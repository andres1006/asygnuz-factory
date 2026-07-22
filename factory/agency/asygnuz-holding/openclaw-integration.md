# OpenClaw / ClawFlows integration

OpenClaw se usa como capa de automatización y ejecución recurrente. Factory
mantiene la política, contratos, gates y estructura canónica.

## Separación de responsabilidades

| Capa | Responsabilidad |
|------|-----------------|
| `factory/areas/` | Capacidades y ownership. |
| `factory/agency/` | Modelos operativos y workflows versionados. |
| OpenHands | Ejecución de repo, PRs, artefactos y validaciones. |
| OpenClaw / ClawFlows | Automatizaciones recurrentes, comandos y flujos externos. |

## Reglas para ClawFlows

- No escribir directamente en `workflows/enabled/`; debe contener symlinks.
- Crear workflows con CLI, no copiando archivos a mano.
- Los workflows deben ser genéricos y descubrir contexto en runtime.
- Workflows que publican, envían mensajes, contactan leads, gastan dinero o
  despliegan producción requieren aprobación explícita.
- Si un workflow existe fuera del repo, documentar su contrato aquí antes de
  depender de él en Factory.

## Workflows detectados históricamente

| Workflow | Estado observado | Uso recomendado |
|----------|------------------|-----------------|
| `claudia-daily-telegram` | custom disponible; enabled no confirmado | Mantener fuera de Factory salvo que se formalice como cliente/canal. |
| `update-clawflows` | mencionado en AGENTS histórico; no confirmado en enabled | Usar solo como mantenimiento de OpenClaw, no como gate de producto. |

## Comando de sincronización recomendado

```bash
clawflows list
clawflows sync-agent
```

Si el CLI se bloquea o no responde, no asumir que los workflows están activos.
Registrar el drift y resolverlo fuera de los gates de producto.
