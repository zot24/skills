<!-- Source: Authored — Bazarr subtitle management -->

# Bazarr

## Overview

Bazarr is a companion app to Sonarr and Radarr that manages and downloads subtitles for your media library.

## Docker Setup

```yaml
bazarr:
  image: lscr.io/linuxserver/bazarr:latest
  container_name: bazarr
  environment:
    - PUID=1000
    - PGID=1000
    - TZ=America/New_York
  ports:
    - "6767:6767"
  volumes:
    - ./config/bazarr:/config
    - /path/to/data/media:/data/media
  restart: unless-stopped
```

## Initial Setup

1. Open `http://localhost:6767`
2. Configure Sonarr connection (Settings → Sonarr → URL + API key)
3. Configure Radarr connection (Settings → Radarr → URL + API key)
4. Add subtitle providers (Settings → Providers)
5. Set languages (Settings → Languages)
6. Configure subtitle profiles

## Subtitle Providers

Popular providers to configure:
- **OpenSubtitles.com** — Largest database, requires free account
- **Subscene** — Good for non-English languages
- **Addic7ed** — TV show focused
- **Podnapisi** — Multi-language

## Integration

Bazarr connects to Sonarr and Radarr to:
1. Discover all media in your library
2. Check for missing subtitles
3. Automatically download matching subtitles
4. Re-download if better quality becomes available

## API Examples

```bash
# List movies with missing subtitles
curl -H "X-Api-Key: $BAZARR_KEY" "http://localhost:6767/api/movies/wanted"

# List episodes with missing subtitles
curl -H "X-Api-Key: $BAZARR_KEY" "http://localhost:6767/api/episodes/wanted"

# Trigger subtitle search
curl -X POST -H "X-Api-Key: $BAZARR_KEY" \
  "http://localhost:6767/api/movies/subtitles" \
  -d '{"radarrid": 123}'
```
