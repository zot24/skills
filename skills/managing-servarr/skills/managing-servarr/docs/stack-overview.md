<!-- Source: Authored — architecture overview of the full media stack -->

# Media Stack Architecture

## Data Flow

```
User Request (Overseerr)
    ↓
Monitoring (*arr apps)
    ↓
Indexer Search (Prowlarr → indexers)
    ↓
Download (qBittorrent)
    ↓
Import & Organize (*arr apps)
    ↓
Subtitle Fetch (Bazarr)
    ↓
Media Server (Plex)
    ↓
Playback (Plex clients)
```

## Component Roles

### Acquisition Layer
- **Prowlarr** — Central indexer manager. Configures indexer connections once, syncs to all *arr apps automatically. Supports Usenet and torrent indexers.
- **Sonarr** — Monitors TV shows. Searches for episodes via Prowlarr, sends to download client, imports and renames files.
- **Radarr** — Monitors movies. Same workflow as Sonarr but for movies. Uses TMDB for metadata.
- **Lidarr** — Monitors music artists/albums. Uses MusicBrainz for metadata.

### Download Layer
- **qBittorrent** — Torrent download client. All *arr apps send download requests here. Supports categories, speed limits, and seeding rules.
- Alternative: SABnzbd for Usenet downloads.

### Organization Layer
- **Recyclarr** — CLI tool that syncs TRaSH Guides quality profiles and custom formats to Sonarr/Radarr. Run periodically or as a cron job.
- **Bazarr** — Automatic subtitle downloads for Sonarr and Radarr libraries. Connects to subtitle providers (OpenSubtitles, Subscene, etc.).

### Serving Layer
- **Plex** — Media server. Scans imported media, provides metadata, transcodes for playback on any device.
- Alternative: Jellyfin (open source, no account required).

### Request Layer
- **Overseerr** — Web UI for users to request movies/shows. Integrates with Sonarr/Radarr to automatically add and search for requested media.
- Alternative: Jellyseerr (fork for Jellyfin).

## Shared Volume Strategy

Use a single `/data` root with subdirectories to enable hardlinks (instant file moves instead of copies):

```
/data/
├── torrents/
│   ├── movies/
│   ├── tv/
│   └── music/
├── media/
│   ├── movies/
│   ├── tv/
│   └── music/
└── usenet/
    ├── movies/
    ├── tv/
    └── music/
```

### Volume Mapping in Docker
```yaml
# All services share the same /data mount
volumes:
  - /path/on/host/data:/data
```

This enables:
- qBittorrent downloads to `/data/torrents/movies/`
- Radarr imports (hardlinks) to `/data/media/movies/`
- Plex reads from `/data/media/movies/`

No file copies, instant moves.

## Network Architecture

All services run on the same Docker network. Communication is by container name:

```yaml
networks:
  media:
    driver: bridge

# In each service:
networks:
  - media
```

Internal URLs: `http://sonarr:8989`, `http://radarr:7878`, etc.

## Integration Points

| From | To | Purpose |
|------|----|---------|
| Prowlarr | Sonarr/Radarr/Lidarr | Sync indexers |
| Sonarr/Radarr/Lidarr | qBittorrent | Send downloads |
| Sonarr/Radarr/Lidarr | Plex | Notify on import (Connections) |
| Bazarr | Sonarr/Radarr | Subtitle matching |
| Overseerr | Sonarr/Radarr | Request fulfillment |
| Recyclarr | Sonarr/Radarr | Quality profile sync |
