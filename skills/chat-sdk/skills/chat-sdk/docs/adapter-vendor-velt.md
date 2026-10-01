> Source: https://chat-sdk.dev/adapters/vendor-official/velt.md

---
title: Velt
description: Chat SDK adapter backed by Velt Comments. Build bots that read, reply, mention, and start threads in anchored comments across documents, rich-text editors, canvases, PDFs, and video. Includes per-comment document context and a streaming AI reply flow.
tagline: Bots that read, reply, mention, and start threads in Velt's anchored comments across editors, canvases, PDFs, and video, mapping Velt organizations, documents, comment annotations, and comments to the Chat SDK channel, thread, and message model.
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

The adapter maps Velt documents to Chat SDK channels, comment annotations to Chat SDK threads, and individual comments to messages, so subscriptions, handlers, posts, and reactions work as they do with any other adapter.

## Platform setup

1. Create a [Velt account](https://console.velt.dev) and copy your API key.
2. Add a bot user to your organization (`POST /v2/users/add` with `userId: "velt-bot"`) so it can post and appears in the @-mention list.
3. Configure webhooks (Velt Console → **Configurations → Webhook Service**, or `POST /v2/workspace/webhookconfig/update`) and subscribe to:
   * `comment.add`
   * `comment_annotation.add`
   * `comment.reaction_add`
   * `comment.reaction_delete`
4. Copy the signing secret (`whsec_...` for Advanced/v2 webhooks) into `webhookSecret`.

Point your Velt webhook URL at the route that forwards requests to `bot.webhooks.velt` (see [Webhooks](#webhooks)).

## Configuration


### Environment variables

| Variable               | Required | Description                                                                                             |
| ---------------------- | -------- | ------------------------------------------------------------------------------------------------------- |
| `VELT_API_KEY`         | Yes      | Velt API key for REST API calls. Used when `apiKey` isn't set.                                          |
| `VELT_WEBHOOK_SECRET`  | Yes      | Webhook signing secret. Used when `webhookSecret` isn't set.                                            |
| `VELT_AUTH_TOKEN`      | No       | Velt auth token. If neither this nor `authToken` is set, the adapter generates a token for `botUserId`. |
| `VELT_ORGANIZATION_ID` | No       | Default organization ID. Used when `organizationId` isn't set.                                          |

## Webhooks

The adapter handles these Velt webhook events:

| Event                     | Role                               |
| ------------------------- | ---------------------------------- |
| `comment.add`             | Drives Chat SDK message processing |
| `comment_annotation.add`  | First comment of a new thread      |
| `comment.reaction_add`    | Drives reaction handlers           |
| `comment.reaction_delete` | Drives reaction handlers           |

Forward webhook requests to `bot.webhooks.velt`:

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

Velt has two webhook systems, and the adapter verifies both. Advanced (v2), the default, uses Svix-style HMAC-SHA256 with a `whsec_...` secret. Basic (v1) uses an `Authorization: Basic <token>` header; set `webhookVersion: "v1"` to verify it. The adapter returns `401` for an invalid request. Passing `waitUntil` lets work continue after the response is sent in serverless environments such as Vercel.

## Message format

Velt Comments are stored as `commentHtml`, so the adapter converts between Velt HTML and the Chat SDK's mdast AST (`VeltFormatConverter`). Inbound `{{userId}}` mention tokens are normalized to readable `@Name`. Each parsed `Message.raw` also carries document context in `documentName`, `documentUrl`, and `anchoredText`, which bots can use to ground replies.

Comment bodies support paragraphs with bold, italic, code, strikethrough, links, and @mentions.

The adapter flattens headings, lists, code blocks, and tables to plain text or paragraphs. Card payloads render as fallback text and lose their interactivity.

## Reactions

Reading reactions (`onReaction`) works on all Velt plans.

The managed Velt backend has no REST endpoint for adding a reaction as a user, so `addReaction` and `removeReaction` throw a `PermissionError` there. To write reactions, set `selfHostingConfig.reactionsService` to a self-hosted reactions service backed by your own database.

## Thread IDs

Thread IDs take the form `velt:{organizationId}:{documentId}:{annotationId}`, and channel IDs take the form `velt:{organizationId}:{documentId}`.

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

Throws if the format is invalid. Each segment is URL-encoded, so IDs may contain `:`.

## Feature support


## Resources

* [Live demo](https://sample-apps-tiptap-comments-demo.vercel.app): open the Velt tiptap comments demo, leave a comment, and @-mention Velt Bot to see a streaming AI reply. The demo runs the AI bot listed below.
* [Velt Chat SDK Bot](https://github.com/velt-js/velt-chat-sdk-adapter/tree/main/examples/nextjs-velt-bot): a Next.js bot that replies to @-mentions in Velt comment threads.
* [Velt Chat SDK AI Bot](https://github.com/velt-js/velt-chat-sdk-adapter/tree/main/examples/nextjs-velt-ai-bot): the same stack with a streaming Claude reply flow.
* Full walkthrough: [Get started with a Chat SDK bot using Velt](https://velt.dev/docs/ai/chat-sdk-adapter).
