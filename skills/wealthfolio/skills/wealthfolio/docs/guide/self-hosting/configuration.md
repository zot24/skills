> Source: https://wealthfolio.app/docs/guide/self-hosting/configuration

All Wealthfolio configuration is done through environment variables prefixed
with `WF_`. This page is the source of truth. The platform-specific guides
link back here for the details.

## Quick reference

| Variable                    | Required           | Default                      |
| --------------------------- | ------------------ | ---------------------------- |
| `WF_SECRET_KEY`             | ✅ always          | —                            |
| `WF_AUTH_PASSWORD_HASH`     | ✅ for web access  | —                            |
| `WF_CORS_ALLOW_ORIGINS`     | ✅ when auth on    | `*` (rejected with auth on)  |
| `WF_LISTEN_ADDR`            | recommended        | `0.0.0.0:8088`               |
| `WF_DB_PATH`                | recommended        | `./db/app.db`                |
| `WF_AUTH_REQUIRED`          | optional           | `true`                       |
| `WF_AUTH_TOKEN_TTL_MINUTES` | optional           | `60`                         |
| `WF_COOKIE_SECURE`          | optional           | `auto`                       |
| `WF_REQUEST_TIMEOUT_MS`     | optional           | `300000` (5 min)             |
| `WF_STATIC_DIR`             | optional           | `dist`                       |
| `WF_SECRET_FILE`            | optional           | `<data-root>/secrets.json`   |
| `WF_ADDONS_DIR`             | optional           | `<data-root>` (DB directory) |
| `WF_LOG_FORMAT`             | optional           | `text`                       |

## Startup safety checks

Wealthfolio refuses to start under two specific configurations to prevent
accidentally exposing an unauthenticated instance to the network:

- **Non-loopback listen + no auth**: if `WF_LISTEN_ADDR` binds to anything
  other than `127.0.0.1` and `WF_AUTH_PASSWORD_HASH` is unset, the server
  panics. Set `WF_AUTH_REQUIRED=false` to opt out (only do this if a
  reverse proxy authenticates for you).
- **Wildcard CORS + auth**: if `WF_CORS_ALLOW_ORIGINS=*` and auth is
  enabled, the server panics. Set explicit origins (e.g.
  `https://wealthfolio.example.com`).

## Security

### `WF_SECRET_KEY`

**Required.** A 32-byte key used to:

- Encrypt sensitive data at rest (broker credentials, API keys)
- Sign JWT access tokens

Generate once and persist it forever:

```bash
openssl rand -base64 32
```

<Callout type="warning">
  **Back this up.** Losing the secret key means losing access to all stored
  encrypted secrets. There's no recovery. Treat it like a master password.
</Callout>

### `WF_SECRET_FILE`

**Default:** `<data-root>/secrets.json`

Path to the encrypted secrets file. By default it sits next to your
database. Override only if you have a reason (e.g. mounting secrets on a
separate volume).

## Authentication

### `WF_AUTH_PASSWORD_HASH`

**Required for web access** (unless `WF_AUTH_REQUIRED=false`).

An Argon2id PHC string that defines the login password. Generate it with
the `argon2` CLI:

```bash
printf 'your-password' | argon2 yoursalt16chars! -id -e
```

- The first arg is the **salt** (use 16+ random characters).
- Use `printf`, not `echo -n`. `echo` adds a trailing newline on some
  shells.
- Output starts with `$argon2id$v=19$...`. That's the value you set.

### Escaping dollar signs in your hash

Argon2 hashes contain `$` which most shells and Compose interpolate as
variable references. Use the right syntax for your environment:

| Environment                                  | Syntax                                       | Notes                                                    |
| -------------------------------------------- | -------------------------------------------- | -------------------------------------------------------- |
| Docker CLI `--env-file`                      | `WF_AUTH_PASSWORD_HASH=$argon2id$...`        | Docker CLI does not interpolate env files                |
| Docker Compose `env_file` with `format: raw` | `WF_AUTH_PASSWORD_HASH=$argon2id$...`        | Requires Docker Compose 2.30+                            |
| Docker Compose `env_file` (default)          | `WF_AUTH_PASSWORD_HASH='$argon2id$...'`      | Single quotes prevent Compose interpolation              |
| Docker Compose `env_file` (default)          | `WF_AUTH_PASSWORD_HASH=$$argon2id$$...`      | Alternative: double every `$`                            |
| Docker Compose YAML inline                   | `WF_AUTH_PASSWORD_HASH: '$$argon2id$$...'`   | Double every `$` to escape Compose                       |
| Docker CLI `-e` (single quotes)              | `-e WF_AUTH_PASSWORD_HASH='$argon2id$...'`   | Single quotes prevent shell expansion                    |
| Docker CLI `-e` (double quotes)              | `-e WF_AUTH_PASSWORD_HASH="\$argon2id\$..."` | Backslash-escape each `$`                                |
| Unraid template UI                           | _paste raw hash_                             | Unraid handles escaping internally                       |
| Coolify env var (marked as secret)           | _paste raw hash_                             | Coolify handles escaping internally                      |

<Callout type="warning">
  **Common mistakes:**
  - Double quotes in Docker CLI (`"$argon..."`): the shell expands `$argon2id` to empty.
  - Single quotes inside `--env-file` files: Docker keeps the quotes as part of the value.
  - Unquoted/unescaped `$` in Compose YAML: Compose treats `$argon` as a substitution.
</Callout>

### `WF_AUTH_REQUIRED`

**Default:** `true`

Set to `false` only if a reverse proxy handles authentication for you (e.g.
Authentik, Authelia, Coolify's built-in auth). When `false`,
`WF_AUTH_PASSWORD_HASH` is ignored and the server starts without its own
login layer.

### `WF_AUTH_TOKEN_TTL_MINUTES`

**Default:** `60`

JWT access token lifetime in minutes. Users re-authenticate after this
expires.

```
60      # 1 hour (default)
1440    # 24 hours
10080   # 7 days
```

### `WF_COOKIE_SECURE`

**Default:** `auto`

Controls the `Secure` attribute on the auth session cookie. Accepted
values:

| Value                  | Behavior                                                                  |
| ---------------------- | ------------------------------------------------------------------------- |
| `auto` _(default)_     | Sets `Secure` automatically based on whether the request was HTTPS.       |
| `true`, `1`, `yes`     | Always sets `Secure`. Use behind a reverse proxy that terminates HTTPS.   |
| `false`, `0`, `no`     | Never sets `Secure`. Only safe for local-only or testing setups.          |

If you sit behind a reverse proxy doing TLS termination, `auto` works in
most cases, but force `true` if cookies aren't sticking after login.

## Server

### `WF_LISTEN_ADDR`

**Default:** `0.0.0.0:8088`

Bind address. The default works for Docker out of the box. For local
non-Docker use, switch to a loopback address.

```
0.0.0.0:8088   # Docker / network-accessible (default)
127.0.0.1:8080 # Local non-Docker
0.0.0.0:3000   # Custom port
```

<Callout type="warning">
  Listening on a non-loopback address (anything other than `127.0.0.1`)
  without setting `WF_AUTH_PASSWORD_HASH` causes the server to refuse to
  start. Set `WF_AUTH_REQUIRED=false` to opt out (only safe if a reverse
  proxy authenticates for you).
</Callout>

### `WF_DB_PATH`

**Default:** `./db/app.db`

Path to the SQLite database. Either a file path or a directory (in which
case `app.db` is created inside).

```
/data/wealthfolio.db   # Recommended for Docker (with /data volume mount)
/data                  # Same: app.db gets created inside
./database/app.db      # Local relative path
```

### `WF_STATIC_DIR`

**Default:** `dist`

Directory the server reads static frontend assets from. Only relevant if
you're serving a custom frontend build.

### `WF_REQUEST_TIMEOUT_MS`

**Default:** `300000` (5 minutes)

HTTP request timeout in milliseconds. The default is generous to
accommodate large broker syncs; lower it if you want stricter timeouts.

## Network

### `WF_CORS_ALLOW_ORIGINS`

**Default:** `*` (wildcard). **Rejected at startup if auth is enabled.**

Comma-separated list of allowed CORS origins. When you enable auth (which
you should for any network-accessible deployment), you **must** set
explicit origins matching the URL in your browser's address bar exactly
(scheme + host + port).

```
http://192.168.1.10:8088
https://wealthfolio.example.com
http://localhost:1420,http://localhost:3000   # multi-origin
```

<Callout type="warning">
  Wildcard CORS combined with cookie-based auth is a CSRF vector. That's
  why the server refuses to start in that combination. If you see a
  startup panic mentioning CORS, set explicit origins.
</Callout>

## Add-ons

### `WF_ADDONS_DIR`

**Default:** parent directory of `WF_DB_PATH`

Path where Wealthfolio reads installable add-ons from. Defaults to the
same directory as your database, so a single `/data` mount holds
everything.

## Logging

### `WF_LOG_FORMAT`

**Default:** `text`

Log output format: `text` (human-readable, colored) or `json` (structured,
ship to log aggregators).

## Complete `.env` example

```bash
# Server (default 0.0.0.0:8088 already works inside Docker; included for clarity)
WF_LISTEN_ADDR=0.0.0.0:8088
WF_DB_PATH=/data/wealthfolio.db

# Security (required, back up the secret key!)
WF_SECRET_KEY=replace-with-output-of-openssl-rand-base64-32

# Authentication (this is your login password)
WF_AUTH_PASSWORD_HASH='$argon2id$v=19$m=19456,t=2,p=1$...'
WF_AUTH_TOKEN_TTL_MINUTES=480

# Network: explicit origin required when auth is on
WF_CORS_ALLOW_ORIGINS=https://wealthfolio.example.com

# Logging
WF_LOG_FORMAT=text
```
