<!-- Source: https://docs.gl-inet.com/router/en/4/interface_guide/wireless -->

# Wireless Configuration

Access via **WIRELESS** in the web admin panel. Supports 2.4 GHz, 5 GHz, 6 GHz, and MLO (WiFi 7) depending on model.

## Per-Band Settings

Each band (2.4G, 5G, 6G) supports Main WiFi and Guest WiFi with these options:
- Enable/disable WiFi
- TX power adjustment
- Randomized BSSID (enabled by default since v4.6 — prevents location tracking)
- SSID name and broadcast visibility
- Security protocol and password
- WiFi mode, bandwidth, channel selection

## MLO WiFi (WiFi 7)

Supported on: GL-BE10000, GL-MT3600BE, GL-BE6500, GL-BE9300, GL-BE3600

Multi-Link Operation uses multiple frequency bands simultaneously for reduced latency and improved stability. Requires minimum two radio bands.

## 6 GHz WiFi

Supported on: GL-BE10000, GL-E5800, GL-BE9300

PSC (Preferred Scanning Channel) setting available for improved device discovery.

## Key Notes

- Bandwidth and channel cannot be modified when router acts as repeater
- Auto channel mode does not switch to DFS channels
- Setting 160 MHz bandwidth forces DFS channel usage
- Guest WiFi BSSID matches Main WiFi BSSID within same band
- QR codes available by hovering over WiFi icons
