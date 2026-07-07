> Source: https://docs.firecrawl.dev/features/monitoring-website.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Website monitoring

> Crawl a website on a schedule and detect changes across every discovered page

Website monitoring watches a whole site instead of a fixed list of URLs. Each check runs a crawl for the target `url`, scrapes every discovered page, and reconciles the result against the last retained snapshot. That catches added, changed, and removed pages, not just edits to pages you already named. It's the right choice for docs sites, blogs, changelogs, help centers, and competitor sites.

This page covers the `crawl` target. Scheduling, goals and judging, change tracking, notifications, and pricing are shared across all monitor types. See the [Monitoring overview](/features/monitoring).

<div className="firecrawl-cta-box" style={{ opacity: 0.6 }}>
  <div style={{ display: "flex", alignItems: "flex-start", gap: "8px", marginBottom: "8px" }}>
    <Icon icon="sack-dollar" color="#9ca3af" size={22} />

    <div className="firecrawl-cta-title" style={{ margin: 0, color: "#9ca3af" }}>
      <span>Expired: Bounty for /monitor feedback</span>
    </div>
  </div>

  <p className="firecrawl-cta-description">
    All interviewees eligible for the bounty reward have been contacted. Keep an eye on future bounties within our docs!
  </p>
</div>

## Create a website monitor

Create a monitor with a `crawl` target to diff every page discovered by a crawl on each check:

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl

  firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

  monitor = firecrawl.create_monitor(
      name="Docs monitor",
      schedule={"cron": "7-59/15 * * * *", "timezone": "UTC"},
      goal="Notify me when docs pages add, remove, or materially change API behavior",
      targets=[
          {
              "type": "crawl",
              "url": "https://example.com/docs",
              "crawlOptions": {
                  "limit": 100,
                  "maxDiscoveryDepth": 3,
              },
          }
      ],
      webhook={
          "url": "https://example.com/webhooks/firecrawl",
          "events": ["monitor.page", "monitor.check.completed"],
      },
  )

  print(monitor.id)
  ```

  ```js Node
  import Firecrawl from "@mendable/firecrawl-js";

  const firecrawl = new Firecrawl({ apiKey: "fc-YOUR-API-KEY" });

  const monitor = await firecrawl.createMonitor({
    name: "Docs monitor",
    schedule: { cron: "7-59/15 * * * *", timezone: "UTC" },
    webhook: {
      url: "https://example.com/webhooks/firecrawl",
      events: ["monitor.page", "monitor.check.completed"],
    },
    goal: "Notify me when docs pages add, remove, or materially change API behavior",
    targets: [
      {
        type: "crawl",
        url: "https://example.com/docs",
        crawlOptions: {
          limit: 100,
          maxDiscoveryDepth: 3,
        },
      },
    ],
  });

  console.log(monitor.id);
  ```

  ```bash cURL
  curl -s -X POST "https://api.firecrawl.dev/v2/monitor" \
    -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
    -H "Content-Type: application/json" \
    -d '{
      "name": "Docs monitor",
      "schedule": {
        "cron": "7-59/15 * * * *",
        "timezone": "UTC"
      },
      "webhook": {
        "url": "https://example.com/webhooks/firecrawl",
        "events": ["monitor.page", "monitor.check.completed"]
      },
      "goal": "Notify me when docs pages add, remove, or materially change API behavior",
      "targets": [
        {
          "type": "crawl",
          "url": "https://example.com/docs",
          "crawlOptions": {
            "limit": 100,
            "maxDiscoveryDepth": 3
          }
        }
      ]
    }'
  ```
</CodeGroup>

## Crawl target

A `crawl` target requires `type` and a single `url`. Use `crawlOptions` for crawl behavior and `scrapeOptions` for how each discovered page is scraped:

```json Crawl target theme={null}
{
  "type": "crawl",
  "url": "https://example.com/docs",
  "crawlOptions": {
    "limit": 100,
    "includePaths": ["/docs"]
  },
  "scrapeOptions": {
    "formats": ["markdown"]
  }
}
```

Common `crawlOptions` fields:

* `limit`: Maximum number of pages a check will crawl.
* `maxDiscoveryDepth`: How many links deep from the starting `url` to discover pages.
* `maxDepth`: Maximum crawl depth.
* `includePaths`: Only monitor URLs matching these path patterns (for example, `/docs`).
* `excludePaths`: Skip URLs matching these path patterns.

As with page monitors, monitor-triggered scrapes default `maxAge` to `0`, so each check re-scrapes discovered pages fresh unless you set a different `maxAge` in `scrapeOptions`.

## What each check reports

A crawl check reconciles every discovered page against the previous check and records a per-page status:

* `same`: The page was discovered again and did not change.
* `changed`: The page was discovered again and changed.
* `new`: The page was discovered for the first time.
* `removed`: A page from the previous check was no longer discovered.
* `error`: The page could not be checked.

To alert on specific structured fields across the crawled pages, add a `changeTracking` format to `scrapeOptions`. See [Change tracking](/features/monitoring#change-tracking).

## Shared configuration

* [Schedules](/features/monitoring#schedules): cron or natural-language cadence, minimum 5 minutes.
* [Goals and judging](/features/monitoring#goals-and-judging): alert only on meaningful changes.
* [Notifications](/features/monitoring#notifications): webhook and email delivery.
* [Check results](/features/monitoring#check-results): inspect each check and its per-page diffs.
* [Pricing](/features/monitoring#pricing): 1 credit per discovered page per check, plus optional judging.
