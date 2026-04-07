# Playbook — Producto (PO / PM / SM fusionados)

*Gate 1 · Perfil: `factory/agents/profiles/product.md` · Prompt: `factory/agents/prompts/product.md`*

## Propósito
Convertir una idea o necesidad de negocio en especificación ejecutable (PRD + RF + RNF) que permita a todos los agentes posteriores trabajar sin ambigüedad ni bloqueos.

---

## Entradas requeridas
- Descripción de idea/problema en cualquier formato (tolerar caos: notas, conversación, doc)
- Contexto: usuario objetivo, dolor que resuelve, restricciones conocidas
- Objetivo del ciclo semanal

---

## Salidas obligatorias
| Archivo | Contenido mínimo |
|---------|-----------------|
| `docs/00-prd.md` | Problema, usuarios, alcance, KPI, supuestos |
| `docs/01-requisitos-funcionales.md` | RF numerados con criterios GIVEN/WHEN/THEN |
| `docs/02-requisitos-no-funcionales.md` | RNF con valores medibles |

---

## Cómo escribir el PRD (estructura mínima)

```
## 1. Problema
¿Qué dolor resuelve? ¿Para quién? ¿Por qué ahora y no después?
(2-4 párrafos. Si no cabe en 4 párrafos, el problema no está claro.)

## 2. Usuarios objetivo
Roles concretos con contexto: no persona completa, sí lo necesario para
decisiones de diseño y priorización.

## 3. Alcance del ciclo
Qué ENTRA en esta iteración (lista).
Qué queda explícitamente FUERA (lista). Obligatorio.

## 4. KPI de validación
Métrica medible en ≤7 días. Ejemplos válidos:
  ✅ "20 usuarios completan flujo A sin soporte"
  ✅ "Tasa de error en registro < 2%"
  ❌ "El producto funciona bien"
  ❌ "Los usuarios están satisfechos"

## 5. Supuestos y restricciones
Lo que se da por hecho. Límites no negociables.
```

---

## Cómo escribir RF

**Formato:** `RF-XXX: [sujeto] puede [acción] para [propósito]`

**Criterio de aceptación — GIVEN/WHEN/THEN obligatorio:**
```
GIVEN  [estado inicial / precondición]
WHEN   [acción del usuario o evento]
THEN   [resultado observable y verificable]
```

**Reglas de granularidad:**
- Si un RF necesita >2 pantallas para cumplirse → dividirlo
- Un RF = un comportamiento verificable = un test de aceptación
- RF-XXX debe tener ID único permanente (no renumerar aunque se eliminen)

**Anti-patrones de RF:**
| ❌ Mal | ✅ Bien |
|--------|---------|
| "El sistema debe ser fácil de usar" | RNF de usabilidad, no RF |
| "El login debe usar JWT" | ADR de arquitectura, no RF |
| "Gestión de usuarios" | Demasiado amplio: dividir en RF-001 crear, RF-002 editar... |
| Sin criterio de aceptación | Siempre GIVEN/WHEN/THEN |

---

## Cómo escribir RNF

**Siempre con valor medible:**

| Categoría | Ejemplo válido |
|-----------|---------------|
| Rendimiento | TTI < 2s en 4G · LCP < 2.5s · P95 API < 300ms |
| Disponibilidad | 99.5% uptime en horario hábil |
| Seguridad | Sin OWASP Top 10 críticos antes de release |
| Accesibilidad | WCAG 2.1 AA mínimo en flujos principales |
| Escalabilidad | Soportar 100 usuarios concurrentes sin degradación |

---

## Decisiones autónomas vs escalación

| Situación | Acción del agente |
|-----------|------------------|
| RF ambiguo pero inferible del PRD | Inferir + dejar `⚠️ SUPUESTO:` en el archivo |
| Contradicción entre dos RF | Escalar con propuesta de resolución explícita |
| Alcance se expande durante escritura | Agregar a sección "fuera de alcance" automáticamente |
| KPI no definible sin más datos | Proponer 2 opciones con pros/contras y escalar |
| Requisito técnico aparece en doc de negocio | Mover a RNF o ADR; dejar nota en origen |
| Fundador no disponible para aprobar | Marcar G1 como "Listo para revisión", no "Aprobado" |

---

## Checklist de calidad — Gate 1
- [ ] PRD tiene problema, usuarios, alcance explícito (dentro/fuera), KPI medible y supuestos
- [ ] Cada RF tiene número único (RF-XXX) y al menos 1 GIVEN/WHEN/THEN verificable
- [ ] RNF tiene valores medibles en: rendimiento, seguridad, accesibilidad
- [ ] No hay RF sin trazabilidad a objetivo del PRD
- [ ] Alcance "fuera del ciclo" está documentado explícitamente
- [ ] Fundador revisó y aprobó (o está marcado "Listo para revisión" con razón)
