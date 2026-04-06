# Decisiones de la fábrica (ADRs)

Registro de decisiones **transversales** (afectan a varios proyectos o al template base), no las de un producto concreto (esas viven en el repo del producto, p. ej. `memory/adrs/`, o en el ejemplo bajo `template/`).

Para el alcance de la POC (productos propios, repos por producto fuera del wrapper), ver `../strategy/incubator-model.md`.

## Cuándo escribir un ADR aquí
- Cambio de stack o herramienta por defecto.
- Política de calidad, seguridad o release que aplica a todos.
- Reorganización de `factory/` o del `template/`.

## Formato
Usar `ADR-NNN-titulo-corto.md` con la plantilla `ADR-000-template.md`.

## Relación con `changes/`
Un ADR puede **informar** un change bajo `changes/` o nacer de un change aprobado. Mantener referencias cruzadas cuando aplique.
