# Patrones de Agent Teams

Referencia canónica para el Orchestrator. Define cuándo usar cada patrón, cuántas instancias, y cómo coordinar.

---

## Patrón A — Sequential Gate Runner

**Cuándo:** Gates con un solo rol (G1, G2, G5, G6).

```
Orchestrator
    └── spawn(worker-único, foreground)
            └── esperar completion
                    └── check-gate.sh N
                            ├── PASS → actualizar gate-status → decidir: auto-avanzar o pedir aprobación
                            └── FAIL → documentar qué falta → escalar a humano
```

| Gate | Rol único | Auto-avanza sin humano |
|------|-----------|----------------------|
| G1 | product | ❌ Siempre requiere aprobación humana |
| G2 | design | ❌ Siempre requiere aprobación humana |
| G5 | qa | ⚠️ Solo si cobertura ≥ 90% y 0 defectos Alto/Crítico |
| G6 | uat | ❌ Siempre requiere aprobación humana |

**Parámetros del spawn:**
```
type: "general-purpose"
isolation: (no requerido — el worker lee y escribe en su directorio de dominio)
run_in_background: false (foreground: el orchestrator espera)
prompt: contenido de factory/agents/prompts/<rol>.md + PRODUCT_ROOT + contexto de gate anterior
```

---

## Patrón B — Parallel Peer Workers

**Cuándo:** Gates con 2 roles con artefactos en directorios disjuntos (G3, G4, G7).

```
Orchestrator
    ├── spawn(worker-A, background, worktree-A)  ──→ [trabajo en paralelo]
    └── spawn(worker-B, background, worktree-B)  ──→ [trabajo en paralelo]
            ↓ ambos completan
    Orchestrator
        ├── merge worktree-A → rama base
        ├── merge worktree-B → rama base
        ├── check-gate.sh N
        └── actualizar gate-status (un solo write consolidado)
```

| Gate | Worker A | Worker B | ¿Auto-avanza? |
|------|----------|----------|---------------|
| G3 | architecture | db | ⚠️ Solo si check-gate 3 pasa y sin ADRs pendientes de aprobación |
| G4 | backend | frontend | ❌ Requiere aprobación humana (merge a main) |
| G7 | devops | security | ❌ Requiere aprobación humana (deploy a prod) |

**Parámetros del spawn (ambos workers):**
```
type: "general-purpose"
isolation: "worktree"
run_in_background: true
prompt: contenido de factory/agents/prompts/<rol>.md + PRODUCT_ROOT + distribución de HUs (G4) o instrucción de coordinación (G7)
```

**Regla de ownership de archivos (evita conflictos):**

| Gate | Worker A escribe | Worker B escribe | Archivo compartido |
|------|-----------------|-----------------|-------------------|
| G3 | `architecture/`, `memory/adrs/` | `db/`, `db/migrations/` | Solo lectura: `docs/`, `design/` |
| G4 | `apps/web/lib/actions/`, `apps/web/app/api/`, `__tests__/actions/` | `apps/web/components/`, `apps/web/app/(routes)/`, `__tests__/components/` | `tasks/hu/*.md` (lectura), `apps/web/types/` (backend crea, frontend importa) |
| G7 | `devops/deployment.md` | `security/security-*.md`, `traceability/` | Ninguno |

**Regla de daily files:** Workers escriben en `memory/daily/YYYY-MM-DD-{rol}.md` (con sufijo de rol). El Orchestrator consolida en `memory/daily/YYYY-MM-DD-orchestrator.md`. **Nunca dos workers escriben en el mismo daily file.**

---

## Patrón C — Review Satellite

**Cuándo:** Un artefacto crítico necesita revisión independiente. Se activa si:
- El humano lo solicita explícitamente
- El artefacto tiene ≥ 3 anotaciones `⚠️ SUPUESTO:` o `⚠️ ASUMIDO:`
- El gate anterior tuvo un bloqueo resuelto con workaround
- Post-G3: revisar arquitectura antes de spawnar G4

```
Orchestrator
    ├── spawn(worker-generador, foreground)   → produce artefacto
    └── spawn(reviewer, background, Explore)  → analiza artefacto vs criterios del gate
            ↓ reviewer completa
    Orchestrator
        ├── Si reviewer aprueba → continuar
        ├── Si reviewer encuentra issues menores → pasar feedback a worker + re-run acotado
        └── Si reviewer encuentra issues mayores → escalar a humano con diff estructurado
```

**Parámetros del reviewer:**
```
type: "Explore"  (solo lectura + análisis)
run_in_background: true
prompt: "Revisá [artefacto] contra los criterios del gate [N] en factory/governance/quality-gates.md
         y los criterios del playbook factory/playbooks/[rol]-playbook.md.
         Retorná: lista de issues encontrados (con severidad Alta/Media/Baja),
         lista de supuestos no verificados, y recomendación: Aprobar / Aprobar con cambios menores / Escalar.
         NO modifiques ningún archivo."
```

---

## Patrón D — Blocker Escalation Agent

**Cuándo:** El Orchestrator detecta condición 🔴 o 🟡 que requiere decisión humana.

```
Orchestrator detecta bloqueo
    └── spawn(escalation-agent, foreground, Plan)
            └── consolida: qué bloqueó, qué necesita el humano, opciones con pros/contras
                    └── Orchestrator presenta al humano en formato estructurado
                            └── PARAR y esperar input
```

**El Orchestrator NO spawna ningún worker mientras haya un bloqueo activo en `gate-status.md`.**

**Parámetros:**
```
type: "Plan"
run_in_background: false
prompt: "Consolidá el siguiente bloqueo en el pipeline:
         [descripción del bloqueo]
         Producí: (1) descripción clara del problema, (2) qué necesita exactamente el humano para desbloquearlo,
         (3) impacto de no desbloquear en las próximas 24h, (4) opciones si las hay."
```

---

## Tabla de selección rápida de patrón

| Condición | Patrón |
|-----------|--------|
| Gate con 1 rol | A |
| Gate 3, 4 o 7 | B |
| Artefacto con ≥3 supuestos o bloqueo previo resuelto | C (después de A o B) |
| Cualquier condición 🔴 o 🟡 del `autonomy-framework.md` | D |
| Artefacto requiere revisión independiente opcional | C |
