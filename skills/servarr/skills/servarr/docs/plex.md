<!-- Source: Seeded from sundial-org/awesome-openclaw-skills/skills/plex -->

# Plex Media Server

## Overview

Plex is the media server that serves your library for playback on any device. It handles metadata, transcoding, and multi-client streaming.

## Docker Setup

```yaml
plex:
  image: lscr.io/linuxserver/plex:latest
  container_name: plex
  network_mode: host  # Required for discovery
  environment:
    - PUID=1000
    - PGID=1000
    - TZ=America/New_York
    - VERSION=docker
  volumes:
    - ./config/plex:/config
    - /path/to/data/media:/data/media
  restart: unless-stopped
```

Note: Plex uses `network_mode: host` for DLNA and client discovery. Port 32400 is the main web interface.

## Authentication

Plex uses tokens, not API keys:

1. Sign in at https://app.plex.tv
2. Get your token from: Account → Settings → Authorized Devices, or from URL parameters in the web app

```bash
export PLEX_TOKEN="your-token-here"
```

## API Examples

### List Libraries
```bash
curl -s "http://localhost:32400/library/sections?X-Plex-Token=$PLEX_TOKEN" | \
  python3 -c "import sys,xml.etree.ElementTree as ET; [print(f'{s.get(\"key\")}: {s.get(\"title\")} ({s.get(\"type\")})') for s in ET.fromstring(sys.stdin.read()).findall('.//Directory')]"
```

### Browse a Library
```bash
# List all items in library section 1
curl -s "http://localhost:32400/library/sections/1/all?X-Plex-Token=$PLEX_TOKEN"
```

### Search
```bash
curl -s "http://localhost:32400/search?query=inception&X-Plex-Token=$PLEX_TOKEN"
```

### Recently Added
```bash
curl -s "http://localhost:32400/library/recentlyAdded?X-Plex-Token=$PLEX_TOKEN"
```

### Active Sessions
```bash
curl -s "http://localhost:32400/status/sessions?X-Plex-Token=$PLEX_TOKEN"
```

### Trigger Library Scan
```bash
# Scan a specific library section
curl -X POST "http://localhost:32400/library/sections/1/refresh?X-Plex-Token=$PLEX_TOKEN"
```

## Integration with *arr Apps

Configure Sonarr/Radarr/Lidarr to notify Plex on import:

1. In Sonarr/Radarr → Settings → Connect → Add → Plex Media Server
2. Enter host, port, and auth token
3. Enable "Update Library" on import

This triggers an automatic library scan when new media is imported.

## Common Configuration

### Hardware Transcoding
Enable in Settings → Transcoder → "Use hardware acceleration when available"

For Docker, pass through the GPU:
```yaml
devices:
  - /dev/dri:/dev/dri  # Intel Quick Sync
```

### Remote Access
Settings → Remote Access → Enable. Plex handles NAT traversal automatically via relay servers.

### Optimized Versions
Pre-transcode media for mobile devices: Library → Movie → "..." → Optimize
