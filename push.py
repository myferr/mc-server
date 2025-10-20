import os
import colorama

MIN_MAJOR = 1
MIN_MINOR = 8


def Versions():
    return (
        os.popen(
            "curl -s https://launchermeta.mojang.com/mc/game/version_manifest.json | jq -r '.versions | sort_by(.releaseTime)[] | select(.type==\"release\") | .id'"
        )
        .read()
        .splitlines()
    )


def Run(command: str):
    try:
        _ = os.system(command)
    except Exception as e:
        print(f"Error running command: {command}")
        print(f"Error message: {e}")


def VersionValidation(version: str):
    major, minor = map(int, version.split(".")[:2])
    if major < MIN_MAJOR or (major == MIN_MAJOR and minor < MIN_MINOR):
        return False
    return True


def Colorize(text: str, color: str):
    colorama.init()
    if color == "red":
        return colorama.Fore.RED + text + colorama.Style.RESET_ALL
    elif color == "green":
        return colorama.Fore.GREEN + text + colorama.Style.RESET_ALL
    elif color == "yellow":
        return colorama.Fore.YELLOW + text + colorama.Style.RESET_ALL
    elif color == "blue":
        return colorama.Fore.BLUE + text + colorama.Style.RESET_ALL
    elif color == "magenta":
        return colorama.Fore.MAGENTA + text + colorama.Style.RESET_ALL
    elif color == "cyan":
        return colorama.Fore.CYAN + text + colorama.Style.RESET_ALL
    elif color == "white":
        return colorama.Fore.WHITE + text + colorama.Style.RESET_ALL
    else:
        return text


def Push(version: str):
    print(
        f"[{Colorize('docker', 'blue')}] Pushing version {Colorize(version, 'green')}"
    )
    Run(f"docker build --build-arg VERSION={version} -t myferr/mc-server:{version} .")
    Run(f"docker push myferr/mc-server:{version}")
    Run(f"docker tag myferr/mc-server:{version} myferr/mc-server:latest")
    Run("docker push myferr/mc-server:latest")
    print(f"[{Colorize('docker', 'blue')}] Pushed version {Colorize(version, 'green')}")

    print(f"[{Colorize('ghcr', 'blue')}] Pushing version {Colorize(version, 'green')}")
    Run(
        f"docker build --build-arg VERSION={version} -t ghcr.io/myferr/mc-server:{version} ."
    )
    Run(f"docker push ghcr.io/myferr/mc-server:{version}")
    Run(
        f"docker tag ghcr.io/myferr/mc-server:{version} ghcr.io/myferr/mc-server:latest"
    )
    Run("docker push ghcr.io/myferr/mc-server:latest")
    print(f"[{Colorize('ghcr', 'blue')}] Pushed version {Colorize(version, 'green')}")


VERSIONS = Versions()

count = 0

for version in VERSIONS:
    major, minor = map(int, version.split(".")[:2])

    if not VersionValidation(version):
        continue

    Push(version)
