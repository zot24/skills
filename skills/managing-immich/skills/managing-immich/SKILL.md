---
name: managing-immich
description: Deploy, configure, and manage Immich — self-hosted photo and video management with machine learning, facial recognition, mobile backup, external libraries, and REST API. Use when setting up photo backup, managing a photo server, or working with Immich. Triggers on mentions of Immich, photo management, photo backup, Google Photos alternative, facial recognition, self-hosted photos, media library, photo server.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# Managing Immich

Expert at deploying and managing Immich, a high-performance self-hosted photo and video management solution.

## Overview

- **Immich Server** — Core application with web UI, API, and background workers (port 2283)
- **Machine Learning** — CLIP search, facial recognition, OCR, and object detection (port 3003)
- **PostgreSQL** — Metadata database with pgvecto.rs extension
- **Redis** — Job queue and caching
- **Mobile Apps** — iOS and Android with automatic photo backup
- **CLI** — `@immich/cli` for bulk upload, album creation, and automation

## Quick Start

```bash
mkdir ./immich-app && cd ./immich-app
wget -O docker-compose.yml https://github.com/immich-app/immich/releases/latest/download/docker-compose.yml
wget -O .env https://github.com/immich-app/immich/releases/latest/download/example.env
# Edit .env: set UPLOAD_LOCATION, DB_PASSWORD, TZ
docker compose up -d
# Access at http://localhost:2283
```

## Core Concepts

**Upload Location** — `UPLOAD_LOCATION` sets where photos/videos are stored on the host. The database only stores metadata; media files must be backed up separately.

**External Libraries** — Mount existing photo directories read-only into the container to index without moving files. Configured via Administration > External Libraries.

**Machine Learning** — Runs in a separate container. Powers smart search (CLIP), facial recognition, and OCR. Models are cached in `/cache` inside the ML container.

**API Authentication** — Uses API keys from user Settings > API Keys. Pass via `x-api-key` header.

## Documentation

- **[Quick Start](docs/quick-start.md)** — Installation and first setup
- **[Requirements](docs/requirements.md)** — Hardware and software prerequisites
- **[Environment Variables](docs/environment-variables.md)** — Full configuration reference
- **[Backup & Restore](docs/backup-and-restore.md)** — Database and filesystem backup
- **[External Libraries](docs/external-libraries.md)** — Index existing photo directories
- **[CLI Reference](docs/cli.md)** — Command-line upload and management
- **[API Overview](docs/api.md)** — OpenAPI-based REST API
- **[Upstream README](docs/readme-upstream.md)** — Raw upstream README

## Common Workflows

### Bulk upload existing photos
```bash
npm i -g @immich/cli
immich login-key http://localhost:2283 YOUR_API_KEY
immich upload --recursive /path/to/photos --album
```

### Mount external library
```yaml
# Add to docker-compose.yml immich-server volumes:
- /mnt/nas/photos:/external/photos:ro
```
Then create an external library in Administration > External Libraries pointing to `/external/photos`.

### Backup database
```bash
docker exec -t immich_postgres pg_dump --clean --if-exists \
  --dbname=immich --username=postgres | gzip > backup.sql.gz
```

## Upstream Sources

- **Website**: https://immich.app
- **Documentation**: https://docs.immich.app
- **GitHub**: https://github.com/immich-app/immich
- **API Docs**: https://api.immich.app
- **Demo**: https://demo.immich.app (demo@immich.app / demo)

## Sync & Update

When user runs `sync`: fetch latest from upstream, update docs/.
When user runs `diff`: compare current vs upstream, report changes.
