# Factory — cerebro de la fábrica / empresa

Este directorio es el **punto único de verdad** para gobierno, conocimiento transversal y mejora continua. Los proyectos viven fuera (p. ej. `projects/`) y consumen el **template**; aquí se decide **cómo** trabajamos y **cómo evoluciona** el estándar.

## Mapa mental (qué va dónde)

| Capa | Carpeta | Rol |
|------|---------|-----|
| **Estrategia** | `strategy/` | Norte: visión, modelo incubadora (POC → clientes), objetivos. |
| **Gobierno** | `governance/` | Reglas de juego: RACI, gates, definición de hecho, modelo operativo. |
| **Arquitectura del sistema** | `architecture/` | Cómo encajan Factory → Template → Projects. |
| **Estándares** | `standards/` | Políticas técnicas y de calidad que aplican a todos. |
| **Decisiones** | `decisions/` | ADRs de fábrica (stack, políticas globales, cambios estructurales). |
| **Operación** | `operations/` | Runbooks, releases, evolución del template. |
| **Playbooks** | `playbooks/` | Flujo por rol y entregas entre equipos. |
| **Agentes (IA)** | `agents/` | Perfiles por rol (Markdown); Cursor/Claude/Gemini enlazan aquí sin duplicar política. |
| **Skills instalados** | `skills/` | Catálogo y mapa al stack ([skills.sh](https://skills.sh/)); artefactos en `.agents/skills/` (ver `../scripts/install-skills.sh`). |
| **Inteligencia** | `monitoring/` + `metrics/` | Portafolio, estado, KPIs y scorecards. |
| **Evolución** | `changes/` | Propuestas y trabajo para mejorar el template y la fábrica. |

## Flujo de lectura recomendado
1. `strategy/vision.md` y `strategy/incubator-model.md` — propósito y reglas de la POC (Markdown, MCP, aprobaciones, repos).
2. `architecture/factory-architecture.md` — niveles Factory → Template → Projects (repos separados).
3. `governance/operating-model.md` + `governance/quality-gates.md` + `governance/factory-governance.md` — cadencia, gates y DoD global.
4. `standards/engineering-standards.md` y `standards/task-specification.md` — política técnica y formato de tareas (obligatorio el nivel base; **SDD + gentle-ai opcional** si el producto lo adopta).
5. `agents/README.md`, `agents/handoff-flow.md`, `agents/handoff-contracts.md`, `agents/prompts/*.md` y `agents/profiles/*.md` — contratos, prompts y perfiles por rol.
6. `playbooks/roles-and-handoffs.md` — handoffs; luego playbooks por rol según necesidad.
7. `operations/` — semana, releases y evolución del template.
8. `monitoring/` y `metrics/` — portafolio y medición.
9. `decisions/` — cuando una decisión afecte a toda la fábrica o al template base (ADRs).

El listado exhaustivo de archivos está en `INDEX.md`.

## Regla de oro
Todo aprendizaje de proyectos se retroalimenta en `template/` vía un change documentado en `changes/`, alineado con estándares y, si aplica, un ADR en `decisions/`.

## Índice detallado
Ver `INDEX.md`.
