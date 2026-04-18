<!-- Source: Seeded from sundial-org/awesome-openclaw-skills/skills/overseerr -->

# Overseerr

## Overview

Overseerr is a request management tool that lets users browse and request movies/TV shows. Requests are automatically sent to Radarr/Sonarr for acquisition.

## Docker Setup

```yaml
overseerr:
  image: lscr.io/linuxserver/overseerr:latest
  container_name: overseerr
  environment:
    - PUID=1000
    - PGID=1000
    - TZ=America/New_York
  ports:
    - "5055:5055"
  volumes:
    - ./config/overseerr:/config
  restart: unless-stopped
```

## Initial Setup

1. Open `http://localhost:5055`
2. Sign in with Plex account
3. Configure Plex server connection
4. Add Radarr server (URL + API key + quality profile + root folder)
5. Add Sonarr server (same pattern)
6. Configure user permissions

## API Examples

### Search for Media
```bash
curl -H "X-Api-Key: $OVERSEERR_KEY" \
  "http://localhost:5055/api/v1/search?query=inception&page=1&language=en"
```

### Request a Movie
```bash
# Get TMDB ID from search results, then:
curl -X POST -H "X-Api-Key: $OVERSEERR_KEY" -H "Content-Type: application/json" \
  "http://localhost:5055/api/v1/request" \
  -d '{"mediaType": "movie", "mediaId": 27205}'
```

### Request a TV Show
```bash
# Request all seasons
curl -X POST -H "X-Api-Key: $OVERSEERR_KEY" -H "Content-Type: application/json" \
  "http://localhost:5055/api/v1/request" \
  -d '{"mediaType": "tv", "mediaId": 1396, "seasons": "all"}'

# Request specific seasons
curl -X POST -H "X-Api-Key: $OVERSEERR_KEY" -H "Content-Type: application/json" \
  "http://localhost:5055/api/v1/request" \
  -d '{"mediaType": "tv", "mediaId": 1396, "seasons": [1, 2]}'
```

### Check Request Status
```bash
# List all requests
curl -H "X-Api-Key: $OVERSEERR_KEY" \
  "http://localhost:5055/api/v1/request?take=20&skip=0&sort=added&filter=all"

# Filter by status
curl -H "X-Api-Key: $OVERSEERR_KEY" \
  "http://localhost:5055/api/v1/request?filter=pending"
```

### 4K Requests
```bash
curl -X POST -H "X-Api-Key: $OVERSEERR_KEY" -H "Content-Type: application/json" \
  "http://localhost:5055/api/v1/request" \
  -d '{"mediaType": "movie", "mediaId": 27205, "is4k": true}'
```

## Integration Flow

```
User browses Overseerr → Requests movie →
  Overseerr sends to Radarr → Radarr searches via Prowlarr →
    Download via qBittorrent → Import to library →
      Plex scans new media → Available for playback
```

## Notifications

Overseerr supports notifications via Discord, Slack, Email, Telegram, and webhooks. Configure in Settings → Notifications.
