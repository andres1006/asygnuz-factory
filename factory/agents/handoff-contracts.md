# Contratos de handoff (artefactos formales)

Cada fila es un **contrato**: el rol de la izquierda **produce** (o mantiene) archivos que el **siguiente lee**. Rutas relativas al **repo del producto** (template instanciado).

| De → A | Produce (salida) | Lee el siguiente | Formato mínimo |
|--------|------------------|------------------|----------------|
| Producto → Diseño | `docs/00-prd.md`, `docs/01-requisitos-funcionales.md`, `docs/02-requisitos-no-funcionales.md` | Diseño | PRD con problema/alcance; RF/RNF con criterios comprobables (p. ej. GIVEN/WHEN/THEN). |
| Diseño → Arquitectura | `design/user-flows.md` + referencias a wireframes/mockups | Arquitectura | Flujos enlazados a RF; estados error/vacío. |
| Diseño → DB | (mismo) + supuestos de datos | DB | Necesidades de entidades reportadas en flujos. |
| Arquitectura → DB | `architecture/solution-architecture.md` | DB | Límites, integraciones, riesgos, stack. |
| DB → Backend | `db/data-model.md`, `db/migrations/*` | Backend | Esquema y migraciones alineadas al modelo. |
| Arquitectura → Dev | `architecture/...` + ADRs en `memory/adrs/` | Backend / Frontend | Decisiones que fijan APIs y módulos. |
| Backend / Frontend → QA | Código + PRs + `tasks/hu/*` | QA | HU con criterios de aceptación y trazabilidad. |
| QA → UAT | `qa/test-plan.md`, `qa/coverage-report.md`, evidencias | UAT (negocio) | Resultados y defectos cerrados o con plan. |
| UAT → DevOps | Resultados `uat/uat-results-*.md`, checklist | DevOps | Go/no-go explícito o condiciones. |
| DevOps → Security | `devops/deployment.md`, pipelines | Security | Superficie de deploy y secretos referidos. |
| Security → Release | `security/security-report.md`, checklist | Release | Baseline antes de producción. |
| Todos → Trazabilidad | `traceability/matriz-trazabilidad.md` | Auditoría | RF/HU/PR/test enlazados. |

**Estado del pipeline:** `tasks/gate-status.md` debe reflejar el gate en el que está el producto; no sustituye los artefactos anteriores.
