<!-- Source: https://docs.immich.app/features/libraries -->

# Immich External Libraries

## Overview

External libraries track assets stored in the filesystem outside of Immich. When scanned, Immich loads videos and photos from disk. They appear in timelines, maps, and albums like regular assets.

## Key Behavior

- Modifications made within Immich (albums, descriptions) exist only in the database
- Moving files externally causes metadata loss upon rescan (treated as new items)
- Deleted external files move to trash for 30 days before permanent removal
- Restoring requires replacing the original file

## Docker Volume Setup

Mount directories as read-only to prevent unintended file deletion:

```yaml
# docker-compose.yml
services:
  immich-server:
    volumes:
      - /source/path:/container/path:ro
```

## Import Paths

Multiple directories can feed a single library with recursive scanning. Duplicate files across paths are added only once.

## Exclusion Patterns

Glob-based patterns filter unwanted files during scanning:
- `**/*.tif` — excludes all TIFF files
- `**/Raw/**` — excludes Raw directories
- `**/@eaDir/**` — excludes Synology metadata directories

## Scanning Options

- **Manual**: Click "Scan" in library management
- **Automatic**: Configurable cron-based nightly jobs (Administration > Settings)
- **Experimental**: Real-time filesystem watching (requires increased inotify limits for large libraries)

## Administration

- Creating libraries requires admin access via Administration > External Libraries
- User ownership is assigned at creation and cannot be modified afterward

## Troubleshooting

- Verify Docker volume mounts are correct
- Check permission settings on host directories
- Use forward slashes only in paths
- Avoid symlinks
- Validate accessibility: `docker exec -it immich_server bash` then `ls /container/path`
