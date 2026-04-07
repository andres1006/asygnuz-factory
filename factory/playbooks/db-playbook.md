# Playbook — Base de Datos (DB-first)

*Gate 3 · Perfil: `factory/agents/profiles/db.md` · Prompt: `factory/agents/prompts/db.md`*

## Propósito
Diseñar el modelo de datos antes de escribir código de aplicación. Un esquema sólido desde el inicio evita migraciones dolorosas y da claridad a backend/frontend sobre los datos disponibles.

---

## Entradas requeridas
- Gate 1 ✅ (RF/RNF — entidades y relaciones implícitas)
- Gate 2 ✅ (flujos — qué datos necesita cada pantalla)
- `architecture/solution-architecture.md` (límites de módulos)

---

## Salidas obligatorias
| Archivo | Contenido |
|---------|-----------|
| `db/data-model.md` | ERD + descripción de entidades + decisiones |
| `db/migrations/` | Migraciones iniciales (Drizzle o Prisma) |

---

## Principios DB-first

1. **Diseñar el schema antes del código** — el schema es el contrato entre DB, backend y frontend.
2. **Nunca modificar producción sin migración versionada** — cada cambio = nuevo archivo en `migrations/`.
3. **Normalizar primero, desnormalizar solo con evidencia** — documentar en ADR si se desnormaliza.
4. **Nombres consistentes** — `snake_case` para columnas, `plural` para tablas, `id` como PK por defecto.

---

## Convenciones de schema (Drizzle ORM — Neon/PostgreSQL)

```typescript
// Columnas estándar en TODAS las tablas
id         uuid PRIMARY KEY DEFAULT gen_random_uuid()
created_at timestamp with time zone DEFAULT now() NOT NULL
updated_at timestamp with time zone DEFAULT now() NOT NULL

// Soft delete (preferido sobre hard delete)
deleted_at timestamp with time zone  -- null = activo

// Relaciones: FK explícita con onDelete behavior documentado
user_id    uuid REFERENCES users(id) ON DELETE CASCADE
```

**Tipos preferidos:**
| Dato | Tipo PostgreSQL |
|------|----------------|
| ID único | `uuid` (gen_random_uuid()) |
| Texto corto (<255) | `varchar(n)` con límite explícito |
| Texto largo | `text` |
| Dinero | `numeric(10,2)` — NUNCA `float` |
| Booleano | `boolean` |
| Fechas | `timestamp with time zone` |
| JSON flexible | `jsonb` (índice GIN si se consulta internamente) |
| Enum acotado | `pgEnum` de Drizzle |

---

## Índices — reglas mínimas
- PK siempre indexada (automático)
- FK usada en JOIN frecuente → índice explícito
- Columnas en WHERE frecuente con alta cardinalidad → índice
- Columnas en ORDER BY para paginación → índice compuesto si hay filtro previo
- No indexar columnas de baja cardinalidad (boolean, status con 2-3 valores) sin análisis documentado

---

## Estrategia de migraciones

```bash
# Tras cambio de schema: generar migración
npx drizzle-kit generate

# Aplicar en desarrollo
npx drizzle-kit migrate
```

**En CI/CD:** migrar automáticamente en deploy via `package.json`:
```json
"postbuild": "tsx db/migrate.ts"
```

Regla: **nunca editar una migración ya aplicada** — crear una nueva.

---

## Datos de seed
- `db/seed.ts` para datos de desarrollo/testing
- Seed idempotente: ejecutable múltiples veces sin duplicar
- Datos de seed nunca en producción salvo catálogos estáticos

---

## Decisiones autónomas vs escalación

| Situación | Acción del agente |
|-----------|-----------------|
| Entidad implícita en RF pero no explícita | Crear con `⚠️ SUPUESTO:` en data-model.md |
| Relación N:M compleja o cardinalidad dudosa | Documentar tabla de unión + escalar |
| Necesidad de JSON/JSONB | ADR justificando por qué no se normaliza |
| Optimización de performance sin datos reales | Diseñar para correctitud; anotar punto de revisión |
| Conflicto de nombres con otra entidad | Escalar al agente de arquitectura |

---

## Checklist de calidad — Gate 3 (parte DB)
- [ ] `db/data-model.md` tiene ERD + descripción de cada entidad y relación
- [ ] Todas las tablas tienen `id`, `created_at`, `updated_at`
- [ ] FKs definidas con `onDelete` behavior explícito
- [ ] Índices necesarios documentados
- [ ] Migración inicial generada en `db/migrations/`
- [ ] Seed de desarrollo en `db/seed.ts`
- [ ] Sin `float` para dinero; sin `varchar` sin límite deliberado
