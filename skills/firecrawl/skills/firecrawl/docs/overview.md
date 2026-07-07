> Source: https://docs.firecrawl.dev/webhooks/overview.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Overview

> Real-time notifications for your Firecrawl operations

Get notified the moment a crawl, batch scrape, extract, agent job, or monitor check starts, progresses, or finishes. Instead of polling for status, you provide an HTTPS endpoint and Firecrawl delivers events to it in real time.

## Supported Operations

| Operation    | Events                                                  |
| ------------ | ------------------------------------------------------- |
| Crawl        | `started`, `page`, `completed`                          |
| Batch Scrape | `started`, `page`, `completed`                          |
| Extract      | `started`, `completed`, `failed`                        |
| Agent        | `started`, `action`, `completed`, `failed`, `cancelled` |
| Monitor      | `check.completed`                                       |

See [Event Types](/webhooks/events) for full payload details and examples.

## Configuration

Add a `webhook` object to your request:

```json JSON theme={null}
{
  "webhook": {
    "url": "https://your-domain.com/webhook",
    "metadata": {
      "any_key": "any_value"
    },
    "events": ["started", "page", "completed", "failed"]
  }
} 
```

| Field      | Type   | Required | Description                           |
| ---------- | ------ | -------- | ------------------------------------- |
| `url`      | string | Yes      | Your endpoint URL (HTTPS)             |
| `headers`  | object | No       | Custom headers to include             |
| `metadata` | object | No       | Custom data included in payloads      |
| `events`   | array  | No       | Event types to receive (default: all) |

## Usage

### Crawl with Webhook

```bash cURL theme={null}
curl -X POST https://api.firecrawl.dev/v2/crawl \
    -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer YOUR_API_KEY' \
    -d '{
      "url": "https://docs.firecrawl.dev",
      "limit": 100,
      "webhook": {
        "url": "https://your-domain.com/webhook",
        "metadata": {
          "any_key": "any_value"
        },
        "events": ["started", "page", "completed"]
      }
    }'
```

### Batch Scrape with Webhook

```bash cURL theme={null}
curl -X POST https://api.firecrawl.dev/v2/batch/scrape \
    -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer YOUR_API_KEY' \
    -d '{
      "urls": [
        "https://example.com/page1",
        "https://example.com/page2",
        "https://example.com/page3"
      ],
      "webhook": {
        "url": "https://your-domain.com/webhook",
        "metadata": {
          "any_key": "any_value"
        },
        "events": ["started", "page", "completed"]
      }
    }' 
```

## Timeouts & Retries

Your endpoint must respond with a `2xx` status within **10 seconds**.

If delivery fails (timeout, non-2xx, or network error), Firecrawl retries automatically:

| Retry | Delay after failure |
| ----- | ------------------- |
| 1st   | 1 minute            |
| 2nd   | 5 minutes           |
| 3rd   | 15 minutes          |

After 3 failed retries, the webhook is marked as failed and no further attempts are made.
