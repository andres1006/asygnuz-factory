# Contexto del proyecto (Claude Code)

Este repositorio es el **wrapper de la fábrica** (`factory/`, `template/`). Los **agentes especializados por rol** están definidos en Markdown para ser agnósticos al IDE:

- Índice: `factory/agents/README.md`
- Perfiles: `factory/agents/profiles/*.md`
- Flujo de handoff: `factory/agents/handoff-flow.md`

Al trabajar en un rol concreto, carga el perfil correspondiente como referencia principal y respeta los gates en `factory/governance/quality-gates.md`.

**Repos de producto** (generados desde `template/`): el protocolo de sesión y el estado del pipeline están en `template/CLAUDE.md` (y en cada clon bajo `projects/<nombre>/CLAUDE.md`) junto con `tasks/gate-status.md` y `tasks/current-gate.txt`.
