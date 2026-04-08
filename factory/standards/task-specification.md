# Especificación mínima de tareas (fábrica)
Toda tarea del factory y de los proyectos administrados debe seguir **SDD (Spec-Driven Development)** usando **`gentle-ai`** como herramienta base de control de specs y tareas.

Para que desarrollo y prueba sean eficientes, toda tarea desglosada debe incluir:

## Campos obligatorios
1. **Título** — verbo + resultado (ej. “Implementar login con email”).
2. **Contexto / para qué** — vínculo al objetivo de producto o HU (una frase).
3. **Quién** — rol responsable (PO consolidado, diseño, dev, QA, etc.) o agente si aplica.
4. **Alcance** — qué entra y qué queda fuera (evita deriva).
5. **Criterios de aceptación** — lista comprobable (idealmente GIVEN/WHEN/THEN o checklist).
6. **Definición de prueba** — qué evidencia cierra la tarea (test automatizado, checklist manual, captura, etc.).
7. **ID de cambio SDD** — identificador único del cambio (ej. `CHG-2026-04-08-auth-login`).
8. **Trazabilidad SDD** — enlaces al paquete de cambio en `specs/changes/<ID>/` (`spec.md`, `design.md`, `tasks.md`, `verify.md`) y al índice `tasks/spec-index.md`.

## Opcionales pero recomendados
- Dependencias o bloqueos
- Riesgos o supuestos
- Enlace a documento de diseño o ADR si aplica

## Relación con el template
En cada proyecto, las tareas viven donde defina el equipo (issues, `tasks/`, etc.); este estándar es la **barra de calidad** que la fábrica exige para aprobar avance entre fases.
Además, cada proyecto debe mantener:
- `.factory/sdd-control.md` (estado de bootstrap SDD con `gentle-ai`)
- `specs/README.md` y `specs/changes/<ID>/...` (artefactos de cambio)
- `tasks/spec-index.md` (registro maestro de cambios y estado)
