> Source: https://docs.umami.is/docs/environment-variables



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2 text-xl font-bold text-foreground tracking-[-0.03em]" target="_blank" rel="noreferrer"><img src="/logo.svg" class="h-6 w-auto dark:hidden" /><img src="/logo.svg" class="hidden h-6 w-auto dark:block" /><span>umami</span></a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center rounded-md text-sm font-medium text-foreground hover:bg-accent hover:text-foreground size-8 justify-center" target="_blank" rel="noreferrer" aria-label="Umami on GitHub"></a>


Menu


Configuration


# Environment variables


Copy page


You can configure Umami with the use of environment variables. They go into the same `.env` file as your `DATABASE_URL`.

------------------------------------------------------------------------

## Runtime variables<a href="#runtime-variables" class="heading-anchor" aria-label="Permalink to “Runtime variables”">#</a>

Runtime variables are recognized when Umami is running. You can set your environment variables prior to starting the application.

### APP_SECRET<a href="#app_secret" class="heading-anchor" aria-label="Permalink to “APP_SECRET”">#</a>


A random string used to secure authentication tokens. Each installation should have a unique value. You can generate one with:


``` code-block
openssl rand -hex 32
```


``` code-block
APP_SECRET = "random string"
```


### CLIENT_IP_HEADER<a href="#client_ip_header" class="heading-anchor" aria-label="Permalink to “CLIENT_IP_HEADER”">#</a>


HTTP header to check for the client's IP address. This is useful when you're behind a proxy that uses non-standard headers.


``` code-block
CLIENT_IP_HEADER = "header name"
```


### COLLECT_API_ENDPOINT<a href="#collect_api_endpoint" class="heading-anchor" aria-label="Permalink to “COLLECT_API_ENDPOINT”">#</a>


Allows you to send metrics to a location different than the default `/api/send`. This is to help you avoid some [ad blockers](/docs/bypass-ad-blockers).


``` code-block
COLLECT_API_ENDPOINT = "/my-custom-route"
```


### CORS_MAX_AGE<a href="#cors_max_age" class="heading-anchor" aria-label="Permalink to “CORS_MAX_AGE”">#</a>


How many seconds a CORS preflight should last. Default is 24 hours.


``` code-block
CORS_MAX_AGE = 86400
```


### DATABASE_URL<a href="#database_url" class="heading-anchor" aria-label="Permalink to “DATABASE_URL”">#</a>


``` code-block
DATABASE_URL = "connection string"
```


Connection string for your database. This is the only required variable.

### DEBUG<a href="#debug" class="heading-anchor" aria-label="Permalink to “DEBUG”">#</a>


Console logging for specific areas of the application. Values include `umami:auth`, `umami:clickhouse`, `umami:kafka`, `umami:middleware`, and `umami:prisma`.


``` code-block
DEBUG = "umami:*"
```


### DISABLE_BOT_CHECK<a href="#disable_bot_check" class="heading-anchor" aria-label="Permalink to “DISABLE_BOT_CHECK”">#</a>


By default bots are excluded from statistics. This disables checking for bots.


``` code-block
DISABLE_BOT_CHECK = 1
```


### DISABLE_LOGIN<a href="#disable_login" class="heading-anchor" aria-label="Permalink to “DISABLE_LOGIN”">#</a>


Disables the login page for the application.


``` code-block
DISABLE_LOGIN = 1
```


### DISABLE_TELEMETRY<a href="#disable_telemetry" class="heading-anchor" aria-label="Permalink to “DISABLE_TELEMETRY”">#</a>


Umami collects completely anonymous telemetry data in order help improve the application. You can choose to disable this if you don't want to participate.


``` code-block
DISABLE_TELEMETRY = 1
```


### DISABLE_UPDATES<a href="#disable_updates" class="heading-anchor" aria-label="Permalink to “DISABLE_UPDATES”">#</a>


Disables the check for new versions of Umami.


``` code-block
DISABLE_UPDATES = 1
```


### ENABLE_TEST_CONSOLE<a href="#enable_test_console" class="heading-anchor" aria-label="Permalink to “ENABLE_TEST_CONSOLE”">#</a>


Enables the internal test page, `{host}/console`. Admin access is required. Users can manually fire pageviews and events to their websites.


``` code-block
ENABLE_TEST_CONSOLE = 1
```


### FAVICON_URL<a href="#favicon_url" class="heading-anchor" aria-label="Permalink to “FAVICON_URL”">#</a>


The URL of the service for displaying website icons.


``` code-block
FAVICON_URL = "service URL"
```


The default is `icons.duckduckgo.com`:

- <https://icons.duckduckgo.com/ip3/%7B%7Bdomain%7D%7D.ico>

Some alternatives you can use:

- <https://www.google.com/s2/favicons?domain=%7B%7Bdomain%7D%7D>
- <https://logo.clearbit.com/%7B%7Bdomain%7D%7D>

### GEO_DATABASE_URL<a href="#geo_database_url" class="heading-anchor" aria-label="Permalink to “GEO_DATABASE_URL”">#</a>


The URL for downloading a MaxMind-compatible GeoIP database in MMDB format. This is used for IP-based location detection when location headers from a CDN are not available.


``` code-block
GEO_DATABASE_URL = "https://example.com/GeoLite2-City.mmdb"
```


### HOSTNAME / PORT<a href="#hostname--port" class="heading-anchor" aria-label="Permalink to “HOSTNAME / PORT”">#</a>


If you are running on an environment which requires you to bind to a specific hostname or port, such as Heroku, you can add these variables and start your app with `npm run start-env` instead of `npm start`.


``` code-block
HOSTNAME = "my.hostname.com"
PORT = 3000
```


### IGNORE_IP<a href="#ignore_ip" class="heading-anchor" aria-label="Permalink to “IGNORE_IP”">#</a>


You can provide a comma-delimited list of IP addresses and CIDR ranges to exclude from data collection.


``` code-block
IGNORE_IP = "192.168.0.1, 10.0.0.0/24, 2001:db8::/32"
```


### LOG_QUERY<a href="#log_query" class="heading-anchor" aria-label="Permalink to “LOG_QUERY”">#</a>


If you are running in development mode, this will log database queries to the console for debugging.


``` code-block
LOG_QUERY = 1
```


### PRIVATE_MODE<a href="#private_mode" class="heading-anchor" aria-label="Permalink to “PRIVATE_MODE”">#</a>


Disables all external network calls. Note, this will also disable all website icons since they come from duckduckgo.com.


``` code-block
PRIVATE_MODE = 1
```


### REDIS_URL<a href="#redis_url" class="heading-anchor" aria-label="Permalink to “REDIS_URL”">#</a>


Optional Redis connection string used for caching and coordination features. If omitted, Redis-backed features stay disabled.


``` code-block
REDIS_URL = "redis://localhost:6379"
```


### REMOVE_TRAILING_SLASH<a href="#remove_trailing_slash" class="heading-anchor" aria-label="Permalink to “REMOVE_TRAILING_SLASH”">#</a>


Removes the trailing slash from all incoming urls.


``` code-block
REMOVE_TRAILING_SLASH = 1
```


### SALT_ROTATION<a href="#salt_rotation" class="heading-anchor" aria-label="Permalink to “SALT_ROTATION”">#</a>


Controls how often the anonymous session salt rotates for generated session identifiers. The default is `month`.


``` code-block
SALT_ROTATION = "month"
```


### SKIP_LOCATION_HEADERS<a href="#skip_location_headers" class="heading-anchor" aria-label="Permalink to “SKIP_LOCATION_HEADERS”">#</a>


Skips using known location headers for country/region/city detection and forces using the local geo database.

This is useful in environments where only the country (without region or city) header is set from the proxy or CDN (like Cloudflare’s `CF-IPCountry` when Network \> IP Geolocation is switched to On).


``` code-block
SKIP_LOCATION_HEADERS = 1
```


### TRACKER_SCRIPT_NAME<a href="#tracker_script_name" class="heading-anchor" aria-label="Permalink to “TRACKER_SCRIPT_NAME”">#</a>


Allows you to assign a custom name to the tracker script different from the default `script.js`. This is to help you avoid some [ad blockers](/docs/bypass-ad-blockers).

The `.js` extension is not required. The value can also be any path you choose, for example `/path/to/tracker`.


``` code-block
TRACKER_SCRIPT_NAME = "custom-script-name.js"
```


### TWO_FACTOR_ENCRYPTION_KEY<a href="#two_factor_encryption_key" class="heading-anchor" aria-label="Permalink to “TWO_FACTOR_ENCRYPTION_KEY”">#</a>


A 64-character hex string (256-bit key) used to encrypt [two-factor authentication](/docs/two-factor-authentication) secrets. Required before any user can enable 2FA. You can generate one with:


``` code-block
openssl rand -hex 32
```


``` code-block
TWO_FACTOR_ENCRYPTION_KEY = "random hex string"
```


### USE_UUIDV7<a href="#use_uuidv7" class="heading-anchor" aria-label="Permalink to “USE_UUIDV7”">#</a>


Uses UUIDv7 instead of UUIDv4 for generated random identifiers. Deterministic IDs derived from analytics data are unchanged.


``` code-block
USE_UUIDV7 = 1
```


------------------------------------------------------------------------

## Build time variables<a href="#build-time-variables" class="heading-anchor" aria-label="Permalink to “Build time variables”">#</a>

Build time variables are only recognized during the build process. This also includes building custom Docker images. You need to set your environment variables prior to building the application.

### ALLOWED_FRAME_URLS<a href="#allowed_frame_urls" class="heading-anchor" aria-label="Permalink to “ALLOWED_FRAME_URLS”">#</a>


A space-delimited list of urls allowed to host the application in an iframe.


``` code-block
ALLOWED_FRAME_URLS = "URLs"
```


### BASE_PATH<a href="#base_path" class="heading-anchor" aria-label="Permalink to “BASE_PATH”">#</a>


If you want to host Umami under a subdirectory. You may need to update your reverse proxy settings to correctly handle the BASE_PATH prefix.


``` code-block
BASE_PATH = "/custom"
```


### BUILD_GEO<a href="#build_geo" class="heading-anchor" aria-label="Permalink to “BUILD_GEO”">#</a>


Run the local GeoIP database setup step even in Vercel environment.


``` code-block
BUILD_GEO = 1
```


### DATABASE_TYPE<a href="#database_type" class="heading-anchor" aria-label="Permalink to “DATABASE_TYPE”">#</a>


``` code-block
DATABASE_TYPE = "postgresql"
```


The type of DB to be used. This is only required for the Docker build.

### DEFAULT_CURRENCY / DEFAULT_LOCALE<a href="#default_currency--default_locale" class="heading-anchor" aria-label="Permalink to “DEFAULT_CURRENCY / DEFAULT_LOCALE”">#</a>


Sets the default currency and locale used by the application UI before a user chooses their own preferences.


``` code-block
DEFAULT_CURRENCY = "USD"
DEFAULT_LOCALE = "en-US"
```


### DIRECT_DATABASE_URL<a href="#direct_database_url" class="heading-anchor" aria-label="Permalink to “DIRECT_DATABASE_URL”">#</a>


Direct PostgreSQL connection string used for Prisma migrations during `check-db`. This is useful when `DATABASE_URL` points to a pooled connection that should not be used for migration commands.


``` code-block
DIRECT_DATABASE_URL = "connection string"
```


### FORCE_SSL<a href="#force_ssl" class="heading-anchor" aria-label="Permalink to “FORCE_SSL”">#</a>


This will send a HTTP `Strict-Transport-Security` response header with all requests. See <https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Strict-Transport-Security>.


``` code-block
FORCE_SSL = 1
```


### SKIP_BUILD_GEO<a href="#skip_build_geo" class="heading-anchor" aria-label="Permalink to “SKIP_BUILD_GEO”">#</a>


Skips the local GeoIP database setup step in the build process.


``` code-block
SKIP_BUILD_GEO = 1
```


### SKIP_DB_CHECK<a href="#skip_db_check" class="heading-anchor" aria-label="Permalink to “SKIP_DB_CHECK”">#</a>


Skips the `check-db` step in the build process. Used for Docker builds.


``` code-block
SKIP_DB_CHECK = 1
```


### SKIP_DB_MIGRATION<a href="#skip_db_migration" class="heading-anchor" aria-label="Permalink to “SKIP_DB_MIGRATION”">#</a>


Skips the Prisma migration step in the build process. Setting `SKIP_DB_CHECK` also skips this step.


``` code-block
SKIP_DB_MIGRATION = 1
```


<a href="/docs/enable-share-url" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground" rel="prev" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Previous</span><span class="font-medium transition-colors group-hover:text-primary">Enable Share URL</span></span></a><a href="/docs/enable-cloudflare-headers" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground justify-end text-right" rel="next" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Next</span><span class="font-medium transition-colors group-hover:text-primary">Enable Cloudflare headers</span></span></a>


On this page


