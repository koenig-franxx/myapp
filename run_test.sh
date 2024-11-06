#!/bin/bash
# Script de ejemplo para ejecutar pruebas

echo "Ejecutando pruebas..."
# Aquí añadirías los comandos para ejecutar tus pruebas.
# Por ejemplo, si usas pytest:
pytest --maxfail=1 --disable-warnings || exit 1
