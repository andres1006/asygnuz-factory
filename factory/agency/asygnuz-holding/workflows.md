# Workflows Asygnuz

Workflows adaptados desde la operación OpenClaw/Jarvis. Son contratos
versionables; la implementación puede vivir en OpenHands, OpenClaw/ClawFlows,
scripts o agentes.

## 1. OpenSpec-lite para cambios complejos

Entrada: feature o cambio complejo.

Salida:

- `factory/changes/<change-id>/proposal.md`
- `factory/changes/<change-id>/tasks.md`
- specs con GIVEN/WHEN/THEN cuando aplique.

Regla: no implementar antes de que exista propuesta y checklist.

## 2. Engineering as Marketing

Entrada: problema de mercado y oferta.

Salida:

- idea de herramienta gratuita;
- landing/copy;
- tracking;
- campaña de distribución;
- reporte de leads/conversión.

Áreas: marketing, sales, product, development, data.

## 3. Lead magnet factory

Entrada: ICP + dolor + promesa.

Salida:

- `campaigns/<slug>/campaign-brief.md`
- `content/landing-pages/<slug>.md`
- PR web si hay producto/app;
- plan de tracking;
- secuencia de nurturing.

## 4. Weekly business review

Entrada:

- métricas de marketing;
- pipeline de ventas;
- estado de productos;
- finanzas.

Salida:

- `reports/weekly-business-review.md`
- decisiones requeridas;
- bloqueos;
- próximos experimentos.

## 5. Agent performance review

Entrada:

- entregables de agentes;
- PRs;
- fallos de handoff;
- feedback humano.

Salida:

- `agent-ops/agent-evaluations.md`
- mejoras de prompts;
- propuestas de nuevos workflows o skills.

## 6. Memory / learning distillation

Entrada:

- notas diarias;
- correcciones humanas;
- incidentes;
- aprendizajes repetibles.

Salida:

- `memory/lessons/*.md` o equivalente del proyecto;
- propuestas de actualización a playbooks, areas o workflows.

Regla: no versionar secretos ni contexto personal sensible.
