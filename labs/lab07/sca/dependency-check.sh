#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT_DIR="${ROOT_DIR}/sca/dependency-check-report"
PROJECT_NAME="lab07-vulnerable-app"
DATA_DIR="${HOME}/.dependency-check-data"

mkdir -p "${OUT_DIR}"
mkdir -p "${DATA_DIR}"

echo "OWASP Dependency-Check SCA"

if command -v dependency-check >/dev/null 2>&1; then
  DC_CMD="dependency-check"
else
  echo "ERROR: global 'dependency-check' CLI not found."
  exit 1
fi

if [ "${1:-}" = "--update" ]; then
  echo "[*] Updating NVD database in ${DATA_DIR}..."
  "${DC_CMD}" \
    --updateonly \
    --data "${DATA_DIR}"
  echo "[+] NVD data updated"
  exit 0
fi

echo "[*] Running scan using cached data in ${DATA_DIR} (no full re-download)"
echo "[*] Scanning:"
echo "    - ${ROOT_DIR}/vulnerable-app"
echo "    - ${ROOT_DIR}/sca/lib"

"${DC_CMD}" \
  --scan "${ROOT_DIR}/vulnerable-app" "${ROOT_DIR}/sca/lib" \
  --format HTML \
  --format JSON \
  --project "${PROJECT_NAME}" \
  --out "${OUT_DIR}" \
  --data "${DATA_DIR}" \
  --noupdate

if command -v jq >/dev/null 2>&1 && [ -f "${OUT_DIR}/dependency-check-report.json" ]; then
  echo "[i] Dependency-Check JSON dependencies count:"
  jq '.dependencies | length' "${OUT_DIR}/dependency-check-report.json"
fi

echo "[+] Reports saved to: ${OUT_DIR}"
echo "[i] To refresh NVD data occasionally, run: bash sca/dependency-check.sh --update"