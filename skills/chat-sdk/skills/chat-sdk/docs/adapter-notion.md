> Source: https://chat-sdk.dev/adapters/official/notion.md

---
title: Notion
description: Respond to comments on Notion pages and discussion threads.
tagline: Participate in Notion page and block comment discussions via webhooks and the Comments API. Supports Post+Edit streaming.
package: @chat-adapter/notion
---

# Notion


## Install


## Quick start


  The adapter auto-detects credentials from `NOTION_TOKEN`, `NOTION_VERIFICATION_TOKEN`, and optional `NOTION_BOT_USERNAME` / `NOTION_VERSION` / `NOTION_MENTION_MODE` / `NOTION_KEYWORDS`.


```typescript title="lib/bot.ts" lineNumbers
import { Chat } from "chat";
import { createNotionAdapter } from "@chat-adapter/notion";
import { createRedisState } from "@chat-adapter/state-redis";

const bot = new Chat({
  userName: "my-bot",
  adapters: {
    notion: createNotionAdapter(),
  },
  state: createRedisState(),
});

bot.onNewMention(async (thread, message) => {
  await thread.post("Hello from Notion!");
});
```

```typescript title="app/api/webhooks/notion/route.ts" lineNumbers
import { bot } from "@/lib/bot";

export async function POST(request: Request): Promise<Response> {
  return bot.webhooks.notion(request);
}
```

## Vercel Connect

Use Vercel Connect for the outbound Notion access token:

```typescript title="lib/bot.ts" lineNumbers
import { createNotionAdapter } from "@chat-adapter/notion";
import { connectNotionAdapter } from "@vercel/connect/chat";

const notion = createNotionAdapter({
  ...connectNotionAdapter("notion/acme-notion"),
  verificationToken: process.env.NOTION_VERIFICATION_TOKEN,
});
```


  Connect does not forward Notion webhooks. Configure the subscription directly
  in Notion and retain `NOTION_VERIFICATION_TOKEN` for native HMAC verification.
  `NOTION_TOKEN` is not needed when using `connectNotionAdapter`.


## Connection setup

The adapter targets a **single workspace** via an [access-token connection](https://developers.notion.com/docs/getting-started).

1. Open the [Developer Portal](https://app.notion.com/developers/connections) and click **New connection**.
2. Enter a connection name, choose **Access token** as the authentication method, and select the workspace the connection is installable in. Only one workspace is supported; the connection is installed automatically. Click **Create connection**.
3. On the connection page, copy the **Access token** → set as `NOTION_TOKEN`.
4. Under **Capabilities → Comment capabilities**, enable **Read comments** and **Insert comments**.
5. Under **Capabilities → Content capabilities**, leave **Read content**, **Update content**, and **Insert content** as-is (**Read content** is required for [`message.subject`](/docs/subject) page metadata).
6. Under **Capabilities → User capabilities**, leave **Read user information including email addresses** as-is (used for author names and mention resolution).
7. On the **Content access** tab, choose which pages and databases the connection can access. The connection is only available and webhooks only fire for those pages and databases.

Capability or access errors (typically HTTP 403) usually mean a missing comment capability or that the page/database was not enabled under **Content access**.

## Webhook subscription

Subscriptions are created on the connection's **Webhooks** tab (not via the API).

1. Deploy your app so `https://your-domain.com/api/webhooks/notion` is publicly reachable.
2. On the connection page, open the **Webhooks** tab and click **Create a subscription**.
3. Set the **Webhook URL**, leave the default **API version** as-is, and under **Events** deselect every category except **Comment** (this selects **Comment created**, **Comment deleted**, and **Comment updated**). The adapter requires **Comment created**; deleted/updated events are acknowledged and ignored by the base adapter.
4. Notion sends a one-time POST containing `verification_token`. The adapter logs it at **warn** and returns `200`.
5. Paste that token into Notion's UI and click **Verify**.
6. Set the same value as `NOTION_VERIFICATION_TOKEN` (or pass `verificationToken` in config), then restart so signed deliveries can be verified.

After verification, every delivery is checked with HMAC-SHA256 over the **raw body** against `X-Notion-Signature` (`sha256=<hex>`).

Event-id dedupe is **best-effort**: in-memory plus state-backed when a Chat state adapter is configured. It is not a substitute for Notion's delivery semantics across cold starts without durable state.


  **Webhook URL is locked after verification.** Notion does not let you change the subscription URL in place. To point at a new endpoint you must **delete the subscription and create a new one**, then repeat the verification-token paste flow and update `NOTION_VERIFICATION_TOKEN`. Choose a stable production URL before verifying.


## Environment variables

| Variable                    | Required | Description                                                   |
| --------------------------- | -------- | ------------------------------------------------------------- |
| `NOTION_TOKEN`              | Yes      | Connection access token (Bearer token).                       |
| `NOTION_VERIFICATION_TOKEN` | Yes      | HMAC key from the webhook verification handshake.             |
| `NOTION_BOT_USERNAME`       | No       | Bot display name override (default `notion-bot`).             |
| `NOTION_MENTION_MODE`       | No       | `mention` \| `all-comments` \| `keyword` (default `mention`). |
| `NOTION_KEYWORDS`           | No       | Comma-separated keywords when `NOTION_MENTION_MODE=keyword`.  |
| `NOTION_VERSION`            | No       | Override `Notion-Version` header (default pinned below).      |

## Configuration


`token` and `verificationToken` are required at runtime (via env or config).

### Mention detection

| Mode                  | Behavior                                                                                                                                                                          |
| --------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `"mention"` (default) | `isMention` when the comment plain text contains `@userName` or `@botUserId`. Notion connection bots are not @-mentionable in the composer, so users type the `@` token manually. |
| `"all-comments"`      | Every non-bot comment on connected pages is treated as a mention (useful for dedicated Q\&A pages).                                                                               |
| `"keyword"`           | `isMention` when the comment matches any configured `keywords` (case-insensitive, word-boundary).                                                                                 |

```typescript
createNotionAdapter({
  userName: "docs-bot",
  // default mentionMode: "mention" → triggers on "@docs-bot" or "@<bot-user-id>"
});
```

```typescript
createNotionAdapter({
  mentionMode: "keyword",
  keywords: ["@docs-bot", "hey bot"],
});
```

## Thread model

One Notion **page** is one Chat SDK **channel**. Each **discussion** is a **thread**.

| Surface                             | Thread ID                                                                                         | Outbound behavior                                                      |
| ----------------------------------- | ------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| Page comment surface (channel root) | `notion:{pageId}`                                                                                 | Creates a **page-level** comment (starts a new page-level discussion). |
| Existing discussion                 | `notion:{pageId}:{discussionId}`                                                                  | Replies in that discussion.                                            |
| Whole-block discussion (outbound)   | `encodeThreadId({ pageId, blockId })` → `notion:{pageId}:block:{blockId}` (or the adapter helper) | Starts a discussion on an entire block via `parent.block_id`.          |

Inbound `comment.created` events always include a `discussion_id`. The adapter resolves the containing page (including block-parent comments) and dispatches on `notion:{pageId}:{discussionId}` so replies stay threaded.


  You can start **page-level** and **whole-block** discussions via the API. You **cannot** start **selected-text-range** (inline highlight) discussions through the public Comments API — those must already exist in Notion.


Helper for deep links:

```typescript
const notion = bot.getAdapter("notion");
const url = notion.getPageUrl(thread.id); // includes ?d={discussionId} when present
```

## Message subject

`await message.subject` resolves the parent Notion **page** (`GET /v1/pages/{pageId}`) on first access and caches the result.


  Requires **Capabilities → Content capabilities → Read content**. Without it, `message.subject` returns `null` (typically after a 403 from the Pages API). Comment posting still works with only the comment capabilities.


| Field    | Value                                                                 |
| -------- | --------------------------------------------------------------------- |
| `type`   | `"page"`                                                              |
| `id`     | Page UUID                                                             |
| `title`  | Page title property (plain text)                                      |
| `url`    | Notion page URL                                                       |
| `status` | `"archived"` when the page is archived or in trash; otherwise omitted |
| `author` | Page `created_by` when present                                        |
| `raw`    | Full page API response                                                |

Returns the Notion **page object** (title, properties, URL, and the full payload on `raw`) from the Pages API — not the page’s **block children** / body content (`GET /v1/blocks/.../children`). See [Message Subject](/docs/subject).

## Streaming and rate limits

Notion allows updating a connection's own comments, so the adapter uses **Post+Edit** streaming: post the first chunk, then `PATCH` the same comment as tokens arrive.

Notion's average rate limit is about **\~3 requests/second** per connection (plus shared workspace limits). The adapter:

* Throttles streaming edits with a default minimum interval of **≥ 1500ms** (`streamingEditIntervalMs`)
* Always flushes a final edit
* Applies a shared limiter to all API calls and honors `Retry-After` on HTTP 429

Override per stream with `updateIntervalMs` on the stream options if needed.


  Notion rich-text spans are limited to about **\~2000 characters per span**. Long posts are automatically split into sequential comments to stay under the limit. Streaming edits a single comment in place, so an unusually long streamed response can still approach this ceiling.


## Conversation history

`fetchMessages` uses Notion's list-comments API (`GET /v1/comments?block_id={pageId}`), paginated ascending, then filters client-side to the requested `discussion_id`. List-comments ordering is **assumed oldest-first** (Notion does not document order). With the SDK default `direction: "backward"`, you get the newest page of matching discussion comments from that assumed order.


  **Open comments only.** List-comments returns unresolved discussions. Once a discussion is resolved in Notion, those comments disappear from history fetches.


## API version

Every request sends:

```http
Notion-Version: 2026-03-11
```

That pin is exported as `DEFAULT_NOTION_VERSION` from `@chat-adapter/notion`. Override with `notionVersion` / `NOTION_VERSION` only if you accept breakage risk when Notion's versioned API diverges.

## Cards and files

* **Cards** — no native Notion card UI; JSX cards render as markdown via `fallbackText` / flattened content (same pattern as Linear/GitHub). Interactive buttons / `callbackUrl` are unsupported.
* **Files** — outbound files use Notion’s **File Uploads API** and attach up to **3** as native comment attachments.
  * Binary uploads use `single_part` (up to Notion’s \~20 MiB single-part limit); public URLs use `external_url`, polled until `uploaded` before attach (default: immediate recheck, then 5s / 10s — configurable via `externalUrlPollDelaysMs`).
  * Overflow beyond 3, uploads still pending after the poll window, and other upload failures fall back to **markdown links** in the comment body. Edits link files in markdown only.

## Feature support


