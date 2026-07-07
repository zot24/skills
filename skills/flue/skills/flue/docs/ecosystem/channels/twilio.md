> Source: https://flueframework.com/docs/ecosystem/channels/twilio



# Twilio


AI-generated, awaiting review <a href="/docs/ecosystem/channels/twilio/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a> <a href="https://www.npmjs.com/package/@flue/twilio" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800" target="_blank" rel="noopener noreferrer">@flue/twilio</a>


## Quickstart

Add verified SMS and MMS webhook ingress and project-owned outbound messaging to an existing Flue project with the [Twilio](https://www.twilio.com/docs/messaging) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add channel twilio
```

## Overview

The Twilio blueprint installs `@flue/twilio`, creates a project-owned Fetch client at the source-root `twilio-client.ts`, and creates `channels/twilio.ts`. It also updates the selected agent to bind the generated reply tool to the verified conversation.

``` astro-code
import { createTwilioChannel } from '@flue/twilio';
import { dispatch } from '@flue/runtime';
import assistant from '../agents/assistant.ts';
import { TwilioClient } from '../twilio-client.ts';

export const client = new TwilioClient({
  accountSid: process.env.TWILIO_ACCOUNT_SID!,
  authToken: process.env.TWILIO_AUTH_TOKEN!,
});

export const channel = createTwilioChannel({
  accountSid: process.env.TWILIO_ACCOUNT_SID!,
  authToken: process.env.TWILIO_AUTH_TOKEN!,
  webhookUrl: process.env.TWILIO_WEBHOOK_URL!,
  destination: {
    type: 'address',
    address: process.env.TWILIO_PHONE_NUMBER!,
  },
  async webhook({ payload, conversation }) {
    if (payload.OptOutType === 'STOP') return;
    await dispatch(assistant, {
      id: channel.conversationKey(conversation),
      input: {
        type: 'twilio.message',
        messageSid: payload.MessageSid,
        from: payload.From,
        text: payload.Body,
      },
    });
  },
});
```

The abridged example omits the generated `postMessage()` tool and the Fetch client implementation. The full blueprint binds that tool to the agent’s parsed conversation, so verified inbound messages reach the corresponding agent instance and replies are sent to the same participant. Cloudflare projects use the generated standards-based client instead of Twilio’s Node-only helper; Messaging Service destinations and optional delivery-status callbacks are configured as secondary changes.

## Configure

| Variable | Purpose |
|----|----|
| `TWILIO_ACCOUNT_SID` | **Required** — Restricts inbound requests and identifies outbound API calls. |
| `TWILIO_AUTH_TOKEN` | **Required** — Verifies inbound signatures and authenticates API calls. |
| `TWILIO_WEBHOOK_URL` | **Required** — Supplies the exact public URL used for signature checks. |
| `TWILIO_PHONE_NUMBER` | **Required for an address-based destination** — Binds an address-based destination. |
| `TWILIO_MESSAGING_SERVICE_SID` | **Required for a Messaging Service destination** — Binds a Messaging Service destination. |
| `TWILIO_STATUS_CALLBACK_URL` | **Required when status callbacks are enabled** — Supplies the exact public status callback URL. |

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

``` astro-code
import { createTwilioChannel, type TwilioConversationRef } from '@flue/twilio';
import { defineTool, dispatch } from '@flue/runtime';
import * as v from 'valibot';
import assistant from '../agents/assistant.ts';
import { TwilioClient } from '../twilio-client.ts';

export const client = new TwilioClient({
  accountSid: process.env.TWILIO_ACCOUNT_SID!,
  authToken: process.env.TWILIO_AUTH_TOKEN!,
});

export const channel = createTwilioChannel({
  accountSid: process.env.TWILIO_ACCOUNT_SID!,
  authToken: process.env.TWILIO_AUTH_TOKEN!,
  webhookUrl: process.env.TWILIO_WEBHOOK_URL!,
  destination: {
    type: 'address',
    address: process.env.TWILIO_PHONE_NUMBER!,
  },

  // Path: /channels/twilio/webhook
  async webhook({ payload, conversation }) {
    if (payload.OptOutType === 'STOP') return;
    const numMedia = Number(payload.NumMedia ?? '0');
    await dispatch(assistant, {
      id: channel.conversationKey(conversation),
      input: {
        type: 'twilio.message',
        messageSid: payload.MessageSid,
        from: payload.From,
        text: payload.Body,
        media: Array.from({ length: numMedia }, (_, index) => ({
          index,
          contentType: payload[`MediaContentType${index}`],
        })),
      },
    });
  },
});

export function postMessage(ref: TwilioConversationRef) {
  return defineTool({
    name: 'post_twilio_message',
    description: 'Post to the Twilio conversation bound to this agent.',
    input: v.object({ text: v.pipe(v.string(), v.minLength(1)) }),
    async run({ input: { text } }) {
      const result = await client.messages.create({
        to: ref.participant,
        body: text,
        ...(ref.type === 'messaging-service'
          ? { messagingServiceSid: ref.messagingServiceSid }
          : { from: ref.address }),
      });
      return { messageSid: result.sid };
    },
  });
}
```

The blueprint creates `src/twilio-client.ts` with the Fetch client used above. Bind the tool from the agent with `postMessage(channel.parseConversationKey(id))`.

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

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


