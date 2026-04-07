# Mapa Gate → rol → prompt

Referencia para orquestar agentes y enlazar automatización (CI, scripts). Gates normativos: `factory/governance/quality-gates.md`.

| Gate | Resumen | Rol(es) | Prompt |
|------|---------|---------|--------|
| 1 | Producto | `product` | [prompts/product.md](prompts/product.md) |
| 2 | Diseño | `design` | [prompts/design.md](prompts/design.md) |
| 3 | Arquitectura + DB | `architecture`, `db` | [prompts/architecture.md](prompts/architecture.md), [prompts/db.md](prompts/db.md) |
| 4 | Desarrollo | `backend`, `frontend` | [prompts/backend.md](prompts/backend.md), [prompts/frontend.md](prompts/frontend.md) |
| 5 | QA | `qa` | [prompts/qa.md](prompts/qa.md) |
| 6 | UAT | `uat` | [prompts/uat.md](prompts/uat.md) |
| 7 | Release | `devops`, `security` | [prompts/devops.md](prompts/devops.md), [prompts/security.md](prompts/security.md) |

## Transversal

- Handoffs: [handoff-contracts.md](handoff-contracts.md), [handoff-flow.md](handoff-flow.md)
- Producto: `tasks/gate-status.md`, `tasks/current-gate.txt`, `CLAUDE.md`

## Automatización

- `./scripts/session-hint.sh` en el producto (mapa filtrado por gate actual)
- `./scripts/check-gate.sh [N]` — archivos mínimos
- GitHub Actions: `ci.yml`, `gate-check.yml`
