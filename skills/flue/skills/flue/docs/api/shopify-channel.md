<!-- Source: https://flueframework.com/docs/api/shopify-channel -->

> NOTE: upstream page removed; content frozen as of last sync

Import from `@flue/shopify`.

## Exports [\#](https://flueframework.com/docs/api/shopify-channel/\#exports)

```
export {
  createShopifyChannel,
  type ChannelRoute,
  type JsonValue,
  type ShopifyChannel,
  type ShopifyChannelOptions,
  type ShopifyHandlerResult,
  type ShopifyWebhookHandlerInput,
};
```

## `createShopifyChannel()` [\#](https://flueframework.com/docs/api/shopify-channel/\#createshopifychannel)

```
function createShopifyChannel<E extends Env = Env>(
  options: ShopifyChannelOptions<E>,
): ShopifyChannel<E>;
```

Creates one stateless Shopify JSON webhook channel.

## `ShopifyChannelOptions` [\#](https://flueframework.com/docs/api/shopify-channel/\#shopifychanneloptions)

```
interface ShopifyChannelOptions<E extends Env = Env> {
  clientSecret: string;
  previousClientSecret?: string;
  bodyLimit?: number;
  webhook(input: ShopifyWebhookHandlerInput<E>): ShopifyHandlerResult;
}
```

| Field | Description |
| --- | --- |
| `clientSecret` | Current Shopify app client secret used for webhook HMACs. |
| `previousClientSecret` | Optional previous secret accepted during rotation overlap. |
| `bodyLimit` | Maximum request-body size in bytes. Defaults to 1 MiB. |
| `webhook` | Receives every verified, structurally valid JSON webhook delivery. |

Configured secrets must be non-empty. `bodyLimit` must be a positive integer.

## Handler input [\#](https://flueframework.com/docs/api/shopify-channel/\#handler-input)

```
interface ShopifyWebhookHandlerInput<E extends Env = Env> {
  c: Context<E>;
  payload: JsonValue;
  rawBody: string;
}
```

`c` is the authentic Hono context. `payload` is Shopify’s parsed JSON body with
its original field names and nesting. `rawBody` is the exact UTF-8 body the
signature was verified against. The callback runs only after exact-body HMAC
verification, UTF-8 decoding, and JSON parsing.

Delivery metadata is read from the provider’s native headers through `c`, for
example `c.req.header('x-shopify-topic')`, `c.req.header('x-shopify-shop-domain')`,
`c.req.header('x-shopify-api-version')`, and `c.req.header('x-shopify-webhook-id')`.
Optional `c.req.header('x-shopify-event-id')`, `c.req.header('x-shopify-triggered-at')`,
and `c.req.header('x-shopify-sub-topic')` may be absent. The channel does not
curate a typed header object, require any header’s presence, or read the
non-standard `X-Shopify-Name` header; the application reads and validates
whatever headers it consumes from `c`.

Topics remain open strings read from `c.req.header('x-shopify-topic')`. A
verified topic newer than the installed package still reaches `webhook`.

Payload fields depend on topic, API version, and subscription field selection.
The package parses JSON with `lossless-json`: safe numeric literals remain
JavaScript numbers, while numeric literals outside the safe integer range are
represented by their exact decimal strings. Applications must validate the
fields they consume and should accept `string | number` for Shopify identifiers
that can exceed `Number.MAX_SAFE_INTEGER`. Do not convert an unsafe identifier
string to `number`.

Shopify signs the request body, not these delivery headers. Header values are
provider-supplied routing metadata rather than independent cryptographic or
authorization claims. The package does not expose a conversation-key helper or
universal resource key.

## Handler result [\#](https://flueframework.com/docs/api/shopify-channel/\#handler-result)

```
type JsonValue = null | boolean | number | string | JsonValue[] | { [key: string]: JsonValue };

type ShopifyHandlerResult =
  | undefined
  | JsonValue
  | Response
  | Promise<undefined | JsonValue | Response>;
```

Returning nothing produces an empty `200`. A JSON-compatible value becomes a
JSON response. A normal Hono or Fetch `Response` passes through unchanged. A
thrown callback propagates to Hono’s error handler.

Non-2xx responses request Shopify redelivery. Shopify’s total response deadline
is five seconds. The channel does not enforce a deadline with a timer, because
racing a JavaScript callback against a timer does not cancel it: the timed-out
work keeps running and may complete after the failure response. Admit durable
work promptly — dispatch and return — and rely on application-owned idempotency
keyed on `x-shopify-webhook-id` rather than a timeout to keep retries safe.

## `ShopifyChannel` [\#](https://flueframework.com/docs/api/shopify-channel/\#shopifychannel)

```
interface ShopifyChannel<E extends Env = Env> {
  readonly routes: readonly ChannelRoute<E>[];
}

interface ChannelRoute<E extends Env = Env> {
  readonly method: string;
  readonly path: string;
  readonly handler: Handler<E>;
}
```

`routes` contains one `POST /webhook` declaration. A file named
`channels/shopify.ts` is served at `POST /channels/shopify/webhook` relative to
the `flue()` mount.

## Verification [\#](https://flueframework.com/docs/api/shopify-channel/\#verification)

The route accepts `application/json` and authenticates each delivery with the
`X-Shopify-Hmac-Sha256` header.

The channel retains the exact request bytes and verifies base64 HMAC-SHA256
with `clientSecret`. If that fails and `previousClientSecret` is configured,
it tries the previous secret. Verification runs before JSON parsing or
application code. The channel verifies the body signature only; it does not
require, curate, or validate the delivery metadata headers. A delivery missing
a metadata header still reaches `webhook`, where the application reads and
validates whatever headers it consumes from `c`.

Unsupported media types receive `415`; oversized bodies receive `413`; missing,
malformed, or incorrect authentication receives `401`; malformed JSON or invalid
UTF-8 receives `400`.

Shopify supplies no signed webhook timestamp or protocol replay window.
Applications own replay policy, delivery-id persistence, deduplication, and
ordering.

## Delivery and application boundary [\#](https://flueframework.com/docs/api/shopify-channel/\#delivery-and-application-boundary)

Shopify can duplicate or reorder deliveries and retries failures eight times
over four hours. Use `c.req.header('x-shopify-webhook-id')` for delivery
deduplication. Use `c.req.header('x-shopify-event-id')`, when present, only to
correlate deliveries caused by the same merchant action.

The channel supports JSON HTTPS webhooks, including mandatory
`customers/data_request`, `customers/redact`, and `shop/redact` topics. It does
not support XML delivery, EventBridge, Google Pub/Sub, or long-lived
transports.

App installation, OAuth, Admin API tokens, webhook registration, subscription
filters, secret-rotation orchestration, deduplication, persistence, compliance
business actions, outbound clients, and tools remain application concerns.

`@flue/shopify` uses Hono, standards-based Web Crypto, and `lossless-json`; it
does not depend on the Shopify SDK or `@flue/runtime`. See
[Shopify setup](https://flueframework.com/docs/ecosystem/channels/shopify/) for the project-owned Admin
GraphQL client and Node/workerd testing guidance.

## Docs Navigation

Current page: [Shopify Channel API](https://flueframework.com/docs/api/shopify-channel/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
