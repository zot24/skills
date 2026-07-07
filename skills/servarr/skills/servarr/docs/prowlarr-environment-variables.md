> Source: https://wiki.servarr.com/prowlarr/environment-variables



# <a href="#prowlarr-environment-variables" class="toc-anchor">¶</a> Prowlarr Environment Variables

Prowlarr has the ability to use environment variables to override entries in config.xml. The pattern for variable naming is predictable and can be used to set any config entry. Environment variables are comprised of 3 parts, delimited by two underscores:

`PROWLARR__CONFIGNAMESPACE__CONFIGITEM`

## <a href="#configuration-namespaces" class="toc-anchor">¶</a> Configuration Namespaces

The config namespaces are shared between all Servarr apps and correspond to the option types in the project:

- **APP** - Application-specific settings
- **AUTH** - Authentication settings
- **LOG** - Logging configuration
- **POSTGRES** - PostgreSQL database settings
- **SERVER** - Server and network settings
- **UPDATE** - Update mechanism settings

## <a href="#environment-variables-table" class="toc-anchor">¶</a> Environment Variables Table

| Config Option                    | Namespace  | Variable Name            | Full Environment Variable                    |
|----------------------------------|------------|--------------------------|----------------------------------------------|
| `InstanceName`                   | `APP`      | `INSTANCENAME`           | `PROWLARR__APP__INSTANCENAME`                |
| `Theme`                          | `APP`      | `THEME`                  | `PROWLARR__APP__THEME`                       |
| `LaunchBrowser`                  | `APP`      | `LAUNCHBROWSER`          | `PROWLARR__APP__LAUNCHBROWSER`               |
| `ApiKey`                         | `AUTH`     | `APIKEY`                 | `PROWLARR__AUTH__APIKEY`                     |
| `AuthenticationEnabled`          | `AUTH`     | `ENABLED`                | `PROWLARR__AUTH__ENABLED`                    |
| `AuthenticationMethod`           | `AUTH`     | `METHOD`                 | `PROWLARR__AUTH__METHOD`                     |
| `AuthenticationRequired`         | `AUTH`     | `REQUIRED`               | `PROWLARR__AUTH__REQUIRED`                   |
| `TrustCgnatIpAddresses`          | `AUTH`     | `TRUSTCGNATIPADDRESSES`  | `PROWLARR__AUTH__TRUSTCGNATIPADDRESSES`      |
| `LogLevel`                       | `LOG`      | `LEVEL`                  | `PROWLARR__LOG__LEVEL`                       |
| `FilterSentryEvents`             | `LOG`      | `FILTERSENTRYEVENTS`     | `PROWLARR__LOG__FILTERSENTRYEVENTS`          |
| `LogRotate`                      | `LOG`      | `ROTATE`                 | `PROWLARR__LOG__ROTATE`                      |
| `LogSizeLimit`                   | `LOG`      | `SIZELIMIT`              | `PROWLARR__LOG__SIZELIMIT`                   |
| `LogSql`                         | `LOG`      | `SQL`                    | `PROWLARR__LOG__SQL`                         |
| `ConsoleLogLevel`                | `LOG`      | `CONSOLELEVEL`           | `PROWLARR__LOG__CONSOLELEVEL`                |
| `ConsoleLogFormat`               | `LOG`      | `CONSOLEFORMAT`          | `PROWLARR__LOG__CONSOLEFORMAT`               |
| `AnalyticsEnabled`               | `LOG`      | `ANALYTICSENABLED`       | `PROWLARR__LOG__ANALYTICSENABLED`            |
| `SyslogServer`                   | `LOG`      | `SYSLOGSERVER`           | `PROWLARR__LOG__SYSLOGSERVER`                |
| `SyslogPort`                     | `LOG`      | `SYSLOGPORT`             | `PROWLARR__LOG__SYSLOGPORT`                  |
| `SyslogLevel`                    | `LOG`      | `SYSLOGLEVEL`            | `PROWLARR__LOG__SYSLOGLEVEL`                 |
| `LogDbEnabled`                   | `LOG`      | `DBENABLED`              | `PROWLARR__LOG__DBENABLED`                   |
| `PostgresHost`                   | `POSTGRES` | `HOST`                   | `PROWLARR__POSTGRES__HOST`                   |
| `PostgresPort`                   | `POSTGRES` | `PORT`                   | `PROWLARR__POSTGRES__PORT`                   |
| `PostgresUser`                   | `POSTGRES` | `USER`                   | `PROWLARR__POSTGRES__USER`                   |
| `PostgresPassword`               | `POSTGRES` | `PASSWORD`               | `PROWLARR__POSTGRES__PASSWORD`               |
| `PostgresMainDb`                 | `POSTGRES` | `MAINDB`                 | `PROWLARR__POSTGRES__MAINDB`                 |
| `PostgresLogDb`                  | `POSTGRES` | `LOGDB`                  | `PROWLARR__POSTGRES__LOGDB`                  |
| `PostgresMainDbConnectionString` | `POSTGRES` | `MAINDBCONNECTIONSTRING` | `PROWLARR__POSTGRES__MAINDBCONNECTIONSTRING` |
| `PostgresLogDbConnectionString`  | `POSTGRES` | `LOGDBCONNECTIONSTRING`  | `PROWLARR__POSTGRES__LOGDBCONNECTIONSTRING`  |
| `UrlBase`                        | `SERVER`   | `URLBASE`                | `PROWLARR__SERVER__URLBASE`                  |
| `BindAddress`                    | `SERVER`   | `BINDADDRESS`            | `PROWLARR__SERVER__BINDADDRESS`              |
| `Port`                           | `SERVER`   | `PORT`                   | `PROWLARR__SERVER__PORT`                     |
| `EnableSsl`                      | `SERVER`   | `ENABLESSL`              | `PROWLARR__SERVER__ENABLESSL`                |
| `SslPort`                        | `SERVER`   | `SSLPORT`                | `PROWLARR__SERVER__SSLPORT`                  |
| `SslCertPath`                    | `SERVER`   | `SSLCERTPATH`            | `PROWLARR__SERVER__SSLCERTPATH`              |
| `SslCertPassword`                | `SERVER`   | `SSLCERTPASSWORD`        | `PROWLARR__SERVER__SSLCERTPASSWORD`          |
| `UpdateMechanism`                | `UPDATE`   | `MECHANISM`              | `PROWLARR__UPDATE__MECHANISM`                |
| `UpdateAutomatically`            | `UPDATE`   | `AUTOMATICALLY`          | `PROWLARR__UPDATE__AUTOMATICALLY`            |
| `UpdateScriptPath`               | `UPDATE`   | `SCRIPTPATH`             | `PROWLARR__UPDATE__SCRIPTPATH`               |
| `Branch`                         | `UPDATE`   | `BRANCH`                 | `PROWLARR__UPDATE__BRANCH`                   |

## <a href="#usage-examples" class="toc-anchor">¶</a> Usage Examples

### <a href="#docker-compose" class="toc-anchor">¶</a> Docker Compose

``` prismjs
services:
  prowlarr:
    image: lscr.io/linuxserver/prowlarr:latest
    environment:
      - PROWLARR__SERVER__PORT=9696
      - PROWLARR__SERVER__URLBASE=/prowlarr
      - PROWLARR__POSTGRES__HOST=postgres
      - PROWLARR__POSTGRES__USER=prowlarr
      - PROWLARR__POSTGRES__PASSWORD=prowlarr_password
      - PROWLARR__POSTGRES__MAINDB=prowlarr
```

### <a href="#docker-run" class="toc-anchor">¶</a> Docker Run

``` prismjs
docker run -d \
  --name prowlarr \
  -e PROWLARR__SERVER__PORT=9696 \
  -e PROWLARR__SERVER__URLBASE=/prowlarr \
  -e PROWLARR__POSTGRES__HOST=postgres \
  -e PROWLARR__POSTGRES__USER=prowlarr \
  lscr.io/linuxserver/prowlarr:latest
```

### <a href="#system-environment-variables" class="toc-anchor">¶</a> System Environment Variables

For native installations, set environment variables using your system's method:

**Linux/macOS:**

``` prismjs
export PROWLARR__SERVER__PORT=9696
export PROWLARR__SERVER__URLBASE=/prowlarr
```

**Windows:**

``` prismjs
set PROWLARR__SERVER__PORT=9696
set PROWLARR__SERVER__URLBASE=/prowlarr
```

## <a href="#package-info-file" class="toc-anchor">¶</a> Package Info File

For package maintainers and custom installations, Prowlarr supports a `package_info` file to override deployment settings.

### <a href="#location" class="toc-anchor">¶</a> Location

The `package_info` file should be placed in the parent directory of the `bin` folder:

``` prismjs
/opt/Prowlarr/package_info
/opt/Prowlarr/bin/Prowlarr
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
| `ReleaseVersion`       | Override release version                   | `1.0.0.0`                    |

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
PackageAuthor=[prowlarr](https://aur.archlinux.org/packages/prowlarr/)
UpdateMethod=External
UpdateMethodMessage=flag [prowlarr](https://aur.archlinux.org/packages/prowlarr/) [out-of-date](https://aur.archlinux.org/pkgbase/prowlarr/flag/), use an [aur helper](https://wiki.archlinux.org/index.php/AUR_helpers) or the [manual method](https://wiki.archlinux.org/index.php/Arch_User_Repository#Installing_packages) to update.
Branch=master
```

## <a href="#notes" class="toc-anchor">¶</a> Notes

- Environment variables override config.xml entries
- Variable names are case-sensitive
- Restart Prowlarr after changing environment variables
- The `package_info` file is read at startup and overrides built-in update mechanisms
- These variables are particularly useful for Docker deployments and automation


