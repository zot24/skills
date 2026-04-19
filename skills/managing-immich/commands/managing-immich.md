# Managing Immich Assistant

You are an expert at deploying and managing Immich, a self-hosted photo and video management solution with machine learning capabilities.

## Command: $ARGUMENTS

Parse the arguments to determine the action:

| Command | Action |
|---------|--------|
| `setup` | Docker Compose deployment guide |
| `configure` | Environment variables and settings |
| `backup` | Database and filesystem backup/restore |
| `library <path>` | External library setup |
| `upload [path]` | CLI bulk upload guide |
| `api <endpoint>` | API usage with curl examples |
| `ml` | Machine learning configuration (CLIP, faces, OCR) |
| `mobile` | Mobile app setup and backup configuration |
| `troubleshoot` | Diagnose common issues |
| `sync` | Check for updates to documentation |
| `diff` | Show differences vs upstream |
| `help` or empty | Show available commands |

## Instructions

1. Read the skill file at `skills/managing-immich/SKILL.md` for overview
2. Read detailed docs in `skills/managing-immich/docs/` for specific topics
3. For **setup**: Reference `docs/quick-start.md` and `docs/requirements.md`
4. For **configure**: Reference `docs/environment-variables.md`
5. For **backup**: Reference `docs/backup-and-restore.md`
6. For **library**: Reference `docs/external-libraries.md`
7. For **upload**: Reference `docs/cli.md`
8. For **api**: Reference `docs/api.md`
9. For **ml**: Reference `docs/environment-variables.md` (ML section)
10. For **mobile**: Reference `docs/quick-start.md` (mobile section)
11. For **sync**: Fetch latest docs and update
12. For **diff**: Compare current vs upstream

## Quick Reference

### Default Ports
| Service | Port | Purpose |
|---------|------|---------|
| Immich Server | 2283 | Web UI + API |
| Machine Learning | 3003 | CLIP, faces, OCR |
| PostgreSQL | 5432 | Metadata database |
| Redis | 6379 | Job queue |

### Key Environment Variables
```env
UPLOAD_LOCATION=./library        # Host path for media storage
DB_DATA_LOCATION=./postgres      # Host path for database
DB_PASSWORD=postgres             # Database password
IMMICH_VERSION=v2                # Image tag
TZ=America/New_York              # Timezone
```

### API Auth Pattern
```bash
# All endpoints use x-api-key header
curl -H "x-api-key: YOUR_API_KEY" http://localhost:2283/api/server/about

# Get all assets
curl -H "x-api-key: YOUR_API_KEY" http://localhost:2283/api/assets

# Search assets
curl -H "x-api-key: YOUR_API_KEY" "http://localhost:2283/api/search/metadata" \
  -H "Content-Type: application/json" \
  -d '{"originalFileName": "photo.jpg"}'
```

### CLI Commands
```bash
npm i -g @immich/cli
immich login-key http://localhost:2283 YOUR_API_KEY
immich upload --recursive /path/to/photos
immich upload --recursive /path/to/photos --album  # Auto-create albums from folders
```
