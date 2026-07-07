<!-- Source: https://flueframework.com/docs/api/whatsapp-channel -->

> NOTE: upstream page removed; content frozen as of last sync

Import from `@flue/whatsapp`.

## `createWhatsAppChannel()` [\#](https://flueframework.com/docs/api/whatsapp-channel/\#createwhatsappchannel)

```
function createWhatsAppChannel<E extends Env = Env>(
  options: WhatsAppChannelOptions<E>,
): WhatsAppChannel<E>;
```

Creates `GET /webhook` for endpoint verification and `POST /webhook` for
signed deliveries.

## `WhatsAppChannelOptions` [\#](https://flueframework.com/docs/api/whatsapp-channel/\#whatsappchanneloptions)

```
interface WhatsAppChannelOptions<E extends Env = Env> {
  appSecret: string;
  verifyToken: string;
  bodyLimit?: number;
  webhook(input: WhatsAppWebhookHandlerInput<E>): WhatsAppHandlerResult;
}
```

| Field | Description |
| --- | --- |
| `appSecret` | Meta app secret for exact-body HMAC-SHA256 verification. |
| `verifyToken` | User-chosen token for GET challenge verification. |
| `bodyLimit` | Maximum POST body. Default: 3 \* 1024 \* 1024 bytes. |
| `webhook` | Callback for one verified delivery with every change preserved. |

The channel verifies the exact request bytes and then forwards Meta’s
provider-native payload unmodified. It does not filter by business account or
phone number; restricting to your configured phone number
(`metadata.phone_number_id`) or business account (`entry[].id`) is application
policy.

## `WhatsAppWebhookHandlerInput` [\#](https://flueframework.com/docs/api/whatsapp-channel/\#whatsappwebhookhandlerinput)

```
interface WhatsAppWebhookHandlerInput<E extends Env = Env> {
  c: Context<E>;
  payload: WhatsAppWebhookPayload;
}
```

`c` is the Hono request context. `payload` is the verified, provider-native
WhatsApp Cloud API webhook object, forwarded unmodified.

```
type WhatsAppHandlerResult = WhatsAppHandlerValue | Promise<WhatsAppHandlerValue>;
// WhatsAppHandlerValue = undefined | JsonValue | Response
```

Returning nothing produces an empty `200`. A JSON-compatible value becomes the
response body. An ordinary Hono or Fetch `Response` passes through. A thrown
handler is not swallowed; it reaches Hono’s error handler.

## `WhatsAppChannel` [\#](https://flueframework.com/docs/api/whatsapp-channel/\#whatsappchannel)

```
interface WhatsAppChannel<E extends Env = Env> {
  readonly routes: readonly ChannelRoute<E>[];
  conversationKey(ref: WhatsAppConversationRef): string;
  parseConversationKey(id: string): WhatsAppConversationRef;
}
```

A file named `channels/whatsapp.ts` serves GET and POST
`/channels/whatsapp/webhook` relative to the `flue()` mount.

The channel does not persist or deduplicate deliveries. Conversation keys are
canonical identifiers, not authorization capabilities.

## Payload [\#](https://flueframework.com/docs/api/whatsapp-channel/\#payload)

```
type WhatsAppWebhookPayload = WebhookPayload;
```

`payload` is Meta’s provider-native `whatsapp_business_account` webhook object,
forwarded unmodified after exact-body signature verification. Its field names,
nesting, and discriminants match Meta’s documented wire shape. One POST may
batch multiple entries, changes, messages, and statuses; walk
`payload.entry[].changes[]` in the order Meta sent them, narrowing on
`change.field`, then on `message.type` or `status`.

The channel re-exports provider-shaped webhook types from the third-party,
community-maintained
[`@whatsapp-cloudapi/types`](https://www.npmjs.com/package/@whatsapp-cloudapi/types)
package:

```
import type {
  WebhookChange,
  WebhookContact,
  WebhookConversation,
  WebhookEntry,
  WebhookError,
  WebhookMessage,
  WebhookMessageContact,
  WebhookMetadata,
  WebhookPayload,
  WebhookPricing,
  WebhookReferral,
  WebhookStatus,
  WebhookValue,
} from '@flue/whatsapp';
```

Within a `messages` change, `change.value.messages[].type` discriminates text,
image, audio, video, document, sticker, location, contacts, interactive
replies, legacy buttons, reactions, order, system, and unsupported messages.
Authenticated future event and message shapes are still forwarded at runtime,
but TypeScript consumers may need a cast or application type guard until the
type package models them. The `change.value.statuses[].status` discriminant
preserves `sent`, `delivered`, `read`, `played`, and `failed`. Do not dispatch
or persist raw payloads wholesale.

## Identity [\#](https://flueframework.com/docs/api/whatsapp-channel/\#identity)

```
type WhatsAppConversationRef =
  | {
      type: 'individual';
      businessAccountId: string;
      phoneNumberId: string;
      destination:
        | {
            type: 'phone-number';
            phoneNumber: string;
          }
        | {
            type: 'user-id';
            userId: string;
          };
    }
  | {
      type: 'group';
      businessAccountId: string;
      phoneNumberId: string;
      groupId: string;
    };
```

Individual destinations distinguish phone numbers from Meta Business-Scoped
User IDs so equal strings in different identity namespaces cannot collide.
For stable inbound individual identity, derive the destination from the BSUID
(`message.from_user_id`) even when `message.from` is also present. Groups remain
keyed by provider `group_id`.

`conversationKey(ref)` serializes a canonical namespaced identifier suitable for
a Flue agent-instance id; it is not an authorization capability.
`parseConversationKey(id)` parses only keys produced by `conversationKey()` and
throws `InvalidWhatsAppConversationKeyError` otherwise. The round trip is
lossless across phone, BSUID, and group destinations.

## Errors [\#](https://flueframework.com/docs/api/whatsapp-channel/\#errors)

- `InvalidWhatsAppConversationKeyError`
- `InvalidWhatsAppInputError`, with structured `field`

See [WhatsApp setup](https://flueframework.com/docs/ecosystem/channels/whatsapp/) for Meta configuration and
project-owned client composition.

## Docs Navigation

Current page: [WhatsApp Channel API](https://flueframework.com/docs/api/whatsapp-channel/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
