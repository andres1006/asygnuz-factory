# Especificación mínima de tareas (fábrica)

Para que desarrollo y prueba sean eficientes, toda tarea desglosada debe incluir:

## Campos obligatorios
1. **Título** — verbo + resultado (ej. “Implementar login con email”).
2. **Contexto / para qué** — vínculo al objetivo de producto o HU (una frase).
3. **Quién** — rol responsable (PO consolidado, diseño, dev, QA, etc.) o agente si aplica.
4. **Alcance** — qué entra y qué queda fuera (evita deriva).
5. **Criterios de aceptación** — lista comprobable (idealmente GIVEN/WHEN/THEN o checklist).
6. **Definición de prueba** — qué evidencia cierra la tarea (test automatizado, checklist manual, captura, etc.).

## Opcionales pero recomendados
- Dependencias o bloqueos
- Riesgos o supuestos
- Enlace a documento de diseño o ADR si aplica

## Relación con el template
En cada proyecto, las tareas viven donde defina el equipo (issues, `tasks/`, etc.); este estándar es la **barra de calidad** que la fábrica exige para aprobar avance entre fases.
