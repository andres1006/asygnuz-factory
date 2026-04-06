# Estándares de ingeniería (fábrica)

## Stack de referencia
Definido en `template/README.md`: **Next.js** en `apps/web`, **pnpm** workspace en la raíz del producto, **Tailwind + shadcn/ui**, **Neon**, **Vercel** (QA rama `qa`, PROD rama `main`), CI en **GitHub Actions**. Nuevos proyectos parten de ahí salvo decisión explícita en ADR de proyecto o de fábrica.

## Pull requests
- Tamaño pequeño, una intención por PR.
- Título y descripción enlazan a HU o tarea trazable.
- Revisión obligatoria según política del repo.

## Calidad
- Tests y cobertura según gate en `governance/quality-gates.md`.
- Sin merge a main sin CI verde salvo excepción documentada.

## Seguridad y datos
- Checklist mínimo antes de release (ver playbooks de Security y template).

## Evolución
Si el estándar cambia para toda la fábrica, registrar ADR en `decisions/` y proceso en `operations/template-evolution-process.md`.
