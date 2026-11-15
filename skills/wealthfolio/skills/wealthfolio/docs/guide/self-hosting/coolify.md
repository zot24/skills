> Source: https://wealthfolio.app/docs/guide/self-hosting/coolify



Docs


Coolify


# Coolify

Deploy Wealthfolio on Coolify, the self-hosted PaaS that handles HTTPS, env vars, persistent storage, and rolling updates with one click.


Last updated November 12, 2026


<a href="https://coolify.io" class="font-medium underline underline-offset-4">Coolify</a> is a self-hosted PaaS, think Heroku you run on your own VPS. It handles HTTPS, env vars, persistent storage, and rolling updates, so deploying Wealthfolio is mostly clicks plus a few values to paste in.

## Prerequisites

- A Coolify instance (v4 or newer) with a configured server and destination
- A domain pointed at your Coolify server (for HTTPS)
- `openssl` and `argon2` on any machine for generating secrets

## Deploy

### Step 1: Create a new resource

In Coolify: **+ New Resource → Docker Image**.


| Field              | Value                            |
|--------------------|----------------------------------|
| **Image**          | `wealthfolio/wealthfolio:latest` |
| **Port (exposed)** | `8088`                           |


Pin to a specific tag (e.g. `wealthfolio/wealthfolio:3.3.0`) for production.

### Step 2: Set the domain

Under **Domains**, add the FQDN you want (e.g. `wealthfolio.example.com`). Coolify provisions a Let’s Encrypt certificate automatically through its built-in proxy (Traefik or Caddy).

### Step 3: Generate your secrets

On any machine:

``` mb-4
# 32-byte secret key. Back this up!
openssl rand -base64 32

# Argon2id password hash for your login
printf 'your-password' | argon2 yoursalt16chars! -id -e
```

### Step 4: Set environment variables

Under **Environment Variables**, add:


| Name | Value | Notes |
|----|----|----|
| `WF_LISTEN_ADDR` | `0.0.0.0:8088` | Required for container networking |
| `WF_DB_PATH` | `/data/wealthfolio.db` | SQLite database location |
| `WF_SECRET_KEY` | *(paste your 32-byte key)* | Toggle **Is Secret**, Coolify masks the value |
| `WF_AUTH_PASSWORD_HASH` | *(paste the full `$argon2id$...` string)* | Toggle **Is Secret** *and* **Is Literal?** – see below |
| `WF_CORS_ALLOW_ORIGINS` | `https://wealthfolio.example.com` | Must match your domain exactly |
| `WF_AUTH_TOKEN_TTL_MINUTES` | `480` | Optional (8 hours) |


**Check “Is Literal?” on `WF_AUTH_PASSWORD_HASH`.** By default Coolify treats `$` in values as variable references, so the `$argon2id`, `$v`, and `$m` segments of your hash get interpolated away and login will always fail. Marking a variable **Is Secret** only masks it in the UI – it does **not** prevent interpolation. Enable **Is Literal?** so the hash is passed through byte-for-byte, then paste the raw hash without doubling or quoting.


After deploying, verify the hash survived: open the container’s **Terminal** in Coolify and run `printenv WF_AUTH_PASSWORD_HASH`. The output must start with `$argon2id$` and match your generated hash exactly.

### Step 5: Add persistent storage

Under **Storage** (or **Persistent Volumes**), add a mount:


| Field           | Value              |
|-----------------|--------------------|
| **Mount path**  | `/data`            |
| **Type**        | Volume Mount       |
| **Volume name** | `wealthfolio-data` |


This holds your SQLite database and encrypted secrets. Without it, all data is lost on container restart.

### Step 6: Deploy

Click **Deploy**. Coolify pulls the image, mounts the volume, sets the env, and starts the container behind its proxy. After ~30 seconds, your domain serves Wealthfolio over HTTPS.

## Updating

Coolify auto-fetches new images if you’ve enabled **Watchtower** / auto-update; otherwise click **Redeploy** to pull `:latest` (or change the tag). For zero-downtime, enable **Rolling Updates** in the resource settings.


**Upgrading from a pre-`v3.4.0` image?** The container now runs as non-root UID `1000`. Existing Coolify volumes were written by the old `root` image and need a one-time chown – otherwise the new container fails to write and restarts. SSH into the Coolify host and run the snippet below, then **Redeploy** in Coolify.


``` mb-4
# Find the volume with: docker volume ls | grep wealthfolio
docker run --rm -v <volume-name>:/data alpine chown -R 1000:1000 /data
```

## Health checks

Wealthfolio exposes a health endpoint at `/api/v1/healthz`. Configure Coolify’s healthcheck:


| Field            | Value             |
|------------------|-------------------|
| **Path**         | `/api/v1/healthz` |
| **Port**         | `8088`            |
| **Interval**     | `30s`             |
| **Start period** | `15s`             |


## Letting Coolify handle authentication

If you use Coolify’s **basic auth** or front it with **Authentik / Authelia**, you can disable Wealthfolio’s built-in login:


| Variable                | Value     |
|-------------------------|-----------|
| `WF_AUTH_REQUIRED`      | `false`   |
| `WF_AUTH_PASSWORD_HASH` | *(empty)* |


Wealthfolio will trust whatever Coolify’s proxy lets through.

## Backups

Coolify’s S3 backup integration handles the volume. Point it at your `wealthfolio-data` volume and your storage backend.


Back up `WF_SECRET_KEY` **separately** from the volume. The encrypted secrets in `/data/secrets.json` are useless without the key.


## Troubleshooting


| Symptom | Fix |
|----|----|
| Container restarts: `WF_SECRET_KEY` missing | Variable wasn’t saved as a secret. Re-add it under Environment Variables. |
| Login always says “Invalid password” | The hash was mangled by Coolify’s `$` interpolation. Open the container **Terminal**, run `printenv WF_AUTH_PASSWORD_HASH`, and compare with your generated hash. If it differs, enable **Is Literal?** on the variable and redeploy. |
| Login rejects the right password (hash intact) | Hash captured a trailing newline or a shell-mangled password. Regenerate with `printf` (not `echo -n`) and avoid special characters your shell may expand. |
| Container won’t start: `Failed to parse WF_AUTH_PASSWORD_HASH` | Same `$` interpolation problem – enable **Is Literal?** on the variable and redeploy. |
| `502 Bad Gateway` from Coolify proxy | Check `WF_LISTEN_ADDR=0.0.0.0:8088` and that the resource port matches. |
| CORS errors in browser console | `WF_CORS_ALLOW_ORIGINS` must match the domain in your address bar exactly. |


## Configuration reference

Every variable Wealthfolio reads is documented in <a href="/docs/guide/self-hosting/configuration/" class="font-medium underline underline-offset-4"><strong>Configuration</strong></a>.


<a href="/docs/guide/self-hosting/proxmox/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08]">Proxmox</a> <a href="/docs/guide/self-hosting/reverse-proxy/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">Reverse Proxy</a>


On this page

- <a href="#prerequisites" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Prerequisites</a>
- <a href="#deploy" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Deploy</a>
  - <a href="#step-1-create-a-new-resource" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Step 1: Create a new resource</a>
  - <a href="#step-2-set-the-domain" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Step 2: Set the domain</a>
  - <a href="#step-3-generate-your-secrets" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Step 3: Generate your secrets</a>
  - <a href="#step-4-set-environment-variables" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Step 4: Set environment variables</a>
  - <a href="#step-5-add-persistent-storage" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Step 5: Add persistent storage</a>
  - <a href="#step-6-deploy" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Step 6: Deploy</a>
- <a href="#updating" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Updating</a>
- <a href="#health-checks" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Health checks</a>
- <a href="#letting-coolify-handle-authentication" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Letting Coolify handle authentication</a>
- <a href="#backups" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Backups</a>
- <a href="#troubleshooting" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Troubleshooting</a>
- <a href="#configuration-reference" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Configuration reference</a>


