# Search Engines

Expert skill for getting a live site into Google and Bing through their APIs, and reporting how it is
doing there.

## Features

- **Google Search Console** — Domain property verified by DNS TXT, owner added, sitemap submitted
- **Bing Webmaster Tools** — site added, verified by CNAME, sitemap submitted
- **IndexNow** — Cloudflare Crawler Hints by default, manual pings for launches
- **Checks** — URL inspection, search analytics, crawl issues, a short monitoring report

## Commands

```bash
/search-engines:search-engines launch acmewidgets.com   # full playbook
/search-engines:search-engines google acmewidgets.com
/search-engines:search-engines bing acmewidgets.com
/search-engines:search-engines indexnow https://acmewidgets.com/pricing
/search-engines:search-engines inspect https://acmewidgets.com/pricing
/search-engines:search-engines report acmewidgets.com
```

## Safety

- Runs only after the production site is live with no `noindex`.
- Keys and emails come from 1Password; nothing private goes into a repo.

## Sources

Authored from the [Search Console API](https://developers.google.com/webmaster-tools) and
[Site Verification API](https://developers.google.com/site-verification) discovery documents, the
[Bing Webmaster API](https://learn.microsoft.com/en-us/bingwebmaster/) reference and the
[IndexNow](https://www.indexnow.org/documentation) protocol.
