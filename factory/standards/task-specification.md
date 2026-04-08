# Especificación mínima de tareas (fábrica)

Toda tarea en proyectos de la fábrica debe ser **trazable y comprobable**. Hay **dos niveles**; el segundo es opcional.

## Nivel base (obligatorio en todos los proyectos)

Aplica a productos que siguen el template con `docs/`, `tasks/`, gates y —si aplica— `tasks/hu/`. **No requiere** `gentle-ai`, ni `specs/changes/`, ni SDD.

### Campos obligatorios
1. **Título** — verbo + resultado (ej. “Implementar login con email”).
2. **Contexto / para qué** — vínculo al objetivo de producto o HU (una frase).
3. **Quién** — rol responsable (PO, diseño, dev, QA, etc.) o agente si aplica.
4. **Alcance** — qué entra y qué queda fuera (evita deriva).
5. **Criterios de aceptación** — lista comprobable (idealmente GIVEN/WHEN/THEN o checklist).
6. **Definición de prueba** — qué evidencia cierra la tarea (test automatizado, checklist manual, captura, etc.).

### Opcionales pero recomendados
- Dependencias o bloqueos
- Riesgos o supuestos
- Enlace a ADR o diseño si aplica

### Relación con gates

Los gates se evalúan con **`factory/governance/quality-gates.md`**, artefactos en el repo del producto (PRD, RF, diseño, etc.) y **`./scripts/check-gate.sh`** donde aplique. **Un gate puede estar operable sin SDD** si se cumplen esos criterios.

---

## Nivel SDD opcional (gentle-ai)

**SDD (Spec-Driven Development)** con la herramienta **`gentle-ai`** es un **refuerzo opcional** para equipos que quieren paquetes de cambio versionados (`spec.md`, `design.md`, `tasks.md`, `verify.md`) y un índice de specs.

### Cuándo activarlo

- El equipo decide adoptarlo y lo registra con **ADR en el proyecto** o una línea explícita en **`memory/project-memory.md`** (“SDD activado desde [fecha]”).
- Hasta entonces, **no** se exigen los campos ni rutas SDD de abajo.

### Campos adicionales (solo si SDD está activo)

7. **ID de cambio SDD** — identificador único (ej. `CHG-2026-04-08-auth-login`).
8. **Trazabilidad SDD** — enlaces al paquete en `specs/changes/<ID>/` y a `tasks/spec-index.md` si existe.

### Artefactos típicos (solo si SDD está activo)

- `.factory/sdd-control.md` — estado del bootstrap con `gentle-ai` (si la herramienta lo usa).
- `specs/changes/<ID>/...` — spec, diseño, tareas, verificación por cambio.
- `tasks/spec-index.md` — registro maestro (si el equipo lo mantiene).

### Bootstrap sugerido (referencia)

1. `gentle-ai` instalado y en PATH (según documentación de la herramienta).
2. Inicialización del proyecto con el flujo que defina `gentle-ai` (ej. `/sdd-init` si aplica).
3. Actualizar registro de skills/contexto si el equipo lo usa.

---

## Relación con el template

Las tareas pueden vivir en `tasks/hu/`, issues del forjador, o SDD; el **nivel base** es la **barra mínima** de la fábrica. El **nivel SDD** suma rigor cuando el producto lo elige **sin bloquear** a quien trabaja solo con Markdown y gates.
