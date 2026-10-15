> Source: https://wiki.servarr.com/lidarr/postgres-setup



## <a href="#lidarr-and-postgres" class="toc-anchor">¶</a> Lidarr and Postgres

> Lidarr v1.1.2.2890 or newer required.

> Lidarr doesn't back up Postgres databases. Set up and maintain your own backups.

Lidarr uses <a href="https://www.npgsql.org/" class="is-external-link">Npgsql</a> 9.x, which targets all <a href="https://www.postgresql.org/support/versioning/" class="is-external-link">currently supported PostgreSQL versions</a> (PostgreSQL 14 through 18). PostgreSQL 13 reached end-of-life in November 2025 and isn't recommended.

## <a href="#should-you-use-postgres" class="toc-anchor">¶</a> Should you use Postgres?

SQLite is the default and works well for most Lidarr libraries. Postgres can make a large library faster, but it adds a second service you have to run, back up, and upgrade. Switch when you can see a database problem, not because your library passed a certain size.

### <a href="#why-there-is-no-track-count-threshold" class="toc-anchor">¶</a> Why there is no track-count threshold

Community reports don't line up with track count. Some users with 140,000 tracks on SQLite notice no problems, while others with fewer tracks saw large improvements after moving to Postgres. Library shape matters more than size. Artists with long discographies and many releases per album add far more rows to the database than the track count suggests.

Lidarr also stores more rows than Sonarr or Radarr for a library of similar size, because it keeps every MusicBrainz release and track for each monitored artist. A user who saw no difference after moving Sonarr to Postgres may still see one in Lidarr.

### <a href="#what-postgres-improves" class="toc-anchor">¶</a> What Postgres improves

SQLite allows only one write at a time. When a long task such as Refresh Artist overlaps with imports, RSS Sync, or the UI saving a change, writes wait for each other. Lidarr waits up to one second for the lock, retries a few times, and then fails the operation. Postgres handles many writes at once, so this contention goes away.

Postgres also has a stronger query planner, which helps the heavier pages on large libraries, such as the artist index, Wanted, and History.

### <a href="#what-postgres-doesnt-improve" class="toc-anchor">¶</a> What Postgres doesn't improve

- **Metadata lookups.** Adding artists, searching, and refreshing wait on the Lidarr metadata server and MusicBrainz. The database isn't involved.
- **File work.** Copying, tagging, and fingerprinting during import depend on disk and CPU.
- **Slow queries.** Some Lidarr queries are slow on both engines. Users on Postgres have reported waiting about 30 seconds for Wanted \> Missing on a large library. Postgres hides part of this cost but doesn't remove it.

> At the time of writing (October 2026), <a href="https://github.com/Lidarr/Lidarr/pull/5853" class="is-external-link">Lidarr pull request #5853</a> proposes query and index improvements for Wanted, History, and the artist and album lists. If a release includes these changes, upgrade and measure again before you migrate. The upgrade alone may fix the slowdown.

### <a href="#signs-that-postgres-would-help" class="toc-anchor">¶</a> Signs that Postgres would help

- `Failed writing to database. Retry #` warnings appear in the logs most days.
- `database is locked` errors appear, often as failed imports or settings that don't save.
- Pages load normally when Lidarr is idle but take two or more times longer while tasks run.
- The first page load after opening Lidarr takes tens of seconds.

To check these signs, see [Measuring database performance](#measuring-database-performance).

### <a href="#upkeep" class="toc-anchor">¶</a> Upkeep

Running Postgres adds these ongoing tasks:

- **Backups.** Lidarr's built-in backup doesn't include Postgres data. You need your own scheduled dumps. See [Backing up and restoring Postgres](#backing-up-and-restoring-postgres).
- **Start order.** Postgres must be ready before Lidarr starts, or Lidarr exits with a startup error. See [Starting Postgres before Lidarr](#starting-postgres-before-lidarr).
- **Major-version upgrades.** Postgres data files only work with the major version that created them. Moving from 17 to 18, for example, requires a dump and restore or `pg_upgrade`. This is why the Docker examples pin a version tag. See the <a href="https://www.postgresql.org/docs/current/upgrading.html" class="is-external-link">Postgres upgrade documentation</a>.
- **Minor updates.** Updates within a major version, such as 17.4 to 17.5, need only a restart and pulling the new image or package.

Routine database maintenance isn't on this list. Postgres runs autovacuum by default, which reclaims space and updates query statistics without any action from you.

## <a href="#measuring-database-performance" class="toc-anchor">¶</a> Measuring database performance

Use these checks to find out whether the database is what's slowing Lidarr down. Run them before you migrate, and again afterward to confirm the improvement.

### <a href="#enable-timing-logs" class="toc-anchor">¶</a> Enable timing logs

1.  Go to **Settings \> General \> Logging** and set **Log Level** to **Trace**.
2.  Use Lidarr normally for a while, including at least one time when a large task such as Refresh Artist is running.
3.  Open `lidarr.trace.txt` in the `logs` folder of your <a href="/lidarr/appdata-directory" class="is-internal-link is-valid-page">AppData directory</a>.
4.  Set the log level back to **Info** when you're done. Trace logging writes a lot of data.

At Trace level, Lidarr logs every API request with how long it took:

``` prismjs
Res: 1234 [GET] /api/v1/wanted/missing: 200.OK (5821 ms)
```

It also logs how long each task took:

``` prismjs
RefreshArtistCommand <- RefreshArtistService [00:14:32.1234567]
```

These endpoints are the most useful to compare:

| Endpoint                                             | Page                          |
|------------------------------------------------------|-------------------------------|
| `/api/v1/artist` and `/api/v1/album`                 | Initial load and artist index |
| `/api/v1/wanted/missing` and `/api/v1/wanted/cutoff` | Wanted                        |
| `/api/v1/history`                                    | History                       |

On Linux or macOS, this command pulls out those lines:

``` prismjs
grep -E "Res: .*/api/v1/(artist|album|wanted|history)" lidarr.trace.txt
```

Compare each endpoint while Lidarr is idle and while a task is running:

- **Slow only while tasks run:** writes are waiting on each other. Postgres is likely to help.
- **Slow all the time, with no lock warnings:** the queries themselves are slow. Postgres may help some, but check for a Lidarr update first.
- **Slow all the time, with high disk wait:** the storage is the bottleneck. Move the database to faster local storage.

### <a href="#log-sql-queries-optional" class="toc-anchor">¶</a> Log SQL queries (optional)

To see which queries Lidarr runs, add `<LogSql>true</LogSql>` to `config.xml` or set the `LIDARR__LOG__SQL=true` environment variable, then restart Lidarr. This only works at Trace level. Lidarr writes each query between `==== Begin Query Trace ====` markers. The log doesn't include query durations, so use this to spot pages that run hundreds of small queries, not to time them. Turn it off when you're done.

### <a href="#query-the-sqlite-files" class="toc-anchor">¶</a> Query the SQLite files

Run these queries against a copy of the database, not the live file. Because Lidarr uses WAL mode, a plain file copy can miss recent changes. Make a consistent copy with:

``` prismjs
sqlite3 lidarr.db ".backup lidarr-copy.db"
```

Count rows in the largest tables:

``` prismjs
SELECT 'Artists', COUNT(*) FROM Artists UNION ALL
SELECT 'Albums', COUNT(*) FROM Albums UNION ALL
SELECT 'AlbumReleases', COUNT(*) FROM AlbumReleases UNION ALL
SELECT 'Tracks', COUNT(*) FROM Tracks UNION ALL
SELECT 'TrackFiles', COUNT(*) FROM TrackFiles UNION ALL
SELECT 'History', COUNT(*) FROM History;
```

Check file size and unused space:

``` prismjs
PRAGMA page_count;
PRAGMA page_size;
PRAGMA freelist_count;
```

If `freelist_count` is a large share of `page_count`, stop Lidarr and run `VACUUM;` on the live database. This is quicker to try than a migration.

Find the slowest recent tasks. Lidarr keeps finished tasks for about one day:

``` prismjs
SELECT Name, QueuedAt, StartedAt, EndedAt, Duration, Status
FROM Commands
ORDER BY Duration DESC
LIMIT 20;
```

If `StartedAt` is often much later than `QueuedAt`, tasks are waiting behind each other.

Search past lock warnings in `logs.db`, which keeps Info-level and higher messages:

``` prismjs
SELECT Time, Level, Logger, Message
FROM Logs
WHERE Message LIKE '%Retry #%'
   OR Message LIKE '%database is locked%'
   OR Exception LIKE '%database is locked%'
ORDER BY Time DESC
LIMIT 50;
```

Check database integrity:

``` prismjs
PRAGMA quick_check;
```

Any result other than `ok` points to a storage problem. Fix the storage first. Moving a damaged database to Postgres won't help.

### <a href="#other-signals" class="toc-anchor">¶</a> Other signals

- **WAL file size.** A `lidarr.db-wal` file that stays at hundreds of megabytes means SQLite can't checkpoint because reads and writes keep overlapping.
- **Disk wait.** On Linux, run `iostat -x 5` or watch the `wa` value in `top` during a refresh. A saturated disk slows Lidarr whichever database you use.
- **Log database writes.** Lidarr writes Info-level and higher messages to `logs.db`. As a test, set `<LogDbEnabled>false</LogDbEnabled>` in `config.xml` and restart. If Lidarr gets noticeably faster, the storage can't keep up with writes, and faster storage will help more than Postgres.

### <a href="#after-migrating" class="toc-anchor">¶</a> After migrating

Postgres can record real query timings, which SQLite can't. To log every query slower than one second, add this to `postgresql.conf` and reload Postgres:

``` prismjs
log_min_duration_statement = 1000
```

For per-query totals across Lidarr's activity, enable the <a href="https://www.postgresql.org/docs/current/pgstatstatements.html" class="is-external-link"><code>pg_stat_statements</code></a> extension.

## <a href="#setting-up-postgres" class="toc-anchor">¶</a> Setting up Postgres

First, you need a Postgres instance. This guide covers the `postgres:17` Docker image.

> Don't use the `latest` tag. It will upgrade your database engine on container recreate and can break compatibility.

``` prismjs
docker create --name=postgres17 \
    -e POSTGRES_PASSWORD=qstick \
    -e POSTGRES_USER=qstick \
    -e POSTGRES_DB=lidarr-main \
    -p 5432:5432/tcp \
    -v /path/to/appdata/postgres17:/var/lib/postgresql/data \
    postgres:17
```

## <a href="#creation-of-database" class="toc-anchor">¶</a> Creation of database

Lidarr needs two databases. The default names are:

- `lidarr-main`: stores all configuration and history
- `lidarr-log`: stores events that produce a log entry

> Lidarr won't create the databases for you. Create them before starting Lidarr.

Create the databases using your preferred tool, for example <a href="https://www.pgadmin.org/" class="is-external-link">pgAdmin</a> or <a href="https://www.adminer.org/" class="is-external-link">Adminer</a>.

You can give the databases any name you want, but make sure `config.xml` has the correct names. See [Schema creation](#schema-creation) below.

### <a href="#schema-creation" class="toc-anchor">¶</a> Schema creation

Tell Lidarr to use Postgres. Open `config.xml` and add or update these entries:

``` prismjs
<PostgresUser>qstick</PostgresUser>
<PostgresPassword>qstick</PostgresPassword>
<PostgresPort>5432</PostgresPort>
<PostgresHost>postgres17</PostgresHost>
```

To use custom database names, also add:

``` prismjs
<PostgresMainDb>MainDbName</PostgresMainDb>
<PostgresLogDb>LogDbName</PostgresLogDb>
```

Only **after creating** both databases, start Lidarr to initialize the schema.

## <a href="#starting-postgres-before-lidarr" class="toc-anchor">¶</a> Starting Postgres before Lidarr

Postgres must be ready to accept connections when Lidarr starts. If Postgres refuses the connection, Lidarr retries 3 times, 5 seconds apart, and then exits. If Postgres is running but still starting up, Lidarr fails right away without retrying. This happens most often after a host reboot, when both services start at the same time.

### <a href="#docker-compose" class="toc-anchor">¶</a> Docker Compose

Plain `depends_on` only waits for the Postgres container to start, not for Postgres to be ready. Add a health check and the `service_healthy` condition:

``` prismjs
services:
  postgres17:
    image: postgres:17
    environment:
      POSTGRES_USER: qstick
      POSTGRES_PASSWORD: qstick
      POSTGRES_DB: lidarr-main
    volumes:
      - /path/to/appdata/postgres17:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U qstick -d lidarr-main"]
      interval: 5s
      timeout: 5s
      retries: 10
    restart: unless-stopped

  lidarr:
    image: lscr.io/linuxserver/lidarr:latest
    depends_on:
      postgres17:
        condition: service_healthy
    # ...rest of your Lidarr configuration
```

With this in place, you don't need a fixed start delay.

### <a href="#unraid" class="toc-anchor">¶</a> Unraid

Unraid's container autostart doesn't wait for health checks. On the **Docker** tab, place the Postgres container above Lidarr in the autostart order. Then set a **Wait** value of 60 to 90 seconds on the Postgres container so it's ready before Lidarr starts.

### <a href="#linux-systemd" class="toc-anchor">¶</a> Linux (systemd)

Make the Lidarr service start after Postgres. Run `sudo systemctl edit lidarr` and add:

``` prismjs
[Unit]
Wants=postgresql.service
After=postgresql.service
```

On Debian and Ubuntu, `postgresql.service` is a wrapper that can report as started before the database is ready. Order Lidarr after the cluster unit instead, for example `postgresql@17-main.service`. Run `systemctl list-units 'postgresql*'` to find the name.

### <a href="#windows" class="toc-anchor">¶</a> Windows

Make the Lidarr service depend on the Postgres service. From an elevated command prompt:

``` prismjs
sc.exe config Lidarr depend= postgresql-x64-17
```

Keep the space after `depend=`. Replace `postgresql-x64-17` with your Postgres service name, which you can find in `services.msc`.

## <a href="#migrating-data" class="toc-anchor">¶</a> Migrating data

> If you don't want to migrate an existing SQLite database to Postgres, you're done.

> Lidarr doesn't officially support SQLite-to-Postgres migration. The community script below works for many users on Postgres 14 through 17, but isn't guaranteed to work on Postgres 18 or later. On those versions, start with a fresh database.

To migrate data, use <a href="https://github.com/dimitri/pgloader" class="is-external-link">PGLoader</a>. Two gotchas:

- By default, identifiers are case-insensitive. Use `--with "quote identifiers"` to make them case-sensitive.
- The version packaged in Debian and Ubuntu apt repos is too old for Postgres 14+. Use the <a href="https://github.com/Roxedus/Pgloader-bin" class="is-external-link">Roxedus pgloader binary</a>, which includes updated dependencies.

> Don't drop any tables in the Postgres instance.

Before migrating, run Lidarr against the created Postgres databases **at least once** so the schema exists, then stop Lidarr and follow these steps:

1.  Stop Lidarr.

2.  Open your preferred database management tool and connect to the Postgres instance.

3.  Run the following commands to clear the default seed data:

    ``` prismjs
    DELETE FROM "QualityProfiles";
    DELETE FROM "QualityDefinitions";
    DELETE FROM "DelayProfiles";
    DELETE FROM "Metadata";
    DELETE FROM "MetadataProfiles";
    ```

4.  Start the migration using one of these options:

    ``` prismjs
    pgloader --with "quote identifiers" --with "data only" lidarr.db 'postgresql://qstick:qstick@localhost/lidarr-main'
    ```

    ``` prismjs
    docker run --rm -v /absolute/path/to/lidarr.db:/lidarr.db:ro --network=host ghcr.io/roxedus/pgloader --with "quote identifiers" --with "data only" /lidarr.db "postgresql://qstick:qstick@localhost/lidarr-main"
    ```

    > If pgloader errors on a large database, add `--with "prefetch rows = 100" --with "batch size = 1MB"` to the command.

5.  If you see sequence errors after migration, run the following to reset all sequences:

    ``` prismjs
    select setval('public."AlbumReleases_Id_seq"', (SELECT MAX("Id")+1 FROM "AlbumReleases"));
    select setval('public."Albums_Id_seq"', (SELECT MAX("Id")+1 FROM "Albums"));
    select setval('public."ArtistMetadata_Id_seq"', (SELECT MAX("Id")+1 FROM "ArtistMetadata"));
    select setval('public."Artists_Id_seq"', (SELECT MAX("Id")+1 FROM "Artists"));
    select setval('public."AutoTagging_Id_seq"', (SELECT MAX("Id")+1 FROM "AutoTagging"));
    select setval('public."Blacklist_Id_seq"', (SELECT MAX("Id")+1 FROM "Blocklist"));
    select setval('public."Commands_Id_seq"', (SELECT MAX("Id")+1 FROM "Commands"));
    select setval('public."Config_Id_seq"', (SELECT MAX("Id")+1 FROM "Config"));
    select setval('public."CustomFilters_Id_seq"', (SELECT MAX("Id")+1 FROM "CustomFilters"));
    select setval('public."CustomFormats_Id_seq"', (SELECT MAX("Id")+1 FROM "CustomFormats"));
    select setval('public."DelayProfiles_Id_seq"', (SELECT MAX("Id")+1 FROM "DelayProfiles"));
    select setval('public."DownloadClients_Id_seq"', (SELECT MAX("Id")+1 FROM "DownloadClients"));
    select setval('public."DownloadClientStatus_Id_seq"', (SELECT MAX("Id")+1 FROM "DownloadClientStatus"));
    select setval('public."DownloadHistory_Id_seq"', (SELECT MAX("Id")+1 FROM "DownloadHistory"));
    select setval('public."ExtraFiles_Id_seq"', (SELECT MAX("Id")+1 FROM "ExtraFiles"));
    select setval('public."History_Id_seq"', (SELECT MAX("Id")+1 FROM "History"));
    select setval('public."ImportListExclusions_Id_seq"', (SELECT MAX("Id")+1 FROM "ImportListExclusions"));
    select setval('public."ImportLists_Id_seq"', (SELECT MAX("Id")+1 FROM "ImportLists"));
    select setval('public."ImportListStatus_Id_seq"', (SELECT MAX("Id")+1 FROM "ImportListStatus"));
    select setval('public."Indexers_Id_seq"', (SELECT MAX("Id")+1 FROM "Indexers"));
    select setval('public."IndexerStatus_Id_seq"', (SELECT MAX("Id")+1 FROM "IndexerStatus"));
    select setval('public."LyricFiles_Id_seq"', (SELECT MAX("Id")+1 FROM "LyricFiles"));
    select setval('public."Metadata_Id_seq"', (SELECT MAX("Id")+1 FROM "Metadata"));
    select setval('public."MetadataFiles_Id_seq"', (SELECT MAX("Id")+1 FROM "MetadataFiles"));
    select setval('public."MetadataProfiles_Id_seq"', (SELECT MAX("Id")+1 FROM "MetadataProfiles"));
    select setval('public."NamingConfig_Id_seq"', (SELECT MAX("Id")+1 FROM "NamingConfig"));
    select setval('public."Notifications_Id_seq"', (SELECT MAX("Id")+1 FROM "Notifications"));
    select setval('public."NotificationStatus_Id_seq"', (SELECT MAX("Id")+1 FROM "NotificationStatus"));
    select setval('public."PendingReleases_Id_seq"', (SELECT MAX("Id")+1 FROM "PendingReleases"));
    select setval('public."Profiles_Id_seq"', (SELECT MAX("Id")+1 FROM "QualityProfiles"));
    select setval('public."QualityDefinitions_Id_seq"', (SELECT MAX("Id")+1 FROM "QualityDefinitions"));
    select setval('public."RemotePathMappings_Id_seq"', (SELECT MAX("Id")+1 FROM "RemotePathMappings"));
    select setval('public."Restrictions_Id_seq"', (SELECT MAX("Id")+1 FROM "ReleaseProfiles"));
    select setval('public."RootFolders_Id_seq"', (SELECT MAX("Id")+1 FROM "RootFolders"));
    select setval('public."ScheduledTasks_Id_seq"', (SELECT MAX("Id")+1 FROM "ScheduledTasks"));
    select setval('public."Tags_Id_seq"', (SELECT MAX("Id")+1 FROM "Tags"));
    select setval('public."TrackFiles_Id_seq"', (SELECT MAX("Id")+1 FROM "TrackFiles"));
    select setval('public."Tracks_Id_seq"', (SELECT MAX("Id")+1 FROM "Tracks"));
    select setval('public."UpdateHistory_Id_seq"', (SELECT MAX("Id")+1 FROM "UpdateHistory"));
    select setval('public."Users_Id_seq"', (SELECT MAX("Id")+1 FROM "Users"));
    ```

6.  Start Lidarr.

## <a href="#backing-up-and-restoring-postgres" class="toc-anchor">¶</a> Backing up and restoring Postgres

> Lidarr's built-in backup covers only the application config (`config.xml`) and, when using SQLite, the database files. It doesn't back up a Postgres database. Restoring a Lidarr backup won't restore your Postgres data.

Use `pg_dump` to back up each database on its own. The examples below use the `postgres:17` Docker container from the setup above. Adjust the container name, user, and database names to match your environment.

### <a href="#creating-a-backup" class="toc-anchor">¶</a> Creating a backup

**Native Postgres install:**

``` prismjs
pg_dump -U qstick -F c -f /path/to/backups/lidarr-main.dump lidarr-main
pg_dump -U qstick -F c -f /path/to/backups/lidarr-log.dump lidarr-log
```

**Docker:**

``` prismjs
docker exec postgres17 pg_dump -U qstick -F c lidarr-main > /path/to/backups/lidarr-main.dump
docker exec postgres17 pg_dump -U qstick -F c lidarr-log > /path/to/backups/lidarr-log.dump
```

The `-F c` flag uses the custom format, which compresses the dump and supports selective restore with `pg_restore`. Use `-F p` for a plain SQL file if you prefer something human-readable.

### <a href="#restoring-from-a-backup" class="toc-anchor">¶</a> Restoring from a backup

1.  Stop Lidarr.

2.  Drop and recreate the target databases so you start from a clean state:

    ``` prismjs
    DROP DATABASE "lidarr-main";
    DROP DATABASE "lidarr-log";
    CREATE DATABASE "lidarr-main";
    CREATE DATABASE "lidarr-log";
    ```

3.  Restore each dump:

    **Native Postgres install:**

    ``` prismjs
    pg_restore -U qstick -d lidarr-main /path/to/backups/lidarr-main.dump
    pg_restore -U qstick -d lidarr-log /path/to/backups/lidarr-log.dump
    ```

    **Docker:**

    ``` prismjs
    docker exec -i postgres17 pg_restore -U qstick -d lidarr-main < /path/to/backups/lidarr-main.dump
    docker exec -i postgres17 pg_restore -U qstick -d lidarr-log < /path/to/backups/lidarr-log.dump
    ```

4.  Start Lidarr.

### <a href="#automating-backups" class="toc-anchor">¶</a> Automating backups

> Keep at least a week of rolling backups. A single backup file that gets overwritten daily gives you no recovery point if the database was already corrupted before the last dump ran.

Store dumps in a location that your normal system or offsite backup already covers.

#### <a href="#linux-and-macos" class="toc-anchor">¶</a> Linux and macOS

Use `cron` to schedule a daily dump. The example below backs up the main database and removes dumps older than 7 days:

``` prismjs
0 2 * * * pg_dump -U qstick -F c lidarr-main > /path/to/backups/lidarr-main-$(date +\%Y\%m\%d).dump && find /path/to/backups -name "lidarr-main-*.dump" -mtime +7 -delete
```

Add a second entry for the log database if you want to preserve it as well.

#### <a href="#windows-1" class="toc-anchor">¶</a> Windows

> The scripts below are for convenience and reference only. The Servarr team doesn't support them. Review them before running and adapt them to your environment.

The following PowerShell script creates a scheduled task that backs up both databases daily and removes dumps older than the retention period. Run it once as Administrator. Re-run it with updated parameters to change the schedule or connection details.

**Prerequisite:** `pg_dump` must be available on the host. A native Postgres install includes the client tools. If you run Postgres in Docker with no native install, install the <a href="https://www.postgresql.org/download/windows/" class="is-external-link">PostgreSQL client tools</a> on the host. You can also skip this script and use the Docker `pg_dump` approach from [Creating a backup](#creating-a-backup).

``` prismjs
# New-LidarrBackupTask.ps1
# Creates a Windows scheduled task that backs up Lidarr's Postgres databases.
#
# Parameters:
#   -PgHost         Postgres host                        (default: localhost)
#   -PgPort         Postgres port                        (default: 5432)
#   -PgUser         Postgres username                    (default: qstick)
#   -PgPassword     Postgres password                    (default: qstick)
#   -MainDb         Main database name                   (default: lidarr-main)
#   -LogDb          Log database name                    (default: lidarr-log)
#   -BackupDir      Directory for dump files             (default: %ProgramData%\Lidarr\Backups\postgres)
#   -RetentionDays  Days of backups to keep              (default: 7)
#   -RunAt          Daily run time HH:mm                 (default: 02:00)
#   -TaskName       Scheduled task name                  (default: Lidarr Postgres Backup)
#   -PgDumpPath     Full path to pg_dump.exe (optional)  (default: auto-detect)

param(
    [string]$PgHost        = "localhost",
    [int]   $PgPort        = 5432,
    [string]$PgUser        = "qstick",
    [string]$PgPassword    = "qstick",
    [string]$MainDb        = "lidarr-main",
    [string]$LogDb         = "lidarr-log",
    [string]$BackupDir     = "$env:ProgramData\Lidarr\Backups\postgres",
    [int]   $RetentionDays = 7,
    [string]$RunAt         = "02:00",
    [string]$TaskName      = "Lidarr Postgres Backup",
    [string]$PgDumpPath    = ""
)

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
        [Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "Run this script as Administrator."
    exit 1
}

# Resolve pg_dump before writing the backup script so we fail early with a clear message.
if ($PgDumpPath) {
    if (-not (Test-Path $PgDumpPath)) {
        Write-Error "pg_dump not found at '$PgDumpPath'."
        exit 1
    }
    $resolvedPgDump = $PgDumpPath
} elseif (Get-Command 'pg_dump' -ErrorAction SilentlyContinue) {
    $resolvedPgDump = 'pg_dump'
} else {
    $found = Get-ChildItem 'C:\Program Files\PostgreSQL' -Filter 'pg_dump.exe' -Recurse -ErrorAction SilentlyContinue |
             Sort-Object FullName -Descending |
             Select-Object -First 1
    if ($found) {
        $resolvedPgDump = $found.FullName
    } else {
        Write-Error "pg_dump not found. Install PostgreSQL client tools, add the bin directory to PATH, or pass -PgDumpPath with the full path to pg_dump.exe."
        exit 1
    }
}

$installDir = "$env:ProgramData\Lidarr"
$scriptPath = Join-Path $installDir "Invoke-LidarrBackup.ps1"

foreach ($dir in $installDir, $BackupDir) {
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
}

# Write the backup script with connection details embedded.
# To change settings, re-run New-LidarrBackupTask.ps1 rather than editing this file.
@"
`$pgDump       = '$resolvedPgDump'
`$PgHost       = '$PgHost'
`$PgPort       = $PgPort
`$PgUser       = '$PgUser'
`$PgPassword   = '$PgPassword'
`$MainDb       = '$MainDb'
`$LogDb        = '$LogDb'
`$BackupDir    = '$BackupDir'
`$RetentionDays = $RetentionDays

`$env:PGPASSWORD = `$PgPassword
`$date = Get-Date -Format 'yyyyMMdd-HHmmss'

if (-not (Test-Path `$BackupDir)) { New-Item -ItemType Directory -Path `$BackupDir | Out-Null }

function Invoke-Dump {
    param([string]`$Db, [string]`$Label)
    `$file = Join-Path `$BackupDir "`$Label-`$date.dump"
    & `$pgDump -h `$PgHost -p `$PgPort -U `$PgUser -F c -f `$file `$Db
    if (`$LASTEXITCODE -ne 0) {
        Write-Error "Backup of `$Db failed (exit code `$LASTEXITCODE)."
        exit 1
    }
    Write-Host "Backed up `$Db to `$file"
}

Invoke-Dump -Db `$MainDb -Label 'lidarr-main'
Invoke-Dump -Db `$LogDb  -Label 'lidarr-log'

Get-ChildItem `$BackupDir -Filter '*.dump' |
    Where-Object { `$_.LastWriteTime -lt (Get-Date).AddDays(-`$RetentionDays) } |
    ForEach-Object {
        Remove-Item `$_.FullName
        Write-Host "Removed old backup: `$(`$_.Name)"
    }

`$env:PGPASSWORD = ''
"@ | Set-Content -Path $scriptPath -Encoding UTF8

$action    = New-ScheduledTaskAction -Execute 'powershell.exe' `
                 -Argument "-NonInteractive -ExecutionPolicy Bypass -File `"$scriptPath`""
$trigger   = New-ScheduledTaskTrigger -Daily -At $RunAt
$settings  = New-ScheduledTaskSettingsSet -ExecutionTimeLimit (New-TimeSpan -Hours 1) -StartWhenAvailable
$principal = New-ScheduledTaskPrincipal -UserId 'SYSTEM' -LogonType ServiceAccount -RunLevel Highest

Register-ScheduledTask -TaskName $TaskName `
    -Action $action -Trigger $trigger -Settings $settings -Principal $principal `
    -Force | Out-Null

Write-Host "Task '$TaskName' registered. Backups will run daily at $RunAt."
Write-Host "Backup script: $scriptPath"
Write-Host "Dump directory: $BackupDir"
Write-Host "Using pg_dump: $resolvedPgDump"
```

Run the script from an elevated PowerShell prompt:

``` prismjs
.\New-LidarrBackupTask.ps1 -PgPassword "yourpassword" -RetentionDays 14
```

If `pg_dump` isn't in PATH and isn't under `C:\Program Files\PostgreSQL`, pass the full path explicitly:

``` prismjs
.\New-LidarrBackupTask.ps1 -PgPassword "yourpassword" -PgDumpPath "C:\Program Files\PostgreSQL\17\bin\pg_dump.exe"
```

The script resolves `pg_dump` at setup time and saves the full path in the generated backup script. The scheduled task then works even if PATH is wrong for the SYSTEM account. It writes `Invoke-LidarrBackup.ps1` to `%ProgramData%\Lidarr\` with your connection details embedded, then registers a daily scheduled task running as the SYSTEM account. To update the schedule or connection details, re-run `New-LidarrBackupTask.ps1` with the new parameters rather than editing the generated script directly.

By default, the script writes dumps to `%ProgramData%\Lidarr\Backups\postgres`, alongside Lidarr's own backup files. If you run more than one Servarr app against the same Postgres instance, use `-BackupDir` to specify a shared location instead:

``` prismjs
.\New-LidarrBackupTask.ps1 -PgPassword "yourpassword" -BackupDir "D:\backups\servarr\postgres"
```

> The generated script stores the password in plain text. Restrict access to `%ProgramData%\Lidarr\` to administrator accounts only.


