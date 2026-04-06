# Deployment — Vercel + GitHub (QA y PROD)

Stack: **Next.js** en `apps/web`, **pnpm** workspace en la raíz del repo, **Neon** como PostgreSQL.

## Ambientes (por ahora)

| Ambiente | Rama Git | Vercel | Uso |
|----------|-----------|--------|-----|
| **QA** | `qa` | Deployment asociado a la rama `qa` (p. ej. “Staging” o preview de rama fija) | Integración, pruebas internas, checklist QA |
| **PROD** | `main` | **Production** | Usuarios finales |

Convención: los merges a **`qa`** despliegan QA; los merges a **`main`** despliegan producción. Los PR pueden usar **Preview deployments** de Vercel según configuración del proyecto (opcional; no sustituye el ambiente QA estable si definís `qa` como fuente única de pre-producción).

## Configuración en Vercel (una vez por producto)

1. Importar el repositorio desde GitHub.
2. **Root Directory:** `apps/web`
3. **Build Command:** `cd ../.. && pnpm install --frozen-lockfile && pnpm --filter web build`  
   (o dejar el default si Vercel detecta el monorepo; en muchos casos basta con root = `apps/web` y **Install Command** `cd ../.. && pnpm install --frozen-lockfile` desde el directorio raíz del repo).
4. Ajustar según el asistente de Vercel para monorepos pnpm ([documentación Vercel monorepos](https://vercel.com/docs/monorepos)).

Valores típicos cuando el **Root Directory** es `apps/web`:

- **Install:** ejecutar desde la raíz del repositorio: `pnpm install --frozen-lockfile` (Vercel: “Override” con ruta al lockfile en la raíz).
- **Build:** `pnpm --filter web build` con `cwd` en la raíz, o el equivalente que genere el dashboard.

5. **Variables de entorno**
   - **Production (`main`):** `DATABASE_URL` apuntando a la base **producción** Neon (o rama Neon `production`).
   - **Preview / QA:** `DATABASE_URL` apuntando a base **QA** Neon (proyecto o rama separada, p. ej. `development`).

No commitear secretos: solo `apps/web/.env.example` en git.

## CI en GitHub

El workflow `.github/workflows/ci.yml` ejecuta `pnpm install`, `lint` y `build` en cada PR/push a `main` y `qa`. Debe mantenerse verde antes de merge según política del equipo.

## Rollback

- **Vercel:** desplegar de nuevo un deployment anterior desde el dashboard (Instant Rollback / Promote).
- **Datos:** plan de rollback de migraciones documentado en `db/migrations/README.md` cuando aplique.

## Roadmap

- Automatizar creación de proyecto Vercel + variables desde IaC o script (opcional).
- Añadir ambiente `staging` intermedio solo si QA y PROD no alcanzan.
