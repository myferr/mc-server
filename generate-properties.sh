#!/bin/bash
set -e

echo "eula=true" > eula.txt

cat > server.properties <<EOF
hardcore=${HARDCORE:-false}
gamemode=${GAMEMODE:-survival}
allow-cheats=${CHEATS:-false}
max-players=${MAXPLAYERS:-20}
motd=${MOTD:-Welcome to my server!}
EOF

echo "[imagery:info] Generated server.properties:"
cat server.properties
