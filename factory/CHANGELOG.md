# Factory Changelog

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
