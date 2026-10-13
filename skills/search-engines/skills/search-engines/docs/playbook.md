<!-- Authored for this skill. Not synced from upstream. -->

# Launch playbook

Run after the site is live on its domain, with `robots.txt` and a sitemap served. Each step names the
guide with the commands.

## Before you start

```bash
curl -s https://acmewidgets.com/robots.txt            # must not Disallow: /  and should list the sitemap
curl -s -o /dev/null -w "%{http_code}\n" https://acmewidgets.com/sitemap-index.xml   # 200
curl -sI https://acmewidgets.com/ | grep -i x-robots-tag                            # must be empty
```

A preview build that ships `noindex` to production is the most common launch bug. Fix it before any
step below.

## Steps

| # | Step | Guide |
|---|---|---|
| 1 | Google: DNS TXT token → verify → add owner | [google-search-console](google-search-console.md) §1–2 |
| 2 | Google: add `sc-domain:` property, submit sitemap | [google-search-console](google-search-console.md) §3 |
| 3 | Bing: add site, verify by CNAME | [bing-webmaster](bing-webmaster.md) §1–2 |
| 4 | Bing: submit sitemap | [bing-webmaster](bing-webmaster.md) §3 |
| 5 | IndexNow: Crawler Hints on (Cloudflare) | [indexnow](indexnow.md) |
| 6 | Ping the launch URLs once (IndexNow) | [indexnow](indexnow.md) |
| 7 | Ask the owner to **Request indexing** for the home page and the money page in Google | — |

DNS records in steps 1 and 3 go through the `cloudflare-domains` skill.

## Verify

- Google: `sites.list` shows `sc-domain:acmewidgets.com` with `siteOwner`; the sitemap shows
  `lastDownloaded` within a day.
- Bing: `GetUserSites` shows `IsVerified: true`; `GetFeeds` lists the sitemap.
- The owner sees both properties in their own dashboards.

## After launch

Run the checks in [monitoring](monitoring.md) one week and four weeks after launch, then monthly.
