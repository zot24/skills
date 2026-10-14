---
name: cloudflare-domains
description: Takes a domain from search to serving on Cloudflare with the official cf CLI — availability and price, registration behind a money gate, DNS, DNSSEC, Always Use HTTPS, Worker custom domains, www to apex redirect, Email Routing, Crawler Hints, public hostnames on an existing Cloudflare Tunnel and WAF rules that hide admin paths. A playbook over Cloudflare's own cf-cli skill, not a copy of its docs. Use when buying or wiring a domain, pointing a domain at a Worker, forwarding domain email, or exposing a self-hosted service under a site's subdomain. Triggers on buy a domain, register domain, Cloudflare Registrar, DNS records, www redirect, email routing, custom domain, tunnel hostname, cfargotunnel, WAF custom rule, Crawler Hints.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# cloudflare-domains

Everything between "we want acmewidgets.com" and "it serves the site, forwards mail and pings search
engines", run with Cloudflare's official `cf` CLI. Cloudflare's **`cf-cli`** skill (cloudflare/skills)
owns the commands; this skill owns the order, the stops and the merges that keep other things
working.

## Overview

- **Registrar** — availability and price, registration only after the owner's yes
- **DNS and HTTPS** — records, DNSSEC, Always Use HTTPS, Crawler Hints
- **Worker custom domains** — declared in the site's `wrangler.jsonc`, attached on deploy
- **www → apex** — one Single Redirect rule added next to the rules already there
- **Email Routing** — `info@<domain>` forwarded to the owner's inbox
- **Tunnel hostnames + WAF** — `umami.<site-domain>` on an existing tunnel, admin paths blocked

## Three hard rules

1. **Money gate.** Registration charges the account card at once and cannot be refunded. Show the
   exact domain, first-year price and renewal price; register only after an explicit yes.
2. **Add, never replace.** Rulesets take one new rule with `cf rulesets rules create`. The tunnel
   ingress list has no add command, so read it, merge, write it back.
3. **No secrets in repos.** Token and account ID come from the environment (1Password via Varlock).
   Never print them, and never commit vault names, account IDs or tunnel IDs.

## Quick start

```bash
npm i -g cf                                   # Cloudflare CLI; needs Node 22.18+
cf registrar registrations check acmewidgets.com
cf zones settings edit always_use_https -z acmewidgets.com --body '{"value":"on"}'
```

`-z` takes the domain name, so there is no zone ID lookup. Before a command you have not run, use
`cf cli search "<task>"`, then `--help` and `--dry-run` (see Cloudflare's `cf-cli` skill).

## Documentation

- **[Playbook](docs/playbook.md)** — the steps for a new domain, in order, with checks
- **[Redirects](docs/redirects.md)** — www → apex without touching existing rules
- **[Email Routing](docs/email-routing.md)** — enable, verify the destination, forward `info@`
- **[Tunnel hostnames](docs/tunnel-hostnames.md)** — ingress merge, CNAME, WAF path lock
- **[Secrets](docs/secrets.md)** — token permissions, Varlock schema, `op` fallback

## Depends on

| Skill | Source | For |
|---|---|---|
| `cf-cli` | cloudflare/skills | every `cf` command, sign-in, `cf cli search` |
| `wrangler` | cloudflare/skills | deploys and Worker custom domains |
| `cloudflare` | cloudflare/skills | product references (WAF, tunnels) |
| `1password-cli` | zot24/skills | secrets fallback |

## Common workflows

- New site: `setup <domain>` runs the [playbook](docs/playbook.md) end to end.
- Self-hosted tracker for a site: `tunnel umami.<domain>` ([tunnel hostnames](docs/tunnel-hostnames.md)).
- A domain bought elsewhere: `cf zones create`, then the owner changes nameservers; continue at step 3.
