# Agentes especializados (fuente canónica)

Los perfiles viven aquí en **Markdown** para que cualquier herramienta (Cursor, Claude Code, Antigravity, otros) pueda **leer el mismo contenido** sin lock-in. Las reglas específicas de cada IDE son **delgadas** y apuntan a estos archivos.

## Guía rápida (trabajo diario)

1. **Estado del producto:** en el repo del producto → `tasks/gate-status.md`, `tasks/current-gate.txt`.
2. **Contrato de entregables entre roles:** [handoff-contracts.md](handoff-contracts.md) (qué archivo produce cada rol y quién lo lee).
3. **Prompt listo para pegar/cargar en el IDE:** [prompts/](prompts/) → un archivo por rol (objetivo de sesión + criterios de salida).
4. **Contexto y comportamiento del rol:** tabla de perfiles abajo → [profiles/](profiles/).

Sin los **prompts** y **handoff-contracts**, el perfil solo describe el rol; el prompt ordena la sesión de forma ejecutable.

## Contratos, prompts y flujo

| Recurso | Enlace | Uso |
|---------|--------|-----|
| Handoffs / artefactos | [handoff-contracts.md](handoff-contracts.md) | Contrato formal archivo → siguiente rol |
| Prompts por fase | [prompts/](prompts/) | Inicio de sesión por gate/rol |
| Cadena de roles | [handoff-flow.md](handoff-flow.md) | Orden macro Producto → … → Release |

## Índice: perfil + prompt (mismo rol)

| ID | Perfil | Perfil (contexto) | Prompt (sesión) |
|----|--------|-------------------|-----------------|
| `product` | Producto | [profiles/product.md](profiles/product.md) | [prompts/product.md](prompts/product.md) |
| `design` | Diseño | [profiles/design.md](profiles/design.md) | [prompts/design.md](prompts/design.md) |
| `architecture` | Arquitectura | [profiles/architecture.md](profiles/architecture.md) | [prompts/architecture.md](prompts/architecture.md) |
| `db` | Base de datos | [profiles/db.md](profiles/db.md) | [prompts/db.md](prompts/db.md) |
| `backend` | Backend | [profiles/backend.md](profiles/backend.md) | [prompts/backend.md](prompts/backend.md) |
| `frontend` | Frontend | [profiles/frontend.md](profiles/frontend.md) | [prompts/frontend.md](prompts/frontend.md) |
| `qa` | QA | [profiles/qa.md](profiles/qa.md) | [prompts/qa.md](prompts/qa.md) |
| `uat` | UAT | [profiles/uat.md](profiles/uat.md) | [prompts/uat.md](prompts/uat.md) |
| `devops` | DevOps | [profiles/devops.md](profiles/devops.md) | [prompts/devops.md](prompts/devops.md) |
| `security` | Security | [profiles/security.md](profiles/security.md) | [prompts/security.md](prompts/security.md) |

## Herramientas (transparente)

| Herramienta | Cómo enlaza |
|-------------|-------------|
| **Cursor** | `.cursor/rules/*.mdc` → descripción + enlace al perfil en `factory/agents/profiles/`. Skills: [skills.sh](https://skills.sh/) en `.agents/skills/` (ver `../skills/README.md`). |
| **Claude Code** | `CLAUDE.md` del producto o wrapper; skills en `.claude/skills/`. |
| **Antigravity / Gemini** | `GEMINI.md` + opcional `.agent/rules/`. |
| **Cualquier otra** | Abre perfil + prompt o pega rutas al contexto. |

Instalación de skills del stack (wrapper): `./scripts/install-skills.sh`. En repo **solo template**: `./scripts/install-skills.sh` dentro del proyecto (copiado desde `template/scripts/`).

## Relación con `template/`

Los playbooks bajo `template/` son la **instancia** de entregables; los perfiles citan esos paths cuando trabajás en un producto generado desde el template. Ver `template/docs/tooling-agents.md`, `template/docs/skills-profiles.md`.
