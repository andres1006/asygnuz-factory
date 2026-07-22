# Agencia autónoma de marketing

Modelo operativo para usar OpenHands como agencia de marketing autónoma con
controles. El objetivo es maximizar producción y análisis autónomo sin delegar
acciones irreversibles o externas sin aprobación humana.

## Flujo

```text
Intake cliente
  ↓
Marketing brief
  ↓
Estrategia/campaña
  ↓
Producción de drafts
  ↓
Revisión marca/legal
  ↓
Aprobación humana
  ↓
Publicación o PR
  ↓
Reporte y aprendizaje
```

## Artefactos por cliente

```text
agency-composition.yaml
docs/marketing/
content/
campaigns/
approvals/
reports/
```

## Reglas de autonomía

OpenHands puede crear drafts, análisis, calendarios, reportes, propuestas,
briefs y PRs. OpenHands no debe publicar, enviar campañas, lanzar ads, gastar
presupuesto, contactar leads ni cambiar producción sin aprobación explícita.

## Archivos clave

- `services.md` — servicios que ofrece la agencia.
- `agents.md` — agentes/roles operativos.
- `approval-policy.md` — matriz de autonomía y aprobación.
- `quality-gates.md` — gates M1–M7.
- `client-composition-template.yaml` — plantilla por cliente.
- `openhands.md` — instrucciones operativas para OpenHands.
- `workflows.md` — workflows reutilizables de intake, campaña, contenido, landing y reporting.
