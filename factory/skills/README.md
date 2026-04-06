# Catálogo de [skills.sh](https://skills.sh/) — stack y perfiles

El CLI oficial es `npx skills add <owner/repo>` ([documentación](https://skills.sh/docs), código en [vercel-labs/skills](https://github.com/vercel-labs/skills)). Los skills se instalan en el proyecto (p. ej. `.agents/skills/` para Cursor) o globalmente con `-g`.

## Instalación rápida en este repo

```bash
./scripts/install-skills.sh
```

Instala en **cursor**, **claude-code** y **antigravity** los paquetes listados abajo (no interactivo: `-y`).

## Stack objetivo (template / fábrica)

| Tema | Skills instalados (origen) |
|------|---------------------------|
| **Next.js / React** | `vercel-react-best-practices`, `next-best-practices`, `next-cache-components` (`vercel-labs/agent-skills`, `vercel-labs/next-skills`) |
| **UI / UX / accesibilidad** | `web-design-guidelines`, `frontend-design` (Vercel + Anthropic). Opcional: `canvas-design` (incluye fuentes; repo pesado) — `npx skills add anthropics/skills --skill canvas-design ...` |
| **shadcn** | `shadcn` (`shadcn/ui`) |
| **Vercel / deploy** | `deploy-to-vercel`, `vercel-composition-patterns` |
| **Neon (Postgres)** | `neon-postgres` (`neondatabase/agent-skills`) |
| **Node / API** | `nodejs-backend-patterns`, `api-design-principles` (`wshobson/agents`) |
| **Producto / PRD / Git** | `prd`, `git-commit`, `create-github-action-workflow-specification` (`github/awesome-copilot`) |
| **Diseño asistido (Stitch / prompts)** | `design-md`, `enhance-prompt` (`google-labs-code/stitch-skills`) — útiles si usas flujo tipo Stitch; **Pencil** u otras apps se pueden sumar vía MCP aparte |
| **Planificación (PO/SM, “kanban” de planes)** | `writing-plans`, `executing-plans` (`obra/superpowers`) |
| **QA / pruebas web** | `webapp-testing` (`anthropics/skills`) |

### Scrum / Kanban

No hay un skill único estándar para “Kanban” en el directorio; se cubre con **planes ejecutables** (`writing-plans`, `executing-plans`) + tus tableros en GitHub. Opcionalmente puedes añadir skills de terceros, p. ej. tras `npx skills find scrum`:

```bash
npx skills add aj-geddes/claude-code-bmad-skills --skill scrum-master -a cursor -a claude-code -a antigravity -y
```

(Revisa el nombre exacto del skill con `npx skills add ... --list`.)

## Mapa perfil de agente (`factory/agents/profiles/`) → skills

| Perfil | Skills típicos |
|--------|----------------|
| product | `prd`, `writing-plans` |
| design | `frontend-design`, `web-design-guidelines`, `design-md`, `enhance-prompt` |
| architecture | `api-design-principles`, `vercel-composition-patterns` |
| db | `neon-postgres` |
| backend | `nodejs-backend-patterns`, `api-design-principles` |
| frontend | `vercel-react-best-practices`, `next-best-practices`, `shadcn`, `web-design-guidelines` |
| qa | `webapp-testing` |
| devops | `deploy-to-vercel`, `create-github-action-workflow-specification` |
| security | (añadir bajo demanda, p. ej. `supercent-io/skills-template` → `security-best-practices` si lo validas) |

## Comandos útiles

```bash
npx skills list
npx skills check
npx skills update
npx skills find next
```

En la raíz del repo puede generarse `skills-lock.json` (versiones/hashes de skills instalados); conviene versionarlo si el equipo comparte el mismo conjunto.

## Nota sobre “Pencil”

Si te refieres a la herramienta de diseño **Pencil**, no hay un paquete único obligatorio en skills.sh con ese nombre; el flujo más cercano en el ecosistema abierto es **Stitch** (`design-md`, `enhance-prompt`). Los mocks/wireframes pueden seguir apoyándose en **MCP** de tu app de diseño además de estos skills.
