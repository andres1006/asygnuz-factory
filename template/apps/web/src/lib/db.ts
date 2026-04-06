import { neon } from "@neondatabase/serverless";

/**
 * Cliente SQL serverless para Neon. Usar solo en Server Components, Route Handlers o Server Actions.
 * En local: copiar `.env.example` → `.env.local` con `DATABASE_URL` del proyecto Neon.
 */
export function getSql() {
  const url = process.env.DATABASE_URL;
  if (!url) {
    throw new Error(
      "DATABASE_URL no está definida. Ver apps/web/.env.example y docs/local-development.md",
    );
  }
  return neon(url);
}
