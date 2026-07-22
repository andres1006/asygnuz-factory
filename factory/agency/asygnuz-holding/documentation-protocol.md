# Documentation protocol

Adaptación de la política histórica “anti-mediocre”.

## Regla central

Las tareas no son el lugar principal para conocimiento. Las tareas deben enlazar
a documentos persistentes.

## Calidad mínima

Un documento relevante debe incluir:

- contexto;
- objetivo;
- alcance;
- supuestos;
- edge cases o failure modes;
- decisiones;
- próximos pasos;
- criterios de validación.

## Prohibido

- Listas superficiales sin contexto.
- Entregables que solo viven en comentarios o chats.
- Claims externos sin fuente o sin marcar como supuesto.
- Marcar una tarea como terminada sin evidencia verificable.

## Dónde documentar

| Caso | Ruta |
|------|------|
| Producto | `docs/` del proyecto |
| Campaña | `campaigns/` y `content/` |
| Arquitectura | `architecture/` y ADRs |
| Seguridad | `security/` |
| Operación de fábrica | `factory/operations/` |
| Decisiones globales | `factory/decisions/` |
