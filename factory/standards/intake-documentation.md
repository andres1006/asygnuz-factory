# Estándar: intake de negocio / producto (`docs/intake/`)

## Objetivo

Misma **estructura de fuentes de contexto** en todos los proyectos generados desde el template: agentes y humanos saben **dónde** está cada tipo de información antes del PRD formal.

## Ubicación canónica

En el repo de cada producto:

```text
docs/intake/
  README.md
  00-indice-y-alcance.md
  01-contexto-y-vision.md
  …
  08-anexos.md
```

Definición archivo por archivo: ver `template/docs/intake/README.md` en el wrapper.

## Reglas

1. **Nombres fijos** `00`–`08`: no renombrar por proyecto salvo decisión de fábrica (cambio de estándar).
2. **Intake** alimenta **`docs/00-prd.md`** y RF/RNF; no reemplaza el Gate 1 formal hasta consolidación explícita.
3. **Un monolito histórico** (si existe) debe referenciarse desde `00-indice-y-alcance.md` y planificarse su migración a `01–08` o a `08-anexos.md`.

## Relación con agentes

- Prompt de producto: leer `docs/intake/00` y `03` antes de proponer cambios al PRD.
- Contratos de handoff: el output formal sigue siendo `docs/00-prd.md` y siguientes según `factory/agents/handoff-contracts.md`.
