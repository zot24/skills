> Source: https://docs.firecrawl.dev/features/monitoring-page.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Page monitoring

> Watch known URLs and get alerted on meaningful page changes

Page monitoring watches URLs you already know about. Each check scrapes every URL in the target, diffs it against the last retained snapshot, and reports whether the page is `same`, `changed`, `new`, `removed`, or `error`. It's the right choice for pricing pages, changelogs, docs pages, job posts, status pages, or any known URL where a small change matters.

This page covers the `scrape` target. Scheduling, goals and judging, change tracking, notifications, and pricing are shared across all monitor types. See the [Monitoring overview](/features/monitoring).

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

## Create a page monitor

Create a monitor with a `scrape` target that lists one or more explicit URLs:

<CodeGroup>
  ```python Python
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

  ```js Node
  import Firecrawl from "@mendable/firecrawl-js";

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

  ```bash cURL
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
</CodeGroup>

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

By default a page monitor diffs the page's markdown. To alert only when a **specific field** changes, such as a price, a headline, an in-stock flag, or the items in a list, add a `changeTracking` format to the target's `scrapeOptions`. See [Change tracking](/features/monitoring#change-tracking) for JSON mode and mixed mode.

## Shared configuration

* [Schedules](/features/monitoring#schedules): cron or natural-language cadence, minimum 5 minutes.
* [Goals and judging](/features/monitoring#goals-and-judging): alert only on meaningful changes.
* [Notifications](/features/monitoring#notifications): webhook and email delivery.
* [Check results](/features/monitoring#check-results): inspect each check and its per-page diffs.
* [Pricing](/features/monitoring#pricing): 1 credit per URL per check, plus optional judging.
