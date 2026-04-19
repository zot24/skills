# Managing AdGuard Home Skill

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
/managing-adguard:managing-adguard setup docker       # Docker deployment
/managing-adguard:managing-adguard configure          # Config reference
/managing-adguard:managing-adguard block malware.com  # Block a domain
/managing-adguard:managing-adguard check example.com  # Check filtering
/managing-adguard:managing-adguard encrypt            # DNS encryption
/managing-adguard:managing-adguard blocklists         # Recommended lists
/managing-adguard:managing-adguard api                # API reference
```

## Documentation Sources

- **GitHub Wiki**: https://github.com/AdguardTeam/AdGuardHome/wiki
- **Repository**: https://github.com/AdguardTeam/AdGuardHome
- **Built-in API docs**: `http://YOUR_HOST/control/` (Swagger UI)

## Sync

```bash
.github/workflows/scripts/sync-skill.sh skills/managing-adguard --force
```
