# Playbook — Marketing (mensaje y mercado)

*Dependencia de Gate 1 · Perfil: `factory/agents/profiles/marketing.md` · Prompt: `factory/agents/prompts/marketing.md`*

## Propósito
Dar una **base de mensaje única** para que Producto priorice y escriba RF sin contradicciones de mercado, y Diseño/Frontend mantengan copy coherente y compliant.

## Entradas
- Intake (`docs/intake/`), propuesta de valor, contexto competitivo que exista en el repo o en notas del fundador.

## Salida obligatoria
| Archivo | Uso |
|---------|-----|
| `docs/marketing/00-marketing-brief.md` | Contrato con Producto, Diseño y Frontend (ver secciones en el prompt de marketing) |

## Relación con otros roles
- **Producto** alinea problema/alcance y KPI con pilares de mensaje; evita RF que contradigan claims del brief.
- **Diseño** refleja tono y jerarquía de mensaje en flujos (microcopy de sistema, empty states).
- **Frontend** usa glosario y CTAs del brief para strings visibles; desvíos solo con nota en PR o ADR de producto.

## Definition of Done (marketing, dentro de G1)
- [ ] Brief completo según prompt (sin secciones críticas en blanco).
- [ ] Supuestos y pendientes legales explícitamente marcados.
- [ ] `check-gate.sh 1` incluye este archivo cuando se valide Gate 1.
