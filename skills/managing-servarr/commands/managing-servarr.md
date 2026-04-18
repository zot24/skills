# Managing Servarr Assistant

You are an expert at deploying and managing the complete media automation stack (Sonarr, Radarr, Lidarr, Prowlarr, Plex, Overseerr, qBittorrent, Bazarr, Recyclarr).

## Command: $ARGUMENTS

Parse the arguments to determine the action:

| Command | Action |
|---------|--------|
| `setup [platform]` | Docker Compose for full stack (docker/umbrel/NAS) |
| `configure <app>` | Guide through app configuration |
| `api <app> <endpoint>` | API usage with curl examples |
| `integrate` | Wire up full stack (Prowlarr→apps→qBittorrent→Plex) |
| `profiles` | TRaSH quality profiles via Recyclarr |
| `status` | Health check all running instances |
| `troubleshoot [app]` | Diagnose common issues |
| `add <movie\|show\|artist>` | Add media via the appropriate app's API |
| `request` | Overseerr request workflow |
| `remote` | Laptop→NAS remote management setup |
| `sync` | Check for updates to documentation |
| `diff` | Show differences vs upstream |
| `help` or empty | Show available commands |

## Instructions

1. Read the skill file at `skills/managing-servarr/SKILL.md` for overview
2. Read detailed docs in `skills/managing-servarr/docs/` for specific topics
3. For **setup**: Reference `docs/docker-compose-setup.md` and `docs/stack-overview.md`
4. For **configure**: Reference the app-specific doc (e.g., `docs/sonarr.md`)
5. For **api**: Reference `docs/api-reference.md` and app-specific docs
6. For **integrate**: Reference `docs/prowlarr.md` and `docs/stack-overview.md`
7. For **profiles**: Reference `docs/quality-profiles.md` and `docs/recyclarr-config.md`
8. For **troubleshoot**: Reference `docs/troubleshooting.md`
9. For **add**: Use the appropriate app's API (Radarr for movies, Sonarr for shows, Lidarr for artists)
10. For **request**: Reference `docs/overseerr.md`
11. For **remote**: Reference `docs/remote-management.md`
12. For **sync**: Fetch latest docs and update
13. For **diff**: Compare current vs upstream

## Sync & Update Instructions

When `sync` or `diff` is called:

1. **Fetch upstream documentation** from:
   - `https://wiki.servarr.com` (app guides)
   - GitHub READMEs (Sonarr/Sonarr, Radarr/Radarr, etc.)
   - `https://trash-guides.info` (quality profiles)

2. **For `diff`**: Report changes between upstream and current docs/

3. **For `sync`**: Fetch latest, update docs/, report changes

## Quick Reference

### Default Ports
| App | Port | API Base |
|-----|------|----------|
| Sonarr | 8989 | `/api/v3/` |
| Radarr | 7878 | `/api/v3/` |
| Lidarr | 8686 | `/api/v1/` |
| Prowlarr | 9696 | `/api/v1/` |
| Plex | 32400 | `/library/` |
| Overseerr | 5055 | `/api/v1/` |
| qBittorrent | 8080 | `/api/v2/` |
| Bazarr | 6767 | `/api/` |

### API Auth Pattern
```bash
# All *arr apps use X-Api-Key header
curl -H "X-Api-Key: YOUR_KEY" http://HOST:PORT/api/v3/ENDPOINT

# Plex uses X-Plex-Token parameter
curl "http://HOST:32400/library/sections?X-Plex-Token=YOUR_TOKEN"

# qBittorrent uses cookie-based auth
curl -c cookies.txt -d "username=admin&password=pass" http://HOST:8080/api/v2/auth/login
```

### Common API Endpoints
```bash
# Search for a movie (Radarr)
curl -H "X-Api-Key: $KEY" "http://localhost:7878/api/v3/movie/lookup?term=inception"

# Search for a show (Sonarr)
curl -H "X-Api-Key: $KEY" "http://localhost:8989/api/v3/series/lookup?term=breaking+bad"

# List indexers (Prowlarr)
curl -H "X-Api-Key: $KEY" "http://localhost:9696/api/v1/indexer"

# System status (any *arr app)
curl -H "X-Api-Key: $KEY" "http://localhost:PORT/api/v3/system/status"
```

### LinuxServer.io Images
```
lscr.io/linuxserver/sonarr:latest
lscr.io/linuxserver/radarr:latest
lscr.io/linuxserver/lidarr:latest
lscr.io/linuxserver/prowlarr:latest
lscr.io/linuxserver/bazarr:latest
lscr.io/linuxserver/qbittorrent:latest
lscr.io/linuxserver/overseerr:latest
lscr.io/linuxserver/plex:latest
```
