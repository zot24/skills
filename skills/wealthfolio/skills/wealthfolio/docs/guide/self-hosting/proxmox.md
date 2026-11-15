> Source: https://wealthfolio.app/docs/guide/self-hosting/proxmox



Docs


Proxmox VE


# Proxmox VE

Three install paths on Proxmox (community-scripts LXC, Docker inside an LXC, or Docker inside a VM). Pick based on how you already run services.


Last updated November 12, 2026


There are three sensible ways to run Wealthfolio on Proxmox. Pick based on how you already run other services.


| Approach | Pros | Cons |
|----|----|----|
| <a href="#lxc" class="font-medium underline underline-offset-4">LXC via community-scripts</a> | Native execution, lowest overhead, fits the Proxmox idiom (no Docker-in-LXC) | Builds from source (~15–25 min on a typical homelab CPU on first install, <a href="https://github.com/wealthfolio/wealthfolio/issues/563" class="font-medium underline underline-offset-4">#563</a>) |
| <a href="#docker-lxc" class="font-medium underline underline-offset-4">Docker inside an LXC</a> | Fast install (image pull only), easy updates | Docker-in-LXC needs nesting + a couple of LXC tweaks |
| <a href="#docker-vm" class="font-medium underline underline-offset-4">Docker inside a VM</a> | Most isolated, no LXC quirks | Higher RAM/CPU overhead than LXC |


If you’re already a community-scripts user, **stick with the LXC path**. If you already run a Docker host VM on Proxmox, **just deploy the container there** like any other service. See <a href="/docs/guide/self-hosting/docker-compose/" class="font-medium underline underline-offset-4"><strong>Docker Compose</strong></a>.

## <span id="lxc"></span>1. LXC via community-scripts (recommended)

The <a href="https://community-scripts.github.io/ProxmoxVE/" class="font-medium underline underline-offset-4">community-scripts</a> project maintains an installer that creates a Debian 13 LXC, installs all dependencies, builds Wealthfolio from source, and registers a systemd service.

### Install

Open a shell on the **Proxmox host** (not inside an existing container) and run:

``` mb-4
bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/ct/wealthfolio.sh)"
```

The script prompts for resources. The defaults are sensible:


| Resource | Default | Notes |
|----|----|----|
| OS | Debian 13 |  |
| CPU | 4 cores | Used heavily during the initial Rust build, can be lowered after. |
| RAM | 4096 MB | Same: the build is the peak; ~256 MB at runtime. |
| Disk | 10 GB |  |
| Privileged | No | Unprivileged container |
| Port | 8080 | Note: the official Docker image uses 8088, this script uses 8080. |


When the script finishes:

- WebUI: `http://<lxc-ip>:8080`
- Login credentials: `/root/wealthfolio.creds` inside the container (`pct enter <vmid>` then `cat ~/wealthfolio.creds`)
- `WF_SECRET_KEY` is generated for you and persisted in `/etc/systemd/system/wealthfolio.service`. **Back this file up** along with `/opt/wealthfolio_data/`.

### Layout inside the LXC


| Path | Purpose |
|----|----|
| `/opt/wealthfolio` | Source + built static assets (`dist/`) |
| `/opt/wealthfolio_data/wealthfolio.db` | SQLite database |
| `/usr/local/bin/wealthfolio-server` | Compiled server binary |
| `/etc/systemd/system/wealthfolio.service` | Systemd unit (holds env vars including the key) |


### Updating

Re-run the installer one-liner. The script’s `update` path pulls the latest release tag, rebuilds, and restarts the service.


**Heads-up: long builds.** Wealthfolio doesn’t yet ship prebuilt Linux binaries, so each install/update compiles the Rust server from scratch (~15–25 min depending on CPU). Tracked in <a href="https://github.com/wealthfolio/wealthfolio/issues/563" class="font-medium underline underline-offset-4">#563</a>. The Docker paths below avoid this entirely.


### OIDC with a private CA

For a native LXC using an IdP behind a private CA, place the PEM CA bundle inside the LXC, for example `/etc/wealthfolio/internal-ca.pem`. Inspect `systemctl cat wealthfolio.service` to find the service’s `EnvironmentFile`, and add the following to that file. If the unit defines its environment inline instead, add the variable to the service’s environment configuration.

``` mb-4
WF_OIDC_CA_FILE=/etc/wealthfolio/internal-ca.pem
```

The bundle must be readable by the service’s configured `User` and protected against changes by untrusted users. Restart `wealthfolio.service` after changing the setting or replacing the bundle. If you edited the unit or a drop-in, run `systemctl daemon-reload` before restarting. Leave the setting unset when no private CA is needed.

See <a href="/docs/guide/self-hosting/configuration/#wf_oidc_ca_file" class="font-medium underline underline-offset-4"><code>WF_OIDC_CA_FILE</code></a> for supported server builds, startup failures, and browser trust requirements. Installing the CA only in the system trust store does not configure the OIDC client. For the Docker paths below, use the <a href="/docs/guide/self-hosting/docker-compose/#oidc-with-a-private-ca" class="font-medium underline underline-offset-4">read-only Compose mount</a> and a container path instead.

## <span id="docker-lxc"></span>2. Docker inside an LXC

If you already run a Docker-host LXC for other services, just add Wealthfolio to it. Otherwise, create a small unprivileged Debian/Ubuntu LXC first.

### LXC requirements for Docker

In the LXC’s config (`/etc/pve/lxc/<vmid>.conf` on the Proxmox host):

``` mb-4
features: nesting=1,keyctl=1
```

Unprivileged containers running storage-driver `overlay2` may also need:

``` mb-4
lxc.apparmor.profile: unconfined
lxc.cap.drop:
```

(Drop these only if you understand the security tradeoff. Privileged LXCs sidestep most of this but lose isolation.)

### Install Wealthfolio

Inside the LXC, install Docker + Compose, then follow the <a href="/docs/guide/self-hosting/docker-compose/" class="font-medium underline underline-offset-4"><strong>Docker Compose</strong></a> guide. Quick version:

``` mb-4
mkdir -p /opt/wealthfolio && cd /opt/wealthfolio

# Generate secrets
WF_SECRET_KEY=$(openssl rand -base64 32)
apt install -y argon2
WF_AUTH_PASSWORD_HASH=$(printf 'changeme' | argon2 yoursalt16chars! -id -e)

cat > .env <<EOF
WF_SECRET_KEY='${WF_SECRET_KEY}'
WF_AUTH_PASSWORD_HASH='${WF_AUTH_PASSWORD_HASH}'
WF_CORS_ALLOW_ORIGINS=http://$(hostname -I | awk '{print $1}'):8088
EOF
chmod 600 .env

curl -fsSL https://raw.githubusercontent.com/wealthfolio/wealthfolio/main/compose.yml -o compose.yml
docker compose --env-file .env up -d
```

WebUI: `http://<lxc-ip>:8088`. Data lives in the `wealthfolio-data` Docker volume.


**Upgrading from a pre-`v3.4.0` image?** The container now runs as non-root UID `1000`. Existing volumes were written by the old `root` image – chown once before starting the new image using the snippet below.


``` mb-4
# Compose prefixes the volume with the project name (the directory you ran
# `docker compose` from). Run `docker volume ls` to confirm – the name is
# usually `wealthfolio_wealthfolio-data`. Substitute it below if different.
docker compose down
docker run --rm -v wealthfolio_wealthfolio-data:/data alpine chown -R 1000:1000 /data
docker compose up -d
```

## <span id="docker-vm"></span>3. Docker inside a VM

Same flow as a normal Docker host. Nothing Proxmox-specific. Spin up a Debian/Ubuntu VM, install Docker, and follow <a href="/docs/guide/self-hosting/docker/" class="font-medium underline underline-offset-4"><strong>Docker</strong></a> or <a href="/docs/guide/self-hosting/docker-compose/" class="font-medium underline underline-offset-4"><strong>Docker Compose</strong></a>.

This is the right choice if you don’t want to fiddle with LXC nesting or if you’re already running a “docker VM” pattern.

## Reverse proxy

For HTTPS and a real domain, see <a href="/docs/guide/self-hosting/reverse-proxy/" class="font-medium underline underline-offset-4"><strong>Reverse proxy setup</strong></a>.

## Troubleshooting


| Symptom | Fix |
|----|----|
| LXC install fails near `cargo build` with OOM | Bump RAM to 6–8 GB during the build, drop it back after. |
| Docker container restarts: `WF_SECRET_KEY` missing | The variable wasn’t picked up. Check `.env` has single-quoted values. |
| Login screen rejects the right password | Hash captured a trailing newline (use `printf`, not `echo`) or `$` chars got eaten. |
| LXC runs but isn’t reachable on the LAN | Check the LXC’s network bridge and firewall; the service binds `0.0.0.0`. |


## Reference

- LXC installer source: <a href="https://github.com/community-scripts/ProxmoxVE/blob/main/ct/wealthfolio.sh" class="font-medium underline underline-offset-4">community-scripts/ProxmoxVE → ct/wealthfolio.sh</a>
- Build/install steps: <a href="https://github.com/community-scripts/ProxmoxVE/blob/main/install/wealthfolio-install.sh" class="font-medium underline underline-offset-4">community-scripts/ProxmoxVE → install/wealthfolio-install.sh</a>
- Prebuilt-binary tracking issue: <a href="https://github.com/wealthfolio/wealthfolio/issues/563" class="font-medium underline underline-offset-4">#563</a>


<a href="/docs/guide/self-hosting/unraid/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08]">Unraid</a> <a href="/docs/guide/self-hosting/coolify/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">Coolify</a>


On this page

- <a href="#a-idlxca1-lxc-via-community-scripts-recommended" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">1. LXC via community-scripts (recommended)</a>
  - <a href="#install" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Install</a>
  - <a href="#layout-inside-the-lxc" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Layout inside the LXC</a>
  - <a href="#updating" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Updating</a>
  - <a href="#oidc-with-a-private-ca" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">OIDC with a private CA</a>
- <a href="#a-iddocker-lxca2-docker-inside-an-lxc" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">2. Docker inside an LXC</a>
  - <a href="#lxc-requirements-for-docker" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">LXC requirements for Docker</a>
  - <a href="#install-wealthfolio" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Install Wealthfolio</a>
- <a href="#a-iddocker-vma3-docker-inside-a-vm" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">3. Docker inside a VM</a>
- <a href="#reverse-proxy" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Reverse proxy</a>
- <a href="#troubleshooting" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Troubleshooting</a>
- <a href="#reference" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Reference</a>


