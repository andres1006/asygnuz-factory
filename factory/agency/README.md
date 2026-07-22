# Agency

`factory/agency/` empaqueta áreas componibles como servicios operativos. La
primera agencia definida es `autonomous-marketing/`, diseñada para trabajar con
OpenHands como operador autónomo seguro.

## Principios

- La agencia usa áreas (`factory/areas/`) en vez de duplicar roles.
- OpenHands produce artefactos, reportes y PRs.
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
