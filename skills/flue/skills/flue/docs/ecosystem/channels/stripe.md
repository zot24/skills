> Source: https://flueframework.com/docs/ecosystem/channels/stripe

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Stripe


Last updated Jul 21, 2026<a href="/docs/ecosystem/channels/stripe/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a><a href="https://www.npmjs.com/package/@flue/stripe" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800" target="_blank" rel="noopener noreferrer">@flue/stripe</a>


## Quickstart

Add verified webhook ingress and application-owned API behavior to an existing Flue project with the [Stripe](https://stripe.com) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add channel stripe
```

## Overview

The blueprint installs `@flue/stripe`, Stripe’s official `stripe` SDK, and its required TypeScript peer when needed. It creates `<source-root>/channels/stripe.ts`, where the named `channel` export verifies snapshot webhook events by default and the project-owned `client` handles outbound API calls. Adapt the selected events, agent, and tool to the application.

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import Stripe from &#39;stripe&#39;;
import { createStripeChannel } from &#39;@flue/stripe&#39;;
import { dispatch, useModel } from &#39;@flue/runtime&#39;;
import { Billing } from &#39;../agents/billing.ts&#39;;

export const client = new Stripe(process.env.STRIPE_SECRET_KEY!, {
  httpClient: Stripe.createFetchHttpClient(),
});

export const channel = createStripeChannel({
  client,
  webhookSecret: process.env.STRIPE_WEBHOOK_SECRET!,
  async webhook({ event }) {
    if (event.type !== &#39;checkout.session.completed&#39;) return;
    const session = event.data.object;
    const customerId =
      typeof session.customer === &#39;string&#39; ? session.customer : session.customer?.id;
    if (!customerId) return;

    await dispatch(Billing, {
      id: customerId,
      message: {
        kind: &#39;signal&#39;,
        type: `stripe.${event.type}`,
        body: `Checkout session ${session.id} reported payment status ${session.payment_status}.`,
        attributes: {
          eventId: event.id,
          customerId,
          sessionId: session.id,
          paymentStatus: session.payment_status,
          ...(session.amount_total === null ? {} : { amountTotal: String(session.amount_total) }),
          ...(session.currency === null ? {} : { currency: session.currency }),
        },
      },
    });
  },
});</code></pre>
<figcaption><span>src/channels/stripe.ts (abridged)</span></figcaption>
</figure>

A matching event is admitted to the billing agent identified by its Stripe customer. Other events receive an empty successful response. The generated module also defines a customer-bound retrieval tool; the blueprint wires that tool into the billing agent. For Cloudflare targets, the same SDK uses its Fetch and Web Crypto implementation.

## Mount the channel

A channel serves HTTP routes only where `app.ts` mounts it. Mount the module’s named `channel` export:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { channel as stripe } from &#39;./channels/stripe.ts&#39;;

app.route(&#39;/channels/stripe&#39;, stripe.route());</code></pre>
<figcaption><span>src/app.ts</span></figcaption>
</figure>

`channel.route()` is a pure router factory serving the channel’s declared routes relative to the mount path. The webhook paths in this guide assume the conventional `/channels/stripe` mount; a different mount path shifts them accordingly. The dispatch-target agent module carries the `'use agent'` directive — the directive registers it, so a dispatch-only agent needs no HTTP mount of its own.

## Configure

| Variable                | Purpose                                          |
|-------------------------|--------------------------------------------------|
| `STRIPE_WEBHOOK_SECRET` | **Required** — Verifies inbound deliveries.      |
| `STRIPE_SECRET_KEY`     | **Required** — Authenticates outbound SDK calls. |

It installs `@flue/stripe` and Stripe’s official `stripe` SDK. The SDK verifies inbound payloads and remains the project-owned client for outbound API calls. The blueprint creates `src/channels/stripe.ts` with named `channel` and `client` exports.

Configure the Stripe event destination as:

``` astro-code
https://example.com/channels/stripe/webhook
```

If `flue()` is mounted beneath an outer prefix, include that prefix. Subscribe only to event types the application handles. Keep both credentials in the project’s existing secret system.

## Channel module

Snapshot events are the default:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import Stripe from &#39;stripe&#39;;
import { createStripeChannel } from &#39;@flue/stripe&#39;;
import { defineTool, dispatch, useModel } from &#39;@flue/runtime&#39;;
import { Billing } from &#39;../agents/billing.ts&#39;;

export const client = new Stripe(process.env.STRIPE_SECRET_KEY!, {
  httpClient: Stripe.createFetchHttpClient(),
});

export const channel = createStripeChannel({
  client,
  webhookSecret: process.env.STRIPE_WEBHOOK_SECRET!,

  // Path: /channels/stripe/webhook
  async webhook({ event }) {
    switch (event.type) {
      case &#39;checkout.session.completed&#39;:
      case &#39;checkout.session.async_payment_succeeded&#39;: {
        const session = event.data.object;
        const customerId =
          typeof session.customer === &#39;string&#39; ? session.customer : session.customer?.id;
        if (!customerId) return;

        await dispatch(Billing, {
          id: customerId,
          message: {
            kind: &#39;signal&#39;,
            type: `stripe.${event.type}`,
            body: `Checkout session ${session.id} reported payment status ${session.payment_status}.`,
            attributes: {
              eventId: event.id,
              customerId,
              sessionId: session.id,
              paymentStatus: session.payment_status,
              ...(session.amount_total === null
                ? {}
                : { amountTotal: String(session.amount_total) }),
              ...(session.currency === null ? {} : { currency: session.currency }),
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

export function retrieveCustomer(customerId: string) {
  return defineTool({
    name: &#39;retrieve_stripe_customer&#39;,
    description: &#39;Retrieve the Stripe customer bound to this billing agent.&#39;,
    async run() {
      const customer = await client.customers.retrieve(customerId);
      return {
        output: &#39;deleted&#39; in customer
          ? { id: customer.id, deleted: true }
          : { id: customer.id, name: customer.name, email: customer.email },
      };
    },
  });
}</code></pre>
<figcaption><span>src/channels/stripe.ts</span></figcaption>
</figure>

`@flue/stripe` gives Stripe’s SDK the exact request bytes and `Stripe-Signature` header before invoking `webhook`. Returning nothing produces an empty `200`. A JSON-compatible value becomes the response body, and a normal Hono or Fetch `Response` passes through unchanged.

The example uses a customer id as the agent instance id for one Stripe account. Stripe has no universal conversation identity. Choose the customer, subscription, account, Checkout Session, or other resource that represents the application’s unit of work. Connect and organization destinations should include the verified `event.account` or `event.context` when their resource namespaces require it.

## Bind the tool

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>&#39;use agent&#39;;
import { type AgentProps, useModel, useTool } from &#39;@flue/runtime&#39;;
import { retrieveCustomer } from &#39;../channels/stripe.ts&#39;;

export function Billing({ id: customerId }: AgentProps) {
  useModel(&#39;anthropic/claude-haiku-4-5&#39;);
  useTool(retrieveCustomer(customerId));
  return &#39;Review the completed Checkout event and summarize any billing follow-up that is needed.&#39;;
}</code></pre>
<figcaption><span>src/agents/billing.ts</span></figcaption>
</figure>

The model can invoke the lookup but cannot select another customer, account, or credential. Trusted application code binds those values. The channel-agent import cycle is supported because both imported bindings are read only inside deferred callbacks or the agent function body.

## Thin event notifications

Set `eventPayload: 'thin'` only for an event destination configured to send Stripe thin event notifications:

``` astro-code
export const channel = createStripeChannel({
  client,
  webhookSecret: process.env.STRIPE_WEBHOOK_SECRET!,
  eventPayload: 'thin',

  // Path: /channels/stripe/webhook
  async webhook({ event }) {
    const relatedObject = await event.fetchRelatedObject();
    await handleRelatedObject(event, relatedObject);
  },
});
```

The callback receives Stripe’s native `Stripe.V2.Core.EventNotification`. Its `fetchEvent()` and `fetchRelatedObject()` methods use the project-owned client and preserve Stripe context. Snapshot and thin destinations use different signed payload shapes; the package rejects a payload that does not match the configured mode.

## Delivery behavior

Stripe retries unsuccessful live-mode webhook deliveries for up to three days and sandbox deliveries three times over several hours. Ordering is not guaranteed and duplicate delivery is possible. Claim `event.id` in application-owned durable storage before dispatch when duplicate admission is unacceptable. Business operations should remain idempotent because separate Event objects can describe the same resource change.

Snapshot event objects are tied to the API version selected for the event destination. Keep that version aligned with the installed SDK types, or narrow and validate resource fields in application code.

Flue forwards a verified event type that is newer than the installed Stripe declarations. Until the project upgrades Stripe, use `switch (event.type as string)` to observe that future type and treat its resource fields as untrusted rather than weakening the native narrowing for every known event.

The official Stripe SDK selects its Fetch and Web Crypto implementation in Cloudflare Workers. The example executes that path in workerd with Flue’s required `nodejs_compat` configuration. Projects may initialize credentials through `process.env` or typed Worker bindings and should still verify their complete target build and workerd tests. Stripe’s declarations reference `@types/node`; that package is type-only and does not add Node code to the Worker bundle.

The channel does not register event destinations, rotate signing secrets, manage OAuth or API keys, deduplicate events, restore ordering, or define generic Stripe tools. It also does not claim support for specialized latency-sensitive workflows such as synchronous real-time Issuing authorization decisions.

See the [`@flue/stripe` README](https://github.com/withastro/flue/tree/main/packages/stripe#readme).


## Docs Navigation

Current page: [Stripe](/docs/ecosystem/channels/stripe/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


