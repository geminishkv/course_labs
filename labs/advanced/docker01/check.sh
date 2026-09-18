#!/usr/bin/env bash
# Проверка рантайма стенда docker01.
#
# По каждому сервису compose-файла снимает факты (от кого работает процесс, какие у него
# привилегии, куда он может писать, что опубликовано наружу) и превращает отклонения
# в находки. Находка закрывается одним из двух способов: исправлением в compose-файле
# или исключением с причиной в файле check.ignore.
#
# Значения секретов не печатаются никогда, только имена переменных.
#
#   ./check.sh compose.insecure.yml > before.txt
#   ./check.sh compose.hardened.yml > after.txt
#   diff before.txt after.txt
#
# Код возврата: 0 — открытых находок нет, 1 — есть открытые находки,
#               2 — ошибка запуска или исключение оформлено неверно.

# shellcheck disable=SC2016  # знак $ внутри шаблонов Go для docker inspect, а не переменные shell
set -euo pipefail

FILE="${1:-}"
if [[ -z "${FILE}" || ! -f "${FILE}" ]]; then
  echo "usage: $0 <compose-file>" >&2
  exit 2
fi

# для чужого compose-файла свой список исключений: CHECK_IGNORE=путь ./check.sh файл
IGNORE_FILE="${CHECK_IGNORE:-$(dirname "$0")/check.ignore}"
MIN_REASON=15

# ─── исключения: сервис | проверка | значение | причина ─────────────────────────
EXCEPTIONS=""
if [[ -f "${IGNORE_FILE}" ]]; then
  EXCEPTIONS="$(awk -F'|' -v min="${MIN_REASON}" '
    /^[[:space:]]*(#|$)/ { next }
    {
      for (i = 1; i <= NF; i++) gsub(/^[[:space:]]+|[[:space:]]+$/, "", $i)
      if (NF != 4 || $1 == "" || $2 == "" || $3 == "" || length($4) < min) { printf "BAD|%d\n", NR; next }
      printf "%s|%s|%s|%s\n", $1, $2, $3, $4
    }' "${IGNORE_FILE}")"
  if grep -q '^BAD|' <<<"${EXCEPTIONS}"; then
    bad_lines="$(grep '^BAD|' <<<"${EXCEPTIONS}" | cut -d'|' -f2 | tr '\n' ' ')"
    echo "check.ignore: строки ${bad_lines}оформлены неверно." >&2
    echo "Формат: сервис | проверка | значение | причина. Причина не короче ${MIN_REASON} символов." >&2
    exit 2
  fi
fi

FINDINGS=""
add_finding() { # add_finding <service> <check> <value> <message>
  FINDINGS+="$1|$2|$3|$4"$'\n'
}

caps_label() {
  case "$1" in
    0000000000000000) echo "нет ни одной" ;;
    00000000a80425fb) echo "набор Docker по умолчанию, 14 capabilities" ;;
    000001ffffffffff | 000003ffffffffff) echo "все, контейнер привилегированный" ;;
    *) echo "свой набор, расшифровка: capsh --decode=$1" ;;
  esac
}

limit_label() {
  case "$1" in
    "" | 0 | -1 | "<nil>") echo "не задан" ;;
    *) echo "$1" ;;
  esac
}

proc_field() { # proc_field <container> <field>
  docker exec "$1" cat /proc/1/status 2>/dev/null | awk -v f="$2:" '$1 == f { print $2 }'
}

inspect() { # inspect <container> <go-template>
  docker inspect -f "$2" "$1"
}

echo "compose-файл: ${FILE}"
echo

for svc in $(docker compose -f "${FILE}" config --services | sort); do
  cid="$(docker compose -f "${FILE}" ps -q "${svc}" 2>/dev/null || true)"
  echo "== ${svc}"
  if [[ -z "${cid}" ]]; then
    echo "   контейнер не запущен"
    echo
    add_finding "${svc}" "not-running" "-" "контейнер не запущен, факты снять нельзя"
    continue
  fi

  uid="$(proc_field "${cid}" Uid)"
  # CapBnd — верхняя граница привилегий контейнера: её не видно по процессу,
  # который сам сбросил права после старта
  cap_bnd="$(proc_field "${cid}" CapBnd)"
  nnp="$(proc_field "${cid}" NoNewPrivs)"
  seccomp="$(proc_field "${cid}" Seccomp)"
  privileged="$(inspect "${cid}" '{{.HostConfig.Privileged}}')"
  readonly_root="$(inspect "${cid}" '{{.HostConfig.ReadonlyRootfs}}')"
  pids="$(limit_label "$(inspect "${cid}" '{{.HostConfig.PidsLimit}}')")"
  memory="$(limit_label "$(inspect "${cid}" '{{.HostConfig.Memory}}')")"
  published="$(inspect "${cid}" '{{range $p, $b := .NetworkSettings.Ports}}{{range $b}}{{.HostIp}}:{{.HostPort}}->{{$p}} {{end}}{{end}}')"

  echo "   uid процесса PID 1:  ${uid:-?}"
  echo "   privileged:          ${privileged}"
  echo "   capabilities:        ${cap_bnd:-?} ($(caps_label "${cap_bnd:-}"))"
  echo "   no-new-privileges:   ${nnp:-?}"
  echo "   seccomp:             ${seccomp:-?}"
  echo "   корень read-only:    ${readonly_root}"
  echo "   tmpfs:               $(inspect "${cid}" '{{range $k, $v := .HostConfig.Tmpfs}}{{$k}} {{end}}')"
  echo "   pids-limit:          ${pids}"
  echo "   memory, байт:        ${memory}"
  echo "   сети:                $(inspect "${cid}" '{{range $k, $v := .NetworkSettings.Networks}}{{$k}} {{end}}')"
  echo "   опубликовано:        ${published:-нет}"

  [[ "${uid}" == "0" ]] && add_finding "${svc}" "user-root" "0" "процесс PID 1 работает от root"
  [[ "${privileged}" == "true" ]] && add_finding "${svc}" "privileged" "true" "контейнер привилегированный"
  [[ -n "${cap_bnd}" && "${cap_bnd}" != "0000000000000000" ]] \
    && add_finding "${svc}" "capabilities" "${cap_bnd}" "capabilities не сброшены: $(caps_label "${cap_bnd}")"
  [[ "${nnp}" == "0" ]] && add_finding "${svc}" "no-new-privileges" "0" "повышение привилегий через setuid не запрещено"
  [[ "${seccomp}" == "0" ]] && add_finding "${svc}" "seccomp" "0" "фильтр системных вызовов выключен"
  [[ "${readonly_root}" == "false" ]] && add_finding "${svc}" "rootfs-rw" "false" "корневая файловая система доступна на запись"
  [[ "${pids}" == "не задан" ]] && add_finding "${svc}" "pids-limit" "-" "число процессов не ограничено"
  [[ "${memory}" == "не задан" ]] && add_finding "${svc}" "memory" "-" "память не ограничена"

  for binding in ${published}; do
    case "${binding}" in
      0.0.0.0:* | :::*) add_finding "${svc}" "published-all" "${binding}" "порт слушает на всех интерфейсах хоста" ;;
    esac
  done

  if inspect "${cid}" '{{range .Mounts}}{{.Source}} {{end}}' | grep -q 'docker.sock'; then
    seen="$(docker exec "${cid}" python -c '
import http.client, json, socket
class C(http.client.HTTPConnection):
    def connect(self):
        self.sock = socket.socket(socket.AF_UNIX); self.sock.connect("/var/run/docker.sock")
c = C("docker"); c.request("GET", "/containers/json?all=1")
print(len(json.loads(c.getresponse().read())))' 2>/dev/null || echo '?')"
    echo "   docker.sock:         смонтирован, контейнеру видно контейнеров хоста: ${seen}"
    add_finding "${svc}" "docker-sock" "mounted" "в контейнер проброшен сокет Docker: это управление всем хостом"
  else
    echo "   docker.sock:         не смонтирован"
  fi

  # поиск по имени переменной: так работают и настоящие сканеры секретов
  names="$(inspect "${cid}" '{{range .Config.Env}}{{println .}}{{end}}' \
    | awk -F= 'toupper($1) ~ /PASSWORD|SECRET|TOKEN|KEY/ { print $1 }' | sort -u)"
  echo "   похоже на секрет:    $(tr '\n' ' ' <<<"${names}")"
  for name in ${names}; do
    add_finding "${svc}" "env-secret" "${name}" "переменная окружения похожа на секрет"
  done
  echo
done

# ─── находки ────────────────────────────────────────────────────────────────────
open=0
excepted=0
used=""

echo "== находки"
while IFS='|' read -r svc chk val msg; do
  [[ -z "${svc}" ]] && continue
  reason="$(awk -F'|' -v s="${svc}" -v c="${chk}" -v v="${val}" \
    '$1 == s && $2 == c && $3 == v { print $4; exit }' <<<"${EXCEPTIONS}")"
  if [[ -n "${reason}" ]]; then
    excepted=$((excepted + 1))
    used+="${svc}|${chk}|${val}"$'\n'
    printf '   [исключена] %-4s %-18s %-22s причина: %s\n' "${svc}" "${chk}" "${val}" "${reason}"
  else
    open=$((open + 1))
    printf '   [открыта]   %-4s %-18s %-22s %s\n' "${svc}" "${chk}" "${val}" "${msg}"
  fi
done <<<"${FINDINGS}"

# исключение, которое ничего не закрыло, хуже лишней находки: оно молча переживёт своё основание
stale=0
while IFS='|' read -r svc chk val _; do
  [[ -z "${svc}" ]] && continue
  if ! grep -qxF "${svc}|${chk}|${val}" <<<"${used}"; then
    stale=$((stale + 1))
    printf '   [лишнее]    %-4s %-18s %-22s исключение ничего не закрыло, удалите его\n' "${svc}" "${chk}" "${val}"
  fi
done <<<"${EXCEPTIONS}"

echo
echo "итог: открыто ${open}, исключено ${excepted}, лишних исключений ${stale}"

if [[ "${open}" -gt 0 || "${stale}" -gt 0 ]]; then
  exit 1
fi
