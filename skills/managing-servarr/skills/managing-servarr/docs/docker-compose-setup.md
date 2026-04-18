<!-- Source: Authored — full Docker Compose templates for media stack -->

# Docker Compose Setup

## Full Stack (Recommended)

Complete media stack with all services:

```yaml
version: "3.8"

services:
  # === Indexer Management ===
  prowlarr:
    image: lscr.io/linuxserver/prowlarr:latest
    container_name: prowlarr
    environment: &env
      PUID: "1000"
      PGID: "1000"
      TZ: "America/New_York"
    ports:
      - "9696:9696"
    volumes:
      - ./config/prowlarr:/config
    networks: [media]
    restart: unless-stopped

  # === TV Shows ===
  sonarr:
    image: lscr.io/linuxserver/sonarr:latest
    container_name: sonarr
    environment: *env
    ports:
      - "8989:8989"
    volumes:
      - ./config/sonarr:/config
      - /path/to/data:/data
    networks: [media]
    restart: unless-stopped

  # === Movies ===
  radarr:
    image: lscr.io/linuxserver/radarr:latest
    container_name: radarr
    environment: *env
    ports:
      - "7878:7878"
    volumes:
      - ./config/radarr:/config
      - /path/to/data:/data
    networks: [media]
    restart: unless-stopped

  # === Music ===
  lidarr:
    image: lscr.io/linuxserver/lidarr:latest
    container_name: lidarr
    environment: *env
    ports:
      - "8686:8686"
    volumes:
      - ./config/lidarr:/config
      - /path/to/data:/data
    networks: [media]
    restart: unless-stopped

  # === Download Client ===
  qbittorrent:
    image: lscr.io/linuxserver/qbittorrent:latest
    container_name: qbittorrent
    environment:
      <<: *env
      WEBUI_PORT: "8080"
    ports:
      - "8080:8080"
      - "6881:6881"
      - "6881:6881/udp"
    volumes:
      - ./config/qbittorrent:/config
      - /path/to/data/torrents:/data/torrents
    networks: [media]
    restart: unless-stopped

  # === Subtitles ===
  bazarr:
    image: lscr.io/linuxserver/bazarr:latest
    container_name: bazarr
    environment: *env
    ports:
      - "6767:6767"
    volumes:
      - ./config/bazarr:/config
      - /path/to/data/media:/data/media
    networks: [media]
    restart: unless-stopped

  # === Media Server ===
  plex:
    image: lscr.io/linuxserver/plex:latest
    container_name: plex
    network_mode: host
    environment:
      <<: *env
      VERSION: docker
    volumes:
      - ./config/plex:/config
      - /path/to/data/media:/data/media
    restart: unless-stopped

  # === Request Management ===
  overseerr:
    image: lscr.io/linuxserver/overseerr:latest
    container_name: overseerr
    environment: *env
    ports:
      - "5055:5055"
    volumes:
      - ./config/overseerr:/config
    networks: [media]
    restart: unless-stopped

networks:
  media:
    driver: bridge
```

## Directory Structure on Host

```bash
# Create the directory structure before starting
mkdir -p config/{sonarr,radarr,lidarr,prowlarr,qbittorrent,bazarr,plex,overseerr}
mkdir -p /path/to/data/{torrents/{movies,tv,music},media/{movies,tv,music}}
```

## Volume Mapping Strategy

All services share a common `/data` mount to enable hardlinks:

```
Host: /path/to/data/          → Container: /data/
  ├── torrents/                  Downloads land here
  │   ├── movies/
  │   ├── tv/
  │   └── music/
  └── media/                     Final organized media
      ├── movies/
      ├── tv/
      └── music/
```

**Why hardlinks matter**: When Sonarr/Radarr "imports" a download, it creates a hardlink instead of copying the file. This is instant and uses no additional disk space. Both the torrent file (for seeding) and the organized file point to the same data on disk.

**Requirement**: Both paths must be on the same filesystem/partition.

## PUID/PGID

LinuxServer.io images use PUID/PGID to run as a specific user:

```bash
# Find your user's IDs
id $USER
# uid=1000(user) gid=1000(user)
```

Set these in the environment to match your host user. This ensures file permissions work correctly across all containers.

## Starting the Stack

```bash
# Start all services
docker compose up -d

# Check status
docker compose ps

# View logs
docker compose logs -f sonarr

# Update all images
docker compose pull && docker compose up -d

# Restart a single service
docker compose restart radarr
```

## Minimal Stack (Sonarr + Radarr + Prowlarr)

For a simpler setup without music, subtitles, or request management:

```yaml
version: "3.8"
services:
  prowlarr:
    image: lscr.io/linuxserver/prowlarr:latest
    ports: ["9696:9696"]
    volumes: ["./config/prowlarr:/config"]
    environment: &env { PUID: "1000", PGID: "1000", TZ: "America/New_York" }
    networks: [media]
    restart: unless-stopped
  sonarr:
    image: lscr.io/linuxserver/sonarr:latest
    ports: ["8989:8989"]
    volumes: ["./config/sonarr:/config", "/path/to/data:/data"]
    environment: *env
    networks: [media]
    restart: unless-stopped
  radarr:
    image: lscr.io/linuxserver/radarr:latest
    ports: ["7878:7878"]
    volumes: ["./config/radarr:/config", "/path/to/data:/data"]
    environment: *env
    networks: [media]
    restart: unless-stopped
  qbittorrent:
    image: lscr.io/linuxserver/qbittorrent:latest
    ports: ["8080:8080", "6881:6881", "6881:6881/udp"]
    volumes: ["./config/qbittorrent:/config", "/path/to/data/torrents:/data/torrents"]
    environment:
      <<: *env
      WEBUI_PORT: "8080"
    networks: [media]
    restart: unless-stopped
networks:
  media:
```

## With VPN (Gluetun)

Route qBittorrent traffic through a VPN:

```yaml
gluetun:
  image: qmcgaw/gluetun:latest
  container_name: gluetun
  cap_add: [NET_ADMIN]
  environment:
    - VPN_SERVICE_PROVIDER=your-provider
    - VPN_TYPE=wireguard
    - WIREGUARD_PRIVATE_KEY=your-key
    - SERVER_COUNTRIES=Netherlands
  ports:
    - "8080:8080"  # qBittorrent WebUI (exposed through gluetun)
    - "6881:6881"
  networks: [media]
  restart: unless-stopped

qbittorrent:
  image: lscr.io/linuxserver/qbittorrent:latest
  container_name: qbittorrent
  network_mode: "service:gluetun"  # Route through VPN
  environment:
    <<: *env
    WEBUI_PORT: "8080"
  volumes:
    - ./config/qbittorrent:/config
    - /path/to/data/torrents:/data/torrents
  depends_on:
    - gluetun
  restart: unless-stopped
```
