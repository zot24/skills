<!-- Source: https://docs.gl-inet.com/router/en/4/interface_guide/wireguard_client + wireguard_server -->

# WireGuard Client & Server

## WireGuard Client

Access via **VPN → WireGuard Client**.

### Integrated Providers
One-click setup with credentials: AzireVPN, Hide.me, IPVanish, Mullvad, NordVPN, PIA, PureVPN, Surfshark, Windscribe.

Setup: VPN → WireGuard Client → Provider → enter credentials → Save and Continue → select server → connect.

### Manual Configuration
For other providers:
1. VPN → WireGuard Client → Add Manually
2. Name the configuration group
3. Upload: `.conf`, `.zip`, `.tar`, `.gz`, `.txt` files — or paste config text
4. Apply and connect via three-dot menu

### Configuration Modes
- **Text Mode**: Paste complete WireGuard config block
- **Item Mode**: Verify individual parameters before applying

### Management
- Green dot = connected
- Update Servers: refresh server lists
- Refresh: update public keys for connection issues
- Delete All: remove configs (optionally delete keys)

## WireGuard Server

Access via **VPN → WireGuard Server**.

### Prerequisites
- Public IP address from ISP (verify in WAN settings)
- Port forwarding on upstream router if GL.iNet is secondary router

### Setup
1. Click Generate Configuration (first time only)
2. Verify IPv4 address (default `10.0.0.1/24`) doesn't conflict with upstream
3. Create client profiles under Profiles tab
4. Export config: QR code, plain text, or `.conf` file
5. Click Start to activate server

### Server Address Options
Use public IP, DDNS domain, or current WAN IP as server endpoint.

### Verification
Import config on a device using different internet (e.g. cellular). Search IP online — should match server's public IP.

### Troubleshooting
- No public IP → contact ISP or use AstroWarp
- Missing port forwarding on upstream router
- ISP blocking WireGuard port → try alternative port
