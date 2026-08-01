> Source: https://flueframework.com/docs/ecosystem/channels/messenger

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Facebook Messenger


Last updated Jul 21, 2026<a href="/docs/ecosystem/channels/messenger/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a><a href="https://www.npmjs.com/package/@flue/messenger" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800" target="_blank" rel="noopener noreferrer">@flue/messenger</a>


## Quickstart

Add verified Page webhook ingress and project-owned outbound Graph API access to an existing Flue project with the [Facebook Messenger](https://developers.facebook.com/docs/messenger-platform) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add channel messenger
```

## Overview

The Facebook Messenger blueprint installs `@flue/messenger`, creates a project-owned Graph API Fetch client at the source-root `messenger-client.ts`, and creates `channels/messenger.ts`. It also updates the selected agent to bind the generated reply tool to the verified Page conversation.

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { createMessengerChannel } from &#39;@flue/messenger&#39;;
import { dispatch } from &#39;@flue/runtime&#39;;
import { Assistant } from &#39;../agents/assistant.ts&#39;;
import { MessengerClient } from &#39;../messenger-client.ts&#39;;

export const client = new MessengerClient({
  pageId: process.env.MESSENGER_PAGE_ID!,
  pageAccessToken: process.env.MESSENGER_PAGE_ACCESS_TOKEN!,
  graphVersion: &#39;v25.0&#39;,
});

export const channel = createMessengerChannel({
  appSecret: process.env.MESSENGER_APP_SECRET!,
  verifyToken: process.env.MESSENGER_VERIFY_TOKEN!,
  pageId: process.env.MESSENGER_PAGE_ID!,
  async webhook({ payload }) {
    for (const entry of payload.entry) {
      for (const event of entry.messaging ?? []) {
        if (event.message === undefined || event.message.is_echo) continue;
        const conversation = channel.conversationRef(event);
        if (!conversation || event.message.text === undefined) continue;
        const attachmentTypes = (event.message.attachments ?? []).map(
          (attachment) =&gt; attachment.type,
        );
        await dispatch(Assistant, {
          id: channel.instanceId(conversation),
          // Recorded once when this event creates the instance; ignored after.
          initialData: {
            pageId: conversation.pageId,
            participant: conversation.participant,
          },
          message: {
            kind: &#39;signal&#39;,
            type: &#39;messenger.message&#39;,
            body: event.message.text,
            attributes: {
              messageId: event.message.mid,
              ...(event.message.quick_reply?.payload === undefined
                ? {}
                : { quickReplyPayload: event.message.quick_reply.payload }),
              ...(attachmentTypes.length === 0
                ? {}
                : { attachmentTypes: attachmentTypes.join(&#39;,&#39;) }),
            },
          },
        });
      }
    }
  },
});</code></pre>
<figcaption><span>src/channels/messenger.ts (abridged)</span></figcaption>
</figure>

The abridged example omits the generated `postMessage()` tool and Graph client implementation. Only verified, non-echo text messages from `entry.messaging` are dispatched to the corresponding agent instance; replies return to the same participant through the tool bound by the complete blueprint. Other event families and Graph API operations remain subject to application policy, and the standards-based client supports Node and workerd.

## Mount the channel

A channel serves HTTP routes only where `app.ts` mounts it. Mount the module’s named `channel` export:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { channel as messenger } from &#39;./channels/messenger.ts&#39;;

app.route(&#39;/channels/messenger&#39;, messenger.route());</code></pre>
<figcaption><span>src/app.ts</span></figcaption>
</figure>

`channel.route()` is a pure router factory serving the channel’s declared routes relative to the mount path. The webhook paths in this guide assume the conventional `/channels/messenger` mount; a different mount path shifts them accordingly. The dispatch-target agent module carries the `'use agent'` directive — the directive registers it, so a dispatch-only agent needs no HTTP mount of its own.

## Configure

| Variable                      | Purpose                                                                            |
|-------------------------------|------------------------------------------------------------------------------------|
| `MESSENGER_APP_SECRET`        | **Required** — Verifies signed inbound webhook bodies.                             |
| `MESSENGER_VERIFY_TOKEN`      | **Required** — Verifies Meta’s callback setup challenge.                           |
| `MESSENGER_PAGE_ID`           | **Required** — Scopes conversation identity to your Page and binds outbound sends. |
| `MESSENGER_PAGE_ACCESS_TOKEN` | **Required** — Authenticates outbound Graph API calls.                             |

It installs `@flue/messenger` for verified Page ingress and creates an editable Graph API Fetch client for outbound messages. The same client runs in Node and workerd with Flue’s required `nodejs_compat` configuration.

Configure Meta to use:

``` astro-code
https://example.com/channels/messenger/webhook
```

Set the app secret, your chosen verify token, the fixed Page id, and a Page access token. The GET route answers Meta’s verification challenge. The POST route validates the exact body with `X-Hub-Signature-256` before parsing any events.

Connect the app to the Page and subscribe only to the webhook fields the application handles. A useful starting set is `messages`, `message_echoes`, `message_edits`, `messaging_postbacks`, `message_reactions`, `message_deliveries`, `message_reads`, `messaging_optins`, and `messaging_referrals`.

The app secret is an inbound verification credential. The Page access token is an outbound Graph credential. Keep both in trusted server configuration.

## Channel module

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { createMessengerChannel, type MessengerConversationRef } from &#39;@flue/messenger&#39;;
import { defineTool, dispatch } from &#39;@flue/runtime&#39;;
import * as v from &#39;valibot&#39;;
import { Assistant } from &#39;../agents/assistant.ts&#39;;
import { MessengerClient } from &#39;../messenger-client.ts&#39;;

export const client = new MessengerClient({
  pageId: process.env.MESSENGER_PAGE_ID!,
  pageAccessToken: process.env.MESSENGER_PAGE_ACCESS_TOKEN!,
  graphVersion: &#39;v25.0&#39;,
});

export const channel = createMessengerChannel({
  appSecret: process.env.MESSENGER_APP_SECRET!,
  verifyToken: process.env.MESSENGER_VERIFY_TOKEN!,
  pageId: process.env.MESSENGER_PAGE_ID!,

  // Paths: GET and POST /channels/messenger/webhook
  async webhook({ payload }) {
    for (const entry of payload.entry) {
      for (const event of entry.messaging ?? []) {
        // Echoes of the Page&#39;s own sends and other non-message events are
        // left to application policy. Attachment-only messages are skipped;
        // attachments alongside text surface through `attachmentTypes`.
        if (event.message === undefined || event.message.is_echo) continue;
        const conversation = channel.conversationRef(event);
        if (conversation === undefined || event.message.text === undefined) {
          continue;
        }
        const attachmentTypes = (event.message.attachments ?? []).map(
          (attachment) =&gt; attachment.type,
        );
        await dispatch(Assistant, {
          id: channel.instanceId(conversation),
          // Recorded once when this event creates the instance; ignored after.
          initialData: {
            pageId: conversation.pageId,
            participant: conversation.participant,
          },
          message: {
            kind: &#39;signal&#39;,
            type: &#39;messenger.message&#39;,
            body: event.message.text,
            attributes: {
              messageId: event.message.mid,
              ...(event.message.quick_reply?.payload === undefined
                ? {}
                : { quickReplyPayload: event.message.quick_reply.payload }),
              ...(attachmentTypes.length === 0
                ? {}
                : { attachmentTypes: attachmentTypes.join(&#39;,&#39;) }),
            },
          },
        });
      }
    }
  },
});

export function postMessage(ref: MessengerConversationRef) {
  return defineTool({
    name: &#39;post_messenger_message&#39;,
    description: &#39;Post to the Messenger conversation bound to this agent.&#39;,
    input: v.object({ text: v.pipe(v.string(), v.minLength(1)) }),
    async run({ data: { text } }) {
      const result = await client.messages.sendText({
        to: ref.participant,
        text,
      });
      return { output: { messageId: result.messageId } };
    },
  });
}</code></pre>
<figcaption><span>src/channels/messenger.ts</span></figcaption>
</figure>

The blueprint creates `src/messenger-client.ts` with the Fetch client used above. `initialData` is the instance’s creation data: recorded once when the event creates the instance and ignored afterward, so the channel passes it on every dispatch. Bind the tool from the agent with `useInitialData()` instead of parsing the instance id:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>&#39;use agent&#39;;
import { useInitialData, useModel, useTool } from &#39;@flue/runtime&#39;;
import * as v from &#39;valibot&#39;;
import { postMessage } from &#39;../channels/messenger.ts&#39;;

const initialData = v.object({
  pageId: v.string(),
  participant: v.variant(&#39;type&#39;, [
    v.object({ type: v.literal(&#39;page-scoped-id&#39;), id: v.string() }),
    v.object({ type: v.literal(&#39;user-ref&#39;), id: v.string() }),
  ]),
});

export function Assistant() {
  useModel(&#39;anthropic/claude-haiku-4-5&#39;);
  const data = useInitialData&lt;v.InferOutput&lt;typeof initialData&gt;&gt;();
  if (!data) throw new Error(&#39;This agent is created by the Messenger channel dispatch.&#39;);
  useTool(postMessage(data));
  return &#39;Reply concisely in the bound Facebook Messenger conversation.&#39;;
}

Assistant.initialData = initialData;</code></pre>
<figcaption><span>src/agents/assistant.ts</span></figcaption>
</figure>

## Delivery behavior

One signed POST can contain several Page entries and several events. The callback runs once with the provider-native `payload`. Iterate `payload.entry[]` and the native `messaging`, `standby`, and `changes` arrays in Meta’s delivered order; the channel does not reshape, filter, or deduplicate them.

The event family is discriminated by **which property is present** — not by a `type` field — exactly as Meta delivers it. A message has `event.message`, a postback has `event.postback`, a reaction has `event.reaction`, and so on through `event.delivery`, `event.read`, `event.optin`, `event.referral`, and `event.message_edit`. Field names stay snake_case (`mid`, `quick_reply.payload`, `is_echo`), and unmodeled families and fields forward intact.

`standby` events arrive while another app owns the conversation under the Handover protocol. Bot and echo filtering (`message.is_echo`) is application policy: the channel forwards every verified delivery and the application decides what to admit.

Returning nothing produces Meta’s documented `EVENT_RECEIVED` response with status `200`. Return an ordinary Hono or Fetch `Response` for explicit control. Meta retries the delivery on any non-2xx response, so complete only admission work inside the handler and move long-running behavior behind durable dispatch or application queues. A handler that blocks does not buy more time; rely on prompt admission plus idempotency rather than an in-handler deadline. Because retried deliveries can repeat events and reorder after failures, claim stable message ids before dispatch when duplicate admission is unacceptable.

## Identity and capabilities

Instance ids combine the fixed Page with either a Page-scoped person id (PSID) or a `user_ref`. Those participant types are not interchangeable. `channel.conversationRef(event)` derives the counterpart participant for a native messaging event; parse or derive the instance id in trusted code and bind the destination to application-owned tools rather than letting the model choose a recipient id.

Messaging-opt-in (`event.optin`) events may expose a `notification_messages_token` — the recurring-notification capability that pairs with Meta’s one-time and recurring notification (OTN) surfaces. Treat it as a short-lived provider capability and keep it, along with complete native payloads, out of the dispatched message, model context, logs, and durable session history.

## Outbound behavior

The generated client exposes a generic Graph request method plus message and sender-action helpers. Add rich templates, attachments, reactions, typing, or other operations in project code as needed.

Messenger policy still applies. Ordinary replies use the standard 24-hour messaging window; message tags, the one-time and recurring notification (OTN) surfaces, and other outbound paths have separate permission and content requirements. Sending outside the 24-hour window requires an eligible tag or notification token.

Messenger does not provide historical webhook notifications. Store the events your application needs rather than treating process memory as provider history.

See the [`@flue/messenger` README](https://github.com/withastro/flue/tree/main/packages/messenger#readme).


## Docs Navigation

Current page: [Facebook Messenger](/docs/ecosystem/channels/messenger/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


