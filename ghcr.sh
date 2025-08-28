#!/bin/bash
set -e

MIN_MAJOR=1
MIN_MINOR=8

# If no versions provided, fetch all
if [ -z "$1" ]; then
  echo "[imagery:info] No versions specified. Fetching all releases..."
  VERSIONS=$(curl -s https://launchermeta.mojang.com/mc/game/version_manifest.json \
    | jq -r '.versions | sort_by(.releaseTime)[] | select(.type=="release") | .id')
else
  VERSIONS="$@"
fi

# Filter out versions <1.8
FILTERED_VERSIONS=""
for v in $VERSIONS; do
  MAJOR=$(echo "$v" | cut -d. -f1)
  MINOR=$(echo "$v" | cut -d. -f2)
  if [ "$MAJOR" -gt $MIN_MAJOR ] || { [ "$MAJOR" -eq $MIN_MAJOR ] && [ "$MINOR" -ge $MIN_MINOR ]; }; then
    FILTERED_VERSIONS="$FILTERED_VERSIONS $v"
  fi
done

for v in $FILTERED_VERSIONS; do
  echo "[imagery:build] Building $v..."
  docker build --build-arg VERSION="$v" -t ghcr.io/myferr/mc-server:"$v" .
  docker push ghcr.io/myferr/mc-server:"$v"
done

# Tag latest as the newest built version
LATEST=$(echo "$FILTERED_VERSIONS" | awk '{print $NF}')
docker tag ghcr.io/myferr/mc-server:"$LATEST" ghcr.io/myferr/mc-server:latest
docker push ghcr.io/myferr/mc-server:latest

echo "[imagery:done] Built and pushed images for versions:"
echo "$FILTERED_VERSIONS"
