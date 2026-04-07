# Estándares de Ingeniería — Fábrica

Todo proyecto generado desde `template/` sigue estos estándares. Las desviaciones requieren ADR en el proyecto.

---

## Stack de referencia

| Capa | Tecnología | Versión mínima |
|------|-----------|----------------|
| Framework | Next.js App Router | 14+ |
| Lenguaje | TypeScript | 5+ (strict mode) |
| UI | Tailwind CSS + shadcn/ui | latest |
| ORM | Drizzle ORM | latest |
| DB | Neon (PostgreSQL serverless) | latest |
| Auth | NextAuth.js v5 o Clerk | latest |
| Validación | Zod | 3+ |
| Testing unit/integration | Vitest | latest |
| Testing E2E | Playwright | latest |
| Package manager | pnpm workspaces | 9+ |
| Hosting / CI-CD | Vercel + GitHub Actions | — |
| Análisis estático | ESLint + Prettier | latest |

---

## Estructura de monorepo (template)

```
apps/
  web/
    app/                        ← rutas Next.js (App Router)
      (auth)/                   ← grupo de rutas protegidas
      (public)/                 ← rutas públicas
      api/                      ← Route Handlers
      layout.tsx
      globals.css
    components/
      ui/                       ← wrappers shadcn (sin lógica de negocio)
      features/                 ← componentes con lógica de dominio, por feature
    lib/
      db/
        index.ts                ← cliente Drizzle
        schema.ts               ← schema completo o barrel de esquemas por dominio
        migrate.ts              ← script de migración
      actions/                  ← Server Actions, un archivo por dominio
      auth/                     ← configuración NextAuth/Clerk
      validations/              ← schemas Zod por dominio
    hooks/                      ← custom hooks React
    types/                      ← tipos TypeScript compartidos en la app
packages/
  ui/                           ← componentes compartidos si hay múltiples apps
  db/                           ← schema + migrations si se comparte entre apps
```

---

## TypeScript — reglas obligatorias

```typescript
// tsconfig.json
{
  "compilerOptions": {
    "strict": true,             // obligatorio
    "noUncheckedIndexedAccess": true,
    "exactOptionalPropertyTypes": true
  }
}
```

- **Sin `any`** salvo en boundaries de integración externos con justificación en comentario
- **Sin `// @ts-ignore`** sin explicación de por qué es necesario
- **Inferir tipos de Zod schemas:** `type T = z.infer<typeof Schema>` — no duplicar interfaces
- **Enums como `const` objects** en lugar de TypeScript `enum`:
  ```typescript
  // ✅
  export const Status = { ACTIVE: 'active', INACTIVE: 'inactive' } as const
  export type Status = (typeof Status)[keyof typeof Status]
  // ❌
  enum Status { ACTIVE = 'active', INACTIVE = 'inactive' }
  ```

---

## Nombrado — convenciones

| Elemento | Convención | Ejemplo |
|----------|-----------|---------|
| Archivos/carpetas | kebab-case | `user-profile.tsx` |
| Componentes React | PascalCase | `UserProfile` |
| Funciones | camelCase | `getUserById` |
| Constantes globales | UPPER_SNAKE | `MAX_RETRIES` |
| Variables DB (columnas) | snake_case | `created_at` |
| Tablas DB | plural snake_case | `user_sessions` |
| Server Actions | camelCase con verbo | `createUser`, `updateProfile` |
| Schemas Zod | PascalCase + Schema | `CreateUserSchema` |
| Tipos de retorno de actions | `ActionResult<T>` | ver patrón en backend-playbook |

---

## Pull Requests — estándar

**Título:** `tipo(scope): descripción en imperativo`
- Tipos: `feat`, `fix`, `chore`, `docs`, `test`, `refactor`
- Scope: dominio o módulo (`auth`, `items`, `db`, `ci`)
- Ejemplo: `feat(items): agregar paginación infinita`

**Descripción mínima:**
```markdown
## Qué
[qué hace este PR en 1-2 oraciones]

## Por qué
[enlace a HU o tarea: Closes tasks/hu/HU-XXX.md]

## Decisiones no obvias
[si las hay; si no, omitir sección]

## Checklist
- [ ] Tests agregados/actualizados
- [ ] CI verde
- [ ] Sin console.log, TODO suelto, ni secretos
```

**Tamaño:** diff < 400 líneas salvo generación automática justificada.

---

## Testing — estándares

**Cobertura objetivo: ≥ 90%** (global). Excepción requiere aprobación explícita en `qa/coverage-report.md`.

**Nunca:**
- Tests sin assertions (`expect(true).toBe(true)`)
- Mockear la DB en integration tests (usar `DATABASE_URL_TEST` real)
- Snapshots de componentes como única prueba (muy frágiles)

**Convención de archivos:**
```
__tests__/
  actions/          ← integration tests de Server Actions
  components/       ← unit tests de componentes
e2e/               ← tests Playwright
```

**Setup de Vitest:**
```typescript
// vitest.config.ts
export default defineConfig({
  test: {
    environment: 'node',       // para actions/db
    setupFiles: ['./test-setup.ts'],
    coverage: {
      provider: 'v8',
      thresholds: { global: { lines: 90, branches: 85, functions: 90 } }
    }
  }
})
```

---

## Seguridad — reglas no negociables

1. **Sin secretos en código ni en git** — todo en variables de entorno
2. **Sin SQL dinámico por concatenación** — solo ORM o queries parametrizadas
3. **Validación server-side con Zod** en toda entrada de usuario
4. **Auth verificada en Server Actions antes de cualquier operación**
5. **`pnpm audit --audit-level=high`** debe pasar antes de cada release
6. **Headers de seguridad** configurados en `next.config.ts`

---

## Performance — guías

- **LCP objetivo: < 2.5s** en conexión típica
- **Server Components por defecto** — minimizar bundle del cliente
- **`next/image`** para todas las imágenes (optimización automática)
- **`next/font`** para fuentes (evitar FOUT y layout shift)
- **Suspense boundaries** en componentes que fetchean datos
- **No over-fetching:** seleccionar solo columnas necesarias en queries Drizzle

---

## Evolución del estándar

Si el estándar cambia para toda la fábrica:
1. ADR en `factory/decisions/`
2. Actualizar este archivo
3. Registrar en `factory/CHANGELOG.md`
4. Propagar a proyectos activos según `factory/operations/template-evolution-process.md`
