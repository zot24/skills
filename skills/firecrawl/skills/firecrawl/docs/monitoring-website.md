> Source: https://docs.firecrawl.dev/features/monitoring-website.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Website monitoring

> Crawl a website on a schedule and detect changes across every discovered page

Website monitoring watches a whole site instead of a fixed list of URLs. Each check runs a crawl for the target `url`, scrapes every discovered page, and reconciles the result against the last retained snapshot. That catches added, changed, and removed pages, not just edits to pages you already named. It's the right choice for docs sites, blogs, changelogs, help centers, and competitor sites.

This page covers the `crawl` target. Scheduling, goals and judging, change tracking, notifications, and pricing are shared across all monitor types. See the [Monitoring overview](https://docs.firecrawl.dev/features/monitoring.md).

## Create a website monitor

Create a monitor with a `crawl` target to diff every page discovered by a crawl on each check:

```python Python theme={null}
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

```js Node theme={null}
import Firecrawl from "firecrawl";

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

```bash cURL theme={null}
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

To alert on specific structured fields across the crawled pages, add a `changeTracking` format to `scrapeOptions`. See [Change tracking](https://docs.firecrawl.dev/features/monitoring.md#change-tracking).

## Shared configuration

* [Schedules](https://docs.firecrawl.dev/features/monitoring.md#schedules): cron or natural-language cadence, minimum 5 minutes.
* [Goals and judging](https://docs.firecrawl.dev/features/monitoring.md#goals-and-judging): alert only on meaningful changes.
* [Notifications](https://docs.firecrawl.dev/features/monitoring.md#notifications): webhook and email delivery.
* [Check results](https://docs.firecrawl.dev/features/monitoring.md#check-results): inspect each check and its per-page diffs.
* [Pricing](https://docs.firecrawl.dev/features/monitoring.md#pricing): 1 credit per discovered page per check, plus optional judging.


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
