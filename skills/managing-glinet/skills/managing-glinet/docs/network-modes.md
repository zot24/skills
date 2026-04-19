<!-- Source: https://docs.gl-inet.com/router/en/4/interface_guide/network_mode -->

# Network Modes

## Models with WiFi

| Mode | NAT | DHCP | Firewall | WiFi | Use Case |
|------|-----|------|----------|------|----------|
| **Router** | Yes | Yes | Yes | Yes | Default — full gateway with all features |
| **Access Point** | No | No | No | Yes | Wireless bridge via Ethernet to primary router |
| **Extender** | No | No | No | Yes | Wireless repeater (no cable needed, ~50% bandwidth) |
| **WDS** | No | No | No | Yes | Wireless bridge between compatible routers |

## Models without WiFi (GL-MT2500/A)

| Mode | NAT | DHCP | Firewall | Use Case |
|------|-----|------|----------|----------|
| **Router** | Yes | Yes | Yes | Default gateway |
| **Bridge** | No | No | No | Transparent network switch |

## Important Notes

- Only **Router mode** supports VPN, AdGuard, parental controls, port forwarding, guest networks, DNS management
- In AP/Extender/Bridge/WDS modes, the original LAN IP (`192.168.8.1`) may become inaccessible
- Press reset button for 4 seconds to revert to Router mode
- All client devices may need to reconnect after switching modes
- In Extender mode, admin panel remains accessible at original LAN IP
