# Migración conservando el proyecto original

## Objetivo
Este proyecto parte de `linacastaneda/Procesamiento-Imagenes-openmp`. Se mantienen la estructura `src/`, `include/`, `tests/`, `docs/`, `imagenes/`, el menú, el código de procesamiento RGB y los filtros existentes. La integración añade el filtro OpenMP, las pruebas de equivalencia, el benchmark y el análisis experimental.

## Método recomendado: conservar el historial Git
1. Crear en GitHub un **repositorio nuevo y vacío**, sin README, sin licencia y sin `.gitignore` inicial (por ejemplo `Procesamiento-Imagenes-OpenMP-Unificado`).
2. Descomprimir este paquete y abrir la terminal en la carpeta `proyecto`.
3. Ejecutar el script de migración con la URL real del repositorio nuevo:

```bash
bash migrar_a_nuevo_git.sh https://github.com/USUARIO/REPOSITORIO-NUEVO.git
```

El script clona el repositorio original (con su historial), copia la integración sobre los archivos originales y prepara un commit en una carpeta hermana llamada `Procesamiento-Imagenes-migrado`. **No publica automáticamente:** revisa los cambios antes de subirlos.

4. Revisar y publicar:

```bash
cd ../Procesamiento-Imagenes-migrado
git status
git diff HEAD~1 --stat
git push -u nuevo main
```

Usa autenticación GitHub ya configurada en tu equipo. El `origin` seguirá apuntando al GitHub de Lina, y `nuevo` al destino; así evitas subir accidentalmente los cambios al proyecto original. No hagas `git push origin`.

## Qué se conserva
- `src/main.c` sigue siendo el punto de entrada y conserva el menú existente (se agregan funcionalidades).
- `src/filtro_secuencial.c` conserva la implementación secuencial.
- `src/imagen.c`, `include/`, `imagenes/foto.jpg` mantienen su función.
- `Makefile` conserva los comandos `make`, `make test` y `make run` y añade `make benchmark` / `make experimentos`.
- `README.md` mantiene la explicación académica del proyecto, ampliada con el flujo de las pruebas.

## Verificación antes de publicar
```bash
sudo apt install build-essential libstb-dev python3 python3-matplotlib
make test
make benchmark
python3 scripts/experimentar.py --resoluciones 128 256 --hilos 1 2 --filtros 3 7 --repeticiones 2
# Para pruebas definitivas:
python3 scripts/experimentar.py
```

Las mediciones deben repetirse en el hardware real del informe. No confundas mediciones de ejemplo con resultados definitivos.

## Alternativa si ya tienes un repo nuevo con commits
No ejecutes este script sobre un repositorio existente: prepara la integración en una rama y fusiona mediante PR para no sobrescribir ni duplicar trabajo.
