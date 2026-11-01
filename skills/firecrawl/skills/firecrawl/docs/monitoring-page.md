> Source: https://docs.firecrawl.dev/features/monitoring-page.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Page monitoring

> Watch known URLs and get alerted on meaningful page changes

Page monitoring watches URLs you already know about. Each check scrapes every URL in the target, diffs it against the last retained snapshot, and reports whether the page is `same`, `changed`, `new`, `removed`, or `error`. It's the right choice for pricing pages, changelogs, docs pages, job posts, status pages, or any known URL where a small change matters.

This page covers the `scrape` target. Scheduling, goals and judging, change tracking, notifications, and pricing are shared across all monitor types. See the [Monitoring overview](https://docs.firecrawl.dev/features/monitoring.md).

## Create a page monitor

Create a monitor with a `scrape` target that lists one or more explicit URLs:

```python Python theme={null}
from firecrawl import Firecrawl

firecrawl = Firecrawl(
  # Monitor endpoints require an API key:
  api_key="fc-YOUR-API-KEY",
)

monitor = firecrawl.create_monitor(
    name="Hacker News AI monitor",
    schedule={"text": "every 30 minutes", "timezone": "UTC"},
    goal=(
        "Alert when a new Hacker News story related to AI enters the top 10. "
        "Ignore changes to stories that are not about AI. "
        "Do not alert on changes outside the top 10."
    ),
    targets=[
        {
            "type": "scrape",
            "urls": ["https://news.ycombinator.com"],
        }
    ],
    notification={
        "email": {
            "enabled": True,
            "recipients": ["alerts@example.com"],
            "includeDiffs": True,
        }
    },
)

print(monitor.id)
```

```js Node theme={null}
import Firecrawl from "firecrawl";

const firecrawl = new Firecrawl({
  // Monitor endpoints require an API key:
  apiKey: "fc-YOUR-API-KEY",
});

const monitor = await firecrawl.createMonitor({
  name: "Hacker News AI monitor",
  schedule: { text: "every 30 minutes", timezone: "UTC" },
  goal:
    "Alert when a new Hacker News story related to AI enters the top 10. Ignore changes to stories that are not about AI. Do not alert on changes outside the top 10.",
  notification: {
    email: {
      enabled: true,
      recipients: ["alerts@example.com"],
      includeDiffs: true,
    },
  },
  targets: [
    {
      type: "scrape",
      urls: ["https://news.ycombinator.com"],
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
    "name": "Hacker News AI monitor",
    "schedule": {
      "text": "every 30 minutes",
      "timezone": "UTC"
    },
    "goal": "Alert when a new Hacker News story related to AI enters the top 10. Ignore changes to stories that are not about AI. Do not alert on changes outside the top 10.",
    "notification": {
      "email": {
        "enabled": true,
        "recipients": ["alerts@example.com"],
        "includeDiffs": true
      }
    },
    "targets": [
      {
        "type": "scrape",
        "urls": ["https://news.ycombinator.com"]
      }
    ]
  }'
```

You can also create monitors from the Firecrawl CLI:

```bash CLI theme={null}
firecrawl monitor create --name "Hacker News AI" \
  --schedule "every 30 minutes" \
  --goal "Alert when a new Hacker News story related to AI enters the top 10. Ignore changes to stories that are not about AI. Do not alert on changes outside the top 10." \
  --page https://news.ycombinator.com
```

## Scrape target

A `scrape` target requires `type` and a `urls` array with at least one URL. Scrape options are passed through to the underlying scrape jobs. Monitor-triggered scrapes default `maxAge` to `0`, so each check performs a fresh scrape unless you explicitly set a different `maxAge`.

```json Scrape target theme={null}
{
  "type": "scrape",
  "urls": ["https://example.com/pricing"],
  "scrapeOptions": {
    "formats": ["markdown"],
    "maxAge": 0
  }
}
```

## Detecting field-level changes

By default a page monitor diffs the page's markdown. To alert only when a **specific field** changes, such as a price, a headline, an in-stock flag, or the items in a list, add a `changeTracking` format to the target's `scrapeOptions`. See [Change tracking](https://docs.firecrawl.dev/features/monitoring.md#change-tracking) for JSON mode and mixed mode.

## Shared configuration

* [Schedules](https://docs.firecrawl.dev/features/monitoring.md#schedules): cron or natural-language cadence, minimum 5 minutes.
* [Goals and judging](https://docs.firecrawl.dev/features/monitoring.md#goals-and-judging): alert only on meaningful changes.
* [Notifications](https://docs.firecrawl.dev/features/monitoring.md#notifications): webhook and email delivery.
* [Check results](https://docs.firecrawl.dev/features/monitoring.md#check-results): inspect each check and its per-page diffs.
* [Pricing](https://docs.firecrawl.dev/features/monitoring.md#pricing): 1 credit per URL per check, plus optional judging.


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
