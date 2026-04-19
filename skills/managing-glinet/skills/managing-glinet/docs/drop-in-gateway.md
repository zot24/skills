<!-- Source: https://docs.gl-inet.com/router/en/4/interface_guide/drop-in_gateway -->

# Drop-in Gateway

Add VPN, AdGuard Home, and encrypted DNS to an existing network without replacing the primary router.

## How It Works

Data flow: Client devices → Primary router → GL.iNet router (processing) → Primary router → Internet

## Features Added
- Ad filtering via AdGuard Home
- VPN client support
- Encrypted DNS
- Preserves existing SSID and network config

## Setup: All Devices

1. Connect primary router LAN port → GL.iNet WAN port (Ethernet)
2. Enable Drop-in Gateway in GL.iNet admin panel, note the generated IP
3. Configure primary router's DHCP gateway to the GL.iNet WAN IP:
   - **GL.iNet primary**: Set DHCP Gateway IP (v4.2+)
   - **TP-Link**: Advanced → Network → DHCP Server → Disable
   - **Linksys**: Router Settings → Connectivity → Local Network → Disable DHCP
   - **Others**: Consult manufacturer docs
4. Configure desired features on GL.iNet router

## Setup: Specific Devices Only

1. Connect routers via Ethernet (same as above)
2. Enable Drop-in Gateway, note IP
3. On each target device, set gateway and DNS to the Drop-in Gateway IP (static IP config)

## Caveats

- Increases network latency
- LAN-to-LAN traffic also routes through gateway, reducing bandwidth
- Recommended: higher-performance models (GL-MT2500, GL-MT5000) for traffic forwarding
