# Agentes y herramientas en el repo del producto

Los perfiles **canónicos** viven en el repositorio de la fábrica (`asygnuz-factory` u homónimo), bajo **`factory/agents/`**.

## Si desarrollas dentro del monorepo (wrapper + template)
Abre directamente `factory/agents/profiles/<rol>.md` y las reglas `.cursor/rules/agent-*.mdc` del wrapper.

## Si este producto es solo su propio repositorio (clon desde template)
Opciones para mantener el mismo comportamiento:

1. **Copiar o sincronizar** al crear el repo: `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.cursor/rules/`, `.agent/rules/` desde el repo de la fábrica (o un script).
2. **Submodule** del repo de la fábrica (solo si quieres actualizaciones automáticas de política).
3. **Manual:** pegar en el chat la ruta o contenido del perfil desde la última versión publicada de la fábrica.

La estructura de entregables de este template (`docs/`, `design/`, `qa/`, etc.) es la que los perfiles referencian; **no** sustituyas esa estructura sin un ADR en el producto.
