---
name: search-engines
description: Gets a live site into Google and Bing through their APIs — Search Console Domain property verified by DNS TXT, owner added, sitemap submitted; Bing Webmaster Tools site added, verified by CNAME, sitemap submitted; IndexNow through Cloudflare Crawler Hints or manual pings; URL inspection, search performance and crawl-issue reports. Use when launching a site, submitting a sitemap, verifying a domain for Google or Bing, checking whether pages are indexed, or reporting search traffic. Triggers on Google Search Console, GSC, Bing Webmaster Tools, site verification, sitemap submit, IndexNow, request indexing, URL inspection, search analytics, not indexed.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# search-engines

Takes a site that is live on its domain and makes sure Google, Bing and the IndexNow engines know about
it — then reports what they think of it. Everything goes through the APIs; the owner clicks only where
an API does not exist.

## Overview

- **Google Search Console** — `sc-domain:` property, DNS TXT verification through the Site
  Verification API, owner added, sitemap, URL inspection, search analytics
- **Bing Webmaster Tools** — add site, CNAME verification, sitemap, URL batch submit, crawl issues
- **IndexNow** — Cloudflare Crawler Hints by default, manual pings for launches
- **Monitoring** — sitemap reads, index coverage, queries, with at most three actions per report

## Rules

1. **Live first.** Run only after the production site serves `robots.txt` and the sitemap with no
   `noindex`. The [playbook](docs/playbook.md) starts with that check.
2. **No private data in repos.** Service account emails, owner emails and API keys come from the
   environment. See [secrets](docs/secrets.md).
3. **Keep verification in place.** Removing the TXT record, CNAME, file or meta tag unverifies the site.

## Quick start

```bash
GTOKEN=$(gcloud auth application-default print-access-token \
  --scopes=https://www.googleapis.com/auth/webmasters,https://www.googleapis.com/auth/siteverification)
curl -s https://www.googleapis.com/webmasters/v3/sites -H "Authorization: Bearer $GTOKEN" | jq
curl -s "https://ssl.bing.com/webmaster/api.svc/json/GetUserSites?apikey=$BING_WEBMASTER_API_KEY" | jq
```

## Documentation

- **[Playbook](docs/playbook.md)** — pre-flight checks and the seven launch steps
- **[Google Search Console](docs/google-search-console.md)** — auth, verify, owner, property, sitemap, checks
- **[Bing Webmaster](docs/bing-webmaster.md)** — key, add, verify, sitemap, URL submit, checks
- **[IndexNow](docs/indexnow.md)** — Crawler Hints default, key file, ping, response codes
- **[Monitoring](docs/monitoring.md)** — what to pull, how to read it, report shape
- **[Secrets](docs/secrets.md)** — vault items, Varlock schema, key file handling

## Common workflows

- **New site:** [playbook](docs/playbook.md), steps 1–7.
- **Existing site, already in Search Console:** owner adds the service account as Owner; then
  sitemap, Bing (or Bing's import from Search Console) and IndexNow.
- **"Is it indexed?":** URL inspection on the pages in question, then [monitoring](docs/monitoring.md).

## Related skills

- `cloudflare-domains` — DNS records for verification, Crawler Hints
- `seo-geo` — what to fix when pages are not indexed or not ranking
- `umami` — traffic once visitors arrive

## Sync & Update

No synced sources: the guides are authored from the Google API discovery documents, the Bing
Webmaster API reference and the IndexNow protocol. When an API call fails with a 404 or an unknown
field, re-read the source named at the top of the guide and update the guide.
