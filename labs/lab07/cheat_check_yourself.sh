#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "=== lab07: SAST + SCA for vulnerable-app ==="

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || { echo "ERROR: '$1' not found in PATH"; exit 1; }
}

need_cmd docker
if ! command -v docker-compose >/dev/null 2>&1 && ! command -v docker >/dev/null 2>&1; then
  echo "ERROR: neither 'docker-compose' nor 'docker compose' found"
  exit 1
fi

echo "[*] Tools check: docker OK"

echo
echo "Build & run vulnerable-app (Docker)"
if command -v docker-compose >/dev/null 2>&1; then
  docker-compose -f "${ROOT_DIR}/docker-compose.yml" up -d --build
else
  docker compose -f "${ROOT_DIR}/docker-compose.yml" up -d --build
fi
echo "[+] vulnerable-app is up"

echo
echo "SAST with Semgrep"
if command -v semgrep >/dev/null 2>&1; then
  cd "${ROOT_DIR}"
  echo "[*] Semgrep: custom rules only"
  semgrep --config sast/semgrep-rules.yml \
    --json \
    --output sast/semgrep-report.json \
    vulnerable-app/ || true
  echo "[+] Semgrep report saved to sast/semgrep-report.json"
else
  echo "[-] Semgrep not found, skipping SAST"
fi

echo
echo "SAST with Checkov (Dockerfile / IaC)"
if command -v checkov >/dev/null 2>&1; then
  cd "${ROOT_DIR}"
  rm -rf "${ROOT_DIR}/sast/checkov-report.json"
  checkov \
    --framework dockerfile \
    --file vulnerable-app/Dockerfile docker-compose.yml \
    --output json \
    --output-file-path "${ROOT_DIR}/sast/checkov-report.json" \
    --soft-fail || true
  echo "[+] Checkov report saved under sast/checkov-report.json/results_json.json"
else
  echo "[-] Checkov not found, skipping Docker/IaC SAST (pip install checkov)"
fi

echo
echo "SCA with OWASP Dependency-Check (CLI)"
if [ -x "${ROOT_DIR}/sca/dependency-check.sh" ]; then
  cd "${ROOT_DIR}"
  bash sca/dependency-check.sh
else
  echo "[-] sca/dependency-check.sh not found or not executable."
fi

echo
echo "SCA with Maven Dependency-Check plugin"
if command -v mvn >/dev/null 2>&1; then
  cd "${ROOT_DIR}/sca"
  mvn org.owasp:dependency-check-maven:check || true
  echo "[+] Maven Dependency-Check (if DB ok) writes reports under sca/dependency-check-report or pom.xml outputDirectory"
else
  echo "[-] mvn not found, skipping Maven-based Dependency-Check"
fi

echo
echo "Unified SAST/SCA Report Generation"
if [ -x "${ROOT_DIR}/sca/generate_unified_report.sh" ]; then
  bash "${ROOT_DIR}/sca/generate_unified_report.sh"
else
  echo "[-] generate_unified_report.sh not found or not executable"
fi

echo
echo "lab07 scanning complete - positive"
echo "Review:"
echo "  - Semgrep SAST findings"
echo "  - Checkov Docker/IaC findings"
echo "  - OWASP Dependency-Check SCA findings (CLI + Maven)"
echo "  - Unified reports in reports/ directory (CSV, HTML, JSON)"
echo "  - Open CSV in Excel/LibreOffice and save as XLSX/ODT"
