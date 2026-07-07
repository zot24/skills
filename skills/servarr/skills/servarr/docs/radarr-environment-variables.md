> Source: https://wiki.servarr.com/radarr/environment-variables



# <a href="#radarr-environment-variables" class="toc-anchor">¶</a> Radarr Environment Variables

Radarr has the ability to use environment variables to override entries in config.xml. The pattern for variable naming is predictable and can be used to set any config entry. Environment variables are comprised of 3 parts, delimited by two underscores:

`RADARR__CONFIGNAMESPACE__CONFIGITEM`

## <a href="#configuration-namespaces" class="toc-anchor">¶</a> Configuration Namespaces

The config namespaces are shared between all Servarr apps and correspond to the option types in the project:

- **APP** - Application-specific settings
- **AUTH** - Authentication settings
- **LOG** - Logging configuration
- **POSTGRES** - PostgreSQL database settings
- **SERVER** - Server and network settings
- **UPDATE** - Update mechanism settings

## <a href="#environment-variables-table" class="toc-anchor">¶</a> Environment Variables Table

| Config Option                    | Namespace  | Variable Name            | Full Environment Variable                  |
|----------------------------------|------------|--------------------------|--------------------------------------------|
| `InstanceName`                   | `APP`      | `INSTANCENAME`           | `RADARR__APP__INSTANCENAME`                |
| `Theme`                          | `APP`      | `THEME`                  | `RADARR__APP__THEME`                       |
| `LaunchBrowser`                  | `APP`      | `LAUNCHBROWSER`          | `RADARR__APP__LAUNCHBROWSER`               |
| `ApiKey`                         | `AUTH`     | `APIKEY`                 | `RADARR__AUTH__APIKEY`                     |
| `AuthenticationEnabled`          | `AUTH`     | `ENABLED`                | `RADARR__AUTH__ENABLED`                    |
| `AuthenticationMethod`           | `AUTH`     | `METHOD`                 | `RADARR__AUTH__METHOD`                     |
| `AuthenticationRequired`         | `AUTH`     | `REQUIRED`               | `RADARR__AUTH__REQUIRED`                   |
| `TrustCgnatIpAddresses`          | `AUTH`     | `TRUSTCGNATIPADDRESSES`  | `RADARR__AUTH__TRUSTCGNATIPADDRESSES`      |
| `LogLevel`                       | `LOG`      | `LEVEL`                  | `RADARR__LOG__LEVEL`                       |
| `FilterSentryEvents`             | `LOG`      | `FILTERSENTRYEVENTS`     | `RADARR__LOG__FILTERSENTRYEVENTS`          |
| `LogRotate`                      | `LOG`      | `ROTATE`                 | `RADARR__LOG__ROTATE`                      |
| `LogSizeLimit`                   | `LOG`      | `SIZELIMIT`              | `RADARR__LOG__SIZELIMIT`                   |
| `LogSql`                         | `LOG`      | `SQL`                    | `RADARR__LOG__SQL`                         |
| `ConsoleLogLevel`                | `LOG`      | `CONSOLELEVEL`           | `RADARR__LOG__CONSOLELEVEL`                |
| `ConsoleLogFormat`               | `LOG`      | `CONSOLEFORMAT`          | `RADARR__LOG__CONSOLEFORMAT`               |
| `AnalyticsEnabled`               | `LOG`      | `ANALYTICSENABLED`       | `RADARR__LOG__ANALYTICSENABLED`            |
| `SyslogServer`                   | `LOG`      | `SYSLOGSERVER`           | `RADARR__LOG__SYSLOGSERVER`                |
| `SyslogPort`                     | `LOG`      | `SYSLOGPORT`             | `RADARR__LOG__SYSLOGPORT`                  |
| `SyslogLevel`                    | `LOG`      | `SYSLOGLEVEL`            | `RADARR__LOG__SYSLOGLEVEL`                 |
| `LogDbEnabled`                   | `LOG`      | `DBENABLED`              | `RADARR__LOG__DBENABLED`                   |
| `PostgresHost`                   | `POSTGRES` | `HOST`                   | `RADARR__POSTGRES__HOST`                   |
| `PostgresPort`                   | `POSTGRES` | `PORT`                   | `RADARR__POSTGRES__PORT`                   |
| `PostgresUser`                   | `POSTGRES` | `USER`                   | `RADARR__POSTGRES__USER`                   |
| `PostgresPassword`               | `POSTGRES` | `PASSWORD`               | `RADARR__POSTGRES__PASSWORD`               |
| `PostgresMainDb`                 | `POSTGRES` | `MAINDB`                 | `RADARR__POSTGRES__MAINDB`                 |
| `PostgresLogDb`                  | `POSTGRES` | `LOGDB`                  | `RADARR__POSTGRES__LOGDB`                  |
| `PostgresMainDbConnectionString` | `POSTGRES` | `MAINDBCONNECTIONSTRING` | `RADARR__POSTGRES__MAINDBCONNECTIONSTRING` |
| `PostgresLogDbConnectionString`  | `POSTGRES` | `LOGDBCONNECTIONSTRING`  | `RADARR__POSTGRES__LOGDBCONNECTIONSTRING`  |
| `UrlBase`                        | `SERVER`   | `URLBASE`                | `RADARR__SERVER__URLBASE`                  |
| `BindAddress`                    | `SERVER`   | `BINDADDRESS`            | `RADARR__SERVER__BINDADDRESS`              |
| `Port`                           | `SERVER`   | `PORT`                   | `RADARR__SERVER__PORT`                     |
| `EnableSsl`                      | `SERVER`   | `ENABLESSL`              | `RADARR__SERVER__ENABLESSL`                |
| `SslPort`                        | `SERVER`   | `SSLPORT`                | `RADARR__SERVER__SSLPORT`                  |
| `SslCertPath`                    | `SERVER`   | `SSLCERTPATH`            | `RADARR__SERVER__SSLCERTPATH`              |
| `SslCertPassword`                | `SERVER`   | `SSLCERTPASSWORD`        | `RADARR__SERVER__SSLCERTPASSWORD`          |
| `UpdateMechanism`                | `UPDATE`   | `MECHANISM`              | `RADARR__UPDATE__MECHANISM`                |
| `UpdateAutomatically`            | `UPDATE`   | `AUTOMATICALLY`          | `RADARR__UPDATE__AUTOMATICALLY`            |
| `UpdateScriptPath`               | `UPDATE`   | `SCRIPTPATH`             | `RADARR__UPDATE__SCRIPTPATH`               |
| `Branch`                         | `UPDATE`   | `BRANCH`                 | `RADARR__UPDATE__BRANCH`                   |

## <a href="#usage-examples" class="toc-anchor">¶</a> Usage Examples

### <a href="#docker-compose" class="toc-anchor">¶</a> Docker Compose

``` prismjs
services:
  radarr:
    image: lscr.io/linuxserver/radarr:latest
    environment:
      - RADARR__SERVER__PORT=7878
      - RADARR__SERVER__URLBASE=/radarr
      - RADARR__POSTGRES__HOST=postgres
      - RADARR__POSTGRES__USER=radarr
      - RADARR__POSTGRES__PASSWORD=radarr_password
      - RADARR__POSTGRES__MAINDB=radarr
```

### <a href="#docker-run" class="toc-anchor">¶</a> Docker Run

``` prismjs
docker run -d \
  --name radarr \
  -e RADARR__SERVER__PORT=7878 \
  -e RADARR__SERVER__URLBASE=/radarr \
  -e RADARR__POSTGRES__HOST=postgres \
  -e RADARR__POSTGRES__USER=radarr \
  lscr.io/linuxserver/radarr:latest
```

### <a href="#system-environment-variables" class="toc-anchor">¶</a> System Environment Variables

For native installations, set environment variables using your system's method:

**Linux/macOS:**

``` prismjs
export RADARR__SERVER__PORT=7878
export RADARR__SERVER__URLBASE=/radarr
export RADARR__POSTGRES__HOST=localhost
```

**Windows:**

``` prismjs
set RADARR__SERVER__PORT=7878
set RADARR__SERVER__URLBASE=/radarr
set RADARR__POSTGRES__HOST=localhost
```

## <a href="#package-info-file" class="toc-anchor">¶</a> Package Info File

For package maintainers and custom installations, Radarr supports a `package_info` file to override deployment settings.

### <a href="#location" class="toc-anchor">¶</a> Location

The `package_info` file should be placed in the parent directory of the `bin` folder:

``` prismjs
/opt/Radarr/package_info
/opt/Radarr/bin/Radarr
```

### <a href="#format" class="toc-anchor">¶</a> Format

The file uses simple key=value pairs, one per line:

``` prismjs
PackageVersion=1.0.0
PackageAuthor=YourName
UpdateMethod=External
Branch=master
```

### <a href="#available-keys" class="toc-anchor">¶</a> Available Keys

| Key                    | Description                                | Example                      |
|------------------------|--------------------------------------------|------------------------------|
| `PackageVersion`       | Custom package version identifier          | `1.0.0-custom`               |
| `PackageAuthor`        | Package maintainer name                    | `Community Package`          |
| `PackageGlobalMessage` | Message displayed in UI                    | `Custom build for Debian 11` |
| `UpdateMethod`         | How updates are handled (see values below) | `External`                   |
| `UpdateMethodMessage`  | Custom message about update method         | `Updates managed by apt`     |
| `Branch`               | Default branch to use                      | `master` or `develop`        |
| `ReleaseVersion`       | Override release version                   | `5.0.0.0`                    |

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
PackageAuthor=[radarr](https://aur.archlinux.org/packages/radarr/)
UpdateMethod=External
UpdateMethodMessage=flag [radarr](https://aur.archlinux.org/packages/radarr/) [out-of-date](https://aur.archlinux.org/pkgbase/radarr/flag/), use an [aur helper](https://wiki.archlinux.org/index.php/AUR_helpers) or the [manual method](https://wiki.archlinux.org/index.php/Arch_User_Repository#Installing_packages) to update.
Branch=master
```

## <a href="#notes" class="toc-anchor">¶</a> Notes

- Environment variables override config.xml entries
- Variable names are case-sensitive
- Restart Radarr after changing environment variables
- The `package_info` file is read at startup and overrides built-in update mechanisms
- These variables are particularly useful for Docker deployments and automation


