<!-- Source: Seeded from sundial-org/awesome-openclaw-skills/skills/qbittorrent -->

# qBittorrent

## Overview

qBittorrent is the download client used by Sonarr, Radarr, and Lidarr for torrent downloads. All *arr apps send download requests to qBittorrent via its WebUI API.

## Docker Setup

```yaml
qbittorrent:
  image: lscr.io/linuxserver/qbittorrent:latest
  container_name: qbittorrent
  environment:
    - PUID=1000
    - PGID=1000
    - TZ=America/New_York
    - WEBUI_PORT=8080
  ports:
    - "8080:8080"
    - "6881:6881"
    - "6881:6881/udp"
  volumes:
    - ./config/qbittorrent:/config
    - /path/to/data/torrents:/data/torrents
  restart: unless-stopped
```

Default credentials: `admin` / check container logs for temporary password.

## API Authentication

qBittorrent uses cookie-based authentication:

```bash
# Login and save cookie
curl -c cookies.txt \
  -d "username=admin&password=your-password" \
  http://localhost:8080/api/v2/auth/login

# Use cookie for subsequent requests
curl -b cookies.txt http://localhost:8080/api/v2/torrents/info
```

## API Examples

### List Torrents
```bash
# All torrents
curl -b cookies.txt "http://localhost:8080/api/v2/torrents/info"

# Filtered by state
curl -b cookies.txt "http://localhost:8080/api/v2/torrents/info?filter=downloading"
curl -b cookies.txt "http://localhost:8080/api/v2/torrents/info?filter=seeding"
curl -b cookies.txt "http://localhost:8080/api/v2/torrents/info?filter=completed"
curl -b cookies.txt "http://localhost:8080/api/v2/torrents/info?filter=paused"

# By category
curl -b cookies.txt "http://localhost:8080/api/v2/torrents/info?category=radarr"
```

### Add Torrent
```bash
# Via magnet link
curl -b cookies.txt -X POST \
  -d "urls=magnet:?xt=..." \
  -d "category=radarr" \
  -d "savepath=/data/torrents/movies" \
  http://localhost:8080/api/v2/torrents/add
```

### Control Torrents
```bash
# Pause
curl -b cookies.txt -d "hashes=HASH" http://localhost:8080/api/v2/torrents/pause

# Resume
curl -b cookies.txt -d "hashes=HASH" http://localhost:8080/api/v2/torrents/resume

# Delete (with files)
curl -b cookies.txt -d "hashes=HASH&deleteFiles=true" http://localhost:8080/api/v2/torrents/delete
```

### Transfer Info
```bash
curl -b cookies.txt http://localhost:8080/api/v2/transfer/info
# Returns: dl_info_speed, up_info_speed, etc.
```

## Integration with *arr Apps

Configure in each *arr app → Settings → Download Clients → Add → qBittorrent:

- **Host**: `qbittorrent` (Docker container name) or `localhost`
- **Port**: 8080
- **Username/Password**: qBittorrent WebUI credentials
- **Category**: Set per-app (e.g., `sonarr`, `radarr`, `lidarr`)

Categories keep downloads organized and let each *arr app track its own downloads.

## Recommended Settings

- **Downloads → Default Save Path**: `/data/torrents/`
- **Downloads → Keep incomplete in**: `/data/torrents/incomplete/`
- **BitTorrent → Seeding Limits**: Set ratio limit (e.g., 1.0) or time limit
- **Web UI → Authentication**: Change default password immediately
- **Advanced → Network Interface**: Bind to VPN interface if using one
