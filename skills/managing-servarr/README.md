# Managing Servarr Skill

Expert assistant for deploying and managing the complete media automation stack using the [Servarr](https://wiki.servarr.com) ecosystem.

## Stack Coverage

| App | Purpose | Port |
|-----|---------|------|
| Sonarr | TV show automation | 8989 |
| Radarr | Movie automation | 7878 |
| Lidarr | Music collection | 8686 |
| Prowlarr | Indexer management | 9696 |
| Plex | Media server | 32400 |
| Overseerr | Request management | 5055 |
| qBittorrent | Download client | 8080 |
| Bazarr | Subtitle management | 6767 |
| Recyclarr | TRaSH Guides sync | CLI |

## Usage

### Slash Commands

```
/managing-servarr setup docker          # Full Docker Compose stack
/managing-servarr configure sonarr      # Sonarr configuration guide
/managing-servarr api radarr movie      # Radarr movie API usage
/managing-servarr integrate             # Wire up the full stack
/managing-servarr profiles              # TRaSH quality profiles
/managing-servarr add movie "Inception" # Add a movie via Radarr API
/managing-servarr request               # Overseerr request workflow
/managing-servarr remote                # Laptop→NAS setup
/managing-servarr troubleshoot sonarr   # Diagnose issues
/managing-servarr sync                  # Update documentation
```

### Natural Language Triggers

The skill activates on mentions of: Sonarr, Radarr, Lidarr, Prowlarr, Plex, Overseerr, *arr, servarr, media library, quality profiles, TRaSH Guides, media server, NAS.

## Documentation Sources

- **Servarr Wiki**: https://wiki.servarr.com
- **TRaSH Guides**: https://trash-guides.info
- **GitHub**: Sonarr/Sonarr, Radarr/Radarr, Lidarr/Lidarr, Prowlarr/Prowlarr

Wiki pages are scraped using Firecrawl for clean markdown extraction.

## Sync

```bash
# Discover new wiki pages
./skills/managing-servarr/discover-pages.sh

# Auto-add new pages
./skills/managing-servarr/discover-pages.sh --auto-add

# Sync all documentation
.github/workflows/scripts/sync-skill.sh skills/managing-servarr --force
```

## Skill Structure

```
skills/managing-servarr/
├── .claude-plugin/plugin.json           # Plugin metadata
├── commands/managing-servarr.md         # Slash command entry point
├── skills/managing-servarr/
│   ├── SKILL.md                         # Overview + references (~100 lines)
│   └── docs/                            # Cached documentation
│       ├── stack-overview.md            # Architecture + data flow
│       ├── docker-compose-setup.md      # Deployment templates
│       ├── sonarr.md, radarr.md, ...    # Per-app guides
│       ├── quality-profiles.md          # TRaSH Guides
│       ├── api-reference.md             # Shared API patterns
│       ├── remote-management.md         # Laptop→NAS patterns
│       └── troubleshooting.md           # Common issues
├── discover-pages.sh                    # Wiki page discovery
├── sync.json                            # Sync configuration
└── README.md                            # This file
```
