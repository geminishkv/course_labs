#!/usr/bin/env bash
# Audit exactly the locked runtime packages (uv.lock) with pip-audit.
# Runs the same way in CI and on a developer machine: .github/scripts/pip-audit.sh
set -euo pipefail

export_file="$(mktemp)"
trap 'rm -f "$export_file"' EXIT

uv export --frozen --no-dev --no-hashes --no-emit-project -o "$export_file"

# Coverage proof: an empty or truncated export would make pip-audit report a clean run.
pinned="$(grep -c '==' "$export_file")"
if [ "$pinned" -lt 20 ]; then
  echo "pip-audit: only $pinned pinned packages exported, expected the full runtime set" >&2
  exit 1
fi
echo "pip-audit: auditing $pinned pinned packages from uv.lock"

uv run --frozen --only-group audit pip-audit -r "$export_file" --no-deps --strict
