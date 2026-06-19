> Source: https://wealthfolio.app/docs/guide/self-hosting/docker

The fastest way to self-host Wealthfolio: pull the official multi-arch
image and run it with `docker run`. For a Compose-based setup with
restart policies and an env file, see
[**Docker Compose**](/docs/guide/self-hosting/docker-compose).

## Prerequisites

- Docker installed ([install guide](https://docs.docker.com/get-docker/))
- `openssl` and `argon2` for generating the secret key and password hash
  (`brew install argon2` on macOS, `apt install argon2` on Debian/Ubuntu)

## Pull the image

```bash
docker pull wealthfolio/wealthfolio:latest
```

Or from GHCR:

```bash
docker pull ghcr.io/wealthfolio/wealthfolio:latest
```

Both registries publish identical multi-arch builds (`linux/amd64`,
`linux/arm64`). Pin to a version tag in production:

```bash
docker pull wealthfolio/wealthfolio:3.3.0
```

## Generate your secrets

Two values are required (see [Configuration](/docs/guide/self-hosting/configuration)
for full details):

```bash
# 32-byte secret key. Save this somewhere safe!
SECRET=$(openssl rand -base64 32)

# Argon2id password hash for your login
HASH=$(printf 'your-password' | argon2 yoursalt16chars! -id -e)
```

## Run

### Quick start (inline env vars)

```bash
docker run -d \
  --name wealthfolio \
  -p 8088:8088 \
  -v wealthfolio-data:/data \
  -e WF_LISTEN_ADDR=0.0.0.0:8088 \
  -e WF_DB_PATH=/data/wealthfolio.db \
  -e WF_SECRET_KEY="$SECRET" \
  -e WF_AUTH_PASSWORD_HASH="$HASH" \
  -e WF_CORS_ALLOW_ORIGINS=http://localhost:8088 \
  --restart unless-stopped \
  wealthfolio/wealthfolio:latest
```

Open `http://localhost:8088` and log in with the password you hashed.

<Callout type="warning">
  Inside the container, `WF_LISTEN_ADDR` **must** be `0.0.0.0:PORT`. Binding to `127.0.0.1` makes
  the app reachable only from inside the container.
</Callout>

### Production (env file)

For anything beyond a quick try, put your config in a file:

```bash
cat > .env.docker <<'EOF'
WF_LISTEN_ADDR=0.0.0.0:8088
WF_DB_PATH=/data/wealthfolio.db
WF_SECRET_KEY=replace-me
WF_AUTH_PASSWORD_HASH=$argon2id$v=19$m=19456,t=2,p=1$...
WF_CORS_ALLOW_ORIGINS=https://wealthfolio.example.com
WF_AUTH_TOKEN_TTL_MINUTES=480
EOF
chmod 600 .env.docker
```

```bash
docker run -d \
  --name wealthfolio \
  -p 8088:8088 \
  -v wealthfolio-data:/data \
  --env-file .env.docker \
  --restart unless-stopped \
  wealthfolio/wealthfolio:latest
```

<Callout type="info">
  When using `--env-file`, Docker keeps `$` characters in the hash as-is. No escaping needed. If you
  switch to `-e` flags or YAML inline values, see the [escaping
  table](/docs/guide/self-hosting/configuration#escaping-dollar-signs-in-your-hash).
</Callout>

## Volumes and ports

### Volumes

`/data` is the only mount you need. It holds:

- `wealthfolio.db`: SQLite database with all your portfolio data
- `secrets.json`: encrypted broker credentials and API keys

```bash
# Named volume (recommended, Docker manages location)
-v wealthfolio-data:/data

# Bind mount (you control the path)
-v /opt/wealthfolio:/data

# Bind mount in current directory
-v "$(pwd)/wealthfolio-data:/data"
```

<Callout type="info">
  The container runs as non-root UID/GID `1000:1000`. If you bind-mount a host directory, make sure
  it's writable by that user: `sudo chown -R 1000:1000 /opt/wealthfolio`. Named volumes don't need
  this for fresh installs — Docker creates them with the right ownership automatically.
</Callout>

<Callout type="warning">
  **Upgrading from a pre-`v3.4.0` image?** Older images ran as `root`, so existing data is owned by
  root and the new container can't write to it. Chown the volume once before starting the new image
  using the snippet below. If you manage Wealthfolio with Compose, see the
  [Docker Compose upgrade notes](/docs/guide/self-hosting/docker-compose#permissions) — the volume name will be prefixed with your compose project.
</Callout>

```bash
# Named volume (volume name matches what you used with `docker run -v`)
docker run --rm -v wealthfolio-data:/data alpine chown -R 1000:1000 /data

# Bind mount
sudo chown -R 1000:1000 /opt/wealthfolio
```

### Ports

The container exposes `8088` by default. Map it however you like:

```bash
-p 8088:8088              # Default
-p 3000:8088              # Different host port
-p 127.0.0.1:8088:8088    # Localhost only (for reverse proxy)
```

## Updating

```bash
docker pull wealthfolio/wealthfolio:latest
docker stop wealthfolio
docker rm wealthfolio
# Re-run with the same flags as before
```

If you need rolling updates without downtime, switch to
[Docker Compose](/docs/guide/self-hosting/docker-compose) or a proper
orchestrator.

<Callout type="tip">
  Always back up `/data` (and your `WF_SECRET_KEY` outside the volume) before updating. See
  [Backups](#backups) below.
</Callout>

## Backups

The only state lives in the `/data` volume. Tar it up:

```bash
docker run --rm \
  -v wealthfolio-data:/data \
  -v "$(pwd):/backup" \
  alpine tar czf /backup/wealthfolio-$(date +%Y%m%d).tar.gz -C / data
```

For a named volume, restore by stopping the container and untarring back
into the same volume.

<Callout type="warning">
  Back up the volume **and** `WF_SECRET_KEY` together. Either alone is useless: the volume holds
  encrypted secrets that only the key can decrypt.
</Callout>

## Reverse proxy

For HTTPS and a real domain, put Wealthfolio behind a reverse proxy. See
[**Reverse proxy setup**](/docs/guide/self-hosting/reverse-proxy) for
Nginx, Caddy, Traefik, and NPM examples.

## Troubleshooting

### Container won't start

```bash
docker logs wealthfolio
```

| Log says                           | Fix                                                                                                                                                    |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `WF_SECRET_KEY missing or invalid` | Set the variable; must decode to exactly 32 bytes (use `openssl rand -base64 32`)                                                                      |
| `Address already in use`           | Change the host port: `-p 3000:8088`                                                                                                                   |
| `Permission denied` on `/data`     | Volume is owned by `root` (pre-`v3.4.0` upgrade) or the bind-mount path isn't writable by UID `1000`. Run the chown step in the upgrade callout above. |

### Login rejects the right password

Most common cause: the hash captured a trailing newline (you used `echo
-n` instead of `printf`), or the `$` characters got eaten by your shell.
Regenerate with `printf` and quote the value with single quotes when
passing via `-e`.

### CORS errors in browser console

`WF_CORS_ALLOW_ORIGINS` must match your browser's address bar **exactly**:
scheme, host, and port all have to line up. If you access via
`http://192.168.1.10:8088`, that exact string is what goes in.
