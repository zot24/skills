> Source: https://wealthfolio.app/docs/guide/self-hosting/unraid

Wealthfolio runs as a standard Docker container on Unraid, configured
through Unraid's Docker tab. The Community Apps (CA) template covers
ports, volumes, and required env vars. You just fill in the secrets.

## Prerequisites

- Unraid 6.10 or newer
- The **Community Applications** plugin
- A directory under `/mnt/user/appdata/` for persistent data (template
  defaults to `/mnt/user/appdata/wealthfolio`)

## Install from Community Apps

1. Open the **Apps** tab in the Unraid web UI.
2. Search for **Wealthfolio**.
3. Click **Install**, fill in the required values below, click **Apply**.

That's it. The container starts, and the WebUI is reachable at
`http://<unraid-ip>:8088`.

## Manual sideload (power users)

If you want to test a newer template before CA picks it up, or run a
template Squid hasn't approved yet, sideload it directly from the
project repo. SSH into Unraid (or use the WebTerminal):

```bash
mkdir -p /boot/config/plugins/dockerMan/templates-user
curl -fsSL \
  https://raw.githubusercontent.com/wealthfolio/wealthfolio/main/docs/self-host/unraid/template.xml \
  -o /boot/config/plugins/dockerMan/templates-user/my-wealthfolio.xml
```

Then in Unraid: **Docker → Add Container → Template dropdown → User
templates → wealthfolio**.

## Required values

| Field                     | What to enter                                                                    |
| ------------------------- | -------------------------------------------------------------------------------- |
| **WebUI Port**            | Host port to expose. Default `8088`. Change if it clashes.                       |
| **Appdata**               | Leave at `/mnt/user/appdata/wealthfolio` unless you have a reason to move it.    |
| **WF_SECRET_KEY**         | `openssl rand -base64 32`. **Back this up**, losing it means losing all secrets. |
| **WF_AUTH_PASSWORD_HASH** | Argon2id PHC hash of your login password (see below).                            |
| **WF_CORS_ALLOW_ORIGINS** | The exact origin you'll use, e.g. `http://192.168.1.10:8088`.                    |

### Generating the password hash

On any machine with `argon2` installed (`brew install argon2`,
`apt install argon2`, or [argon2.online](https://argon2.online)):

```bash
printf 'your-password' | argon2 yoursalt16chars! -id -e
```

Copy the entire output (starts with `$argon2id$v=19$...`) into the
`WF_AUTH_PASSWORD_HASH` field.

<Callout type="info">
  Unraid handles the `$` escaping for you, so paste the **raw** hash. Do not double the dollar signs
  like you would in a Compose `.env` file.
</Callout>

## Permissions

The image runs as a non-root user (UID `1000`) by default. The Unraid
template overrides this with `--user=99:100` in `<ExtraParams>` so the
container matches Unraid's standard `nobody:users` appdata ownership.
Fresh installs work without any host-side `chown`.

<Callout type="warning">
  **Upgrading from a pre-`v3.4.0` image?** Older images ran as `root`, so existing data under
  `/mnt/user/appdata/wealthfolio` is owned by `root:root` and the new container can't write to it.
  Run the chown below once on the Unraid host (via the WebTerminal or SSH), then start the
  container.
</Callout>

```bash
chown -R 99:100 /mnt/user/appdata/wealthfolio
```

## Reverse proxy (SWAG, NPM, Traefik)

If you front Wealthfolio with a proxy:

- Set `WF_CORS_ALLOW_ORIGINS` to the public HTTPS URL.
- Forward to the container's host port (default `8088`).
- Standard websocket / `Host` header proxying. No special config needed.
- If your proxy authenticates, set **WF_AUTH_REQUIRED** to `false`
  (advanced view) and clear `WF_AUTH_PASSWORD_HASH`.

See [**Reverse proxy setup**](/docs/guide/self-hosting/reverse-proxy)
for full examples.

## Backups

Everything lives in the appdata volume:

- `wealthfolio.db`: your portfolio data
- `secrets.json`: encrypted with `WF_SECRET_KEY`

Back up the volume **and** the secret key together. Either alone is
useless. Tools like CA Backup / Restore Appdata work fine.

## Updating

In the **Docker** tab, click the container → **Force Update**. The
template tracks `wealthfolio/wealthfolio:latest`; switch the **Repository**
field to a specific tag (e.g. `wealthfolio/wealthfolio:3.3.0`) for production
stability.

## Troubleshooting

| Symptom                                                         | Likely cause                                                                                                      |
| --------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- |
| Container restart loop, log says `WF_SECRET_KEY` missing        | The variable wasn't set, or isn't 32 bytes when base64-decoded. Regenerate with `openssl rand -base64 32`.        |
| Login screen rejects correct password                           | Hash was generated with `echo -n` (trailing newline) or pasted with extra whitespace. Regenerate with `printf`.   |
| CORS errors in browser console                                  | `WF_CORS_ALLOW_ORIGINS` doesn't match the URL in your address bar (scheme + host + port must match exactly).      |
| Port already in use                                             | Change the **WebUI Port** field to a free host port.                                                              |
| Container restart loop, log says `Permission denied` on `/data` | Upgrading from a pre-`v3.4.0` image. Run `chown -R 99:100 /mnt/user/appdata/wealthfolio` once on the Unraid host. |

## Configuration reference

Every variable the container reads is documented in
[**Configuration**](/docs/guide/self-hosting/configuration).
