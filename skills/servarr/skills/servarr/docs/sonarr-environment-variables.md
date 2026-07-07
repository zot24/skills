> Source: https://wiki.servarr.com/sonarr/environment-variables



# <a href="#sonarr-environment-variables" class="toc-anchor">¶</a> Sonarr Environment Variables

Sonarr has the ability to use environment variables to override entries in config.xml. The pattern for variable naming is predictable and can be used to set any config entry. Environment variables are comprised of 3 parts, delimited by two underscores:

`SONARR__CONFIGNAMESPACE__CONFIGITEM`

## <a href="#configuration-namespaces" class="toc-anchor">¶</a> Configuration Namespaces

The config namespaces are shared between all Servarr apps and correspond to the option types in the project:

- **APP** - Application-specific settings
- **AUTH** - Authentication settings
- **LOG** - Logging configuration
- **POSTGRES** - PostgreSQL database settings
- **SERVER** - Server and network settings
- **UPDATE** - Update mechanism settings

## <a href="#environment-variables-table" class="toc-anchor">¶</a> Environment Variables Table

| Config Option            | Namespace  | Variable Name           | Full Environment Variable             |
|--------------------------|------------|-------------------------|---------------------------------------|
| `InstanceName`           | `APP`      | `INSTANCENAME`          | `SONARR__APP__INSTANCENAME`           |
| `Theme`                  | `APP`      | `THEME`                 | `SONARR__APP__THEME`                  |
| `LaunchBrowser`          | `APP`      | `LAUNCHBROWSER`         | `SONARR__APP__LAUNCHBROWSER`          |
| `ApiKey`                 | `AUTH`     | `APIKEY`                | `SONARR__AUTH__APIKEY`                |
| `AuthenticationEnabled`  | `AUTH`     | `ENABLED`               | `SONARR__AUTH__ENABLED`               |
| `AuthenticationMethod`   | `AUTH`     | `METHOD`                | `SONARR__AUTH__METHOD`                |
| `AuthenticationRequired` | `AUTH`     | `REQUIRED`              | `SONARR__AUTH__REQUIRED`              |
| `TrustCgnatIpAddresses`  | `AUTH`     | `TRUSTCGNATIPADDRESSES` | `SONARR__AUTH__TRUSTCGNATIPADDRESSES` |
| `LogLevel`               | `LOG`      | `LEVEL`                 | `SONARR__LOG__LEVEL`                  |
| `FilterSentryEvents`     | `LOG`      | `FILTERSENTRYEVENTS`    | `SONARR__LOG__FILTERSENTRYEVENTS`     |
| `LogRotate`              | `LOG`      | `ROTATE`                | `SONARR__LOG__ROTATE`                 |
| `LogSizeLimit`           | `LOG`      | `SIZELIMIT`             | `SONARR__LOG__SIZELIMIT`              |
| `LogSql`                 | `LOG`      | `SQL`                   | `SONARR__LOG__SQL`                    |
| `ConsoleLogLevel`        | `LOG`      | `CONSOLELEVEL`          | `SONARR__LOG__CONSOLELEVEL`           |
| `ConsoleLogFormat`       | `LOG`      | `CONSOLEFORMAT`         | `SONARR__LOG__CONSOLEFORMAT`          |
| `AnalyticsEnabled`       | `LOG`      | `ANALYTICSENABLED`      | `SONARR__LOG__ANALYTICSENABLED`       |
| `SyslogServer`           | `LOG`      | `SYSLOGSERVER`          | `SONARR__LOG__SYSLOGSERVER`           |
| `SyslogPort`             | `LOG`      | `SYSLOGPORT`            | `SONARR__LOG__SYSLOGPORT`             |
| `SyslogLevel`            | `LOG`      | `SYSLOGLEVEL`           | `SONARR__LOG__SYSLOGLEVEL`            |
| `LogDbEnabled`           | `LOG`      | `DBENABLED`             | `SONARR__LOG__DBENABLED`              |
| `PostgresHost`           | `POSTGRES` | `HOST`                  | `SONARR__POSTGRES__HOST`              |
| `PostgresPort`           | `POSTGRES` | `PORT`                  | `SONARR__POSTGRES__PORT`              |
| `PostgresUser`           | `POSTGRES` | `USER`                  | `SONARR__POSTGRES__USER`              |
| `PostgresPassword`       | `POSTGRES` | `PASSWORD`              | `SONARR__POSTGRES__PASSWORD`          |
| `PostgresMainDb`         | `POSTGRES` | `MAINDB`                | `SONARR__POSTGRES__MAINDB`            |
| `PostgresLogDb`          | `POSTGRES` | `LOGDB`                 | `SONARR__POSTGRES__LOGDB`             |
| `UrlBase`                | `SERVER`   | `URLBASE`               | `SONARR__SERVER__URLBASE`             |
| `BindAddress`            | `SERVER`   | `BINDADDRESS`           | `SONARR__SERVER__BINDADDRESS`         |
| `Port`                   | `SERVER`   | `PORT`                  | `SONARR__SERVER__PORT`                |
| `EnableSsl`              | `SERVER`   | `ENABLESSL`             | `SONARR__SERVER__ENABLESSL`           |
| `SslPort`                | `SERVER`   | `SSLPORT`               | `SONARR__SERVER__SSLPORT`             |
| `SslCertPath`            | `SERVER`   | `SSLCERTPATH`           | `SONARR__SERVER__SSLCERTPATH`         |
| `SslCertPassword`        | `SERVER`   | `SSLCERTPASSWORD`       | `SONARR__SERVER__SSLCERTPASSWORD`     |
| `UpdateMechanism`        | `UPDATE`   | `MECHANISM`             | `SONARR__UPDATE__MECHANISM`           |
| `UpdateAutomatically`    | `UPDATE`   | `AUTOMATICALLY`         | `SONARR__UPDATE__AUTOMATICALLY`       |
| `UpdateScriptPath`       | `UPDATE`   | `SCRIPTPATH`            | `SONARR__UPDATE__SCRIPTPATH`          |
| `Branch`                 | `UPDATE`   | `BRANCH`                | `SONARR__UPDATE__BRANCH`              |

## <a href="#usage-examples" class="toc-anchor">¶</a> Usage Examples

### <a href="#docker-compose" class="toc-anchor">¶</a> Docker Compose

``` prismjs
services:
  sonarr:
    image: lscr.io/linuxserver/sonarr:latest
    environment:
      - SONARR__SERVER__PORT=8989
      - SONARR__SERVER__URLBASE=/sonarr
      - SONARR__POSTGRES__HOST=postgres
      - SONARR__POSTGRES__USER=sonarr
      - SONARR__POSTGRES__PASSWORD=sonarr_password
      - SONARR__POSTGRES__MAINDB=sonarr
```

### <a href="#docker-run" class="toc-anchor">¶</a> Docker Run

``` prismjs
docker run -d \
  --name sonarr \
  -e SONARR__SERVER__PORT=8989 \
  -e SONARR__SERVER__URLBASE=/sonarr \
  -e SONARR__POSTGRES__HOST=postgres \
  -e SONARR__POSTGRES__USER=sonarr \
  lscr.io/linuxserver/sonarr:latest
```

### <a href="#system-environment-variables" class="toc-anchor">¶</a> System Environment Variables

For native installations, set environment variables using your system's method:

**Linux/macOS:**

``` prismjs
export SONARR__SERVER__PORT=8989
export SONARR__SERVER__URLBASE=/sonarr
export SONARR__POSTGRES__HOST=localhost
```

**Windows:**

``` prismjs
set SONARR__SERVER__PORT=8989
set SONARR__SERVER__URLBASE=/sonarr
set SONARR__POSTGRES__HOST=localhost
```

## <a href="#package-info-file" class="toc-anchor">¶</a> Package Info File

For package maintainers and custom installations, Sonarr supports a `package_info` file to override deployment settings.

### <a href="#location" class="toc-anchor">¶</a> Location

The `package_info` file should be placed in the parent directory of the `bin` folder:

``` prismjs
/opt/Sonarr/package_info
/opt/Sonarr/bin/Sonarr
```

### <a href="#format" class="toc-anchor">¶</a> Format

The file uses simple key=value pairs, one per line:

``` prismjs
PackageVersion=1.0.0
PackageAuthor=YourName
UpdateMethod=External
Branch=main
```

### <a href="#available-keys" class="toc-anchor">¶</a> Available Keys

| Key                    | Description                                | Example                      |
|------------------------|--------------------------------------------|------------------------------|
| `PackageVersion`       | Custom package version identifier          | `1.0.0-custom`               |
| `PackageAuthor`        | Package maintainer name                    | `Community Package`          |
| `PackageGlobalMessage` | Message displayed in UI                    | `Custom build for Debian 11` |
| `UpdateMethod`         | How updates are handled (see values below) | `External`                   |
| `UpdateMethodMessage`  | Custom message about update method         | `Updates managed by apt`     |
| `Branch`               | Default branch to use                      | `main` or `develop`          |
| `ReleaseVersion`       | Override release version                   | `4.0.0.0`                    |

### <a href="#updatemethod-values" class="toc-anchor">¶</a> UpdateMethod Values

| Value      | Numeric | Description                   | Use Case                    |
|------------|---------|-------------------------------|-----------------------------|
| `BuiltIn`  | 0       | Default built-in updater      | Standard installations      |
| `Script`   | 1       | Updates via custom script     | Advanced custom setups      |
| `External` | 10      | Updates managed externally    | Package managers, Docker    |
| `Apt`      | 11      | Debian/Ubuntu package manager | Used by package maintainers |
| `Docker`   | 12      | Docker container updates      | Used by Docker maintainers  |

### <a href="#real-world-example" class="toc-anchor">¶</a> Real-World Example

**Arch Linux AUR Package** (from <a href="https://aur.archlinux.org/packages/prowlarr/" class="is-external-link">prowlarr AUR</a>):

``` prismjs
# PackageVersion is added by PKGBUILD
PackageAuthor=[sonarr](https://aur.archlinux.org/packages/sonarr/)
UpdateMethod=External
UpdateMethodMessage=flag [sonarr](https://aur.archlinux.org/packages/sonarr/) [out-of-date](https://aur.archlinux.org/pkgbase/sonarr/flag/), use an [aur helper](https://wiki.archlinux.org/index.php/AUR_helpers) or the [manual method](https://wiki.archlinux.org/index.php/Arch_User_Repository#Installing_packages) to update.
Branch=main
```

## <a href="#notes" class="toc-anchor">¶</a> Notes

- Environment variables override config.xml entries
- Variable names are case-sensitive
- Restart Sonarr after changing environment variables
- The `package_info` file is read at startup and overrides built-in update mechanisms
- These variables are particularly useful for Docker deployments and automation


