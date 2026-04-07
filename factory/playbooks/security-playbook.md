# Playbook — Seguridad

*Gate 7 · Perfil: `factory/agents/profiles/security.md` · Prompt: `factory/agents/prompts/security.md`*

## Propósito
Aplicar el baseline de seguridad antes de cada release: no es una auditoría exhaustiva, es un checklist mínimo no negociable que bloquea producción si hay hallazgos críticos abiertos.

---

## Entradas requeridas
- Código candidato a release (rama `qa` con CI verde)
- Gate 5 ✅ (QA sin defectos críticos)
- `devops/deployment.md` (superficie de deploy y entornos)

---

## Salidas obligatorias
| Archivo | Contenido |
|---------|-----------|
| `security/security-checklist.md` | Checklist ejecutado con resultado |
| `security/security-report.md` | Hallazgos + severidad + decisión |

---

## Checklist de seguridad baseline

### 1. Dependencias y supply chain
```bash
# Auditoría de vulnerabilidades conocidas
pnpm audit --audit-level=high

# Si hay vulnerabilidades high/critical:
pnpm audit --fix   # o actualizar manualmente
```
- [ ] Sin vulnerabilidades `high` o `critical` abiertas (o con excepción documentada)

### 2. Secretos en el código
```bash
# Búsqueda de secretos hardcodeados
grep -rn --include="*.ts" --include="*.tsx" --include="*.js" \
  -E "(password|secret|api_key|apikey|token|private_key)\s*=\s*['\"][^'\"]{8,}" \
  --exclude-dir={node_modules,.git,.next}
```
- [ ] Sin secretos hardcodeados en código fuente
- [ ] `.env` y `.env.local` en `.gitignore`
- [ ] Sin secretos en el historial de git (revisar commits recientes con `git log -p`)

### 3. Autenticación y autorización
- [ ] Todas las rutas protegidas verifican sesión activa (middleware o en la página)
- [ ] Server Actions verifican `getCurrentUser()` antes de cualquier operación
- [ ] No hay endpoints que expongan datos de otro usuario por cambio de ID en URL
- [ ] Contraseñas hasheadas (bcrypt/argon2) — nunca en texto plano ni MD5/SHA1

### 4. Validación de entrada
- [ ] Todo input de usuario validado con Zod en el servidor (no solo en el cliente)
- [ ] Sin queries SQL construidas con concatenación de strings (usar ORM o queries parametrizadas)
- [ ] Contenido HTML generado por usuario sanitizado con DOMPurify o similar

### 5. Headers de seguridad (Next.js)
```typescript
// next.config.ts
const securityHeaders = [
  { key: 'X-Frame-Options', value: 'SAMEORIGIN' },
  { key: 'X-Content-Type-Options', value: 'nosniff' },
  { key: 'Referrer-Policy', value: 'strict-origin-when-cross-origin' },
  { key: 'Permissions-Policy', value: 'camera=(), microphone=(), geolocation=()' },
  {
    key: 'Content-Security-Policy',
    value: "default-src 'self'; script-src 'self' 'unsafe-eval' 'unsafe-inline'; ..."
  },
]
```
- [ ] Headers de seguridad configurados en `next.config.ts`

### 6. Variables de entorno
- [ ] Sin vars de entorno de producción en el código
- [ ] `NEXTAUTH_SECRET` es un valor aleatorio fuerte (≥32 chars)
- [ ] DATABASE_URL de producción no accesible desde el cliente

### 7. OWASP Top 10 — verificación básica
| Riesgo | Check |
|--------|-------|
| A01 Broken Access Control | Rutas y acciones verifican permisos |
| A02 Cryptographic Failures | Passwords hasheados; HTTPS enforced |
| A03 Injection | ORM + Zod; sin SQL dinámico |
| A05 Security Misconfiguration | Headers configurados; debug off en prod |
| A07 Auth Failures | Session manejo con NextAuth; tokens seguros |
| A09 Logging Failures | Errores loggeados sin exponer datos sensibles |

---

## Clasificación de hallazgos

| Severidad | Criterio | Acción |
|-----------|----------|--------|
| **Crítica** | RCE, SQLi, autenticación bypasseable, secreto expuesto | BLOQUEA release |
| **Alta** | IDOR, XSS persistente, CSRF, datos sensibles expuestos | BLOQUEA release salvo excepción aprobada |
| **Media** | Header faltante, dependency desactualizada sin CVE activo | Plan en próximo ciclo |
| **Baja** | Mejora defensiva, best practice no seguida | Issue documentado |

---

## Reporte de seguridad — formato

```markdown
# Security Report — v{VERSION} — YYYY-MM-DD

## Resumen ejecutivo
**Decisión:** GO ✅ | NO GO ❌ | GO CONDICIONAL ⚠️

## Hallazgos

### [CRÍTICO/ALTO/MEDIO/BAJO] — Título del hallazgo
**Descripción:** Qué es el problema.
**Evidencia:** Archivo, línea, o comportamiento observado.
**Impacto:** Qué puede hacer un atacante.
**Remediación:** Cómo arreglarlo.
**Estado:** Abierto | Mitigado | Aceptado con razón

## Checklists ejecutados
- [x] Dependencias (pnpm audit): sin high/critical
- [x] Secretos en código: ninguno encontrado
- [x] Autenticación/autorización: verificada
- [x] Validación de entrada: Zod en server
- [x] Headers de seguridad: configurados
```

---

## Checklist de calidad — Gate 7 (security)
- [ ] `pnpm audit` sin vulnerabilidades high/critical
- [ ] Sin secretos en código o git history
- [ ] Autenticación verificada en todas las rutas/acciones protegidas
- [ ] Validación de entrada server-side en todos los endpoints
- [ ] Headers de seguridad configurados
- [ ] `security/security-checklist.md` ejecutado
- [ ] `security/security-report.md` con decisión go/no-go
- [ ] Sin hallazgos críticos o altos abiertos (o con excepción aprobada explícitamente)
