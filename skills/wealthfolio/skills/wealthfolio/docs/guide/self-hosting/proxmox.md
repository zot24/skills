> Source: https://wealthfolio.app/docs/guide/self-hosting/proxmox

There are three sensible ways to run Wealthfolio on Proxmox. Pick based
on how you already run other services.

| Approach                            | Pros                                                                         | Cons                                                                                                                                     |
| ----------------------------------- | ---------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| [LXC via community-scripts](#lxc)   | Native execution, lowest overhead, fits the Proxmox idiom (no Docker-in-LXC) | Builds from source (~15–25 min on a typical homelab CPU on first install, [#563](https://github.com/wealthfolio/wealthfolio/issues/563)) |
| [Docker inside an LXC](#docker-lxc) | Fast install (image pull only), easy updates                                 | Docker-in-LXC needs nesting + a couple of LXC tweaks                                                                                     |
| [Docker inside a VM](#docker-vm)    | Most isolated, no LXC quirks                                                 | Higher RAM/CPU overhead than LXC                                                                                                         |

If you're already a community-scripts user, **stick with the LXC path**.
If you already run a Docker host VM on Proxmox, **just deploy the
container there** like any other service. See
[**Docker Compose**](/docs/guide/self-hosting/docker-compose).

## <a id="lxc"></a>1. LXC via community-scripts (recommended)

The [community-scripts](https://community-scripts.github.io/ProxmoxVE/)
project maintains an installer that creates a Debian 13 LXC, installs
all dependencies, builds Wealthfolio from source, and registers a
systemd service.

### Install

Open a shell on the **Proxmox host** (not inside an existing container)
and run:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/ct/wealthfolio.sh)"
```

The script prompts for resources. The defaults are sensible:

| Resource   | Default   | Notes                                                             |
| ---------- | --------- | ----------------------------------------------------------------- |
| OS         | Debian 13 |                                                                   |
| CPU        | 4 cores   | Used heavily during the initial Rust build, can be lowered after. |
| RAM        | 4096 MB   | Same: the build is the peak; ~256 MB at runtime.                  |
| Disk       | 10 GB     |                                                                   |
| Privileged | No        | Unprivileged container                                            |
| Port       | 8080      | Note: the official Docker image uses 8088, this script uses 8080. |

When the script finishes:

- WebUI: `http://<lxc-ip>:8080`
- Login credentials: `/root/wealthfolio.creds` inside the container
  (`pct enter <vmid>` then `cat ~/wealthfolio.creds`)
- `WF_SECRET_KEY` is generated for you and persisted in
  `/etc/systemd/system/wealthfolio.service`. **Back this file up** along
  with `/opt/wealthfolio_data/`.

### Layout inside the LXC

| Path                                      | Purpose                                         |
| ----------------------------------------- | ----------------------------------------------- |
| `/opt/wealthfolio`                        | Source + built static assets (`dist/`)          |
| `/opt/wealthfolio_data/wealthfolio.db`    | SQLite database                                 |
| `/usr/local/bin/wealthfolio-server`       | Compiled server binary                          |
| `/etc/systemd/system/wealthfolio.service` | Systemd unit (holds env vars including the key) |

### Updating

Re-run the installer one-liner. The script's `update` path pulls the
latest release tag, rebuilds, and restarts the service.

<Callout type="warning">
  **Heads-up: long builds.** Wealthfolio doesn't yet ship prebuilt Linux binaries, so each
  install/update compiles the Rust server from scratch (~15–25 min depending on CPU). Tracked in
  [#563](https://github.com/wealthfolio/wealthfolio/issues/563). The Docker paths below avoid this
  entirely.
</Callout>

## <a id="docker-lxc"></a>2. Docker inside an LXC

If you already run a Docker-host LXC for other services, just add
Wealthfolio to it. Otherwise, create a small unprivileged Debian/Ubuntu
LXC first.

### LXC requirements for Docker

In the LXC's config (`/etc/pve/lxc/<vmid>.conf` on the Proxmox host):

```
features: nesting=1,keyctl=1
```

Unprivileged containers running storage-driver `overlay2` may also
need:

```
lxc.apparmor.profile: unconfined
lxc.cap.drop:
```

(Drop these only if you understand the security tradeoff. Privileged
LXCs sidestep most of this but lose isolation.)

### Install Wealthfolio

Inside the LXC, install Docker + Compose, then follow the
[**Docker Compose**](/docs/guide/self-hosting/docker-compose) guide.
Quick version:

```bash
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

WebUI: `http://<lxc-ip>:8088`. Data lives in the `wealthfolio-data`
Docker volume.

<Callout type="warning">
  **Upgrading from a pre-`v3.4.0` image?** The container now runs as non-root UID `1000`. Existing
  volumes were written by the old `root` image — chown once before starting the new image using the
  snippet below.
</Callout>

```bash
# Compose prefixes the volume with the project name (the directory you ran
# `docker compose` from). Run `docker volume ls` to confirm — the name is
# usually `wealthfolio_wealthfolio-data`. Substitute it below if different.
docker compose down
docker run --rm -v wealthfolio_wealthfolio-data:/data alpine chown -R 1000:1000 /data
docker compose up -d
```

## <a id="docker-vm"></a>3. Docker inside a VM

Same flow as a normal Docker host. Nothing Proxmox-specific.
Spin up a Debian/Ubuntu VM, install Docker, and follow
[**Docker**](/docs/guide/self-hosting/docker) or
[**Docker Compose**](/docs/guide/self-hosting/docker-compose).

This is the right choice if you don't want to fiddle with LXC nesting
or if you're already running a "docker VM" pattern.

## Reverse proxy

For HTTPS and a real domain, see
[**Reverse proxy setup**](/docs/guide/self-hosting/reverse-proxy).

## Troubleshooting

| Symptom                                            | Fix                                                                                 |
| -------------------------------------------------- | ----------------------------------------------------------------------------------- |
| LXC install fails near `cargo build` with OOM      | Bump RAM to 6–8 GB during the build, drop it back after.                            |
| Docker container restarts: `WF_SECRET_KEY` missing | The variable wasn't picked up. Check `.env` has single-quoted values.               |
| Login screen rejects the right password            | Hash captured a trailing newline (use `printf`, not `echo`) or `$` chars got eaten. |
| LXC runs but isn't reachable on the LAN            | Check the LXC's network bridge and firewall; the service binds `0.0.0.0`.           |

## Reference

- LXC installer source:
  [community-scripts/ProxmoxVE → ct/wealthfolio.sh](https://github.com/community-scripts/ProxmoxVE/blob/main/ct/wealthfolio.sh)
- Build/install steps:
  [community-scripts/ProxmoxVE → install/wealthfolio-install.sh](https://github.com/community-scripts/ProxmoxVE/blob/main/install/wealthfolio-install.sh)
- Prebuilt-binary tracking issue:
  [#563](https://github.com/wealthfolio/wealthfolio/issues/563)
