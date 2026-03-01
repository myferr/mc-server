FROM eclipse-temurin:21-jre AS runtime

WORKDIR /server

ARG VERSION
ARG PAPER_BUILD

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl jq && \
    rm -rf /var/lib/apt/lists/*

# Create plugins directory
RUN mkdir -p /server/plugins

# Download server jar dynamically
RUN set -eux; \
    # Enforce minimum version 1.8
    MAJOR=$(echo "$VERSION" | cut -d. -f1); \
    MINOR=$(echo "$VERSION" | cut -d. -f2); \
    if [ "$MAJOR" -lt 1 ] || { [ "$MAJOR" -eq 1 ] && [ "$MINOR" -lt 8 ]; }; then \
        echo "[error] Version $VERSION not supported, must be >=1.8"; exit 1; \
    fi; \
    # Check if this is a PaperMC version
    if [[ "$VERSION" == paper-* ]]; then \
        # Extract minecraft version from paper-<version>
        MC_VERSION="${VERSION#paper-}"; \
        echo "Downloading PaperMC for Minecraft $MC_VERSION"; \
        PAPERS_API="https://api.papermc.io/v2/projects/paper/versions/$MC_VERSION"; \
        BUILD=$(curl -sSL "$PAPERS_API/builds" | jq -r '.builds[-1].build' | head -n1); \
        if [ -z "$BUILD" ] || [ "$BUILD" = "null" ]; then \
            echo "[error] Could not find PaperMC build for version $MC_VERSION"; exit 1; \
        fi; \
        JAR_URL="https://api.papermc.io/v2/projects/paper/versions/$MC_VERSION/builds/$BUILD/downloads/paper-$MC_VERSION-$BUILD.jar"; \
        curl -o server.jar "$JAR_URL"; \
    else \
        # Standard Mojang server
        echo "Downloading standard Minecraft server $VERSION"; \
        MANIFEST_URL="https://launchermeta.mojang.com/mc/game/version_manifest.json"; \
        MANIFEST=$(curl -sSL $MANIFEST_URL); \
        VERSION_INFO=$(echo "$MANIFEST" | jq -r --arg ver "$VERSION" '.versions[] | select(.id==$ver) | .url'); \
        if [ -z "$VERSION_INFO" ] || [ "$VERSION_INFO" = "null" ]; then \
            echo "[error] Version $VERSION not found in manifest."; exit 1; \
        fi; \
        SERVER_URL=$(curl -sSL "$VERSION_INFO" | jq -r '.downloads.server.url'); \
        curl -o server.jar "$SERVER_URL"; \
    fi

# Copy startup script
COPY generate-properties.sh /usr/local/bin/generate-properties.sh
RUN chmod +x /usr/local/bin/generate-properties.sh

EXPOSE 25565

CMD ["/bin/bash", "-c", "generate-properties.sh && java -Xmx2G -Xms2G -jar server.jar nogui"]
