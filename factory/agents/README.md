# Agentes especializados (fuente canónica)

Los perfiles viven aquí en **Markdown** para que cualquier herramienta (Cursor, Claude Code, Antigravity, otros) pueda **leer el mismo contenido** sin lock-in. Las reglas específicas de cada IDE son **delgadas** y apuntan a estos archivos.

## Dos modos de operación

**Modo manual (un agente a la vez):** el humano lee `tasks/gate-status.md`, elige el rol, pega el prompt en el IDE y trabaja.

**Modo orquestado (Agent Teams):** el Orchestrator lee el estado, spawna los agentes correctos (en paralelo donde aplica), coordina merges, y solo pausa cuando el humano necesita aprobar. Ver [prompts/orchestrator.md](prompts/orchestrator.md) y [team-patterns.md](team-patterns.md).

---

## Guía rápida (trabajo diario)

1. **Estado del producto:** en el repo del producto → `tasks/gate-status.md`, `tasks/current-gate.txt`.
2. **Mapa gate → rol → prompt:** [gate-role-map.md](gate-role-map.md) (qué agente usar según `tasks/current-gate.txt`).
3. **Contrato de entregables entre roles:** [handoff-contracts.md](handoff-contracts.md) (qué archivo produce cada rol y quién lo lee).
4. **Prompt listo para pegar/cargar en el IDE:** [prompts/](prompts/) → un archivo por rol (objetivo de sesión + criterios de salida).
5. **Contexto y comportamiento del rol:** tabla de perfiles abajo → [profiles/](profiles/).
6. **Framework de autonomía:** [autonomy-framework.md](autonomy-framework.md) — qué decide el agente solo vs escala al humano.

Sin los **prompts** y **handoff-contracts**, el perfil solo describe el rol; el prompt ordena la sesión de forma ejecutable.

## Contratos, prompts, flujo y orquestación

| Recurso | Enlace | Uso |
|---------|--------|-----|
| Orchestrator (modo teams) | [prompts/orchestrator.md](prompts/orchestrator.md) | Coordina el pipeline completo con agentes paralelos |
| Patrones de Agent Teams | [team-patterns.md](team-patterns.md) | A: secuencial · B: paralelo · C: revisor · D: escalación |
| Coordinación paralela | [parallel-coordination.md](parallel-coordination.md) | Worktree isolation, merge, ownership de archivos |
| Autonomía | [autonomy-framework.md](autonomy-framework.md) | 🟢🟡🔴 por gate: qué hace solo vs escala |
| Gate → rol | [gate-role-map.md](gate-role-map.md) | Tabla rápida por `current-gate.txt` |
| Handoffs / artefactos | [handoff-contracts.md](handoff-contracts.md) | Contrato formal archivo → siguiente rol |
| Prompts por fase | [prompts/](prompts/) | Inicio de sesión por gate/rol |
| Cadena de roles | [handoff-flow.md](handoff-flow.md) | Orden macro Producto → … → Release |

## Índice: perfil + prompt (mismo rol)

| ID | Perfil | Perfil (contexto) | Prompt (sesión) |
|----|--------|-------------------|-----------------|
| `orchestrator` | Orchestrator | [profiles/orchestrator.md](profiles/orchestrator.md) | [prompts/orchestrator.md](prompts/orchestrator.md) |
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

## Automatización ligada a agentes

| Acción | Dónde |
|--------|--------|
| Ver rol/prompt sugerido para el gate actual | En el producto: `./scripts/session-hint.sh` · Desde el wrapper: `./scripts/session-hint.sh projects/<nombre>` |
| Verificar archivos mínimos del gate | `./scripts/check-gate.sh [N]` |
| CI build/lint | `.github/workflows/ci.yml` (producto) |
| CI gate (archivos) | `.github/workflows/gate-check.yml` (producto) |

Los prompts no se ejecutan solos: el script **orienta** qué abrir; la ejecución sigue siendo en el IDE o cliente con `FACTORY_ROOT` apuntando al wrapper.

## Relación con `template/`

Los playbooks bajo `template/` son la **instancia** de entregables; los perfiles citan esos paths cuando trabajás en un producto generado desde el template. Ver `template/docs/tooling-agents.md`, `template/docs/skills-profiles.md`.
