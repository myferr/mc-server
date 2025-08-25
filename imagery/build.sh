#!/bin/bash
set -e

# Versions in chronological order
VERSIONS=("1.21.5" "1.21.6" "1.21.7" "1.21.8")

for VERSION in "${VERSIONS[@]}"; do
  echo "[imagery:info] Building mc-server:$VERSION ..."

  # Generates image and pushes
  ./imagery.sh "$VERSION" "mc-server-$VERSION" latest

  echo "[imagery:info] mc-server:$VERSION completed."
done

echo "[imagery:info] All versions built and pushed successfully."
