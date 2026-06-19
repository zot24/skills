> Source: https://wealthfolio.app/docs/guide/self-hosting/coolify

[Coolify](https://coolify.io) is a self-hosted PaaS, think Heroku you
run on your own VPS. It handles HTTPS, env vars, persistent storage,
and rolling updates, so deploying Wealthfolio is mostly clicks plus a
few values to paste in.

## Prerequisites

- A Coolify instance (v4 or newer) with a configured server and
  destination
- A domain pointed at your Coolify server (for HTTPS)
- `openssl` and `argon2` on any machine for generating secrets

## Deploy

### Step 1: Create a new resource

In Coolify: **+ New Resource → Docker Image**.

| Field              | Value                            |
| ------------------ | -------------------------------- |
| **Image**          | `wealthfolio/wealthfolio:latest` |
| **Port (exposed)** | `8088`                           |

Pin to a specific tag (e.g. `wealthfolio/wealthfolio:3.3.0`) for production.

### Step 2: Set the domain

Under **Domains**, add the FQDN you want (e.g.
`wealthfolio.example.com`). Coolify provisions a Let's Encrypt
certificate automatically through its built-in proxy (Traefik or Caddy).

### Step 3: Generate your secrets

On any machine:

```bash
# 32-byte secret key. Back this up!
openssl rand -base64 32

# Argon2id password hash for your login
printf 'your-password' | argon2 yoursalt16chars! -id -e
```

### Step 4: Set environment variables

Under **Environment Variables**, add:

| Name                        | Value                                     | Notes                                            |
| --------------------------- | ----------------------------------------- | ------------------------------------------------ |
| `WF_LISTEN_ADDR`            | `0.0.0.0:8088`                            | Required for container networking                |
| `WF_DB_PATH`                | `/data/wealthfolio.db`                    | SQLite database location                         |
| `WF_SECRET_KEY`             | _(paste your 32-byte key)_                | Toggle **Is Secret**, Coolify masks the value    |
| `WF_AUTH_PASSWORD_HASH`     | _(paste the full `$argon2id$...` string)_ | Toggle **Is Secret**, Coolify handles `$` safely |
| `WF_CORS_ALLOW_ORIGINS`     | `https://wealthfolio.example.com`         | Must match your domain exactly                   |
| `WF_AUTH_TOKEN_TTL_MINUTES` | `480`                                     | Optional (8 hours)                               |

<Callout type="info">
  Coolify's env var UI escapes `$` characters correctly when stored as secrets. Paste the raw Argon2
  hash without doubling or quoting.
</Callout>

### Step 5: Add persistent storage

Under **Storage** (or **Persistent Volumes**), add a mount:

| Field           | Value              |
| --------------- | ------------------ |
| **Mount path**  | `/data`            |
| **Type**        | Volume Mount       |
| **Volume name** | `wealthfolio-data` |

This holds your SQLite database and encrypted secrets. Without it, all
data is lost on container restart.

### Step 6: Deploy

Click **Deploy**. Coolify pulls the image, mounts the volume, sets the
env, and starts the container behind its proxy. After ~30 seconds, your
domain serves Wealthfolio over HTTPS.

## Updating

Coolify auto-fetches new images if you've enabled **Watchtower** /
auto-update; otherwise click **Redeploy** to pull `:latest` (or change
the tag). For zero-downtime, enable **Rolling Updates** in the resource
settings.

<Callout type="warning">
  **Upgrading from a pre-`v3.4.0` image?** The container now runs as non-root UID `1000`. Existing
  Coolify volumes were written by the old `root` image and need a one-time chown — otherwise the
  new container fails to write and restarts. SSH into the Coolify host and run the snippet below,
  then **Redeploy** in Coolify.
</Callout>

```bash
# Find the volume with: docker volume ls | grep wealthfolio
docker run --rm -v <volume-name>:/data alpine chown -R 1000:1000 /data
```

## Health checks

Wealthfolio exposes a health endpoint at `/api/v1/healthz`. Configure
Coolify's healthcheck:

| Field            | Value             |
| ---------------- | ----------------- |
| **Path**         | `/api/v1/healthz` |
| **Port**         | `8088`            |
| **Interval**     | `30s`             |
| **Start period** | `15s`             |

## Letting Coolify handle authentication

If you use Coolify's **basic auth** or front it with **Authentik /
Authelia**, you can disable Wealthfolio's built-in login:

| Variable                | Value     |
| ----------------------- | --------- |
| `WF_AUTH_REQUIRED`      | `false`   |
| `WF_AUTH_PASSWORD_HASH` | _(empty)_ |

Wealthfolio will trust whatever Coolify's proxy lets through.

## Backups

Coolify's S3 backup integration handles the volume. Point it at your
`wealthfolio-data` volume and your storage backend.

<Callout type="warning">
  Back up `WF_SECRET_KEY` **separately** from the volume. The encrypted secrets in
  `/data/secrets.json` are useless without the key.
</Callout>

## Troubleshooting

| Symptom                                     | Fix                                                                         |
| ------------------------------------------- | --------------------------------------------------------------------------- |
| Container restarts: `WF_SECRET_KEY` missing | Variable wasn't saved as a secret. Re-add it under Environment Variables.   |
| Login rejects the right password            | Hash captured a trailing newline. Regenerate with `printf` (not `echo -n`). |
| `502 Bad Gateway` from Coolify proxy        | Check `WF_LISTEN_ADDR=0.0.0.0:8088` and that the resource port matches.     |
| CORS errors in browser console              | `WF_CORS_ALLOW_ORIGINS` must match the domain in your address bar exactly.  |

## Configuration reference

Every variable Wealthfolio reads is documented in
[**Configuration**](/docs/guide/self-hosting/configuration).
