> Source: https://wealthfolio.app/docs/guide/self-hosting/configuration



Docs


Configuration Reference


# Configuration Reference

Every WF\_\* environment variable Wealthfolio understands, plus how to escape Argon2 hashes for each environment.


Last updated November 12, 2026


All Wealthfolio configuration is done through environment variables prefixed with `WF_`. This page is the source of truth. The platform-specific guides link back here for the details.

## Quick reference


| Variable | Required | Default |
|----|----|----|
| `WF_SECRET_KEY` | ✅ always | – |
| `WF_AUTH_PASSWORD_HASH` | ✅ for web access | – |
| `WF_CORS_ALLOW_ORIGINS` | ✅ when auth on | `*` (rejected with auth on) |
| `WF_LISTEN_ADDR` | recommended | `0.0.0.0:8088` |
| `WF_DATA_DIR` | optional | Unset (uses `WF_DB_PATH` parent) |
| `WF_DB_PATH` | optional | `./db/app.db` |
| `WF_DB_REQUIRE_ENCRYPTION` | optional | `false` |
| `WF_AUTH_REQUIRED` | optional | `true` |
| `WF_AUTH_TOKEN_TTL_MINUTES` | optional | `60` |
| `WF_COOKIE_SECURE` | optional | `auto` |
| `WF_OIDC_ISSUER_URL` | for SSO | – |
| `WF_OIDC_CLIENT_ID` | for SSO | – |
| `WF_OIDC_*` (SSO options) | optional | see <a href="#single-sign-on-oidc" class="font-medium underline underline-offset-4">below</a> |
| `WF_REQUEST_TIMEOUT_MS` | optional | `300000` (5 min) |
| `WF_STATIC_DIR` | optional | `dist` |
| `WF_SECRET_FILE` | optional | `<data-root>/secrets.json` |
| `WF_ADDONS_DIR` | optional | `<data-root>` (DB directory) |
| `WF_LOG_FORMAT` | optional | `text` |


## Startup safety checks

Wealthfolio refuses to start under two specific configurations to prevent accidentally exposing an unauthenticated instance to the network:

- **Non-loopback listen + no auth**: if `WF_LISTEN_ADDR` binds to anything other than `127.0.0.1` and `WF_AUTH_PASSWORD_HASH` is unset, the server panics. Set `WF_AUTH_REQUIRED=false` to opt out (only do this if a reverse proxy authenticates for you).
- **Wildcard CORS + auth**: if `WF_CORS_ALLOW_ORIGINS=*` and auth is enabled, the server panics. Set explicit origins (e.g. `https://wealthfolio.example.com`).
- **OIDC with no allowlist**: if OIDC is enabled (`WF_OIDC_ISSUER_URL` + `WF_OIDC_CLIENT_ID`) but neither `WF_OIDC_ALLOWED_EMAILS` nor `WF_OIDC_ALLOWED_SUBS` is set, the server panics – an empty allowlist would grant every IdP-authenticated user access. Set an allowlist, or `WF_OIDC_ALLOW_ANY=true` to opt into open access (only safe on a dedicated single-user IdP).

## Security

### `WF_SECRET_KEY`

**Required.** A 32-byte key used to:

- Encrypt sensitive data at rest (broker credentials, API keys)
- Sign JWT access tokens

Generate once and persist it forever:

``` mb-4
openssl rand -base64 32
```


**Back this up.** Losing the secret key means losing access to all stored encrypted secrets. There’s no recovery. Treat it like a master password.


### `WF_SECRET_FILE`

**Default:** `<data-root>/secrets.json`

Path to the encrypted secrets file. By default it sits in the installation directory. An explicit `WF_SECRET_FILE` is independent of `WF_DATA_DIR`; keep the override when changing storage settings.

## Authentication

### `WF_AUTH_PASSWORD_HASH`

**Required for web access** (unless `WF_AUTH_REQUIRED=false`).

An Argon2id PHC string that defines the login password. Generate it with the `argon2` CLI:

``` mb-4
printf 'your-password' | argon2 yoursalt16chars! -id -e
```

- The first arg is the **salt** (use 16+ random characters).
- Use `printf`, not `echo -n`. `echo` adds a trailing newline on some shells.
- Output starts with `$argon2id$v=19$...`. That’s the value you set.

### Escaping dollar signs in your hash

Argon2 hashes contain `$` which most shells and Compose interpolate as variable references. Use the right syntax for your environment:


| Environment | Syntax | Notes |
|----|----|----|
| Docker CLI `--env-file` | `WF_AUTH_PASSWORD_HASH=$argon2id$...` | Docker CLI does not interpolate env files |
| Docker Compose `env_file` with `format: raw` | `WF_AUTH_PASSWORD_HASH=$argon2id$...` | Requires Docker Compose 2.30+ |
| Docker Compose `env_file` (default) | `WF_AUTH_PASSWORD_HASH='$argon2id$...'` | Single quotes prevent Compose interpolation |
| Docker Compose `env_file` (default) | `WF_AUTH_PASSWORD_HASH=$$argon2id$$...` | Alternative: double every `$` |
| Docker Compose YAML inline | `WF_AUTH_PASSWORD_HASH: '$$argon2id$$...'` | Double every `$` to escape Compose |
| Docker CLI `-e` (single quotes) | `-e WF_AUTH_PASSWORD_HASH='$argon2id$...'` | Single quotes prevent shell expansion |
| Docker CLI `-e` (double quotes) | `-e WF_AUTH_PASSWORD_HASH="\$argon2id\$..."` | Backslash-escape each `$` |
| Unraid template UI | *paste raw hash* | Unraid handles escaping internally |
| Coolify env var | *paste raw hash, check **Is Literal?*** | Without it Coolify interpolates `$` as variable refs |


**Common mistakes:**

- Double quotes in Docker CLI (`"$argon..."`): the shell expands `$argon2id` to empty.
- Single quotes inside `--env-file` files: Docker keeps the quotes as part of the value.
- Unquoted/unescaped `$` in Compose YAML: Compose treats `$argon` as a substitution.
- Coolify: **Is Secret** only masks the value in the UI. It does not stop `$` interpolation – you must also check **Is Literal?**.


### `WF_AUTH_REQUIRED`

**Default:** `true`

Set to `false` only if a reverse proxy handles authentication for you (e.g. Authentik, Authelia, Coolify’s built-in auth). When `false`, `WF_AUTH_PASSWORD_HASH` is ignored and the server starts without its own login layer.

### `WF_AUTH_TOKEN_TTL_MINUTES`

**Default:** `60`

JWT access token lifetime in minutes. Users re-authenticate after this expires.

``` mb-4
60      # 1 hour (default)
1440    # 24 hours
10080   # 7 days
```

### `WF_COOKIE_SECURE`

**Default:** `auto`

Controls the `Secure` attribute on the auth session cookie. Accepted values:


| Value | Behavior |
|----|----|
| `auto` *(default)* | Sets `Secure` automatically based on whether the request was HTTPS. |
| `true`, `1`, `yes` | Always sets `Secure`. Use behind a reverse proxy that terminates HTTPS. |
| `false`, `0`, `no` | Never sets `Secure`. Only safe for local-only or testing setups. |


If you sit behind a reverse proxy doing TLS termination, `auto` works in most cases, but force `true` if cookies aren’t sticking after login.

## Single Sign-On (OIDC)

**Optional.** Sign in through any OpenID Connect provider (Authentik, PocketID, Authelia, Keycloak, …) using Authorization Code + PKCE. OIDC is **authentication only** and works alongside or instead of `WF_AUTH_PASSWORD_HASH`:


| Configuration                | Login page shows                |
|------------------------------|---------------------------------|
| `WF_OIDC_*` only             | **Sign in with SSO** only       |
| `WF_AUTH_PASSWORD_HASH` only | password field only *(default)* |
| both                         | password field **and** SSO      |


A successful SSO login mints the same session cookie as password login, so sliding refresh, the JWT layer, and logout behave identically.

OIDC is enabled when **both** `WF_OIDC_ISSUER_URL` and `WF_OIDC_CLIENT_ID` are set.


When OIDC is enabled you must set an allowlist (`WF_OIDC_ALLOWED_EMAILS` and/or `WF_OIDC_ALLOWED_SUBS`) or the server refuses to start. An empty allowlist would grant **every** account your IdP authenticates full access – dangerous on a shared / multi-tenant / self-signup IdP. To intentionally allow anyone (only safe on a dedicated single-user IdP), set `WF_OIDC_ALLOW_ANY=true`.


### `WF_OIDC_ISSUER_URL`

Provider base URL. Discovery hits `<issuer>/.well-known/openid-configuration` at startup, so the issuer must be reachable when the container starts.

``` mb-4
https://auth.example.com/application/o/wealthfolio/
```

### `WF_OIDC_CLIENT_ID`

Client ID registered with your IdP.

### `WF_OIDC_CLIENT_SECRET`

**Optional.** PKCE is always used, so a secret is only needed for confidential clients that require one.

### `WF_OIDC_REDIRECT_URL`

**Required when OIDC is enabled.** Must be registered in the IdP and reachable by the browser:

``` mb-4
https://your.host/api/v1/auth/oidc/callback
```

### `WF_OIDC_SCOPES`

**Default:** `openid email profile`. Space-separated; `openid` is always requested.

### `WF_OIDC_ALLOWED_EMAILS` / `WF_OIDC_ALLOWED_SUBS`

Comma-separated allowlists matched against the ID token’s `email` / `sub` claims. With neither set the server refuses to start (see the warning above) unless `WF_OIDC_ALLOW_ANY=true`.

``` mb-4
WF_OIDC_ALLOWED_EMAILS=you@example.com,partner@example.com
WF_OIDC_ALLOWED_SUBS=8f3b...,a91c...
```

- An `email` is only honored when the IdP asserts `email_verified=true` – an unverified email can be attacker-chosen on self-signup IdPs.
- `WF_OIDC_ALLOWED_SUBS` is the stronger control: the `sub` is stable and issuer-scoped. Prefer it on shared / multi-tenant IdPs.

### `WF_OIDC_ALLOW_ANY`

**Default:** `false`. Set to `true` to allow any user your IdP authenticates when no allowlist is configured. Only safe on a dedicated single-user IdP; on a shared IdP this grants everyone access. A warning is logged at startup when enabled.

### `WF_OIDC_POST_LOGOUT_REDIRECT_URL`

**Optional.** When the IdP advertises an `end_session_endpoint`, sign-out also ends the IdP session (RP-Initiated Logout); otherwise logout is local-only. Set this to land back on the app after IdP logout – it must be **registered** with the IdP (e.g. Keycloak’s “Valid post logout redirect URIs”). If unset, the IdP shows its own logged-out page.

### `WF_OIDC_RP_LOGOUT`

**Default:** `true`. Set to `false` to force local-only logout even when the IdP supports RP-Initiated Logout.

### `WF_OIDC_CA_FILE`

**Optional; unset by default.** Absolute path to a PEM bundle of extra trusted CA certificates for an identity provider using a private CA, such as step-ca or an internal PKI. Requires a server build containing <a href="https://github.com/wealthfolio/wealthfolio/pull/2253" class="font-medium underline underline-offset-4">#2253</a>; upgrade older pinned images or binaries before using this setting.

``` mb-4
WF_OIDC_CA_FILE=/certs/internal-ca.pem
```

For Docker, this is the path **inside the container**. Mount the existing host file read-only; setting the variable alone does not mount it. See the <a href="/docs/guide/self-hosting/docker-compose/#oidc-with-a-private-ca" class="font-medium underline underline-offset-4">Docker Compose example</a>, <a href="/docs/guide/self-hosting/unraid/#oidc-with-a-private-ca" class="font-medium underline underline-offset-4">Unraid instructions</a>, or <a href="/docs/guide/self-hosting/proxmox/#oidc-with-a-private-ca" class="font-medium underline underline-offset-4">native Proxmox instructions</a>.

The bundle adds trust only to the OIDC client, including discovery, signing-key retrieval, token exchange, and metadata refresh. Bundled Mozilla roots remain trusted, and certificate and hostname validation remain enabled. The OIDC client ignores the system trust store and `SSL_CERT_FILE`. Other outbound clients are unaffected. Leaving the value unset or empty preserves existing behavior.

Use only CA certificates you trust. The bundle contains public certificates, not private keys. Keep it and its parent directory administrator-controlled, and make it readable by the server’s runtime user. Browsers must separately trust the IdP certificate when following the SSO redirect.

Certificates are loaded once at startup. Restart the server after replacing the bundle. When OIDC is enabled, an unreadable file, invalid certificate, or bundle without certificates prevents startup. If discovery still fails, check the issuing CA and the issuer hostname against the IdP certificate.

## Server

### `WF_LISTEN_ADDR`

**Default:** `0.0.0.0:8088`

Bind address. The default works for Docker out of the box. For local non-Docker use, switch to a loopback address.

``` mb-4
0.0.0.0:8088   # Docker / network-accessible (default)
127.0.0.1:8080 # Local non-Docker
0.0.0.0:3000   # Custom port
```


Listening on a non-loopback address (anything other than `127.0.0.1`) without setting `WF_AUTH_PASSWORD_HASH` causes the server to refuse to start. Set `WF_AUTH_REQUIRED=false` to opt out (only safe if a reverse proxy authenticates for you).


### `WF_DATA_DIR`

**Optional.** Directory holding `profiles.json`, profile databases under `profiles/<uuid>/app.db`, and the default encrypted `secrets.json` file. Relative paths use the server’s working directory; `~` is not expanded.

Existing installations do not need this setting. `WF_DB_PATH` continues to select the installation directory through its parent. If you set both, `WF_DATA_DIR` must be the same directory as the parent of `WF_DB_PATH`, or startup fails before writing data. Existing profile registry entries keep their saved database paths; setting `WF_DATA_DIR` does not move files.

For a fresh installation using only `WF_DATA_DIR`, the legacy database candidate is `<WF_DATA_DIR>/app.db`. Docker images supply `WF_DB_PATH=/data/wealthfolio.db` by default, so explicitly set `WF_DB_PATH=` to clear it when using the directory-only form. Keep the old database path when upgrading an existing installation.

### `WF_DB_PATH`

**Default:** `./db/app.db`

Legacy SQLite file path. Its parent selects the installation directory when `WF_DATA_DIR` is unset. New profiles have separate databases under that directory. Keep this path when upgrading an existing installation.

``` mb-4
/data/wealthfolio.db   # Docker image default (with /data volume mount)
./database/app.db      # Local relative path
```

### `WF_DB_REQUIRE_ENCRYPTION`

**Default:** `false`. Requires encrypted profile databases at server startup. For a fresh installation, set it before starting to create encrypted databases. Changing this setting does **not** encrypt an existing database. Stop the server, run `wealthfolio-server db encrypt` for the default profile and `wealthfolio-server db encrypt --profile <UUID>` for each additional profile, then enable the setting and restart. The offline commands need the same master key, storage settings, and data mounts as the server. Keep the master key: it is needed to open encrypted databases and saved encrypted snapshots. See <a href="/docs/guide/data-export/#database-encryption-and-backup-passwords" class="font-medium underline underline-offset-4">Export &amp; Backup</a> for how this differs from a portable backup password.


**Existing databases must be encrypted before enabling `WF_DB_REQUIRE_ENCRYPTION`.** The variable enforces the database state; it does not convert a plaintext database. If startup reports a mismatch, the database is not damaged. Either unset the variable to remain plaintext, or stop the service, back up the full data directory, run `wealthfolio-server db encrypt` with the same volume, service user, and master key, then restart with the flag set. Releases before 3.9 ignored the variable, so upgraded databases can be plaintext even when it was already configured.


### `WF_STATIC_DIR`

**Default:** `dist`

Directory the server reads static frontend assets from. Only relevant if you’re serving a custom frontend build.

### `WF_REQUEST_TIMEOUT_MS`

**Default:** `300000` (5 minutes)

HTTP request timeout in milliseconds. The default is generous to accommodate large broker syncs; lower it if you want stricter timeouts.

## Network

### `WF_CORS_ALLOW_ORIGINS`

**Default:** `*` (wildcard). **Rejected at startup if auth is enabled.**

Comma-separated list of allowed CORS origins. When you enable auth (which you should for any network-accessible deployment), you **must** set explicit origins matching the URL in your browser’s address bar exactly (scheme + host + port).

``` mb-4
http://192.168.1.10:8088
https://wealthfolio.example.com
http://localhost:1420,http://localhost:3000   # multi-origin
```


Wildcard CORS combined with cookie-based auth is a CSRF vector. That’s why the server refuses to start in that combination. If you see a startup panic mentioning CORS, set explicit origins.


## Add-ons

### `WF_ADDONS_DIR`

**Default:** installation directory (`WF_DATA_DIR` or parent of `WF_DB_PATH`)

Path where Wealthfolio reads installable add-ons from. Defaults to the installation directory, so a single `/data` mount holds everything.

## Logging

### `WF_LOG_FORMAT`

**Default:** `text`

Log output format: `text` (human-readable, colored) or `json` (structured, ship to log aggregators).

## Complete `.env` example

``` mb-4
# Server (default 0.0.0.0:8088 already works inside Docker; included for clarity)
WF_LISTEN_ADDR=0.0.0.0:8088
WF_DB_PATH=/data/wealthfolio.db
# Optional with the path above: WF_DATA_DIR=/data

# Security (required, back up the secret key!)
WF_SECRET_KEY=replace-with-output-of-openssl-rand-base64-32

# Authentication (this is your login password)
WF_AUTH_PASSWORD_HASH='$argon2id$v=19$m=19456,t=2,p=1$...'
WF_AUTH_TOKEN_TTL_MINUTES=480

# Network: explicit origin required when auth is on
WF_CORS_ALLOW_ORIGINS=https://wealthfolio.example.com

# Single Sign-On (optional) – enabled when issuer + client id are both set.
# An allowlist is required, or set WF_OIDC_ALLOW_ANY=true to allow any IdP user.
# WF_OIDC_ISSUER_URL=https://auth.example.com/application/o/wealthfolio/
# WF_OIDC_CLIENT_ID=wealthfolio
# WF_OIDC_REDIRECT_URL=https://wealthfolio.example.com/api/v1/auth/oidc/callback
# WF_OIDC_ALLOWED_EMAILS=you@example.com
# Private-CA IdP only: mount this PEM bundle read-only inside the container.
# WF_OIDC_CA_FILE=/certs/internal-ca.pem

# Logging
WF_LOG_FORMAT=text
```

------------------------------------------------------------------------

To let external AI agents reach a self-hosted instance, enable the endpoint with `WF_MCP_ENABLED=true` and follow the <a href="/docs/guide/mcp-server/" class="font-medium underline underline-offset-4">MCP Server</a> guide – it covers token scopes and the auth requirements for network-bound servers.


<a href="/docs/guide/self-hosting/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08]">Overview</a> <a href="/docs/guide/self-hosting/docker/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">Docker</a>


On this page

- <a href="#quick-reference" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Quick reference</a>
- <a href="#startup-safety-checks" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Startup safety checks</a>
- <a href="#security" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Security</a>
  - <a href="#wf_secret_key" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">WF_SECRET_KEY</a>
  - <a href="#wf_secret_file" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">WF_SECRET_FILE</a>
- <a href="#authentication" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Authentication</a>
  - <a href="#wf_auth_password_hash" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">WF_AUTH_PASSWORD_HASH</a>
  - <a href="#escaping-dollar-signs-in-your-hash" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Escaping dollar signs in your hash</a>
  - <a href="#wf_auth_required" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">WF_AUTH_REQUIRED</a>
  - <a href="#wf_auth_token_ttl_minutes" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">WF_AUTH_TOKEN_TTL_MINUTES</a>
  - <a href="#wf_cookie_secure" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">WF_COOKIE_SECURE</a>
- <a href="#single-sign-on-oidc" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Single Sign-On (OIDC)</a>
  - <a href="#wf_oidc_issuer_url" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">WF_OIDC_ISSUER_URL</a>
  - <a href="#wf_oidc_client_id" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">WF_OIDC_CLIENT_ID</a>
  - <a href="#wf_oidc_client_secret" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">WF_OIDC_CLIENT_SECRET</a>
  - <a href="#wf_oidc_redirect_url" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">WF_OIDC_REDIRECT_URL</a>
  - <a href="#wf_oidc_scopes" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">WF_OIDC_SCOPES</a>
  - <a href="#wf_oidc_allowed_emails--wf_oidc_allowed_subs" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">WF_OIDC_ALLOWED_EMAILS / WF_OIDC_ALLOWED_SUBS</a>
  - <a href="#wf_oidc_allow_any" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">WF_OIDC_ALLOW_ANY</a>
  - <a href="#wf_oidc_post_logout_redirect_url" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">WF_OIDC_POST_LOGOUT_REDIRECT_URL</a>
  - <a href="#wf_oidc_rp_logout" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">WF_OIDC_RP_LOGOUT</a>
  - <a href="#wf_oidc_ca_file" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">WF_OIDC_CA_FILE</a>
- <a href="#server" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Server</a>
  - <a href="#wf_listen_addr" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">WF_LISTEN_ADDR</a>
  - <a href="#wf_data_dir" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">WF_DATA_DIR</a>
  - <a href="#wf_db_path" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">WF_DB_PATH</a>
  - <a href="#wf_db_require_encryption" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">WF_DB_REQUIRE_ENCRYPTION</a>
  - <a href="#wf_static_dir" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">WF_STATIC_DIR</a>
  - <a href="#wf_request_timeout_ms" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">WF_REQUEST_TIMEOUT_MS</a>
- <a href="#network" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Network</a>
  - <a href="#wf_cors_allow_origins" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">WF_CORS_ALLOW_ORIGINS</a>
- <a href="#add-ons" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Add-ons</a>
  - <a href="#wf_addons_dir" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">WF_ADDONS_DIR</a>
- <a href="#logging" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Logging</a>
  - <a href="#wf_log_format" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">WF_LOG_FORMAT</a>
- <a href="#complete-env-example" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Complete .env example</a>


