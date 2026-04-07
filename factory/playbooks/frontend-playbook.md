# Playbook — Frontend

*Gate 4 · Perfil: `factory/agents/profiles/frontend.md` · Prompt: `factory/agents/prompts/frontend.md`*

## Propósito
Implementar interfaces funcionales, accesibles y performantes alineadas a los flujos de diseño y conectadas a los Server Actions del backend.

---

## Entradas requeridas
- Gate 2 ✅ (flujos + wireframes)
- Gate 3 ✅ (arquitectura — estructura de módulos)
- Server Actions / Route Handlers disponibles del agente backend

---

## Salidas obligatorias
- Componentes implementados en `apps/web/components/features/`
- Páginas en `apps/web/app/`
- Tests de interacción para flujos críticos

---

## Decisión: RSC vs Client Component

```
Regla de oro: Server Component por defecto.
Convertir a Client ('use client') SOLO si necesitás:
  ✅ useState / useReducer
  ✅ useEffect / lifecycle hooks
  ✅ Event handlers del browser (onClick, onChange…)
  ✅ Librería de terceros que usa window/document
  ✅ Context providers de React

NUNCA 'use client' por:
  ❌ "Es más fácil"
  ❌ Hacer un fetch que podría hacerse en el servidor
  ❌ Usar una prop que podría pasarse desde RSC
```

**Patrón: empujar el límite cliente hacia las hojas del árbol:**
```
Page (RSC) → Layout (RSC) → DataList (RSC) → InteractiveButton ('use client')
                                            ↑ solo este componente es cliente
```

---

## Patrones de componentes

### Página con datos (RSC)
```tsx
// app/items/page.tsx
import { db } from '@/lib/db'
import { ItemList } from '@/components/features/items/item-list'

export default async function ItemsPage() {
  const items = await db.query.items.findMany({
    where: (t, { isNull }) => isNull(t.deletedAt),
    orderBy: (t, { desc }) => desc(t.createdAt),
  })

  return (
    <main>
      <h1>Items</h1>
      <ItemList items={items} />
    </main>
  )
}
```

### Formulario con Server Action
```tsx
'use client'
import { useActionState } from 'react'
import { createItem } from '@/lib/actions/items'
import { Button } from '@/components/ui/button'
import { Input } from '@/components/ui/input'

export function CreateItemForm() {
  const [state, action, isPending] = useActionState(createItem, null)

  return (
    <form action={action}>
      <Input name="name" placeholder="Nombre" required />
      {state?.fieldErrors?.name && (
        <p className="text-sm text-destructive">{state.fieldErrors.name[0]}</p>
      )}
      <Button type="submit" disabled={isPending}>
        {isPending ? 'Guardando…' : 'Guardar'}
      </Button>
      {state && !state.success && (
        <p className="text-sm text-destructive">{state.error}</p>
      )}
    </form>
  )
}
```

### Loading state obligatorio
```tsx
// app/items/loading.tsx — automático en App Router
import { Skeleton } from '@/components/ui/skeleton'

export default function Loading() {
  return (
    <div className="space-y-2">
      {Array.from({ length: 5 }).map((_, i) => (
        <Skeleton key={i} className="h-12 w-full" />
      ))}
    </div>
  )
}
```

### Error boundary obligatorio
```tsx
// app/items/error.tsx
'use client'
export default function Error({ error, reset }: { error: Error; reset: () => void }) {
  return (
    <div>
      <p>Algo salió mal: {error.message}</p>
      <button onClick={reset}>Reintentar</button>
    </div>
  )
}
```

### Estado vacío obligatorio
```tsx
// Siempre manejar listas vacías
{items.length === 0 ? (
  <EmptyState
    title="No hay items todavía"
    description="Crea tu primer item para comenzar."
    action={<CreateItemButton />}
  />
) : (
  <ItemList items={items} />
)}
```

---

## Accesibilidad — checklist por componente
- Botones tienen texto visible o `aria-label`
- Inputs tienen `<label>` asociado (no solo placeholder)
- Errores de formulario son anunciados (`aria-live="polite"`)
- Imágenes tienen `alt` descriptivo (o `alt=""` si es decorativa)
- Contraste de color ≥ 4.5:1 (verificar con DevTools)
- Formularios navegables por teclado (Tab / Shift+Tab / Enter)

---

## shadcn/ui — reglas de uso
- Usar componentes de shadcn/ui antes de crear uno custom
- Customizar vía `className` con Tailwind, no sobreescribiendo el CSS base
- Si se necesita variante nueva → agregar en `components/ui/` con `cva`
- No modificar directamente los archivos generados en `components/ui/` (se sobreescriben con `npx shadcn add`)

---

## Tests de frontend

```typescript
// __tests__/components/create-item-form.test.tsx
import { render, screen, fireEvent, waitFor } from '@testing-library/react'
import { CreateItemForm } from '@/components/features/items/create-item-form'
import { vi } from 'vitest'

vi.mock('@/lib/actions/items', () => ({
  createItem: vi.fn().mockResolvedValue({ success: true, data: { id: '123' } })
}))

it('envía el formulario con datos válidos', async () => {
  render(<CreateItemForm />)
  fireEvent.change(screen.getByPlaceholderText('Nombre'), { target: { value: 'Test' } })
  fireEvent.click(screen.getByRole('button', { name: /guardar/i }))
  await waitFor(() => expect(createItem).toHaveBeenCalled())
})

it('muestra error de validación', async () => {
  // ...
})
```

**Flujos con Playwright (E2E):**
```typescript
// e2e/items.spec.ts
test('usuario puede crear un item', async ({ page }) => {
  await page.goto('/items')
  await page.click('text=Nuevo item')
  await page.fill('[name=name]', 'Mi item')
  await page.click('button[type=submit]')
  await expect(page.locator('text=Mi item')).toBeVisible()
})
```

---

## Checklist de calidad — Gate 4 (frontend)
- [ ] Todos los flujos del Gate 2 implementados
- [ ] Cada página tiene `loading.tsx` y `error.tsx`
- [ ] Listas vacías tienen estado vacío con acción
- [ ] Formularios con validación visual de errores (campo a campo)
- [ ] Accesibilidad: labels, aria-labels, contraste
- [ ] Tests de interacción para flujos críticos (submit, error, success)
- [ ] Sin `console.log` en producción
- [ ] Sin hardcoded strings de URL; usar variables de entorno
