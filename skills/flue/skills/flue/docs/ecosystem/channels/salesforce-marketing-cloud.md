> Source: https://flueframework.com/docs/ecosystem/channels/salesforce-marketing-cloud

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Salesforce Marketing Cloud


Last updated Jul 21, 2026<a href="/docs/ecosystem/channels/salesforce-marketing-cloud/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a><a href="https://www.npmjs.com/package/@flue/salesforce" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800" target="_blank" rel="noopener noreferrer">@flue/salesforce</a>


## Quickstart

Add verified Event Notification Service ingress and application-owned REST behavior to an existing Flue project with the [Salesforce Marketing Cloud Engagement](https://developer.salesforce.com/docs/marketing/marketing-cloud/guide/ens.html) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add channel salesforce-marketing-cloud
```

## Overview

The blueprint installs `@flue/salesforce`. It creates a narrow Fetch client at `<source-root>/salesforce-marketing-cloud-client.ts`, family identity helpers at `<source-root>/salesforce-marketing-cloud-email.ts`, and `<source-root>/channels/salesforce-marketing-cloud.ts` with named `channel` and project-owned `client` exports. It also creates or updates an agent to bind a callback lookup tool to validated email-event identity. This integration is for Marketing Cloud Engagement ENS, not generic Salesforce APIs.

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { createSalesforceMarketingCloudChannel } from &#39;@flue/salesforce&#39;;
import { dispatch, useModel } from &#39;@flue/runtime&#39;;
import { Assistant } from &#39;../agents/assistant.ts&#39;;
import { createSalesforceMarketingCloudClient } from &#39;../salesforce-marketing-cloud-client.ts&#39;;
import { emailEventInstanceId, emailRefFromEvent } from &#39;../salesforce-marketing-cloud-email.ts&#39;;

const callbackId = process.env.SALESFORCE_MARKETING_CLOUD_CALLBACK_ID!;
export const client = createSalesforceMarketingCloudClient({
  restBaseUrl: process.env.SALESFORCE_MARKETING_CLOUD_REST_BASE_URL!,
  accessToken: process.env.SALESFORCE_MARKETING_CLOUD_ACCESS_TOKEN!,
});

export const channel = createSalesforceMarketingCloudChannel({
  signatureKey: process.env.SALESFORCE_MARKETING_CLOUD_SIGNATURE_KEY!,
  callbackId,
  async events({ c, batch }) {
    const usefulEvents = [];
    for (const event of batch.events) {
      if (event.eventCategoryType !== &#39;EngagementEvents.EmailOpen&#39;) continue;
      const ref = emailRefFromEvent(callbackId, event);
      if (!ref) return c.json({ error: &#39;Expected a supported email event.&#39; }, 400);
      usefulEvents.push({ event, ref });
    }
    for (const { event, ref } of usefulEvents) {
      await dispatch(Assistant, {
        id: emailEventInstanceId(ref),
        message: {
          kind: &#39;signal&#39;,
          type: `salesforce-marketing-cloud.${event.eventCategoryType}`,
          // `info` carries the family-specific event fields; there is no
          // natural message text for an engagement event.
          body: JSON.stringify(event.info ?? {}),
          attributes: {
            ...(typeof event.timestampUTC === &#39;string&#39; ? { occurredAt: event.timestampUTC } : {}),
            callbackId: ref.callbackId,
            mid: ref.mid,
            eid: ref.eid,
            jobId: ref.jobId,
            batchId: ref.batchId,
            listId: ref.listId,
            subscriberId: ref.subscriberId,
          },
        },
      });
    }
    return c.body(null, 204);
  },
});</code></pre>
<figcaption><span>src/channels/salesforce-marketing-cloud.ts (abridged)</span></figcaption>
</figure>

Each valid selected email event in a signed batch is admitted to the agent bound to its callback and email tracking identity, then the batch receives `204`. The full generated module handles additional send and engagement families and lets the bound agent retrieve the configured callback. Callback registration, OAuth, token refresh, and the one-time `/ens-verify` call remain application-owned; Node and Cloudflare targets use the same Fetch and Web Crypto implementation.

## Mount the channel

A channel serves HTTP routes only where `app.ts` mounts it. Mount the module’s named `channel` export:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { channel as salesforceMarketingCloud } from &#39;./channels/salesforce-marketing-cloud.ts&#39;;

app.route(&#39;/channels/salesforce-marketing-cloud&#39;, salesforceMarketingCloud.route());</code></pre>
<figcaption><span>src/app.ts</span></figcaption>
</figure>

`channel.route()` is a pure router factory serving the channel’s declared routes relative to the mount path. The webhook paths in this guide assume the conventional `/channels/salesforce-marketing-cloud` mount; a different mount path shifts them accordingly. The dispatch-target agent module carries the `'use agent'` directive — the directive registers it, so a dispatch-only agent needs no HTTP mount of its own.

## Configure

| Variable                                   | Purpose                                                                 |
|--------------------------------------------|-------------------------------------------------------------------------|
| `SALESFORCE_MARKETING_CLOUD_SIGNATURE_KEY` | **Required** — Verifies inbound ENS batches.                            |
| `SALESFORCE_MARKETING_CLOUD_CALLBACK_ID`   | **Required** — Restricts and identifies the configured ENS callback.    |
| `SALESFORCE_MARKETING_CLOUD_REST_BASE_URL` | **Required** — Selects the tenant-specific Marketing Cloud REST origin. |
| `SALESFORCE_MARKETING_CLOUD_ACCESS_TOKEN`  | **Required** — Authenticates application-owned REST requests.           |

It installs `@flue/salesforce` and creates named `channel` and project-owned `client` exports. The integration targets Marketing Cloud Engagement Event Notification Service (ENS), not generic Salesforce APIs.

Register the complete callback URL:

``` astro-code
https://example.com/channels/salesforce-marketing-cloud/events
```

The signature key and outbound access token are separate credentials. Callback registration, OAuth, token refresh, and token storage remain application-owned.

## Channel module

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import {
  createSalesforceMarketingCloudChannel,
  type SalesforceMarketingCloudEvent,
} from &#39;@flue/salesforce&#39;;
import { defineTool, dispatch, useModel } from &#39;@flue/runtime&#39;;
import { Assistant } from &#39;../agents/assistant.ts&#39;;
import { createSalesforceMarketingCloudClient } from &#39;../salesforce-marketing-cloud-client.ts&#39;;
import {
  emailEventInstanceId,
  emailRefFromEvent,
  type SalesforceMarketingCloudEmailRef,
} from &#39;../salesforce-marketing-cloud-email.ts&#39;;

const callbackId = requiredEnv(&#39;SALESFORCE_MARKETING_CLOUD_CALLBACK_ID&#39;);

export const client = createSalesforceMarketingCloudClient({
  restBaseUrl: requiredEnv(&#39;SALESFORCE_MARKETING_CLOUD_REST_BASE_URL&#39;),
  accessToken: requiredEnv(&#39;SALESFORCE_MARKETING_CLOUD_ACCESS_TOKEN&#39;),
});

export const channel = createSalesforceMarketingCloudChannel({
  signatureKey: requiredEnv(&#39;SALESFORCE_MARKETING_CLOUD_SIGNATURE_KEY&#39;),
  callbackId,

  // Path: /channels/salesforce-marketing-cloud/events
  async events({ c, batch }) {
    const usefulEvents: Array&lt;{
      event: SalesforceMarketingCloudEvent;
      ref: SalesforceMarketingCloudEmailRef;
    }&gt; = [];

    for (const event of batch.events) {
      switch (event.eventCategoryType) {
        case &#39;TransactionalSendEvents.EmailSent&#39;:
        case &#39;TransactionalSendEvents.EmailNotSent&#39;:
        case &#39;TransactionalSendEvents.EmailBounced&#39;:
        case &#39;EngagementEvents.EmailOpen&#39;:
        case &#39;EngagementEvents.EmailClick&#39;:
        case &#39;EngagementEvents.EmailUnsubscribe&#39;: {
          const ref = emailRefFromEvent(callbackId, event);
          if (!ref) {
            return c.json({ error: &#39;Expected a supported Marketing Cloud email event.&#39; }, 400);
          }
          usefulEvents.push({ event, ref });
          break;
        }
        default:
          break;
      }
    }

    for (const { event, ref } of usefulEvents) {
      await dispatch(Assistant, {
        id: emailEventInstanceId(ref),
        message: {
          kind: &#39;signal&#39;,
          type: `salesforce-marketing-cloud.${event.eventCategoryType}`,
          // `info` carries the family-specific event fields; there is no
          // natural message text for an engagement event.
          body: JSON.stringify(event.info ?? {}),
          attributes: {
            ...(typeof event.timestampUTC === &#39;string&#39; ? { occurredAt: event.timestampUTC } : {}),
            callbackId: ref.callbackId,
            mid: ref.mid,
            eid: ref.eid,
            jobId: ref.jobId,
            batchId: ref.batchId,
            listId: ref.listId,
            subscriberId: ref.subscriberId,
          },
        },
      });
    }

    return c.body(null, 204);
  },
});

export function retrieveCallback(ref: SalesforceMarketingCloudEmailRef) {
  if (ref.callbackId !== callbackId) {
    throw new TypeError(&#39;Expected the configured Marketing Cloud callback.&#39;);
  }
  return defineTool({
    name: &#39;retrieve_salesforce_marketing_cloud_callback&#39;,
    description: &#39;Retrieve the Marketing Cloud ENS callback bound to this agent.&#39;,
    async run() {
      return { output: await client.getCallback(callbackId) };
    },
  });
}

function requiredEnv(name: string): string {
  const value = process.env[name];
  if (!value) throw new Error(`${name} is required.`);
  return value;
}</code></pre>
<figcaption><span>src/channels/salesforce-marketing-cloud.ts</span></figcaption>
</figure>

The route is fixed at `POST /events`. The example groups selected email event families while leaving the ENS taxonomy open. `emailRefFromEvent()` is application code that validates `mid`, `eid`, and the selected families’ tracking fields under `event.composite`. It normalizes those values with `callbackId` into a local agent id and rejects malformed events.

ENS supplies no universal delivery or conversation id. This email identity is valid only for the families the application validates. `compositeId` is optional and deprecated for transactional email, so do not use it as a universal key.

## Project-owned client

Use a narrow Fetch client and validate the tenant origin before attaching a Bearer token:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>export function createSalesforceMarketingCloudClient({
  restBaseUrl,
  accessToken,
  fetcher = globalThis.fetch,
}: {
  restBaseUrl: string;
  accessToken: string;
  fetcher?: typeof globalThis.fetch;
}) {
  const origin = salesforceMarketingCloudRestOrigin(restBaseUrl);
  if (!accessToken || accessToken.trim() !== accessToken) {
    throw new TypeError(&#39;Marketing Cloud access token must be non-empty and trimmed.&#39;);
  }

  return {
    async getCallback(callbackId: string) {
      if (!callbackId || callbackId.trim() !== callbackId) {
        throw new TypeError(&#39;Marketing Cloud callback id must be non-empty and trimmed.&#39;);
      }
      const response = await fetcher(
        `${origin}/platform/v1/ens-callbacks/${encodeURIComponent(callbackId)}`,
        {
          method: &#39;GET&#39;,
          headers: {
            accept: &#39;application/json&#39;,
            authorization: `Bearer ${accessToken}`,
          },
        },
      );
      if (!response.ok) {
        throw new Error(`Marketing Cloud API request failed with ${response.status}.`);
      }
      const value: unknown = await response.json();
      if (!value || typeof value !== &#39;object&#39; || Array.isArray(value)) {
        throw new TypeError(&#39;Marketing Cloud returned an invalid callback response.&#39;);
      }
      return value;
    },
  };
}

function salesforceMarketingCloudRestOrigin(value: string): string {
  const url = new URL(value);
  const suffix = &#39;.rest.marketingcloudapis.com&#39;;
  if (
    url.protocol !== &#39;https:&#39; ||
    url.username !== &#39;&#39; ||
    url.password !== &#39;&#39; ||
    url.port !== &#39;&#39; ||
    url.pathname !== &#39;/&#39; ||
    url.search !== &#39;&#39; ||
    url.hash !== &#39;&#39; ||
    !url.hostname.endsWith(suffix) ||
    url.hostname.length === suffix.length
  ) {
    throw new TypeError(&#39;Expected an HTTPS tenant origin ending in .rest.marketingcloudapis.com.&#39;);
  }
  return url.origin;
}</code></pre>
<figcaption><span>src/salesforce-marketing-cloud-client.ts</span></figcaption>
</figure>

Do not accept an arbitrary API origin, callback id, or token from a model or event. The tool shown above binds all three in trusted application code and performs only:

``` astro-code
GET /platform/v1/ens-callbacks/{callbackId}
Authorization: Bearer <access token>
```

No Salesforce SDK is required. Callback registration, OAuth, token refresh, subscription lifecycle, token storage, and broader outbound API behavior remain application-owned.

## Bind the agent

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>&#39;use agent&#39;;
import { type AgentProps, useModel, useTool } from &#39;@flue/runtime&#39;;
import { retrieveCallback } from &#39;../channels/salesforce-marketing-cloud.ts&#39;;
import { parseEmailEventInstanceId } from &#39;../salesforce-marketing-cloud-email.ts&#39;;

export function Assistant({ id }: AgentProps) {
  useModel(&#39;anthropic/claude-haiku-4-5&#39;);
  const email = parseEmailEventInstanceId(id);
  useTool(retrieveCallback(email));
  return &#39;Review the inbound Salesforce Marketing Cloud email lifecycle event. Retrieve the configured ENS callback when callback status or delivery configuration is relevant.&#39;;
}</code></pre>
<figcaption><span>src/agents/assistant.ts</span></figcaption>
</figure>

The tool accepts no tenant origin, callback id, access token, or resource id from the model. The parsed local id remains an identifier, not authorization; the tool checks its callback id again before selecting credentials.

## Callback verification

During callback setup, Marketing Cloud sends an unsigned JSON body containing exactly:

``` astro-code
{
  "callbackId": "provider-callback-id",
  "verificationKey": "one-time-verification-key"
}
```

Unsigned setup requests are accepted only when the channel has a `verification` handler. Restrict `callbackId`, call `POST /platform/v1/ens-verify` from application code, and disable the handler after setup. Without the handler, unsigned requests receive `401`.

Flue validates the shape and returns the required empty `200` after the handler completes. It does not register callbacks, obtain tokens, or call the verification API automatically. Keep this setup call separate from the GET-only client above unless the application explicitly needs it.

## Signatures and event batches

Signed notifications include:

``` astro-code
x-sfmc-ens-signature: <base64 HMAC-SHA256 digest>
```

Marketing Cloud signs the exact body bytes. `signatureKey` is required: it is the opaque string returned during callback creation and is imported directly as UTF-8 HMAC key material. Do not base64-decode it. Only the signature header is base64-decoded.

The signed payload is an ordered, nonempty array of at most 1000 events. Each event is passed through with Marketing Cloud’s own field names and nesting — there is no `raw` wrapper and no field projection. Ingress requires only a nonempty `eventCategoryType` on each event; that one field is what makes a batch forwardable. Everything else is delivered as ENS sent it:

- `timestampUTC`, the provider UTC epoch in milliseconds, forwarded unchanged and not validated (some families omit it or use a different representation);
- `composite` (`{ jobId, batchId, listId, … }`), `definitionKey`, and `definitionId` on the email send and engagement families that carry them;
- `info`, the family-specific details;
- `mid` and `eid`, which arrive as `number` on some families and `string` on others;
- `compositeId`, the flattened tracking id, deprecated for transactional email.

A top-level index signature forwards any authenticated field the modeled type does not name. The batch also exposes `rawBody`, the exact UTF-8 body after signature verification. The package does not close the event taxonomy or infer a universal resource, actor, delivery, or conversation identity. Narrow on `eventCategoryType` and validate every family-specific field you read.

## Responses and delivery

Returning nothing produces an empty `200`. A JSON-compatible value becomes a JSON `200`. A normal Hono or Fetch `Response` passes through unchanged.

ENS acknowledges only statuses `200` through `204`. Channel failures and unsupported (non-serializable) return values produce `500`. A custom `Response` outside the acknowledgment range is passed through and can cause redelivery.

Flue imposes no route timeout. The handler is awaited and its result serialized. The only ENS deadline is at setup: the unsigned verification POST must be answered `200` within 30 seconds, or callback creation fails. Steady-state deliveries have no per-request deadline, but ENS retries any batch it does not see acknowledged.

ENS delivery is at least once and retries may continue for up to seven days. Admit durable work quickly — dispatch, then return — instead of blocking the handler on slow operations, and rely on idempotency. The package does not deduplicate or persist events; use application-owned durable state and a family-appropriate key before non-idempotent work.

## Cloudflare Workers

Ingress and the project-owned client use standards-based Fetch, URL, and Web Crypto APIs. They execute in workerd under Flue’s canonical `nodejs_compat` configuration; package workerd tests exercise exact-body HMAC verification.

Use original synthetic event batches and local keys for tests. Test the real client with injected fail-closed Fetch in Node and workerd, asserting the exact tenant host, callback path, method, and Bearer header. Never register a live callback, perform OAuth, call `/ens-verify`, or contact Salesforce from tests.

See the [`@flue/salesforce` README](https://github.com/withastro/flue/tree/main/packages/salesforce-marketing-cloud#readme).


## Docs Navigation

Current page: [Salesforce Marketing Cloud](/docs/ecosystem/channels/salesforce-marketing-cloud/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


