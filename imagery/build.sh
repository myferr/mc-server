#!/bin/bash
set -e

# Versions in chronological order
VERSIONS=("1.19" "1.19.1" "1.19.2" "1.19.3" "1.19.4" "1.20" "1.20.1" "1.20.2" "1.20.3" "1.20.4" "1.20.5" "1.20.6" "1.21" "1.21.1" "1.21.2" "1.21.3" "1.21.4" "1.21.5" "1.21.6" "1.21.7" "1.21.8")

LAST_INDEX=$((${#VERSIONS[@]} - 1))
LAST_VERSION=${VERSIONS[$LAST_INDEX]}

for VERSION in "${VERSIONS[@]}"; do
  echo "[imagery:info] Building mc-server:$VERSION ..."

  # Tag 'latest' only for the newest version
  if [ "$VERSION" == "$LAST_VERSION" ]; then
    ./imagery.sh "$VERSION" "mc-server-$VERSION" latest
  else
    ./imagery.sh "$VERSION" "mc-server-$VERSION"
  fi

  echo "[imagery:info] mc-server:$VERSION completed."
done

echo "[imagery:info] All versions built and pushed successfully."
