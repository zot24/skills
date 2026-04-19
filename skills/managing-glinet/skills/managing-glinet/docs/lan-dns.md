<!-- Source: https://docs.gl-inet.com/router/en/4/interface_guide/lan + dns -->

# LAN & DNS Configuration

## LAN Settings

Access via **NETWORK → LAN**.

### Router IP
Default: `192.168.8.1`. Change if network conflicts occur.

### Netmask
Default: `255.255.255.0`. Select `255.255.0.0` for larger subnets.

### Allowed Subnets
`192.168.0.0/16`, `172.16.0.0/12`, `10.0.0.0/8`

### AP Isolation
Isolates client devices — they cannot communicate with each other on the same network.

### DHCP Server
Enabled by default. Configurable options:
- Start/end IP address range
- Lease time
- Gateway
- Primary/secondary DNS servers
- LPR server (print jobs)

### Address Reservation
Assign fixed IPs to devices by MAC address. Click Add → select MAC → confirm IP → name → Submit. Device must reconnect to activate.

## DNS Settings

Access via **NETWORK → DNS**.

### DNS Modes

| Mode | Description |
|------|-------------|
| **Automatic** | Uses DNS from upstream device (ISP/modem) |
| **Encrypted DNS** | DNS over TLS, DNSCrypt-Proxy, DNS over HTTPS, Oblivious DoH |
| **Manual DNS** | Custom DNS servers from dropdown |
| **DNS Proxy** | Routes all LAN DNS to specified proxy (format: `8.8.8.8#53`) |

### Encrypted DNS Providers
- DNS over TLS: Control D, NextDNS, Cloudflare
- DNSCrypt-Proxy: Public repository servers
- DNS over HTTPS: Repository servers
- Oblivious DoH: Enhanced privacy servers

### Global DNS Options
- **DNS Rebinding Attack Protection** — may cause issues with captive portals
- **Override DNS Settings for All Clients** — forces DNS replacement router-wide
- **Allow Custom DNS to Override VPN DNS** — custom DNS supersedes VPN DNS

### Static DNS (Edit Hosts)
Create custom domain-to-IP mappings that override standard resolution.
