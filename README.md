![](https://github.com/user-attachments/assets/4e6d9da8-3598-4260-be27-187963bcce9a)

# 🐳 mc-server
Minecraft servers in Docker

[![Docker Pulls](https://img.shields.io/docker/pulls/myferr/mc-server.svg?logo=docker)](https://hub.docker.com/r/myferr/mc-server/)
[![Docker Stars](https://img.shields.io/docker/stars/myferr/mc-server.svg?logo=docker)](https://hub.docker.com/r/myferr/mc-server/)
[![GitHub Issues](https://img.shields.io/github/issues-raw/myferr/mc-server.svg)](https://github.com/myferr/mc-server/issues)

- Prebuilt Docker images for multiple Minecraft versions
- Minimal Docker Compose setup
- Quick startup and ready-to-play

> [!TIP]
> When creating your Docker Compose or starting the server, use a supported version as the `image` tag. Like `myferr/mc-server:1.21.6`, `myferr/mc-server:1.20.6`, `myferr/mc-server:1.19.4`, etc.

## Quick Start

### Pull & Run with Docker
```bash
docker run -d -p 25565:25565 --name mc-server myferr/mc-server:1.21.6
```

### Minimal Docker Compose

```yaml
services:
  mc-server:
    image: myferr/mc-server:1.21.6
    container_name: mc-server
    ports:
      - "25565:25565"
```

Start the server:

```bash
docker compose up -d
```

## Configuration

You can configure the Minecraft server through environment variables in either `docker run` or `docker-compose.yml`.

### Supported Variables

| Variable     | Values (examples)                                | Default                | Description                                                            |
| ------------ | ------------------------------------------------ | ---------------------- | ---------------------------------------------------------------------- |
| `DIFFICULTY` | `peaceful`, `easy`, `normal`, `hard`             | `easy`                 | Sets the difficulty level of the world.                                |
| `MOTD`       | Any string (e.g. `"Hello World!"`)               | `"Welcome to my server!"` | Message shown in the server list (supports formatting codes).          |
| `GAMEMODE`   | `survival`, `creative`, `adventure`, `spectator` | `survival`             | Sets the default gamemode for new players.                             |
| `HARDCORE`   | `true`, `false`                                  | `false`                | Enables or disables hardcore mode.                                     |

### Server icons
A Minecraft server icon is a visual representation of the game's logo or a custom design that can be used to identify the server in the server list, to apply the logo to the server just by placing it in the [`server-icon.png`](https://github.com/user-attachments/assets/7c7f73fd-46ef-406a-852f-aa35201bac29) file in the server directory. Make sure it's a `.png` and a `64x64` pixel size.

![](https://github.com/user-attachments/assets/4c9a9830-d5a9-4024-bebd-8fa94b59764e)

To apply a server icon in your Docker Compose add the following lines:

```yaml
    volumes:
      - ~/desktop/server-icon.png:/server/server-icon.png
```

Full example:
```yaml
services:
  mc-server:
    image: myferr/mc-server
    container_name: mc-server
    ports:
      - "25565:25565"
    volumes:
      - ~/desktop/server-icon.png:/server/server-icon.png
```


### Docker Run

```bash
docker run -d -p 25565:25565 \
  -e MOTD="Welcome to my server!" \
  -e DIFFICULTY=normal \
  -e GAMEMODE=survival \
  -e HARDCORE=false \
  myferr/mc-server:latest
```

### Docker Compose

```yaml
services:
  mc-server:
    image: myferr/mc-server:latest
    ports:
      - "25565:25565"
    environment:
      - DIFFICULTY=normal
      - MOTD=Welcome to my server!
      - GAMEMODE=survival
      - HARDCORE=false
```

## Supported Versions

| Version  | Supported? |
| -------- | ---------- |
| `1.21.8` | ✅          |
| `1.21.7` | ✅          |
| `1.21.6` | ✅          |
| `1.21.5` | ✅          |
| `1.21.4` | ✅          |
| `1.21.3` | ✅          |
| `1.21.2` | ✅          |
| `1.21.1` | ✅          |
| `1.21`   | ✅          |
| `1.20.6` | ✅          |
| `1.20.5` | ✅          |
| `1.20.4` | ✅          |
| `1.20.3` | ✅          |
| `1.20.2` | ✅          |
| `1.20.1` | ✅          |
| `1.20`   | ✅          |
| `1.19.4` | ✅          |
| `1.19.3` | ✅          |
| `1.19.2` | ✅          |
| `1.19.1` | ✅          |
| `1.19`   | ✅          |
| `1.18.2` | ✅          |
| `1.18.1` | ✅          |
| `1.18`   | ✅          |
| `1.17.1` | ✅          |
| `1.17`   | ✅          |
| `1.16.5` | ✅          |
| `1.16.4` | ✅          |
| `1.16.3` | ✅          |
| `1.16.2` | ✅          |
| `1.16.1` | ✅          |
| `1.16`   | ✅          |
| `1.15.2` | ✅          |
| `1.15.1` | ✅          |
| `1.15`   | ✅          |
| `1.14.4` | ✅          |
| `1.14.3` | ✅          |
| `1.14.2` | ✅          |
| `1.14.1` | ✅          |
| `1.14`   | ✅          |
| `1.13.2` | ✅          |
| `1.13.1` | ✅          |
| `1.13`   | ✅          |
| `1.12.2` | ✅          |
| `1.12.1` | ✅          |
| `1.12`   | ✅          |
| `1.11.2` | ✅          |
| `1.11.1` | ✅          |
| `1.11`   | ✅          |
| `1.10.2` | ✅          |
| `1.10.1` | ✅          |
| `1.10`   | ✅          |
| `1.9.4`  | ✅          |
| `1.9.3`  | ✅          |
| `1.9.2`  | ✅          |
| `1.9.1`  | ✅          |
| `1.9`    | ✅          |
| `1.8.9`  | ✅          |
| `1.8.8`  | ✅          |
| `1.8.7`  | ✅          |
| `1.8.6`  | ✅          |
| `1.8.5`  | ✅          |
| `1.8.4`  | ✅          |
| `1.8.3`  | ✅          |
| `1.8.2`  | ✅          |
| `1.8.1`  | ✅          |
| `1.8`    | ✅          |

---

## License

This project is licensed under the MIT license and is completely open-source.
