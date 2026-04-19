---
name: managing-glinet
description: Configure and manage GL.iNet routers — VPN (WireGuard, OpenVPN, Tailscale), AdGuard Home, DNS, multi-WAN failover, drop-in gateway, firewall, and network modes. Use when setting up or configuring a GL.iNet router, travel router, or OpenWrt-based networking. Triggers on mentions of GL.iNet, GL-iNet, Flint, Beryl, Slate, Brume, Spitz, Mudi, Marble, travel router, WireGuard router, drop-in gateway.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# Managing GL.iNet Routers

Expert at configuring GL.iNet routers running firmware v4.x (OpenWrt-based).

## Overview

- **VPN Client/Server** — WireGuard, OpenVPN with 10+ integrated providers, policy-based routing
- **AdGuard Home** — Built-in network-wide ad blocking on supported models
- **Multi-WAN** — Failover and load balancing across Ethernet, WiFi repeater, tethering, cellular
- **Drop-in Gateway** — Add VPN/AdGuard to existing network without replacing primary router
- **Network Modes** — Router, Access Point, Extender, Bridge, WDS
- **Tailscale / ZeroTier** — Mesh VPN integration for remote access
- **Network Storage** — USB/SD shared via Samba, WebDAV, DLNA
- **LuCI** — Full OpenWrt advanced configuration access

## Quick Start

1. Connect to router WiFi (SSID on bottom label, default key: `goodlife`)
2. Browse to `http://192.168.8.1`
3. Set admin password → configure internet connection
4. Default ports: Web UI `80/443`, DNS `53`, WireGuard `51820`

## Core Concepts

**VPN Dashboard** — Central hub for managing VPN connections. Supports Global Mode (all traffic through one tunnel) and Policy Mode (up to 5 tunnels with per-device/per-domain routing rules). Kill switch blocks traffic if VPN drops.

**Drop-in Gateway** — Place GL.iNet router between existing router and devices. Adds VPN, AdGuard, encrypted DNS without changing existing network. Connect primary router LAN → GL.iNet WAN.

**Network Modes** — Router (default, full features), Access Point (wireless bridge, no NAT), Extender (wireless repeater), Bridge (transparent switch). Only Router mode supports VPN/AdGuard/firewall.

## Documentation

- **[First Time Setup](docs/first-time-setup.md)** — Initial configuration guide
- **[Internet & WAN](docs/internet-wan.md)** — Ethernet, repeater, tethering, cellular
- **[Wireless](docs/wireless.md)** — WiFi bands, channels, security, mesh/MLO
- **[LAN & DNS](docs/lan-dns.md)** — LAN settings, DHCP, DNS modes, encrypted DNS
- **[VPN Dashboard](docs/vpn-dashboard.md)** — Global/policy mode, kill switch, tunnels
- **[WireGuard](docs/wireguard.md)** — Client and server setup
- **[Tailscale](docs/tailscale.md)** — Mesh VPN remote access
- **[AdGuard Home](docs/adguardhome.md)** — Built-in ad blocking setup
- **[Firewall & Security](docs/firewall-security.md)** — Port forwarding, DMZ, firewall rules
- **[Network Modes](docs/network-modes.md)** — Router, AP, extender, bridge, WDS
- **[Drop-in Gateway](docs/drop-in-gateway.md)** — Add features to existing network
- **[Multi-WAN](docs/multi-wan.md)** — Failover and load balancing
- **[Clients](docs/clients.md)** — Device management, speed limits, access control
- **[Network Storage](docs/network-storage.md)** — USB/Samba/WebDAV/DLNA
- **[Administration](docs/administration.md)** — Firmware upgrade, DDNS, LuCI, debrick

## Common Workflows

### Set up as drop-in gateway with AdGuard
1. Connect primary router LAN → GL.iNet WAN
2. Enable Drop-in Gateway in admin panel
3. Set primary router DHCP gateway to GL.iNet WAN IP
4. Enable AdGuard Home under Applications

### Connect to VPN provider (WireGuard)
VPN → WireGuard Client → select provider (Mullvad, NordVPN, etc.) → enter credentials → select server → connect

### Remote access via Tailscale
Applications → Tailscale → Enable → bind to Tailscale account → enable Allow Remote Access LAN → approve subnet routes in Tailscale admin

## Upstream Sources

- **Documentation**: https://docs.gl-inet.com/router/en/4/
- **Community**: https://forum.gl-inet.com
- **Firmware**: https://dl.gl-inet.com

## Sync & Update

When user runs `sync`: fetch latest from upstream, update docs/.
When user runs `diff`: compare current vs upstream, report changes.
