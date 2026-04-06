# Arquitectura de la Fábrica

## Niveles
1. **Factory** — cerebro: estrategia (`strategy/`), gobierno, estándares, ADRs de fábrica, operación, playbooks, monitoreo, métricas y `changes/`.
2. **Template** — molde técnico-documental replicable por proyecto.
3. **Projects** — instancias operativas que ejecutan el template; **cada producto en su propio repositorio**. El repo wrapper de la fábrica puede tener `projects/<nombre>/` solo como clone local, **excluido del git del wrapper** para no anidar historiales.

## Carpetas del cerebro (Factory)
- `strategy/`: visión y objetivos estratégicos (el “por qué” y el “hacia dónde”).
- `governance/`: reglas, RACI, gates, DoD.
- `standards/`: políticas técnicas transversales.
- `decisions/`: ADRs que afectan a toda la fábrica o al template base.
- `operations/`, `playbooks/`, `monitoring/`, `metrics/`, `changes/`: operación, roles, visibilidad y evolución.

## Flujo de información
- Cada proyecto registra decisiones y resultados (memoria en proyecto).
- Factory consolida métricas y hallazgos.
- Factory decide mejoras y abre cambios al template; las decisiones globales quedan en `decisions/` cuando aplica.
- Template evoluciona versionado (v1, v1.1, v1.2...).

## Convenciones
- Todo proyecto debe poder auditarse por documentos y evidencias.
- Toda mejora de template debe pasar por change con justificación.

## Referencias
- Modelo de negocio e incubadora: `../strategy/incubator-model.md`
- Índice completo de `factory/`: `../INDEX.md`
- Visión y objetivos: `../strategy/vision.md`
