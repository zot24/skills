---
name: managing-servarr
description: Deploy, configure, and manage the full media stack — Sonarr, Radarr, Lidarr, Prowlarr, Plex, Overseerr, qBittorrent, Bazarr, Recyclarr. Use when setting up media automation, quality profiles, indexers, Docker stacks, or managing a media server. Triggers on mentions of Sonarr, Radarr, Lidarr, Prowlarr, Plex, Overseerr, *arr, servarr, media library, quality profiles, TRaSH Guides, media server, NAS.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# Managing Servarr

Expert at deploying and managing the complete media automation stack.

## Overview

The media stack follows a pipeline: **Acquire → Organize → Serve → Request**

- **Prowlarr** — Unified indexer manager, syncs to all *arr apps (port 9696)
- **Sonarr** — TV show monitoring and download automation (port 8989)
- **Radarr** — Movie monitoring and download automation (port 7878)
- **Lidarr** — Music collection management (port 8686)
- **qBittorrent** — Download client for torrents (port 8080)
- **Bazarr** — Automatic subtitle downloads (port 6767)
- **Recyclarr** — Sync TRaSH Guides quality profiles (CLI)
- **Plex** — Media server for playback and transcoding (port 32400)
- **Overseerr** — User request management → triggers acquisition (port 5055)

## Quick Start

```yaml
# docker-compose.yml (minimal stack)
services:
  sonarr:
    image: lscr.io/linuxserver/sonarr:latest
    ports: ["8989:8989"]
    volumes: ["/path/to/data:/data", "./config/sonarr:/config"]
    environment: &env { PUID: "1000", PGID: "1000", TZ: "America/New_York" }
  radarr:
    image: lscr.io/linuxserver/radarr:latest
    ports: ["7878:7878"]
    volumes: ["/path/to/data:/data", "./config/radarr:/config"]
    environment: *env
  prowlarr:
    image: lscr.io/linuxserver/prowlarr:latest
    ports: ["9696:9696"]
    volumes: ["./config/prowlarr:/config"]
    environment: *env
```

## API Pattern

All *arr apps use the same authentication and API style:

```bash
curl -H "X-Api-Key: YOUR_API_KEY" http://localhost:PORT/api/v3/ENDPOINT
```

API keys are found in each app under **Settings → General → Security**.

## Core Concepts

**Quality Profiles** — Define acceptable release qualities (720p, 1080p, 4K). Use Recyclarr + TRaSH Guides for optimized defaults.

**Root Folders** — Where media files are stored. Use a shared `/data` mount for hardlinks.

**Indexers** — Configured centrally in Prowlarr, synced to all apps automatically.

**Download Clients** — qBittorrent/SABnzbd configured in each app under Settings → Download Clients.

**Remote Path Mappings** — Translate paths between apps when running on different hosts or containers.

## Documentation

- **[Stack Overview](docs/stack-overview.md)** — Architecture and data flow
- **[Docker Compose Setup](docs/docker-compose-setup.md)** — Full deployment templates
- **[Sonarr](docs/sonarr.md)** — Overview ([settings](docs/sonarr/settings.md), [installation](docs/sonarr/installation.md), [FAQ](docs/sonarr/faq.md), [system](docs/sonarr/system.md))
- **[Radarr](docs/radarr.md)** — Overview ([settings](docs/radarr/settings.md), [installation](docs/radarr/installation.md), [FAQ](docs/radarr/faq.md), [quick start](docs/radarr/quick-start-guide.md))
- **[Lidarr](docs/lidarr.md)** — Overview ([installation](docs/lidarr/installation.md), [troubleshooting](docs/lidarr/troubleshooting.md))
- **[Prowlarr](docs/prowlarr.md)** — Overview ([installation](docs/prowlarr/installation.md), [FAQ](docs/prowlarr/faq.md), [indexers](docs/prowlarr/supported-indexers.md))
- **[Plex](docs/plex.md)** — Media server setup and library management
- **[Overseerr](docs/overseerr.md)** — Request management
- **[qBittorrent](docs/qbittorrent.md)** — Download client configuration
- **[Bazarr](docs/bazarr.md)** — Subtitle management
- **[Quality Profiles](docs/quality-profiles.md)** — TRaSH Guides best practices
- **[Recyclarr Config](docs/recyclarr-config.md)** — Recyclarr setup and guide configs
- **[Hardlinks Guide](docs/hardlinks-guide.md)** — TRaSH folder structure for instant moves
- **[API Reference](docs/api-reference.md)** — Shared API v3 patterns
- **[Troubleshooting](docs/troubleshooting.md)** — Common issues and fixes
- **[Remote Management](docs/remote-management.md)** — Laptop→NAS patterns

## Common Workflows

### Wire up the full stack
1. Deploy Docker Compose → 2. Configure Prowlarr indexers → 3. Add Sonarr/Radarr/Lidarr as apps in Prowlarr → 4. Set qBittorrent as download client in each app → 5. Add root folders → 6. Run Recyclarr for quality profiles → 7. Point Plex at media folders → 8. Set up Overseerr with Sonarr/Radarr

### Add a movie via API
```bash
curl -X POST -H "X-Api-Key: $RADARR_KEY" -H "Content-Type: application/json" \
  http://localhost:7878/api/v3/movie \
  -d '{"tmdbId": 123, "qualityProfileId": 1, "rootFolderPath": "/data/movies", "monitored": true, "addOptions": {"searchForMovie": true}}'
```

## Upstream Sources

- **Servarr Wiki**: https://wiki.servarr.com
- **TRaSH Guides**: https://trash-guides.info
- **GitHub**: Sonarr/Sonarr, Radarr/Radarr, Lidarr/Lidarr, Prowlarr/Prowlarr

## Sync & Update

When user runs `sync`: fetch latest from upstream, update docs/.
When user runs `diff`: compare current vs upstream, report changes.
