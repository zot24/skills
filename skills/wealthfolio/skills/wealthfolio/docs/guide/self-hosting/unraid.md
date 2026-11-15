> Source: https://wealthfolio.app/docs/guide/self-hosting/unraid



Docs


Unraid


# Unraid

Install Wealthfolio on Unraid via Community Apps, with the official template covering ports, volumes, and required environment variables.


Last updated November 12, 2026


Wealthfolio runs as a standard Docker container on Unraid, configured through Unraid’s Docker tab. The Community Apps (CA) template covers ports, volumes, and required env vars. You just fill in the secrets.

## Prerequisites

- Unraid 6.10 or newer
- The **Community Applications** plugin
- A directory under `/mnt/user/appdata/` for persistent data (template defaults to `/mnt/user/appdata/wealthfolio`)

## Install from Community Apps

1.  Open the **Apps** tab in the Unraid web UI.
2.  Search for **Wealthfolio**.
3.  Click **Install**, fill in the required values below, click **Apply**.

That’s it. The container starts, and the WebUI is reachable at `http://<unraid-ip>:8088`.

## Manual sideload (power users)

If you want to test a newer template before CA picks it up, or run a template Squid hasn’t approved yet, sideload it directly from the project repo. SSH into Unraid (or use the WebTerminal):

``` mb-4
mkdir -p /boot/config/plugins/dockerMan/templates-user
curl -fsSL \
  https://raw.githubusercontent.com/wealthfolio/wealthfolio-unraid/main/templates/wealthfolio.xml \
  -o /boot/config/plugins/dockerMan/templates-user/my-wealthfolio.xml
```

Then in Unraid: **Docker → Add Container → Template dropdown → User templates → wealthfolio**.

## Required values


| Field | What to enter |
|----|----|
| **WebUI Port** | Host port to expose. Default `8088`. Change if it clashes. |
| **Appdata** | Leave at `/mnt/user/appdata/wealthfolio` unless you have a reason to move it. |
| **WF_SECRET_KEY** | `openssl rand -base64 32`. **Back this up**, losing it means losing all secrets. |
| **WF_AUTH_PASSWORD_HASH** | Argon2id PHC hash of your login password (see below). |
| **WF_CORS_ALLOW_ORIGINS** | The exact origin you’ll use, e.g. `http://192.168.1.10:8088`. |


### Generating the password hash

On any machine with `argon2` installed (`brew install argon2`, `apt install argon2`, or <a href="https://argon2.online" class="font-medium underline underline-offset-4">argon2.online</a>):

``` mb-4
printf 'your-password' | argon2 yoursalt16chars! -id -e
```

Copy the entire output (starts with `$argon2id$v=19$...`) into the `WF_AUTH_PASSWORD_HASH` field.


Unraid handles the `$` escaping for you, so paste the **raw** hash. Do not double the dollar signs like you would in a Compose `.env` file.


## OIDC with a private CA

For an IdP using a private CA, see <a href="/docs/guide/self-hosting/configuration/#wf_oidc_ca_file" class="font-medium underline underline-offset-4"><code>WF_OIDC_CA_FILE</code></a> for supported server builds and trust behavior. Leave this optional setting empty for ordinary installations.

In **Docker → wealthfolio → Edit**:

1.  Add a **Path** mapping from an existing host PEM CA bundle to `/certs/internal-ca.pem`, with access mode **Read Only**.
2.  Set the advanced variable `WF_OIDC_CA_FILE` to `/certs/internal-ca.pem`. If an older installed template does not show it, add it as a **Variable**.
3.  Make the bundle readable by the actual container user (`99:100` with the standard template). Keep it and its parent directory protected against unauthorized changes, then click **Apply** to recreate the container.

The variable uses the container path, not the Unraid host path. Restart the container after replacing the bundle. A missing, unreadable, or invalid bundle prevents startup when OIDC is enabled. Browser trust for the IdP is configured separately.

## Permissions

The image runs as a non-root user (UID `1000`) by default. The Unraid template overrides this with `--user=99:100` in `<ExtraParams>` so the container matches Unraid’s standard `nobody:users` appdata ownership. Fresh installs work without any host-side `chown`.


**Upgrading from a pre-`v3.4.0` image?** Older images ran as `root`, so existing data under `/mnt/user/appdata/wealthfolio` is owned by `root:root` and the new container can’t write to it. Run the chown below once on the Unraid host (via the WebTerminal or SSH), then start the container.


``` mb-4
chown -R 99:100 /mnt/user/appdata/wealthfolio
```

## Reverse proxy (SWAG, NPM, Traefik)

If you front Wealthfolio with a proxy:

- Set `WF_CORS_ALLOW_ORIGINS` to the public HTTPS URL.
- Forward to the container’s host port (default `8088`).
- Standard websocket / `Host` header proxying. No special config needed.
- If your proxy authenticates, set **WF_AUTH_REQUIRED** to `false` (advanced view) and clear `WF_AUTH_PASSWORD_HASH`.

See <a href="/docs/guide/self-hosting/reverse-proxy/" class="font-medium underline underline-offset-4"><strong>Reverse proxy setup</strong></a> for full examples.

## Backups

Everything lives in the appdata volume:

- `wealthfolio.db`: your portfolio data
- `secrets.json`: encrypted with `WF_SECRET_KEY`

Back up the volume **and** the secret key together. Either alone is useless. Tools like CA Backup / Restore Appdata work fine.

## Updating

In the **Docker** tab, click the container → **Force Update**. The template tracks `wealthfolio/wealthfolio:latest`; switch the **Repository** field to a specific tag (e.g. `wealthfolio/wealthfolio:3.3.0`) for production stability.

## Troubleshooting


| Symptom | Likely cause |
|----|----|
| Container restart loop, log says `WF_SECRET_KEY` missing | The variable wasn’t set, or isn’t 32 bytes when base64-decoded. Regenerate with `openssl rand -base64 32`. |
| Login screen rejects correct password | Hash was generated with `echo -n` (trailing newline) or pasted with extra whitespace. Regenerate with `printf`. |
| CORS errors in browser console | `WF_CORS_ALLOW_ORIGINS` doesn’t match the URL in your address bar (scheme + host + port must match exactly). |
| Port already in use | Change the **WebUI Port** field to a free host port. |
| Container restart loop, log says `Permission denied` on `/data` | Upgrading from a pre-`v3.4.0` image. Run `chown -R 99:100 /mnt/user/appdata/wealthfolio` once on the Unraid host. |


## Configuration reference

Every variable the container reads is documented in <a href="/docs/guide/self-hosting/configuration/" class="font-medium underline underline-offset-4"><strong>Configuration</strong></a>.


<a href="/docs/guide/self-hosting/docker-compose/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08]">Docker Compose</a> <a href="/docs/guide/self-hosting/proxmox/" class="inline-flex h-10 items-center rounded-full bg-tile px-5 text-sm font-medium transition-colors hover:bg-foreground/[0.06] dark:hover:bg-white/[0.08] ml-auto">Proxmox</a>


On this page

- <a href="#prerequisites" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Prerequisites</a>
- <a href="#install-from-community-apps" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Install from Community Apps</a>
- <a href="#manual-sideload-power-users" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Manual sideload (power users)</a>
- <a href="#required-values" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Required values</a>
  - <a href="#generating-the-password-hash" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Generating the password hash</a>
- <a href="#oidc-with-a-private-ca" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">OIDC with a private CA</a>
- <a href="#permissions" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Permissions</a>
- <a href="#reverse-proxy-swag-npm-traefik" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Reverse proxy (SWAG, NPM, Traefik)</a>
- <a href="#backups" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Backups</a>
- <a href="#updating" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Updating</a>
- <a href="#troubleshooting" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Troubleshooting</a>
- <a href="#configuration-reference" class="inline-block leading-snug no-underline transition-colors text-muted-foreground/80 hover:text-foreground">Configuration reference</a>


