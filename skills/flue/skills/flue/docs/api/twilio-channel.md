<!-- Source: https://flueframework.com/docs/api/twilio-channel -->

Import from `@flue/twilio`.

## `createTwilioChannel()` [\#](https://flueframework.com/docs/api/twilio-channel/\#createtwiliochannel)

```
function createTwilioChannel<E extends Env = Env>(
  options: TwilioChannelOptions<E>,
): TwilioChannel<E>;
```

Creates required `POST /webhook` ingress and optional `POST /status` ingress
for one fixed Twilio account and messaging destination.

## `TwilioChannelOptions` [\#](https://flueframework.com/docs/api/twilio-channel/\#twiliochanneloptions)

```
interface TwilioChannelOptions<E extends Env = Env> {
  accountSid: string;
  authToken: string;
  webhookUrl: string;
  destination: TwilioDestination;
  bodyLimit?: number;
  webhook(input: TwilioWebhookHandlerInput<E>): TwilioHandlerResult;
  statusCallbackUrl?: string;
  statusCallback?(input: TwilioStatusHandlerInput<E>): TwilioHandlerResult;
}
```

| Field | Description |
| --- | --- |
| `accountSid` | Required account SID in every accepted callback. |
| `authToken` | Auth token for `X-Twilio-Signature` HMAC-SHA1 validation. |
| `webhookUrl` | Exact externally configured inbound URL, including query strings. |
| `destination` | Fixed phone/channel address or Messaging Service. |
| `bodyLimit` | Maximum form body. Default: 1 MiB. |
| `webhook` | Callback for one verified SMS or MMS message. |
| `statusCallbackUrl` | Exact public status URL. Required with `statusCallback`. |
| `statusCallback` | Optional delivery callback. Omitting it leaves `/status` unmounted. |

Connection-override fragments are allowed in configured URLs and excluded from
the signed URL as Twilio specifies.

```
type TwilioDestination =
  | { type: 'address'; address: string }
  | { type: 'messaging-service'; messagingServiceSid: string };

type TwilioHandlerResult = undefined | Response | Promise<undefined | Response>;
```

Returning nothing from `webhook` produces an empty TwiML `<Response/>` with
status `200`. Returning nothing from `statusCallback` produces an empty `200`.
An ordinary Hono or Fetch `Response` passes through.

## `TwilioChannel` [\#](https://flueframework.com/docs/api/twilio-channel/\#twiliochannel)

```
interface TwilioChannel<E extends Env = Env> {
  readonly routes: readonly ChannelRoute<E>[];
  conversationKey(ref: TwilioConversationRef): string;
  parseConversationKey(id: string): TwilioConversationRef;
}
```

A file named `channels/twilio.ts` serves
`/channels/twilio/webhook` and, when enabled,
`/channels/twilio/status` relative to the `flue()` mount.

The channel does not persist or deduplicate message SIDs, status transitions,
or retry tokens. Conversation keys are canonical identifiers, not
authorization capabilities.

## Provider-native form body [\#](https://flueframework.com/docs/api/twilio-channel/\#provider-native-form-body)

Handlers receive the verified Twilio form exactly as Twilio signed it. The
channel does not rename, narrow, or coerce fields.

```
interface TwilioWebhookPayload {
  readonly [field: string]: string | readonly string[] | undefined;
}
```

- Field names use Twilio’s PascalCase wire spelling (`MessageSid`, `From`,
`Body`, `NumMedia`, `MediaUrl0`, …).
- Every value is a `string`. A parameter Twilio repeats becomes a
`readonly string[]`.
- The index signature forwards any parameter the modeled types do not name, so
fields Twilio adds without advance notice reach the handler unmodified. Read
them directly with their wire names.

Two concrete bodies model only the identity fields the channel verifies; the
index signature carries everything else:

```
interface TwilioIncomingMessagePayload extends TwilioWebhookPayload {
  readonly MessageSid: string;
  readonly AccountSid: string;
  readonly From: string;
  readonly To: string;
  readonly Body: string;
}

interface TwilioStatusCallbackPayload extends TwilioWebhookPayload {
  readonly MessageSid: string;
  readonly AccountSid: string;
  readonly MessageStatus: string;
}
```

`MessageStatus` is forwarded verbatim — Twilio’s exact lifecycle value, never
narrowed to a frozen union. Parse numbers, media counts (`NumMedia`,
`MediaUrl{N}`, `MediaContentType{N}`), opt-out values (`OptOutType`), geographic
and rich-message fields in application code.

## Incoming messages [\#](https://flueframework.com/docs/api/twilio-channel/\#incoming-messages)

```
interface TwilioWebhookHandlerInput<E extends Env = Env> {
  c: Context<E>;
  payload: TwilioIncomingMessagePayload;
  conversation: TwilioConversationRef;
  idempotencyToken?: string;
}
```

- `payload` is the verified native form (above).
- `conversation` is the canonical ref derived from the verified destination
(`To`) and sender (`From`).
- `idempotencyToken` carries `I-Twilio-Idempotency-Token` when Twilio supplies
it. The channel makes no deduplication claim.

A request missing a required routing field (`MessageSid`, `AccountSid`, `From`,
`To`) is rejected with `400`. Because a repeated known scalar surfaces as a
`string[]`, a duplicated `MessageSid` fails the required-string check and is
rejected the same way. A signed callback for another account or a destination
that does not match the configured `destination` is rejected with `403`.

## Status callbacks [\#](https://flueframework.com/docs/api/twilio-channel/\#status-callbacks)

```
interface TwilioStatusHandlerInput<E extends Env = Env> {
  c: Context<E>;
  payload: TwilioStatusCallbackPayload;
  conversation?: TwilioConversationRef;
  idempotencyToken?: string;
}
```

- `payload` carries the exact `MessageStatus` string and every other signed status
parameter (sender, recipient, error, channel, delivery-receipt fields).
- `conversation` is present only when the signed fields identify the configured
destination. For an address destination, signed `From` must match that address;
for a Messaging Service destination, signed `MessagingServiceSid` must match
the configured service. Status callbacks swap the sender/recipient roles:
`address` is `From` and `participant` is `To`.
- `idempotencyToken` is exposed as above.

A request missing `MessageSid`, `AccountSid`, or `MessageStatus` is rejected with
`400`; a wrong account SID is rejected with `403`. Twilio does not guarantee
`MessagingServiceSid` on every status callback, and the channel does **not** gate
status callbacks on it — the signed account SID and the exact signed callback
URL scope the route. Read `payload.MessagingServiceSid` in application code when a
present value matters.

## Conversation identity [\#](https://flueframework.com/docs/api/twilio-channel/\#conversation-identity)

```
type TwilioConversationRef =
  | {
      type: 'address';
      accountSid: string;
      address: string;
      participant: string;
    }
  | {
      type: 'messaging-service';
      accountSid: string;
      messagingServiceSid: string;
      address: string;
      participant: string;
    };
```

`address` is the concrete Twilio phone number or channel address.
`participant` is the external destination used for an outbound reply.

## Deadlines and retries [\#](https://flueframework.com/docs/api/twilio-channel/\#deadlines-and-retries)

Twilio applies a 15-second read timeout to webhook responses and recommends
acknowledging fast (an empty `200`/`202`) and processing asynchronously. The
channel does not enforce a deadline of its own; it awaits the handler and
serializes the result.

Twilio does not retry inbound message webhooks by default. A configured Fallback
URL handles an error or timeout instead. Connection overrides on the configured
URL can opt into retries: `rc` sets the retry count and `rp` selects which
failures retry. The fragment carrying those overrides, such as `#rc=2&rp=all`,
is not part of the signed URL. Status callbacks may also be retried with backoff
and can arrive duplicated or out of order.

The channel is stateless and exposes `MessageSid` and
`I-Twilio-Idempotency-Token` without claiming durable deduplication. Retried
requests can reuse the idempotency token, but applications still own durable
idempotency. Claim `MessageSid` before dispatch when duplicate admission is
unacceptable.

## Errors [\#](https://flueframework.com/docs/api/twilio-channel/\#errors)

- `InvalidTwilioConversationKeyError`
- `InvalidTwilioInputError`, with structured `field`

See [Twilio setup](https://flueframework.com/docs/ecosystem/channels/twilio/) for webhook configuration and
project-owned Fetch composition.

## Docs Navigation

Current page: [Twilio Channel API](https://flueframework.com/docs/api/twilio-channel/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
