> Source: https://wealthfolio.app/docs/guide/self-hosting/docker-compose

If you already manage your homelab with Compose, this is the path you
want. The Wealthfolio repo ships a production-ready `compose.yml` for
direct browser access, plus an optional `compose.proxy.yml` override for
same-network reverse proxy setups.

## Prerequisites

- Docker + Docker Compose v2 (`docker compose`, not `docker-compose`)
- `openssl` and `argon2` for generating secrets

## Get the compose file

The official compose files live in the [project repo](https://github.com/wealthfolio/wealthfolio).
Pull the default compose file locally:

```bash
mkdir -p /opt/wealthfolio && cd /opt/wealthfolio
curl -fsSL https://raw.githubusercontent.com/wealthfolio/wealthfolio/main/compose.yml -o compose.yml
```

If you run Wealthfolio behind a reverse proxy container on the same
Docker network, also pull the proxy override:

```bash
curl -fsSL https://raw.githubusercontent.com/wealthfolio/wealthfolio/main/compose.proxy.yml -o compose.proxy.yml
```

It declares a single service backed by the `wealthfolio/wealthfolio:latest`
image, with a named volume, healthcheck, resource limits, and security
hardening (read-only filesystem + dropped privileges).

## Create your `.env`

Generate the required secrets and write them to `.env`:

```bash
SECRET=$(openssl rand -base64 32)
HASH=$(printf 'your-password' | argon2 yoursalt16chars! -id -e)

cat > .env <<EOF
WF_SECRET_KEY='${SECRET}'
WF_AUTH_PASSWORD_HASH='${HASH}'
WF_CORS_ALLOW_ORIGINS=http://localhost:8088
EOF
chmod 600 .env
```

Set `WF_CORS_ALLOW_ORIGINS` to the exact URL you'll use in the browser,
for example `http://192.168.1.10:8088` for LAN access or
`https://wealthfolio.example.com` behind a reverse proxy.

<Callout type="warning">
  **Single quotes around `WF_AUTH_PASSWORD_HASH` are mandatory.** Compose interpolates `$` in `.env`
  files by default, and the Argon2 hash is full of `$` characters. Single-quote it, or double every
  `$` (`$$argon2id$$...`). Compose 2.30+ also supports `format: raw` in `env_file` to skip
  interpolation entirely — see the [escaping
  table](/docs/guide/self-hosting/configuration#escaping-dollar-signs-in-your-hash).
</Callout>

## Start it

```bash
docker compose --env-file .env up -d
```

The default compose file publishes the app on host port `8088`, so
`http://localhost:8088` works from the Docker host. To use a different
host port:

```bash
WF_PORT=8090 docker compose --env-file .env up -d
```

Then open `http://localhost:8090`.

## Inspect & manage

```bash
docker compose --env-file .env logs -f          # Follow logs
docker compose --env-file .env ps               # Status
docker compose --env-file .env restart          # Bounce the container
docker compose --env-file .env down             # Stop and remove (volume persists)
docker compose --env-file .env pull && docker compose --env-file .env up -d   # Update to latest
```

## Reverse proxy integration

Use the proxy override when your reverse proxy runs as a container on
the same Docker network. It removes the host `ports` mapping and exposes
Wealthfolio only to other containers:

```bash
docker compose --env-file .env -f compose.yml -f compose.proxy.yml up -d
```

Then point your proxy at `wealthfolio:8088`. If your proxy uses a shared
external network, add Wealthfolio to that network:

```yaml
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

```bash
docker compose --env-file .env -f compose.yml -f compose.proxy.yml -f compose.override.yml up -d
```

See
[**Reverse proxy setup**](/docs/guide/self-hosting/reverse-proxy) for full
examples.

### Traefik labels

If you're on Traefik, add labels in your `compose.override.yml`:

```yaml
services:
  wealthfolio:
    labels:
      - traefik.enable=true
      - traefik.http.routers.wealthfolio.rule=Host(`wealthfolio.example.com`)
      - traefik.http.routers.wealthfolio.entrypoints=websecure
      - traefik.http.routers.wealthfolio.tls.certresolver=letsencrypt
      - traefik.http.services.wealthfolio.loadbalancer.server.port=8088
```

Set `WF_CORS_ALLOW_ORIGINS=https://wealthfolio.example.com` in your
`.env` to match.

## Permissions

The container runs as non-root UID/GID `1000:1000`. The shipped compose
file uses a named volume (`wealthfolio-data`), so fresh installs get the
right ownership automatically. If you swap in a bind mount, `chown` it
to `1000:1000` first.

<Callout type="warning">
  **Upgrading from a pre-`v3.4.0` image?** Older images ran as `root`, so the existing volume is
  owned by root and the new container can't write to it. Stop the stack and chown the volume once
  using the snippet below.
</Callout>

```bash
docker compose --env-file .env down
# Replace `wealthfolio_wealthfolio-data` with your actual volume name.
# Compose prefixes the volume with the project name (folder name or `-p` flag).
# Run `docker volume ls` to find it.
docker run --rm -v wealthfolio_wealthfolio-data:/data alpine chown -R 1000:1000 /data
docker compose --env-file .env up -d
```

## Pinning the version

`wealthfolio/wealthfolio:latest` rolls forward on every release. For
production, pin a tag:

```yaml
services:
  wealthfolio:
    image: wealthfolio/wealthfolio:3.3.0
```

Then update deliberately by bumping the tag and running
`docker compose --env-file .env up -d`.

## Backups

The compose file uses a named volume `wealthfolio-data`. Back it up by
running a sidecar tar:

```bash
docker run --rm \
  -v wealthfolio_wealthfolio-data:/data \
  -v "$(pwd):/backup" \
  alpine tar czf /backup/wealthfolio-$(date +%Y%m%d).tar.gz -C / data
```

(Volume name is `<compose-project>_<volume-name>`. Adjust if your
project name differs.)

<Callout type="warning">
  Back up `.env` (which holds `WF_SECRET_KEY`) **separately** from the data volume. The encrypted
  secrets in the volume are useless without the key.
</Callout>

## Configuration

Every variable Wealthfolio reads is documented in the
[**Configuration reference**](/docs/guide/self-hosting/configuration).
