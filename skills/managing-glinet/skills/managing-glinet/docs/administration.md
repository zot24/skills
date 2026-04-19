<!-- Source: https://docs.gl-inet.com/router/en/4/interface_guide/upgrade + ddns + advanced_settings + faq/debrick -->

# Administration

## Firmware Upgrade

Access via **SYSTEM → Upgrade**.

### Online Upgrade
Shows current version, auto-checks for updates. Enable **Preview Plan** to test pre-release features.

Timezone sync issue: if download fails, go to System → Time Zone → sync with browser.

### Local Upgrade
Upload firmware files from https://dl.gl-inet.com. Options:
- **Keep Settings**: Preserves config (disable when downgrading)

**Warning:** Do NOT power off during upgrade.

## DDNS

Access via **APPLICATIONS → Dynamic DNS**.

### Setup
1. Enable DDNS → Accept terms → Apply
2. Configure security: SYSTEM → Security → Remote Access Control
3. Wait ~10 minutes for DNS propagation

### Verify
Click DDNS Test — resolved IP should match WAN IP. Yellow warning = behind NAT, need upstream port forwarding.

### Remote Access
- **HTTPS**: `https://xxxxxxx.glddns.com` (port 443, self-signed cert warning)
- **SSH**: `ssh root@xxxxxxx.glddns.com` (port 22)

If using VPN Client: disable "Services From GL.iNet Use VPN" in VPN Dashboard.

## LuCI (Advanced Settings)

Access via **SYSTEM → Advanced Settings → Go To LuCI**. Password same as admin panel.

LuCI is OpenWrt's default web UI for deep system configuration. GL.iNet does not maintain LuCI — it's provided as-is.

## Debrick / Recovery

For bricked routers using U-Boot failsafe:

1. Download firmware from https://dl.gl-inet.com (U-Boot compatible)
2. Connect computer to LAN port via Ethernet only
3. Hold Reset button while powering on → wait for LED pattern change → release
4. Set computer IP to `192.168.1.2`, subnet `255.255.255.0`
5. Browse to `http://192.168.1.1`
6. Upload firmware → wait ~3 minutes
7. Restore computer to DHCP, access router at `192.168.8.1`

**Note:** GL-E5800 (Mudi 7) does not support U-Boot flashing. GL-MT6000: use LAN 2/3/4, not LAN 1.
