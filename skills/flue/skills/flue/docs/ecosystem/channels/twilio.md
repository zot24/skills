> Source: https://flueframework.com/docs/ecosystem/channels/twilio

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Twilio


Last updated Jul 21, 2026<a href="/docs/ecosystem/channels/twilio/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a><a href="https://www.npmjs.com/package/@flue/twilio" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800" target="_blank" rel="noopener noreferrer">@flue/twilio</a>


## Quickstart

Add verified SMS and MMS webhook ingress and project-owned outbound messaging to an existing Flue project with the [Twilio](https://www.twilio.com/docs/messaging) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add channel twilio
```

## Overview

The Twilio blueprint installs `@flue/twilio`, creates a project-owned Fetch client at the source-root `twilio-client.ts`, and creates `channels/twilio.ts`. It also updates the selected agent to bind the generated reply tool to the verified conversation.

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { createTwilioChannel } from &#39;@flue/twilio&#39;;
import { dispatch } from &#39;@flue/runtime&#39;;
import { Assistant } from &#39;../agents/assistant.ts&#39;;
import { TwilioClient } from &#39;../twilio-client.ts&#39;;

export const client = new TwilioClient({
  accountSid: process.env.TWILIO_ACCOUNT_SID!,
  authToken: process.env.TWILIO_AUTH_TOKEN!,
});

export const channel = createTwilioChannel({
  accountSid: process.env.TWILIO_ACCOUNT_SID!,
  authToken: process.env.TWILIO_AUTH_TOKEN!,
  webhookUrl: process.env.TWILIO_WEBHOOK_URL!,
  destination: {
    type: &#39;address&#39;,
    address: process.env.TWILIO_PHONE_NUMBER!,
  },
  async webhook({ payload, conversation }) {
    if (payload.OptOutType === &#39;STOP&#39;) return;
    await dispatch(Assistant, {
      id: channel.instanceId(conversation),
      // Recorded once when this event creates the instance; ignored after.
      initialData:
        conversation.type === &#39;messaging-service&#39;
          ? {
              type: conversation.type,
              messagingServiceSid: conversation.messagingServiceSid,
              participant: conversation.participant,
            }
          : {
              type: conversation.type,
              address: conversation.address,
              participant: conversation.participant,
            },
      message: {
        kind: &#39;signal&#39;,
        type: &#39;twilio.message&#39;,
        body: payload.Body,
        attributes: { messageSid: payload.MessageSid, from: payload.From },
      },
    });
  },
});</code></pre>
<figcaption><span>src/channels/twilio.ts (abridged)</span></figcaption>
</figure>

The abridged example omits the generated `postMessage()` tool and the Fetch client implementation. The full blueprint binds that tool to the agent’s creation data read with `useInitialData()`, so verified inbound messages reach the corresponding agent instance and replies are sent to the same participant. Cloudflare projects use the generated standards-based client instead of Twilio’s Node-only helper; Messaging Service destinations and optional delivery-status callbacks are configured as secondary changes.

## Mount the channel

A channel serves HTTP routes only where `app.ts` mounts it. Mount the module’s named `channel` export:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { channel as twilio } from &#39;./channels/twilio.ts&#39;;

app.route(&#39;/channels/twilio&#39;, twilio.route());</code></pre>
<figcaption><span>src/app.ts</span></figcaption>
</figure>

`channel.route()` is a pure router factory serving the channel’s declared routes relative to the mount path. The webhook paths in this guide assume the conventional `/channels/twilio` mount; a different mount path shifts them accordingly. The dispatch-target agent module carries the `'use agent'` directive — the directive registers it, so a dispatch-only agent needs no HTTP mount of its own.

## Configure

| Variable                       | Purpose                                                                                         |
|--------------------------------|-------------------------------------------------------------------------------------------------|
| `TWILIO_ACCOUNT_SID`           | **Required** — Restricts inbound requests and identifies outbound API calls.                    |
| `TWILIO_AUTH_TOKEN`            | **Required** — Verifies inbound signatures and authenticates API calls.                         |
| `TWILIO_WEBHOOK_URL`           | **Required** — Supplies the exact public URL used for signature checks.                         |
| `TWILIO_PHONE_NUMBER`          | **Required for an address-based destination** — Binds an address-based destination.             |
| `TWILIO_MESSAGING_SERVICE_SID` | **Required for a Messaging Service destination** — Binds a Messaging Service destination.       |
| `TWILIO_STATUS_CALLBACK_URL`   | **Required when status callbacks are enabled** — Supplies the exact public status callback URL. |

It installs `@flue/twilio` for verified ingress and creates an editable Fetch client for outbound Programmable Messaging. The official Twilio Node helper is not the canonical path because it is Node-only; the generated REST client runs in Node and workerd with Flue’s required `nodejs_compat` configuration.

Set the inbound webhook URL to:

``` astro-code
https://example.com/channels/twilio/webhook
```

Set the account SID, auth token, destination, and exact public webhook URL. Twilio signs the external configured URL plus every form parameter. An application behind a proxy cannot reliably reconstruct that URL from the request, so `webhookUrl` is required and must include any outer mount prefix or query string.

A trusted proxy may strip an external path prefix before the request reaches Flue. Signature validation still uses `webhookUrl`; the fixed channel route owns the internal path. The incoming request’s own query string is not re-checked — it is already part of the signed bytes, so any tampering fails signature (`401`).

Connection-override fragments may remain in the configured URL. They are excluded from signature validation because Twilio does not send or sign URL fragments.

For a Messaging Service, configure:

``` astro-code
destination: {
  type: 'messaging-service',
  messagingServiceSid: process.env.TWILIO_MESSAGING_SERVICE_SID!,
},
```

The package rejects signed requests for another account or destination.

## Channel module

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { createTwilioChannel } from &#39;@flue/twilio&#39;;
import { defineTool, dispatch } from &#39;@flue/runtime&#39;;
import * as v from &#39;valibot&#39;;
import { Assistant } from &#39;../agents/assistant.ts&#39;;
import { TwilioClient } from &#39;../twilio-client.ts&#39;;

export const client = new TwilioClient({
  accountSid: process.env.TWILIO_ACCOUNT_SID!,
  authToken: process.env.TWILIO_AUTH_TOKEN!,
});

export const channel = createTwilioChannel({
  accountSid: process.env.TWILIO_ACCOUNT_SID!,
  authToken: process.env.TWILIO_AUTH_TOKEN!,
  webhookUrl: process.env.TWILIO_WEBHOOK_URL!,
  destination: {
    type: &#39;address&#39;,
    address: process.env.TWILIO_PHONE_NUMBER!,
  },

  // Path: /channels/twilio/webhook
  async webhook({ payload, conversation }) {
    if (payload.OptOutType === &#39;STOP&#39;) return;
    const attributes: Record&lt;string, string&gt; = {
      messageSid: payload.MessageSid,
      from: payload.From,
    };
    const numMedia = Number(payload.NumMedia ?? &#39;0&#39;);
    if (numMedia &gt; 0) {
      attributes.numMedia = String(numMedia);
      for (let index = 0; index &lt; numMedia; index += 1) {
        const contentType = payload[`MediaContentType${index}`];
        if (typeof contentType === &#39;string&#39;) {
          attributes[`mediaContentType${index}`] = contentType;
        }
      }
    }
    await dispatch(Assistant, {
      id: channel.instanceId(conversation),
      // Recorded once when this event creates the instance; ignored after.
      initialData:
        conversation.type === &#39;messaging-service&#39;
          ? {
              type: conversation.type,
              messagingServiceSid: conversation.messagingServiceSid,
              participant: conversation.participant,
            }
          : {
              type: conversation.type,
              address: conversation.address,
              participant: conversation.participant,
            },
      message: {
        kind: &#39;signal&#39;,
        type: &#39;twilio.message&#39;,
        body: payload.Body,
        attributes,
      },
    });
  },
});

export function postMessage(
  ref:
    | { type: &#39;address&#39;; address: string; participant: string }
    | { type: &#39;messaging-service&#39;; messagingServiceSid: string; participant: string },
) {
  return defineTool({
    name: &#39;post_twilio_message&#39;,
    description: &#39;Post to the Twilio conversation bound to this agent.&#39;,
    input: v.object({ text: v.pipe(v.string(), v.minLength(1)) }),
    async run({ data: { text } }) {
      const result = await client.messages.create({
        to: ref.participant,
        body: text,
        ...(ref.type === &#39;messaging-service&#39;
          ? { messagingServiceSid: ref.messagingServiceSid }
          : { from: ref.address }),
      });
      return { output: { messageSid: result.sid } };
    },
  });
}</code></pre>
<figcaption><span>src/channels/twilio.ts</span></figcaption>
</figure>

The blueprint creates `src/twilio-client.ts` with the Fetch client used above. `initialData` is the instance’s creation data: recorded once when the event creates the instance and ignored afterward, so the channel passes it on every dispatch. It carries the conversation ref fields the reply tool needs.

## Wire the agent

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>&#39;use agent&#39;;
import { useInitialData, useModel, useTool } from &#39;@flue/runtime&#39;;
import * as v from &#39;valibot&#39;;
import { postMessage } from &#39;../channels/twilio.ts&#39;;

const initialData = v.variant(&#39;type&#39;, [
  v.object({ type: v.literal(&#39;address&#39;), address: v.string(), participant: v.string() }),
  v.object({
    type: v.literal(&#39;messaging-service&#39;),
    messagingServiceSid: v.string(),
    participant: v.string(),
  }),
]);

export function Assistant() {
  useModel(&#39;anthropic/claude-haiku-4-5&#39;);
  const data = useInitialData&lt;v.InferOutput&lt;typeof initialData&gt;&gt;();
  if (!data) throw new Error(&#39;This agent is created by the Twilio channel dispatch.&#39;);
  useTool(postMessage(data));
  return &#39;Reply concisely in the bound Twilio conversation.&#39;;
}

Assistant.initialData = initialData;</code></pre>
<figcaption><span>src/agents/assistant.ts</span></figcaption>
</figure>

The agent’s `initialData` static validates the dispatched `initialData` when the instance is created; `useInitialData()` returns the parsed value on every render — the agent reads the conversation ref this way instead of parsing it from the instance id.

## Message behavior

Verified messages reach the handler as `{ c, payload, conversation, idempotencyToken? }`. `payload` is the provider-native verified form exactly as Twilio signed it: field names use Twilio’s PascalCase wire spelling (`MessageSid`, `From`, `To`, `Body`, `NumMedia`, `MediaUrl0`, `OptOutType`, …), every value is a `string`, and a parameter Twilio repeats becomes a `readonly string[]`. The channel does not rename, narrow, or coerce fields; new parameters Twilio adds reach the handler through an index signature, so read them directly with their wire names. Parse segment counts, MMS metadata, opt-out state, geographic, and rich-message fields in application code. `conversation` is the canonical ref derived from the verified destination and sender; `idempotencyToken` carries Twilio’s `I-Twilio-Idempotency-Token` when present.

Treat `STOP` as control input rather than dispatching it to an agent or sending an application reply.

Returning nothing produces an empty TwiML `<Response/>` with status `200`. Return an ordinary Hono or Fetch `Response` for explicit TwiML, status, or headers.

MMS URLs require Twilio credentials. Fetch media only in trusted application code and avoid placing authenticated content or raw forms into model context.

## Delivery status

Add `statusCallbackUrl` and `statusCallback` together to publish:

``` astro-code
https://example.com/channels/twilio/status
```

Set the same URL as `StatusCallback` on outbound messages. The status handler input mirrors the inbound shape: `payload` carries the exact `MessageStatus` string forwarded verbatim — never narrowed to a frozen union — alongside every other signed status parameter (sender, recipient, error, channel, and delivery-receipt fields), with the same string / `string[]` rules and index-signature forwarding. `conversation` is present only when the signed fields identify the configured destination: `From` must match an address destination, or `MessagingServiceSid` must match a Messaging Service destination.

Twilio may retry status callbacks with backoff, and may deliver them duplicated or out of order. Persist transitions idempotently by message SID; the channel is stateless and exposes `MessageSid` and `I-Twilio-Idempotency-Token` without claiming durable deduplication. Retried requests can reuse the idempotency token, but applications still own durable idempotency.

Twilio does not guarantee `MessagingServiceSid` in every status callback. The channel still forwards a verified callback when that field is missing or does not match, but omits `conversation`; it derives Messaging Service conversation identity only from an exact signed SID match. Read `payload.MessagingServiceSid` in application code when the raw value matters.

## Deadlines

Twilio applies a 15-second read timeout to webhook responses and recommends acknowledging fast and processing asynchronously. The channel does not enforce a deadline of its own. Inbound message webhooks are not retried by default: on error or timeout Twilio uses the configured Fallback URL instead. Connection overrides on the webhook URL can opt into retries with `rc` (retry count) and `rp` (retry policy), for example `#rc=2&rp=all`; that fragment is excluded from the signed URL. Acknowledge before slow work and make admission idempotent when retries are enabled.

See the [`@flue/twilio` README](https://github.com/withastro/flue/tree/main/packages/twilio#readme).


## Docs Navigation

Current page: [Twilio](/docs/ecosystem/channels/twilio/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


