> Source: https://docs.umami.is/docs/environment-variables



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2.5 font-semibold md:hidden" rel="noreferrer noopener" target="_blank"><strong>umami</strong></a>


Search


<a href="/docs" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="true">Documentation</a><a href="/docs/guides" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Guides</a><a href="/docs/api" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">API Reference</a><a href="/docs/cloud" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Cloud</a><a href="https://v2.umami.is" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" target="_blank" rel="noopener noreferrer">v2</a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors duration-100 disabled:pointer-events-none disabled:opacity-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-fd-ring hover:bg-fd-accent hover:text-fd-accent-foreground p-1.5 [&amp;_svg]:size-4.5 text-fd-muted-foreground max-lg:hidden" rel="noreferrer noopener" target="_blank" aria-label="GitHub" data-active="false"></a>


# Environment variables


You can configure Umami with the use of environment variables. They go into the same `.env` file as your `DATABASE_URL`.

------------------------------------------------------------------------

## <a href="#runtime-variables" class="peer" data-card="">Runtime variables</a>

Runtime variables are recognized when Umami is running. You can set your environment variables prior to starting the application.

### <a href="#app_secret-v100" class="peer" data-card="">APP_SECRET <code>v1.0.0</code></a>

A random string used to secure authentication tokens. Each installation should have a unique value. You can generate one with:

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>openssl rand -hex 32</code></pre>
</figure>

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>APP_SECRET = &quot;random string&quot;</code></pre>
</figure>

### <a href="#client_ip_header-v1240" class="peer" data-card="">CLIENT_IP_HEADER <code>v1.24.0</code></a>

HTTP header to check for the client's IP address. This is useful when you're behind a proxy that uses non-standard headers.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>CLIENT_IP_HEADER = &quot;header name&quot;</code></pre>
</figure>

### <a href="#collect_api_endpoint-v1340" class="peer" data-card="">COLLECT_API_ENDPOINT <code>v1.34.0</code></a>

Allows you to send metrics to a location different than the default `/api/send`. This is to help you avoid some [ad blockers](/docs/bypass-ad-blockers).

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>COLLECT_API_ENDPOINT = &quot;/my-custom-route&quot;</code></pre>
</figure>

### <a href="#cors_max_age-v200" class="peer" data-card="">CORS_MAX_AGE <code>v2.0.0</code></a>

How many seconds a CORS preflight should last. Default is 24 hours.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>CORS_MAX_AGE = 86400</code></pre>
</figure>

### <a href="#database_url-v100" class="peer" data-card="">DATABASE_URL <code>v1.0.0</code></a>

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>DATABASE_URL = &quot;connection string&quot;</code></pre>
</figure>

Connection string for your database. This is the only required variable.

### <a href="#debug-v200" class="peer" data-card="">DEBUG <code>v2.0.0</code></a>

Console logging for specific areas of the application. Values include `umami:auth`, `umami:clickhouse`, `umami:kafka`, `umami:middleware`, and `umami:prisma`.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>DEBUG = &quot;umami:*&quot;</code></pre>
</figure>

### <a href="#disable_bot_check-v200" class="peer" data-card="">DISABLE_BOT_CHECK <code>v2.0.0</code></a>

By default bots are excluded from statistics. This disables checking for bots.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>DISABLE_BOT_CHECK = 1</code></pre>
</figure>

### <a href="#disable_login-v1260" class="peer" data-card="">DISABLE_LOGIN <code>v1.26.0</code></a>

Disables the login page for the application.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>DISABLE_LOGIN = 1</code></pre>
</figure>

### <a href="#disable_updates-v1330" class="peer" data-card="">DISABLE_UPDATES <code>v1.33.0</code></a>

Disables the check for new versions of Umami.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>DISABLE_UPDATES = 1</code></pre>
</figure>

### <a href="#disable_telemetry-v200" class="peer" data-card="">DISABLE_TELEMETRY <code>v2.0.0</code></a>

Umami collects completely anonymous telemetry data in order help improve the application. You can choose to disable this if you don't want to participate.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>DISABLE_TELEMETRY = 1</code></pre>
</figure>

### <a href="#enable_test_console-v200" class="peer" data-card="">ENABLE_TEST_CONSOLE <code>v2.0.0</code></a>

Enables the internal test page, `{host}/console`. Admin access is required. Users can manually fire pageviews and events to their websites.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>ENABLE_TEST_CONSOLE = 1</code></pre>
</figure>

### <a href="#favicon_url-v2180" class="peer" data-card="">FAVICON_URL <code>v2.18.0</code></a>

The URL of the service for displaying website icons.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>FAVICON_URL = &quot;service URL&quot;</code></pre>
</figure>

The default is `icons.duckduckgo.com`:

- <a href="https://icons.duckduckgo.com/ip3/%7B%7Bdomain%7D%7D.ico" rel="noreferrer noopener" target="_blank">https://icons.duckduckgo.com/ip3/{{domain}}.ico</a>

Some alternatives you can use:

- <a href="https://www.google.com/s2/favicons?domain=%7B%7Bdomain%7D%7D" rel="noreferrer noopener" target="_blank">https://www.google.com/s2/favicons?domain={{domain}}</a>
- <a href="https://logo.clearbit.com/%7B%7Bdomain%7D%7D" rel="noreferrer noopener" target="_blank">https://logo.clearbit.com/{{domain}}</a>

### <a href="#geo_database_url-v200" class="peer" data-card="">GEO_DATABASE_URL <code>v2.0.0</code></a>

The URL for downloading a MaxMind-compatible GeoIP database in MMDB format. This is used for IP-based location detection when location headers from a CDN are not available.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>GEO_DATABASE_URL = &quot;https://example.com/GeoLite2-City.mmdb&quot;</code></pre>
</figure>

### <a href="#hostname--port-v100" class="peer" data-card="">HOSTNAME / PORT <code>v1.0.0</code></a>

If you are running on an environment which requires you to bind to a specific hostname or port, such as Heroku, you can add these variables and start your app with `npm run start-env` instead of `npm start`.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>HOSTNAME = &quot;my.hostname.com&quot;
PORT = 3000</code></pre>
</figure>

### <a href="#ignore_ip-v100" class="peer" data-card="">IGNORE_IP <code>v1.0.0</code></a>

You can provide a comma-delimited list of IP addresses and CIDR ranges to exclude from data collection.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>IGNORE_IP = &quot;192.168.0.1, 10.0.0.0/24, 2001:db8::/32&quot;</code></pre>
</figure>

### <a href="#log_query-v200" class="peer" data-card="">LOG_QUERY <code>v2.0.0</code></a>

If you are running in development mode, this will log database queries to the console for debugging.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>LOG_QUERY = 1</code></pre>
</figure>

### <a href="#private_mode-v2110" class="peer" data-card="">PRIVATE_MODE <code>v2.11.0</code></a>

Disables all external network calls. Note, this will also disable all website icons since they come from duckduckgo.com.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>PRIVATE_MODE = 1</code></pre>
</figure>

### <a href="#remove_trailing_slash-v1260" class="peer" data-card="">REMOVE_TRAILING_SLASH <code>v1.26.0</code></a>

Removes the trailing slash from all incoming urls.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>REMOVE_TRAILING_SLASH = 1</code></pre>
</figure>

### <a href="#tracker_script_name-v1260" class="peer" data-card="">TRACKER_SCRIPT_NAME <code>v1.26.0</code></a>

Allows you to assign a custom name to the tracker script different from the default `script.js`. This is to help you avoid some [ad blockers](/docs/bypass-ad-blockers).

The `.js` extension is not required. The value can also be any path you choose, for example `/path/to/tracker`.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>TRACKER_SCRIPT_NAME = &quot;custom-script-name.js&quot;</code></pre>
</figure>

### <a href="#skip_location_headers-v2150" class="peer" data-card="">SKIP_LOCATION_HEADERS <code>v2.15.0</code></a>

Skips using known location headers for country/region/city detection and forces using the local geo database.

This is useful in environments where only the country (without region or city) header is set from the proxy or CDN (like Cloudflare’s `CF-IPCountry` when Network \> IP Geolocationis switched to On).

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>SKIP_LOCATION_HEADERS = 1</code></pre>
</figure>

------------------------------------------------------------------------

## <a href="#build-time-variables" class="peer" data-card="">Build time variables</a>

Build time variables are only recognized during the build process. This also includes building custom Docker images. You need to set your environment variables prior to building the application.

### <a href="#allowed_frame_urls-v230" class="peer" data-card="">ALLOWED_FRAME_URLS <code>v2.3.0</code></a>

A space-delimited list of urls allowed to host the application in an iframe.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>ALLOWED_FRAME_URLS = &quot;URLs&quot;</code></pre>
</figure>

### <a href="#base_path-v190" class="peer" data-card="">BASE_PATH <code>v1.9.0</code></a>

If you want to host Umami under a subdirectory. You may need to update your reverse proxy settings to correctly handle the BASE_PATH prefix.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>BASE_PATH = &quot;/custom&quot;</code></pre>
</figure>

### <a href="#database_type-v200" class="peer" data-card="">DATABASE_TYPE <code>v2.0.0</code></a>

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>DATABASE_TYPE = &quot;postgresql&quot;</code></pre>
</figure>

The type of DB to be used. This is only required for the Docker build.

### <a href="#force_ssl-v100" class="peer" data-card="">FORCE_SSL <code>v1.0.0</code></a>

This will send a HTTP `Strict-Transport-Security` response header with all requests. See <a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Strict-Transport-Security" rel="noreferrer noopener" target="_blank">https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Strict-Transport-Security</a>.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>FORCE_SSL = 1</code></pre>
</figure>

### <a href="#skip_db_check-v200" class="peer" data-card="">SKIP_DB_CHECK <code>v2.0.0</code></a>

Skips the `check-db` step in the build process. Used for Docker builds.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>SKIP_DB_CHECK = 1</code></pre>
</figure>

### <a href="#skip_db_migration-v200" class="peer" data-card="">SKIP_DB_MIGRATION <code>v2.0.0</code></a>

Skips the Prisma migration step in the build process. Setting `SKIP_DB_CHECK` also skips this step.

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>SKIP_DB_MIGRATION = 1</code></pre>
</figure>


<a href="/docs/enable-share-url" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full"></a>


Enable Share URL


Previous Page

<a href="/docs/enable-cloudflare-headers" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full text-end"></a>


Enable Cloudflare headers


Next Page


### On this page


<a href="#runtime-variables" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">Runtime variables</a><a href="#app_secret-v100" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">APP_SECRET <code>v1.0.0</code></a><a href="#client_ip_header-v1240" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">CLIENT_IP_HEADER <code>v1.24.0</code></a><a href="#collect_api_endpoint-v1340" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">COLLECT_API_ENDPOINT <code>v1.34.0</code></a><a href="#cors_max_age-v200" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">CORS_MAX_AGE <code>v2.0.0</code></a><a href="#database_url-v100" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">DATABASE_URL <code>v1.0.0</code></a><a href="#debug-v200" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">DEBUG <code>v2.0.0</code></a><a href="#disable_bot_check-v200" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">DISABLE_BOT_CHECK <code>v2.0.0</code></a><a href="#disable_login-v1260" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">DISABLE_LOGIN <code>v1.26.0</code></a><a href="#disable_updates-v1330" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">DISABLE_UPDATES <code>v1.33.0</code></a><a href="#disable_telemetry-v200" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">DISABLE_TELEMETRY <code>v2.0.0</code></a><a href="#enable_test_console-v200" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">ENABLE_TEST_CONSOLE <code>v2.0.0</code></a><a href="#favicon_url-v2180" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">FAVICON_URL <code>v2.18.0</code></a><a href="#geo_database_url-v200" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">GEO_DATABASE_URL <code>v2.0.0</code></a><a href="#hostname--port-v100" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">HOSTNAME / PORT <code>v1.0.0</code></a><a href="#ignore_ip-v100" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">IGNORE_IP <code>v1.0.0</code></a><a href="#log_query-v200" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">LOG_QUERY <code>v2.0.0</code></a><a href="#private_mode-v2110" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">PRIVATE_MODE <code>v2.11.0</code></a><a href="#remove_trailing_slash-v1260" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">REMOVE_TRAILING_SLASH <code>v1.26.0</code></a><a href="#tracker_script_name-v1260" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">TRACKER_SCRIPT_NAME <code>v1.26.0</code></a><a href="#skip_location_headers-v2150" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">SKIP_LOCATION_HEADERS <code>v2.15.0</code></a><a href="#build-time-variables" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">Build time variables</a><a href="#allowed_frame_urls-v230" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">ALLOWED_FRAME_URLS <code>v2.3.0</code></a><a href="#base_path-v190" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">BASE_PATH <code>v1.9.0</code></a><a href="#database_type-v200" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">DATABASE_TYPE <code>v2.0.0</code></a><a href="#force_ssl-v100" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">FORCE_SSL <code>v1.0.0</code></a><a href="#skip_db_check-v200" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">SKIP_DB_CHECK <code>v2.0.0</code></a><a href="#skip_db_migration-v200" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">SKIP_DB_MIGRATION <code>v2.0.0</code></a>


