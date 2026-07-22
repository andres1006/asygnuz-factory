# Política de aprobación

## Autónomo permitido

- Crear drafts.
- Proponer estrategia.
- Generar calendarios.
- Auditar SEO.
- Analizar datos provistos.
- Crear reportes.
- Preparar PRs.
- Actualizar documentación.

## Aprobación humana requerida

| Acción | Motivo |
|--------|--------|
| Publicar en redes | Sale al público y afecta marca. |
| Enviar emails masivos | Contacta usuarios/leads. |
| Lanzar ads | Gasta presupuesto. |
| Cambiar presupuesto ads | Impacto financiero. |
| Contactar leads/clientes | Riesgo comercial/reputacional. |
| Hacer claims sensibles | Riesgo legal/compliance. |
| Usar testimonios/logos | Riesgo legal/marca. |
| Deploy producción | Riesgo operativo. |
| Cambiar secretos/integraciones | Riesgo de seguridad. |

## Formato de aprobación

Cada aprobación debe dejar evidencia:

```text
approvals/YYYY-MM-DD-<decision>.md
```

Contenido mínimo:

```md
# Aprobación — <decisión>

Estado: aprobado | rechazado | aprobado con cambios
Fecha:
Responsable humano:
Artefactos revisados:
Condiciones:
```
