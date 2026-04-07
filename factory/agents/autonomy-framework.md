# Framework de Autonomía de Agentes

Define qué puede decidir un agente **solo** (verde), qué requiere **propuesta + aprobación humana** (amarillo), y qué está **bloqueado hasta aprobación explícita** (rojo). Aplica a todos los roles.

---

## Principio central

> El agente maximiza avance dentro de su gate. Escala cuando la decisión tiene impacto fuera de su gate, afecta a otro rol, o cambia algo que el humano comprometió explícitamente.

Escalar NO es una falla. Escalar sin propuesta SÍ es una falla.

---

## Semáforo de autonomía

### 🟢 Verde — el agente decide y actúa solo

| Decisión | Condición |
|----------|-----------|
| Interpretar RF ambiguo con la interpretación más restrictiva | Dejar nota `⚠️ ASUMIDO:` en el archivo |
| Elegir patrón de implementación dentro del stack de referencia | Alineado a `engineering-standards.md` |
| Crear componente cuando no hay en shadcn | Documentar razón en PR |
| Agregar tests adicionales más allá del mínimo | Siempre bienvenido |
| Corregir bug de tipado o lint en código que toca | Parte del PR principal |
| Agregar manejo de error faltante (estado vacío, estado carga) | Parte del trabajo esperado |
| Actualizar `memory/daily/` y `gate-status.md` | Obligatorio al cerrar sesión |
| Agregar índice de DB para consulta obvia | Con nota en data-model.md |
| Refactorizar código propio del PR para legibilidad | Sin cambiar comportamiento |

---

### 🟡 Amarillo — el agente propone, el humano aprueba

El agente prepara la propuesta completa (alternativas, pros, contras) y espera aprobación antes de implementar.

| Decisión | Por qué escalar |
|----------|----------------|
| Cambiar el stack de referencia (ORM, auth, hosting) | Impacta toda la fábrica |
| Modificar schema de DB existente (renombrar, eliminar columna) | Riesgo de pérdida de datos |
| Ampliar el alcance del ciclo (nuevos RF) | El humano comprometió el alcance |
| Aprobar excepción de cobertura < 90% | Política de calidad explícita |
| Aceptar defecto Alto/Crítico sin corregir | Riesgo de negocio |
| Cambiar la estructura de carpetas del template | Afecta a todos los productos |
| Integrar servicio externo nuevo sin ADR | Impacto en seguridad/costo |
| Mover tarea de un gate a otro | Puede afectar el compromiso del ciclo |
| Crear ADR que contradice uno anterior | Requiere decisión consciente |

**Formato de propuesta:**
```markdown
## Propuesta: [título]
**Contexto:** por qué surge esta decisión.
**Opciones:**
  A. [descripción] — Pros: X — Contras: Y
  B. [descripción] — Pros: X — Contras: Y
**Recomendación del agente:** [opción] porque [razón].
**Impacto si no se decide hoy:** [consecuencia].
```

---

### 🔴 Rojo — bloqueado hasta aprobación explícita

El agente para. Documenta el bloqueo en `tasks/gate-status.md` y en `memory/daily/`. No intenta workarounds.

| Situación | Por qué no proceder |
|-----------|-------------------|
| Deploy a producción sin UAT aprobado | Riesgo directo al usuario final |
| Merge a `main` sin CI verde | Puede romper producción |
| Aplicar migración destructiva sin backup confirmado | Pérdida de datos irreversible |
| Continuar si hay secreto expuesto sin rotarlo | Riesgo de seguridad activo |
| Avanzar al siguiente gate sin aprobación del actual | Rompe el flujo de calidad |
| Crear usuario o datos en producción desde un agente | Solo el humano opera prod directamente |

---

## Por gate — resumen ejecutivo

| Gate | El agente avanza solo cuando | Escala cuando |
|------|------------------------------|---------------|
| G1 Producto | Puede inferir del contexto dado | RF se contradicen, alcance cambia, KPI indefinible |
| G2 Diseño | Herramienta disponible, RF claros | RF no tiene flujo posible, blocker de accesibilidad grave |
| G3 Arquitectura | Stack de referencia aplica | Cambio de stack, integración nueva, RNF no alcanzable |
| G3 DB | Entidades claras en RF/flujos | Relación de cardinalidad dudosa, schema cambia contrato de backend |
| G4 Dev | HU clara, schema y arquitectura definidos | Schema necesita cambiar, lógica de negocio ambigua en HU |
| G5 QA | Cobertura ≥ 90%, defectos menores | Defecto Alto/Crítico, cobertura < 90% sin justificación |
| G6 UAT | Checklist claro, entorno disponible | Entorno falla, RF ambiguo en ejecución, GO CONDICIONAL |
| G7 DevOps | CI verde, UAT aprobado, migrations probadas | Migration falla, deploy falla, secreto en código |
| G7 Security | Hallazgos Bajos/Medios | Hallazgo Alto/Crítico, secreto expuesto |

---

## Protocolo de bloqueo

Cuando el agente llega a un 🔴 o no puede proceder:

```markdown
<!-- En tasks/gate-status.md -->
| G4 | Desarrollo | **BLOQUEADO** | YYYY-MM-DD | — | Esperando: [descripción exacta del bloqueo] |

<!-- En memory/daily/YYYY-MM-DD.md -->
## YYYY-MM-DD — Agente [Rol] — BLOQUEADO
**Bloqueo:** [descripción exacta]
**Necesito de ti:** [acción específica que debe tomar el humano]
**Impacto:** [qué se desbloquea cuando se resuelva]
```

---

## Protocolo de entrega entre agentes (handoff)

Al terminar un gate y pasar al siguiente rol:

1. Verificar con `./scripts/check-gate.sh N`
2. Actualizar `tasks/gate-status.md` → "Listo para revisión" o "Aprobado"
3. Escribir en `memory/daily/YYYY-MM-DD.md` qué produjo este gate y qué lee el siguiente
4. El siguiente agente lee el artefacto de handoff definido en `factory/agents/handoff-contracts.md`
5. No asumir que el siguiente agente tiene el contexto de esta sesión — escribir para alguien nuevo

---

## Regla de oro para ambigüedad

> Cuando no sés si podés decidir solo: **hacé la propuesta más pequeña y segura**, documentala como `⚠️ ASUMIDO:` y avanzá. Es mejor terminar el ciclo con supuestos documentados que bloquearse esperando respuesta.

La excepción son los casos 🔴 — ahí siempre se para.
