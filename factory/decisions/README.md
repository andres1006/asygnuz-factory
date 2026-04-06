# Decisiones de la fábrica (ADRs)

Registro de decisiones **transversales** (afectan a varios proyectos o al template base), no las de un producto concreto (esas viven en `projects/.../memory/adrs/` o en el template de ejemplo).

## Cuándo escribir un ADR aquí
- Cambio de stack o herramienta por defecto.
- Política de calidad, seguridad o release que aplica a todos.
- Reorganización de `factory/` o del `template/`.

## Formato
Usar `ADR-NNN-titulo-corto.md` con la plantilla `ADR-000-template.md`.

## Relación con `changes/`
Un ADR puede **informar** un change bajo `changes/` o nacer de un change aprobado. Mantener referencias cruzadas cuando aplique.
