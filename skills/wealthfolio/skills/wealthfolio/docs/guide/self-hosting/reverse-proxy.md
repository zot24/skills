> Source: https://wealthfolio.app/docs/guide/self-hosting/reverse-proxy

For anything beyond LAN access, put Wealthfolio behind a reverse proxy.
The container speaks plain HTTP on port `8088`. Your proxy terminates
TLS and adds the niceties (HSTS, gzip, access logs).

## Before you start

Whichever proxy you use, two settings on Wealthfolio matter:

1. **`WF_CORS_ALLOW_ORIGINS`** must match the **public** URL you'll
   access the app from. Scheme, host, and port all have to match
   exactly.
2. **`WF_LISTEN_ADDR=0.0.0.0:8088`** so the proxy can reach the
   container. (Already the default in our compose / Unraid templates.)

If your proxy handles authentication (Authentik, Authelia, Cloudflare
Access, Coolify built-in), set `WF_AUTH_REQUIRED=false` and clear
`WF_AUTH_PASSWORD_HASH`.

If you use the official Compose files and your proxy runs on the same
Docker network, start Wealthfolio with the proxy override:

```bash
docker compose --env-file .env -f compose.yml -f compose.proxy.yml up -d
```

That removes the host port publish and keeps Wealthfolio reachable only
to containers on the Docker network at `http://wealthfolio:8088`.

## Caddy

Caddy is the simplest path: automatic HTTPS via Let's Encrypt, zero
config beyond the domain.

```caddyfile
wealthfolio.example.com {
    reverse_proxy localhost:8088
}
```

Or, if Wealthfolio is on the same Docker network as Caddy:

```caddyfile
wealthfolio.example.com {
    reverse_proxy wealthfolio:8088
}
```

Then in your Wealthfolio env: `WF_CORS_ALLOW_ORIGINS=https://wealthfolio.example.com`.

## Nginx

```nginx
server {
    listen 443 ssl http2;
    server_name wealthfolio.example.com;

    ssl_certificate     /etc/letsencrypt/live/wealthfolio.example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/wealthfolio.example.com/privkey.pem;

    # Optional but recommended
    add_header Strict-Transport-Security "max-age=31536000" always;
    client_max_body_size 25M;

    location / {
        proxy_pass http://localhost:8088;
        proxy_http_version 1.1;
        proxy_set_header Host              $host;
        proxy_set_header X-Real-IP         $remote_addr;
        proxy_set_header X-Forwarded-For   $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Upgrade           $http_upgrade;
        proxy_set_header Connection        "upgrade";
        proxy_read_timeout 60s;
    }
}

server {
    listen 80;
    server_name wealthfolio.example.com;
    return 301 https://$host$request_uri;
}
```

## Traefik (Docker labels)

Add labels to your Wealthfolio container in `compose.yml` (or
`compose.override.yml`):

```yaml
services:
  wealthfolio:
    image: wealthfolio/wealthfolio:latest
    networks:
      - traefik
    labels:
      - traefik.enable=true
      - traefik.http.routers.wealthfolio.rule=Host(`wealthfolio.example.com`)
      - traefik.http.routers.wealthfolio.entrypoints=websecure
      - traefik.http.routers.wealthfolio.tls.certresolver=letsencrypt
      - traefik.http.services.wealthfolio.loadbalancer.server.port=8088
      # Optional HTTP→HTTPS redirect
      - traefik.http.routers.wealthfolio-http.rule=Host(`wealthfolio.example.com`)
      - traefik.http.routers.wealthfolio-http.entrypoints=web
      - traefik.http.routers.wealthfolio-http.middlewares=https-redirect
      - traefik.http.middlewares.https-redirect.redirectscheme.scheme=https

networks:
  traefik:
    external: true
```

## Nginx Proxy Manager (NPM)

NPM's UI flow:

1. **Hosts → Proxy Hosts → Add Proxy Host**.
2. **Domain Names**: `wealthfolio.example.com`
3. **Forward Hostname / IP**: `wealthfolio` (Docker network) or your LAN
   IP
4. **Forward Port**: `8088`
5. ✅ **Block Common Exploits**
6. ✅ **Websockets Support**
7. **SSL tab**: request a new Let's Encrypt cert, enable Force SSL +
   HTTP/2.
8. Save.

## SWAG (LinuxServer.io)

If you run SWAG, drop a config file at
`/config/nginx/proxy-confs/wealthfolio.subdomain.conf`:

```nginx
server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name wealthfolio.*;
    include /config/nginx/ssl.conf;

    location / {
        include /config/nginx/proxy.conf;
        include /config/nginx/resolver.conf;
        set $upstream_app wealthfolio;
        set $upstream_port 8088;
        set $upstream_proto http;
        proxy_pass $upstream_proto://$upstream_app:$upstream_port;
    }
}
```

Then make sure SWAG and the Wealthfolio container share a Docker
network.

## Cloudflare Tunnel

If you don't want to open ports at all, use Cloudflare Tunnel
(`cloudflared`):

1. Install `cloudflared` on the host running Wealthfolio.
2. `cloudflared tunnel create wealthfolio`
3. Map a public hostname to `http://localhost:8088`.

Set `WF_CORS_ALLOW_ORIGINS=https://wealthfolio.example.com`. Cloudflare
handles TLS at the edge.

<Callout type="warning">
  Cloudflare Tunnel proxies through Cloudflare's network. If you've enabled Cloudflare Access in
  front, set `WF_AUTH_REQUIRED=false` and rely on Access. Otherwise you'll have two auth layers and
  possible cookie conflicts.
</Callout>

## Common gotchas

| Issue                           | Fix                                                                                                      |
| ------------------------------- | -------------------------------------------------------------------------------------------------------- |
| `502 Bad Gateway`               | Container isn't reachable from the proxy. Check the upstream host/port and that they share a network.    |
| `CORS error` in browser console | `WF_CORS_ALLOW_ORIGINS` must match the URL in your address bar exactly. Add the scheme (`https://`).     |
| Session lost after a few clicks | Proxy isn't forwarding cookies properly. Make sure `proxy_set_header Host $host` (or equivalent) is set. |
| Login screen loops              | Mixed content: proxy serves HTTPS but `WF_CORS_ALLOW_ORIGINS` is still `http://...`. Update both.        |

## After the proxy is up

If you set up authentication-at-the-edge (Authentik, Authelia, etc.),
disable Wealthfolio's built-in auth so users only log in once:

```
WF_AUTH_REQUIRED=false
WF_AUTH_PASSWORD_HASH=
```
