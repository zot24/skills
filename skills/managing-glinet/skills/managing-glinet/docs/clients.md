<!-- Source: https://docs.gl-inet.com/router/en/4/interface_guide/clients -->

# Client Management

Access via **CLIENTS** in the web admin panel.

## Device Information
- Device name and type (customizable via three-dot menu)
- Connection type (WiFi or Ethernet — blue icon)
- IP and MAC addresses (flags randomized MACs)
- Speed (average, updates over 10s–3min)
- Traffic (total data consumption)

## Features

### Reserved IP Addresses (v4.8+)
Assign fixed IPs by MAC address so devices always get the same IP from DHCP.

### Access Control (Blocklist/Allowlist)
- **Blocklist**: Block specific MAC addresses from connecting
- **Allowlist**: Only whitelisted MACs can connect (good for IoT/enterprise)
- Supports batch import via template file

### Speed Limiting
Per-device upload/download restrictions. Three-dot menu → Limit Speed. Yellow arrows indicate limited devices.

### VPN Tunnel Assignment (v4.8+)
Assign clients to specific VPN tunnels via MAC-based routing. Managed through VPN Dashboard.

## Sorting & Cleanup
Default order: router first, then online clients by connection time. Remove offline clients individually or all at once.
