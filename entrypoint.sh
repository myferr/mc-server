#!/bin/bash
set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

if [ ! -f "/server/server.jar" ]; then
    print_status "Server JAR not found, downloading..."
    
    VERSION=$(echo "$0" | grep -oE "(paper-[0-9]+\.[0-9]+\.[0-9]+|[0-9]+\.[0-9]+\.[0-9]+)$" | head -n1 || echo "latest")
    
    if [ -z "$VERSION" ] || [ "$VERSION" = "latest" ]; then
        VERSION="latest"
        print_warning "Using latest version. This will download the latest stable Minecraft server."
        
        MANIFEST_URL="https://launchermeta.mojang.com/mc/game/version_manifest.json"
        MANIFEST=$(curl -sSL "$MANIFEST_URL")
        LATEST_VERSION=$(echo "$MANIFEST" | jq -r '.latest.release')
        VERSION_INFO=$(echo "$MANIFEST" | jq -r --arg ver "$LATEST_VERSION" '.versions[] | select(.id==$ver) | .url')
        
        if [ -z "$VERSION_INFO" ] || [ "$VERSION_INFO" = "null" ]; then
            print_error "Could not find latest version in manifest."
            exit 1
        fi
        
        SERVER_URL=$(curl -sSL "$VERSION_INFO" | jq -r '.downloads.server.url')
        curl -o /server/server.jar "$SERVER_URL"
        print_status "Downloaded latest Minecraft server.jar successfully"
        
    else
        if [[ "$VERSION" == paper-* ]]; then
            MC_VERSION="${VERSION#paper-}"
            print_status "Downloading PaperMC for Minecraft $MC_VERSION"
            
            PAPERS_API="https://api.papermc.io/v2/projects/paper/versions/$MC_VERSION"
            BUILD=$(curl -sSL "$PAPERS_API/builds" | jq -r '.builds[-1].build' | head -n1)
            
            if [ -z "$BUILD" ] || [ "$BUILD" = "null" ]; then
                print_error "Could not find PaperMC build for version $MC_VERSION"
                exit 1
            fi
            
            JAR_URL="https://api.papermc.io/v2/projects/paper/versions/$MC_VERSION/builds/$BUILD/downloads/paper-$MC_VERSION-$BUILD.jar"
            curl -o /server/server.jar "$JAR_URL"
            print_status "Downloaded PaperMC server.jar successfully"
            
        else
            print_status "Downloading standard Minecraft server $VERSION"
            
            MANIFEST_URL="https://launchermeta.mojang.com/mc/game/version_manifest.json"
            MANIFEST=$(curl -sSL "$MANIFEST_URL")
            VERSION_INFO=$(echo "$MANIFEST" | jq -r --arg ver "$VERSION" '.versions[] | select(.id==$ver) | .url')
            
            if [ -z "$VERSION_INFO" ] || [ "$VERSION_INFO" = "null" ]; then
                print_error "Version $VERSION not found in manifest."
                exit 1
            fi
            
            SERVER_URL=$(curl -sSL "$VERSION_INFO" | jq -r '.downloads.server.url')
            curl -o /server/server.jar "$SERVER_URL"
            print_status "Downloaded Minecraft server.jar successfully"
        fi
    fi
    
    echo "eula=true" > /server/eula.txt
else
    print_status "Server JAR already exists, skipping download"
fi

if [ -f "/usr/local/bin/generate-properties.sh" ]; then
    print_status "Generating server properties"
    /usr/local/bin/generate-properties.sh
fi

print_status "Starting Minecraft server..."
exec java -Xmx2G -Xms2G -jar /server/server.jar nogui