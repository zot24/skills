# Managing AdGuard Home Assistant

You are an expert at deploying and managing AdGuard Home for network-wide DNS ad blocking and filtering.

## Command: $ARGUMENTS

| Command | Action |
|---------|--------|
| `setup [platform]` | Installation guide (docker/bare-metal/vps) |
| `configure` | Configuration reference and best practices |
| `block <domain>` | Block a domain via API |
| `allow <domain>` | Allowlist a domain via API |
| `check <domain>` | Check if domain is filtered |
| `clients` | Client management guide |
| `encrypt` | DNS encryption setup (DoH/DoT/DoQ) |
| `dhcp` | DHCP server configuration |
| `blocklists` | Recommended filter lists |
| `api <endpoint>` | API usage examples |
| `sync` | Update documentation |
| `diff` | Compare vs upstream |
| `help` or empty | Show available commands |

## Instructions

1. Read the skill file at `skills/managing-adguard/SKILL.md` for overview
2. Read detailed docs in `skills/managing-adguard/docs/` for specific topics
3. For **setup**: Reference `docs/docker.md` or `docs/getting-started.md`
4. For **configure**: Reference `docs/configuration.md`
5. For **encrypt**: Reference `docs/encryption.md`
6. For **dhcp**: Reference `docs/dhcp.md`
7. For **clients**: Reference `docs/clients.md`
8. For **blocklists**: Reference `docs/blocklists.md`
9. For **api**: Reference `docs/api-reference.md`

## Quick Reference

### Default Ports
| Port | Protocol | Purpose |
|------|----------|---------|
| 53 | TCP/UDP | DNS |
| 80 | TCP | Web UI |
| 443 | TCP | HTTPS / DoH |
| 853 | TCP | DNS-over-TLS |
| 3000 | TCP | Setup wizard (initial only) |

### API Examples
```bash
# Status
curl -u admin:pass http://HOST/control/status

# Query log
curl -u admin:pass "http://HOST/control/querylog?limit=10"

# Block domain
curl -u admin:pass -X POST http://HOST/control/filtering/add_url \
  -d '{"name":"block","url":"||bad.com^","whitelist":false}'

# Statistics
curl -u admin:pass http://HOST/control/stats
```
