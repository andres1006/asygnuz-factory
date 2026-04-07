#!/usr/bin/env bash
# Delega en template/scripts/session-hint.sh. Si pasás un path bajo projects/, usa ese repo como CWD.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PROD_SUBPATH="${1:-}"

if [[ -n "$PROD_SUBPATH" ]]; then
  TARGET="$ROOT/$PROD_SUBPATH"
  if [[ ! -d "$TARGET" ]]; then
    echo "❌ No existe: $TARGET"
    exit 1
  fi
  exec bash "$ROOT/template/scripts/session-hint.sh" "$TARGET"
fi

if [[ -f "$ROOT/tasks/current-gate.txt" ]]; then
  exec bash "$ROOT/template/scripts/session-hint.sh" "$ROOT"
fi

echo "Uso:"
echo "  Desde un repo de producto:  ./scripts/session-hint.sh"
echo "  Desde el wrapper:           ./scripts/session-hint.sh projects/<nombre>"
exit 1
