# Desarrollo local (app Next.js)

## Requisitos

- **Node.js** ≥ 20 (ver `engines` en `package.json` raíz del template)
- **pnpm** 10.x (`corepack enable` y `corepack prepare pnpm@10.28.2 --activate`, o instalar pnpm global)

## Primer arranque

Desde la **raíz del repo del producto** (donde están `pnpm-workspace.yaml` y `apps/web/`):

```bash
pnpm install
cp apps/web/.env.example apps/web/.env.local
# Editar apps/web/.env.local: DATABASE_URL de Neon
pnpm dev
```

La app queda en [http://localhost:3000](http://localhost:3000).

## Comandos útiles

| Comando | Descripción |
|---------|-------------|
| `pnpm dev` | Servidor de desarrollo (app `web`) |
| `pnpm lint` | ESLint en `apps/web` |
| `pnpm build` | Build de producción |
| `pnpm start` | Servidor tras `pnpm build` |

## Base de datos (Neon)

1. Crear proyecto en [Neon](https://neon.tech) y copiar la connection string.
2. Pegarla en `apps/web/.env.local` como `DATABASE_URL`.
3. Modelo y migraciones: ver `db/data-model.md` y `db/migrations/README.md`.

El cliente serverless está en `apps/web/src/lib/db.ts` (`getSql()`). No importar ese módulo en componentes que deban ejecutarse en build sin `DATABASE_URL` configurada.

## UI (Tailwind + shadcn/ui)

- Estilos globales: `apps/web/src/app/globals.css`
- Componentes UI: `apps/web/src/components/ui/` (añadir con `pnpm --filter web exec shadcn add <componente>`)

## Vercel / CI

Despliegue QA y PROD: ver `devops/deployment.md`. En GitHub Actions el build no requiere `DATABASE_URL` mientras la app no ejecute consultas en tiempo de build.
