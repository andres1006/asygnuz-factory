# Áreas componibles

`areas/` define capacidades reutilizables de la fábrica. Una área agrupa roles,
artefactos, gates, handoffs, métricas y límites operativos. No reemplaza
`agents/`, `playbooks/` ni `governance/`: los compone.

## Modelo mental

| Capa | Responsabilidad |
|------|-----------------|
| `agents/` | Quién trabaja: perfiles y prompts por rol. |
| `playbooks/` | Cómo trabaja cada rol. |
| `governance/quality-gates.*` | Cuándo se valida. |
| `areas/` | Qué capacidades puede activar un cliente/proyecto. |
| `factory/agency/` | Cómo se empaquetan áreas como servicios autónomos. |

## Áreas iniciales

- `marketing/` — posicionamiento, contenido, campañas, performance y reporting.
- `product/` — PRD, RF/RNF, alcance, priorización y validación.
- `design/` — flujos, wireframes, UI/UX y handoff visual.
- `architecture/` — arquitectura de solución, ADRs y límites técnicos.
- `data/` — modelo de datos, migraciones y analítica/data contracts.
- `development/` — backend, frontend, integración y delivery técnico.
- `qa/` — estrategia de pruebas, cobertura y evidencia.
- `uat/` — validación de negocio y go/no-go.
- `devops/` — entornos, CI/CD, deploys y operación técnica.
- `security/` — baseline, secretos, threat checks y reporte de seguridad.

## Composición por cliente

Un cliente activa áreas con un archivo de composición, por ejemplo:

```yaml
client: acme
active_areas:
  - marketing
  - product
  - design
  - development
  - qa
  - devops

approval_policy:
  public_content: human_required
  website_changes: pull_request
  paid_ads_launch: human_required
```

La composición debe validar que los handoffs entre áreas estén cubiertos. Si
`development` consume `docs/marketing/00-marketing-brief.md`, el área
`marketing` debe estar activa o el proyecto debe declarar una excepción.
