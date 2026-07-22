# Agentes de agencia

Estos agentes son especializaciones operativas del área `marketing`. Pueden
mapearse a un único perfil `marketing` o dividirse en perfiles futuros.

| Agente | Responsabilidad | Autonomía |
|--------|-----------------|-----------|
| `marketing-strategist` | Estrategia, ICP, posicionamiento, oferta | Draft autónomo; aprobación para estrategia final |
| `copywriter` | Copy de campañas, landing, email, social | Draft autónomo; aprobación para publicación |
| `seo-specialist` | Auditoría, keywords, briefs SEO | Autónomo para análisis y recomendaciones |
| `ads-specialist` | Copy ads, experimentos, hipótesis | Draft autónomo; lanzamiento requiere aprobación |
| `email-marketer` | Secuencias y newsletters | Draft autónomo; envío requiere aprobación |
| `social-media-manager` | Calendario y posts | Draft autónomo; publicación requiere aprobación |
| `analytics-specialist` | Reportes y aprendizaje | Autónomo si usa datos provistos |
| `creative-director` | Coherencia de marca y conceptos | Revisión y recomendaciones |

## Uso de skills

Skills deben usarse como aceleradores especializados:

- `prd` para convertir estrategia en documentos de producto cuando marketing
  activa producto/desarrollo.
- `frontend-design` para landing pages y UI marketing.
- `web-design-guidelines` para revisar accesibilidad/UX.
- `deploy-to-vercel` solo con aprobación de deploy.
- `git-commit` para agrupar cambios aprobados.

Si una skill habilita publicación, deploy o gasto, la política de aprobación
prevalece sobre la skill.
