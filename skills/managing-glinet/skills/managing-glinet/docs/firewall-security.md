<!-- Source: https://docs.gl-inet.com/router/en/4/interface_guide/firewall + port_forwarding -->

# Firewall & Port Forwarding

## Port Forwarding (v4.6+)

Access via **NETWORK → Port Forwarding**.

### DMZ
Exposes one device to all inbound traffic:
1. Toggle Enable DMZ
2. Select internal IP of host device
3. Configure priority vs port forwarding rules

### Port Forwarding Rules

| Field | Options |
|-------|---------|
| Protocol | TCP, UDP, or both |
| External Zone | WAN, wgclient, wgserver, ovpnclient, ovpnserver, LAN, Guest |
| External Port | 1-65535, supports ranges (e.g. `501-510`) |
| Internal Zone | LAN, Guest, WireGuard, OpenVPN, WAN |
| Internal IP | Target device IP |
| Internal Port | Destination port (blank = same as external) |
| Enable | Toggle on/off |

For opening ports on the router itself: **SYSTEM → Security**.

## Firewall (v4.5 and earlier)

Access via **NETWORK → Firewall**. In v4.6+, port forwarding and DMZ moved to dedicated Port Forwarding page; Open Ports moved to Security settings.

### Port Forwards
Enable remote access to local servers (web, FTP, etc.).

### Open Ports on Router
Expose router services (web, SSH) to be publicly reachable.
