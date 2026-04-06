# Proyectos de producto (fuera del wrapper)

Esta carpeta es el **espacio local** para clonar o abrir cada iniciativa. **No forma parte del historial git del repositorio wrapper**: el contenido está ignorado salvo este archivo (ver `.gitignore` en la raíz).

## Convención
- Un directorio por producto: `projects/<nombre-producto>/`
- Cada uno es **su propio repositorio** (origen propio en GitHub/GitLab/etc.).
- El repo **POC-factory** solo contiene `factory/`, `template/` y la gobernanza común.

## Arranque típico
1. Crear el repo remoto del producto.
2. Clonar aquí: `git clone <url> projects/<nombre-producto>`
3. Opcional: partir del `template/` del wrapper y subir al repo del producto.

## Trazabilidad con la fábrica
Los estándares y playbooks viven en `../factory/`; el producto implementa y documenta en su repo.
