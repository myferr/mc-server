#!/bin/bash

# If parameters are not provided
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "[imagery:error] Missing parameters."
  exit 1
fi

# Generate Image
if command -v bun &> /dev/null; then
  bun generate-image.js "$1" "$2"
elif command -v node &> /dev/null; then
  node generate-image.js "$1" "$2"
else
  echo "[imagery:error] Neither bun nor node is installed."
  exit 1
fi

# If docker is installed
if command -v docker &> /dev/null; then
    echo "[imagery:info] Docker is installed. Proceeding."
# If docker is not installed
else
    echo "[imagery:error] Docker is not installed."
    exit 1
fi

docker tag "$2" myferr/mc-server:"$1"

if [ "$3" == "latest" ]; then
    docker tag "$2" myferr/mc-server:latest
fi

docker push myferr/mc-server:"$1"

if [ "$3" == "latest" ]; then
    docker push myferr/mc-server:latest
fi

rm -rf "$2"

echo "[imagery:info] Image generation completed."
