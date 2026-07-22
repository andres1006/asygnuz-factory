# Area contract schema

Cada área define un `area.yaml` con esta forma.

```yaml
id: marketing
name: Marketing
status: active
description: Capacidad reusable.
roles:
  - marketing
gates:
  - 1
owns:
  - docs/marketing/00-marketing-brief.md
inputs:
  - docs/intake/
outputs:
  - docs/marketing/00-marketing-brief.md
handoffs:
  - to: product
    artifact: docs/marketing/00-marketing-brief.md
    purpose: Alimentar PRD y posicionamiento.
policies:
  autonomous:
    - draft_generation
  human_required:
    - public_publish
metrics:
  - message_consistency
references:
  profiles:
    - factory/agents/profiles/marketing.md
  prompts:
    - factory/agents/prompts/marketing.md
  playbooks:
    - factory/playbooks/marketing-playbook.md
```

## Reglas

- `id` debe coincidir con el nombre de la carpeta.
- Cada `role` debe existir en `factory/agents/profiles/` y
  `factory/agents/prompts/`, salvo excepciones documentadas.
- Cada `gate` debe existir en `factory/governance/quality-gates.yaml`.
- Los `handoffs.to` deben apuntar a otra área existente.
- `policies.human_required` debe incluir cualquier acción que publique,
  gaste dinero, contacte leads/clientes o modifique producción.
