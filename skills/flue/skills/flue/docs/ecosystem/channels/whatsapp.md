> Source: https://flueframework.com/docs/ecosystem/channels/whatsapp

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# WhatsApp


AI-generated, awaiting review <a href="/docs/ecosystem/channels/whatsapp/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a> <a href="https://www.npmjs.com/package/@flue/whatsapp" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800" target="_blank" rel="noopener noreferrer">@flue/whatsapp</a>


## Quickstart

Add verified WhatsApp Business Cloud webhook ingress with project-owned outbound WhatsApp access to an existing Flue project with the [WhatsApp](https://developers.facebook.com/docs/whatsapp/cloud-api) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add channel whatsapp
```

## Overview

The blueprint installs `@flue/whatsapp` and `@kapso/whatsapp-cloud-api`, creates a source-root `channels/whatsapp.ts` module with named `channel` and project-owned `client` exports, and modifies the selected agent to bind the generated message tool.

``` astro-code
import { createWhatsAppChannel } from '@flue/whatsapp';
import { dispatch } from '@flue/runtime';
import { WhatsAppClient } from '@kapso/whatsapp-cloud-api';
import assistant from '../agents/assistant.ts';

export const client = new WhatsAppClient({
  accessToken: process.env.WHATSAPP_ACCESS_TOKEN!,
  graphVersion: 'v25.0',
});

export const channel = createWhatsAppChannel({
  appSecret: process.env.WHATSAPP_APP_SECRET!,
  verifyToken: process.env.WHATSAPP_VERIFY_TOKEN!,
  async webhook({ payload }) {
    for (const entry of payload.entry) {
      for (const change of entry.changes) {
        if (change.field !== 'messages') continue;
        if (change.value.metadata.phone_number_id !== process.env.WHATSAPP_PHONE_NUMBER_ID)
          continue;
        for (const message of change.value.messages ?? []) {
          if (message.type !== 'text' && message.type !== 'interactive') continue;
          await dispatch(assistant, {
            id: channel.conversationKey(conversationRef(entry.id, change.value, message)),
            input: { type: `whatsapp.${message.type}`, messageId: message.id, message },
          });
        }
      }
    }
  },
});
```

The abridged example omits the generated `conversationRef` helper and outbound message tool. Once configured, supported messages continue the agent instance for the verified business-scoped user or group, and the bound client tool replies to that same destination. The Fetch-based client runs on Node and Cloudflare Workers with Flue’s `nodejs_compat` setting.

## Configure

| Variable                       | Purpose                                                                      |
|--------------------------------|------------------------------------------------------------------------------|
| `WHATSAPP_APP_SECRET`          | **Required** — Verifies signed inbound webhook bodies.                       |
| `WHATSAPP_VERIFY_TOKEN`        | **Required** — Verifies Meta’s callback setup challenge.                     |
| `WHATSAPP_ACCESS_TOKEN`        | **Required** — Authenticates outbound Graph API calls.                       |
| `WHATSAPP_PHONE_NUMBER_ID`     | **Required** — Restricts handling to the configured phone number.            |
| `WHATSAPP_BUSINESS_ACCOUNT_ID` | **Optional** — Restricts handling by business account as application policy. |

It installs `@flue/whatsapp` for verified ingress and `@kapso/whatsapp-cloud-api` for project-owned Graph API access. `@flue/whatsapp` requires Node 24 because its selected webhook type package declares that engine floor. The client is Fetch-based and runs in Node and workerd with Flue’s required `nodejs_compat` configuration.

Set the callback URL to:

``` astro-code
https://example.com/channels/whatsapp/webhook
```

Configure the Meta app with the route above and a random `WHATSAPP_VERIFY_TOKEN`. Subscribe the WhatsApp Business Account to the `messages` field.

Meta sends GET requests for `hub.challenge` verification and signs POST bodies with the app secret in `X-Hub-Signature-256`. The package verifies the exact bytes, then forwards Meta’s provider-native payload unmodified. It does not filter by business account or phone number; restricting to your configured phone number (`metadata.phone_number_id`) or business account (`entry[].id`) is application policy, as the handler below shows.

Use a system-user or business access token for production outbound calls. Keep Graph API versions explicit and test an upgrade before changing them.

## Channel module

``` astro-code
import {
  createWhatsAppChannel,
  type WebhookMessage,
  type WebhookValue,
  type WhatsAppConversationRef,
} from '@flue/whatsapp';
import { defineTool, dispatch } from '@flue/runtime';
import { WhatsAppClient, type SendMessageResponse } from '@kapso/whatsapp-cloud-api';
import * as v from 'valibot';
import assistant from '../agents/assistant.ts';

export const client = new WhatsAppClient({
  accessToken: process.env.WHATSAPP_ACCESS_TOKEN!,
  graphVersion: 'v25.0',
});

export const channel = createWhatsAppChannel({
  appSecret: process.env.WHATSAPP_APP_SECRET!,
  verifyToken: process.env.WHATSAPP_VERIFY_TOKEN!,

  // Paths: GET and POST /channels/whatsapp/webhook
  async webhook({ payload }) {
    const expectedPhoneNumberId = process.env.WHATSAPP_PHONE_NUMBER_ID!;
    for (const entry of payload.entry) {
      for (const change of entry.changes) {
        if (change.field !== 'messages') continue;
        const value = change.value;
        // Filtering authenticated deliveries by phone number is application policy.
        if (value.metadata.phone_number_id !== expectedPhoneNumberId) continue;
        for (const message of value.messages ?? []) {
          if (message.type !== 'text' && message.type !== 'interactive') continue;
          await dispatch(assistant, {
            id: channel.conversationKey(conversationRef(entry.id, value, message)),
            input: {
              type: `whatsapp.${message.type}`,
              messageId: message.id,
              message,
            },
          });
        }
      }
    }
  },
});

// Derive stable individual identity from the business-scoped user id.
function conversationRef(
  businessAccountId: string,
  value: WebhookValue,
  message: WebhookMessage,
): WhatsAppConversationRef {
  const phoneNumberId = value.metadata.phone_number_id;
  if (message.group_id) {
    return { type: 'group', businessAccountId, phoneNumberId, groupId: message.group_id };
  }
  return {
    type: 'individual',
    businessAccountId,
    phoneNumberId,
    destination: { type: 'user-id', userId: message.from_user_id },
  };
}

function sendTextMessage(ref: WhatsAppConversationRef, body: string): Promise<SendMessageResponse> {
  if (ref.type === 'group') {
    return client.messages.sendText({
      phoneNumberId: ref.phoneNumberId,
      recipientType: 'group',
      to: ref.groupId,
      body,
    });
  }
  if (ref.destination.type === 'phone-number') {
    return client.messages.sendText({
      phoneNumberId: ref.phoneNumberId,
      recipientType: 'individual',
      to: ref.destination.phoneNumber,
      body,
    });
  }
  return client.request<SendMessageResponse>('POST', `${ref.phoneNumberId}/messages`, {
    body: {
      messaging_product: 'whatsapp',
      recipient_type: 'individual',
      recipient: ref.destination.userId,
      type: 'text',
      text: { body },
    },
    responseType: 'json',
  });
}

export function postMessage(ref: WhatsAppConversationRef) {
  return defineTool({
    name: 'post_whatsapp_message',
    description: 'Post to the WhatsApp conversation bound to this agent.',
    input: v.object({
      text: v.pipe(v.string(), v.minLength(1), v.maxLength(4096)),
    }),
    async run({ input: { text } }) {
      const result = await sendTextMessage(ref, text);
      return { messageId: result.messages[0]?.id ?? null };
    },
  });
}
```

Bind the tool from the agent with `postMessage(channel.parseConversationKey(id))`. Trusted application code selects the destination; the model selects only message text.

## Delivery behavior

One POST can contain many entries, changes, messages, and statuses. The callback runs once with the complete verified delivery; `payload` is Meta’s provider-native webhook object, forwarded unmodified and typed by the third-party, community-maintained `@whatsapp-cloudapi/types` package. Walk `payload.entry[].changes[]` in the order Meta sent them, narrow on `change.field`, then on `message.type` or `status`, and process every applicable item before returning.

The `message.type` discriminant covers text, image, audio, video, document, sticker, location, contacts, interactive button/list/flow replies, legacy buttons, reactions, order, system, and unsupported messages. Authenticated future shapes still forward at runtime, but may require an application cast or type guard until the type package models them. The `status` discriminant preserves `sent`, `delivered`, `read`, `played`, and `failed`.

Returning nothing produces an empty `200`. A JSON-compatible value becomes the response body; a Hono or Fetch `Response` passes through. A thrown handler is not swallowed and reaches Hono’s error handler.

Meta expects a prompt `200` (within a few seconds) or it may mark the webhook inactive, and it retries non-`200` deliveries with decreasing frequency for up to seven days, so duplicates are expected. Admit durable work quickly (dispatch, then return) instead of blocking on slow operations. The channel is stateless and does not deduplicate; claim message ids in durable application storage before dispatch when duplicate admission is unacceptable.

## Conversation identity

Meta supplies a Business-Scoped User ID (`from_user_id`) in incoming message webhooks and may omit or change the sender phone number (`from`) as account features evolve. The `conversationRef` helper above always uses `from_user_id` for stable inbound individual identity, even when `from` is present. Group destinations use the provider `group_id`.

The current SDK release exposes broad Graph API helpers but its high-level text helper models only `to`. The example keeps the full exported SDK client and uses its authenticated low-level `request()` method for the documented BSUID `recipient` shape. Test each relied-on operation against fake Fetch in Node and workerd.

Native media payloads carry a bearer-authenticated media `id` (and, on newer API versions, a transient `url`). Treat both as transport credentials: download media with the project-owned client using the verified id, and avoid forwarding the raw `payload` or media URLs into model context wholesale.

See the [`@flue/whatsapp` README](https://github.com/withastro/flue/tree/main/packages/whatsapp#readme).


## Docs Navigation

Current page: [WhatsApp](/docs/ecosystem/channels/whatsapp/)

### Sections

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


