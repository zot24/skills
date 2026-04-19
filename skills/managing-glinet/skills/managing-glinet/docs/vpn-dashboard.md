<!-- Source: https://docs.gl-inet.com/router/en/4/interface_guide/vpn_dashboard_v4.8 -->

# VPN Dashboard (v4.8+)

Access via **VPN → VPN Dashboard**.

## VPN Modes

### Global Mode
All traffic routes through a single VPN tunnel. Simple, comprehensive coverage.

### Policy Mode
Multiple simultaneous VPN connections (up to 5 tunnels) with per-device/per-domain routing.

## Policy Mode Configuration

### Primary Tunnel
Highest priority, customizable with three elements:

**From (Traffic Source):**
- All Clients
- Specified Connection Types
- Specified Devices
- Exclude Specified Devices

**To (Traffic Destination):**
- All Targets
- Specified Domain/IP Lists (manual or subscription URL)
- Exclude Specified Domain/IP Lists

**Via (Routing Method):**
- Use VPN (through selected config)
- Not Use VPN (direct WAN)

### Additional Tunnels
Up to 5 total (including primary). Each has independent source/destination/routing rules.

### All Other Traffic
Default-enabled tunnel for unmatched traffic. When disabled, acts as kill switch — blocks all non-VPN traffic.

## Advanced Options (per tunnel)

| Setting | Description |
|---------|-------------|
| **Kill Switch** | Block traffic if VPN drops |
| **Services from GL.iNet Use VPN** | Route GoodCloud/DDNS through VPN (default: off) |
| **Allow Remote Access to LAN** | VPN-based remote access to router + LAN |
| **IP Masquerading** | Rewrite source IPs to VPN tunnel IP (disable for site-to-site) |
| **MTU** | Override config file MTU |

## Integrated Providers
Setup wizard supports: AzireVPN, Hide.me, IPVanish, Mullvad, NordVPN, PIA, Surfshark.

## Tunnel Priority
Traffic tries highest-priority tunnel first, fails over based on kill switch settings. "All Other Traffic" provides failsafe local WAN access.
