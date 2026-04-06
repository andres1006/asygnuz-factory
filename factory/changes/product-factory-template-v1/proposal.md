# Propuesta: product-factory-template-v1

## Contexto
Se requiere una plantilla replicable para crear proyectos de software con velocidad semanal, trazabilidad completa y calidad robusta. El usuario definió un flujo híbrido orientado a entrega de valor semanal.

## Objetivo
Crear una plantilla de repositorio lista para clonar por iniciativa, con estructura, plantillas de documentos y gates de calidad.

## Alcance v1 (Etapa A)
1. Estructura de carpetas estándar por proyecto.
2. Plantillas robustas para: PRD, requerimientos funcionales/no funcionales, arquitectura, base de datos, HU, QA, UAT, seguridad y DevOps.
3. Matriz de trazabilidad (PRD -> HU -> código -> test -> UAT).
4. Memoria por proyecto (diaria + decisiones + ADRs).
5. Guía de operación semanal.
6. Checklist de Definition of Done por fase.

## Fuera de alcance (Etapa A)
- Orquestación MCP/RAG/Agentic real (Etapa B/C).
- Integraciones automáticas con herramientas externas.

## Riesgos
- Sobredocumentación si no se usa disciplina semanal.
- Variación entre proyectos si no se respeta el estándar de carpetas.

## Mitigaciones
- README con flujo operativo claro.
- Plantillas obligatorias mínimas por gate.
- Checklists de calidad y trazabilidad.
