# Playbook — UAT (User Acceptance Testing)

*Gate 6 · Perfil: `factory/agents/profiles/uat.md` · Prompt: `factory/agents/prompts/uat.md`*

## Propósito
Validar que el producto cumple los criterios de negocio definidos en el PRD y RF, desde la perspectiva del usuario final (o su representante — el fundador en POC). La aprobación de UAT es el go/no-go para release.

---

## Entradas requeridas
- Gate 5 ✅ (QA completado sin defectos bloqueantes)
- `docs/00-prd.md` + `docs/01-requisitos-funcionales.md` (fuente de verdad de lo que se comprometió)
- `uat/uat-checklist.md` preparado (por agente UAT o QA)

---

## Salidas obligatorias
| Archivo | Contenido |
|---------|-----------|
| `uat/uat-checklist.md` | Checklist ejecutado con resultado por ítem |
| `uat/uat-results-YYYY-MM-DD.md` | Resultado detallado + decisión go/no-go |

---

## Cómo preparar el checklist UAT

El checklist se construye a partir de los RF + criterios GIVEN/WHEN/THEN. Cada RF debe tener al menos un escenario UAT.

```markdown
## UAT Checklist — [nombre-producto] — Semana XX

### RF-001: El usuario puede registrarse con email

**Escenario A (happy path)**
- DADO: usuario no registrado
- CUANDO: completa el formulario con email válido y contraseña ≥8 chars
- ENTONCES: recibe email de confirmación y es redirigido al onboarding
- Resultado: [ ] PASS  [ ] FAIL
- Notas:

**Escenario B (email ya registrado)**
- DADO: usuario con email ya en el sistema
- CUANDO: intenta registrarse con el mismo email
- ENTONCES: ve mensaje de error claro con opción de login
- Resultado: [ ] PASS  [ ] FAIL
- Notas:
```

---

## Cómo ejecutar UAT

**Entorno:** siempre en el entorno de QA (rama `qa` en Vercel), nunca en producción.

**Datos de prueba:** usar datos realistas pero ficticios. Preparar estado inicial antes de ejecutar.

**Proceso:**
1. Leer el RF y entender la intención de negocio
2. Ejecutar el escenario como lo haría un usuario real (sin atajos técnicos)
3. Documentar el resultado con evidencia (screenshot / descripción exacta del comportamiento)
4. Si FAIL: describir exactamente qué pasó vs qué debería pasar, con pasos reproducibles

---

## Clasificación de resultados UAT

| Resultado | Criterio | Acción |
|-----------|----------|--------|
| **PASS** | Comportamiento exactamente como el RF lo define | Continuar |
| **PASS con nota** | Funciona pero con UX mejorable (no bloquea negocio) | Documentar para próximo ciclo |
| **FAIL no bloqueante** | RF cumplido parcialmente; flujo alternativo resuelve | Registrar + decidir si bloquea release |
| **FAIL bloqueante** | RF no cumplido en happy path o pérdida de datos | Bloquear release; crear tarea para fix |

---

## Decisión go/no-go

```markdown
## Decisión UAT — YYYY-MM-DD

**Aprobado por:** [nombre]
**Decisión:** GO ✅ | NO GO ❌ | GO CONDICIONAL ⚠️

**Condiciones (si aplica):**
- [lista de condiciones para release o fix antes de release]

**RFs validados:** X / Y total
**Defectos bloqueantes abiertos:** N
**Defectos no bloqueantes documentados:** M
```

**Go condicional:** se puede hacer release si los defectos abiertos son todos de severidad baja/media y hay plan documentado para el próximo ciclo.

---

## Decisiones autónomas vs escalación

| Situación | Acción |
|-----------|--------|
| RF ambiguo durante UAT | Escalar al agente de Producto para clarificación |
| Comportamiento diferente al RF pero que "funciona" | Documentar diferencia; escalar para decisión |
| Defecto encontrado que QA no detectó | Reportar en `qa/test-plan.md` para agregar test |
| Entorno de QA no disponible | Escalar; no hacer UAT en producción |

---

## Checklist de calidad — Gate 6
- [ ] `uat/uat-checklist.md` ejecutado con resultado para cada RF
- [ ] Todos los RF tienen al menos 1 escenario UAT ejecutado
- [ ] Defectos bloqueantes = 0 (o con plan explícito aprobado)
- [ ] `uat/uat-results-YYYY-MM-DD.md` con decisión go/no-go firmada
- [ ] Defectos no bloqueantes documentados con severidad y plan
