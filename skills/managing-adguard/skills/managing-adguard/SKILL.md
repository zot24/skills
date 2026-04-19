---
name: managing-adguard
description: Deploy, configure, and manage AdGuard Home — network-wide DNS ad blocking, HTTPS filtering, DHCP, client management, and API automation. Use when setting up AdGuard Home, managing blocklists, configuring DNS, troubleshooting filtering, or automating via the REST API. Triggers on mentions of AdGuard, ad blocking, DNS filtering, blocklist, allowlist, Pi-hole alternative, network ad blocker.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# Managing AdGuard Home

Expert at deploying and managing AdGuard Home for network-wide ad blocking and DNS filtering.

## Overview

- **DNS filtering** — Block ads, trackers, and malware at the DNS level for all devices
- **HTTPS filtering** — Encrypted DNS (DoH, DoT, DoQ, DNSCrypt)
- **Blocklists** — Curate and manage filter lists
- **Client management** — Per-client rules, tags, and upstream DNS
- **DHCP server** — Built-in DHCP to replace your router's
- **REST API** — Full automation via HTTP API
- **Docker deployment** — Standard or host-network mode

## Quick Start

```yaml
# docker-compose.yml
services:
  adguardhome:
    image: adguard/adguardhome
    container_name: adguardhome
    ports:
      - "53:53/tcp"
      - "53:53/udp"
      - "3000:3000/tcp"  # Setup wizard (becomes 80 after)
      - "80:80/tcp"      # Web UI
      - "443:443/tcp"    # HTTPS
      - "853:853/tcp"    # DNS-over-TLS
    volumes:
      - ./adguard/work:/opt/adguardhome/work
      - ./adguard/conf:/opt/adguardhome/conf
    restart: unless-stopped
```

Then visit `http://HOST:3000` for the setup wizard.

## API Pattern

```bash
# All API calls use basic auth
curl -u admin:password http://HOST/control/status

# Check if a domain is filtered
curl -u admin:password "http://HOST/control/filtering/check_host?name=doubleclick.net"

# Block a domain
curl -u admin:password -X POST http://HOST/control/filtering/add_url \
  -H "Content-Type: application/json" \
  -d '{"name": "Custom Block", "url": "||malware.com^", "whitelist": false}'

# Toggle protection
curl -u admin:password -X POST http://HOST/control/dns_config \
  -H "Content-Type: application/json" \
  -d '{"protection_enabled": true}'
```

## Core Concepts

**Upstream DNS** — Where AdGuard forwards non-blocked queries. Recommended: `https://dns.cloudflare.com/dns-query` or `tls://dns.google`.

**Filter Lists** — Block rules applied to all DNS queries. Default lists block ads and trackers. Add more for malware, adult content, social tracking.

**Client Settings** — Override global settings per device. Assign devices by IP, MAC, or CIDR. Set custom upstream DNS, blocklists, or safe search per client.

**Rewrites** — Custom DNS answers. Map `myservice.local` to a specific IP.

## Documentation

- **[Getting Started](docs/getting-started.md)** — Installation and initial setup
- **[Configuration](docs/configuration.md)** — YAML config reference
- **[Docker Setup](docs/docker.md)** — Container deployment patterns
- **[DNS Encryption](docs/encryption.md)** — DoH, DoT, DoQ, DNSCrypt setup
- **[DHCP Server](docs/dhcp.md)** — Built-in DHCP configuration
- **[Client Management](docs/clients.md)** — Per-client rules and tags
- **[VPS Deployment](docs/vps.md)** — Running on a VPS
- **[FAQ](docs/faq.md)** — Common questions and solutions
- **[API Reference](docs/api-reference.md)** — REST API endpoints
- **[Blocklists Guide](docs/blocklists.md)** — Recommended filter lists
- **[Upstream README](docs/readme-upstream.md)** — Full project documentation

## Common Workflows

### Recommended blocklists
```
# In Settings → Filters → DNS blocklists, add:
https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt  # AdGuard DNS filter
https://adguardteam.github.io/HostlistsRegistry/assets/filter_2.txt  # AdAway Default
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt  # HaGeZi Pro
```

### Set up DNS-over-HTTPS
Settings → Encryption → Enable HTTPS, provide cert and key, set server name.

### Point your network at AdGuard
Set your router's DNS to AdGuard Home's IP, or use DHCP mode.

## Upstream Sources

- **Repository**: https://github.com/AdguardTeam/AdGuardHome
- **Wiki**: https://github.com/AdguardTeam/AdGuardHome/wiki
- **API Docs**: `http://YOUR_HOST/control/` (Swagger UI built-in)

## Sync & Update

When user runs `sync`: fetch latest wiki pages, update docs/.
When user runs `diff`: compare current vs upstream, report changes.
