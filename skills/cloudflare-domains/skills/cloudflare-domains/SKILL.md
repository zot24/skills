---
name: cloudflare-domains
description: Takes a domain from search to serving on Cloudflare — Registrar API search, check and registration, zone DNS, Worker custom domains, www to apex redirect, Always Use HTTPS, DNSSEC, Email Routing, Crawler Hints (IndexNow), public hostnames on an existing Cloudflare Tunnel and WAF rules that hide admin paths. Use when buying or wiring a domain, pointing a domain at a Worker, forwarding domain email, or exposing a self-hosted service under a site's subdomain. Triggers on Cloudflare Registrar, buy a domain, register domain, DNS records, www redirect, email routing, custom domain, cloudflared tunnel hostname, cfargotunnel, WAF custom rule, Crawler Hints, IndexNow.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# cloudflare-domains

Everything between "we want acmewidgets.com" and "it serves the site, forwards mail and pings search
engines" — driven through the Cloudflare API and `wrangler`, no dashboard clicking.

## Overview

- **Registrar API** — search, check price and availability, register, poll status
- **DNS and HTTPS** — zone lookup, records, Always Use HTTPS, DNSSEC
- **Worker custom domains** — apex served by the site's Worker, certificate included
- **www → apex** — one Single Redirect rule, never clobbering existing rules
- **Email Routing** — forward `hello@` or a catch-all to the owner's inbox
- **Tunnel hostnames + WAF** — `umami.<site-domain>` on an existing tunnel, admin paths blocked

## Two hard rules

1. **Money gate.** Registration charges the account card immediately and cannot be refunded. Show the
   user the exact domain, price and renewal price, and register only after an explicit yes.
2. **Read before replace.** Redirect entry points, WAF entry points and tunnel ingress lists are
   replaced wholesale by `PUT`. Read the current state, merge, then write.

## Quick start

```bash
CF=https://api.cloudflare.com/client/v4
AUTH=(-H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" -H "Content-Type: application/json")
curl -s -X POST "$CF/accounts/$CLOUDFLARE_ACCOUNT_ID/registrar/domain-check" "${AUTH[@]}" \
  -d '{"domains":["acmewidgets.com"]}'
ZONE=$(curl -s "$CF/zones?name=acmewidgets.com" "${AUTH[@]}" | jq -r '.result[0].id')
```

Credentials come from 1Password through Varlock — never hard-code them, never print them, and never
write vault names, tunnel IDs or account IDs into a repo. See [secrets](docs/secrets.md).

## Documentation

Authored playbooks (start here):

- **[Playbook](docs/playbook.md)** — the nine steps for a new domain, in order, with verification
- **[Secrets](docs/secrets.md)** — token permissions, Varlock schema, `op` fallback
- **[Redirects](docs/redirects.md)** — www → apex without losing existing rules
- **[Email Routing](docs/email-routing.md)** — enable, verify destination, rules, catch-all
- **[Tunnel hostnames](docs/tunnel-hostnames.md)** — ingress merge, CNAME, WAF path lock

Upstream Cloudflare docs (synced):

- **[Registrar API](docs/registrar-api.md)** · **[Register a domain](docs/register-domain.md)**
- **[Create DNS records](docs/create-dns-records.md)** · **[DNSSEC](docs/dnssec.md)**
- **[Workers custom domains](docs/workers-custom-domains.md)**
- **[Redirect www to root](docs/redirect-www-to-root.md)** · **[Single Redirects API](docs/single-redirects-api.md)**
- **[WAF custom rules API](docs/waf-custom-rules-api.md)** · **[Crawler Hints](docs/crawler-hints.md)**
- **[Remote tunnel API](docs/remote-tunnel-api.md)** · **[Tunnel DNS records](docs/tunnel-dns-records.md)**
- **[Create an API token](docs/create-api-token.md)**

## Common workflows

- **New site domain:** playbook steps 1–8, then `wrangler deploy` with the custom domain route.
- **Existing domain, new Worker:** skip steps 1–2; start at the zone lookup.
- **Analytics hostname:** [tunnel hostnames](docs/tunnel-hostnames.md), then hand the hostname to the
  `umami` skill to create the website and inject its script.

## Related skills

- `wrangler`, `workers-best-practices` (cloudflare/skills) — Worker config and deploys
- `cloudflare-email-service` (cloudflare/skills) — sending mail from the domain
- `1password-cli` — reading secrets when Varlock is not set up

## Upstream Sources

- **Documentation**: https://developers.cloudflare.com
- **Docs source**: https://github.com/cloudflare/cloudflare-docs
- **API reference**: https://developers.cloudflare.com/api

## Sync & Update

When user runs `sync`: run `.github/workflows/scripts/sync-skill.sh skills/cloudflare-domains --force`.
When user runs `diff`: run the same script with `--dry-run`. Authored docs are not touched by sync.
