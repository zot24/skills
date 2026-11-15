> Source: https://docs.firecrawl.dev/rate-limits.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Rate Limits

> Rate limits for different pricing plans and API requests

Rate limits cap how many requests your team can make per minute, while concurrency limits cap how many jobs can run in parallel. Both are set by your plan; exceeding either returns a `429` response. See [Errors](https://docs.firecrawl.dev/api-reference/errors.md) for the full error catalog and a retry-with-backoff snippet.

## Concurrent Browser Limits

Concurrent browsers control how many pages Firecrawl can process for you in parallel. Your plan sets the ceiling; any jobs beyond it wait in a queue until a browser frees up.

Time spent in the queue counts against the request's [`timeout`](https://docs.firecrawl.dev/advanced-scraping-guide#timing-and-cache) parameter, so you can set a lower timeout to fail fast instead of waiting. To see current availability before sending work, call the [Queue Status](https://docs.firecrawl.dev/api-reference/endpoint/queue-status.md) endpoint. Jobs that are waiting in your concurrency queue will time out after a maximum of 48 hours.

### Current Plans


  <thead>
    <tr>
      <th>Plan</th>
      <th>Concurrent Browsers</th>
      <th>Max Queued Jobs</th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>Free</td>
      <td>2</td>
      <td>50,000</td>
    </tr>

    <tr>
      <td>Hobby</td>
      <td>5</td>
      <td>50,000</td>
    </tr>

    <tr>
      <td>Standard</td>
      <td>25</td>
      <td>50,000</td>
    </tr>

    <tr>
      <td>Growth</td>
      <td>50</td>
      <td>100,000</td>
    </tr>

    <tr>
      <td>Scale / Enterprise</td>
      <td>100+</td>
      <td>200,000+</td>
    </tr>
  </tbody>


Each team has a maximum number of jobs that can be waiting in the concurrency queue. If you exceed this limit, new jobs will be rejected with a `429` status code until existing jobs complete. For larger plans with custom concurrency limits, the max queued jobs is 2,000 times your concurrency limit, capped at 2,000,000.

If you require higher concurrency limits, [contact us about enterprise plans](https://firecrawl.dev/enterprise).

## API Rate Limits

Rate limits are measured in requests per minute and are primarily in place to prevent abuse. When configured correctly, your real bottleneck will be concurrent browsers. Rate limits are applied per team, so all API keys on the same team share the same rate limit counters.

### Keyless (no API key)

The hosted Firecrawl MCP keyless endpoint exposes exactly **Search, Scrape, and Parse** without an API key. Other hosted MCP tools require an account connection or an API key.

For official Firecrawl clients, the CLI, SDKs, and REST API, keyless access also includes **Interact**. On Firecrawl Cloud, research, developer, and government search endpoints can also be used without an API key. No other endpoints (crawl, extract, map, batch scrape, etc.) are available without a key.

Keyless usage is free and capped per IP address per day by **two limits**, and exceeding either returns a `429`:

* A maximum number of **requests** per day.
* A maximum number of **credits** per day. Operations cost different amounts of credits (for example, Interact and JSON extraction cost more than a basic scrape), so heavier usage reaches the credit cap sooner.

[Sign up for a free API key](https://firecrawl.dev) to get 1,000 credits and higher rate limits at no cost — official clients automatically use your key once it's configured.

### Current Plans


  <thead>
    <tr>
      <th>Plan</th>
      <th>/scrape</th>
      <th>/map</th>
      <th>/crawl</th>
      <th>/search</th>
      <th>/agent</th>
      <th>/crawl/status</th>
      <th>/agent/status</th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>Free</td>
      <td>10</td>
      <td>10</td>
      <td>2</td>
      <td>10</td>
      <td>2</td>
      <td>500</td>
      <td>500</td>
    </tr>

    <tr>
      <td>Hobby</td>
      <td>100</td>
      <td>100</td>
      <td>20</td>
      <td>100</td>
      <td>20</td>
      <td>5000</td>
      <td>5000</td>
    </tr>

    <tr>
      <td>Standard</td>
      <td>500</td>
      <td>500</td>
      <td>100</td>
      <td>500</td>
      <td>100</td>
      <td>25000</td>
      <td>25000</td>
    </tr>

    <tr>
      <td>Growth</td>
      <td>5000</td>
      <td>5000</td>
      <td>1000</td>
      <td>5000</td>
      <td>1000</td>
      <td>250000</td>
      <td>250000</td>
    </tr>

    <tr>
      <td>Scale</td>
      <td>10000</td>
      <td>10000</td>
      <td>2000</td>
      <td>10000</td>
      <td>2000</td>
      <td>500000</td>
      <td>500000</td>
    </tr>
  </tbody>


These rate limits are enforced to ensure fair usage and availability of the API for all users. If you require higher limits, please contact us at [help@firecrawl.com](mailto:help@firecrawl.com) to discuss custom plans.

### Extract Endpoints

The extract endpoints share limits with the corresponding /agent rate limits.

### Batch Scrape Endpoints

The batch scrape endpoints share limits with the corresponding /crawl rate limits.

### Government and Research Indexes

Calls to the [Government Index](https://docs.firecrawl.dev/features/gov.md) and the [Research Index](https://docs.firecrawl.dev/features/research.md) are free. Each index has a per-minute limit per team that is the same on every plan:

| Index | Calls per minute |
| - | - |
| Government Index | 300 |
| Research Index | 100 |

Each index also has a daily call limit per team:


  <thead>
    <tr>
      <th>Plan</th>
      <th>Calls per index per day</th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>Free / Hobby / Standard</td>
      <td>1,000</td>
    </tr>

    <tr>
      <td>Growth</td>
      <td>2,000</td>
    </tr>

    <tr>
      <td>Scale / Enterprise</td>
      <td>Unlimited</td>
    </tr>
  </tbody>


Requests without an API key get the Free limit, counted per IP address. Counts reset at 00:00 UTC. After you upgrade, the new limit applies within about 10 minutes.

#### What counts

Each index has its own counts. Every call to that index counts once toward both its per-minute and its daily limit, whichever way you reach it:

* **Government Index:** `/search/gov`, `/search` with the `gov` category, and the Government Index tool in [Alexandria](https://docs.firecrawl.dev/features/alexandria.md).
* **Research Index:** every `/search/research/papers` endpoint (search, inspect, read and related papers), and the Research Index tool in Alexandria.

A `gov` search on `/search` also counts toward your plan's `/search` rate limit.

An Alexandria request that carries several calls to an index counts each one. If the request would go over either limit, none of its calls run. The request also counts toward the rate limit of the endpoint it is sent to.

A request Firecrawl rejects as invalid (`400`) before it reaches the index is not counted toward the daily limit, and an Alexandria request replayed with the same `x-request-id` is not counted toward either limit. The replay returns the saved result, except under zero data retention: no result is kept, so the replay returns `409` with code `response_not_retained`. A call that reaches the index counts even if the index returns an error.

#### When you reach the limit

Over the per-minute limit, the request returns `429` with a `Retry-After` header giving the seconds until the minute's count resets. The per-minute limits are the same on every plan, so upgrading does not raise them. Over the daily limit, it returns `429` with a `Retry-After` header giving the seconds until 00:00 UTC. Until then, calls to that index are refused unless they fit in what is left of the daily limit or you upgrade. The daily-limit body explains the limit and how to raise it:

```json theme={null}
{
  "success": false,
  "code": "INDEX_DAILY_LIMIT",
  "error": "Daily Research Index limit reached: your team has used 1,000 of its 1,000 calls today. The limit resets at 00:00 UTC, in 3h 12m. Upgrade to Scale or Enterprise for unlimited Research Index calls: https://firecrawl.dev/pricing",
  "limit": 1000,
  "used": 1000,
  "resetsAt": "2026-10-16T00:00:00.000Z",
  "upgradeUrl": "https://firecrawl.dev/pricing"
}
```

| Field | Meaning |
| - | - |
| `code` | `INDEX_DAILY_LIMIT` from the search endpoints, `index_daily_limit` from Alexandria. A per-minute rate limit `429` has no `code`, except when an Alexandria request goes over an index's per-minute limit, which returns `index_rate_limit`. Use this field to tell them apart. |
| `limit` | Your plan's daily limit for this index. |
| `used` | Calls already counted today. |
| `resetsAt` | When the count resets, in UTC. |
| `upgradeUrl` | Where to change your plan. |

Alexandria's `index_rate_limit` and `index_daily_limit` responses also include `retryAfterSeconds`, the same value as the `Retry-After` header. A `429` from the rate limit of the endpoint an Alexandria request is sent to has no `code`; honor its `Retry-After` header.

### Browser Sandbox

The browser sandbox endpoints have per-plan rate limits that scale with your subscription:


  <thead>
    <tr>
      <th>Plan</th>
      <th>/interact</th>
      <th>/interact/\{id}/execute</th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td>Free</td>
      <td>2</td>
      <td>10</td>
    </tr>

    <tr>
      <td>Hobby</td>
      <td>20</td>
      <td>100</td>
    </tr>

    <tr>
      <td>Standard</td>
      <td>100</td>
      <td>500</td>
    </tr>

    <tr>
      <td>Growth</td>
      <td>1,000</td>
      <td>5,000</td>
    </tr>

    <tr>
      <td>Scale</td>
      <td>1,500</td>
      <td>7,500</td>
    </tr>
  </tbody>


In addition, each team's plan determines how many browser sessions can be active simultaneously (see Concurrent Browser Limits above). If you exceed this limit, new session requests will return a `429` status code until existing sessions are destroyed.


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
