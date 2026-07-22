# MOC — Evolución del template

## Fuentes

- [[factory/operations/template-evolution-process|Proceso de evolución del template]]
- [[factory/changes/product-factory-template-v1/proposal|Propuesta template v1]]
- [[factory/changes/product-factory-template-v1/tasks|Tasks template v1]]
- [[factory/decisions/README|ADRs de fábrica]]
- [[factory/decisions/ADR-000-template|ADR template]]

## Relación Factory → Template

- Factory define políticas, gates, estándares y agentes.
- Areas definen capacidades componibles por cliente.
- Agency empaqueta áreas como servicios operativos.
- Template instancia estructura, scripts, carpetas y checklists.
- Projects consumen el template y devuelven aprendizajes vía `factory/changes/`.

## Reportes derivados

- [[factory/intelligence/codegraph/reports/inventory|Inventario]]
- [[factory/intelligence/codegraph/reports/markdown-links|Markdown links]]
