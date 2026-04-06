# POC-factory

Repositorio **wrapper** de la empresa/fábrica: gobierno, template y documentación común. **Cada producto tiene su propio repositorio**; los clones locales van en `projects/` y **no se versionan aquí** (ver `projects/README.md` y `.gitignore`).

## Estructura

1) `factory/` → cerebro: estrategia (incl. modelo incubadora), gobierno, estándares, decisiones, monitoreo, métricas (ver `factory/README.md`).
2) `template/` → plantilla replicable para arrancar un producto.
3) `projects/` → solo espacio local para repos de producto (ignorado por git en este wrapper).

## Modelo de negocio (POC → escala)
- **Ahora**: productos propios, validación rápida, intake en Markdown (con tolerancia a caos), diseño vía MCP según se conecte.
- **Meta**: monetizar y replicar el mismo modo de trabajo con **clientes en producción**.

## Flujo recomendado
- Leer `factory/strategy/incubator-model.md` para roles fusionados, aprobaciones y MCP por demanda.
- Mantener y mejorar estándar en `factory/`.
- Crear repo del producto aparte; clonar en `projects/<nombre-proyecto>` y opcionalmente partir de `template/`.
- Retroalimentar mejoras hacia `template/` vía `factory/changes/`.
