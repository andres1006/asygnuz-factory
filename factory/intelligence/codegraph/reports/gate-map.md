# Gate map

Generado: 2026-07-22 20:04:07 UTC

> Reporte derivado. No editar manualmente; regenerar con `./scripts/generate-codegraph-report.sh`.

## Gates estructurados

Fuente: `factory/governance/quality-gates.yaml`

### Gate 1

- Nombre: Producto
- Resumen: Brief de marketing, PRD, requisitos funcionales/no funcionales y KPI semanal.
- Roles:
  - `marketing`
  - `product`
- Archivos requeridos:
  - `docs/marketing/00-marketing-brief.md`
  - `docs/00-prd.md`
  - `docs/01-requisitos-funcionales.md`
  - `docs/02-requisitos-no-funcionales.md`
- Globs requeridos:
- Checks humanos:
  - `PRD completo con problema, alcance y supuestos explícitos.`
  - `RF y RNF tienen criterios comprobables, preferentemente GIVEN/WHEN/THEN.`
  - `KPI de validación semanal definido.`

### Gate 2

- Nombre: Diseño
- Resumen: Flujos de usuario trazados a RF y wireframes base.
- Roles:
  - `design`
- Archivos requeridos:
  - `design/user-flows.md`
- Globs requeridos:
- Checks humanos:
  - `Flujos de usuario mapeados a requisitos funcionales.`
  - `Wireframes o referencias visuales disponibles.`
  - `Estados de error, vacío y carga considerados cuando apliquen.`

### Gate 3

- Nombre: Arquitectura + DB-first
- Resumen: Arquitectura, modelo de datos, migraciones iniciales y ADRs críticos.
- Roles:
  - `architecture`
  - `db`
- Archivos requeridos:
  - `architecture/solution-architecture.md`
  - `db/data-model.md`
- Globs requeridos:
  - `db/migrations/*`
- Checks humanos:
  - `Arquitectura aprobada y alineada a alcance.`
  - `Modelo de datos y migraciones iniciales consistentes.`
  - `ADRs críticos registrados cuando hay decisiones estructurales.`

### Gate 4

- Nombre: Desarrollo
- Resumen: HU implementadas con evidencia en PRs y revisión técnica.
- Roles:
  - `backend`
  - `frontend`
- Archivos requeridos:
  - `tasks/sprint-week-XX.md`
- Globs requeridos:
  - `tasks/hu/*.md`
- Checks humanos:
  - `HU implementadas con evidencia en PRs.`
  - `Convenciones SOLID/Clean Code revisadas.`
  - `Trazabilidad RF/HU actualizada.`

### Gate 5

- Nombre: QA
- Resumen: Pruebas ejecutadas y cobertura objetivo o excepción aprobada.
- Roles:
  - `qa`
- Archivos requeridos:
  - `qa/test-plan.md`
  - `qa/coverage-report.md`
- Globs requeridos:
- Checks humanos:
  - `Unit, integration y e2e ejecutados según alcance.`
  - `Cobertura global >= 90% o excepción explícita aprobada.`
  - `Defectos críticos cerrados o con plan acordado.`

### Gate 6

- Nombre: UAT
- Resumen: Checklist UAT ejecutado y go/no-go definido.
- Roles:
  - `uat`
- Archivos requeridos:
  - `uat/uat-checklist.md`
- Globs requeridos:
  - `uat/uat-results-*.md`
- Checks humanos:
  - `Checklist UAT ejecutado por negocio o representante.`
  - `Resultado aprobado o plan de corrección definido.`

### Gate 7

- Nombre: Release
- Resumen: Seguridad baseline, deploy controlado y trazabilidad.
- Roles:
  - `devops`
  - `security`
- Archivos requeridos:
  - `security/security-checklist.md`
  - `security/security-report.md`
  - `traceability/matriz-trazabilidad.md`
- Globs requeridos:
- Checks humanos:
  - `Seguridad baseline aprobada.`
  - `Deploy QA y producción controlado.`
  - `Matriz de trazabilidad actualizada.`
