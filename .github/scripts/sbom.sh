#!/usr/bin/env bash
# CycloneDX SBOM of the locked runtime set (uv.lock) for a release.
# Usage: .github/scripts/sbom.sh <output.cdx.json>   — same command in CI and locally.
set -euo pipefail

out="${1:?output file}"
export_file="$(mktemp)"
trap 'rm -f "$export_file"' EXIT

# pinned versions with sha256 hashes, without the project itself
uv export --frozen --quiet --no-dev --no-emit-project -o "$export_file"

uv run --frozen --isolated --only-group sbom \
  cyclonedx-py requirements "$export_file" --of JSON -o "$out"

# Coverage proof: an SBOM with a handful of components means the export or the
# generator silently failed, not that the site has no dependencies.
components="$(python3 -c 'import json,sys; print(len(json.load(open(sys.argv[1])).get("components", [])))' "$out")"
if [ "$components" -lt 40 ]; then
  echo "sbom: only $components components in $out, expected the full runtime set" >&2
  exit 1
fi
echo "sbom: $components components written to $out"
