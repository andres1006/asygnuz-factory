# Modelo operativo Asygnuz

## Principios

1. **No vibe coding:** cambios complejos requieren propuesta, tareas y criterios
   verificables antes de implementación.
2. **Documentación como activo:** decisiones, investigaciones y entregables
   viven en Markdown versionado; una tarea solo apunta al documento.
3. **Datos sobre opiniones:** cada campaña, producto o experimento debe tener
   KPI explícito.
4. **Automatización radical:** si se repite más de tres veces, se convierte en
   script, workflow o agente.
5. **Profit first:** priorizar flujo de caja, margen y aprendizaje accionable
   sobre vanity metrics.

## Cadencia

| Ritmo | Objetivo | Artefacto |
|-------|----------|-----------|
| Semanal | Planificación y demo/review | `operations/weekly-runbook.md` o status del proyecto |
| Por cambio | Propuesta → tareas → ejecución → cierre | `factory/changes/<id>/` o equivalente del producto |
| Por campaña | Brief → contenido → aprobación → publicación → reporte | `campaigns/`, `content/`, `reports/` |
| Pre-release | QA, dependencies, security, devops | gates 5–7 |

## Flujo Services-to-SaaS

1. Servicios consultivos financian aprendizaje y cash flow.
2. Labs convierte aprendizajes repetibles en sistemas y herramientas.
3. Growth distribuye herramientas como lead magnets.
4. Los leads alimentan servicios high-ticket o productos SaaS.
5. La utilidad financia nuevos assets.

## Uso de OpenHands / OpenClaw

- OpenHands ejecuta trabajo dentro del repo, abre PRs y produce artefactos.
- OpenClaw/ClawFlows puede disparar automatizaciones recurrentes o de canal.
- Ningún sistema externo publica, envía mensajes, contacta leads, gasta dinero o
  despliega producción sin aprobación explícita.
