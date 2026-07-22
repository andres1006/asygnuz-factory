#!/usr/bin/env bash
# Genera reportes Markdown derivados para mapear factory/ y template/.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

OUT_DIR="factory/intelligence/codegraph/reports"
mkdir -p "$OUT_DIR"

timestamp="$(date -u '+%Y-%m-%d %H:%M:%S UTC')"

write_header() {
  local title="$1"
  local file="$2"
  {
    echo "# $title"
    echo
    echo "Generado: $timestamp"
    echo
    echo "> Reporte derivado. No editar manualmente; regenerar con \`./scripts/generate-codegraph-report.sh\`."
    echo
  } > "$file"
}

rel_md_files() {
  find factory template scripts -type f \( -name '*.md' -o -name '*.yaml' -o -name '*.yml' -o -name '*.sh' \) \
    ! -path 'factory/intelligence/codegraph/reports/*' \
    ! -path '*/node_modules/*' \
    ! -path '*/.next/*' \
    ! -path '*/dist/*' \
    ! -path '*/build/*' \
    | sort
}

write_header "Codegraph reports" "$OUT_DIR/README.md"
{
  echo "## Reportes"
  echo
  echo "- [Inventario](inventory.md)"
  echo "- [Markdown links](markdown-links.md)"
  echo "- [Agent role map](agent-role-map.md)"
  echo "- [Area map](area-map.md)"
  echo "- [Gate map](gate-map.md)"
  echo "- [Drift checks](drift-checks.md)"
} >> "$OUT_DIR/README.md"

write_header "Inventario" "$OUT_DIR/inventory.md"
{
  echo "## Archivos mapeados"
  echo
  echo "| Ruta | Tipo |"
  echo "|------|------|"
  while IFS= read -r path; do
    case "$path" in
      *.md) type="markdown" ;;
      *.yaml|*.yml) type="yaml" ;;
      *.sh) type="script" ;;
      *) type="file" ;;
    esac
    echo "| \`$path\` | $type |"
  done < <(rel_md_files)
} >> "$OUT_DIR/inventory.md"

write_header "Markdown links" "$OUT_DIR/markdown-links.md"
{
  echo "## Enlaces internos detectados"
  echo
  echo "| Origen | Destino declarado |"
  echo "|--------|-------------------|"
  while IFS= read -r file; do
    links="$(
      {
        grep -Eo '\[[^]]+\]\([^)]+\)|\[\[[^]]+\]\]' "$file" 2>/dev/null || true
      } \
        | sed -E 's/.*\]\(([^)#]+).*/\1/; s/^\[\[([^]|]+).*/\1/' \
        | grep -vE '^(https?|mailto):' || true
    )"
    while IFS= read -r target; do
      [[ -z "$target" ]] && continue
      echo "| \`$file\` | \`$target\` |"
    done <<< "$links"
  done < <(
    find factory template -type f -name '*.md' \
      ! -path 'factory/intelligence/codegraph/reports/*' \
      ! -path '*/node_modules/*' \
      ! -path '*/.next/*' \
      ! -path '*/dist/*' \
      ! -path '*/build/*' \
      | sort
  )
} >> "$OUT_DIR/markdown-links.md"

write_header "Agent role map" "$OUT_DIR/agent-role-map.md"
{
  echo "## Rol → perfil → prompt → playbook"
  echo
  echo "| Rol | Perfil | Prompt | Playbook | Estado |"
  echo "|-----|--------|--------|----------|--------|"
  roles=(marketing product design architecture db backend frontend qa uat devops security)
  for role in "${roles[@]}"; do
    profile="factory/agents/profiles/$role.md"
    prompt="factory/agents/prompts/$role.md"
    if [[ "$role" == "db" ]]; then
      playbook="factory/playbooks/architecture-playbook.md"
    else
      playbook="factory/playbooks/$role-playbook.md"
    fi
    status="OK"
    [[ -f "$profile" ]] || status="falta perfil"
    [[ -f "$prompt" ]] || status="falta prompt"
    [[ -f "$playbook" ]] || status="falta playbook"
    echo "| \`$role\` | \`$profile\` | \`$prompt\` | \`$playbook\` | $status |"
  done
  echo "| \`orchestrator\` | \`factory/agents/profiles/orchestrator.md\` | \`factory/agents/prompts/orchestrator.md\` | \`factory/agents/team-patterns.md\` | OK |"
} >> "$OUT_DIR/agent-role-map.md"

write_header "Area map" "$OUT_DIR/area-map.md"
{
  echo "## Áreas componibles"
  echo
  echo "| Área | Roles | Gates | Handoffs declarados |"
  echo "|------|-------|-------|---------------------|"
  while IFS= read -r area_file; do
    area="$(basename "$(dirname "$area_file")")"
    roles="$(
      awk '
        /^roles:/ { mode="roles"; next }
        /^[a-zA-Z_]+:/ { if ($0 !~ /^roles:/) mode="" }
        mode=="roles" && /^[[:space:]]+- / { sub(/^[[:space:]]+-[[:space:]]*/, ""); printf "%s ", $0 }
      ' "$area_file"
    )"
    gates="$(
      awk '
        /^gates:/ { mode="gates"; next }
        /^[a-zA-Z_]+:/ { if ($0 !~ /^gates:/) mode="" }
        mode=="gates" && /^[[:space:]]+- / { sub(/^[[:space:]]+-[[:space:]]*/, ""); printf "%s ", $0 }
      ' "$area_file"
    )"
    handoffs="$(
      grep -Ec '^[[:space:]]+- to:' "$area_file" || true
    )"
    echo "| \`$area\` | \`${roles:-none}\` | \`${gates:-none}\` | $handoffs |"
  done < <(find factory/areas -mindepth 2 -maxdepth 2 -name area.yaml | sort)
} >> "$OUT_DIR/area-map.md"

write_header "Gate map" "$OUT_DIR/gate-map.md"
{
  echo "## Gates estructurados"
  echo
  echo "Fuente: \`factory/governance/quality-gates.yaml\`"
  echo
  awk '
    /^  [1-7]:/ {
      if (gate != "") print ""
      gate=$1
      gsub(":", "", gate)
      print "### Gate " gate
      next
    }
    /^[[:space:]]+name:/ {
      sub(/^[[:space:]]+name:[[:space:]]*/, "")
      print ""
      print "- Nombre: " $0
      next
    }
    /^[[:space:]]+summary:/ {
      sub(/^[[:space:]]+summary:[[:space:]]*/, "")
      print "- Resumen: " $0
      next
    }
    /^[[:space:]]+roles:/ {
      mode="roles"
      print "- Roles:"
      next
    }
    /^[[:space:]]+required_files:/ {
      mode="files"
      print "- Archivos requeridos:"
      next
    }
    /^[[:space:]]+required_globs:/ {
      mode="globs"
      print "- Globs requeridos:"
      next
    }
    /^[[:space:]]+human_checks:/ {
      mode="checks"
      print "- Checks humanos:"
      next
    }
    /^[[:space:]]+- / {
      item=$0
      sub(/^[[:space:]]+-[[:space:]]*/, "", item)
      if (mode == "roles" || mode == "files" || mode == "globs" || mode == "checks") {
        print "  - `" item "`"
      }
    }
  ' factory/governance/quality-gates.yaml
} >> "$OUT_DIR/gate-map.md"

write_header "Drift checks" "$OUT_DIR/drift-checks.md"
{
  echo "## Checks"
  echo
  fail_count=0

  if find factory -name '.DS_Store' -print -quit | grep -q .; then
    echo "- ❌ Hay archivos \`.DS_Store\` bajo \`factory/\`."
    fail_count=$((fail_count + 1))
  else
    echo "- ✅ Sin \`.DS_Store\` bajo \`factory/\`."
  fi

  while IFS= read -r profile; do
    role="$(basename "$profile" .md)"
    prompt="factory/agents/prompts/$role.md"
    if [[ -f "$prompt" ]]; then
      echo "- ✅ Perfil con prompt: \`$role\`."
    else
      echo "- ❌ Perfil sin prompt: \`$role\`."
      fail_count=$((fail_count + 1))
    fi
  done < <(find factory/agents/profiles -type f -name '*.md' | sort)

  while IFS= read -r prompt; do
    role="$(basename "$prompt" .md)"
    profile="factory/agents/profiles/$role.md"
    if [[ ! -f "$profile" ]]; then
      echo "- ❌ Prompt sin perfil: \`$role\`."
      fail_count=$((fail_count + 1))
    fi
  done < <(find factory/agents/prompts -type f -name '*.md' | sort)

  for gate in 1 2 3 4 5 6 7; do
    if grep -q "^  $gate:" factory/governance/quality-gates.yaml; then
      echo "- ✅ Gate $gate definido en YAML."
    else
      echo "- ❌ Gate $gate no definido en YAML."
      fail_count=$((fail_count + 1))
    fi
  done

  echo
  echo "## Resultado"
  echo
  if [[ "$fail_count" -eq 0 ]]; then
    echo "Sin drift crítico detectado por checks básicos."
  else
    echo "Drift crítico detectado: $fail_count problema(s)."
  fi
} >> "$OUT_DIR/drift-checks.md"

echo "Codegraph generado en $OUT_DIR"
