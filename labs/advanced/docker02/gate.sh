#!/usr/bin/env bash
# Гейт допуска образа лабораторной docker02.
#
# Отвечает на вопрос «можно ли этот образ запускать»: проверяет подпись, закрепление
# базового образа, пользователя, следы секретов в истории слоёв, опасные файлы внутри
# образа и критические уязвимости. Отклонения становятся находками. Находка закрывается
# исправлением сборки или исключением с причиной в файле gate.ignore.
#
#   ./gate.sh localhost:5005/docker02/app:1.0.0
#
# Переменные окружения:
#   DOCKERFILE   путь к Dockerfile, по которому собран образ   (source/app/Dockerfile)
#   COSIGN_PUB   публичный ключ для проверки подписи            (cosign.pub)
#   GATE_IGNORE  файл исключений                                (gate.ignore рядом со скриптом)
#   COSIGN       команда cosign                                 (cosign)
#   GATE_CHECKS  какие проверки выполнять, через запятую        (все)
#                signature,base,user,history,files,vulns
#
# Код возврата: 0 — образ допущен, 1 — есть открытые находки или лишние исключения,
#               2 — ошибка запуска или исключение оформлено неверно.

# shellcheck disable=SC2016  # знак $ внутри шаблонов Go для docker, а не переменные shell
set -euo pipefail

IMAGE="${1:-}"
if [[ -z "${IMAGE}" ]]; then
  echo "usage: $0 <image-ref>" >&2
  exit 2
fi

HERE="$(cd "$(dirname "$0")" && pwd)"
DOCKERFILE="${DOCKERFILE:-${HERE}/source/app/Dockerfile}"
COSIGN_PUB="${COSIGN_PUB:-${HERE}/cosign.pub}"
IGNORE_FILE="${GATE_IGNORE:-${HERE}/gate.ignore}"
COSIGN="${COSIGN:-cosign}"
GATE_CHECKS="${GATE_CHECKS:-signature,base,user,history,files,vulns}"
MIN_REASON=15

enabled() { # enabled <check>
  [[ ",${GATE_CHECKS}," == *",$1,"* ]]
}

skipped() { # skipped <title> <check> — пропуск всегда виден в выводе: зелёный гейт не должен значить «не проверяли»
  echo "== $1"
  echo "   ПРОПУЩЕНО: проверка «$2» отключена параметром GATE_CHECKS"
  echo
  SKIPPED=$((SKIPPED + 1))
}
SKIPPED=0

if ! docker image inspect "${IMAGE}" >/dev/null 2>&1; then
  echo "образ ${IMAGE} не найден локально: выполните docker pull ${IMAGE}" >&2
  exit 2
fi

# ─── исключения: проверка | значение | причина ──────────────────────────────────
EXCEPTIONS=""
if [[ -f "${IGNORE_FILE}" ]]; then
  EXCEPTIONS="$(awk -F'|' -v min="${MIN_REASON}" '
    /^[[:space:]]*(#|$)/ { next }
    {
      for (i = 1; i <= NF; i++) gsub(/^[[:space:]]+|[[:space:]]+$/, "", $i)
      if (NF != 3 || $1 == "" || $2 == "" || length($3) < min) { printf "BAD|%d\n", NR; next }
      printf "%s|%s|%s\n", $1, $2, $3
    }' "${IGNORE_FILE}")"
  if grep -q '^BAD|' <<<"${EXCEPTIONS}"; then
    bad_lines="$(grep '^BAD|' <<<"${EXCEPTIONS}" | cut -d'|' -f2 | tr '\n' ' ')"
    echo "gate.ignore: строки ${bad_lines}оформлены неверно." >&2
    echo "Формат: проверка | значение | причина. Причина не короче ${MIN_REASON} символов." >&2
    exit 2
  fi
fi

FINDINGS=""
add_finding() { # add_finding <check> <value> <message>
  FINDINGS+="$1|$2|$3"$'\n'
}

echo "образ:       ${IMAGE}"
echo "digest:      $(docker image inspect -f '{{if .RepoDigests}}{{index .RepoDigests 0}}{{else}}нет, образ не отправлен в registry{{end}}' "${IMAGE}")"
echo "Dockerfile:  ${DOCKERFILE}"
echo

# 1. подпись
if enabled signature; then
  echo "== подпись"
  if [[ ! -f "${COSIGN_PUB}" ]]; then
    echo "   публичный ключ ${COSIGN_PUB} не найден"
    add_finding "signature" "no-key" "нет публичного ключа: подпись проверить нечем"
  elif ! command -v "${COSIGN%% *}" >/dev/null 2>&1; then
    echo "   cosign не установлен"
    add_finding "signature" "no-cosign" "cosign не установлен: подпись не проверена"
  elif ${COSIGN} verify --key "${COSIGN_PUB}" --insecure-ignore-tlog=true --allow-insecure-registry "${IMAGE}" >/dev/null 2>&1; then
    echo "   подпись верна для ключа $(basename "${COSIGN_PUB}")"
  else
    echo "   подписи нет или она сделана другим ключом"
    add_finding "signature" "unverified" "образ не подписан ключом проекта"
  fi
  echo
else
  skipped "подпись" "signature"
fi

# 2. базовый образ закреплён по digest
if enabled base; then
  echo "== базовый образ"
  if [[ -f "${DOCKERFILE}" ]]; then
    while read -r base; do
      [[ -z "${base}" || "${base}" == "scratch" ]] && continue
      if [[ "${base}" == *@sha256:* ]]; then
        echo "   ${base%%@*} закреплён по digest"
      else
        echo "   ${base} не закреплён"
        add_finding "base-unpinned" "${base}" "тег можно перезаписать: базовый образ не закреплён по digest"
      fi
    done < <(awk 'toupper($1) == "FROM" { for (i = 2; i <= NF; i++) if ($i !~ /^--/) { print $i; break } }' "${DOCKERFILE}")
  else
    echo "   ${DOCKERFILE} не найден"
    add_finding "base-unpinned" "no-dockerfile" "нет Dockerfile: закрепление базового образа проверить нельзя"
  fi
  echo
else
  skipped "базовый образ" "base"
fi

# 3. пользователь
if enabled user; then
  echo "== пользователь"
  user="$(docker image inspect -f '{{.Config.User}}' "${IMAGE}")"
  echo "   USER: ${user:-не задан}"
  case "${user%%:*}" in
    "" | 0 | root) add_finding "user-root" "${user:-empty}" "процесс в контейнере стартует от root" ;;
  esac
  echo
else
  skipped "пользователь" "user"
fi

# 4. следы секретов в истории слоёв: поиск по словам, как у настоящих сканеров
if enabled history; then
  echo "== история слоёв"
  history="$(docker history --no-trunc --format '{{.CreatedBy}}' "${IMAGE}")"
  hits="$(
    {
      # имена переменных в ENV и ARG
      grep -oE '(ENV|ARG) [A-Za-z_][A-Za-z0-9_]*' <<<"${history}" | awk '{ print $2 }' \
        | grep -iE 'PASSWORD|SECRET|TOKEN|KEY' || true
      # слова в командах RUN: смотрим только на имя слева от знака «=», значение не читаем
      # и не печатаем; всё, что не имя переменной и не путь, выводится скрытым
      grep -E '^(RUN|\|[0-9]+ )' <<<"${history}" | tr -s '[:space:]' '\n' | awk '
        { left = $0; sub(/=.*/, "", left) }
        tolower(left) ~ /password|secret|token/ {
          if (left ~ /^[A-Z][A-Z0-9_]*$/ || left ~ /^\//) print left
          else print "скрытое-слово"
        }' || true
    } | sort -u
  )"
  echo "   похоже на секрет: $(tr '\n' ' ' <<<"${hits}")"
  for hit in ${hits}; do
    add_finding "history-secret" "${hit}" "в истории слоёв есть слово, похожее на секрет"
  done
  echo
else
  skipped "история слоёв" "history"
fi

# 5. опасные файлы внутри образа
if enabled files; then
  echo "== файлы в образе"
  files="$(docker run --rm --network none --entrypoint sh "${IMAGE}" -c \
    'find /app /usr/local/lib/python3*/site-packages \( -name ".env*" -o -name "*.pem" -o -name "*.key" -o -name "id_rsa*" -o -name ".git" \) 2>/dev/null' \
    2>/dev/null | sort || true)"
  echo "   найдено: $(tr '\n' ' ' <<<"${files}")"
  for file in ${files}; do
    add_finding "leak-file" "${file}" "файл такого вида часто содержит секреты"
  done
  echo
else
  skipped "файлы в образе" "files"
fi

# 6. критические уязвимости
if enabled vulns; then
  echo "== уязвимости"
  if command -v trivy >/dev/null 2>&1; then
    report="$(trivy image --quiet --scanners vuln --severity CRITICAL --format json "${IMAGE}" 2>/dev/null || true)"
    # «ноль находок» и «сканер не дошёл до образа» выглядят одинаково: проверяем, что результаты есть
    scanned="$(jq -r '[.Results[]?] | length' <<<"${report}" 2>/dev/null || echo 0)"
    echo "   просканировано целей: ${scanned}"
    if [[ "${scanned}" == "0" ]]; then
      add_finding "vuln-critical" "no-results" "trivy не вернул ни одной цели: сканирование не состоялось"
    fi
    vulns="$(jq -r '[.Results[]?.Vulnerabilities[]? | "\(.VulnerabilityID):\(.PkgName)"] | unique | .[]' <<<"${report}" 2>/dev/null || true)"
    echo "   CRITICAL: $(grep -c . <<<"${vulns}" || true)"
    for vuln in ${vulns}; do
      add_finding "vuln-critical" "${vuln}" "критическая уязвимость в составе образа"
    done
  else
    echo "   trivy не установлен"
    add_finding "vuln-critical" "no-trivy" "trivy не установлен: уязвимости не проверены"
  fi
  echo
else
  skipped "уязвимости" "vulns"
fi

# ─── находки ────────────────────────────────────────────────────────────────────
open=0
excepted=0
used=""

echo "== находки"
while IFS='|' read -r chk val msg; do
  [[ -z "${chk}" ]] && continue
  reason="$(awk -F'|' -v c="${chk}" -v v="${val}" '$1 == c && $2 == v { print $3; exit }' <<<"${EXCEPTIONS}")"
  if [[ -n "${reason}" ]]; then
    excepted=$((excepted + 1))
    used+="${chk}|${val}"$'\n'
    printf '   [исключена] %-15s %-42s причина: %s\n' "${chk}" "${val}" "${reason}"
  else
    open=$((open + 1))
    printf '   [открыта]   %-15s %-42s %s\n' "${chk}" "${val}" "${msg}"
  fi
done <<<"${FINDINGS}"

# исключение, которое ничего не закрыло, молча переживёт своё основание
stale=0
while IFS='|' read -r chk val _; do
  [[ -z "${chk}" ]] && continue
  if ! grep -qxF "${chk}|${val}" <<<"${used}"; then
    stale=$((stale + 1))
    printf '   [лишнее]    %-15s %-42s исключение ничего не закрыло, удалите его\n' "${chk}" "${val}"
  fi
done <<<"${EXCEPTIONS}"

echo
echo "итог: открыто ${open}, исключено ${excepted}, лишних исключений ${stale}, пропущено проверок ${SKIPPED}"

if [[ "${open}" -gt 0 || "${stale}" -gt 0 ]]; then
  echo "решение: образ НЕ допущен"
  exit 1
fi
echo "решение: образ допущен"
