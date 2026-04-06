# UAT — Checklist

## Enfoque por fases

### Fase 1 (ahora): revisar y refinar el proceso

- El **UAT es manual** y sirve para **calibrar** criterios, plantillas y tiempos con una persona de negocio (p. ej. fundador).
- Objetivo: dejar **claro qué se acepta**, cómo se documenta el resultado y cómo se relaciona con `tasks/gate-status.md` y el Gate 6.
- Marcar aquí los hallazgos de proceso (plantilla, demasiado/largo, etc.) para iterar en `memory/project-memory.md`.

### Evolución: UAT autónomo

- Meta: el UAT **corre solo** de forma repetible (scripts, checklist enlazado a RF, entorno QA estable en Vercel rama `qa`, pruebas exploratorias guiadas o automatizadas donde aplique).
- Requisitos típicos antes de “autonomía”: criterios de aceptación **GIVEN/WHEN/THEN** en RF, despliegue QA estable, datos de prueba documentados, y (opcional) pruebas e2e críticas en CI.

---

## Flujo principal

- [ ] Caso 1 validado
- [ ] Caso 2 validado

## Flujos alternos y errores

- [ ] Error handling validado
- [ ] Mensajes de usuario validados

## Aceptación final

- [ ] Aprobado por negocio
- [ ] Requiere ajustes

## Notas de sesión (Fase 1)

- Fecha:
- Ambiente probado (QA URL):
- Cambios al proceso sugeridos:
