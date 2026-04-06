# Agentes especializados (fuente canónica)

Los perfiles viven aquí en **Markdown** para que cualquier herramienta (Cursor, Claude Code, Antigravity, otros) pueda **leer el mismo contenido** sin lock-in. Las reglas específicas de cada IDE son **delgadas** y apuntan a estos archivos.

## Índice de perfiles

| ID | Perfil | Archivo |
|----|--------|---------|
| `product` | Producto (PO/PM/SM fusionado en POC) | [profiles/product.md](profiles/product.md) |
| `design` | Diseño UX/UI | [profiles/design.md](profiles/design.md) |
| `architecture` | Arquitectura | [profiles/architecture.md](profiles/architecture.md) |
| `db` | Base de datos | [profiles/db.md](profiles/db.md) |
| `backend` | Backend | [profiles/backend.md](profiles/backend.md) |
| `frontend` | Frontend | [profiles/frontend.md](profiles/frontend.md) |
| `qa` | QA | [profiles/qa.md](profiles/qa.md) |
| `uat` | UAT (negocio) | [profiles/uat.md](profiles/uat.md) |
| `devops` | DevOps | [profiles/devops.md](profiles/devops.md) |
| `security` | Security | [profiles/security.md](profiles/security.md) |

## Flujo de handoff

Ver [handoff-flow.md](handoff-flow.md).

## Herramientas (transparente)

| Herramienta | Cómo enlaza |
|-------------|-------------|
| **Cursor** | `.cursor/rules/*.mdc` → descripción + enlace al perfil en `factory/agents/profiles/`. |
| **Claude Code** | `CLAUDE.md` en la raíz del repo apunta aquí. |
| **Antigravity / Gemini** | `GEMINI.md` + opcional `.agent/rules/` (puntero). |
| **Cualquier otra** | Abre el `.md` del perfil o pega su ruta como contexto. |

## Relación con `template/`

Los playbooks de producto bajo `template/` son la **instancia** de entregables; los perfiles de agente citan esos paths cuando trabajas dentro de un proyecto generado desde el template. Ver `template/docs/tooling-agents.md`.
