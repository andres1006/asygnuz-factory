# Inteligencia derivada

Esta capa contiene análisis, mapas y reportes generados a partir de la fuente
canónica de `factory/`, `template/` y, cuando aplique, `projects/`.

Regla: nada en `intelligence/` reemplaza documentos normativos. Si un reporte
detecta una inconsistencia, la corrección debe hacerse en la fuente canónica
correspondiente (`governance/`, `standards/`, `agents/`, `template/`, etc.).

## Componentes

- `codegraph/` — grafo documental/técnico derivado para mapear relaciones,
  referencias, agentes, gates y drift.

## Flujo recomendado

1. Actualizar documentos canónicos.
2. Ejecutar `./scripts/check-factory-docs.sh`.
3. Ejecutar `./scripts/generate-codegraph-report.sh`.
4. Revisar reportes en `factory/intelligence/codegraph/reports/`.
