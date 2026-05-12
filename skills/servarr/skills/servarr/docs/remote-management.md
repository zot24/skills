<!-- Source: Authored — patterns for managing media stack from laptop to NAS -->

# Remote Management (Laptop → NAS)

Patterns for managing your media stack on a home server/NAS from a local laptop.

## SSH Tunneling

Forward all *arr app ports through a single SSH connection:

```bash
# Forward all common ports
ssh -N \
  -L 8989:localhost:8989 \
  -L 7878:localhost:7878 \
  -L 8686:localhost:8686 \
  -L 9696:localhost:9696 \
  -L 8080:localhost:8080 \
  -L 6767:localhost:6767 \
  -L 32400:localhost:32400 \
  -L 5055:localhost:5055 \
  user@nas-ip
```

Then access apps at `http://localhost:PORT` from your laptop.

### SSH Config for Convenience

```
# ~/.ssh/config
Host nas
    HostName 192.168.1.100
    User your-user
    LocalForward 8989 localhost:8989
    LocalForward 7878 localhost:7878
    LocalForward 8686 localhost:8686
    LocalForward 9696 localhost:9696
    LocalForward 8080 localhost:8080
    LocalForward 6767 localhost:6767
    LocalForward 32400 localhost:32400
    LocalForward 5055 localhost:5055
```

Then: `ssh -N nas` to open all tunnels.

## Tailscale (Recommended)

Zero-config VPN that gives your NAS a stable IP accessible from anywhere:

```bash
# On the NAS
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up

# Access apps via Tailscale IP
curl -H "X-Api-Key: $KEY" http://100.x.y.z:8989/api/v3/series
```

Benefits:
- No port forwarding needed
- Works from anywhere (not just home network)
- Encrypted by default
- Stable IPs even if home network changes

## Reverse Proxy (Caddy/Nginx)

For HTTPS access with domain names:

```
# Caddyfile
sonarr.home.example.com {
    reverse_proxy localhost:8989
}
radarr.home.example.com {
    reverse_proxy localhost:7878
}
plex.home.example.com {
    reverse_proxy localhost:32400
}
```

## API Scripts from Laptop

Store credentials locally and use them for remote API calls:

```bash
# ~/.config/servarr/env
export NAS_HOST="192.168.1.100"  # or Tailscale IP
export SONARR_KEY="abc123..."
export RADARR_KEY="def456..."
export PROWLARR_KEY="ghi789..."
export PLEX_TOKEN="xyz..."

# Source before using
source ~/.config/servarr/env

# Quick status check
for app in sonarr:8989 radarr:7878 lidarr:8686 prowlarr:9696; do
    name=${app%%:*}
    port=${app##*:}
    api_ver="v3"
    [[ "$name" == "lidarr" || "$name" == "prowlarr" ]] && api_ver="v1"
    key_var="${name^^}_KEY"
    status=$(curl -s -H "X-Api-Key: ${!key_var}" "http://$NAS_HOST:$port/api/$api_ver/system/status" | jq -r '.version // "DOWN"')
    echo "$name: $status"
done
```

## Docker Compose Remote Management

```bash
# Run docker-compose commands on the NAS
ssh nas "cd /path/to/media-stack && docker compose ps"
ssh nas "cd /path/to/media-stack && docker compose restart sonarr"
ssh nas "cd /path/to/media-stack && docker compose logs -f radarr --tail=50"
ssh nas "cd /path/to/media-stack && docker compose pull && docker compose up -d"
```

## Health Check Script

```bash
#!/bin/bash
# check-stack.sh — quick health check from laptop
source ~/.config/servarr/env

echo "=== Media Stack Health ==="
for app in sonarr:8989:v3 radarr:7878:v3 lidarr:8686:v1 prowlarr:9696:v1; do
    IFS=: read -r name port ver <<< "$app"
    key_var="${name^^}_KEY"
    health=$(curl -sf -H "X-Api-Key: ${!key_var}" \
        "http://$NAS_HOST:$port/api/$ver/health" 2>/dev/null)
    if [ $? -eq 0 ]; then
        issues=$(echo "$health" | jq 'length')
        echo "  $name: OK ($issues warnings)"
    else
        echo "  $name: UNREACHABLE"
    fi
done

# Plex
plex_status=$(curl -sf "http://$NAS_HOST:32400/identity?X-Plex-Token=$PLEX_TOKEN" 2>/dev/null)
if [ $? -eq 0 ]; then
    echo "  plex: OK"
else
    echo "  plex: UNREACHABLE"
fi
```
