# Playbook — DevOps (CI/CD y Entornos)

*Gate 7 · Perfil: `factory/agents/profiles/devops.md` · Prompt: `factory/agents/prompts/devops.md`*

## Propósito
Garantizar que el artefacto aprobado en UAT se despliega de forma reproducible, controlada y reversible en producción, con pipeline verde y secretos gestionados.

---

## Entradas requeridas
- Gate 6 ✅ (UAT go/no-go aprobado, `uat/uat-results-*.md`)
- `devops/deployment.md` actualizado
- CI verde en rama `qa`

---

## Salidas obligatorias
- Deploy en producción exitoso y verificado
- `devops/deployment.md` actualizado con versión desplegada
- Tag de versión en git: `v{MAJOR}.{MINOR}.{PATCH}`

---

## Estrategia de ramas y entornos

```
main   ──────────────────────────── PRODUCCIÓN (vercel: prod)
         ↑ merge tras UAT aprobado
qa     ──────────────────────────── QA / Staging (vercel: preview fijo)
         ↑ merge tras Gate 4
feature/HU-XXX ── PR → qa          DEV (vercel: preview por PR)
```

**Reglas:**
- Nunca push directo a `main`; siempre PR desde `qa`
- `main` solo recibe merges post-UAT aprobado
- Toda rama de feature parte de `qa`, no de `main`

---

## GitHub Actions — workflows obligatorios

### CI (ya en template: `.github/workflows/ci.yml`)
Se ejecuta en PR hacia `qa` y `main`:
- `pnpm install --frozen-lockfile`
- `pnpm lint`
- `pnpm test --coverage`
- `pnpm build`

### Migraciones automáticas en deploy
```yaml
# En Vercel: Build Command
pnpm build && tsx db/migrate.ts
```
O vía `postbuild` en `package.json`:
```json
"build": "next build",
"postbuild": "tsx db/migrate.ts"
```

### Opcional: Gate check en PR
Ya incluido en `.github/workflows/gate-check.yml`.

---

## Gestión de secretos

**Regla absoluta: ningún secreto en el código ni en git.**

| Entorno | Dónde van los secretos |
|---------|----------------------|
| Desarrollo local | `.env.local` (en `.gitignore`) |
| Preview (Vercel) | Vercel Environment Variables → Preview |
| QA (Vercel) | Vercel Environment Variables → Preview (rama `qa`) |
| Producción | Vercel Environment Variables → Production |
| CI (GitHub) | GitHub Actions Secrets |

**Variables obligatorias en `.env.example`** (con valor de ejemplo, nunca el real):
```bash
DATABASE_URL=postgresql://user:password@host/db
DATABASE_URL_TEST=postgresql://user:password@host/db_test
NEXTAUTH_SECRET=your-secret-here
NEXTAUTH_URL=http://localhost:3000
```

---

## Checklist de deploy

```markdown
## Deploy Checklist — v{VERSION} — YYYY-MM-DD

### Pre-deploy
- [ ] CI verde en `qa`
- [ ] UAT aprobado (link: uat/uat-results-*.md)
- [ ] Migraciones de DB probadas en entorno QA
- [ ] Variables de entorno de producción configuradas
- [ ] No hay secretos en el código (grep -r "password\|secret\|key" --include="*.ts")

### Deploy
- [ ] PR de `qa` → `main` creado y aprobado
- [ ] Merge a `main`; Vercel deploy automático iniciado
- [ ] Migraciones aplicadas sin error (verificar logs de Vercel)
- [ ] Build de producción exitoso

### Post-deploy
- [ ] URL de producción accesible y respondiendo
- [ ] Flujo crítico verificado manualmente en producción
- [ ] Tag de versión creado: `git tag v{VERSION} && git push --tags`
- [ ] `devops/deployment.md` actualizado con versión y fecha
```

---

## Rollback

Si el deploy falla o introduce regresión crítica:

```bash
# Opción 1: Rollback en Vercel (UI o CLI)
vercel rollback [deployment-url]

# Opción 2: Revert del merge en git + nuevo deploy
git revert -m 1 <merge-commit-hash>
git push origin main
```

**Rollback de migraciones DB:** siempre tener el script de rollback listo antes de deployar un cambio de schema destructivo. Drizzle soporta migraciones de rollback con `drizzle-kit drop`.

---

## Versionado semántico

```
MAJOR.MINOR.PATCH
  │      │     └── Bug fix sin breaking change
  │      └──────── Nueva funcionalidad sin breaking change
  └─────────────── Breaking change o reescritura significativa
```

En POC: `0.MINOR.PATCH` hasta que el producto sea estable para clientes.

---

## Checklist de calidad — Gate 7 (devops)
- [ ] CI verde antes del merge a `main`
- [ ] Deploy en producción exitoso (build + migraciones)
- [ ] Flujo crítico verificado manualmente post-deploy
- [ ] Tag de versión git creado
- [ ] `devops/deployment.md` actualizado
- [ ] Sin secretos en el código o git history
- [ ] Plan de rollback documentado si hubo cambio de schema
