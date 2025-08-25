#!/bin/bash
set -euo pipefail

if [ -z "${GITHUB_USER:-}" ]; then
  echo "[imagery:error] GITHUB_USER must be set as an env var."
  exit 1
fi

if [ -z "${CR_PAT:-}" ]; then
  echo "[imagery:error] CR_PAT must be set as an env var."
  exit 1
fi

echo "$CR_PAT" | docker login ghcr.io -u "$GITHUB_USER" --password-stdin

# Versions in chronological order
VERSIONS=("1.21" "1.21.1" "1.21.2" "1.21.3" "1.21.4" "1.21.5" "1.21.6" "1.21.7" "1.21.8")

IMAGE_NAME="ghcr.io/$GITHUB_USER/mc-server"

LAST_INDEX=$((${#VERSIONS[@]} - 1))
LAST_VERSION=${VERSIONS[$LAST_INDEX]}

for VERSION in "${VERSIONS[@]}"; do
  echo "[imagery:info] Building mc-server:$VERSION ..."

  if [ "$VERSION" == "$LAST_VERSION" ]; then
    ./imagery.sh "$VERSION" "mc-server-$VERSION" latest
    docker tag "mc-server-$VERSION" "$IMAGE_NAME:$VERSION"
    docker tag "mc-server-$VERSION" "$IMAGE_NAME:latest"
    docker push "$IMAGE_NAME:$VERSION"
    docker push "$IMAGE_NAME:latest"
  else
    ./imagery.sh "$VERSION" "mc-server-$VERSION"
    docker tag "mc-server-$VERSION" "$IMAGE_NAME:$VERSION"
    docker push "$IMAGE_NAME:$VERSION"
  fi

  echo "[imagery:info] mc-server:$VERSION pushed to GHCR."
done

echo "[imagery:info] All versions built and pushed successfully."
