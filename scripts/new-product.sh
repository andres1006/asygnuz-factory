#!/usr/bin/env bash
# Bootstrap de un producto bajo projects/<nombre> desde template/.
# Uso: ./scripts/new-product.sh <nombre-producto>
set -euo pipefail

NAME="${1:?Uso: $0 <nombre-producto>}"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$ROOT/projects/$NAME"

if [[ -e "$DEST" ]]; then
  echo "Error: ya existe $DEST"
  exit 1
fi

echo "==> Copiando template → $DEST"
cp -R "$ROOT/template" "$DEST"

echo "==> Personalizando nombre del producto"
perl -pi -e "s/\\[nombre-producto\\]/${NAME}/g" "$DEST/tasks/gate-status.md"
perl -pi -e "s/\\[nombre-producto\\]/${NAME}/g" "$DEST/.factory/state.json"

echo "1" > "$DEST/tasks/current-gate.txt"

if [[ -d "$ROOT/.agents/skills" ]]; then
  echo "==> Copiando skills instalados (.agents, .claude) desde el wrapper"
  cp -R "$ROOT/.agents" "$DEST/"
  [[ -d "$ROOT/.claude" ]] && cp -R "$ROOT/.claude" "$DEST/" || true
fi

echo "==> git init en el producto"
(
  cd "$DEST"
  git init
  git add .
  git commit -m "chore: init producto ${NAME} desde template"
)

echo ""
echo "✅ Producto listo: $DEST"
echo "   Estado: tasks/gate-status.md | tasks/current-gate.txt"
echo "   Siguiente: abrir $DEST/CLAUDE.md en Claude Code y definir FACTORY_ROOT=$ROOT"
echo "   Verificar gate: cd $DEST && ./scripts/check-gate.sh 1"
