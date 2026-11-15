> Source: https://wealthfolio.app/docs/guide/self-hosting



Docs


Self-Hosting Wealthfolio


# Self-Hosting Wealthfolio

Run Wealthfolio on your own infrastructure or choose managed hosting with PikaPods. Explore Docker, Unraid, Proxmox, and Coolify setup guides.


Last updated November 12, 2026


Wealthfolio is local-first by design. The desktop app keeps everything on your machine. The **web edition** packages the same engine into a single Docker image so you can run it on a homelab, NAS, or VPS and access it from any browser.

Follow a platform-specific guide to run Wealthfolio on your own infrastructure, or explore third-party hosting below.

## Image

Multi-arch (`linux/amd64`, `linux/arm64`), published on every release:


| Registry   | Image                                    |
|------------|------------------------------------------|
| Docker Hub | `wealthfolio/wealthfolio:latest`         |
| GHCR       | `ghcr.io/wealthfolio/wealthfolio:latest` |


The legacy `afadil/wealthfolio` Docker Hub image is still published on every release as a backwards-compat mirror, so existing compose files don’t need changes.

Pin to a specific tag (e.g. `3.3.0`) in production rather than `latest`.

## Pick your platform


| You already use… | Read this |
|----|----|
| Plain Docker on a Linux box | <a href="/docs/guide/self-hosting/docker/" class="font-medium underline underline-offset-4"><strong>Docker</strong></a> |
| Docker Compose / a `compose.yml` workflow | <a href="/docs/guide/self-hosting/docker-compose/" class="font-medium underline underline-offset-4"><strong>Docker Compose</strong></a> |
| **Unraid** (NAS / homelab) | <a href="/docs/guide/self-hosting/unraid/" class="font-medium underline underline-offset-4"><strong>Unraid</strong></a> |
| **Proxmox VE** (LXC or VMs) | <a href="/docs/guide/self-hosting/proxmox/" class="font-medium underline underline-offset-4"><strong>Proxmox</strong></a> |
| **Coolify** (self-hosted PaaS) | <a href="/docs/guide/self-hosting/coolify/" class="font-medium underline underline-offset-4"><strong>Coolify</strong></a> |
| Something else | <a href="/docs/guide/self-hosting/docker/" class="font-medium underline underline-offset-4"><strong>Docker</strong></a> (works anywhere Docker runs) |


After install, all platforms share the same configuration:

- 📋 <a href="/docs/guide/self-hosting/configuration/" class="font-medium underline underline-offset-4"><strong>Configuration reference</strong></a>: every `WF_*` env var explained, plus Argon2 hash escaping
- 🌐 <a href="/docs/guide/self-hosting/reverse-proxy/" class="font-medium underline underline-offset-4"><strong>Reverse proxy setup</strong></a>: Nginx, Caddy, Traefik, NPM examples for HTTPS

## Third-party hosting

Prefer to have someone manage the server? Explore <a href="/docs/guide/self-hosting/third-party-hosting/" class="font-medium underline underline-offset-4"><strong>Third-party hosting</strong></a> for managed options, or follow the <a href="/docs/guide/self-hosting/pikapods/" class="font-medium underline underline-offset-4"><strong>PikaPods guide</strong></a> for setup, billing, and backup details.

## What you’ll need before you start

Two values are required in every deployment:

1.  **A 32-byte secret key** that encrypts your stored API keys and signs JWTs:

    ``` mb-4
    openssl rand -base64 32
    ```

    Save this somewhere safe. Losing it means losing access to all stored broker credentials and exchange API keys.

2.  **A login password hash** (Argon2id PHC string):

    ``` mb-4
    printf 'your-password' | argon2 yoursalt16chars! -id -e
    ```

    (`brew install argon2`, `apt install argon2`, or use <a href="https://argon2.online" class="font-medium underline underline-offset-4">argon2.online</a>.)

Both go into environment variables your platform will ask for. The <a href="/docs/guide/self-hosting/configuration/" class="font-medium underline underline-offset-4">Configuration reference</a> walks through every variable.


Use `printf` (not `echo -n`) when generating the hash. `echo` adds a trailing newline on some shells that breaks login silently.


## Quick taste: Docker one-liner

If you just want to kick the tires:

``` mb-4
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

Open `http://localhost:8088` and log in with your password. For anything beyond a quick try, follow the platform-specific guide above.

## Troubleshooting

### ”attempt to write a readonly database” / permission denied after upgrade

Starting with **3.4.0**, the container runs as UID 1000 instead of root. If your existing data volume was created by an older (root-running) image, SQLite can’t write to it.

**Fix:** stop the container, then `chown` the data volume to UID 1000:

``` mb-4
docker stop wealthfolio
sudo chown -R 1000:1000 /path/to/your/wealthfolio/data
docker start wealthfolio
```

If you’re using a named Docker volume (e.g. `wealthfolio-data`), find its mount point:

``` mb-4
docker volume inspect wealthfolio-data
# look for "Mountpoint"
sudo chown -R 1000:1000 /var/lib/docker/volumes/wealthfolio-data/_data
```


Do **not** run `chmod 777` as a shortcut. Wealthfolio’s container is intentionally non-root. Fix the ownership instead of opening the volume to everyone.


### Prices aren’t updating in self-hosted

Three likely causes, in order of frequency:

1.  **The market-data provider can’t be reached.** If you’ve sandboxed outbound DNS or block egress, allow connections to your provider host (e.g. `query1.finance.yahoo.com`).
2.  **Symbol delisted or returned bad data.** Open the <a href="/docs/guide/health-center/" class="font-medium underline underline-offset-4">Health Center</a>. It flags suspect or stale quotes. Switch the asset to manual quotes if the source no longer publishes prices.
3.  **Custom provider points to a private/internal IP.** If you’ve hardened your network or sit behind a reverse proxy, make sure the Wealthfolio process can resolve and reach the host. Test the provider URL from inside the container or the same shell Wealthfolio runs from before assuming the issue is in the app.

### Why is my self-hosted instance hitting `wealthfolio.app`?

The release-check ping. It asks the public site whether a newer version is available and carries no portfolio data. To disable it, turn off **Enable automatic update checks** under **Settings → General → Automatic updates** in the app – the setting is stored per instance as `auto_update_check_enabled`. Since 3.13, the web app skips the check when it can’t read the setting, for example after a reload while it starts, so a check you turned off stays off.

### Required environment variables

The container won’t start without these:


| Variable | What it is |
|----|----|
| `WF_SECRET_KEY` | 32-byte secret (base64). Encrypts stored API keys + signs JWTs. Losing it locks you out of broker creds. |
| `WF_AUTH_PASSWORD_HASH` | Argon2id PHC hash of your login password. Use `printf '…' | argon2 …`, never `echo -n`. |
| `WF_LISTEN_ADDR` | Bind address inside the container (typically `0.0.0.0:8088`). |
| `WF_DB_PATH` | Existing SQLite file path (typically `/data/wealthfolio.db`); its parent selects the installation directory. |
| `WF_DATA_DIR` | Optional explicit installation directory for the profile registry, profile databases, and encrypted vault. |
| `WF_CORS_ALLOW_ORIGINS` | Comma-separated origins allowed to call the API (set to your reverse-proxy URL). |


Full reference: <a href="/docs/guide/self-hosting/configuration/" class="font-medium underline underline-offset-4">Configuration</a>.

### Which Docker image should I pull?


| Registry | Image | Notes |
|----|----|----|
| Docker Hub | `wealthfolio/wealthfolio` | Primary, recommended. |
| GHCR | `ghcr.io/wealthfolio/wealthfolio` | Mirror on every release. |
| Legacy | `afadil/wealthfolio` | Still published as a mirror so old compose files work. |


Pin to a specific tag in production (e.g. `wealthfolio/wealthfolio:3.4.0`). `latest` will follow new majors and can ship breaking changes.

### OIDC / SSO

Supported on the web edition. Sign in through any OpenID Connect provider (Authentik, PocketID, Authelia, Keycloak, …) alongside or instead of the shared password – a successful SSO login mints the same session. Enable it with the `WF_OIDC_*` variables; see <a href="/docs/guide/self-hosting/configuration/#single-sign-on-oidc" class="font-medium underline underline-offset-4">Configuration → Single Sign-On (OIDC)</a>. Closes <a href="https://github.com/wealthfolio/wealthfolio/issues/592" class="font-medium underline underline-offset-4">#592</a>.

## Getting help

- **Discord**: <a href="https://discord.gg/WDMCY6aPWK" class="font-medium underline underline-offset-4">discord.gg/WDMCY6aPWK</a>
- **GitHub Issues**: <a href="https://github.com/wealthfolio/wealthfolio/issues" class="font-medium underline underline-offset-4">github.com/wealthfolio/wealthfolio/issues</a>
- **Source**: <a href="https://github.com/wealthfolio/wealthfolio" class="font-medium underline underline-offset-4">github.com/wealthfolio/wealthfolio</a> (AGPL-3.0)


<a href="/docs/guide/mobile/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08]">Mobile</a> <a href="/docs/guide/self-hosting/configuration/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">Configuration</a>


On this page

- <a href="#image" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Image</a>
- <a href="#pick-your-platform" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Pick your platform</a>
- <a href="#third-party-hosting" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Third-party hosting</a>
- <a href="#what-youll-need-before-you-start" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">What you'll need before you start</a>
- <a href="#quick-taste-docker-one-liner" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Quick taste: Docker one-liner</a>
- <a href="#troubleshooting" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Troubleshooting</a>
  - <a href="#attempt-to-write-a-readonly-database--permission-denied-after-upgrade" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">"attempt to write a readonly database" / permission denied after upgrade</a>
  - <a href="#prices-arent-updating-in-self-hosted" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Prices aren't updating in self-hosted</a>
  - <a href="#why-is-my-self-hosted-instance-hitting-wealthfolioapp" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Why is my self-hosted instance hitting wealthfolio.app?</a>
  - <a href="#required-environment-variables" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Required environment variables</a>
  - <a href="#which-docker-image-should-i-pull" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Which Docker image should I pull?</a>
  - <a href="#oidc--sso" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">OIDC / SSO</a>
- <a href="#getting-help" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Getting help</a>


