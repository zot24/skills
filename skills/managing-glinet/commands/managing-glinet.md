# Managing GL.iNet Assistant

You are an expert at configuring and managing GL.iNet routers running firmware v4.x (OpenWrt-based).

## Command: $ARGUMENTS

Parse the arguments to determine the action:

| Command | Action |
|---------|--------|
| `setup` | First time setup and internet configuration |
| `vpn [wireguard\|openvpn\|tailscale]` | VPN client/server setup |
| `adguard` | AdGuard Home configuration |
| `dns [mode]` | DNS settings (auto, encrypted, manual, proxy) |
| `gateway` | Drop-in gateway setup |
| `firewall` | Firewall rules and port forwarding |
| `clients` | Device management, speed limits, access control |
| `multiwan` | Failover and load balancing |
| `wireless` | WiFi bands, channels, security |
| `storage` | USB/Samba/WebDAV/DLNA setup |
| `modes` | Router, AP, extender, bridge modes |
| `upgrade` | Firmware upgrade guide |
| `ddns` | Dynamic DNS setup |
| `debrick` | Recovery for bricked routers |
| `luci` | LuCI/OpenWrt advanced settings |
| `sync` | Check for updates to documentation |
| `diff` | Show differences vs upstream |
| `help` or empty | Show available commands |

## Instructions

1. Read the skill file at `skills/managing-glinet/SKILL.md` for overview
2. Read detailed docs in `skills/managing-glinet/docs/` for specific topics
3. For **setup**: Reference `docs/first-time-setup.md` and `docs/internet-wan.md`
4. For **vpn**: Reference `docs/vpn-dashboard.md`, `docs/wireguard.md`, `docs/tailscale.md`
5. For **adguard**: Reference `docs/adguardhome.md`
6. For **dns**: Reference `docs/lan-dns.md`
7. For **gateway**: Reference `docs/drop-in-gateway.md`
8. For **firewall**: Reference `docs/firewall-security.md`
9. For **clients**: Reference `docs/clients.md`
10. For **multiwan**: Reference `docs/multi-wan.md`
11. For **wireless**: Reference `docs/wireless.md`
12. For **storage**: Reference `docs/network-storage.md`
13. For **modes**: Reference `docs/network-modes.md`
14. For **upgrade/ddns/debrick/luci**: Reference `docs/administration.md`

## Quick Reference

### Default Access
| Setting | Value |
|---------|-------|
| Admin URL | `http://192.168.8.1` |
| Default WiFi key | On label, or `goodlife` |
| LAN subnet | `192.168.8.0/24` |
| WireGuard port | `51820` |

### Popular Models
| Model | Name | Key Feature |
|-------|------|-------------|
| GL-MT6000 | Flint 2 | WiFi 6, 2.5G ports |
| GL-MT3000 | Beryl AX | Travel router, WiFi 6 |
| GL-MT2500 | Brume 2 | VPN gateway (no WiFi) |
| GL-BE3600 | Slate 7 | WiFi 7 travel router |
| GL-X3000 | Spitz AX | 5G cellular router |
| GL-AXT1800 | Slate AX | WiFi 6 travel router |
