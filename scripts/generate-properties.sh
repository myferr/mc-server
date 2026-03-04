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

# Download plugins if PLUGINS_URL is set
if [ -n "$PLUGINS_URL" ]; then
    echo "[info] Downloading plugins from $PLUGINS_URL"
    mkdir -p /server/plugins
    IFS=',' read -ra PLUGIN_URLS <<< "$PLUGINS_URL"
    for url in "${PLUGIN_URLS[@]}"; do
        url=$(echo "$url" | xargs)
        if [ -n "$url" ]; then
            echo "[info] Downloading plugin: $url"
            filename=$(basename "$url")
            curl -sSL -o "/server/plugins/$filename" "$url"
        fi
    done
    echo "[info] Plugins downloaded successfully"
fi

echo "[imagery:info] Generated server.properties:"
cat server.properties
