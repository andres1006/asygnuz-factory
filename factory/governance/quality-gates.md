# Quality Gates

## Gate 1: Producto
Criterio:
- PRD completo
- RF y RNF con criterios GIVEN/WHEN/THEN
- KPI de validación semanal definido

## Gate 2: Diseño
Criterio:
- Flujos de usuario mapeados a RF
- Wireframes base disponibles

## Gate 3: Arquitectura + DB-first
Criterio:
- Arquitectura aprobada
- Modelo de datos y migraciones iniciales
- ADRs críticos registrados

## Gate 4: Desarrollo
Criterio:
- HU implementadas con evidencia en PRs
- Convenciones SOLID/Clean Code revisadas

## Gate 5: QA
Criterio:
- Unit/integration/e2e ejecutados
- Cobertura global >= 90% (o excepción explícita aprobada)

## Gate 6: UAT
Criterio:
- Checklist UAT ejecutado
- Resultado aprobado o plan de corrección definido

## Gate 7: Release
Criterio:
- Seguridad baseline aprobada
- Deploy QA y producción controlado
- Matriz de trazabilidad actualizada
