<!-- Source: Authored — shared API patterns across all *arr apps -->

# Shared API Reference

## Authentication

All *arr apps use API key authentication via the `X-Api-Key` header.

**Finding your API key**: Each app → Settings → General → Security → API Key

```bash
# Standard *arr API call
curl -H "X-Api-Key: YOUR_API_KEY" http://HOST:PORT/api/v3/ENDPOINT
```

### Per-App Auth Patterns

```bash
# Sonarr (API v3)
curl -H "X-Api-Key: $SONARR_KEY" http://localhost:8989/api/v3/series

# Radarr (API v3)
curl -H "X-Api-Key: $RADARR_KEY" http://localhost:7878/api/v3/movie

# Lidarr (API v1)
curl -H "X-Api-Key: $LIDARR_KEY" http://localhost:8686/api/v1/artist

# Prowlarr (API v1)
curl -H "X-Api-Key: $PROWLARR_KEY" http://localhost:9696/api/v1/indexer

# Plex (token-based)
curl "http://localhost:32400/library/sections?X-Plex-Token=$PLEX_TOKEN"

# Overseerr (API v1)
curl -H "X-Api-Key: $OVERSEERR_KEY" http://localhost:5055/api/v1/search?query=inception

# qBittorrent (cookie-based)
curl -c cookies.txt -d "username=admin&password=adminadmin" http://localhost:8080/api/v2/auth/login
curl -b cookies.txt http://localhost:8080/api/v2/torrents/info
```

## Common Endpoints (Sonarr/Radarr Pattern)

These endpoints work identically across Sonarr and Radarr (adjust port and entity name):

### System
```bash
GET /api/v3/system/status      # App version, OS, runtime info
GET /api/v3/health             # Health check warnings
GET /api/v3/log                # Application logs
```

### Media Management
```bash
# Sonarr
GET    /api/v3/series                    # List all series
GET    /api/v3/series/{id}               # Get series by ID
POST   /api/v3/series                    # Add series
PUT    /api/v3/series/{id}               # Update series
DELETE /api/v3/series/{id}               # Delete series
GET    /api/v3/series/lookup?term=NAME   # Search for series

# Radarr
GET    /api/v3/movie                     # List all movies
GET    /api/v3/movie/{id}                # Get movie by ID
POST   /api/v3/movie                     # Add movie
PUT    /api/v3/movie/{id}                # Update movie
DELETE /api/v3/movie/{id}                # Delete movie
GET    /api/v3/movie/lookup?term=NAME    # Search for movie
```

### Queue & Downloads
```bash
GET    /api/v3/queue                     # Current download queue
DELETE /api/v3/queue/{id}                # Remove from queue
GET    /api/v3/queue/status              # Queue status summary
```

### Calendar
```bash
GET /api/v3/calendar?start=DATE&end=DATE  # Upcoming releases
```

### Profiles
```bash
GET /api/v3/qualityprofile               # List quality profiles
GET /api/v3/rootfolder                   # List root folders
```

### Commands
```bash
POST /api/v3/command                     # Trigger commands
# Body: {"name": "RescanSeries"} or {"name": "RefreshMovie"}
# Common: RescanSeries, RefreshSeries, RssSync, ApplicationUpdateCheck
```

## Adding Media via API

### Add a Movie (Radarr)
```bash
# 1. Search TMDB
RESULTS=$(curl -s -H "X-Api-Key: $KEY" "http://localhost:7878/api/v3/movie/lookup?term=inception")

# 2. Get TMDB ID and quality profile
TMDB_ID=$(echo "$RESULTS" | jq '.[0].tmdbId')
PROFILE_ID=$(curl -s -H "X-Api-Key: $KEY" "http://localhost:7878/api/v3/qualityprofile" | jq '.[0].id')
ROOT=$(curl -s -H "X-Api-Key: $KEY" "http://localhost:7878/api/v3/rootfolder" | jq -r '.[0].path')

# 3. Add movie
curl -X POST -H "X-Api-Key: $KEY" -H "Content-Type: application/json" \
  "http://localhost:7878/api/v3/movie" \
  -d "{\"tmdbId\": $TMDB_ID, \"qualityProfileId\": $PROFILE_ID, \"rootFolderPath\": \"$ROOT\", \"monitored\": true, \"addOptions\": {\"searchForMovie\": true}}"
```

### Add a TV Show (Sonarr)
```bash
# 1. Search TVDB
RESULTS=$(curl -s -H "X-Api-Key: $KEY" "http://localhost:8989/api/v3/series/lookup?term=breaking+bad")

# 2. Add series
TVDB_ID=$(echo "$RESULTS" | jq '.[0].tvdbId')
curl -X POST -H "X-Api-Key: $KEY" -H "Content-Type: application/json" \
  "http://localhost:8989/api/v3/series" \
  -d "{\"tvdbId\": $TVDB_ID, \"qualityProfileId\": 1, \"rootFolderPath\": \"/data/media/tv\", \"monitored\": true, \"addOptions\": {\"searchForMissingEpisodes\": true}}"
```

## Error Handling

All *arr APIs return standard HTTP status codes:
- `200` — Success
- `201` — Created (POST)
- `400` — Bad request (check JSON body)
- `401` — Unauthorized (check API key)
- `404` — Not found
- `409` — Conflict (resource already exists)
- `500` — Internal server error

Error responses include a message field:
```json
[{"propertyName": "tmdbId", "errorMessage": "This movie has already been added", "severity": "error"}]
```
