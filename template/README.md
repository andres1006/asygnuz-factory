# Product Factory Template v1

Plantilla robusta para lanzar productos con entrega semanal, trazabilidad y calidad.

## Stack por defecto
- Frontend/App: Next.js
- UI: Tailwind + shadcn/ui
- DB: Neon (PostgreSQL)
- Hosting/CI-CD: Vercel + GitHub
- Arquitectura: SOLID + Clean Code

## Intake — contexto de negocio (estructura fija)

Antes o durante el PRD formal, documentar investigación en **`docs/intake/`** (archivos `00`–`08`, mismos nombres en todos los proyectos). Ver **[docs/intake/README.md](docs/intake/README.md)**. El intake alimenta `docs/00-prd.md`; no lo sustituye hasta consolidar Gate 1.

**Changelog del producto:** **[docs/project-changelog.md](docs/project-changelog.md)** — línea de tiempo de definición (intake, PRD, alcance, gates) y construcción (hitos de entrega). Estándar en la fábrica: `factory/standards/project-changelog.md`.

## Flujo operativo semanal
1. **Producto**: completar intake (`docs/intake/`) y luego `docs/00-prd.md`, `docs/01-requisitos-funcionales.md`, `docs/02-requisitos-no-funcionales.md`
2. **Diseño**: actualizar `design/user-flows.md` + wireframes
3. **HU**: crear historias en `tasks/hu/` y plan semanal `tasks/sprint-week-XX.md`
4. **Arquitectura/DB**: definir solución en `architecture/solution-architecture.md` y modelo en `db/data-model.md`
5. **Desarrollo**: implementar por HU con PRs pequeños
6. **QA/UAT**: ejecutar plan en `qa/test-plan.md` + validación en `uat/uat-checklist.md`
7. **DevOps/Security**: validar `devops/deployment.md` y `security/security-checklist.md`
8. **Trazabilidad**: actualizar `traceability/matriz-trazabilidad.md`
9. **Memoria**: registrar decisiones en `memory/project-memory.md` y diario en `memory/daily/YYYY-MM-DD.md`
10. **Changelog del producto**: añadir entradas breves en `docs/project-changelog.md` al cerrar gates, cambiar alcance o completar hitos de construcción relevantes

## Herramientas y agentes (IDE)
Los perfiles de agente por rol viven en el repo de la fábrica (`factory/agents/`). Si el producto es un repo aparte, ver `docs/tooling-agents.md` para sincronizar reglas y punteros.

## Continuidad entre sesiones (sin arrancar “en cero”)

| Artefacto | Propósito |
|-----------|-----------|
| `CLAUDE.md`, `GEMINI.md`, `AGENTS.md` | Protocolo de inicio: qué leer primero (gates, memoria). |
| `tasks/gate-status.md` | Tabla viva: en qué gate estás y qué está aprobado. |
| `tasks/current-gate.txt` | Número `1`–`7` para scripts y CI (mantener alineado con la tabla). |
| `.factory/state.json` | Espejo opcional para herramientas; no sustituye la tabla. |
| `scripts/check-gate.sh` | Verificación mínima de archivos por gate: `./scripts/check-gate.sh` o `./scripts/check-gate.sh 3` |

Contratos de entrega entre roles (qué archivo produce cada uno): en la fábrica, `factory/agents/handoff-contracts.md`. Prompts listos por rol: `factory/agents/prompts/*.md`.

## Skills y perfiles (repo solo template)

- **Instalar stack (Next, Neon, Vercel, shadcn, PRD, etc.):** `./scripts/install-skills.sh` (requiere Node/npx). Ver [docs/skills-profiles.md](docs/skills-profiles.md) para mapa rol → skill.
- **Scripts:** [scripts/README.md](scripts/README.md).

## Gates obligatorios
- No desarrollo sin PRD + RF + RNF completos
- No merge sin tests + cobertura mínima definida (objetivo 90%)
- No release sin UAT + checklist de seguridad básica
- Toda HU debe mapear a PRD y evidencia de test

## Estructura
Ver árbol de carpetas en este README al final.

```text
.
├─ docs/
│  ├─ intake/          # fuente canónica de contexto negocio (00–08)
│  ├─ project-changelog.md  # definición + construcción (línea de tiempo)
│  ├─ 00-prd.md
│  ├─ 01-requisitos-funcionales.md
│  └─ …
├─ design/
├─ tasks/
├─ architecture/
├─ db/
├─ qa/
├─ uat/
├─ devops/
├─ security/
├─ memory/
├─ traceability/
├─ scripts/
├─ .cursor/rules/
└─ .github/workflows/
```
