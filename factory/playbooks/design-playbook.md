# Playbook — Diseño UX/UI

*Gate 2 · Perfil: `factory/agents/profiles/design.md` · Prompt: `factory/agents/prompts/design.md`*

## Propósito
Convertir PRD + RF en flujos, estados y referencias de wireframe/mock que permitan a arquitectura y desarrollo trabajar sin preguntar "¿cómo debería verse esto?".

---

## Entradas requeridas
- `docs/00-prd.md` aprobado (Gate 1 ✅)
- `docs/01-requisitos-funcionales.md` completo
- `docs/02-requisitos-no-funcionales.md` (especialmente accesibilidad y responsive)

---

## Salidas obligatorias
| Archivo | Contenido |
|---------|-----------|
| `design/user-flows.md` | Flujos completos mapeados a RF, estados error/vacío/carga |
| Referencias a wireframes | Rutas en repo, enlace a herramienta MCP, o capturas en `design/assets/` |

---

## Cómo documentar flujos de usuario

**Estructura por flujo:**
```markdown
## Flujo: [nombre] (RF-XXX, RF-YYY)

### Happy path
1. El usuario ve [pantalla A]
2. Realiza [acción] → [resultado]
3. ...
4. Resultado final: [estado exitoso visible]

### Estados alternativos
- **Error [tipo]**: [qué ve el usuario, cómo recuperarse]
- **Estado vacío**: [qué muestra cuando no hay datos]
- **Estado de carga**: [feedback visual durante espera]
- **Sin permisos**: [qué ve un usuario no autorizado]

### Mapa pantalla → RF
| Pantalla | RF cubiertos |
|----------|-------------|
| Login | RF-001, RF-002 |
```

---

## Estándar de wireframes

**Nivel mínimo para Gate 2:** wireframe de baja/media fidelidad que muestre:
- Layout y jerarquía visual principal
- Componentes críticos (formularios, tablas, acciones primarias)
- Navegación entre pantallas

**Herramientas aceptadas:**
- MCP Pencil / Figma → export o screenshot en `design/assets/`
- Stitch → `design-md` + `enhance-prompt` skills
- Diagrama Markdown (Mermaid) para flujos de navegación

**No bloquear desarrollo esperando alta fidelidad.** Si el wireframe no está listo, documentar exactamente qué falta y por qué.

---

## Principios de diseño (aplicar en todos los flujos)

**Mobile-first:** diseñar para 375px primero; escalar a desktop.

**Accesibilidad mínima (WCAG 2.1 AA):**
- Contraste de color ≥ 4.5:1 en texto normal
- Elementos interactivos con label visible o aria-label
- Navegación por teclado en flujos principales
- No depender solo del color para transmitir información

**Feedback del sistema:** cada acción del usuario que tarda >100ms debe tener indicador de carga.

**Estados vacíos con CTA:** si una lista puede estar vacía, diseñar el estado vacío con acción que resuelva el vacío.

---

## Stack de componentes (shadcn/ui + Tailwind)
Usar componentes del catálogo de shadcn/ui por defecto antes de crear uno nuevo. El agente de diseño debe referenciar el nombre del componente shadcn cuando aplique:
- `Button`, `Input`, `Form`, `Dialog`, `Sheet`, `Toast`, `Table`, `Select`, `Dropdown`…
- Si no existe en shadcn → documentarlo explícitamente para que frontend lo sepa

---

## Decisiones autónomas vs escalación

| Situación | Acción del agente |
|-----------|-----------------|
| RF no tiene flujo claro | Proponer flujo más simple posible + escalar |
| RF pide funcionalidad sin precedente claro | Documentar 2 opciones con trade-offs |
| RNF de accesibilidad choca con diseño propuesto | Ajustar diseño automáticamente |
| Herramienta de diseño MCP no disponible | Documentar flujo en Markdown + Mermaid y continuar |
| Wireframe de baja fidelidad vs esperar alta fidelidad | Siempre baja fidelidad para no bloquear |

---

## Checklist de calidad — Gate 2
- [ ] Cada RF tiene al menos una pantalla/flujo documentado en `design/user-flows.md`
- [ ] Estados error, vacío y carga documentados para flujos principales
- [ ] Wireframes (cualquier fidelidad) disponibles o referenciados
- [ ] Flujos usan componentes shadcn/ui por nombre cuando aplica
- [ ] Consideraciones de accesibilidad y mobile-first anotadas
- [ ] No hay pantalla sin trazabilidad a RF
