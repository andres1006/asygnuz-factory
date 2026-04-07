# Playbook — Arquitectura de Solución

*Gate 3 · Perfil: `factory/agents/profiles/architecture.md` · Prompt: `factory/agents/prompts/architecture.md`*

## Propósito
Definir la solución técnica que satisface RF, RNF y diseño, tomando decisiones de módulos, integraciones y riesgos. El resultado guía a DB, Backend y Frontend sin ambigüedad.

---

## Entradas requeridas
- Gate 1 ✅ (PRD + RF + RNF)
- Gate 2 ✅ (flujos de usuario)
- Stack de referencia en `factory/standards/engineering-standards.md`

---

## Salidas obligatorias
| Archivo | Contenido |
|---------|-----------|
| `architecture/solution-architecture.md` | Decisión de arquitectura completa |
| `memory/adrs/ADR-XXX-*.md` | Un ADR por decisión significativa |

---

## Stack de referencia (por defecto)
```
Frontend/App  : Next.js 14+ (App Router), TypeScript
UI            : Tailwind CSS + shadcn/ui
Backend       : Next.js Server Actions + Route Handlers
DB            : Neon (PostgreSQL serverless)
ORM           : Drizzle ORM (preferido) o Prisma
Auth          : NextAuth.js v5 o Clerk
Hosting/CI-CD : Vercel + GitHub Actions
Monorepo      : pnpm workspaces (apps/web, packages/*)
```
Cualquier desviación → ADR obligatorio.

---

## Decisión clave: Server Actions vs Route Handlers

| Caso de uso | Usar |
|-------------|------|
| Mutaciones desde formularios React (crear, editar, eliminar) | Server Action |
| Mutaciones disparadas por JS/cliente (sin form nativo) | Server Action o Route Handler |
| API pública consumida por móvil / terceros | Route Handler |
| Webhooks externos (Stripe, GitHub…) | Route Handler |
| Streaming de datos en tiempo real | Route Handler con SSE |
| Operaciones de lectura simple en RSC | fetch directo en Server Component |

---

## Decisión clave: Server Component vs Client Component

```
Por defecto: Server Component.
Cambiar a Client Component ('use client') SOLO cuando:
  - Se necesita estado local (useState, useReducer)
  - Se necesita evento de browser (onClick, onChange, etc.)
  - Se usan hooks de React (useEffect, useContext…)
  - Se integra librería que requiere window/document

NUNCA marcar como Client Component solo por "comodidad".
Cada 'use client' innecesario infla el bundle del cliente.
```

---

## Estructura de módulos (template monorepo)
```
apps/
  web/
    app/                   ← rutas Next.js (App Router)
      (auth)/              ← grupo de rutas protegidas
      (public)/            ← rutas públicas
      api/                 ← Route Handlers
    components/
      ui/                  ← wrappers de shadcn (no lógica de negocio)
      features/            ← componentes con lógica de dominio
    lib/
      db/                  ← cliente Drizzle + schema
      actions/             ← Server Actions por dominio
      auth/                ← configuración auth
      validations/         ← schemas Zod compartidos
packages/
  ui/                      ← componentes compartidos (si hay múltiples apps)
  db/                      ← schema + migraciones compartidas
```

---

## Cuándo crear un ADR
- Cambio al stack de referencia (ORM, auth, hosting, etc.)
- Decisión de estructura de módulos no obvia
- Trade-off con impacto en seguridad, rendimiento o mantenibilidad
- Integración con servicio externo
- Decisión que otro agente podría cuestionar sin contexto

**Formato ADR mínimo:**
```markdown
# ADR-XXX: [título corto]
**Estado:** Propuesto | Aceptado | Deprecado
**Contexto:** Por qué se necesita esta decisión.
**Decisión:** Qué se decide.
**Consecuencias:** Pros y contras; impacto en otros módulos.
```

---

## Checklist de calidad — Gate 3 (parte arquitectura)
- [ ] `solution-architecture.md` describe módulos, integraciones y riesgos
- [ ] Decisión Server Actions vs Route Handlers justificada por dominio
- [ ] Estructura de carpetas definida (alineada al estándar o con ADR)
- [ ] ADR creado por cada desviación del stack de referencia
- [ ] Dependencias externas listadas con versión o rango aceptado
- [ ] Riesgos técnicos identificados con mitigación propuesta
