FROM eclipse-temurin:21-jre AS runtime

ARG VERSION

WORKDIR /server

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl jq && \
    rm -rf /var/lib/apt/lists/*

# Create plugins directory
RUN mkdir -p /server/plugins

# Copy entrypoint script
COPY scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 25565

# Copy properties generation script
COPY scripts/generate-properties.sh /usr/local/bin/generate-properties.sh
RUN chmod +x /usr/local/bin/generate-properties.sh

# Set environment variable for version
ENV MC_VERSION=${VERSION:-latest}

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["java", "-Xmx2G", "-Xms2G", "-jar", "server.jar", "nogui"]
