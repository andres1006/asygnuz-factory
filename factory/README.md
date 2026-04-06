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
| **Inteligencia** | `monitoring/` + `metrics/` | Portafolio, estado, KPIs y scorecards. |
| **Evolución** | `changes/` | Propuestas y trabajo para mejorar el template y la fábrica. |

## Flujo de lectura recomendado
1. `strategy/vision.md` y `strategy/incubator-model.md` — propósito y reglas de la POC (Markdown, MCP, aprobaciones, repos).
2. `governance/operating-model.md` + `governance/quality-gates.md` — cadencia y gates.
3. `standards/` — límites técnicos.
4. `playbooks/roles-and-handoffs.md` — quién hace qué.
5. `operations/` — cómo se opera la semana y los releases.
6. `monitoring/` / `metrics/` — cómo se mide.

## Regla de oro
Todo aprendizaje de proyectos se retroalimenta en `template/` vía un change documentado en `changes/`, alineado con estándares y, si aplica, un ADR en `decisions/`.

## Índice detallado
Ver `INDEX.md`.
