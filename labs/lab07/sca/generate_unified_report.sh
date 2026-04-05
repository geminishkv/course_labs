#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OUT_DIR="${ROOT_DIR}/sca/unified-reports"
mkdir -p "${OUT_DIR}"

echo "Generating unified security reports..."

# Объединение JSON отчетов
if [ -f "${ROOT_DIR}/sast/semgrep-report.json" ] && [ -f "${ROOT_DIR}/sast/checkov-report.json" ]; then
    python3 << 'PYTHON_EOF'
import json
import csv
import os
from datetime import datetime

root = os.environ.get('ROOT_DIR', '.')
out_dir = os.environ.get('OUT_DIR', './unified-reports')

# Чтение отчетов
semgrep_data = {}
checkov_data = {}
dependency_check_data = {}

if os.path.exists(f"{root}/sast/semgrep-report.json"):
    with open(f"{root}/sast/semgrep-report.json") as f:
        semgrep_data = json.load(f)

if os.path.exists(f"{root}/sast/checkov-report.json"):
    with open(f"{root}/sast/checkov-report.json") as f:
        checkov_data = json.load(f)

if os.path.exists(f"{root}/sca/dependency-check-report/dependency-check-report.json"):
    with open(f"{root}/sca/dependency-check-report/dependency-check-report.json") as f:
        dependency_check_data = json.load(f)

# Объединенный отчет
unified = {
    "timestamp": datetime.now().isoformat(),
    "semgrep": {
        "findings_count": len(semgrep_data.get("results", [])),
        "results": semgrep_data.get("results", [])
    },
    "checkov": {
        "passed": checkov_data.get("summary", {}).get("passed", 0),
        "failed": checkov_data.get("summary", {}).get("failed", 0),
        "failed_checks": checkov_data.get("results", {}).get("failed_checks", [])
    },
    "dependency_check": {
        "dependencies_count": len(dependency_check_data.get("dependencies", [])),
        "dependencies": dependency_check_data.get("dependencies", [])
    }
}

# Сохранение JSON
with open(f"{out_dir}/unified-report.json", "w") as f:
    json.dump(unified, f, indent=2)

print(f"✓ Unified JSON report: {out_dir}/unified-report.json")

# CSV отчет
with open(f"{out_dir}/unified-report.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(["Tool", "Type", "Severity", "File", "Line", "Description"])
    
    # Semgrep findings
    for r in semgrep_data.get("results", []):
        writer.writerow([
            "Semgrep",
            r.get("check_id", ""),
            r.get("extra", {}).get("severity", ""),
            r.get("path", ""),
            r.get("start", {}).get("line", ""),
            r.get("extra", {}).get("message", "")
        ])
    
    # Checkov findings
    for c in checkov_data.get("results", {}).get("failed_checks", []):
        writer.writerow([
            "Checkov",
            c.get("check_id", ""),
            c.get("severity", ""),
            c.get("file_path", ""),
            str(c.get("file_line_range", [0, 0])[0]) if c.get("file_line_range") else "",
            c.get("check_name", "")
        ])
    
    # Dependency-Check findings
    for dep in dependency_check_data.get("dependencies", []):
        for vuln in dep.get("vulnerabilities", []):
            writer.writerow([
                "Dependency-Check",
                vuln.get("name", ""),
                vuln.get("severity", ""),
                dep.get("filePath", ""),
                "",
                vuln.get("description", "")[:100]
            ])

print(f"✓ Unified CSV report: {out_dir}/unified-report.csv")

# HTML отчет (простой)
html_content = f"""<!DOCTYPE html>
<html>
<head>
    <title>Unified Security Report</title>
    <style>
        body {{ font-family: Arial, sans-serif; margin: 20px; }}
        h1 {{ color: #333; }}
        .summary {{ background: #f5f5f5; padding: 15px; margin: 20px 0; }}
        .finding {{ border-left: 4px solid #ff6b6b; padding: 10px; margin: 10px 0; background: #fff; }}
        .critical {{ border-color: #d32f2f; }}
        .high {{ border-color: #f57c00; }}
        .medium {{ border-color: #fbc02d; }}
        .low {{ border-color: #388e3c; }}
    </style>
</head>
<body>
    <h1>Unified Security Report</h1>
    <div class="summary">
        <h2>Summary</h2>
        <p><strong>Semgrep Findings:</strong> {unified["semgrep"]["findings_count"]}</p>
        <p><strong>Checkov Failed:</strong> {unified["checkov"]["failed"]}</p>
        <p><strong>Dependency-Check Dependencies:</strong> {unified["dependency_check"]["dependencies_count"]}</p>
    </div>
    <h2>Findings</h2>
"""

for r in semgrep_data.get("results", []):
    severity = r.get("extra", {}).get("severity", "UNKNOWN").lower()
    html_content += f"""
    <div class="finding {severity}">
        <strong>[Semgrep]</strong> {r.get("check_id", "")} - {r.get("extra", {}).get("message", "")}<br>
        <small>{r.get("path", "")}:{r.get("start", {}).get("line", "")}</small>
    </div>
    """

for c in checkov_data.get("results", {}).get("failed_checks", []):
    html_content += f"""
    <div class="finding">
        <strong>[Checkov]</strong> {c.get("check_id", "")} - {c.get("check_name", "")}<br>
        <small>{c.get("file_path", "")}</small>
    </div>
    """

html_content += """
</body>
</html>
"""

with open(f"{out_dir}/unified-report.html", "w") as f:
    f.write(html_content)

print(f"✓ Unified HTML report: {out_dir}/unified-report.html")
PYTHON_EOF
fi

echo "[+] Unified reports generated in: ${OUT_DIR}"
