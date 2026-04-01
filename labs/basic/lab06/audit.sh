#!/usr/bin/env bash
set -euo pipefail

echo "Starting Docker CIS & Image Security Audit"
echo "=========================================="

if ! command -v docker >/dev/null 2>&1; then
  echo "ERROR: docker CLI not found. Install Docker before running this script"
  exit 1
fi

if ! docker info >/dev/null 2>&1; then
  echo "ERROR: Docker daemon is not reachable. Start Docker service/Desktop first"
  exit 1
fi

OS_TYPE="$(uname -s || echo unknown)"
if [[ "$OS_TYPE" == "Linux" && "$(uname -r || true)" == *"Microsoft"* ]] || \
   [[ "${OS:-}" == "Windows_NT" ]]; then
  PLATFORM="Windows"
else
  case "$OS_TYPE" in
    Linux)  PLATFORM="Linux" ;;
    Darwin) PLATFORM="macOS" ;;
    *)      PLATFORM="Unknown" ;;
  esac
fi

DEFAULT_BENCH_IMAGE="docker/docker-bench-security:latest"
BENCH_IMAGE="${DOCKER_BENCH_IMAGE:-$DEFAULT_BENCH_IMAGE}"

REPORTS_DIR="./audit_reports"
REPORTS_JSON="${REPORTS_DIR}/json"
REPORTS_TXT="${REPORTS_DIR}/text"
REPORTS_XLSX="${REPORTS_DIR}/xlsx"
REPORTS_ODT="${REPORTS_DIR}/odt"

mkdir -p "${REPORTS_JSON}" "${REPORTS_TXT}" "${REPORTS_XLSX}" "${REPORTS_ODT}"

echo "Detected platform: ${PLATFORM}"
echo "Using docker-bench-security image: ${BENCH_IMAGE}"
echo "Reports will be saved to: ${REPORTS_DIR}/"
echo ""

if ! docker image inspect "${BENCH_IMAGE}" >/dev/null 2>&1; then
  echo "Bench image ${BENCH_IMAGE} not found locally."
  echo "Pulling it explicitly..."
  docker pull "${BENCH_IMAGE}"
  echo ""
fi

if command -v trivy >/dev/null 2>&1; then
  echo "Running Trivy scan for ${BENCH_IMAGE}..."
  BENCH_REPORT="${REPORTS_JSON}/docker-bench-security-trivy.json"
  trivy image --format json --output "${BENCH_REPORT}" "${BENCH_IMAGE}" || true
  echo "Saved to: ${BENCH_REPORT}"
  echo ""
else
  echo "Trivy not found, skipping image vulnerability scan for ${BENCH_IMAGE}"
  echo ""
fi

# Сканирование тестовых образов nginx, python, postgres
if command -v trivy >/dev/null 2>&1; then
  echo "Scanning lab images for vulnerabilities..."
  for img in nginx:alpine python:3.11-alpine postgres:16-alpine; do
    echo ""
    echo "=== Trivy scan for ${img} ==="
    SAFE_IMG_NAME=$(echo "${img}" | sed 's/:/-/g' | sed 's/\//-/g')
    LAB_REPORT="${REPORTS_JSON}/${SAFE_IMG_NAME}-trivy.json"
    trivy image --format json --output "${LAB_REPORT}" "${img}" || true
    echo "Saved to: ${LAB_REPORT}"
  done
  echo ""
else
  echo "Trivy not found, skipping lab images scan"
  echo ""
fi

run_bench() {
  local mounts="$1"
  local extra_opts="$2"

  echo "Running Docker Bench Security container (CIS host audit)"
  echo ""

  BENCH_OUTPUT="${REPORTS_TXT}/docker-bench-security-cis.txt"
  
  docker run --rm \
    --name "docker-bench-security-$(date +%s)" \
    --cap-add audit_control \
    --security-opt no-new-privileges \
    ${extra_opts} \
    -e DOCKER_CONTENT_TRUST="${DOCKER_CONTENT_TRUST:-0}" \
    -v /var/run/docker.sock:/var/run/docker.sock:ro \
    ${mounts} \
    --label docker_bench_security \
    "${BENCH_IMAGE}" 2>&1 | tee "${BENCH_OUTPUT}"
  
  echo ""
  echo "CIS audit output saved to: ${BENCH_OUTPUT}"
}

case "${PLATFORM}" in
  Linux)
    echo "Linux host detected – configuring mounts for CIS Docker Benchmark coverage"
    echo ""

    MOUNTS="-v /etc:/etc:ro \
            -v /var/lib:/var/lib:ro \
            -v /usr/bin:/usr/bin:ro"

    if [ -f "/usr/bin/containerd" ] && [ ! -d "/usr/bin/containerd" ]; then
      MOUNTS="${MOUNTS} -v /usr/bin/containerd:/usr/bin/containerd:ro"
      echo "Mounting /usr/bin/containerd"
    fi

    if [ -f "/usr/bin/runc" ] && [ ! -d "/usr/bin/runc" ]; then
      MOUNTS="${MOUNTS} -v /usr/bin/runc:/usr/bin/runc:ro"
      echo "Mounting /usr/bin/runc"
    fi

    if [ -d "/usr/lib/systemd" ]; then
      MOUNTS="${MOUNTS} -v /usr/lib/systemd:/usr/lib/systemd:ro"
      echo "Mounting /usr/lib/systemd"
    elif [ -d "/lib/systemd" ]; then
      MOUNTS="${MOUNTS} -v /lib/systemd:/lib/systemd:ro"
      echo "Mounting /lib/systemd"
    fi

    if [ -d "/etc/docker" ]; then
      MOUNTS="${MOUNTS} -v /etc/docker:/etc/docker:ro"
      echo "Mounting /etc/docker"
    fi

    if [ -d "/var/log" ]; then
      MOUNTS="${MOUNTS} -v /var/log:/var/log:ro"
      echo "Mounting /var/log"
    fi

    run_bench "${MOUNTS}" "--network host --pid host --userns host"
    ;;

  macOS)
    echo "macOS detected – Docker Desktop (Apple Silicon) environment"
    echo "Due to Docker Desktop limitations, docker-bench-security may fail to start CIS host audit."
    echo "Use the Trivy image scans above for lab purposes and run full CIS Docker Benchmark on a Linux VM/WSL host."
    echo ""
    ;;

  Windows)
    echo "Windows / WSL environment detected"
    echo ""

    if grep -qi "microsoft" /proc/version 2>/dev/null; then
      echo "Docker appears to be running under WSL (Linux kernel)"
      echo "CIS checks will apply to this WSL Linux environment and Docker Engine inside it"
      echo ""

      MOUNTS="-v /etc:/etc:ro \
              -v /var/lib:/var/lib:ro \
              -v /usr/bin:/usr/bin:ro"

      if [ -f "/usr/bin/containerd" ] && [ ! -d "/usr/bin/containerd" ]; then
        MOUNTS="${MOUNTS} -v /usr/bin/containerd:/usr/bin/containerd:ro"
        echo "Mounting /usr/bin/containerd"
      fi

      if [ -f "/usr/bin/runc" ] && [ ! -d "/usr/bin/runc" ]; then
        MOUNTS="${MOUNTS} -v /usr/bin/runc:/usr/bin/runc:ro"
        echo "Mounting /usr/bin/runc"
      fi

      if [ -d "/etc/docker" ]; then
        MOUNTS="${MOUNTS} -v /etc/docker:/etc/docker:ro"
        echo "Mounting /etc/docker"
      fi

      if [ -d "/var/log" ]; then
        MOUNTS="${MOUNTS} -v /var/log:/var/log:ro"
        echo "Mounting /var/log"
      fi

      run_bench "${MOUNTS}" "--network host --pid host --userns host"
    else
      echo "Docker Desktop on native Windows without WSL Linux context is not fully supported by docker-bench-security."
      echo "For full CIS Docker Benchmark coverage, run this script inside a Linux or WSL2 environment where Docker Engine is available."
      echo ""
    fi
    ;;

  *)
    echo "Unsupported or unknown platform: ${PLATFORM} (${OS_TYPE})"
    echo "This script supports Linux hosts (full CIS), macOS (image scans only), and Windows via WSL2"
    exit 1
    ;;
esac

if command -v python3 >/dev/null 2>&1; then
  echo ""
  echo "Converting Trivy JSON reports to XLSX/ODT formats..."
  python3 << 'PYTHON_EOF'

import json
import os
import sys
from pathlib import Path

try:
    from openpyxl import Workbook
    from odf.opendocument import OpenDocumentText
    from odf.text import P, Span
    from odf.style import Style, TextProperties
except ImportError:
    print("WARNING: openpyxl or odfpy not installed. Skipping XLSX/ODT conversion.")
    print("Install with: pip install openpyxl odfpy")
    sys.exit(0)

REPORTS_JSON = "./audit_reports/json"
REPORTS_XLSX = "./audit_reports/xlsx"
REPORTS_ODT = "./audit_reports/odt"

def trivy_json_to_xlsx(json_path, xlsx_path):
    with open(json_path, 'r') as f:
        data = json.load(f)
    
    wb = Workbook()
    ws = wb.active
    ws.title = "Vulnerabilities"
    
    headers = ["Target", "Type", "Vulnerability ID", "Severity", "Status", "Title", "Description"]
    ws.append(headers)
    
    for result in data.get('Results', []):
        target = result.get('Target', 'N/A')
        for vuln in result.get('Misconfigurations', []) + result.get('Vulnerabilities', []):
            row = [
                target,
                result.get('Type', 'unknown'),
                vuln.get('VulnerabilityID', 'N/A'),
                vuln.get('Severity', 'UNKNOWN'),
                vuln.get('Status', 'N/A'),
                vuln.get('Title', 'N/A')[:50],
                vuln.get('Description', 'N/A')[:100]
            ]
            ws.append(row)
    
    wb.save(xlsx_path)
    print(f"✓ Saved to XLSX: {xlsx_path}")

def trivy_json_to_odt(json_path, odt_path):
    with open(json_path, 'r') as f:
        data = json.load(f)
    
    doc = OpenDocumentText()
    
    p = P(text=f"Docker Audit Report: {os.path.basename(json_path)}")
    doc.text.addElement(p)
    
    for result in data.get('Results', []):
        target = result.get('Target', 'N/A')
        p = P(text=f"\nTarget: {target}")
        doc.text.addElement(p)
        
        vulns = result.get('Vulnerabilities', []) + result.get('Misconfigurations', [])
        for i, vuln in enumerate(vulns, 1):
            p = P(text=f"  [{i}] {vuln.get('VulnerabilityID', 'N/A')} ({vuln.get('Severity', 'UNKNOWN')}): {vuln.get('Title', 'N/A')}")
            doc.text.addElement(p)
    
    doc.save(odt_path)
    print(f"✓ Saved to ODT: {odt_path}")

if os.path.isdir(REPORTS_JSON):
    for json_file in Path(REPORTS_JSON).glob("*.json"):
        base_name = json_file.stem
        xlsx_file = os.path.join(REPORTS_XLSX, f"{base_name}.xlsx")
        odt_file = os.path.join(REPORTS_ODT, f"{base_name}.odt")
        
        try:
            trivy_json_to_xlsx(str(json_file), xlsx_file)
            trivy_json_to_odt(str(json_file), odt_file)
        except Exception as e:
            print(f"ERROR converting {json_file}: {e}")
else:
    print(f"WARNING: {REPORTS_JSON} directory not found")

PYTHON_EOF
fi

echo ""
echo "=========================================="
echo "Audit complete!"
echo "Reports directory structure:"
echo "   ${REPORTS_DIR}/"
echo "   ├── json/          (Trivy JSON outputs)"
echo "   ├── text/          (CIS audit text outputs)"
echo "   ├── xlsx/          (Excel spreadsheets)"
echo "   └── odt/           (OpenDocument Text files)"
echo ""
echo "For CIS Docker Benchmark details, see:"
echo "https://www.cisecurity.org/benchmark/docker"
echo ""