> Source: https://wealthfolio.app/docs/guide/self-hosting

Wealthfolio is local-first by design. The desktop app keeps everything on
your machine. The **web edition** packages the same engine into a single
Docker image so you can run it on a homelab, NAS, or VPS and access it from
any browser.

This guide is split into platform-specific pages. Pick the one that matches
how you already host services.

## Image

Multi-arch (`linux/amd64`, `linux/arm64`), published on every release:

| Registry   | Image                                    |
| ---------- | ---------------------------------------- |
| Docker Hub | `wealthfolio/wealthfolio:latest`         |
| GHCR       | `ghcr.io/wealthfolio/wealthfolio:latest` |

The legacy `afadil/wealthfolio` Docker Hub image is still published on
every release as a backwards-compat mirror, so existing compose files
don't need changes.

Pin to a specific tag (e.g. `3.3.0`) in production rather than `latest`.

## Pick your platform

| You already use…                          | Read this                                                                  |
| ----------------------------------------- | -------------------------------------------------------------------------- |
| Plain Docker on a Linux box               | [**Docker**](/docs/guide/self-hosting/docker)                              |
| Docker Compose / a `compose.yml` workflow | [**Docker Compose**](/docs/guide/self-hosting/docker-compose)              |
| **Unraid** (NAS / homelab)                | [**Unraid**](/docs/guide/self-hosting/unraid)                              |
| **Proxmox VE** (LXC or VMs)               | [**Proxmox**](/docs/guide/self-hosting/proxmox)                            |
| **Coolify** (self-hosted PaaS)            | [**Coolify**](/docs/guide/self-hosting/coolify)                            |
| Something else                            | [**Docker**](/docs/guide/self-hosting/docker) (works anywhere Docker runs) |

After install, all platforms share the same configuration:

- 📋 [**Configuration reference**](/docs/guide/self-hosting/configuration): every `WF_*` env var explained, plus Argon2 hash escaping
- 🌐 [**Reverse proxy setup**](/docs/guide/self-hosting/reverse-proxy): Nginx, Caddy, Traefik, NPM examples for HTTPS

## What you'll need before you start

Two values are required in every deployment:

1. **A 32-byte secret key** that encrypts your stored API keys and signs JWTs:

   ```bash
   openssl rand -base64 32
   ```

   Save this somewhere safe. Losing it means losing access to all stored
   broker credentials and exchange API keys.

2. **A login password hash** (Argon2id PHC string):

   ```bash
   printf 'your-password' | argon2 yoursalt16chars! -id -e
   ```

   (`brew install argon2`, `apt install argon2`, or use
   [argon2.online](https://argon2.online).)

Both go into environment variables your platform will ask for. The
[Configuration reference](/docs/guide/self-hosting/configuration) walks
through every variable.

<Callout type="warning">
  Use `printf` (not `echo -n`) when generating the hash. `echo` adds a trailing newline on some
  shells that breaks login silently.
</Callout>

## Quick taste: Docker one-liner

If you just want to kick the tires:

```bash
docker run --rm -d \
  --name wealthfolio \
  -p 8088:8088 \
  -v wealthfolio-data:/data \
  -e WF_LISTEN_ADDR=0.0.0.0:8088 \
  -e WF_DB_PATH=/data/wealthfolio.db \
  -e WF_SECRET_KEY=$(openssl rand -base64 32) \
  -e WF_AUTH_PASSWORD_HASH='$argon2id$v=19$m=19456,t=2,p=1$...' \
  -e WF_CORS_ALLOW_ORIGINS=http://localhost:8088 \
  wealthfolio/wealthfolio:latest
```

Open `http://localhost:8088` and log in with your password. For anything
beyond a quick try, follow the platform-specific guide above.

## Troubleshooting

### "attempt to write a readonly database" / permission denied after upgrade

Starting with **3.4.0**, the container runs as UID 1000 instead of root. If your existing
data volume was created by an older (root-running) image, SQLite can't write to it.

**Fix:** stop the container, then `chown` the data volume to UID 1000:

```bash
docker stop wealthfolio
sudo chown -R 1000:1000 /path/to/your/wealthfolio/data
docker start wealthfolio
```

If you're using a named Docker volume (e.g. `wealthfolio-data`), find its mount point:

```bash
docker volume inspect wealthfolio-data
# look for "Mountpoint"
sudo chown -R 1000:1000 /var/lib/docker/volumes/wealthfolio-data/_data
```

<Callout type="warning">
  Do **not** run `chmod 777` as a shortcut. Wealthfolio's container is intentionally non-root.
  Fix the ownership instead of opening the volume to everyone.
</Callout>

### Prices aren't updating in self-hosted

Three likely causes, in order of frequency:

1. **The market-data provider can't be reached.** If you've sandboxed outbound DNS or
   block egress, allow connections to your provider host (e.g. `query1.finance.yahoo.com`).
2. **Symbol delisted or returned bad data.** Open the [Health Center](/docs/guide/health-center).
   It flags suspect or stale quotes. Switch the asset to manual quotes if the source no
   longer publishes prices.
3. **Custom provider points to a private/internal IP.** If you've hardened your
   network or sit behind a reverse proxy, make sure the Wealthfolio process can
   resolve and reach the host. Test the provider URL from inside the container or
   the same shell Wealthfolio runs from before assuming the issue is in the app.

### Why is my self-hosted instance hitting `wealthfolio.app`?

The release-check ping. It asks the public site whether a newer version is available and
carries no portfolio data. To disable it, toggle off **Settings → General → Check for
updates automatically** in the app — the setting is stored per instance as
`auto_update_check_enabled`.

### Required environment variables

The container won't start without these:

| Variable                | What it is                                                                                                |
| ----------------------- | --------------------------------------------------------------------------------------------------------- |
| `WF_SECRET_KEY`         | 32-byte secret (base64). Encrypts stored API keys + signs JWTs. Losing it locks you out of broker creds. |
| `WF_AUTH_PASSWORD_HASH` | Argon2id PHC hash of your login password. Use `printf '…' \| argon2 …`, never `echo -n`.                  |
| `WF_LISTEN_ADDR`        | Bind address inside the container (typically `0.0.0.0:8088`).                                             |
| `WF_DB_PATH`            | Absolute path to the SQLite file (typically `/data/wealthfolio.db`).                                      |
| `WF_CORS_ALLOW_ORIGINS` | Comma-separated origins allowed to call the API (set to your reverse-proxy URL).                          |

Full reference: [Configuration](/docs/guide/self-hosting/configuration).

### Which Docker image should I pull?

| Registry   | Image                                    | Notes                       |
| ---------- | ---------------------------------------- | --------------------------- |
| Docker Hub | `wealthfolio/wealthfolio`                | Primary, recommended.       |
| GHCR       | `ghcr.io/wealthfolio/wealthfolio`        | Mirror on every release.    |
| Legacy     | `afadil/wealthfolio`                     | Still published as a mirror so old compose files work. |

Pin to a specific tag in production (e.g. `wealthfolio/wealthfolio:3.4.0`). `latest`
will follow new majors and can ship breaking changes.

### OIDC / SSO

Not supported today. It's the most-reacted open issue
([#592](https://github.com/wealthfolio/wealthfolio/issues/592)) and is on the roadmap.

## Getting help

- **Discord**: [discord.gg/WDMCY6aPWK](https://discord.gg/WDMCY6aPWK)
- **GitHub Issues**: [github.com/wealthfolio/wealthfolio/issues](https://github.com/wealthfolio/wealthfolio/issues)
- **Source**: [github.com/wealthfolio/wealthfolio](https://github.com/wealthfolio/wealthfolio) (AGPL-3.0)
