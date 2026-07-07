> Source: https://chat-sdk.dev/adapters/vendor-official/velt.md

---
title: Velt
description: Chat SDK adapter backed by Velt Comments. Build bots that read, reply, mention, and start threads in anchored comments across documents, rich-text editors, canvases, PDFs, and video. Includes per-comment document context and a streaming AI reply flow.
tagline: Bots that read, reply, mention, and start threads in Velt's anchored comments across editors, canvases, PDFs, and video, mapping Velt organizations, documents, comment annotations, and comments to the Chat SDK Channel/Thread/Message model.
package: @veltdev/chat-sdk-adapter
---

# Velt


## Install


## Quick start

```typescript title="lib/bot.ts" lineNumbers
import { Chat } from "chat";
import { createMemoryState } from "@chat-adapter/state-memory";
import { createVeltAdapter, type VeltAdapter } from "@veltdev/chat-sdk-adapter";

const bot = new Chat<{ velt: VeltAdapter }>({
  userName: "Velt Bot",
  adapters: {
    velt: createVeltAdapter({
      apiKey: process.env.VELT_API_KEY,
      webhookSecret: process.env.VELT_WEBHOOK_SECRET,
      botUserId: "velt-bot",
      botUserName: "Velt Bot",
    }),
  },
  state: createMemoryState(),
});

bot.onNewMention(async (thread, message) => {
  await thread.post(`Hi ${message.author.fullName}! How can I help?`);
});
```

The adapter maps Velt documents to Chat SDK channels, comment annotations to Chat SDK threads, and individual comments to messages, so the rest of the Chat SDK API (subscriptions, handlers, posts, reactions) works exactly the same as with any other adapter.

## Configuration


## Platform setup

1. Create a [Velt account](https://console.velt.dev) and copy your **API key**.
2. Add a **bot user** to your organization (`POST /v2/users/add` with `userId: "velt-bot"`) so it can post and appears in the @-mention list.
3. Configure webhooks (Velt Console → **Configurations → Webhook Service**, or `POST /v2/workspace/webhookconfig/update`) and subscribe to:
   * `comment.add`
   * `comment_annotation.add`
   * `comment.reaction_add`
   * `comment.reaction_delete`
4. Copy the **signing secret** (`whsec_...` for Advanced/v2 webhooks) into `webhookSecret`.

Point your Velt webhook URL at the route that forwards requests to `bot.webhooks.velt` (see [Webhook events](#webhook-events)).

## Webhook events

| Event                     | Role                               |
| ------------------------- | ---------------------------------- |
| `comment.add`             | Drives Chat SDK message processing |
| `comment_annotation.add`  | First comment of a new thread      |
| `comment.reaction_add`    | Drives reaction handlers           |
| `comment.reaction_delete` | Drives reaction handlers           |

```typescript title="app/api/webhooks/velt/route.ts" lineNumbers
import { after } from "next/server";
import { bot } from "@/lib/bot";

export const runtime = "nodejs"; // raw body + crypto; not edge

export async function POST(request: Request) {
  return bot.webhooks.velt(request, {
    waitUntil: (task) => after(() => task),
  });
}
```

Velt has two webhook systems and the adapter verifies both: **Advanced (v2)** with Svix-style HMAC-SHA256 (`whsec_...`, default) and **Basic (v1)** with an `Authorization: Basic <token>` header (set `webhookVersion: "v1"`). Invalid requests return **401**. Passing `waitUntil` lets work continue after the response is sent in serverless environments like Vercel.

## ID encoding

* **Thread ID:** `velt:{organizationId}:{documentId}:{annotationId}`
* **Channel ID:** `velt:{organizationId}:{documentId}`

### `encodeThreadId`

```typescript
adapter.encodeThreadId(data: {
  organizationId: string;
  documentId: string;
  annotationId: string;
}): string;
```

```typescript
const encoded = adapter.encodeThreadId({
  organizationId: "my-org",
  documentId: "doc-1",
  annotationId: "NHR5sMWU7YmTv2HJ1nVC",
});
// "velt:my-org:doc-1:NHR5sMWU7YmTv2HJ1nVC"
```

### `decodeThreadId`

```typescript
adapter.decodeThreadId(threadId: string): {
  organizationId: string;
  documentId: string;
  annotationId: string;
};
```

Each segment is URL-encoded, so ids may safely contain `:`. Throws if the format is invalid.

## Message format

Velt Comments are stored as `commentHtml`, so the adapter converts between Velt HTML and the Chat SDK's mdast AST (`VeltFormatConverter`). Inbound `{{userId}}` mention tokens are normalized to readable `@Name`. Each parsed `Message.raw` also carries lightweight document context (`documentName`, `documentUrl`, `anchoredText`) so bots can ground replies.

**Supported:** paragraphs with bold, italic, code, strikethrough, links, and @mentions.

**Flattened to plain text / paragraphs:** headings, lists, code blocks, tables, and card payloads (rendered as fallback text). Interactivity is not preserved.

## Reactions

Reading reactions (`onReaction`) works on all Velt plans.

**Writing** reactions (`addReaction` / `removeReaction`) is not supported on the managed Velt backend, because there is no managed REST endpoint to add a reaction as a user, so these methods throw a clear `PermissionError`. To enable reaction writes, provide `selfHostingConfig.reactionsService` (a self-hosted reactions service backed by your own database).

## Examples

* **[Live demo](https://sample-apps-tiptap-comments-demo.vercel.app):** open the Velt tiptap comments demo, leave a comment, and @-mention **Velt Bot** to see a streaming AI reply (runs the AI bot below).
* [Velt Chat SDK Bot](https://github.com/velt-js/velt-chat-sdk-adapter/tree/main/examples/nextjs-velt-bot): a Next.js bot that replies to @-mentions in Velt comment threads.
* [Velt Chat SDK AI Bot](https://github.com/velt-js/velt-chat-sdk-adapter/tree/main/examples/nextjs-velt-ai-bot): the same stack with a streaming Claude reply flow.
* Full walkthrough: [Get started with a Chat SDK bot using Velt](https://velt.dev/docs/ai/chat-sdk-adapter).

## Feature support


