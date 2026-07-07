> Source: https://wiki.servarr.com/sonarr/postgres-setup



# <a href="#sonarr-and-postgres" class="toc-anchor">¶</a> Sonarr and Postgres

This document will go over the key points of migrating and setting up Postgres support in Sonarr.

> Sonarr v4.0.0.615 or newer required

This guide was created by the amazing <a href="https://github.com/Roxedus" class="is-external-link">Roxedus</a>.

> Postgres databases are NOT backed up by Sonarr, any backups must be implemented and maintained by the user

> Sonarr connects to Postgres via <a href="https://www.npgsql.org/" class="is-external-link">Npgsql</a> and supports all currently supported PostgreSQL versions (PostgreSQL 14 through 18). PostgreSQL 13 reached end-of-life in November 2025 and isn't recommended. This guide uses `postgres:17`. The SQLite-to-Postgres migration steps below were written against Postgres 14 and may need adjustment on newer majors; for Postgres 18 or later, start with a fresh database.

## <a href="#setting-up-postgres" class="toc-anchor">¶</a> Setting up Postgres

First, we need a Postgres instance. This guide is written for usage of the `postgres:17` Docker image.

> Do not even think about using the `latest` tag!

``` prismjs
docker create --name=postgres17 \
    -e POSTGRES_PASSWORD=qstick \
    -e POSTGRES_USER=qstick \
    -e POSTGRES_DB=sonarr-main \
    -p 5432:5432/tcp \
    -v /path/to/appdata/postgres17:/var/lib/postgresql/data \
    postgres:17
```

## <a href="#creation-of-database" class="toc-anchor">¶</a> Creation of database

Sonarr needs two databases, the default names of these are:

- `sonarr-main` This is used to store all configuration and history
- `sonarr-log` This is used to store events that produce a logentry

> Sonarr will not create the databases for you. Make sure you create them ahead of time

Create the databases mentioned above using your favorite method - for example <a href="https://www.pgadmin.org/" class="is-external-link">pgAdmin</a> or <a href="https://www.adminer.org/" class="is-external-link">Adminer</a>.

You can give the databases any name you want but make sure `config.xml` file has the correct names. For further information see <a href="/sonarr/postgres-setup#schema-creation" class="is-internal-link is-valid-page">schema creation</a>.

### <a href="#schema-creation" class="toc-anchor">¶</a> Schema creation

We need to tell Sonarr to use Postgres. The `config.xml` should already be populated with the entries we need:

``` prismjs
<PostgresUser>qstick</PostgresUser>
<PostgresPassword>qstick</PostgresPassword>
<PostgresPort>5432</PostgresPort>
<PostgresHost>postgres17</PostgresHost>
```

If you want to specify a database name then should also include the following configuration:

``` prismjs
<PostgresMainDb>MainDbName</PostgresMainDb>
<PostgresLogDb>LogDbName</PostgresLogDb>
```

Only **after creating** both databases you can start the Sonarr migration from SQLite to Postgres.

## <a href="#migrating-data" class="toc-anchor">¶</a> Migrating data

> If you do not want to migrate a existing SQLite database to Postgres then you are already finished with this guide!

> Migrating an existing sqlite3 database is unsupported, and this script may not work without modifications which we cannot assist you with. We support only new installs using postgres.

To migrate data we can use <a href="https://github.com/dimitri/pgloader" class="is-external-link">PGLoader</a>. It does, however, have some gotchas:

- By default transactions are case-insensitive, we use `--with "quote identifiers"` to make them sensitive.
- The version packaged in Debian and Ubuntu's apt repo are too old for newer versions of Postgres (Roxedus has not tested packages in other distros).  
  Roxedus <a href="https://github.com/Roxedus/Pgloader-bin" class="is-external-link">built a binary</a> to enable this support (no code modification was needed, simply had to be built with updated dependencies).

> Do not drop any tables in the Postgres instance

Before starting a migration please ensure that you have run Sonarr against the created Postgres databases **at least once** successfully. Begin the migration by doing the following:

1.  Stop Sonarr
2.  Open your preferred database management tool and connect to the Postgres database instance
3.  Run the following commands:

``` prismjs
DELETE FROM "QualityProfiles";
DELETE FROM "QualityDefinitions";
DELETE FROM "DelayProfiles";
DELETE FROM "Metadata";
DELETE FROM "Config";
DELETE FROM "VersionInfo";
DELETE FROM "ScheduledTasks";
```

1.  Start the migration by using either of these options:

    - ``` prismjs
      pgloader --with "quote identifiers" --with "data only" sonarr.db 'postgresql://qstick:qstick@localhost/sonarr-main'
      ```

    - ``` prismjs
      docker run --rm -v /absolute/path/to/sonarr.db:/sonarr.db:ro --network=host ghcr.io/roxedus/pgloader --with "quote identifiers" --with "data only" /sonarr.db "postgresql://qstick:qstick@localhost/sonarr-main"
      ```

    > If you experience an error using pgloader it could be due to your DB being too large, to resolve this try adding `--with "prefetch rows = 100" --with "batch size = 1MB"` to the above command

    > With these handled, it is pretty straightforward after telling it to not mess with the scheme using `--with "data only"`

2.  For those having the issues POST-MIGRATION from SQLite run the following:

    ``` prismjs
    select setval('public."AutoTagging_Id_seq"',(SELECT MAX("Id")+1 FROM "AutoTagging"));
    select setval('public."Blacklist_Id_seq"',(SELECT MAX("Id")+1 FROM "Blocklist"));
    select setval('public."Commands_Id_seq"',(SELECT MAX("Id")+1 FROM "Commands"));
    select setval('public."Config_Id_seq"',(SELECT MAX("Id")+1 FROM "Config"));
    select setval('public."CustomFilters_Id_seq"',(SELECT MAX("Id")+1 FROM "CustomFilters"));
    select setval('public."CustomFormats_Id_seq"',(SELECT MAX("Id")+1 FROM "CustomFormats"));
    select setval('public."DelayProfiles_Id_seq"',(SELECT MAX("Id")+1 FROM "DelayProfiles"));
    select setval('public."DownloadClientStatus_Id_seq"',(SELECT MAX("Id")+1 FROM "DownloadClientStatus"));
    select setval('public."DownloadClients_Id_seq"',(SELECT MAX("Id")+1 FROM "DownloadClients"));
    select setval('public."DownloadHistory_Id_seq"',(SELECT MAX("Id")+1 FROM "DownloadHistory"));
    select setval('public."EpisodeFiles_Id_seq"',(SELECT MAX("Id")+1 FROM "EpisodeFiles"));
    select setval('public."Episodes_Id_seq"',(SELECT MAX("Id")+1 FROM "Episodes"));
    select setval('public."ExtraFiles_Id_seq"',(SELECT MAX("Id")+1 FROM "ExtraFiles"));
    select setval('public."History_Id_seq"',(SELECT MAX("Id")+1 FROM "History"));
    select setval('public."ImportListExclusions_Id_seq"',(SELECT MAX("Id")+1 FROM "ImportListExclusions"));
    select setval('public."ImportListItems_Id_seq"',(SELECT MAX("Id")+1 FROM "ImportListItems"));
    select setval('public."ImportListStatus_Id_seq"',(SELECT MAX("Id")+1 FROM "ImportListStatus"));
    select setval('public."ImportLists_Id_seq"',(SELECT MAX("Id")+1 FROM "ImportLists"));
    select setval('public."IndexerStatus_Id_seq"',(SELECT MAX("Id")+1 FROM "IndexerStatus"));
    select setval('public."Indexers_Id_seq"',(SELECT MAX("Id")+1 FROM "Indexers"));
    select setval('public."MetadataFiles_Id_seq"',(SELECT MAX("Id")+1 FROM "MetadataFiles"));
    select setval('public."Metadata_Id_seq"',(SELECT MAX("Id")+1 FROM "Metadata"));
    select setval('public."NamingConfig_Id_seq"',(SELECT MAX("Id")+1 FROM "NamingConfig"));
    select setval('public."NotificationStatus_Id_seq"',(SELECT MAX("Id")+1 FROM "NotificationStatus"));
    select setval('public."Notifications_Id_seq"',(SELECT MAX("Id")+1 FROM "Notifications"));
    select setval('public."PendingReleases_Id_seq"',(SELECT MAX("Id")+1 FROM "PendingReleases"));
    select setval('public."QualityDefinitions_Id_seq"',(SELECT MAX("Id")+1 FROM "QualityDefinitions"));
    select setval('public."QualityProfiles_Id_seq"',(SELECT MAX("Id")+1 FROM "QualityProfiles"));
    select setval('public."RemotePathMappings_Id_seq"',(SELECT MAX("Id")+1 FROM "RemotePathMappings"));
    select setval('public."RootFolders_Id_seq"',(SELECT MAX("Id")+1 FROM "RootFolders"));
    select setval('public."SceneMappings_Id_seq"',(SELECT MAX("Id")+1 FROM "SceneMappings"));
    select setval('public."ScheduledTasks_Id_seq"',(SELECT MAX("Id")+1 FROM "ScheduledTasks"));
    select setval('public."Series_Id_seq"',(SELECT MAX("Id")+1 FROM "Series"));
    select setval('public."SubtitleFiles_Id_seq"',(SELECT MAX("Id")+1 FROM "SubtitleFiles"));
    select setval('public."Tags_Id_seq"',(SELECT MAX("Id")+1 FROM "Tags"));
    select setval('public."UpdateHistory_Id_seq"',(SELECT MAX("Id")+1 FROM "UpdateHistory"));
    select setval('public."Users_Id_seq"',(SELECT MAX("Id")+1 FROM "Users"));
    ```

3.  Start Sonarr


