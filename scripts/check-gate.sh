#!/usr/bin/env bash
# Delega en la plantilla canónica (mismo comportamiento en wrapper o en producto).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
exec bash "$ROOT/template/scripts/check-gate.sh" "$@"
