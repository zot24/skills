> Source: https://wiki.servarr.com/prowlarr/postgres-setup



# <a href="#prowlarr-and-postgres" class="toc-anchor">¶</a> Prowlarr and Postgres

This document will go over the key points of migrating and setting up Postgres support in Prowlarr.

This guide was created by the amazing <a href="https://github.com/Roxedus" class="is-external-link">Roxedus</a>.

> Postgres databases are NOT backed up by Prowlarr, any backups must be implemented and maintained by the user

> Prowlarr connects to Postgres via <a href="https://www.npgsql.org/" class="is-external-link">Npgsql</a> and supports all currently supported PostgreSQL versions (PostgreSQL 14 through 18). PostgreSQL 13 reached end-of-life in November 2025 and isn't recommended. This guide uses `postgres:17`. The SQLite-to-Postgres migration steps below were written against Postgres 14 and may need adjustment on newer majors; for Postgres 18 or later, start with a fresh database.

## <a href="#setting-up-postgres" class="toc-anchor">¶</a> Setting up Postgres

First, we need a Postgres instance. This guide is written for usage of the `postgres:17` Docker image.

> Do not even think about using the `latest` tag!

``` prismjs
docker create --name=postgres17 \
    -e POSTGRES_PASSWORD=qstick \
    -e POSTGRES_USER=qstick \
    -e POSTGRES_DB=prowlarr-main \
    -p 5432:5432/tcp \
    -v /path/to/appdata/postgres17:/var/lib/postgresql/data \
    postgres:17
```

## <a href="#creation-of-database" class="toc-anchor">¶</a> Creation of database

Prowlarr needs two databases, the default names of these are:

- `prowlarr-main` This is used to store all configuration and history
- `prowlarr-log` This is used to store events that produce a logentry

> Prowlarr will not create the databases for you. Make sure you create them ahead of time

Create the databases mentioned above using your favorite method - for example <a href="https://www.pgadmin.org/" class="is-external-link">pgAdmin</a> or <a href="https://www.adminer.org/" class="is-external-link">Adminer</a>.

> In order for the `Housekeeping` task to run, this user has to be a superuser, as it performs the vacuum task

You can give the databases any name you want but make sure `config.xml` file has the correct names. For further information see <a href="/prowlarr/postgres-setup#schema-creation" class="is-internal-link is-valid-page">schema creation</a>.

### <a href="#schema-creation" class="toc-anchor">¶</a> Schema creation

We need to tell Prowlarr to use Postgres. The `config.xml` should already be populated with the entries we need:

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

Only **after creating** both databases you can start the Prowlarr migration from SQLite to Postgres.

## <a href="#migrating-data" class="toc-anchor">¶</a> Migrating data

> If you do not want to migrate a existing SQLite database to Postgres then you are already finished with this guide!

> Migrating an existing sqlite3 database is unsupported, and this script may not work without modifications which we cannot assist you with. We support only new installs using postgres.

To migrate data we can use <a href="https://github.com/dimitri/pgloader" class="is-external-link">PGLoader</a>. It does, however, have some gotchas:

- By default transactions are case-insensitive, we use `--with "quote identifiers"` to make them sensitive.
- The version packaged in Debian and Ubuntu's apt repo are too old for newer versions of Postgres (Roxedus has not tested packages in other distros).  
  Roxedus <a href="https://github.com/Roxedus/Pgloader-bin" class="is-external-link">built a binary</a> to enable this support (no code modification was needed, simply had to be built with updated dependencies).

> Do not drop any tables in the Postgres instance

Before starting a migration please ensure that you have run Prowlarr against the created Postgres databases **at least once successfully**. Begin the migration by doing the following:

1.  Stop Prowlarr

2.  Open your preferred database management tool and connect to the Postgres database instance

3.  Start the migration by using either of these options:

    - ``` prismjs
      pgloader --with "quote identifiers" --with "data only" prowlarr.db 'postgresql://qstick:qstick@localhost/prowlarr-main'
      ```

    - ``` prismjs
      docker run --rm -v /absolute/path/to/prowlarr.db:/prowlarr.db:ro --network=host ghcr.io/roxedus/pgloader --with "quote identifiers" --with "data only" /prowlarr.db "postgresql://qstick:qstick@localhost/prowlarr-main"
      ```

    > If you experience an error using pgloader it could be due to your DB being too large, to resolve this try adding `--with "prefetch rows = 100" --with "batch size = 1MB"` to the above command

    > With these handled, it is pretty straightforward after telling it to not mess with the scheme using `--with "data only"`

4.  For those having the issues POST-MIGRATION from SQLite run the following:

    ``` prismjs
    select setval('public."ApplicationIndexerMapping_Id_seq"', (SELECT MAX("Id")+1 FROM "ApplicationIndexerMapping"));
    select setval('public."Applications_Id_seq"', (SELECT MAX("Id")+1 FROM "Applications"));
    select setval('public."ApplicationStatus_Id_seq"', (SELECT MAX("Id")+1 FROM "ApplicationStatus"));
    select setval('public."AppSyncProfiles_Id_seq"', (SELECT MAX("Id")+1 FROM "AppSyncProfiles"));
    select setval('public."Commands_Id_seq"', (SELECT MAX("Id")+1 FROM "Commands"));
    select setval('public."Config_Id_seq"', (SELECT MAX("Id")+1 FROM "Config"));
    select setval('public."CustomFilters_Id_seq"', (SELECT MAX("Id")+1 FROM "CustomFilters"));
    select setval('public."DownloadClients_Id_seq"', (SELECT MAX("Id")+1 FROM "DownloadClients"));
    select setval('public."DownloadClientStatus_Id_seq"', (SELECT MAX("Id")+1 FROM "DownloadClientStatus"));
    select setval('public."History_Id_seq"', (SELECT MAX("Id")+1 FROM "History"));
    select setval('public."IndexerDefinitionVersions_Id_seq"', (SELECT MAX("Id")+1 FROM "IndexerDefinitionVersions"));
    select setval('public."IndexerProxies_Id_seq"', (SELECT MAX("Id")+1 FROM "IndexerProxies"));
    select setval('public."Indexers_Id_seq"', (SELECT MAX("Id")+1 FROM "Indexers"));
    select setval('public."IndexerStatus_Id_seq"', (SELECT MAX("Id")+1 FROM "IndexerStatus"));
    select setval('public."NotificationStatus_Id_seq"', (SELECT MAX("Id")+1 FROM "NotificationStatus"));
    select setval('public."Notifications_Id_seq"', (SELECT MAX("Id")+1 FROM "Notifications"));
    select setval('public."ScheduledTasks_Id_seq"', (SELECT MAX("Id")+1 FROM "ScheduledTasks"));
    select setval('public."Tags_Id_seq"', (SELECT MAX("Id")+1 FROM "Tags"));
    select setval('public."Users_Id_seq"', (SELECT MAX("Id")+1 FROM "Users"));
    ```

5.  Start Prowlarr


