<!-- Source: https://flueframework.com/docs/api/stripe-channel -->

> NOTE: upstream page removed; content frozen as of last sync

Import from `@flue/stripe`.

## `createStripeChannel()` [\#](https://flueframework.com/docs/api/stripe-channel/\#createstripechannel)

```
function createStripeChannel<E extends Env = Env>(
  options: StripeSnapshotChannelOptions<E>,
): StripeChannel<E>;

function createStripeChannel<E extends Env = Env>(
  options: StripeThinChannelOptions<E>,
): StripeChannel<E>;
```

Creates one stateless Stripe webhook channel. The callback is stored during
construction and runs only after Stripe’s SDK verifies the exact request bytes,
signature timestamp, and configured payload mode.

## `StripeChannelOptions` [\#](https://flueframework.com/docs/api/stripe-channel/\#stripechanneloptions)

```
interface StripeSnapshotChannelOptions<E extends Env = Env> {
  client: Stripe;
  webhookSecret: string;
  bodyLimit?: number;
  signatureToleranceSeconds?: number;
  eventPayload?: 'snapshot';
  webhook(input: StripeSnapshotWebhookHandlerInput<E>): StripeHandlerResult;
}

interface StripeThinChannelOptions<E extends Env = Env> {
  client: Stripe;
  webhookSecret: string;
  bodyLimit?: number;
  signatureToleranceSeconds?: number;
  eventPayload: 'thin';
  webhook(input: StripeThinWebhookHandlerInput<E>): StripeHandlerResult;
}
```

Snapshot mode is the default. Set `eventPayload: 'thin'` only when the Stripe
event destination sends thin event notifications.

```
interface StripeSnapshotWebhookHandlerInput<E extends Env = Env> {
  c: Context<E>;
  event: Stripe.Event;
}

interface StripeThinWebhookHandlerInput<E extends Env = Env> {
  c: Context<E>;
  event: Stripe.V2.Core.EventNotification;
}
```

| Field | Description |
| --- | --- |
| `client` | Project-owned official Stripe SDK client. |
| `webhookSecret` | Signing secret for this Stripe event destination. |
| `signatureToleranceSeconds` | Allowed signature timestamp age. Defaults to 300 seconds. |
| `bodyLimit` | Maximum request-body size in bytes. Defaults to 1 MiB. |
| `eventPayload` | Signed payload mode. Defaults to `snapshot`. |
| `webhook` | Receives every event verified for the configured payload mode. |

The package calls `client.webhooks.constructEventAsync()` for snapshot events
and `client.parseEventNotificationAsync()` for thin notifications. The raw
request is not parsed or reserialized before verification.

## Handler result [\#](https://flueframework.com/docs/api/stripe-channel/\#handler-result)

```
type StripeHandlerResult = void | JsonValue | Response | Promise<void | JsonValue | Response>;
```

Returning nothing produces an empty `200`. A JSON-compatible value becomes a
JSON response. An ordinary Hono or Fetch `Response` passes through unchanged.
Thrown callbacks and unsupported return values produce a server error.

The package does not impose a general handler deadline because Stripe does not
publish one timeout for every event family. Applications should acknowledge
ordinary asynchronous events quickly. Specialized synchronous event workflows
may have stricter provider-specific response requirements.

## `StripeChannel` [\#](https://flueframework.com/docs/api/stripe-channel/\#stripechannel)

```
interface StripeChannel<E extends Env = Env> {
  readonly routes: readonly ChannelRoute<E>[];
}
```

`routes` contains one `POST /webhook` declaration. A file named
`channels/stripe.ts` is served at `/channels/stripe/webhook` relative to the
`flue()` mount.

Stripe does not supply one canonical conversation identity across its event
families, so this package does not expose conversation-key helpers.

## Snapshot events [\#](https://flueframework.com/docs/api/stripe-channel/\#snapshot-events)

The snapshot callback receives the provider-native `Stripe.Event`. The event’s
`type` discriminates its `data.object` for the API version represented by the
installed Stripe SDK.

Verified event types newer than the installed SDK are still forwarded at
runtime. Until Stripe’s declarations include one, inspect
`event.type as string` and validate its resource fields in application code.
The callback keeps Stripe’s closed native union so known cases retain their
provider-supplied payload narrowing.

Useful identity fields include:

- `event.id` for event-level idempotency;
- `event.account` for Connect deliveries;
- `event.context` for organization destinations;
- `event.request?.id` for an originating API request;
- resource ids within `event.data.object`.

The package does not deduplicate deliveries or guarantee ordering. Header and
payload metadata identify the delivery context but do not grant authorization
for outbound API calls.

## Thin event notifications [\#](https://flueframework.com/docs/api/stripe-channel/\#thin-event-notifications)

Thin mode receives the provider-native
`Stripe.V2.Core.EventNotification`. Notifications expose their own id, type,
context, and provider-supplied related-object metadata. Some event types have
no related object. Stripe’s SDK adds `fetchEvent()` and
`fetchRelatedObject()` methods that use the supplied project-owned client and
propagate the notification context; `fetchRelatedObject()` returns `null` when
no related object exists.

Snapshot events and thin notifications are separate modes. A snapshot payload
sent to a thin channel, or a thin notification sent to a snapshot channel, is
rejected before the application callback.

Thin notification types are also generated with the installed SDK. A verified
future type is forwarded at runtime and may be inspected through
`event.type as string` until the SDK is upgraded.

## Verification [\#](https://flueframework.com/docs/api/stripe-channel/\#verification)

The route requires `application/json` and `Stripe-Signature`. Stripe’s SDK
verifies HMAC-SHA256 over the exact request bytes and checks the signed
timestamp against `signatureToleranceSeconds`. Multiple `v1` signatures are
accepted according to the SDK’s signing-secret rotation behavior.

Invalid, missing, stale, malformed, oversized, or mode-mismatched requests fail
before `webhook` runs.

Invalid constructor options such as a missing client or signing secret,
unsupported payload mode, non-positive body limit, or non-positive signature
tolerance throw a `TypeError`.

See [Stripe setup](https://flueframework.com/docs/ecosystem/channels/stripe/) for event-destination setup,
the project-owned SDK client, and application-owned tools.

## Docs Navigation

Current page: [Stripe Channel API](https://flueframework.com/docs/api/stripe-channel/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
