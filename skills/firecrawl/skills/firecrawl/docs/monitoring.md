> Source: https://docs.firecrawl.dev/features/monitoring.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Monitoring

> Schedule recurring checks, detect changes, and get notified by webhook or email

Firecrawl monitoring runs recurring checks and notifies you or your agent when something changes or appears. Use `/monitor` to [watch known pages](/features/monitoring-page), [crawl a website on a schedule](/features/monitoring-website), or [run an always-on web search](/features/monitoring-web-scale) for new results that match a goal.

All monitor types share the same workflow: choose one or more targets, set a schedule, add an optional plain-language goal, and receive webhook or email notifications when something matters. This page covers shared configuration. For target-specific setup and examples, go to the [Page](/features/monitoring-page), [Website](/features/monitoring-website), or [Entire web-scale](/features/monitoring-web-scale) monitoring page.


    Watch one or more known URLs, diff each scrape against the last snapshot, and alert on meaningful page changes.


    Crawl a site on a schedule, detect added, changed, or removed pages, and notify your webhook or inbox.


    Run recurring web searches and alert when a new result appears that matches your goal.


Each check records page-level results as `same`, `new`, `changed`, `removed`, or `error`. You can receive a webhook as each monitored page finishes, a webhook for every completed check, email summaries when changes or errors happen, or any combination of those notifications.

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

## Targets

Every monitor has one or more **targets**. The target type determines what each check does:

| Target   | What it watches                  | Setup                                                         |
| -------- | -------------------------------- | ------------------------------------------------------------- |
| `scrape` | Known URLs you name              | [Page monitoring](/features/monitoring-page)                  |
| `crawl`  | Every page discovered by a crawl | [Website monitoring](/features/monitoring-website)            |
| `search` | New results across the whole web | [Entire web-scale monitoring](/features/monitoring-web-scale) |

Each monitor accepts 1–50 targets, and you can mix target types in a single monitor. `retentionDays` defaults to `30` and can be set up to `365`.

Every create call returns the new monitor with its normalized cron, computed `nextRunAt`, and `estimatedCreditsPerMonth`. When judging is enabled, `estimatedCreditsPerMonth` is an upper-bound estimate because judge credits are only charged for changed pages that are actually judged:

```json Response
{
  "success": true,
  "data": {
    "id": "019df960-06e7-7383-9d89-82c0113dc31a",
    "name": "Hacker News AI monitor",
    "status": "active",
    "schedule": {
      "cron": "*/30 * * * *",
      "timezone": "UTC"
    },
    "nextRunAt": "2026-05-17T16:00:00.000Z",
    "lastRunAt": null,
    "currentCheckId": null,
    "goal": "Alert when a new Hacker News story related to AI enters the top 10. Ignore changes to stories that are not about AI. Do not alert on changes outside the top 10.",
    "judgeEnabled": true,
    "targets": [
      {
        "id": "019df960-09bb-7c11-8001-1f12f50ab1c2",
        "type": "scrape",
        "urls": ["https://news.ycombinator.com"]
      }
    ],
    "webhook": null,
    "notification": {
      "email": {
        "enabled": true,
        "recipients": ["alerts@example.com"],
        "includeDiffs": true
      }
    },
    "retentionDays": 30,
    "estimatedCreditsPerMonth": 2880,
    "lastCheckSummary": null,
    "createdAt": "2026-05-17T15:30:00.000Z",
    "updatedAt": "2026-05-17T15:30:00.000Z"
  }
}
```

## Goals and judging

Add a plain-language `goal` when you only want to be alerted for meaningful changes. If `goal` is present and `judgeEnabled` is omitted, Firecrawl enables judging automatically. Judging runs on changed pages and returns a `judgment` with `meaningful`, `confidence`, `reason`, and `meaningfulChanges`.

How the goal is applied depends on the target: [page](/features/monitoring-page) and [website](/features/monitoring-website) monitors judge changed pages, while [entire web-scale monitors](/features/monitoring-web-scale#judging) judge each new search result.

Use `judgeEnabled: false` if you want to store a goal without judging changes yet. The judge only runs when the monitor has both `judgeEnabled` and a non-empty `goal`.


  A `goal` is required for `search` targets (entire web-scale monitoring) unless you set `judgeEnabled: false`. It is optional for `scrape` and `crawl` targets.


  Each check always charges for the underlying scrapes or crawls. If judging is enabled, the judge adds 1 credit for each changed page it validates. Checks with no changed pages do not use judge credits.


Good goals are short and explicit: say what should trigger an alert, restate any scope such as top N, price, role type, company, region, topic, status, or entity, and include exclusions only when they are part of the intent. If the goal is broad, keep it broad; for example, "any change" should not add noise filters that would hide changes.

For example, a monitor with this goal:

```text
Alert when a new Hacker News story related to AI enters the top 10. Ignore changes to stories that are not about AI. Do not alert on changes outside the top 10.
```

could produce a `monitor.page` webhook like this when a matching story enters scope:

```json monitor.page
{
  "success": true,
  "type": "monitor.page",
  "id": "019df960-5f2a-75fb-a98b-bd2d32ca67d4",
  "webhookId": "f1e2d3c4-0000-0000-0000-000000000000",
  "data": [
    {
      "monitorId": "019df960-06e7-7383-9d89-82c0113dc31a",
      "checkId": "019df960-5f2a-75fb-a98b-bd2d32ca67d4",
      "url": "https://news.ycombinator.com",
      "status": "changed",
      "previousScrapeId": "019df94f-82c3-7e41-81f0-00c72b2d9c52",
      "currentScrapeId": "019df960-73ee-7ac2-97a9-fb0e442c21f1",
      "error": null,
      "isMeaningful": true,
      "judgment": {
        "meaningful": true,
        "confidence": "high",
        "reason": "A new AI-related story entered the Hacker News top 10.",
        "meaningfulChanges": [
          {
            "type": "added",
            "after": "4. Show HN: Open-source AI coding assistant",
            "reason": "This is a new AI-related story inside the top 10."
          }
        ]
      },
      "diff": {
        "text": "--- previous\n+++ current\n@@ -1,5 +1,6 @@\n # Hacker News\n 1. Database internals for beginners\n 2. A new approach to CSS\n 3. Building reliable queues\n+4. Show HN: Open-source AI coding assistant\n"
      }
    }
  ],
  "metadata": {
    "environment": "production"
  }
}
```

## Schedules

Schedules can be provided as cron or as simple natural language text.

<CodeGroup>
  ```json Cron
  {
    "schedule": {
      "cron": "*/30 * * * *",
      "timezone": "UTC"
    }
  }
  ```

  ```json Text
  {
    "schedule": {
      "text": "every 30 minutes",
      "timezone": "UTC"
    }
  }
  ```
</CodeGroup>

Supported natural language examples:

* `every 30 minutes`
* `every 15 minutes starting at :07`
* `hourly`
* `every 2 hours`
* `daily`
* `daily at 9:00`
* `daily at 9am`
* `daily at 5:30 PM`
* `weekly`

The minimum interval is 5 minutes. API responses always return the normalized cron expression. For text schedules, `timezone` controls when phrases like `daily at 9am` run. Text schedules are spread by monitor ID before they are converted to cron so many monitors do not all run at the same instant.

## Change tracking

[Page](/features/monitoring-page) and [website](/features/monitoring-website) monitors diff each page's markdown by default and report `same`, `changed`, `new`, `removed`, or `error`. When you want to detect changes in **specific structured fields** (price, headline, in-stock flag, the items in a list, etc.), enable JSON-mode change tracking by adding a `changeTracking` format with `modes: ["json"]` to the target's `scrapeOptions`.


  Change tracking applies to `scrape` and `crawl` targets. Entire web-scale (`search`) monitors alert on new results rather than diffing known pages. See [Statuses and dedup](/features/monitoring-web-scale#statuses-and-dedup).


### Markdown mode (default)

When `scrapeOptions.formats` is just `["markdown"]`, each changed page in the check response carries a unified text diff plus a [parseDiff](https://github.com/sergeyt/parse-diff)-style AST:

```json Markdown-mode diff
{
  "diff": {
    "text": "--- previous\n+++ current\n@@ -1,3 +1,3 @@\n # Pricing\n-Starter — $19/mo\n+Starter — $24/mo\n",
    "json": {
      "files": [
        {
          "from": "previous",
          "to": "current",
          "chunks": [
            {
              "content": "@@ -1,3 +1,3 @@",
              "changes": []
            }
          ]
        }
      ]
    }
  }
}
```

### JSON mode

Pass a `changeTracking` format with `modes: ["json"]` together with a JSON schema (or a `prompt`) describing the fields you care about. Firecrawl extracts that JSON on every check and emits a **per-field diff** keyed by the field path, plus a `snapshot.json` with the full current extraction so consumers don't need to re-fetch the underlying scrape.

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl
  from pydantic import BaseModel
  from typing import List

  firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")


  class Plan(BaseModel):
      name: str
      price: str
      features: List[str]


  class Pricing(BaseModel):
      plans: List[Plan]


  monitor = firecrawl.create_monitor(
      name="Pricing monitor",
      schedule={"text": "hourly", "timezone": "UTC"},
      goal="Notify me when a pricing tier, price, or headline feature changes",
      targets=[
          {
              "type": "scrape",
              "urls": ["https://example.com/pricing"],
              "scrapeOptions": {
                  "formats": [
                      {
                          "type": "changeTracking",
                          "modes": ["json"],
                          "prompt": "Extract pricing tiers and headline features for each plan.",
                          "schema": Pricing.model_json_schema(),
                      }
                  ]
              },
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
  import { z } from "zod";

  const firecrawl = new Firecrawl({ apiKey: "fc-YOUR-API-KEY" });

  const pricingSchema = z.object({
    plans: z.array(
      z.object({
        name: z.string(),
        price: z.string(),
        features: z.array(z.string()),
      }),
    ),
  });

  const monitor = await firecrawl.createMonitor({
    name: "Pricing monitor",
    schedule: { text: "hourly", timezone: "UTC" },
    goal: "Notify me when a pricing tier, price, or headline feature changes",
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
        urls: ["https://example.com/pricing"],
        scrapeOptions: {
          formats: [
            {
              type: "changeTracking",
              modes: ["json"],
              prompt: "Extract pricing tiers and headline features for each plan.",
              schema: pricingSchema,
            },
          ],
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
      "name": "Pricing monitor",
      "schedule": {
        "text": "hourly",
        "timezone": "UTC"
      },
      "goal": "Notify me when a pricing tier, price, or headline feature changes",
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
          "urls": ["https://example.com/pricing"],
          "scrapeOptions": {
            "formats": [
              {
                "type": "changeTracking",
                "modes": ["json"],
                "prompt": "Extract pricing tiers and headline features for each plan.",
                "schema": {
                  "type": "object",
                  "properties": {
                    "plans": {
                      "type": "array",
                      "items": {
                        "type": "object",
                        "properties": {
                          "name": { "type": "string" },
                          "price": { "type": "string" },
                          "features": {
                            "type": "array",
                            "items": { "type": "string" }
                          }
                        }
                      }
                    }
                  }
                }
              }
            ]
          }
        }
      ]
    }'
  ```
</CodeGroup>

The diff payload uses JSON paths into the extraction as keys. Each value is a `{previous, current}` pair:

```json JSON-mode diff
{
  "diff": {
    "json": {
      "plans[0].price": {
        "previous": "$19/mo",
        "current": "$24/mo"
      },
      "plans[1].features[2]": {
        "previous": "10 GB storage",
        "current": "25 GB storage"
      }
    }
  },
  "snapshot": {
    "json": {
      "plans": [
        {
          "name": "Starter",
          "price": "$24/mo",
          "features": ["Up to 3 users", "Basic analytics", "Email support"]
        },
        {
          "name": "Pro",
          "price": "$49/mo",
          "features": ["Unlimited users", "Advanced analytics", "25 GB storage"]
        }
      ]
    }
  }
}
```


  Even if no tracked field changed but the surrounding markdown did, JSON-mode monitors still report `same` unless you also enable git-diff (see mixed mode below). The diff focuses purely on the fields in your schema.


### Mixed mode (JSON + git-diff)

If you want both the structured per-field diff **and** the raw markdown unified diff, pass both modes:

```json Mixed target (JSON + git-diff)
{
  "type": "scrape",
  "urls": ["https://example.com/pricing"],
  "scrapeOptions": {
    "formats": [
      {
        "type": "changeTracking",
        "modes": ["json", "git-diff"],
        "prompt": "Extract pricing tiers and headline features for each plan.",
        "schema": {
          "type": "object",
          "properties": {
            "plans": {
              "type": "array",
              "items": {
                "type": "object",
                "properties": {
                  "name": { "type": "string" },
                  "price": { "type": "string" }
                }
              }
            }
          }
        }
      }
    ]
  }
}
```

The check response then contains both `diff.text` (markdown sidecar) and `diff.json` (per-field diff), along with the `snapshot.json` extraction:

```json Mixed-mode diff (JSON + git-diff)
{
  "diff": {
    "text": "--- previous\n+++ current\n@@ -1,3 +1,3 @@\n # Pricing\n-Starter — $19/mo\n+Starter — $24/mo\n",
    "json": {
      "plans[0].price": {
        "previous": "$19/mo",
        "current": "$24/mo"
      }
    }
  },
  "snapshot": {
    "json": {
      "plans": [
        { "name": "Starter", "price": "$24/mo" },
        { "name": "Pro", "price": "$49/mo" }
      ]
    }
  }
}
```

A mixed-mode page reports `changed` whenever **either** surface changed.

## Notifications

### Webhooks

When a monitor has a `webhook`, Firecrawl can send two monitor events:

* `monitor.page`: Sent as each monitored scrape finishes in the scrape worker.
* `monitor.check.completed`: Sent after the full check is reconciled. Includes check status and summary counts. Use `monitor.page` events or the monitor check API for page-level results.

`monitor.page` includes `isMeaningful` and `judgment` when meaningful-change judging ran for a changed page.

```json Webhook config
{
  "webhook": {
    "url": "https://example.com/webhooks/firecrawl",
    "headers": {
      "Authorization": "Bearer your-secret"
    },
    "metadata": {
      "environment": "production"
    },
    "events": ["monitor.page", "monitor.check.completed"]
  }
}
```

`monitor.page` payload:

```json monitor.page
{
  "success": true,
  "type": "monitor.page",
  "id": "019df960-5f2a-75fb-a98b-bd2d32ca67d4",
  "webhookId": "f1e2d3c4-0000-0000-0000-000000000000",
  "data": [
    {
      "monitorId": "019df960-06e7-7383-9d89-82c0113dc31a",
      "checkId": "019df960-5f2a-75fb-a98b-bd2d32ca67d4",
      "url": "https://example.com/blog",
      "status": "changed",
      "previousScrapeId": "019df94f-82c3-7e41-81f0-00c72b2d9c52",
      "currentScrapeId": "019df960-73ee-7ac2-97a9-fb0e442c21f1",
      "error": null,
      "isMeaningful": true,
      "judgment": {
        "meaningful": true,
        "confidence": "high",
        "reason": "The page headline changed to announce a new release cadence.",
        "meaningfulChanges": [
          {
            "type": "changed",
            "before": "Welcome to our weekly update.",
            "after": "Welcome to our weekly update — now with daily releases!",
            "reason": "The headline changed in a way that matches the monitor goal."
          }
        ]
      },
      "diff": {
        "text": "--- previous\n+++ current\n@@ -1,3 +1,3 @@\n # Latest posts\n-Welcome to our weekly update.\n+Welcome to our weekly update — now with daily releases!\n"
      }
    }
  ],
  "metadata": {
    "environment": "production"
  }
}
```

`monitor.check.completed` payload:

```json monitor.check.completed
{
  "success": true,
  "type": "monitor.check.completed",
  "id": "019df960-5f2a-75fb-a98b-bd2d32ca67d4",
  "webhookId": "f1e2d3c4-0001-0000-0000-000000000000",
  "data": [
    {
      "monitorId": "019df960-06e7-7383-9d89-82c0113dc31a",
      "checkId": "019df960-5f2a-75fb-a98b-bd2d32ca67d4",
      "status": "completed",
      "summary": {
        "totalPages": 2,
        "same": 1,
        "changed": 1,
        "new": 0,
        "removed": 0,
        "error": 0
      }
    }
  ],
  "metadata": {
    "environment": "production"
  }
}
```

`success` is `true` when the check completed without page errors. It is `false` for failed or partial checks, and `error` contains the failure reason when available.

### Email

Email summaries are sent only when a check has changed, new, removed, or errored pages.

```json Email config
{
  "notification": {
    "email": {
      "enabled": true,
      "recipients": ["alerts@example.com"],
      "includeDiffs": true
    }
  }
}
```

When a monitor has a goal and judging enabled, email summaries prioritize meaningful changed pages. If every changed page is judged as noise and there are no new, removed, or errored pages, the email is suppressed.

If `recipients` is omitted, Firecrawl sends to team members who are eligible for system alert emails.
You can configure up to 25 explicit recipients.

#### Recipient confirmation process

When a new recipient is added to a monitor, Firecrawl sends them an email containing a confirmation link. This ensures they explicitly agree to receive notifications for that monitor. If the recipient is already a member of the team, no confirmation is required.

## Check results

Use `GET /v2/monitor/{monitorId}/checks` to list checks and `GET /v2/monitor/{monitorId}/checks/{checkId}` to inspect a check. The SDKs auto-paginate by default.

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl

  firecrawl = Firecrawl(api_key="fc-YOUR-API-KEY")

  check = firecrawl.get_monitor_check(monitor_id, check_id, limit=25, status="changed")

  for page in check.pages:
      print(page.url, page.status)

      if page.judgment:
          print(page.judgment.meaningful, page.judgment.reason)

      if page.diff and page.diff.text:
          print(page.diff.text)

      if page.snapshot and page.snapshot.json:
          print(page.snapshot.json)
  ```

  ```js Node
  import Firecrawl from "@mendable/firecrawl-js";

  const firecrawl = new Firecrawl({ apiKey: "fc-YOUR-API-KEY" });

  const check = await firecrawl.getMonitorCheck(monitorId, checkId, {
    limit: 25,
    status: "changed",
  });

  for (const page of check.pages) {
    console.log(page.url, page.status);

    if (page.judgment) {
      console.log(page.judgment.meaningful, page.judgment.reason);
    }

    if (page.diff?.text) {
      console.log(page.diff.text);
    }

    if (page.snapshot?.json) {
      console.log(page.snapshot.json);
    }
  }
  ```

  ```bash cURL
  curl "https://api.firecrawl.dev/v2/monitor/$MONITOR_ID/checks/$CHECK_ID?limit=25&status=changed" \
    -H "Authorization: Bearer $FIRECRAWL_API_KEY"
  ```
</CodeGroup>

List checks can be filtered by check `status`: `queued`, `running`, `completed`, `failed`, `partial`, or `skipped_overlap`.

The check detail response includes `estimatedCredits`, `actualCredits`, summary counts, and a paginated `pages` array. `estimatedCredits` is the upper-bound reservation for the check; `actualCredits` is the final amount charged after Firecrawl knows how many pages changed and needed judging. Use the top-level `next` URL to fetch the next page of results, matching crawl pagination. You can filter pages by `status`: `same`, `new`, `changed`, `removed`, or `error`. Each changed page includes inline `diff` data; pages from JSON-mode monitors also include a `snapshot` with the current extraction.


    ```json Markdown-mode response
    {
      "success": true,
      "next": "https://api.firecrawl.dev/v2/monitor/019df960-06e7-7383-9d89-82c0113dc31a/checks/019df960-5f2a-75fb-a98b-bd2d32ca67d4?skip=25&limit=25",
      "data": {
        "id": "019df960-5f2a-75fb-a98b-bd2d32ca67d4",
        "monitorId": "019df960-06e7-7383-9d89-82c0113dc31a",
        "status": "completed",
        "estimatedCredits": 2,
        "actualCredits": 2,
        "summary": {
          "totalPages": 1,
          "same": 0,
          "changed": 1,
          "new": 0,
          "removed": 0,
          "error": 0
        },
        "pages": [
          {
            "id": "019df960-7708-7c62-a5dc-6206f16ac122",
            "targetId": "019df960-09bb-7c11-8001-1f12f50ab1c2",
            "url": "https://example.com/blog",
            "status": "changed",
            "previousScrapeId": "019df94f-82c3-7e41-81f0-00c72b2d9c52",
            "currentScrapeId": "019df960-73ee-7ac2-97a9-fb0e442c21f1",
            "statusCode": 200,
            "error": null,
            "metadata": {
              "title": "Example Blog",
              "creditsUsed": 1
            },
            "judgment": {
              "meaningful": true,
              "confidence": "high",
              "reason": "The page headline changed to announce a new release cadence.",
              "meaningfulChanges": [
                {
                  "type": "changed",
                  "before": "Welcome to our weekly update.",
                  "after": "Welcome to our weekly update — now with daily releases!",
                  "reason": "The headline changed in a way that matches the monitor goal."
                }
              ]
            },
            "createdAt": "2026-05-17T15:35:00.000Z",
            "diff": {
              "text": "--- previous\n+++ current\n@@ -1,3 +1,3 @@\n # Latest posts\n-Welcome to our weekly update.\n+Welcome to our weekly update — now with daily releases!\n",
              "json": {
                "files": [
                  {
                    "from": "previous",
                    "to": "current",
                    "chunks": []
                  }
                ]
              }
            }
          }
        ],
        "next": "https://api.firecrawl.dev/v2/monitor/019df960-06e7-7383-9d89-82c0113dc31a/checks/019df960-5f2a-75fb-a98b-bd2d32ca67d4?skip=25&limit=25"
      }
    }
    ```


    ```json JSON-mode response
    {
      "success": true,
      "data": {
        "id": "019df960-5f2a-75fb-a98b-bd2d32ca67d4",
        "monitorId": "019df960-06e7-7383-9d89-82c0113dc31a",
        "status": "completed",
        "estimatedCredits": 2,
        "actualCredits": 2,
        "summary": {
          "totalPages": 1,
          "same": 0,
          "changed": 1,
          "new": 0,
          "removed": 0,
          "error": 0
        },
        "pages": [
          {
            "id": "019df960-7708-7c62-a5dc-6206f16ac122",
            "targetId": "019df960-09bb-7c11-8001-1f12f50ab1c2",
            "url": "https://example.com/pricing",
            "status": "changed",
            "previousScrapeId": "019df94f-82c3-7e41-81f0-00c72b2d9c52",
            "currentScrapeId": "019df960-73ee-7ac2-97a9-fb0e442c21f1",
            "statusCode": 200,
            "error": null,
            "metadata": {
              "title": "Pricing",
              "creditsUsed": 1
            },
            "judgment": {
              "meaningful": true,
              "confidence": "high",
              "reason": "The Starter plan price and Pro storage limit changed.",
              "meaningfulChanges": [
                {
                  "type": "changed",
                  "before": "$19/mo",
                  "after": "$24/mo",
                  "reason": "The Starter plan price changed."
                },
                {
                  "type": "changed",
                  "before": "10 GB storage",
                  "after": "25 GB storage",
                  "reason": "The Pro storage limit changed."
                }
              ]
            },
            "createdAt": "2026-05-17T15:35:00.000Z",
            "diff": {
              "json": {
                "plans[0].price": {
                  "previous": "$19/mo",
                  "current": "$24/mo"
                },
                "plans[1].features[2]": {
                  "previous": "10 GB storage",
                  "current": "25 GB storage"
                }
              }
            },
            "snapshot": {
              "json": {
                "plans": [
                  {
                    "name": "Starter",
                    "price": "$24/mo",
                    "features": ["Up to 3 users", "Basic analytics", "Email support"]
                  },
                  {
                    "name": "Pro",
                    "price": "$49/mo",
                    "features": ["Unlimited users", "Advanced analytics", "25 GB storage"]
                  }
                ]
              }
            }
          }
        ]
      }
    }
    ```


    ```json Mixed-mode response (JSON + git-diff)
    {
      "success": true,
      "data": {
        "id": "019df960-5f2a-75fb-a98b-bd2d32ca67d4",
        "monitorId": "019df960-06e7-7383-9d89-82c0113dc31a",
        "status": "completed",
        "estimatedCredits": 2,
        "actualCredits": 2,
        "summary": {
          "totalPages": 1,
          "same": 0,
          "changed": 1,
          "new": 0,
          "removed": 0,
          "error": 0
        },
        "pages": [
          {
            "id": "019df960-7708-7c62-a5dc-6206f16ac122",
            "targetId": "019df960-09bb-7c11-8001-1f12f50ab1c2",
            "url": "https://example.com/pricing",
            "status": "changed",
            "previousScrapeId": "019df94f-82c3-7e41-81f0-00c72b2d9c52",
            "currentScrapeId": "019df960-73ee-7ac2-97a9-fb0e442c21f1",
            "statusCode": 200,
            "error": null,
            "metadata": {
              "title": "Pricing",
              "creditsUsed": 1
            },
            "judgment": {
              "meaningful": true,
              "confidence": "high",
              "reason": "The Starter plan price changed.",
              "meaningfulChanges": [
                {
                  "type": "changed",
                  "before": "Starter — $19/mo",
                  "after": "Starter — $24/mo",
                  "reason": "The Starter plan price changed."
                }
              ]
            },
            "createdAt": "2026-05-17T15:35:00.000Z",
            "diff": {
              "text": "--- previous\n+++ current\n@@ -1,3 +1,3 @@\n # Pricing\n-Starter — $19/mo\n+Starter — $24/mo\n",
              "json": {
                "plans[0].price": {
                  "previous": "$19/mo",
                  "current": "$24/mo"
                }
              }
            },
            "snapshot": {
              "json": {
                "plans": [
                  { "name": "Starter", "price": "$24/mo" },
                  { "name": "Pro", "price": "$49/mo" }
                ]
              }
            }
          }
        ]
      }
    }
    ```


## Pricing

Monitors don't introduce a separate per-monitor fee. Each check pays for the underlying scrape, crawl, or search it performs, plus an optional credit per changed page when meaningful-change judging is enabled.

| Component                                                 | Credits                                                                                            |
| --------------------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| Scrape monitor                                            | 1 credit per URL per check                                                                         |
| Crawl monitor                                             | 1 credit per discovered page per check                                                             |
| Web monitor                                               | 2 credits per 10 results per check                                                                 |
| Web monitor judging                                       | 1 credit per result judged, when AI judging is enabled (covers scraping and evaluating the result) |
| Meaningful change enabled                                 | 1 additional credit per changed page that the judge validates                                      |
| Format add-ons (JSON, PDF, question, enhanced mode, etc.) | Same as standalone [scrape](/features/scrape)                                                      |

## API reference

* [Create monitor](/api-reference/endpoint/monitor-create)
* [List monitors](/api-reference/endpoint/monitor-list)
* [Get monitor](/api-reference/endpoint/monitor-get)
* [Update monitor](/api-reference/endpoint/monitor-update)
* [Delete monitor](/api-reference/endpoint/monitor-delete)
* [Run monitor](/api-reference/endpoint/monitor-run)
* [List monitor checks](/api-reference/endpoint/monitor-checks-list)
* [Get monitor check](/api-reference/endpoint/monitor-check-get)
* [Monitor page webhook payload](/api-reference/endpoint/webhook-monitor-page)
* [Monitor check completed webhook payload](/api-reference/endpoint/webhook-monitor-check-completed)
