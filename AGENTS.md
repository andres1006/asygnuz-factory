# Agentes y roles (entrada multi-herramienta)

La definición **canónica** de perfiles, handoffs y enlaces a playbooks está en:

**[`factory/agents/README.md`](factory/agents/README.md)**

Usa esa carpeta desde **Cursor** (reglas en `.cursor/rules/`), **Claude Code** (`CLAUDE.md`), **Antigravity / Gemini** (`GEMINI.md`) o copiando rutas al contexto en cualquier otro cliente.

No dupliques política aquí: un solo lugar (`factory/agents/profiles/*.md`) para mantener transparencia entre herramientas.

## Skills ([skills.sh](https://skills.sh/))

Capacidades reutilizables (Next, React, Neon, Vercel, shadcn, PRD, planes, etc.): ver **`factory/skills/README.md`** y ejecutar **`./scripts/install-skills.sh`** para instalar en Cursor, Claude Code y Antigravity.
