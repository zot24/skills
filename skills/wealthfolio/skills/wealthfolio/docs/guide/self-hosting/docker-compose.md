> Source: https://wealthfolio.app/docs/guide/self-hosting/docker-compose



Docs


Self-Host with Docker Compose


# Self-Host with Docker Compose

Run Wealthfolio with a compose.yml that bundles restart policies, env files, direct browser access, and an optional reverse proxy override.


Last updated November 12, 2026


If you already manage your homelab with Compose, this is the path you want. The Wealthfolio repo ships a production-ready `compose.yml` for direct browser access, plus an optional `compose.proxy.yml` override for same-network reverse proxy setups.

## Prerequisites

- Docker + Docker Compose v2 (`docker compose`, not `docker-compose`)
- `openssl` and `argon2` for generating secrets

## Get the compose file

The official compose files live in the <a href="https://github.com/wealthfolio/wealthfolio" class="font-medium underline underline-offset-4">project repo</a>. Pull the default compose file locally:

``` mb-4
mkdir -p /opt/wealthfolio && cd /opt/wealthfolio
curl -fsSL https://raw.githubusercontent.com/wealthfolio/wealthfolio/main/compose.yml -o compose.yml
```

If you run Wealthfolio behind a reverse proxy container on the same Docker network, also pull the proxy override:

``` mb-4
curl -fsSL https://raw.githubusercontent.com/wealthfolio/wealthfolio/main/compose.proxy.yml -o compose.proxy.yml
```

It declares a single service backed by the `wealthfolio/wealthfolio:latest` image, with a named volume, healthcheck, resource limits, and security hardening (read-only filesystem + dropped privileges).

## Create your `.env`

Generate the required secrets and write them to `.env`:

``` mb-4
SECRET=$(openssl rand -base64 32)
HASH=$(printf 'your-password' | argon2 yoursalt16chars! -id -e)

cat > .env <<EOF
WF_SECRET_KEY='${SECRET}'
WF_AUTH_PASSWORD_HASH='${HASH}'
WF_CORS_ALLOW_ORIGINS=http://localhost:8088
EOF
chmod 600 .env
```

Set `WF_CORS_ALLOW_ORIGINS` to the exact URL you’ll use in the browser, for example `http://192.168.1.10:8088` for LAN access or `https://wealthfolio.example.com` behind a reverse proxy.


**Single quotes around `WF_AUTH_PASSWORD_HASH` are mandatory.** Compose interpolates `$` in `.env` files by default, and the Argon2 hash is full of `$` characters. Single-quote it, or double every `$` (`$$argon2id$$...`). Compose 2.30+ also supports `format: raw` in `env_file` to skip interpolation entirely – see the <a href="/docs/guide/self-hosting/configuration/#escaping-dollar-signs-in-your-hash" class="font-medium underline underline-offset-4">escaping table</a>.


## Start it

``` mb-4
docker compose --env-file .env up -d
```

The default compose file publishes the app on host port `8088`, so `http://localhost:8088` works from the Docker host. To use a different host port:

``` mb-4
WF_PORT=8090 docker compose --env-file .env up -d
```

Then open `http://localhost:8090`.

### Installation directory

The supplied `compose.yml` sets `WF_DB_PATH=/data/wealthfolio.db`. Its parent already selects `/data` for the profile registry, profile databases, and encrypted vault. Existing installations can keep that configuration.

To set the installation directory explicitly, add a Compose override:

``` mb-4
# compose.override.yml
services:
  wealthfolio:
    environment:
      WF_DATA_DIR: /data
```

For a **fresh** installation using only `WF_DATA_DIR`, add `WF_DB_PATH: ""` under `environment` in that override. This clears the path supplied by the image and `compose.yml`. Do not clear the old path when upgrading a volume containing `/data/wealthfolio.db`; doing so changes the legacy database candidate. Keep `/data` mounted persistently in either case. An `.env` entry alone cannot override `WF_DB_PATH` hardcoded in `compose.yml`.

Start with both files:

``` mb-4
docker compose --env-file .env -f compose.yml -f compose.override.yml up -d
```

## OIDC with a private CA

If your identity provider uses a private CA, configure <a href="/docs/guide/self-hosting/configuration/#wf_oidc_ca_file" class="font-medium underline underline-offset-4"><code>WF_OIDC_CA_FILE</code></a> and mount its PEM bundle read-only. This is optional; existing installations need no additional file or mount.

Create the host bundle first. Save the following as `compose.oidc-ca.yml` alongside `compose.yml`, replacing the source with your existing file’s absolute host path:

``` mb-4
services:
  wealthfolio:
    environment:
      WF_OIDC_CA_FILE: /certs/internal-ca.pem
    volumes:
      - type: bind
        source: /protected/internal-ca.pem
        target: /certs/internal-ca.pem
        read_only: true
        bind:
          create_host_path: false
```

Add the overlay to your normal Compose command, preserving your environment file and **all existing `-f` files**. Explicit `-f` arguments disable automatic loading of `compose.override.yml`; include it explicitly if your installation uses it, along with any proxy overlays. For an installation using only the base configuration:

``` mb-4
docker compose --env-file .env -f compose.yml -f compose.oidc-ca.yml up -d
```

If you use the installation override from the previous section, keep it:

``` mb-4
docker compose --env-file .env -f compose.yml -f compose.override.yml -f compose.oidc-ca.yml up -d
```

The existing data volume remains mounted. Ensure the CA file is readable by the container’s configured runtime user (UID/GID `1000:1000` by default), while only trusted administrators can change it or its parent directory. Recreate the service after adding the setting, and restart it after replacing the bundle. Missing or invalid certificates prevent startup when OIDC is enabled.

## Inspect & manage

``` mb-4
docker compose --env-file .env logs -f          # Follow logs
docker compose --env-file .env ps               # Status
docker compose --env-file .env restart          # Bounce the container
docker compose --env-file .env down             # Stop and remove (volume persists)
docker compose --env-file .env pull && docker compose --env-file .env up -d   # Update to latest
```

## Reverse proxy integration

Use the proxy override when your reverse proxy runs as a container on the same Docker network. It removes the host `ports` mapping and exposes Wealthfolio only to other containers:

``` mb-4
docker compose --env-file .env -f compose.yml -f compose.proxy.yml up -d
```

Then point your proxy at `wealthfolio:8088`. If your proxy uses a shared external network, add Wealthfolio to that network:

``` mb-4
# compose.override.yml
services:
  wealthfolio:
    networks:
      - proxy
networks:
  proxy:
    external: true
```

Start with all three files when using that override:

``` mb-4
docker compose --env-file .env -f compose.yml -f compose.proxy.yml -f compose.override.yml up -d
```

See <a href="/docs/guide/self-hosting/reverse-proxy/" class="font-medium underline underline-offset-4"><strong>Reverse proxy setup</strong></a> for full examples.

### Traefik labels

If you’re on Traefik, add labels in your `compose.override.yml`:

``` mb-4
services:
  wealthfolio:
    labels:
      - traefik.enable=true
      - traefik.http.routers.wealthfolio.rule=Host(`wealthfolio.example.com`)
      - traefik.http.routers.wealthfolio.entrypoints=websecure
      - traefik.http.routers.wealthfolio.tls.certresolver=letsencrypt
      - traefik.http.services.wealthfolio.loadbalancer.server.port=8088
```

Set `WF_CORS_ALLOW_ORIGINS=https://wealthfolio.example.com` in your `.env` to match.

## Permissions

The container runs as non-root UID/GID `1000:1000`. The shipped compose file uses a named volume (`wealthfolio-data`), so fresh installs get the right ownership automatically. If you swap in a bind mount, `chown` it to `1000:1000` first.


**Upgrading from a pre-`v3.4.0` image?** Older images ran as `root`, so the existing volume is owned by root and the new container can’t write to it. Stop the stack and chown the volume once using the snippet below.


``` mb-4
docker compose --env-file .env down
# Replace `wealthfolio_wealthfolio-data` with your actual volume name.
# Compose prefixes the volume with the project name (folder name or `-p` flag).
# Run `docker volume ls` to find it.
docker run --rm -v wealthfolio_wealthfolio-data:/data alpine chown -R 1000:1000 /data
docker compose --env-file .env up -d
```

## Pinning the version

`wealthfolio/wealthfolio:latest` rolls forward on every release. For production, pin a tag:

``` mb-4
services:
  wealthfolio:
    image: wealthfolio/wealthfolio:3.3.0
```

Then update deliberately by bumping the tag and running `docker compose --env-file .env up -d`.

## Backups

The compose file uses a named volume `wealthfolio-data`. Back it up by running a sidecar tar:

``` mb-4
docker run --rm \
  -v wealthfolio_wealthfolio-data:/data \
  -v "$(pwd):/backup" \
  alpine tar czf /backup/wealthfolio-$(date +%Y%m%d).tar.gz -C / data
```

(Volume name is `<compose-project>_<volume-name>`. Adjust if your project name differs.)


Back up `.env` (which holds `WF_SECRET_KEY`) **separately** from the data volume. The encrypted secrets in the volume are useless without the key.


## Configuration

Every variable Wealthfolio reads is documented in the <a href="/docs/guide/self-hosting/configuration/" class="font-medium underline underline-offset-4"><strong>Configuration reference</strong></a>.


<a href="/docs/guide/self-hosting/docker/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08]">Docker</a> <a href="/docs/guide/self-hosting/unraid/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">Unraid</a>


On this page

- <a href="#prerequisites" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Prerequisites</a>
- <a href="#get-the-compose-file" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Get the compose file</a>
- <a href="#create-your-env" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Create your .env</a>
- <a href="#start-it" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Start it</a>
  - <a href="#installation-directory" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Installation directory</a>
- <a href="#oidc-with-a-private-ca" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">OIDC with a private CA</a>
- <a href="#inspect--manage" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Inspect &amp; manage</a>
- <a href="#reverse-proxy-integration" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Reverse proxy integration</a>
  - <a href="#traefik-labels" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Traefik labels</a>
- <a href="#permissions" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Permissions</a>
- <a href="#pinning-the-version" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Pinning the version</a>
- <a href="#backups" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Backups</a>
- <a href="#configuration" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Configuration</a>


