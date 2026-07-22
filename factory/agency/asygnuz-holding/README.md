# Asygnuz Holding

Modelo operativo adaptado desde la estructura histórica de OpenClaw/Jarvis para
Asygnuz. Esta carpeta convierte esa visión en una arquitectura versionable,
compatible con `factory/areas/`, `factory/agents/`, `factory/agency/` y
Codegraph.

## Identidad operacional

Asygnuz opera como un holding de ingeniería de crecimiento:

- **Asygnuz Labs:** software, producto, cloud, IA, automatización y SaaS.
- **Asygnuz Growth:** performance marketing, SEO programático, funnels, copy,
  adquisición y sistemas comerciales.

La tesis central es unir código y distribución:

```text
Engineering as Marketing
  → herramientas útiles gratuitas
  → captación de leads
  → automatización de conversión
  → servicios high-ticket / SaaS
  → reinversión en más sistemas
```

## Relación con Factory

| Concepto histórico OpenClaw | Equivalente en Factory |
|-----------------------------|------------------------|
| Jarvis / Orquestador | `factory/agents/profiles/orchestrator.md` |
| CMO Bot | `factory/areas/marketing/` + `factory/areas/sales/` |
| CTO Bot | `factory/areas/architecture/`, `data/`, `development/`, `devops/` |
| CFO Bot | `factory/areas/finance/` |
| CLO Bot | `factory/areas/legal/` |
| CHRO Bot / Recursos IA | `factory/areas/agent-ops/` |
| ClawFlows | `workflows.md` + `factory/agency/*/workflows.md` |
| Instincts / aprendizaje | `learning-protocol.md` |

## Regla de seguridad

Esta carpeta no debe contener memoria privada, secretos, tokens, sesiones ni
datos personales operativos. Los documentos históricos pueden inspirar la
estructura, pero la fuente versionada debe ser reusable y segura.
