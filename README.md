![](https://github.com/user-attachments/assets/4e6d9da8-3598-4260-be27-187963bcce9a)

# 🐳 mc-server
Minecraft servers in Docker

[![Docker Pulls](https://img.shields.io/docker/pulls/myferr/mc-server.svg?logo=docker)](https://hub.docker.com/r/myferr/mc-server/)
[![Docker Stars](https://img.shields.io/docker/stars/myferr/mc-server.svg?logo=docker)](https://hub.docker.com/r/myferr/mc-server/)
[![GitHub Issues](https://img.shields.io/github/issues-raw/myferr/mc-server.svg)](https://github.com/myferr/mc-server/issues)

- Prebuilt Docker images for multiple Minecraft versions
- Minimal Docker Compose setup
- Quick startup and ready-to-play

## Supported Versions

| Version    | Supported?  |
| ---------- | ----------- |
| `1.21.8`   | ✅          |
| `1.21.7`   | ✅          |
| `1.21.6`   | ✅          |
| `1.21.5`   | ✅          |
| `1.21.4`   | ✅          |
| `1.21.3`   | ✅          |
| `1.21.2`   | ✅          |
| `1.21.1`   | ✅          |
| `1.21`     | ✅          |
| `1.20.6`   | ✅          |
| `1.20.5`   | ✅          |
| `1.20.4`   | ✅          |
| `1.20.3`   | ✅          |
| `1.20.2`   | ✅          |
| `1.20.1`   | ✅          |
| `1.20`     | ✅          |
| `1.19.4`   | ✅          |
| `1.19.3`   | ✅          |
| `1.19.2`   | ✅          |
| `1.19.1`   | ✅          |
| `1.19`     | ✅          |
| `1.18.2`   | ✅          |
| `1.18.1`   | ✅          |
| `1.18`     | ✅          |
| `1.16.5`   | ✅          |
| `1.16.4`   | ✅          |
| `1.16.3`   | ✅          |
| `1.16.2`   | ✅          |
| `1.16.1`   | ✅          |
| `1.16`     | ✅          |
| `1.15.2`   | ✅          |
| `1.15.1`   | ✅          |
| `1.15`     | ✅          |
| `1.14.4`   | ✅          |
| `1.14.3`   | ✅          |
| `1.14.2`   | ✅          |
| `1.14.1`   | ✅          |
| `1.14`     | ✅          |
| `1.13.2`   | ✅          |
| `1.13.1`   | ✅          |
| `1.13`     | ✅          |
| `1.12.2`   | ✅          |
| `1.12.1`   | ✅          |
| `1.12`     | ✅          |
| `1.17.1`   | ✅          |
| `1.17`     | ✅          |

> [!TIP]
> When creating your Docker Compose or starting the server, replace `1.21.6` with any [supported version](https://github.com/myferr/mc-server#supported-versions) you'd like.

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

## Tags

| Tag      | Description                   |
| -------- | ----------------------------- |
| `latest` | Always points to newest image |
| `1.21.8` | Minecraft 1.21.8 server       |
| `1.21.7` | Minecraft 1.21.7 server       |
| `1.21.6` | Minecraft 1.21.6 server       |
| `1.21.5` | Minecraft 1.21.5 server       |
| `1.21.4` | Minecraft 1.21.4 server       |
| `1.21.3` | Minecraft 1.21.3 server       |
| `1.21.2` | Minecraft 1.21.2 server       |
| `1.21.1` | Minecraft 1.21.1 server       |
| `1.21` | Minecraft 1.21 server       |
| `1.20.6` | Minecraft 1.20.6 server       |
| `1.20.5` | Minecraft 1.20.5 server       |
| `1.20.4` | Minecraft 1.20.4 server       |
| `1.20.3` | Minecraft 1.20.3 server       |
| `1.20.2` | Minecraft 1.20.2 server       |
| `1.20.1` | Minecraft 1.20.1 server       |
| `1.20` | Minecraft 1.20 server       |
| `1.19.4` | Minecraft 1.19.4 server       |
| `1.19.3` | Minecraft 1.19.3 server       |
| `1.19.2` | Minecraft 1.19.2 server       |
| `1.19.1` | Minecraft 1.19.1 server       |
| `1.19` | Minecraft 1.19 server       |
| `1.18.2` | Minecraft 1.18.2 server       |
| `1.18.1` | Minecraft 1.18.1 server       |
| `1.18` | Minecraft 1.18 server       |
| `1.16.5` | Minecraft 1.16.5 server       |
| `1.16.4` | Minecraft 1.16.4 server       |
| `1.16.3` | Minecraft 1.16.3 server       |
| `1.16.2` | Minecraft 1.16.2 server       |
| `1.16.1` | Minecraft 1.16.1 server       |
| `1.16` | Minecraft 1.16 server       |
| `1.15.2` | Minecraft 1.15.2 server       |
| `1.15.1` | Minecraft 1.15.1 server       |
| `1.15` | Minecraft 1.15 server       |
| `1.14.4` | Minecraft 1.14.4 server       |
| `1.14.3` | Minecraft 1.14.3 server       |
| `1.14.2` | Minecraft 1.14.2 server       |
| `1.14.1` | Minecraft 1.14.1 server       |
| `1.14` | Minecraft 1.14 server       |
| `1.13.2` | Minecraft 1.13.2 server       |
| `1.13.1` | Minecraft 1.13.1 server       |
| `1.13` | Minecraft 1.13 server       |
| `1.12.2` | Minecraft 1.12.2 server       |
| `1.12.1` | Minecraft 1.12.1 server       |
| `1.12` | Minecraft 1.12 server       |
| `1.17.1` | Minecraft 1.17.1 server       |
| `1.17` | Minecraft 1.17 server       |

## License

This project is licensed under the MIT license and is completely open-source.
