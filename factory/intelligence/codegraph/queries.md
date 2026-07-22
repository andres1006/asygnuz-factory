# Consultas útiles

Estas preguntas guían los reportes generados por Codegraph.

## Documentación

- ¿Qué archivos Markdown/YAML existen bajo `factory/`?
- ¿Qué documentos tienen enlaces internos?
- ¿Qué enlaces apuntan a rutas inexistentes?
- ¿Qué archivos existen pero no están listados en `factory/INDEX.md`?

## Agentes

- ¿Cada rol tiene perfil?
- ¿Cada rol tiene prompt?
- ¿Cada rol tiene playbook o cobertura explícita?
- ¿Qué roles participan en cada gate?

## Gates

- ¿Cada gate 1–7 está definido en Markdown y YAML?
- ¿Qué archivos mínimos exige cada gate?
- ¿Qué criterios siguen siendo revisión humana?
- ¿El template implementa los archivos mínimos esperados?

## Drift

- ¿Hay `.DS_Store` u otros archivos locales bajo `factory/`?
- ¿Hay prompts sin perfil?
- ¿Hay perfiles sin prompt?
- ¿Hay playbooks huérfanos?
- ¿La matriz de agentes incluye roles que no están en el mapa de gates?
