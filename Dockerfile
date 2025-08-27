FROM eclipse-temurin:21-jre AS runtime

WORKDIR /server

ARG VERSION

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl jq && \
    rm -rf /var/lib/apt/lists/*

# Download server jar dynamically
RUN set -eux; \
    # Enforce minimum version 1.8
    MAJOR=$(echo "$VERSION" | cut -d. -f1); \
    MINOR=$(echo "$VERSION" | cut -d. -f2); \
    if [ "$MAJOR" -lt 1 ] || { [ "$MAJOR" -eq 1 ] && [ "$MINOR" -lt 8 ]; }; then \
        echo "[error] Version $VERSION not supported, must be >=1.8"; exit 1; \
    fi; \
    MANIFEST_URL="https://launchermeta.mojang.com/mc/game/version_manifest.json"; \
    MANIFEST=$(curl -sSL $MANIFEST_URL); \
    VERSION_INFO=$(echo "$MANIFEST" | jq -r --arg ver "$VERSION" '.versions[] | select(.id==$ver) | .url'); \
    if [ -z "$VERSION_INFO" ] || [ "$VERSION_INFO" = "null" ]; then \
        echo "[error] Version $VERSION not found in manifest."; exit 1; \
    fi; \
    SERVER_URL=$(curl -sSL "$VERSION_INFO" | jq -r '.downloads.server.url'); \
    curl -o server.jar "$SERVER_URL"

# Copy startup script
COPY generate-properties.sh /usr/local/bin/generate-properties.sh
RUN chmod +x /usr/local/bin/generate-properties.sh

EXPOSE 25565

CMD ["/bin/bash", "-c", "generate-properties.sh && java -Xmx2G -Xms2G -jar server.jar nogui"]
