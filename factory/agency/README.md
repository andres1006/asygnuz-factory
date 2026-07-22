# Agency

`factory/agency/` empaqueta áreas componibles como servicios operativos.
Incluye `autonomous-marketing/` para operación de marketing con OpenHands y
`asygnuz-holding/` para adaptar la estructura histórica OpenClaw/Jarvis a la
fábrica.

## Principios

- La agencia usa áreas (`factory/areas/`) en vez de duplicar roles.
- OpenHands produce artefactos, reportes y PRs.
- OpenClaw/ClawFlows puede ejecutar automatizaciones recurrentes si están
  documentadas y aprobadas.
- Publicar, gastar dinero, contactar leads o cambiar producción requiere
  aprobación explícita.
- Skills y workflows aceleran ejecución, pero no reemplazan gates ni políticas.

## Relación con áreas

```text
agency/autonomous-marketing
  usa: areas/marketing
  puede consumir: areas/product, areas/design, areas/development, areas/qa
  escala a: areas/security, areas/devops cuando hay deploy/publicación
```
