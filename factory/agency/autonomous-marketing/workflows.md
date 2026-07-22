# Workflows de agencia

Workflows reutilizables para OpenHands. Cada workflow produce artefactos y
termina en aprobación, PR o reporte.

## 1. Intake → Marketing brief

Entrada:

- notas del cliente;
- `docs/intake/` si existe.

Salida:

- `docs/marketing/00-marketing-brief.md`
- lista de supuestos;
- preguntas abiertas.

Autonomía: permitido.

## 2. Brief → Estrategia

Entrada:

- `docs/marketing/00-marketing-brief.md`

Salida:

- `docs/marketing/strategy.md`
- `docs/marketing/positioning.md`
- `docs/marketing/kpi-plan.md`

Autonomía: draft permitido; aprobación requerida para estrategia final.

## 3. Estrategia → Campaña

Entrada:

- estrategia aprobada;
- objetivo de campaña.

Salida:

- `campaigns/<slug>/campaign-brief.md`
- `content/calendar.md`
- `approvals/<slug>-approval-request.md`

Autonomía: permitido hasta solicitud de aprobación.

## 4. Campaña → Contenido multicanal

Entrada:

- `campaigns/<slug>/campaign-brief.md`

Salida:

- `content/social/*.md`
- `content/email/*.md`
- `content/blog/*.md`
- `content/ads/*.md`
- `content/landing-pages/*.md`

Autonomía: drafts permitidos; publicación/envío/lanzamiento requiere aprobación.

## 5. Landing page → Desarrollo

Entrada:

- `content/landing-pages/<slug>.md`
- `docs/marketing/00-marketing-brief.md`

Salida:

- PR con cambios web si el repo tiene app;
- checklist de revisión UX/copy;
- no deploy producción.

Skills útiles:

- `frontend-design`
- `web-design-guidelines`
- `webapp-testing`
- `git-commit`
- `deploy-to-vercel` solo con aprobación.

## 6. Analytics → Reporte semanal

Entrada:

- exports en `reports/raw/`;
- métricas manuales si no hay conectores.

Salida:

- `reports/weekly-marketing-report.md`
- aprendizajes;
- próximos experimentos;
- decisiones requeridas.

Autonomía: permitido si usa datos provistos.

## 7. Reporte → Backlog de experimentos

Entrada:

- reporte semanal;
- resultados de campaña.

Salida:

- `campaigns/experiments-backlog.md`
- priorización por impacto/esfuerzo;
- riesgos y dependencias.

Autonomía: permitido; cambios de presupuesto requieren aprobación.
