# Managing GL.iNet Skill

Expert assistant for configuring and managing [GL.iNet](https://www.gl-inet.com/) routers running firmware v4.x.

## Feature Coverage

| Feature | Description |
|---------|-------------|
| VPN | WireGuard, OpenVPN client/server, Tailscale, ZeroTier |
| AdGuard Home | Built-in network-wide ad blocking |
| DNS | Automatic, encrypted (DoH/DoT/DNSCrypt), manual, proxy |
| Multi-WAN | Failover and load balancing across interfaces |
| Drop-in Gateway | Add VPN/AdGuard to existing network |
| Network Modes | Router, AP, Extender, Bridge, WDS |
| Firewall | Port forwarding, DMZ, access control |
| Storage | USB/SD via Samba, WebDAV, DLNA |
| DDNS | Dynamic DNS with remote HTTPS/SSH access |

## Usage

### Slash Commands

```
/managing-glinet setup                  # First time setup
/managing-glinet vpn wireguard          # WireGuard client/server
/managing-glinet vpn tailscale          # Tailscale mesh VPN
/managing-glinet adguard                # AdGuard Home setup
/managing-glinet dns encrypted          # Encrypted DNS config
/managing-glinet gateway                # Drop-in gateway setup
/managing-glinet firewall               # Port forwarding / DMZ
/managing-glinet multiwan               # Failover / load balancing
/managing-glinet clients                # Device management
/managing-glinet storage                # USB/Samba/WebDAV
/managing-glinet debrick                # Recovery for bricked router
/managing-glinet sync                   # Update documentation
```

### Natural Language Triggers

The skill activates on mentions of: GL.iNet, GL-iNet, Flint, Beryl, Slate, Brume, Spitz, Mudi, Marble, travel router, WireGuard router, drop-in gateway.

## Documentation Sources

- **Docs**: https://docs.gl-inet.com/router/en/4/
- **Community**: https://forum.gl-inet.com
- **Firmware**: https://dl.gl-inet.com

## Skill Structure

```
skills/managing-glinet/
├── .claude-plugin/plugin.json           # Plugin metadata
├── commands/managing-glinet.md          # Slash command entry point
├── skills/managing-glinet/
│   ├── SKILL.md                         # Overview + references (~100 lines)
│   └── docs/                            # Cached documentation
│       ├── first-time-setup.md          # Initial configuration
│       ├── internet-wan.md              # WAN connection types
│       ├── wireless.md                  # WiFi configuration
│       ├── lan-dns.md                   # LAN + DNS settings
│       ├── vpn-dashboard.md             # VPN management
│       ├── wireguard.md                 # WG client + server
│       ├── tailscale.md                 # Tailscale integration
│       ├── adguardhome.md               # AdGuard Home
│       ├── firewall-security.md         # Firewall + port forwarding
│       ├── network-modes.md             # Router/AP/bridge modes
│       ├── drop-in-gateway.md           # Drop-in gateway
│       ├── multi-wan.md                 # Failover + load balancing
│       ├── clients.md                   # Device management
│       ├── network-storage.md           # USB/Samba/WebDAV/DLNA
│       └── administration.md            # Upgrade, DDNS, LuCI, debrick
├── sync.json                            # Sync configuration
└── README.md                            # This file
```
