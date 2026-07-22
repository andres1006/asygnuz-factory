# OpenHands operating guide

## Rol

OpenHands actúa como operador autónomo de agencia. Lee la composición del
cliente, produce artefactos versionados y escala decisiones cuando la política
lo exige.

## Orden de lectura por cliente

1. `agency-composition.yaml`
2. `docs/marketing/00-marketing-brief.md`
3. `docs/marketing/strategy.md` si existe
4. `content/calendar.md` si existe
5. `approvals/`
6. `reports/`

## Instrucciones base

- No publiques contenido externo sin aprobación explícita.
- No lances campañas pagas.
- No envíes emails masivos.
- No contactes leads/clientes.
- No inventes claims, precios, certificaciones, logos, testimonios ni casos de éxito.
- Cambios web deben ir por PR.
- Todo contenido público debe tener evidencia de revisión o quedar como draft.
- Si faltan datos, registra supuestos en el artefacto.

## Workflows útiles

Ver también `workflows.md`.

### Crear campaña

```text
Leer agency-composition.yaml y docs/marketing/.
Crear campaigns/<slug>/campaign-brief.md.
Crear content/calendar.md.
Crear drafts por canal.
No publicar.
Crear approvals/<slug>-approval-request.md.
```

### Crear landing page

```text
Leer campaign brief y marketing brief.
Crear content/landing-pages/<slug>.md.
Si existe app web, implementar en branch y abrir PR.
No hacer deploy producción.
```

### Reporte semanal

```text
Leer exports disponibles en reports/raw/.
Generar reports/weekly-marketing-report.md.
Incluir aprendizajes, riesgos, próximos experimentos y decisiones requeridas.
```

## Skills

OpenHands puede aprovechar skills si están disponibles en el cliente o wrapper:

- Diseño/frontend: `frontend-design`, `web-design-guidelines`.
- Producto: `prd`.
- Deploy: `deploy-to-vercel` solo con aprobación.
- Commit: `git-commit`.
- Testing web: `webapp-testing`.

Las skills cubren ejecución especializada; no cubren por sí solas política,
handoffs ni aprobación. Eso vive en `factory/agency/` y `factory/areas/`.
