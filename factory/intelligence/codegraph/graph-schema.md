# Esquema del grafo

Modelo conceptual usado por los reportes de Codegraph.

## Nodos

| Tipo | Ejemplo | Descripción |
|------|---------|-------------|
| `document` | `factory/README.md` | Documento Markdown/YAML relevante. |
| `role` | `frontend` | Rol/agente operativo. |
| `gate` | `Gate 4` | Quality gate de producto. |
| `artifact` | `docs/00-prd.md` | Archivo esperado en un producto/template. |
| `script` | `scripts/check-factory-docs.sh` | Automatización local. |

## Aristas

| Relación | Ejemplo |
|----------|---------|
| `links_to` | `factory/README.md` → `factory/INDEX.md` |
| `defines` | `quality-gates.yaml` → `Gate 1` |
| `participates_in` | `product` → `Gate 1` |
| `requires` | `Gate 1` → `docs/00-prd.md` |
| `uses_profile` | `product` → `agents/profiles/product.md` |
| `uses_prompt` | `product` → `agents/prompts/product.md` |
| `uses_playbook` | `product` → `playbooks/product-playbook.md` |

## Principio de diseño

El grafo es derivado y auditable. Debe poder regenerarse desde archivos del repo
sin editar manualmente los reportes.
