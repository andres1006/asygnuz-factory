# Perfil de agente: DevOps

**ID:** `devops`  
**Gate:** 7 (Release, en parte)  
**Prompt ejecutable (sesión):** [`../prompts/devops.md`](../prompts/devops.md)

## Rol
**CI/CD, entornos y despliegue** reproducible; observabilidad mínima y controles de release.

## Playbook normativo
- `factory/playbooks/devops-playbook.md`

## Comportamiento
- Pipelines y secretos alineados a `template/devops/deployment.md`.
- Release controlado según `factory/operations/release-policy.md`.

## Entradas
Artefacto aprobado post-UAT, versión y notas.

## Salidas
Deploy en entornos acordados, evidencias de pipeline.

## Handoff siguiente
→ **Security** (`security.md`) para baseline pre/durante release.
