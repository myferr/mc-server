#!/bin/bash
set -euo pipefail

MIN_MAJOR=1
MIN_MINOR=8

Versions() {
    curl -s https://launchermeta.mojang.com/mc/game/version_manifest.json | jq -r '.versions | sort_by(.releaseTime)[] | select(.type=="release") | .id'
}

Run() {
    local command="$1"
    if ! eval "$command"; then
        echo "Error running command: $command" >&2
        return 1
    fi
}

VersionValidation() {
    local version="$1"
    local major minor
    IFS='.' read -r major minor _ <<< "$version"
    if (( major < MIN_MAJOR )) || (( major == MIN_MAJOR && minor < MIN_MINOR )); then
        return 1
    fi
    return 0
}

Colorize() {
    local text="$1"
    local color="$2"
    case $color in
        red) echo -e "\033[0;31m$text\033[0m" ;;
        green) echo -e "\033[0;32m$text\033[0m" ;;
        yellow) echo -e "\033[1;33m$text\033[0m" ;;
        blue) echo -e "\033[0;34m$text\033[0m" ;;
        magenta) echo -e "\033[0;35m$text\033[0m" ;;
        cyan) echo -e "\033[0;36m$text\033[0m" ;;
        white) echo -e "\033[0;37m$text\033[0m" ;;
        *) echo "$text" ;;
    esac
}

Push() {
    local version="$1"
    echo "[$(Colorize 'docker' 'blue')] Pushing version $(Colorize "$version" 'green')"
    Run "docker build --build-arg VERSION=$version -t myferr/mc-server:$version ."
    Run "docker push myferr/mc-server:$version"
    Run "docker tag myferr/mc-server:$version myferr/mc-server:latest"
    Run "docker push myferr/mc-server:latest"
    echo "[$(Colorize 'docker' 'blue')] Pushed version $(Colorize "$version" 'green')"

    echo "[$(Colorize 'ghcr' 'blue')] Pushing version $(Colorize "$version" 'green')"
    Run "docker build --build-arg VERSION=$version -t ghcr.io/myferr/mc-server:$version ."
    Run "docker push ghcr.io/myferr/mc-server:$version"
    Run "docker tag ghcr.io/myferr/mc-server:$version ghcr.io/myferr/mc-server:latest"
    Run "docker push ghcr.io/myferr/mc-server:latest"
    echo "[$(Colorize 'ghcr' 'blue')] Pushed version $(Colorize "$version" 'green')"
}

main() {
    local version
    while IFS= read -r version; do
        if VersionValidation "$version"; then
            Push "$version"
        fi
    done < <(Versions)
}

main "$@"