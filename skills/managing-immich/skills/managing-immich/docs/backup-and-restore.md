<!-- Source: https://docs.immich.app/administration/backup-and-restore -->

# Immich Backup and Restore

## Database Backup

### Automatic Backups
Immich automatically generates database backups stored in `UPLOAD_LOCATION/backups`. Default: last 14 backups, created daily at 2:00 AM. Adjustable via Administration > Settings > Backup.

**Important:** Database backups do NOT contain photos or videos — only metadata.

### Manual Backup
1. Navigate to Administration > Job Queues
2. Click "Create job" (top right)
3. Select "Create Database Backup" and confirm

### Command-Line Backup
```bash
docker exec -t immich_postgres pg_dump --clean --if-exists \
  --dbname=<DB_DATABASE_NAME> --username=<DB_USERNAME> | gzip > "/path/to/backup/dump.sql.gz"
```

### Restore via Web Interface
1. Go to Administration > Maintenance
2. Expand "Restore database backup"
3. Select your backup and click Restore

### Restore via Command Line
```bash
docker compose down -v
docker compose pull
docker compose create
docker start immich_postgres
sleep 10
gunzip --stdout "/path/to/backup/dump.sql.gz" \
  | docker exec -i immich_postgres psql \
    --dbname=<DB_DATABASE_NAME> --username=<DB_USERNAME> \
    --single-transaction --set ON_ERROR_STOP=on
docker compose up -d
```

### Fresh Installation Restore
1. Configure `.env` and `docker-compose.yml`
2. Move previous instance directories to new `UPLOAD_LOCATION`
3. Start services with `docker compose up -d`
4. On welcome screen, click "Restore from backup"
5. Review integrity checks and select backup file
6. Click Restore

## Filesystem Backup

Critical folders requiring backup:
- `UPLOAD_LOCATION/library`
- `UPLOAD_LOCATION/upload`
- `UPLOAD_LOCATION/profile`

### Storage Locations by Asset Type

**Without Storage Template (Default):**

| Type | Path |
|------|------|
| Source Assets | `UPLOAD_LOCATION/upload/<userID>` |
| Avatars | `UPLOAD_LOCATION/profile/<userID>` |
| Thumbnails | `UPLOAD_LOCATION/thumbs/<userID>` |
| Encoded Videos | `UPLOAD_LOCATION/encoded-video/<userID>` |
| Database Backups | `UPLOAD_LOCATION/backups/` |
| Postgres Data | `DB_DATA_LOCATION` |

**With Storage Template Enabled:**

| Type | Path |
|------|------|
| Source Assets | `UPLOAD_LOCATION/library/<userID>` |
| Other locations | Same as above |

## Best Practices

- **3-2-1 Strategy:** 3 copies on 2 different media types with 1 offsite
- **Backup ordering:** Stop immich-server during backup. If unavoidable, backup database first, then filesystem
- **Version compatibility:** Restoring from different Immich versions may require database migrations (automatic)
