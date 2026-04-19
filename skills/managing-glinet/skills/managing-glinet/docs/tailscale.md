<!-- Source: https://docs.gl-inet.com/router/en/4/interface_guide/tailscale -->

# Tailscale Integration

Available since firmware v4.2. Access via **APPLICATIONS → Tailscale**.

## Supported Models
GL-E5800, GL-MT5000, GL-MT3600BE, GL-BE6500, GL-BE9300, GL-BE3600, GL-X2000, GL-B3000, GL-MT6000, GL-X3000, GL-XE3000, GL-AX1800, GL-MT2500/A, GL-MT3000, GL-AXT1800, GL-A1300.

## Setup

1. Create Tailscale account and bind test devices
2. On router: APPLICATIONS → Tailscale → Enable → Apply
3. Click Device Bind Link → authenticate via Tailscale website
4. Router receives Tailscale IP address
5. Test: ping router from other Tailscale devices

## Key Options

### Allow Remote Access WAN
Access upstream network resources. Requires approving subnet routes in Tailscale Admin console.

### Allow Remote Access LAN
Access downstream LAN devices (SSH, ping, web UIs). Requires approving subnet routes in Tailscale Admin.

### Custom Exit Nodes
Route all internet traffic through a designated exit node:
1. Enable subnet routes for router
2. Configure device as exit node in Tailscale
3. Enable Custom Exit Nodes on router
4. Select exit node IP

**DNS note:** If router DNS uses private IP, you may lose internet when using exit node. Set DNS to `8.8.8.8` to resolve.

## Restrictions
- Not recommended alongside OpenVPN Client, WireGuard Client, GoodCloud Site to Site, ZeroTier, or AstroWarp
- GL.iNet routers are not yet available as exit nodes
- Feature is in beta
