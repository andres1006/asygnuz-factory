# Codegraph de la fábrica

Codegraph es la capa de mapeo derivado de la fábrica. Su objetivo es responder:

- qué documentos existen;
- qué documentos se enlazan entre sí;
- qué roles participan en cada gate;
- qué perfiles, prompts y playbooks forman el contrato operativo por agente;
- dónde puede haber drift entre documentación, template y automatización.

## Fuente de verdad

El grafo se deriva de:

- `factory/README.md` e `factory/INDEX.md`
- `factory/governance/quality-gates.md`
- `factory/governance/quality-gates.yaml`
- `factory/agents/`
- `factory/playbooks/`
- `template/`

Los reportes generados no son normativos.

## Generación

Desde la raíz del wrapper:

```bash
./scripts/generate-codegraph-report.sh
```

Salida principal:

- `reports/inventory.md`
- `reports/markdown-links.md`
- `reports/agent-role-map.md`
- `reports/gate-map.md`
- `reports/drift-checks.md`
- `reports/README.md`

## Lectura recomendada

1. `reports/drift-checks.md` — inconsistencias accionables.
2. `reports/gate-map.md` — gate → roles → archivos requeridos.
3. `reports/agent-role-map.md` — rol → perfil → prompt → playbook.
4. `reports/markdown-links.md` — enlaces internos detectados.
