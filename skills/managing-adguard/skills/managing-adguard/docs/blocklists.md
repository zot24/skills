<!-- Source: Authored — recommended AdGuard Home blocklists -->

# Recommended Blocklists

## Default Lists (included with AdGuard Home)
- **AdGuard DNS filter** — balanced blocking, low false positives
- **AdAway Default Blocklist** — mobile-focused ad blocking

## Recommended Additions

### General Ad & Tracker Blocking
```
# HaGeZi Pro — comprehensive, well-maintained
https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt

# OISD Big — one of the largest curated lists
https://big.oisd.nl

# Steven Black's Hosts — unified hosts with extensions
https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
```

### Malware & Phishing
```
# Phishing Army
https://phishing.army/download/phishing_army_blocklist.txt

# URLhaus Malicious URLs
https://urlhaus.abuse.ch/downloads/hostfile/

# Malware Domain List
https://www.malwaredomainlist.com/hostslist/hosts.txt
```

### Privacy & Tracking
```
# EasyPrivacy (tracking)
https://v.firebog.net/hosts/Easyprivacy.txt

# Prigent Ads (French-optimized)
https://v.firebog.net/hosts/AdguardDNS.txt
```

### Adult Content (Optional)
```
# OISD NSFW
https://nsfw.oisd.nl
```

## Filter Syntax

AdGuard Home supports multiple filter formats:

```
# Block a domain and all subdomains
||ads.example.com^

# Block exact domain only
|ads.example.com^

# Allow (whitelist) a domain
@@||example.com^

# Block with regex
/ads\d+\.example\.com/

# Comment
! This is a comment

# Important rule (overrides allow)
||very-bad.com^$important
```

## Managing Lists

### Via Web UI
Settings → Filters → DNS blocklists → Add blocklist → Add a custom list

### Via API
```bash
# Add a list
curl -u admin:pass -X POST http://HOST/control/filtering/add_url \
  -H "Content-Type: application/json" \
  -d '{"name": "HaGeZi Pro", "url": "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt", "whitelist": false}'

# Force refresh all lists
curl -u admin:pass -X POST http://HOST/control/filtering/refresh \
  -d '{"whitelist": false}'
```

## Recommended Setup

1. Keep the **AdGuard DNS filter** (default)
2. Add **HaGeZi Pro** for comprehensive blocking
3. Add a **malware list** (URLhaus or Phishing Army)
4. Start conservative — add more lists if you see ads getting through
5. Use the Query Log to identify false positives and add allowlist rules

## Performance Notes

- More lists = more memory usage and slower filter updates
- 500K–1M rules is a reasonable target
- Lists with overlapping rules waste memory — prefer curated lists over stacking many
- Set filter update interval to 24h (Settings → Filters → Filter update interval)
