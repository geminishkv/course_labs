#!/usr/bin/env bash
# Конвейер образа лабораторной docker02: сборка, SBOM, гейт.
# Одна и та же последовательность выполняется на машине разработчика и в CI:
# workflow только вызывает этот скрипт.
#
#   IMAGE=localhost:5005/docker02/app:1.0.0 API_TOKEN=... ./ci/build.sh
#
# Подписи здесь нет намеренно: ключ подписи не должен попадать в проверочный конвейер.

set -euo pipefail

IMAGE="${IMAGE:?укажите IMAGE, например localhost:5005/docker02/app:1.0.0}"
CONTEXT="${CONTEXT:-source/app}"
SBOM="${SBOM:-sbom.cdx.json}"

if [[ -z "${API_TOKEN:-}" ]]; then
  echo "нет API_TOKEN: сборке нужен секрет, без него она обязана упасть" >&2
  exit 2
fi

step() { printf '\n── %s\n' "$1"; }

step "1. сборка: секрет передаётся через BuildKit и в образ не попадает"
docker buildx build --secret id=api_token,env=API_TOKEN -t "${IMAGE}" --load "${CONTEXT}"

step "2. SBOM"
trivy image --quiet --format cyclonedx -o "${SBOM}" "${IMAGE}"
components="$(jq '.components | length' "${SBOM}")"
echo "компонентов в SBOM: ${components}"
# пустой SBOM значит, что сканер не дошёл до образа: это падение, а не успех
[[ "${components}" -gt 0 ]]

step "3. гейт без проверки подписи"
GATE_CHECKS=base,user,history,files,vulns DOCKERFILE="${CONTEXT}/Dockerfile" ./gate.sh "${IMAGE}"
