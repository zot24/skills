<!-- Authored for this skill. Not synced from upstream. -->

# Monitoring

A short report the agent can produce on request or on a schedule. Commands are in
[google-search-console](google-search-console.md) and [bing-webmaster](bing-webmaster.md).

## What to pull

| Signal | Google | Bing |
|---|---|---|
| Is the sitemap read? | `sitemaps.list` → `lastDownloaded`, `errors`, `warnings` | `GetFeeds` |
| Are key pages indexed? | `urlInspection.index.inspect` → `verdict`, `coverageState` | `GetUrlInfo` |
| Crawl problems | `coverageState` on inspected pages | `GetCrawlIssues` |
| Queries | `searchAnalytics.query`, dimension `query` | `GetQueryStats` |
| Pages | `searchAnalytics.query`, dimension `page` | `GetPageStats` |

Inspect at most the pages that matter (home, pricing, top landing pages). URL inspection has a daily
quota per property.

## How to read it

- `coverageState: "Discovered - currently not indexed"` on a new site is normal for weeks. On an old
  site it points at thin or duplicate content — hand it to the `seo-geo` skill.
- `googleCanonical` differs from the page's own canonical: fix the canonical or the duplicate.
- High impressions, low CTR on a query: rewrite the title and description for that page.
- Position 8–20 on a query with impressions: the page is close; improve its content for that query.

## Report shape

One table per engine, then at most three actions, each tied to a page and a number. Pair it with
Umami traffic from the `umami` skill when the owner asks "is it working?".
