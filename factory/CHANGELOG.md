# Factory Changelog

## v1.9.0
- Agentes: **`factory/agents/gate-role-map.md`** (gate → rol → prompt) y tabla de **automatización** en `factory/agents/README.md`.
- Script **`template/scripts/session-hint.sh`** (+ delegación `scripts/session-hint.sh` en el wrapper): pista de rol/prompt según `current-gate.txt`; `new-product.sh` deja el script ejecutable.
- Prompts **product / frontend / backend** alineados a `session-hint` y stack **`apps/web`**.
- Cursor **`000-factory-core.mdc`**: enlaces a prompts, contratos, `gate-role-map`, `FACTORY_ROOT`, `apps/web`; **`agent-product.mdc`**: salidas en `docs/` del producto (no `template/docs/`).

## v1.8.0
- Template: app **Next.js 16** en `apps/web` con **pnpm** workspace, **Tailwind v4**, **shadcn/ui**, cliente **Neon** (`@neondatabase/serverless`, `src/lib/db.ts`).
- CI GitHub Actions: `pnpm install`, lint y build en ramas **`main`** y **`qa`**; `gate-check` también en PRs hacia `qa`.
- `devops/deployment.md`: ambientes **QA** (`qa`) y **PROD** (`main`) en Vercel; notas de monorepo.
- `docs/local-development.md`, `apps/web/.env.example`, `template/.gitignore` raíz; `new-product.sh` elimina `node_modules` copiados.
- UAT: `uat-checklist.md` + `incubator-model.md` + prompt UAT alineados a **Fase 1 (refinar proceso)** y evolución a **UAT autónomo**.
- `engineering-standards.md`: stack con pnpm y rutas `apps/web`.

## v1.7.0
- Estándar **`factory/standards/project-changelog.md`**: bitácora de definición y construcción del producto.
- Template: **`template/docs/project-changelog.md`** + referencias en `README.md`, `CLAUDE.md`, `docs/tooling-agents.md`.
- Prompt producto: actualizar `docs/project-changelog.md` al cerrar Gate 1.
- `intake-documentation.md`: enlace complementario a `docs/project-changelog.md`.

## v1.6.0
- Template: carpeta **`docs/intake/`** con estructura fija `00–08` (README + plantillas) para gestión coherente del contexto de negocio antes del PRD.
- `factory/standards/intake-documentation.md`: estándar de la fábrica para ese intake.
- `template/README.md`, `template/CLAUDE.md`, prompt producto: lectura obligatoria del intake en flujo de producto.

## v1.5.1
- `agents/README.md`: guía rápida + tabla perfil↔prompt; handoff-contracts y prompts destacados.
- `agents/profiles/*.md`: enlace explícito al prompt ejecutable por rol.
- Template: `docs/gates-checklist.md` alineado a 7 gates (`quality-gates.md`); `docs/skills-profiles.md`; `scripts/install-skills.sh` + `scripts/README.md`; `.cursor/rules/000-template-core.mdc`.
- `check-gate.sh`: mensajes que aclaran verificación mínima y límites en gates 4–7.

## v1.5.0
- `agents/handoff-contracts.md`: contratos formales de artefactos entre roles.
- `agents/prompts/*.md`: prompts ejecutables por fase (10 roles).
- Template: `CLAUDE.md`, `GEMINI.md`, `AGENTS.md`, `tasks/gate-status.md`, `tasks/current-gate.txt`, `.factory/state.json`, `scripts/check-gate.sh`.
- `scripts/new-product.sh` (bootstrap en `projects/<nombre>`), `scripts/check-gate.sh` (delega al template).
- `template/.github/workflows/gate-check.yml`: CI de verificación según `current-gate.txt`.

## v1.4.0
- `skills/README.md`: catálogo [skills.sh](https://skills.sh/) alineado a stack (Next, React, Neon, Vercel, shadcn, Node, PRD, GitHub Actions spec, Stitch design-md, planes).
- `../scripts/install-skills.sh`: instalación no interactiva para Cursor, Claude Code y Antigravity.
- `agents/README.md`, `AGENTS.md`, `template/docs/tooling-agents.md`: enlaces a skills.

## v1.3.0
- `agents/`: perfiles por rol en Markdown (`profiles/*.md`), `README.md`, `handoff-flow.md`; alineados a playbooks y gates.
- Raíz del wrapper: `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.cursor/rules/` (core + `agent-*.mdc`), `.agent/rules/factory-agents.md`.
- `template/docs/tooling-agents.md`: uso en monorepo vs repo solo de producto.

## v1.2.1
- Alineación de documentación: `README.md` (flujo de lectura con arquitectura, gobierno completo, estándares de tarea, decisiones); `INDEX.md` (enlace al wrapper y autoreferencia); `factory-architecture.md`, `operating-model.md`, `decisions/README.md` e `incubator-model.md` con referencias cruzadas coherentes.

## v1.2.0
- `strategy/incubator-model.md`: POC propia → monetización/clientes; Markdown como fuente; MCP por demanda; roles fusionados; UAT único; control y transición a autonomía; repos por producto.
- `standards/task-specification.md`: tareas con quién / para qué / cómo / criterios de aceptación.
- `.gitignore`: ignora contenido de `projects/` en el repo wrapper; `projects/README.md` documenta clones por producto.
- README raíz y `strategy/vision.md` alineados al modelo incubadora.

## v1.1.0
- Estructura de “cerebro”: carpetas `strategy/`, `standards/`, `decisions/` con documentos base.
- README e INDEX alineados al mapa por capas (estrategia, gobierno, estándares, ADRs, inteligencia, evolución).
- `architecture/factory-architecture.md` actualizado con el desglose del nivel Factory.

## v1.0.0
- Definición base de operating model
- Gates de calidad
- RACI inicial
- Playbooks por rol
- Monitoreo y KPIs
- Proceso de evolución de template
