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

## License

This project is licensed under the MIT license and is completely open-source.
