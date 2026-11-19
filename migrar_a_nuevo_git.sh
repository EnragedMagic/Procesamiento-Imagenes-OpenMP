#!/usr/bin/env bash
set -euo pipefail
if [[ $# -ne 1 || "$1" != https://github.com/*/*.git ]]; then
  echo 'Uso: bash migrar_a_nuevo_git.sh https://github.com/USUARIO/REPO-NUEVO.git' >&2
  exit 2
fi
for cmd in git cp python3; do command -v "$cmd" >/dev/null || { echo "Falta $cmd" >&2; exit 1; }; done
INTEGRACION="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DESTINO="$(dirname "$INTEGRACION")/Procesamiento-Imagenes-migrado"
if [[ -e "$DESTINO" ]]; then
  echo "La carpeta $DESTINO ya existe; no se sobrescribe." >&2
  exit 1
fi
ORIGEN='https://github.com/linacastaneda/Procesamiento-Imagenes-openmp.git'
git clone "$ORIGEN" "$DESTINO"
cd "$DESTINO"
git switch main
# Conserva la carpeta .git e historial. Copia los archivos de integración sobre la base.
cp -a "$INTEGRACION"/. "$DESTINO"/
# No introducir accidentalmente repositorios anidados.
rm -rf -- "$DESTINO/.gitignore.bak" 2>/dev/null || true
git add -A
git commit -m 'Integrar procesamiento OpenMP y experimentos reproducibles'
git remote add nuevo "$1"
printf '\nMigración local lista: %s\n' "$DESTINO"
printf 'Revisa los cambios y publica con:\n  cd "%s"\n  git push -u nuevo main\n' "$DESTINO"
