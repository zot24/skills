> Source: https://flueframework.com/docs/ecosystem/channels/resend

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Resend


Last updated Jul 21, 2026<a href="/docs/ecosystem/channels/resend/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a><a href="https://www.npmjs.com/package/@flue/resend" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800" target="_blank" rel="noopener noreferrer">@flue/resend</a>


## Quickstart

Add verified webhook ingress and application-owned email behavior to an existing Flue project with the [Resend](https://resend.com) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add channel resend
```

## Overview

The Resend blueprint installs `@flue/resend` and the official `resend` SDK, adds the SDK’s declaration-only development dependencies, and creates `channels/resend.ts` in the source-root. It also updates the selected agent to bind a message-retrieval tool to the verified inbound email.

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { createResendChannel } from &#39;@flue/resend&#39;;
import { dispatch, useModel } from &#39;@flue/runtime&#39;;
import { Resend } from &#39;resend&#39;;
import { Assistant } from &#39;../agents/assistant.ts&#39;;

export const client = new Resend(process.env.RESEND_API_KEY!);

export const channel = createResendChannel({
  client,
  webhookSecret: process.env.RESEND_WEBHOOK_SECRET!,
  async webhook({ event, delivery }) {
    if (event.type !== &#39;email.received&#39;) return;
    await dispatch(Assistant, {
      id: emailInstanceId(event.data.email_id),
      message: {
        kind: &#39;signal&#39;,
        type: &#39;resend.email.received&#39;,
        // The webhook carries envelope data only; the agent retrieves the
        // full email text through the retrieve_resend_email tool.
        body: event.data.subject,
        attributes: {
          deliveryId: delivery.id,
          emailId: event.data.email_id,
          from: event.data.from,
          to: event.data.to.join(&#39;, &#39;),
        },
      },
    });
  },
});</code></pre>
<figcaption><span>src/channels/resend.ts (abridged)</span></figcaption>
</figure>

The abridged example omits the generated local email-id helpers and `retrieveReceivedEmail()` tool. The complete blueprint binds that tool in the agent module, so a verified `email.received` event starts a message-scoped agent instance that can retrieve the full email through the project-owned client. Receiving-domain setup, webhook registration, attachment retrieval, outbound mail, and reply policy remain application-owned.

## Mount the channel

A channel serves HTTP routes only where `app.ts` mounts it. Mount the module’s named `channel` export:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { channel as resend } from &#39;./channels/resend.ts&#39;;

app.route(&#39;/channels/resend&#39;, resend.route());</code></pre>
<figcaption><span>src/app.ts</span></figcaption>
</figure>

`channel.route()` is a pure router factory serving the channel’s declared routes relative to the mount path. The webhook paths in this guide assume the conventional `/channels/resend` mount; a different mount path shifts them accordingly. The dispatch-target agent module carries the `'use agent'` directive — the directive registers it, so a dispatch-only agent needs no HTTP mount of its own.

## Configure

| Variable                | Purpose                                          |
|-------------------------|--------------------------------------------------|
| `RESEND_WEBHOOK_SECRET` | **Required** — Verifies inbound deliveries.      |
| `RESEND_API_KEY`        | **Required** — Authenticates outbound SDK calls. |

It installs `@flue/resend` and the official `resend@6.12.4` SDK. The blueprint creates a channel module with named `channel` and project-owned `client` exports.

Configure the webhook URL as:

``` astro-code
https://example.com/channels/resend/webhook
```

The webhook secret and outbound API key are separate credentials.

The SDK’s public declarations reference `Buffer` and React email types. Add `@types/node` and `@types/react` as development dependencies. Both are declaration-only requirements and add no Node or React runtime code to a Worker bundle.

## Channel module

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { createResendChannel } from &#39;@flue/resend&#39;;
import { defineTool, dispatch, useModel } from &#39;@flue/runtime&#39;;
import { Resend } from &#39;resend&#39;;
import { Assistant } from &#39;../agents/assistant.ts&#39;;

const EMAIL_INSTANCE_PREFIX = &#39;resend-email:&#39;;

export const client = new Resend(process.env.RESEND_API_KEY!);

export const channel = createResendChannel({
  client,
  webhookSecret: process.env.RESEND_WEBHOOK_SECRET!,

  // Path: /channels/resend/webhook
  async webhook({ event, delivery }) {
    switch (event.type) {
      case &#39;email.received&#39;: {
        await dispatch(Assistant, {
          id: emailInstanceId(event.data.email_id),
          message: {
            kind: &#39;signal&#39;,
            type: &#39;resend.email.received&#39;,
            // The webhook carries envelope data only; the agent retrieves the
            // full email text through the retrieve_resend_email tool.
            body: event.data.subject,
            attributes: {
              deliveryId: delivery.id,
              emailId: event.data.email_id,
              messageId: event.data.message_id,
              from: event.data.from,
              to: event.data.to.join(&#39;, &#39;),
              ...(event.data.cc.length === 0 ? {} : { cc: event.data.cc.join(&#39;, &#39;) }),
              ...(event.data.attachments.length === 0
                ? {}
                : { attachmentCount: String(event.data.attachments.length) }),
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

export function retrieveReceivedEmail(emailId: string) {
  return defineTool({
    name: &#39;retrieve_resend_email&#39;,
    description: &#39;Retrieve the complete inbound email already bound to this agent.&#39;,
    async run() {
      const result = await client.emails.receiving.get(emailId);
      if (result.error) throw new Error(result.error.message);
      return { output: result.data };
    },
  });
}

export function emailInstanceId(emailId: string): string {
  if (!emailId) throw new TypeError(&#39;Resend email id must be non-empty.&#39;);
  return `${EMAIL_INSTANCE_PREFIX}${encodeURIComponent(emailId)}`;
}

export function emailIdFromInstanceId(id: string): string {
  if (!id.startsWith(EMAIL_INSTANCE_PREFIX)) {
    throw new TypeError(&#39;Expected a local Resend email instance id.&#39;);
  }
  const emailId = decodeURIComponent(id.slice(EMAIL_INSTANCE_PREFIX.length));
  if (!emailId) throw new TypeError(&#39;Expected a local Resend email instance id.&#39;);
  return emailId;
}</code></pre>
<figcaption><span>src/channels/resend.ts</span></figcaption>
</figure>

`@flue/resend` gives `client.webhooks.verify()` the exact request body and the signed `svix-id`, `svix-timestamp`, and `svix-signature` values before invoking `webhook`. Returning nothing produces an empty `200`. A JSON-compatible value becomes the response body, and a normal Hono or Fetch `Response` passes through unchanged. Resend retries every status other than `200`, so return a non-`200` response only when redelivery is intentional.

Every verified delivery is the official `WebhookEventPayload` union, forwarded verbatim. Each event keeps its provider-native `event.type`, `created_at`, and `data` fields, including event types newer than your installed `resend` version. The channel never wraps events in a `type: 'unknown'` envelope, so `switch (event.type)` narrows the modeled variants and a `default` branch handles anything your SDK predates.

## Retrieve message content

The `email.received` webhook includes routing metadata and attachment descriptors. Retrieve the full body, headers, and current attachment metadata later through the project-owned client:

``` astro-code
const email = await client.emails.receiving.get(emailId);
```

Use `client.emails.receiving.attachments` to obtain signed download URLs when attachment content is needed. Fetch only the content authorized for the current application action, and decide separately what may enter model context or durable storage.

## Bind the tool

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>&#39;use agent&#39;;
import { type AgentProps, useModel, useTool } from &#39;@flue/runtime&#39;;
import { emailIdFromInstanceId, retrieveReceivedEmail } from &#39;../channels/resend.ts&#39;;

export function Assistant({ id }: AgentProps) {
  useModel(&#39;anthropic/claude-haiku-4-5&#39;);
  const emailId = emailIdFromInstanceId(id);
  useTool(retrieveReceivedEmail(emailId));
  return &#39;Review the inbound support email. Retrieve the complete email when its body or headers are needed.&#39;;
}</code></pre>
<figcaption><span>src/agents/assistant.ts</span></figcaption>
</figure>

The model can retrieve only the email already bound by trusted application code. Outbound send, forward, or reply tools should likewise bind credentials, sender identity, recipients, and message policy outside model-selected arguments.

The `resend-email:` id is an application convention for one inbound message. The package does not expose a conversation helper because Resend’s `message_id` identifies one message rather than a stable thread root. Define and persist any reply-grouping policy in application code.

## Delivery behavior

Resend delivery is at least once and ordering is not guaranteed. `delivery.id` comes from the `svix-id` Resend documents for deduplication. Claim it in application-owned durable storage before dispatch when duplicate admission is unacceptable.

The channel is stateless. It does not register webhooks, manage receiving domains or MX records, store credentials, deduplicate deliveries, restore ordering, persist messages, retrieve bodies or attachments automatically, or send replies.

## Cloudflare Workers

The official `resend@6.12.4` client and webhook verifier execute in Node and workerd with Flue’s required `nodejs_compat` configuration. Cloudflare projects may initialize secrets through `process.env` or typed Worker bindings, then should verify their complete Worker build.

Test ingress with original synthetic bodies and locally generated Svix-format HMAC signatures over the exact bytes. Test the real client against a local fake `baseUrl` and a Fetch stub that rejects unexpected destinations. Exercise both paths in Node and workerd; tests should never contact Resend.

Receiving-domain configuration, webhook registration, API keys, signing-secret rotation, deduplication, persistence, outbound mail, and reply behavior remain application-owned.

See the [`@flue/resend` README](https://github.com/withastro/flue/tree/main/packages/resend#readme).


## Docs Navigation

Current page: [Resend](/docs/ecosystem/channels/resend/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


