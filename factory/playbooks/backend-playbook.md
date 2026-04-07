# Playbook — Backend

*Gate 4 · Perfil: `factory/agents/profiles/backend.md` · Prompt: `factory/agents/prompts/backend.md`*

## Propósito
Implementar APIs, lógica de dominio y persistencia con calidad, trazabilidad a HU/RF, y tests que permitan a QA verificar sin fricción.

---

## Entradas requeridas
- Gate 3 ✅ (`db/data-model.md` + migraciones, `architecture/solution-architecture.md`)
- HU en `tasks/hu/` con criterios GIVEN/WHEN/THEN
- ADRs relevantes en `memory/adrs/`

---

## Salidas obligatorias
- Código en el repo del producto + PRs enlazados a HU
- Tests (unit + integration) por Server Action / Route Handler
- Sin merge a `main`/`qa` sin CI verde

---

## Patrones obligatorios del stack

### Server Actions — estructura estándar

```typescript
// lib/actions/[dominio].ts
'use server'

import { z } from 'zod'
import { db } from '@/lib/db'
import { revalidatePath } from 'next/cache'
import { getCurrentUser } from '@/lib/auth'

const CreateItemSchema = z.object({
  name: z.string().min(1).max(100),
  description: z.string().optional(),
})

export type ActionResult<T = void> =
  | { success: true; data: T }
  | { success: false; error: string; fieldErrors?: Record<string, string[]> }

export async function createItem(
  formData: FormData
): Promise<ActionResult<{ id: string }>> {
  // 1. Autenticación
  const user = await getCurrentUser()
  if (!user) return { success: false, error: 'No autorizado' }

  // 2. Validación
  const parsed = CreateItemSchema.safeParse(Object.fromEntries(formData))
  if (!parsed.success) {
    return {
      success: false,
      error: 'Datos inválidos',
      fieldErrors: parsed.error.flatten().fieldErrors,
    }
  }

  // 3. Lógica de negocio / persistencia
  try {
    const [item] = await db.insert(items).values({
      ...parsed.data,
      userId: user.id,
    }).returning({ id: items.id })

    // 4. Revalidar cache
    revalidatePath('/items')
    return { success: true, data: { id: item.id } }
  } catch (err) {
    console.error('[createItem]', err)
    return { success: false, error: 'Error interno. Intenta de nuevo.' }
  }
}
```

### Reglas de Server Actions
- Siempre `'use server'` en el archivo, no en la función individual
- Retornar `ActionResult<T>` — nunca lanzar excepciones al cliente
- Validar con Zod antes de tocar la DB
- Verificar autenticación y autorización antes de validar
- `revalidatePath` o `revalidateTag` después de mutación exitosa
- Un archivo por dominio (`actions/users.ts`, `actions/items.ts`)

### Route Handlers — cuándo y cómo

```typescript
// app/api/webhooks/stripe/route.ts
import { headers } from 'next/headers'
import { NextResponse } from 'next/server'

export async function POST(req: Request) {
  const body = await req.text()
  const sig = headers().get('stripe-signature')!

  try {
    const event = stripe.webhooks.constructEvent(body, sig, process.env.STRIPE_WEBHOOK_SECRET!)
    // procesar evento...
    return NextResponse.json({ received: true })
  } catch (err) {
    return NextResponse.json({ error: 'Invalid signature' }, { status: 400 })
  }
}
```

---

## Validación con Zod — reglas

```typescript
// lib/validations/item.ts — schemas reutilizables
export const CreateItemSchema = z.object({
  name: z.string().min(1, 'Nombre requerido').max(100),
  price: z.number().positive('Precio debe ser positivo'),
  category: z.enum(['A', 'B', 'C']),
})

// En el agente: inferir tipo del schema, no duplicar interfaces
export type CreateItemInput = z.infer<typeof CreateItemSchema>
```

- Un archivo por dominio en `lib/validations/`
- Mensaje de error en español si la UI es en español
- Nunca confiar en validación solo del cliente; siempre validar en servidor

---

## Manejo de errores

| Tipo de error | Acción |
|--------------|--------|
| Error de validación | Retornar `fieldErrors` mapeados al campo |
| No autenticado | Retornar 401 (Route Handler) o `{ success: false, error: 'No autorizado' }` |
| No autorizado (permiso) | Retornar 403 o error claro |
| Error de DB (constraint) | Capturar, loggear, retornar mensaje genérico al cliente |
| Error inesperado | `console.error` + retornar mensaje genérico (nunca stack trace al cliente) |

---

## Tests de backend

```typescript
// __tests__/actions/createItem.test.ts
import { describe, it, expect, vi, beforeEach } from 'vitest'
import { createItem } from '@/lib/actions/items'

describe('createItem', () => {
  it('retorna error si el usuario no está autenticado', async () => {
    vi.mock('@/lib/auth', () => ({ getCurrentUser: () => null }))
    const fd = new FormData()
    fd.set('name', 'Test')
    const result = await createItem(fd)
    expect(result.success).toBe(false)
    expect(result.error).toContain('autorizado')
  })

  it('valida campos requeridos', async () => {
    // ...
  })

  it('crea el item con datos válidos', async () => {
    // usar DB de test (Neon branch o SQLite en memoria)
    // ...
  })
})
```

**Cobertura mínima por Server Action / Route Handler:**
- Happy path (éxito)
- Input inválido / faltante
- Sin autenticación
- Sin autorización (si aplica)

---

## Reglas de PR

- Un PR por HU o sub-tarea técnica
- Título: `feat(dominio): descripción` | `fix(dominio): descripción`
- Descripción enlaza HU: `Closes tasks/hu/HU-XXX.md`
- Sin `console.log` sin ticket; sin `TODO` sin issue
- Diff < 400 líneas salvo generación automática justificada

---

## Decisiones autónomas vs escalación

| Situación | Acción |
|-----------|--------|
| Lógica de negocio ambigua en HU | Implementar la interpretación más simple + nota en PR |
| Schema de DB necesita cambiar | Escalar al agente de DB antes de modificar |
| Necesidad de endpoint externo sin ADR | Crear ADR borrador + escalar |
| Timeout / performance sin benchmarks | Implementar correctamente, anotar para QA |
| Secreto o credencial nueva | Nunca hardcodear; agregar a `.env.example` y documentar |

---

## Checklist de calidad — Gate 4 (backend)
- [ ] Cada Server Action / Route Handler tiene tests (happy path + error cases)
- [ ] Validación Zod en todas las entradas de usuario
- [ ] Autenticación verificada antes de cualquier operación
- [ ] Errores no exponen stack traces al cliente
- [ ] PRs enlazados a HU con descripción
- [ ] Sin secrets hardcodeados; nuevas vars en `.env.example`
- [ ] CI verde antes de solicitar revisión
