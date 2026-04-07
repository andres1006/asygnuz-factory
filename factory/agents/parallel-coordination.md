# Protocolo de Coordinación Paralela

Define cómo el Orchestrator gestiona workers paralelos (Patrón B): worktree isolation, distribución de trabajo, merge, y escritura consolidada de estado.

---

## Principio fundamental

> **Un solo writer por archivo crítico.** El Orchestrator es el único que escribe en `gate-status.md`, `current-gate.txt`, y `.factory/state.json`. Los workers escriben exclusivamente en sus directorios de dominio y en daily files con sufijo de rol.

---

## 1. Distribución de trabajo antes del spawn

### Gate 3: Architecture + DB

El Orchestrator NO necesita distribuir trabajo: cada worker tiene dominios disjuntos.

**Instrucción adicional para el DB worker:**
> Lee `architecture/solution-architecture.md` cuando exista (puede estar siendo escrito en paralelo). Si no tiene contenido aún, procede con lo que inferís de RF y flujos; el agente de arquitectura sincronizará después.

**Instrucción adicional para el Architecture worker:**
> Al definir módulos y límites, documenta en `architecture/solution-architecture.md` la sección "Para DB" con las entidades principales que inferís. El DB worker la leerá como punto de partida.

### Gate 4: Backend + Frontend

El Orchestrator distribuye las HUs explícitamente antes de spawnear.

**Algoritmo de distribución:**
```
Para cada HU en tasks/hu/:
  Si el criterio THEN menciona "en la DB" / "se persiste" / "se crea/actualiza/elimina en":
    → Backend
  Si el criterio THEN menciona "el usuario ve" / "se muestra" / "aparece":
    → Frontend
  Si ambos criterios están presentes (HU mixta):
    → Backend primero (fase 1), Frontend en fase 2 con el Server Action ya disponible
```

**El Orchestrator pasa al prompt de cada worker la lista explícita de HUs asignadas:**
```
WORKER BACKEND — HUs asignadas: HU-001, HU-003, HU-005
WORKER FRONTEND — HUs asignadas: HU-002, HU-004
HUs mixtas (fase 2 tras backend): HU-006
```

### Gate 7: DevOps + Security

**Instrucción adicional para el Security worker:**
```
Ejecutá los pasos en este orden:
1. pnpm audit (no depende de deployment.md)
2. Búsqueda de secretos en código (no depende de deployment.md)
3. Checklist de auth/validación (no depende de deployment.md)
4. Verificar devops/deployment.md (esperar 5 min si no tiene contenido aún, luego continuar con nota)
5. Headers de seguridad (requiere ver configuración de entorno en deployment.md)
```

---

## 2. Spawn con worktree isolation

```
# El Orchestrator spawna con estos parámetros:

Worker A:
  type: "general-purpose"
  isolation: "worktree"           ← branch temporal: agent/gate-N-rol-A-{timestamp}
  run_in_background: true
  prompt: [prompt del rol + contexto explícito de PRODUCT_ROOT + HUs asignadas]

Worker B:
  type: "general-purpose"
  isolation: "worktree"           ← branch temporal: agent/gate-N-rol-B-{timestamp}
  run_in_background: true
  prompt: [prompt del rol + contexto explícito de PRODUCT_ROOT + HUs asignadas]
```

El Orchestrator registra los nombres de worktree en `.factory/state.json` (ver schema en `orchestrator-state-schema.md`).

---

## 3. Durante la ejecución paralela

El Orchestrator NO interfiere con los workers mientras están activos. No hace polling ni lee sus archivos en progreso.

**El Orchestrator sí monitorea:**
- Si llega notificación de completion de Worker A antes de B → registrar en state.json pero no hacer merge todavía
- Si llega notificación de error de algún worker → activar Patrón D (Blocker Escalation)
- Si pasan más de 30 minutos sin completion de algún worker → activar Patrón D

---

## 4. Protocolo de merge post-paralelo

Una vez que **ambos** workers notifican completion:

### Paso 1: Verificar artefactos mínimos por worker

```bash
# Verificar que cada worker produjo sus artefactos esperados
# Gate 3:
ls architecture/solution-architecture.md   # Worker A
ls db/data-model.md db/migrations/          # Worker B

# Gate 4 (por worktree de cada worker):
ls apps/web/lib/actions/*.ts               # Worker Backend
ls apps/web/components/features/           # Worker Frontend
```

Si algún artefacto falta → activar Patrón D antes de continuar.

### Paso 2: Merge Worker A → rama base

```bash
git merge --no-ff worktree-branch-A -m "merge: gate-N architecture work"
```

**Si hay conflictos:**
- En archivos de dominio del Worker A → Worker A tiene razón, aplicar su versión
- En archivos fuera de su dominio → escalar al humano con `git diff --merge` del archivo en conflicto
- En `gate-status.md` → NO debería pasar (solo el Orchestrator lo escribe); si pasa, restaurar desde la versión del Orchestrator

### Paso 3: Merge Worker B → rama base (ya con Worker A integrado)

```bash
git merge --no-ff worktree-branch-B -m "merge: gate-N db work"
```

**Regla de conflicto:** Worker B solo puede tener conflictos en sus archivos de dominio. Si hay conflicto en directorio de Worker A → error de ownership, escalar.

### Paso 4: Validación integral post-merge

```bash
./scripts/check-gate.sh N     # verifica artefactos mínimos del gate
pnpm lint                      # solo si Gate 4 (código nuevo)
pnpm test                      # solo si Gate 4 (código nuevo)
```

### Paso 5: Consolidar daily files

El Orchestrator lee:
- `memory/daily/YYYY-MM-DD-{rol-A}.md`
- `memory/daily/YYYY-MM-DD-{rol-B}.md`

Y escribe `memory/daily/YYYY-MM-DD-orchestrator.md` con el resumen consolidado del gate.

### Paso 6: Actualizar estado (UN SOLO WRITE)

```markdown
<!-- gate-status.md actualización -->
| G3 | Arquitectura + DB | Listo para revisión | YYYY-MM-DD | — | arch ✅ db ✅ · check-gate pasa |
```

```json
// .factory/state.json actualización
{
  "current_gate": 3,
  "updated_at": "YYYY-MM-DDTHH:mm:ssZ",
  "gates": {
    "G3": {
      "status": "ready_for_review",
      "workers": {
        "architecture": { "status": "completed", "merged": true },
        "db": { "status": "completed", "merged": true }
      }
    }
  }
}
```

---

## 5. Reglas de conflicto de archivos — referencia rápida

| Conflicto | Resolución |
|-----------|-----------|
| Worker A y B tocan el mismo archivo de dominio de A | Worker A tiene razón |
| Worker A toca archivo de dominio de B | Error de ownership → escalar |
| Ambos tocan archivo no asignado explícitamente | Escalar al humano con diff |
| Conflicto en `gate-status.md` | Restaurar versión del Orchestrator (es el único owner) |
| Conflicto en `memory/daily/` | No debería pasar (sufijo de rol por worker) |
| Conflicto en `tasks/hu/HU-XXX.md` | Verificar sección: si es "Evidencias" de HU diferente → merge trivial |

---

## 6. Nota de operación actual (POC → transición a autonomía)

En la fase POC actual, el **humano puede actuar como Orchestrator manual** usando este documento como checklist. La arquitectura está diseñada para ser adoptada gradualmente:

1. **Fase 1 (ahora):** Humano lee gate-status.md → elige patrón → spawna agentes manualmente usando los prompts
2. **Fase 2:** Orchestrator prompt se usa en Claude Code para semi-automatizar (humano aprueba gates críticos)
3. **Fase 3:** Orchestrator totalmente autónomo excepto en gates con aprobación humana obligatoria (G1, G2, G6, G7)
