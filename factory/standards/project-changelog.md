# Estándar: changelog de definición y construcción del producto

## Objetivo

Un único archivo en cada repo de producto que registre **en orden cronológico inverso** los hitos de **definición** (intake, PRD, gates, cambios de alcance) y de **construcción** (releases internas, entregas semanales, pivots técnicos relevantes para el negocio).

Sirve como **línea de tiempo legible** para humanos y agentes sin sustituir el detalle de `memory/project-memory.md` ni el diario en `memory/daily/`.

## Ubicación canónica

```text
docs/project-changelog.md
```

No confundir con un `CHANGELOG.md` en la raíz del repo si existe uno orientado a **versiones semver del paquete** (npm, librerías): ese archivo puede seguir convenciones de releases de código; **`docs/project-changelog.md`** es el **historial del producto** (negocio + entrega).

## Qué registrar

| Tipo | Ejemplos |
|------|----------|
| **Definición** | Cierre de secciones de intake, PRD aprobado, cambio de MVP, decisión de alcance |
| **Gates** | Paso de G1→G2, bloqueos y desbloqueos relevantes |
| **Construcción** | Primera demo, UAT cerrada, release a producción, hito de sprint con impacto en alcance |
| **Riesgo / alcance** | Recortes, ampliaciones, dependencias externas resueltas |

Qué **no** duplicar aquí de forma exhaustiva: cada decisión con contexto largo → `memory/project-memory.md` o ADR; trabajo del día → `memory/daily/`.

## Formato recomendado

- Secciones por fecha **`## YYYY-MM-DD`** (más reciente arriba).
- Viñetas breves; enlace a archivo o PR cuando aporte (`docs/00-prd.md`, `tasks/gate-status.md`).
- Opcional: etiqueta en la viñeta `[Definición]`, `[Construcción]`, `[Gate]`, `[Alcance]`.

## Relación con el template

La plantilla vive en `template/docs/project-changelog.md`. Al crear un producto desde el template, el archivo ya existe con instrucciones y una entrada inicial de arranque.
