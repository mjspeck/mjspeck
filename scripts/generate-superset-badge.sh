#!/bin/sh
# Usage: generate-superset-badge.sh [icon.png] [out.svg]
set -eu

ROOT=$(git rev-parse --show-toplevel)
ICON=${1:-"$ROOT/assets/superset-icon.png"}
OUT=${2:-"$ROOT/assets/superset-badge.svg"}

LOGO=$(python3 -c 'import base64, sys, urllib.parse
data = base64.b64encode(open(sys.argv[1], "rb").read()).decode()
print(urllib.parse.quote("data:image/png;base64," + data, safe=""))' "$ICON")

TMP=$(mktemp)
trap 'rm -f "$TMP"' EXIT
curl -sSf -o "$TMP" "https://img.shields.io/badge/Superset-matt--speck-black?labelColor=black&logo=$LOGO"
mv "$TMP" "$OUT"
