# AdGuard Home Skill

Expert assistant for deploying and managing [AdGuard Home](https://adguard.com/adguard-home/overview.html) — network-wide DNS ad blocking and filtering.

## What This Skill Covers

- Docker and bare-metal deployment
- DNS filtering configuration and blocklists
- DNS encryption (DoH, DoT, DoQ, DNSCrypt)
- DHCP server setup
- Per-client rules and settings
- REST API automation
- VPS deployment patterns

## Usage

```
/adguard:adguard setup docker       # Docker deployment
/adguard:adguard configure          # Config reference
/adguard:adguard block malware.com  # Block a domain
/adguard:adguard check example.com  # Check filtering
/adguard:adguard encrypt            # DNS encryption
/adguard:adguard blocklists         # Recommended lists
/adguard:adguard api                # API reference
```

## Documentation Sources

- **GitHub Wiki**: https://github.com/AdguardTeam/AdGuardHome/wiki
- **Repository**: https://github.com/AdguardTeam/AdGuardHome
- **Built-in API docs**: `http://YOUR_HOST/control/` (Swagger UI)

## Sync

```bash
.github/workflows/scripts/sync-skill.sh skills/adguard --force
```
