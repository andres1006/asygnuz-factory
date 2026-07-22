#!/usr/bin/env bash
# Verifica consistencia estructural de la documentación de factory/.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

FAIL=0

ok() { echo "✅ $1"; }
fail() {
  echo "❌ $1"
  FAIL=1
}

need_file() {
  local path="$1"
  local label="${2:-$1}"
  if [[ -f "$path" && -s "$path" ]]; then
    ok "$label"
  else
    fail "$label (falta o vacío: $path)"
  fi
}

echo "==> Verificando índice maestro de factory/"
while IFS= read -r path; do
  [[ -z "$path" ]] && continue
  need_file "factory/$path" "INDEX.md referencia $path"
done < <(
  sed -n 's/^- \([^`(][^ ]*\.md\).*/\1/p; s/^- `\([^`]*\.md\)`.*/\1/p' factory/INDEX.md \
    | sed 's#^factory/##' \
    | sort -u
)

echo "==> Verificando perfiles, prompts y playbooks por rol"
roles=(
  marketing
  product
  design
  architecture
  db
  backend
  frontend
  qa
  uat
  devops
  security
)

for role in "${roles[@]}"; do
  need_file "factory/agents/profiles/$role.md" "perfil $role"
  need_file "factory/agents/prompts/$role.md" "prompt $role"

  if [[ "$role" == "db" ]]; then
    # DB está cubierto por architecture-playbook + db profile/prompt.
    continue
  fi

  need_file "factory/playbooks/$role-playbook.md" "playbook $role"
done

need_file "factory/agents/profiles/orchestrator.md" "perfil orchestrator"
need_file "factory/agents/prompts/orchestrator.md" "prompt orchestrator"
need_file "factory/governance/quality-gates.yaml" "contrato estructurado de gates"
need_file "factory/intelligence/README.md" "índice de inteligencia derivada"
need_file "factory/intelligence/codegraph/README.md" "README de codegraph"
need_file "factory/intelligence/codegraph/graph-schema.md" "schema de codegraph"
need_file "factory/intelligence/codegraph/queries.md" "consultas de codegraph"
need_file "factory/obsidian/README.md" "README de Obsidian"
need_file "factory/obsidian/maps/MOC-factory.md" "MOC factory"
need_file "factory/obsidian/maps/MOC-agents.md" "MOC agents"
need_file "factory/obsidian/maps/MOC-quality-gates.md" "MOC quality gates"
need_file "factory/obsidian/maps/MOC-template-evolution.md" "MOC template evolution"
need_file "scripts/generate-codegraph-report.sh" "generador de codegraph"
need_file "factory/areas/README.md" "README de áreas"
need_file "factory/areas/area-schema.md" "schema de áreas"
need_file "factory/agency/README.md" "README de agency"
need_file "factory/agency/autonomous-marketing/README.md" "README agencia autónoma marketing"
need_file "factory/agency/autonomous-marketing/client-composition-template.yaml" "plantilla composición cliente agencia"
need_file "factory/agency/autonomous-marketing/openhands.md" "guía OpenHands agencia"
need_file "factory/agency/autonomous-marketing/workflows.md" "workflows agencia OpenHands"

echo "==> Verificando áreas componibles"
areas=(
  marketing
  product
  design
  architecture
  data
  development
  qa
  uat
  devops
  security
)

for area in "${areas[@]}"; do
  need_file "factory/areas/$area/README.md" "README área $area"
  need_file "factory/areas/$area/area.yaml" "contrato área $area"
  if grep -q "^id: $area$" "factory/areas/$area/area.yaml"; then
    ok "id área $area"
  else
    fail "id de factory/areas/$area/area.yaml no coincide con carpeta"
  fi
done

echo "==> Verificando basura local conocida"
if find factory -name '.DS_Store' -print -quit | grep -q .; then
  find factory -name '.DS_Store' -print | sed 's/^/❌ archivo local no versionable: /'
  FAIL=1
else
  ok "sin .DS_Store bajo factory/"
fi

echo "==> Verificando cobertura básica de gates estructurados"
for gate in 1 2 3 4 5 6 7; do
  if grep -q "^  $gate:" factory/governance/quality-gates.yaml; then
    ok "gate $gate definido en YAML"
  else
    fail "gate $gate no definido en YAML"
  fi
done

if [[ "$FAIL" -ne 0 ]]; then
  echo "==> check-factory-docs: falló"
  exit 1
fi

echo "==> check-factory-docs: OK"
