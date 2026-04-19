<!-- Source: https://docs.gl-inet.com/router/en/4/interface_guide/multi-wan -->

# Multi-WAN

Access via **NETWORK → Multi-WAN**. Supports Ethernet, Repeater, Tethering, Cellular.

## Interface Status Tracking

Monitors up to 5 virtual interfaces per device using ping/httping. Green = available, gray = unavailable.

### Detection Modes
- **Normal**: Continuous monitoring (default)
- **Low Data**: Tracks only after errors (saves data on cellular)
- **Strict**: Uses only public IP detection

### Sensitivity (v4.5+)
- **High**: Quick failover — best for streaming/gaming on stable networks
- **Low**: Avoids constant switching — best for large downloads on unstable connections

## Failover Mode (Default)

Assigns priority to each interface. Uses highest-priority available connection, auto-switches on failure, auto-restores when preferred connection returns.

Example: Ethernet (priority 1) > Repeater (priority 2) — if Ethernet drops, switches to Repeater.

## Load Balancing

Distributes traffic across multiple active interfaces by ratio.

Example: Ethernet 200 Mbps (ratio 2) + Repeater 100 Mbps (ratio 1) — new connections distributed proportionally.

Note: Active connections aren't rebalanced. Ratio accuracy improves over time.

## Model Limitations
- No WiFi models (GL-MT2500/A): Ethernet, Tethering, Cellular only
- No USB models (GL-B3000): Ethernet and Repeater only
