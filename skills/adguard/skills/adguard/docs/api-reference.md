<!-- Source: Authored — AdGuard Home REST API reference -->

# AdGuard Home API Reference

## Authentication

All API calls require HTTP Basic Auth:

```bash
curl -u username:password http://HOST/control/ENDPOINT
```

## Endpoints

### Status & Info
```bash
# Server status
GET /control/status

# DNS info (upstream, bootstrap, etc.)
GET /control/dns_info

# Version info
GET /control/version.json
```

### Filtering
```bash
# Check if domain is filtered
GET /control/filtering/check_host?name=example.com

# Get filtering status and lists
GET /control/filtering/status

# Add a filter list
POST /control/filtering/add_url
{"name": "My List", "url": "https://...", "whitelist": false}

# Remove a filter list
POST /control/filtering/remove_url
{"url": "https://...", "whitelist": false}

# Refresh filters
POST /control/filtering/refresh
{"whitelist": false}

# Set custom filtering rules
POST /control/filtering/set_rules
{"rules": ["||ads.example.com^", "@@||allowed.com^"]}
```

### DNS Configuration
```bash
# Get DNS config
GET /control/dns_info

# Update DNS config
POST /control/dns_config
{
  "upstream_dns": ["https://dns.cloudflare.com/dns-query"],
  "bootstrap_dns": ["1.1.1.1"],
  "protection_enabled": true,
  "ratelimit": 20
}
```

### Query Log
```bash
# Get query log
GET /control/querylog?limit=100&offset=0

# Get query log config
GET /control/querylog_info

# Clear query log
POST /control/querylog_clear
```

### Statistics
```bash
# Get statistics
GET /control/stats

# Reset statistics
POST /control/stats_reset

# Get stats config
GET /control/stats_info
```

### Clients
```bash
# List clients
GET /control/clients

# Add client
POST /control/clients/add
{
  "name": "Living Room TV",
  "ids": ["192.168.1.50"],
  "tags": ["device_tv"],
  "use_global_settings": false,
  "filtering_enabled": true,
  "safe_search": {"enabled": true}
}

# Update client
POST /control/clients/update
{"name": "Living Room TV", "data": {"name": "Living Room TV", ...}}

# Delete client
POST /control/clients/delete
{"name": "Living Room TV"}
```

### DHCP
```bash
# Get DHCP status
GET /control/dhcp/status

# Set DHCP config
POST /control/dhcp/set_config
{
  "enabled": true,
  "interface_name": "eth0",
  "v4": {
    "gateway_ip": "192.168.1.1",
    "subnet_mask": "255.255.255.0",
    "range_start": "192.168.1.100",
    "range_end": "192.168.1.200",
    "lease_duration": 86400
  }
}

# Add static lease
POST /control/dhcp/add_static_lease
{"mac": "AA:BB:CC:DD:EE:FF", "ip": "192.168.1.50", "hostname": "my-device"}
```

### DNS Rewrites
```bash
# List rewrites
GET /control/rewrite/list

# Add rewrite
POST /control/rewrite/add
{"domain": "myservice.local", "answer": "192.168.1.100"}

# Delete rewrite
POST /control/rewrite/delete
{"domain": "myservice.local", "answer": "192.168.1.100"}
```

### Protection Toggle
```bash
# Disable protection temporarily (e.g., 5 minutes)
POST /control/protection
{"enabled": false, "duration": 300000}

# Re-enable
POST /control/protection
{"enabled": true}
```

### Cache
```bash
# Clear DNS cache
POST /control/cache_clear
```

## Swagger UI

AdGuard Home includes built-in Swagger documentation at:
```
http://YOUR_HOST/control/
```
