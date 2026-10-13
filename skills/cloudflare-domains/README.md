# Cloudflare Domains

Expert skill for taking a domain from search to serving on Cloudflare — through the API and
`wrangler`, with no dashboard clicking.

## Features

- **Registrar API** — search, availability and price checks, registration with a money gate
- **DNS and HTTPS** — records, Always Use HTTPS, DNSSEC
- **Worker custom domains** — the apex served by the site's Worker
- **www → apex** — a Single Redirect that keeps existing rules
- **Email Routing** — forward `hello@` or a catch-all to an existing inbox
- **Tunnel hostnames** — `umami.<site-domain>` on an existing Cloudflare Tunnel, admin paths locked by WAF
- **Crawler Hints** — IndexNow pings to Bing and others when pages change

## Commands

```bash
/cloudflare-domains:cloudflare-domains search acme widgets   # domain ideas
/cloudflare-domains:cloudflare-domains check acmewidgets.com # availability + price
/cloudflare-domains:cloudflare-domains register acmewidgets.com
/cloudflare-domains:cloudflare-domains setup acmewidgets.com # full playbook
/cloudflare-domains:cloudflare-domains redirect acmewidgets.com
/cloudflare-domains:cloudflare-domains email acmewidgets.com
/cloudflare-domains:cloudflare-domains tunnel umami.acmewidgets.com
/cloudflare-domains:cloudflare-domains token                 # permissions + secrets
/cloudflare-domains:cloudflare-domains sync
```

## Safety

- Registration is billable and non-refundable: the skill always asks before buying.
- Redirect, WAF and tunnel configs are read and merged before any write.
- Secrets come from 1Password through Varlock; vault names and IDs never go into a repo.

## Sources

Upstream docs are synced from [cloudflare/cloudflare-docs](https://github.com/cloudflare/cloudflare-docs).
The playbook, redirects, email, tunnel and secrets guides are authored for this skill.
