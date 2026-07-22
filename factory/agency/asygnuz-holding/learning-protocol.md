# Learning protocol

Adaptación segura del protocolo histórico de “instintos”.

## Objetivo

Convertir correcciones humanas, errores repetidos e insights operativos en
mejoras versionables de la fábrica.

## Qué capturar

- Decisiones que cambian cómo trabajamos.
- Errores repetidos de agentes.
- Gaps de handoff.
- Automatizaciones candidatas.
- Riesgos o supuestos que aparecieron en ejecución.

## Qué no capturar

- Secretos.
- Tokens.
- Credenciales.
- Conversaciones privadas no necesarias.
- Datos personales sin propósito operativo.

## Destinos

| Tipo de aprendizaje | Destino |
|---------------------|---------|
| Política estable | `factory/standards/` o `factory/governance/` |
| Cambio operativo | `factory/operations/` |
| Nuevo handoff | `factory/agents/handoff-contracts.md` |
| Mejora de área | `factory/areas/<area>/area.yaml` |
| Workflow repetible | `factory/agency/*/workflows.md` |
| Decisión estructural | `factory/decisions/ADR-*.md` |

## Cadencia

- Revisar aprendizajes al cierre de cambios relevantes.
- Consolidar semanalmente si hay suficiente señal.
- No actualizar reglas por una sola ocurrencia débil; documentar como candidato.
