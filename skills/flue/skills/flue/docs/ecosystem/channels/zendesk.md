> Source: https://flueframework.com/docs/ecosystem/channels/zendesk

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Zendesk


Last updated Jul 21, 2026<a href="/docs/ecosystem/channels/zendesk/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a><a href="https://www.npmjs.com/package/@flue/zendesk" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800" target="_blank" rel="noopener noreferrer">@flue/zendesk</a>


## Quickstart

Add verified event-subscription ingress and application-owned Ticketing API behavior to an existing Flue project with the [Zendesk](https://developer.zendesk.com) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add channel zendesk
```

## Overview

The blueprint installs `@flue/zendesk` and `lossless-json`. It creates a narrow Fetch client at `<source-root>/zendesk-client.ts` and `<source-root>/channels/zendesk.ts` with named `channel` and project-owned `client` exports, ticket identity handling, and a ticket-bound retrieval tool. It wires that tool into an agent and adds Node types only when the target needs them; no community Zendesk SDK is installed.

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { createZendeskChannel } from &#39;@flue/zendesk&#39;;
import { dispatch } from &#39;@flue/runtime&#39;;
import { Assistant } from &#39;../agents/assistant.ts&#39;;
import { createZendeskClient } from &#39;../zendesk-client.ts&#39;;

export const client = createZendeskClient({
  subdomain: process.env.ZENDESK_SUBDOMAIN!,
  email: process.env.ZENDESK_EMAIL!,
  apiToken: process.env.ZENDESK_API_TOKEN!,
});

export const channel = createZendeskChannel({
  signingSecret: process.env.ZENDESK_WEBHOOK_SIGNING_SECRET!,
  accountId: process.env.ZENDESK_ACCOUNT_ID!,
  async webhook({ payload, delivery }) {
    if (payload.type !== &#39;zen:event-type:ticket.created&#39;) return;
    const ticketId = ticketIdFromEvent(payload.subject, payload.detail);
    if (!ticketId) return;

    await dispatch(Assistant, {
      id: channel.instanceId({ accountId: payload.account_id, ticketId }),
      message: {
        kind: &#39;signal&#39;,
        type: `zendesk.${payload.type}`,
        // `event` is Zendesk&#39;s provider-native change object; its
        // properties vary by event type.
        body: JSON.stringify(payload.event),
        attributes: {
          eventId: payload.id,
          ticketId,
          occurredAt: payload.time,
          invocationId: delivery.invocationId,
        },
      },
    });
  },
});</code></pre>
<figcaption><span>src/channels/zendesk.ts (abridged)</span></figcaption>
</figure>

The abridged example omits the `ticketIdFromEvent()` helper; the complete helper appears in the channel module below.

A matching ticket event is admitted to the agent bound to that account and ticket, while other verified events receive an empty successful response. The full generated module validates matching ticket identity in `subject` and `detail.id`, handles comment events, and lets the bound agent retrieve the current ticket through the project-owned client. That client preserves large Zendesk identifiers and runs in Node or Cloudflare Workers.

## Mount the channel

A channel serves HTTP routes only where `app.ts` mounts it. Mount the module’s named `channel` export:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { channel as zendesk } from &#39;./channels/zendesk.ts&#39;;

app.route(&#39;/channels/zendesk&#39;, zendesk.route());</code></pre>
<figcaption><span>src/app.ts</span></figcaption>
</figure>

`channel.route()` is a pure router factory serving the channel’s declared routes relative to the mount path. The webhook paths in this guide assume the conventional `/channels/zendesk` mount; a different mount path shifts them accordingly. The dispatch-target agent module carries the `'use agent'` directive — the directive registers it, so a dispatch-only agent needs no HTTP mount of its own.

## Configure

| Variable                         | Purpose                                                                |
|----------------------------------|------------------------------------------------------------------------|
| `ZENDESK_WEBHOOK_SIGNING_SECRET` | **Required** — Verifies inbound event bodies.                          |
| `ZENDESK_ACCOUNT_ID`             | **Required** — Restricts events and resource identity to one account.  |
| `ZENDESK_WEBHOOK_ID`             | **Optional** — Restricts deliveries to one configured webhook.         |
| `ZENDESK_SUBDOMAIN`              | **Required** — Selects the account’s Ticketing API origin.             |
| `ZENDESK_EMAIL`                  | **Required** — Identifies the API-token user for Basic authentication. |
| `ZENDESK_API_TOKEN`              | **Required** — Authenticates outbound Ticketing API requests.          |

It installs `@flue/zendesk` and creates a channel module with named `channel` and project-owned `client` exports. Zendesk has no officially supported Node server SDK, so the blueprint uses a narrow native Fetch client instead of adding a community wrapper.

Create a JSON event-subscription webhook with:

``` astro-code
https://example.com/channels/zendesk/webhook
```

The webhook signing secret and outbound API token are separate credentials.

## Channel module

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { createZendeskChannel, type JsonValue, type ZendeskTicketRef } from &#39;@flue/zendesk&#39;;
import { defineTool, dispatch } from &#39;@flue/runtime&#39;;
import { Assistant } from &#39;../agents/assistant.ts&#39;;
import { createZendeskClient } from &#39;../zendesk-client.ts&#39;;

const accountId = requiredEnv(&#39;ZENDESK_ACCOUNT_ID&#39;);

export const client = createZendeskClient({
  subdomain: requiredEnv(&#39;ZENDESK_SUBDOMAIN&#39;),
  email: requiredEnv(&#39;ZENDESK_EMAIL&#39;),
  apiToken: requiredEnv(&#39;ZENDESK_API_TOKEN&#39;),
});

export const channel = createZendeskChannel({
  signingSecret: requiredEnv(&#39;ZENDESK_WEBHOOK_SIGNING_SECRET&#39;),
  accountId,
  webhookId: process.env.ZENDESK_WEBHOOK_ID || undefined,

  // Path: /channels/zendesk/webhook
  async webhook({ c, payload, delivery }) {
    switch (payload.type) {
      case &#39;zen:event-type:ticket.created&#39;:
      case &#39;zen:event-type:ticket.comment_added&#39;: {
        const ticketId = ticketIdFromEvent(payload.subject, payload.detail);
        if (!ticketId) {
          return c.json({ error: &#39;Expected a Zendesk ticket event.&#39; }, 400);
        }

        const ticket: ZendeskTicketRef = {
          accountId: payload.account_id,
          ticketId,
        };
        await dispatch(Assistant, {
          id: channel.instanceId(ticket),
          // Recorded once when this event creates the instance; ignored after.
          initialData: {
            accountId: ticket.accountId,
            ticketId: ticket.ticketId,
          },
          message: {
            kind: &#39;signal&#39;,
            type: `zendesk.${payload.type}`,
            // `event` is Zendesk&#39;s provider-native change object; its
            // properties vary by event type.
            body: JSON.stringify(payload.event),
            attributes: {
              eventId: payload.id,
              ticketId,
              occurredAt: payload.time,
              invocationId: delivery.invocationId,
            },
          },
        });
        return;
      }
      default:
        return;
    }
  },
});

export function retrieveTicket(ref: ZendeskTicketRef) {
  if (ref.accountId !== accountId) {
    throw new TypeError(&#39;Expected the configured Zendesk account.&#39;);
  }
  return defineTool({
    name: &#39;retrieve_zendesk_ticket&#39;,
    description: &#39;Retrieve the Zendesk ticket already bound to this agent.&#39;,
    async run() {
      return { output: await client.getTicket(ref.ticketId) };
    },
  });
}

function ticketIdFromEvent(subject: string, detail: Record&lt;string, JsonValue&gt;): string | undefined {
  const match = /^zen:ticket:([1-9]\d*)$/.exec(subject);
  if (!match?.[1]) return undefined;
  const id = detail.id;
  if (!(
    (typeof id === &#39;string&#39; &amp;&amp; /^[1-9]\d*$/.test(id)) ||
    (typeof id === &#39;number&#39; &amp;&amp; Number.isSafeInteger(id) &amp;&amp; id &gt; 0)
  )) {
    return undefined;
  }
  return String(id) === match[1] ? match[1] : undefined;
}

function requiredEnv(name: string): string {
  const value = process.env[name];
  if (!value) throw new Error(`${name} is required.`);
  return value;
}</code></pre>
<figcaption><span>src/channels/zendesk.ts</span></figcaption>
</figure>

The grouped branch handles selected ticket events while leaving the provider catalog open. Validate the fields consumed for every subscribed type. The example requires the ticket id in `subject` and `detail.id` to agree before using it as application identity.

## Project-owned client

Use the original account subdomain and bind credentials in trusted code:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { isLosslessNumber, isSafeNumber, parse } from &#39;lossless-json&#39;;

type JsonValue = null | boolean | number | string | JsonValue[] | { [key: string]: JsonValue };

export function createZendeskClient({
  subdomain,
  email,
  apiToken,
  fetcher = globalThis.fetch,
}: {
  subdomain: string;
  email: string;
  apiToken: string;
  fetcher?: typeof globalThis.fetch;
}) {
  if (!/^[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?$/i.test(subdomain)) {
    throw new TypeError(&#39;Zendesk subdomain must be a bare DNS label.&#39;);
  }
  const authorization = `Basic ${Buffer.from(`${email}/token:${apiToken}`).toString(&#39;base64&#39;)}`;

  return {
    async getTicket(ticketId: string) {
      if (!/^[1-9]\d*$/.test(ticketId)) {
        throw new TypeError(&#39;Zendesk ticket id must be a positive integer.&#39;);
      }
      const response = await fetcher(
        `https://${subdomain}.zendesk.com/api/v2/tickets/${ticketId}.json`,
        {
          headers: {
            accept: &#39;application/json&#39;,
            authorization,
          },
        },
      );
      if (!response.ok) {
        throw new Error(`Zendesk API request failed with ${response.status}.`);
      }
      const body = normalizeJsonValue(parse(await response.text()));
      if (!isRecord(body) || !isRecord(body.ticket) || !isZendeskId(body.ticket.id)) {
        throw new TypeError(&#39;Zendesk returned an invalid ticket response.&#39;);
      }
      return body.ticket;
    },
  };
}

function isZendeskId(value: unknown): value is string | number {
  if (typeof value === &#39;string&#39;) return /^[1-9]\d*$/.test(value);
  return typeof value === &#39;number&#39; &amp;&amp; Number.isSafeInteger(value) &amp;&amp; value &gt; 0;
}

function normalizeJsonValue(value: unknown): JsonValue | undefined {
  if (
    value === null ||
    typeof value === &#39;boolean&#39; ||
    typeof value === &#39;string&#39; ||
    (typeof value === &#39;number&#39; &amp;&amp; Number.isFinite(value))
  ) {
    return value;
  }
  if (isLosslessNumber(value)) {
    return isSafeNumber(value.value) ? Number(value.value) : value.value;
  }
  if (Array.isArray(value)) {
    const result: JsonValue[] = [];
    for (const item of value) {
      const normalized = normalizeJsonValue(item);
      if (normalized === undefined) return undefined;
      result.push(normalized);
    }
    return result;
  }
  if (!isRecord(value)) return undefined;
  const result: { [key: string]: JsonValue } = {};
  for (const [key, item] of Object.entries(value)) {
    const normalized = normalizeJsonValue(item);
    if (normalized === undefined) return undefined;
    result[key] = normalized;
  }
  return result;
}

function isRecord(value: unknown): value is Record&lt;string, unknown&gt; {
  return (
    typeof value === &#39;object&#39; &amp;&amp;
    value !== null &amp;&amp;
    !Array.isArray(value) &amp;&amp;
    !isLosslessNumber(value) &amp;&amp;
    Object.getPrototypeOf(value) === Object.prototype
  );
}</code></pre>
<figcaption><span>src/zendesk-client.ts</span></figcaption>
</figure>

Zendesk documents API-token Basic authentication as `{email}/token:{api_token}`. OAuth bearer tokens are also available, but authorization setup, token refresh, and installation storage remain application-owned.

Do not accept an arbitrary base URL from a model or webhook field. Host-mapped Help Center domains do not replace the account’s original `<subdomain>.zendesk.com` API origin.

Install `lossless-json@4.3.0` for this client. Zendesk identifiers can exceed JavaScript’s safe integer range, so unsafe numeric ids remain decimal strings instead of being rounded.

## Bind the tool

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>&#39;use agent&#39;;
import { useInitialData, useModel, useTool } from &#39;@flue/runtime&#39;;
import * as v from &#39;valibot&#39;;
import { retrieveTicket } from &#39;../channels/zendesk.ts&#39;;

const initialData = v.object({
  accountId: v.string(),
  ticketId: v.string(),
});

export function Assistant() {
  useModel(&#39;anthropic/claude-haiku-4-5&#39;);
  const data = useInitialData&lt;v.InferOutput&lt;typeof initialData&gt;&gt;();
  if (!data) throw new Error(&#39;This agent is created by the Zendesk channel dispatch.&#39;);
  useTool(retrieveTicket(data));
  return &#39;Review the inbound Zendesk ticket event. Retrieve the current ticket when more context is needed.&#39;;
}

Assistant.initialData = initialData;</code></pre>
<figcaption><span>src/agents/assistant.ts</span></figcaption>
</figure>

`initialData` is the instance’s creation data: recorded once when the event creates the instance and ignored afterward, so the channel passes it on every dispatch. The agent reads it with `useInitialData()`, validated against the agent’s `initialData` static, instead of parsing the instance id.

The tool accepts no account, ticket id, API host, or credential from the model. `instanceId()` includes account and ticket identity because Zendesk resource ids are account-scoped. The id remains an identifier, not an authorization capability. `parseInstanceId()` remains available as an escape hatch for recovering that identity from the id directly.

## Verification

Zendesk sends:

``` astro-code
X-Zendesk-Account-Id
X-Zendesk-Webhook-Id
X-Zendesk-Webhook-Invocation-Id
X-Zendesk-Webhook-Signature
X-Zendesk-Webhook-Signature-Timestamp
```

The signature is base64 HMAC-SHA256 over the signature timestamp concatenated directly with the exact request body. There is no delimiter. `@flue/zendesk` preserves and verifies those bytes before UTF-8 decoding or JSON parsing.

The HMAC covers the timestamp and body, not the account, webhook, or invocation headers. The package requires those headers, checks payload `account_id` against the account header, and can restrict configured account and webhook ids. Treat header metadata as provider routing context rather than independent authorization.

Zendesk does not document a timestamp acceptance window or clock-skew rule. The channel exposes `delivery.signatureTimestamp` but does not invent freshness semantics.

## Event shape

The callback receives `{ c, payload, delivery }`, keeping the Flue-verified provider-native payload separate from the unsigned header metadata.

`payload` is Zendesk’s own [common event envelope](https://developer.zendesk.com/api-reference/webhooks/event-types/webhook-event-types/), with the provider’s snake_case field names:

- `account_id`, normalized to a positive decimal string;
- `id`, the provider event id;
- `type` and `zendesk_event_version`, both open strings;
- `subject` such as `zen:ticket:<id>`, and `time`;
- provider-native `detail` and `event` JSON objects.

An index signature forwards any authenticated future or unmodeled fields, so verified future event families remain observable. JSON is parsed losslessly: unsafe integer literals retain their exact decimal spelling as strings, and the top-level integer `account_id` is normalized to a decimal string.

`delivery` is the unsigned routing metadata read from the request headers: `webhookId`, `invocationId`, and `signatureTimestamp`. Zendesk’s HMAC does not cover these headers, so treat them as provider routing context, not authorization.

Zendesk’s current documentation is inconsistent about ticket delivery setup: the event catalog and Support UI documentation list ticket subscriptions, while the developer webhook guide still recommends triggers or automations for ticket activity. Use the grouped ticket example only when the account exposes those event subscriptions. Custom trigger payloads are developer-authored and are not accepted as if they were the fixed common event envelope.

This initial channel targets provider-defined JSON event subscriptions. Custom trigger and automation webhooks can use developer-authored payloads, other media types, and other methods, so they are not silently treated as the same protocol. Sunshine Conversations and Zendesk AI Agent webhooks also have different or incomplete authentication and delivery contracts and remain separate research.

## Responses and delivery

Returning nothing produces an empty `200`. A JSON-compatible value becomes a JSON response. A normal Hono or Fetch `Response` passes through unchanged. A thrown callback or unsupported return value fails closed with retryable `409`.

Zendesk allows 12 seconds for the complete request. The channel does not enforce a deadline, because racing the callback against a timer cannot actually cancel JavaScript work that has already started — the timed-out work keeps running while a misleading failure is returned. Instead, admit durable work promptly (for example `dispatch(...)` then return) and rely on idempotency rather than blocking on slow operations before acknowledging.

Zendesk retries `409` up to three times, conditionally retries `429` and `503` with a short `Retry-After`, and retries timeouts up to five times. Delivery is best effort and may be duplicated or omitted. Persist the signed `payload.id` in application-owned storage when duplicate admission is unacceptable. The unsigned `delivery.invocationId` is useful for correlating provider attempts but is not a replay-resistant deduplication key. Use an exact `200` for ordinary acknowledgment.

## Cloudflare Workers

Ingress uses Web Crypto and standards-based Fetch APIs. The project-owned client uses native Fetch plus `Buffer` for documented Basic authentication. Both paths execute in workerd with Flue’s required `nodejs_compat` configuration.

Test the real exported client with injected fail-closed Fetch in Node and workerd. Assert the exact Zendesk host, ticket path, method, and authorization header, and reject every unexpected destination. Create original synthetic events and local HMACs for ingress tests. Do not create a webhook, subscribe to live events, obtain a real token, or contact Zendesk.

See the [`@flue/zendesk` README](https://github.com/withastro/flue/tree/main/packages/zendesk#readme).


## Docs Navigation

Current page: [Zendesk](/docs/ecosystem/channels/zendesk/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


