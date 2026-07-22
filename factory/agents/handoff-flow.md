# Flujo de handoffs (cadena)

Orden lógico alineado a `factory/playbooks/roles-and-handoffs.md`:

```text
Marketing → Producto → Diseño → Arquitectura → DB → Backend / Frontend → QA → UAT → DevOps → Security → Release
```

Notas:
- **Marketing** entrega el brief de mensaje antes (o en paralelo temprano) de cerrar **Gate 1**; Producto **depende** de ese artefacto para alinear alcance, naming y claims con el mercado.
- **Backend** y **Frontend** pueden trabajar en paralelo tras arquitectura/DB según el proyecto.
- Cada handoff debe dejar **evidencia** en el repo del producto (docs, diseño, PRs, tests) según `factory/standards/task-specification.md`.
- Gates globales: `factory/governance/quality-gates.md`.
