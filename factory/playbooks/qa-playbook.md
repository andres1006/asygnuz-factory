# Playbook — QA (Calidad y Pruebas)

*Gate 5 · Perfil: `factory/agents/profiles/qa.md` · Prompt: `factory/agents/prompts/qa.md`*

## Propósito
Verificar que el build cumple los criterios de aceptación antes de UAT, con evidencia objetiva (cobertura, resultados de pruebas, defectos documentados).

---

## Entradas requeridas
- Gate 4 ✅ (build estable, PRs mergeados)
- `qa/test-plan.md` actualizado
- HU en `tasks/hu/` con criterios GIVEN/WHEN/THEN (fuente de verdad de qué probar)

---

## Salidas obligatorias
| Archivo | Contenido |
|---------|-----------|
| `qa/test-plan.md` | Plan de pruebas del ciclo |
| `qa/coverage-report.md` | Resultado de cobertura con evidencia |
| Defectos | En `tasks/hu/` anotados o en issues GitHub enlazados |

---

## Pirámide de pruebas — proporciones objetivo

```
         /\
        /E2E\        5-10% — flujos críticos de usuario end-to-end
       /------\
      /Integra-\     20-30% — Server Actions + DB + auth
     /  ción    \
    /------------\
   /   Unit       \  60-70% — funciones puras, validaciones, utilidades
  /________________\

Cobertura global objetivo: ≥ 90%
Excepciones deben ser aprobadas explícitamente y documentadas.
```

---

## Unit tests (Vitest)

**Qué testear:**
- Schemas de validación Zod (todos los casos edge)
- Funciones de transformación / utilidades
- Lógica de negocio pura (sin DB ni network)
- Componentes React con lógica de presentación

```typescript
// Ejemplo: schema de validación
describe('CreateItemSchema', () => {
  it('acepta datos válidos', () => {
    expect(CreateItemSchema.safeParse({ name: 'Test', price: 10 }).success).toBe(true)
  })
  it('rechaza nombre vacío', () => {
    const r = CreateItemSchema.safeParse({ name: '', price: 10 })
    expect(r.success).toBe(false)
    expect(r.error.flatten().fieldErrors.name).toBeDefined()
  })
  it('rechaza precio negativo', () => { /* ... */ })
  it('rechaza precio cero', () => { /* ... */ })
})
```

---

## Tests de integración (Vitest + Neon branch / test DB)

**Qué testear:**
- Server Actions completas (auth → validación → DB → respuesta)
- Route Handlers con request/response reales
- Consultas DB complejas

```typescript
// Setup: DB de test aislada
// vitest.config.ts: usar DATABASE_URL_TEST
describe('createItem action', () => {
  beforeEach(async () => { await resetTestDB() })

  it('crea item y retorna id', async () => {
    const user = await createTestUser()
    mockCurrentUser(user)

    const fd = new FormData()
    fd.set('name', 'Test item')

    const result = await createItem(fd)
    expect(result.success).toBe(true)
    if (result.success) {
      const item = await db.query.items.findFirst({
        where: (t, { eq }) => eq(t.id, result.data.id)
      })
      expect(item).toBeDefined()
    }
  })
})
```

---

## E2E tests (Playwright)

**Flujos obligatorios para E2E:**
- Autenticación (login exitoso, fallo, logout)
- Flujo crítico de negocio #1 (el que más usa el usuario)
- Flujo crítico de negocio #2

```typescript
// playwright.config.ts
export default defineConfig({
  testDir: './e2e',
  use: {
    baseURL: process.env.PLAYWRIGHT_BASE_URL || 'http://localhost:3000',
  },
})

// e2e/auth.spec.ts
test.describe('Autenticación', () => {
  test('login exitoso redirige al dashboard', async ({ page }) => {
    await page.goto('/login')
    await page.fill('[name=email]', 'test@example.com')
    await page.fill('[name=password]', 'password123')
    await page.click('button[type=submit]')
    await expect(page).toHaveURL('/dashboard')
  })

  test('credenciales incorrectas muestra error', async ({ page }) => {
    await page.goto('/login')
    await page.fill('[name=email]', 'wrong@example.com')
    await page.fill('[name=password]', 'wrongpassword')
    await page.click('button[type=submit]')
    await expect(page.locator('[role=alert]')).toBeVisible()
  })
})
```

---

## Reporte de cobertura — formato

```markdown
# Coverage Report — Semana XX / YYYY-MM-DD

## Resumen
| Tipo | Cobertura | Objetivo | Estado |
|------|-----------|----------|--------|
| Lines | 92% | ≥90% | ✅ |
| Branches | 88% | ≥85% | ✅ |
| Functions | 95% | ≥90% | ✅ |

## E2E
- Flujos cubiertos: [login, crear item, listar items]
- Flujos pendientes: [eliminar item — pendiente HU-005]

## Defectos encontrados
| ID | HU | Severidad | Estado |
|----|-----|-----------|--------|
| BUG-001 | HU-003 | Alta | Abierto |

## Excepciones de cobertura
| Módulo | Cobertura | Razón | Aprobado por |
|--------|-----------|-------|-------------|
| lib/legacy | 60% | Código legado sin tests — plan en ADR-004 | Andrés |
```

---

## Clasificación de defectos

| Severidad | Criterio | Acción |
|-----------|----------|--------|
| **Crítica** | Pérdida de datos, seguridad, bloqueo total | Bloquea Gate 5; fix inmediato |
| **Alta** | Flujo principal roto, error visible en happy path | Bloquea Gate 5 salvo excepción aprobada |
| **Media** | Flujo alterno roto, UX degradada | Documentar; puede pasar a UAT con nota |
| **Baja** | Cosmético, typo, mejora | No bloquea; crear issue para próximo ciclo |

---

## Checklist de calidad — Gate 5
- [ ] `qa/test-plan.md` actualizado con alcance del ciclo
- [ ] Cobertura ≥ 90% (o excepción documentada y aprobada)
- [ ] E2E cubre flujos críticos definidos en Gate 2
- [ ] Todos los defectos Alta/Crítica resueltos o con excepción aprobada
- [ ] `qa/coverage-report.md` actualizado con evidencia
- [ ] CI verde en rama `qa`
