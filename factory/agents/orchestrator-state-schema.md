# Schema de Estado del Orchestrator — `.factory/state.json` v2

Define la estructura del archivo `.factory/state.json` en el repo de cada producto cuando se usa el Orchestrator con agentes paralelos.

---

## Schema v2 completo

```json
{
  "version": 2,
  "product": "nombre-del-producto",
  "current_gate": 1,
  "updated_at": "2026-04-07T10:00:00Z",
  "note": "Fuente de verdad machine-readable. Mantener sincronizado con tasks/gate-status.md",

  "gates": {
    "G1": { "status": "completed", "completed_at": "2026-04-07T09:00:00Z", "approved_by": "Andrés" },
    "G2": { "status": "pending" },
    "G3": {
      "status": "in_progress",
      "workers": {
        "architecture": {
          "status": "running",
          "worktree": "agent/gate-3-architecture-20260407-1000",
          "started_at": "2026-04-07T10:00:00Z"
        },
        "db": {
          "status": "completed",
          "worktree": "agent/gate-3-db-20260407-1000",
          "started_at": "2026-04-07T10:00:00Z",
          "completed_at": "2026-04-07T10:30:00Z",
          "merged": false
        }
      }
    },
    "G4": { "status": "pending" },
    "G5": { "status": "pending" },
    "G6": { "status": "pending" },
    "G7": { "status": "pending" }
  },

  "human_approval_pending": null,
  "blocked": null,

  "last_orchestrator_run": "2026-04-07T10:00:00Z"
}
```

---

## Valores de `status` por gate

| Valor | Significado |
|-------|-------------|
| `"pending"` | Aún no iniciado |
| `"in_progress"` | Workers activos |
| `"ready_for_review"` | Workers completaron, pendiente validación |
| `"completed"` | Gate aprobado (por humano o auto-aprobado) |
| `"blocked"` | Bloqueado esperando acción |

## Valores de `status` por worker

| Valor | Significado |
|-------|-------------|
| `"running"` | Worker activo en background |
| `"completed"` | Worker notificó completion |
| `"failed"` | Worker terminó con error |
| `"merged"` | Worktree ya integrado en rama base |

---

## Campo `human_approval_pending`

`null` cuando no hay aprobación pendiente. Objeto cuando sí:

```json
"human_approval_pending": {
  "gate": 3,
  "reason": "ADR-001 propone cambiar ORM de Drizzle a Prisma — requiere aprobación",
  "created_at": "2026-04-07T10:45:00Z",
  "proposal_file": "memory/adrs/ADR-001-orm-selection.md"
}
```

## Campo `blocked`

`null` cuando no hay bloqueo. Objeto cuando sí:

```json
"blocked": {
  "gate": 4,
  "worker": "backend",
  "reason": "Schema de DB necesita columna 'payment_status' para HU-003 — requiere agente DB",
  "created_at": "2026-04-07T11:00:00Z",
  "daily_file": "memory/daily/2026-04-07-backend.md"
}
```

---

## Migración desde v1

El schema v1 tenía solo:
```json
{ "version": 1, "product": "...", "current_gate": 1, "updated_at": null, "note": "..." }
```

El script `new-product.sh` genera v2 desde ahora. Los proyectos existentes pueden actualizarse manualmente añadiendo el campo `"version": 2` y el objeto `"gates"` con todos los gates en `"pending"`.
