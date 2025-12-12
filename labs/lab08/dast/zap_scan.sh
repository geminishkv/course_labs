#!/usr/bin/env bash
# shellcheck disable=all

set -euo pipefail

TARGET_URL="${TARGET_URL:-http://host.docker.internal:8080}"
ZAP_IMAGE="${ZAP_IMAGE:-ghcr.io/zaproxy/zaproxy:stable}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPORT_DIR="${SCRIPT_DIR}/reports"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

PYTHON_BIN="${SCRIPT_DIR}/../venv/bin/python"

mkdir -p "${REPORT_DIR}"

echo "[*] Running OWASP ZAP baseline scan against ${TARGET_URL}"
echo "[i] Using image: ${ZAP_IMAGE}"
echo "[i] Reports will be saved to ${REPORT_DIR}"

docker run --rm \
  -v "${REPORT_DIR}:/zap/wrk" \
  "${ZAP_IMAGE}" \
  zap-baseline.py \
    -t "${TARGET_URL}" \
    -r "zap-report-${TIMESTAMP}.html" \
    -J "zap-report-${TIMESTAMP}.json" \
    -x "zap-report-${TIMESTAMP}.xml" \
    -I || true

echo "[+] ZAP scan completed. Reports (if any) in ${REPORT_DIR}"
ls -lh "${REPORT_DIR}"/zap-report-*.* 2>/dev/null || echo "[!] No report files found"

JSON_REPORT="${REPORT_DIR}/zap-report-${TIMESTAMP}.json"

if [ -f "${JSON_REPORT}" ]; then
    echo "[*] Converting JSON report to ODT/XLSX using ${PYTHON_BIN} ..."
    cd "${REPORT_DIR}" || exit 1
    "${PYTHON_BIN}" ../convert_reports.py "${TIMESTAMP}"
else
    echo "[!] JSON report not found: ${JSON_REPORT}"
fi