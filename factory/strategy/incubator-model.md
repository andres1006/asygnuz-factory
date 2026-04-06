# Modelo incubadora + fábrica de software

*Ubicación en la fábrica:* estrategia (`strategy/`). Índice de todo `factory/`: `../INDEX.md`.

## Objetivo
Sacar productos digitales **escalables y mantenibles**, validar en mercado **rápido**, **iterar o pivotear** como incubadora, y evolucionar hacia **réplica en producción con clientes** cuando el modelo esté probado.

## Alcance actual (POC)
- **Productos propios**; la meta es **monetizar** y llevar el mismo modo de trabajo a **clientes en producción**.
- **Fuente de verdad de producto**: documentos **Markdown** (tolerancia a caos en el intake; se estructura en el flujo).
- **Diseño**: a partir del conocimiento en Markdown se elaboran mocks/wireframes; herramientas de diseño se integran **vía MCP** según se vayan necesitando.
- **Roles tipo Producto** (PO / PM / SM): **fusionables** en un solo hilo de agente/proceso en esta fase.
- **UAT**: **Fase 1** — revisión manual con una persona de negocio para **refinar el proceso** (checklist, criterios, tiempos). **Evolución** — hacia UAT **autónomo** (entorno QA estable, criterios comprobables, automatización donde aplique); ver `template/uat/uat-checklist.md` en el template.

## Control y camino a la autonomía
- **Ahora**: control explícito — hay que **probar/aprobar** para avanzar; foco en **calidad y entregables** medibles.
- **Después**: transición gradual a más autonomía, manteniendo siempre **panorama y timeline** visibles para que la aprobación sea principalmente sobre **entregables, documentos, diseños, módulos y features** (no microgestión accidental).

## Tareas y eficiencia
Cada pieza de trabajo debe quedar **muy definida**, con claridad de:
- **Quién** (rol / agente / persona)
- **Para qué** (outcome)
- **Cómo** (enfoque o restricciones)
- **Criterios de aceptación** (incl. pruebas cuando aplique)

Ver `../standards/task-specification.md`.

## Repositorios
- **Wrapper (este monorepo de empresa/fábrica)**: un solo git; contiene `factory/`, `template/`, política común.
- **Cada producto**: **repositorio propio** bajo `projects/<nombre>/` en local, **no** versionado dentro del wrapper (evita anidación y mezcla de historiales).

## MCP y agentes
- Conexión **por demanda**: ir instalando y configurando MCP según necesidad (diseño, tickets, hosting, etc.).
- Los perfiles de agente por rol están en `../agents/` (Markdown); Cursor, Claude Code y Antigravity/Gemini enlazan a esa fuente desde la raíz del repo (`AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.cursor/rules/`, `.agent/rules/`).
- Los flujos agenticos se alinean a los playbooks en `../playbooks/` y a los gates en `../governance/`.
