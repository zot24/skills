> Source: https://flueframework.com/docs/ecosystem/channels/telegram

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Telegram


Last updated Jul 21, 2026<a href="/docs/ecosystem/channels/telegram/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a><a href="https://www.npmjs.com/package/@flue/telegram" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800" target="_blank" rel="noopener noreferrer">@flue/telegram</a>


## Quickstart

Add verified Telegram Bot API webhook ingress with project-owned outbound Telegram access to an existing Flue project with the [Telegram](https://core.telegram.org/bots/api) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add channel telegram
```

## Overview

The blueprint installs `@flue/telegram` and grammY, creates a source-root `channels/telegram.ts` module with named `channel` and project-owned `client` exports, and modifies the selected agent to bind the generated message tool.

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { createTelegramChannel } from &#39;@flue/telegram&#39;;
import { dispatch } from &#39;@flue/runtime&#39;;
import { Api } from &#39;grammy&#39;;
import { Assistant } from &#39;../agents/assistant.ts&#39;;

export const client = new Api(process.env.TELEGRAM_BOT_TOKEN!);

export const channel = createTelegramChannel({
  secretToken: process.env.TELEGRAM_WEBHOOK_SECRET_TOKEN!,
  async webhook({ update }) {
    const incoming = update.message ?? update.channel_post ?? update.business_message;
    if (!incoming) return;
    const conversation = conversationFromMessage(incoming);
    await dispatch(Assistant, {
      id: channel.instanceId(conversation),
      // Recorded once when this event creates the instance; ignored after.
      initialData: conversationData(conversation, incoming),
      message: {
        kind: &#39;signal&#39;,
        type: &#39;telegram.message&#39;,
        body: messageBody(incoming),
        attributes: { updateId: String(update.update_id) },
      },
    });
  },
});</code></pre>
<figcaption><span>src/channels/telegram.ts (abridged)</span></figcaption>
</figure>

The abridged example omits the generated `conversationFromMessage`, `conversationData`, and `messageBody` helpers, callback-query branch, and message tool. Once configured, an incoming message continues the agent instance for its chat, business chat, or topic, and the bound grammY tool replies to that same destination. grammY’s Fetch export runs on Node and Cloudflare Workers with Flue’s `nodejs_compat` setting.

## Mount the channel

A channel serves HTTP routes only where `app.ts` mounts it. Mount the module’s named `channel` export:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { channel as telegram } from &#39;./channels/telegram.ts&#39;;

app.route(&#39;/channels/telegram&#39;, telegram.route());</code></pre>
<figcaption><span>src/app.ts</span></figcaption>
</figure>

`channel.route()` is a pure router factory serving the channel’s declared routes relative to the mount path. The webhook paths in this guide assume the conventional `/channels/telegram` mount; a different mount path shifts them accordingly. The dispatch-target agent module carries the `'use agent'` directive — the directive registers it, so a dispatch-only agent needs no HTTP mount of its own.

## Configure

| Variable                        | Purpose                                              |
|---------------------------------|------------------------------------------------------|
| `TELEGRAM_WEBHOOK_SECRET_TOKEN` | **Required** — Verifies inbound webhook requests.    |
| `TELEGRAM_BOT_TOKEN`            | **Required** — Authenticates outbound Bot API calls. |

It installs `@flue/telegram` for verified ingress and grammY for project-owned Bot API access. grammY publishes a browser/Fetch build that runs in both Node and workerd with Flue’s required `nodejs_compat` configuration.

Set the webhook URL to:

``` astro-code
https://example.com/channels/telegram/webhook
```

Generate an independent random webhook secret using only letters, numbers, underscores, and hyphens. Configure it with the full route:

``` astro-code
await client.setWebhook('https://example.com/channels/telegram/webhook', {
  secret_token: process.env.TELEGRAM_WEBHOOK_SECRET_TOKEN!,
  allowed_updates: [
    'message',
    'edited_message',
    'channel_post',
    'edited_channel_post',
    'business_message',
    'edited_business_message',
    'guest_message',
    'callback_query',
    'message_reaction',
    'message_reaction_count',
  ],
});
```

Telegram sends the secret in `X-Telegram-Bot-Api-Secret-Token`. `@flue/telegram` rejects a missing or changed value before parsing the Update. Telegram does not sign the body or include a signed timestamp, so do not reuse one secret across bots.

Webhook delivery and `getUpdates` polling are mutually exclusive. Polling is outside the HTTP channel package.

## Channel module

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { createTelegramChannel, type TelegramConversationRef } from &#39;@flue/telegram&#39;;
import { defineTool, dispatch } from &#39;@flue/runtime&#39;;
import { Api } from &#39;grammy&#39;;
import type { Message } from &#39;grammy/types&#39;;
import * as v from &#39;valibot&#39;;
import { Assistant } from &#39;../agents/assistant.ts&#39;;

export const client = new Api(process.env.TELEGRAM_BOT_TOKEN!);

export const channel = createTelegramChannel({
  secretToken: process.env.TELEGRAM_WEBHOOK_SECRET_TOKEN!,

  // Path: /channels/telegram/webhook
  async webhook({ update }) {
    const incoming = update.message ?? update.channel_post ?? update.business_message;
    if (incoming) {
      const conversation = conversationFromMessage(incoming);
      await dispatch(Assistant, {
        id: channel.instanceId(conversation),
        // Recorded once when this event creates the instance; ignored after.
        initialData: conversationData(conversation, incoming),
        message: {
          kind: &#39;signal&#39;,
          type: &#39;telegram.message&#39;,
          body: messageBody(incoming),
          attributes: { updateId: String(update.update_id) },
        },
      });
      return;
    }

    if (update.callback_query) {
      const query = update.callback_query;
      await client.answerCallbackQuery(query.id);
      if (!query.message) return;
      const conversation = conversationFromMessage(query.message);
      await dispatch(Assistant, {
        id: channel.instanceId(conversation),
        // Recorded once when this event creates the instance; ignored after.
        initialData: conversationData(conversation, query.message),
        message: {
          kind: &#39;signal&#39;,
          type: &#39;telegram.callback_query&#39;,
          body: query.data ?? &#39;&#39;,
          attributes: {
            updateId: String(update.update_id),
            fromId: String(query.from.id),
            ...(query.from.username === undefined ? {} : { fromUsername: query.from.username }),
          },
        },
      });
      return;
    }
  },
});

// Message text, or a short placeholder describing a media-only message.
function messageBody(message: Message): string {
  if (message.text !== undefined) return message.text;
  if (message.caption !== undefined) return message.caption;
  if (message.photo) return &#39;[photo message]&#39;;
  if (message.video) return &#39;[video message]&#39;;
  if (message.voice) return &#39;[voice message]&#39;;
  if (message.document) return &#39;[document message]&#39;;
  if (message.sticker) return &#39;[sticker message]&#39;;
  return &#39;[non-text message]&#39;;
}

// Build the canonical destination identity from a native Telegram Message.
function conversationFromMessage(message: Message): TelegramConversationRef {
  const topic = {
    ...(message.message_thread_id === undefined
      ? {}
      : { messageThreadId: message.message_thread_id }),
    ...(message.direct_messages_topic?.topic_id === undefined
      ? {}
      : { directMessagesTopicId: message.direct_messages_topic.topic_id }),
  };
  return message.business_connection_id
    ? {
        type: &#39;business-chat&#39;,
        businessConnectionId: message.business_connection_id,
        chatId: message.chat.id,
        ...topic,
      }
    : { type: &#39;chat&#39;, chatId: message.chat.id, ...topic };
}

// Instance-creation data: the destination ref plus small instance-constant context.
function conversationData(conversation: TelegramConversationRef, message: Message) {
  return {
    type: conversation.type,
    chatId: conversation.chatId,
    ...(conversation.type === &#39;business-chat&#39;
      ? { businessConnectionId: conversation.businessConnectionId }
      : {}),
    ...(conversation.messageThreadId === undefined
      ? {}
      : { messageThreadId: conversation.messageThreadId }),
    ...(conversation.directMessagesTopicId === undefined
      ? {}
      : { directMessagesTopicId: conversation.directMessagesTopicId }),
    ...(message.chat.title === undefined ? {} : { chatTitle: message.chat.title }),
  };
}

export function postMessage(ref: TelegramConversationRef) {
  return defineTool({
    name: &#39;post_telegram_message&#39;,
    description: &#39;Post to the Telegram conversation bound to this agent.&#39;,
    input: v.object({ text: v.pipe(v.string(), v.minLength(1)) }),
    async run({ data: { text } }) {
      const message = await client.sendMessage(ref.chatId, text, {
        ...(ref.type === &#39;business-chat&#39;
          ? { business_connection_id: ref.businessConnectionId }
          : {}),
        ...(ref.messageThreadId ? { message_thread_id: ref.messageThreadId } : {}),
        ...(ref.directMessagesTopicId
          ? { direct_messages_topic_id: ref.directMessagesTopicId }
          : {}),
      });
      return { output: { messageId: message.message_id } };
    },
  });
}</code></pre>
<figcaption><span>src/channels/telegram.ts</span></figcaption>
</figure>

## Bind the tool

`initialData` is the instance’s creation data: recorded once when the event creates the instance and ignored afterward, so the channel passes it on every dispatch. Bind the tool from the agent with `useInitialData()` instead of parsing the instance id:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>&#39;use agent&#39;;
import { useInitialData, useModel, useTool } from &#39;@flue/runtime&#39;;
import * as v from &#39;valibot&#39;;
import { postMessage } from &#39;../channels/telegram.ts&#39;;

const chatData = v.object({
  type: v.literal(&#39;chat&#39;),
  chatId: v.number(),
  messageThreadId: v.optional(v.number()),
  directMessagesTopicId: v.optional(v.number()),
  chatTitle: v.optional(v.string()),
});
const businessChatData = v.object({
  type: v.literal(&#39;business-chat&#39;),
  businessConnectionId: v.string(),
  chatId: v.number(),
  messageThreadId: v.optional(v.number()),
  directMessagesTopicId: v.optional(v.number()),
  chatTitle: v.optional(v.string()),
});
const initialData = v.variant(&#39;type&#39;, [chatData, businessChatData]);

export function Assistant() {
  useModel(&#39;anthropic/claude-haiku-4-5&#39;);
  const data = useInitialData&lt;v.InferOutput&lt;typeof initialData&gt;&gt;();
  if (!data) throw new Error(&#39;This agent is created by the Telegram channel dispatch.&#39;);
  useTool(postMessage(data));
  const chatTitle = data.chatTitle ? ` (&quot;${data.chatTitle}&quot;)` : &#39;&#39;;
  return `Reply concisely in the bound Telegram conversation${chatTitle}.`;
}

Assistant.initialData = initialData;</code></pre>
<figcaption><span>src/agents/assistant.ts</span></figcaption>
</figure>

Trusted code binds the chat, business connection, and optional topic. The model selects only message text.

## Verified inbound

Flue owns one job on the inbound side: it verifies the `X-Telegram-Bot-Api-Secret-Token` header, enforces the body limit, parses the JSON, and forwards a single provider-native Bot API `Update` to your callback. There is no parallel normalized model — the update keeps Telegram’s own field names, nesting, and discriminants. The authoritative type is the spec-generated [`@grammyjs/types`](https://github.com/grammyjs/types) `Update`, which `@flue/telegram` re-exports (the same type grammY uses).

Because at most one of an `Update`’s optional fields is present per delivery, branch on those fields instead of a discriminant. The example above reads `update.message ?? update.channel_post ?? update.business_message` for incoming messages and `update.callback_query` for callbacks; widen the branches to the update families your bot enabled in `allowed_updates`. Each native `Message` carries its own conversation identity, which `conversationFromMessage` reads to build the `TelegramConversationRef`.

Each delivery contains one Update and invokes the callback once. `update.update_id` is Telegram’s ordering and duplicate-detection key. The package does not persist it; claim it in application storage before dispatch when duplicate admission is unacceptable.

Telegram retries unsuccessful webhook requests. Returning nothing produces an empty `200`. Return JSON to use Telegram’s webhook-reply method format, or use the Hono context for explicit status control.

## Conversation identity

`conversationFromMessage` derives a canonical instance id from the native `Message`: regular chats, business chats, forum threads, and channel direct-message topics produce distinct ids. Business identity includes `businessConnectionId` because Telegram warns that business chat ids can match ordinary bot chat ids, and a thread id (`message_thread_id`) and direct-message topic id (`direct_messages_topic.topic_id`) are mutually exclusive.

Some native updates have no durable chat destination, so do not build an instance id from them. A guest message’s `guest_query_id` authorizes one short-lived `answerGuestQuery` response and must not enter model context, logs, durable session data, or agent identity. An inline `callback_query` without a `message` likewise supplies no accessible chat.

See the [`@flue/telegram` README](https://github.com/withastro/flue/tree/main/packages/telegram#readme).


## Docs Navigation

Current page: [Telegram](/docs/ecosystem/channels/telegram/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


