#!/bin/bash
set -e

# If no versions provided, fetch all
if [ -z "$1" ]; then
  echo "[imagery:info] No versions specified. Fetching all releases..."
  VERSIONS=$(curl -s https://launchermeta.mojang.com/mc/game/version_manifest.json \
    | jq -r '.versions | sort_by(.releaseTime)[] | select(.type=="release") | .id')
else
  VERSIONS="$@"
fi

for v in $VERSIONS; do
  echo "[imagery:build] Building $v..."
  docker build --build-arg VERSION="$v" -t myferr/mc-server:"$v" .
  docker push myferr/mc-server:"$v"
done

# Tag latest as the newest built version
LATEST=$(echo "$VERSIONS" | tail -n1)
docker tag myferr/mc-server:"$LATEST" myferr/mc-server:latest
docker push myferr/mc-server:latest

echo "[imagery:done] Built and pushed images for versions:"
echo "$VERSIONS"
