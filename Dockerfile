FROM eclipse-temurin:21-jre AS runtime

WORKDIR /server

# Download Minecraft server jar dynamically
ARG VERSION
RUN curl -s https://launchermeta.mojang.com/mc/game/version_manifest.json \
    | jq -r --arg v "$VERSION" '.versions[] | select(.id==$v) | .url' \
    | xargs curl -s \
    | jq -r '.downloads.server.url' \
    | xargs curl -o server.jar

# Copy in startup and properties generator
COPY generate-properties.sh /usr/local/bin/generate-properties.sh
RUN chmod +x /usr/local/bin/generate-properties.sh

EXPOSE 25565

CMD ["/bin/bash", "-c", "generate-properties.sh && java -Xmx2G -Xms2G -jar server.jar nogui"]
