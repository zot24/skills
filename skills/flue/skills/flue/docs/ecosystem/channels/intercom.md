> Source: https://flueframework.com/docs/ecosystem/channels/intercom

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Intercom


Last updated Jul 21, 2026<a href="/docs/ecosystem/channels/intercom/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a><a href="https://www.npmjs.com/package/@flue/intercom" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800" target="_blank" rel="noopener noreferrer">@flue/intercom</a>


## Quickstart

Add verified webhook ingress and application-owned API behavior to an existing Flue project with the [Intercom](https://developers.intercom.com) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add channel intercom
```

## Overview

The Intercom blueprint installs `@flue/intercom` and the official `intercom-client` SDK, creates a project-owned client factory at the source-root `intercom-client.ts`, and creates `channels/intercom.ts`. It also updates the selected agent to bind a conversation-retrieval tool to the verified workspace and conversation.

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { createIntercomChannel, type IntercomConversationRef } from &#39;@flue/intercom&#39;;
import { dispatch } from &#39;@flue/runtime&#39;;
import { Assistant } from &#39;../agents/assistant.ts&#39;;
import { createIntercomClient } from &#39;../intercom-client.ts&#39;;

export const client = createIntercomClient(process.env.INTERCOM_ACCESS_TOKEN!, { region: &#39;us&#39; });

export const channel = createIntercomChannel({
  clientSecret: process.env.INTERCOM_CLIENT_SECRET!,
  async webhook({ notification }) {
    if (notification.topic !== &#39;conversation.user.replied&#39;) return;
    const conversationId = conversationIdFromItem(notification.data.item);
    if (!conversationId) return;

    const conversation: IntercomConversationRef = {
      workspaceId: notification.app_id,
      conversationId,
    };
    await dispatch(Assistant, {
      id: channel.instanceId(conversation),
      // Recorded once when this event creates the instance; ignored after.
      initialData: {
        workspaceId: conversation.workspaceId,
        conversationId: conversation.conversationId,
      },
      message: {
        kind: &#39;signal&#39;,
        type: &#39;intercom.conversation.user.replied&#39;,
        // The conversation item is Intercom&#39;s own message payload; it has no
        // single flat text field, so it travels as the body verbatim.
        body: JSON.stringify(notification.data.item),
        attributes: {
          ...(notification.id === null ? {} : { notificationId: notification.id }),
          createdAt: String(notification.created_at),
          deliveryAttempts: String(notification.delivery_attempts),
        },
      },
    });
  },
});</code></pre>
<figcaption><span>src/channels/intercom.ts (abridged)</span></figcaption>
</figure>

The abridged example shows one dispatched topic and omits the generated environment, region, conversation-id, and retrieval-tool helpers. The complete generated module dispatches `conversation.user.created` and `conversation.user.replied`; other verified topics reach the callback and remain subject to application policy. It pins the SDK to its typed API version, selects the configured region, and binds the retrieval tool in the agent module, so dispatched notifications reach a workspace-scoped agent instance that can retrieve the current conversation without exposing workspace ids or credentials to the model.

## Mount the channel

A channel serves HTTP routes only where `app.ts` mounts it. Mount the module’s named `channel` export:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { channel as intercom } from &#39;./channels/intercom.ts&#39;;

app.route(&#39;/channels/intercom&#39;, intercom.route());</code></pre>
<figcaption><span>src/app.ts</span></figcaption>
</figure>

`channel.route()` is a pure router factory serving the channel’s declared routes relative to the mount path. The webhook paths in this guide assume the conventional `/channels/intercom` mount; a different mount path shifts them accordingly. The dispatch-target agent module carries the `'use agent'` directive — the directive registers it, so a dispatch-only agent needs no HTTP mount of its own.

## Configure

| Variable                 | Purpose                                                               |
|--------------------------|-----------------------------------------------------------------------|
| `INTERCOM_CLIENT_SECRET` | **Required** — Verifies inbound notifications.                        |
| `INTERCOM_ACCESS_TOKEN`  | **Required** — Authenticates outbound API calls.                      |
| `INTERCOM_WORKSPACE_ID`  | **Required** — Restricts resource identity to one Intercom workspace. |
| `INTERCOM_REGION`        | **Optional** — Selects `us`, `eu`, or `au`; defaults to `us`.         |

It installs `@flue/intercom` and the official `intercom-client@7.0.3`. The blueprint creates named `channel` and project-owned `client` exports.

Configure one URL in Intercom’s Developer Hub:

``` astro-code
https://example.com/channels/intercom/webhook
```

Intercom validates that URL with `HEAD` and sends notifications to it with `POST`. The client secret and outbound access token are separate credentials.

## Channel module

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import {
  createIntercomChannel,
  type IntercomConversationRef,
  type JsonValue,
} from &#39;@flue/intercom&#39;;
import { defineTool, dispatch } from &#39;@flue/runtime&#39;;
import { Assistant } from &#39;../agents/assistant.ts&#39;;
import { createIntercomClient, type IntercomRegion } from &#39;../intercom-client.ts&#39;;

const workspaceId = requiredEnv(&#39;INTERCOM_WORKSPACE_ID&#39;);

export const client = createIntercomClient(requiredEnv(&#39;INTERCOM_ACCESS_TOKEN&#39;), {
  region: intercomRegion(),
});

export const channel = createIntercomChannel({
  clientSecret: requiredEnv(&#39;INTERCOM_CLIENT_SECRET&#39;),

  // Path: /channels/intercom/webhook (HEAD, POST)
  async webhook({ notification }) {
    switch (notification.topic) {
      case &#39;conversation.user.created&#39;:
      case &#39;conversation.user.replied&#39;: {
        const conversationId = conversationIdFromItem(notification.data.item);
        if (!conversationId) return;

        const conversation: IntercomConversationRef = {
          workspaceId: notification.app_id,
          conversationId,
        };
        await dispatch(Assistant, {
          id: channel.instanceId(conversation),
          // Recorded once when this event creates the instance; ignored after.
          initialData: {
            workspaceId: conversation.workspaceId,
            conversationId: conversation.conversationId,
          },
          message: {
            kind: &#39;signal&#39;,
            type: `intercom.${notification.topic}`,
            // The conversation item is Intercom&#39;s own message payload; it has no
            // single flat text field, so it travels as the body verbatim.
            body: JSON.stringify(notification.data.item),
            attributes: {
              ...(notification.id === null ? {} : { notificationId: notification.id }),
              createdAt: String(notification.created_at),
              deliveryAttempts: String(notification.delivery_attempts),
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

export function retrieveConversation(ref: IntercomConversationRef) {
  if (ref.workspaceId !== workspaceId) {
    throw new TypeError(&#39;Expected the configured Intercom workspace.&#39;);
  }
  return defineTool({
    name: &#39;retrieve_intercom_conversation&#39;,
    description: &#39;Retrieve the current Intercom conversation bound to this agent.&#39;,
    async run() {
      const conversation = await client.conversations.find({
        conversation_id: ref.conversationId,
        display_as: &#39;plaintext&#39;,
      });
      return { output: conversation };
    },
  });
}

function conversationIdFromItem(item: JsonValue): string | undefined {
  if (!item || typeof item !== &#39;object&#39; || Array.isArray(item)) return undefined;
  return typeof item.id === &#39;string&#39; &amp;&amp; item.id.length &gt; 0 ? item.id : undefined;
}

function intercomRegion(): IntercomRegion {
  const value = process.env.INTERCOM_REGION || &#39;us&#39;;
  if (value === &#39;us&#39; || value === &#39;eu&#39; || value === &#39;au&#39;) return value;
  throw new Error(&#39;INTERCOM_REGION must be us, eu, or au.&#39;);
}

function requiredEnv(name: string): string {
  const value = process.env[name];
  if (!value) throw new Error(`${name} is required.`);
  return value;
}</code></pre>
<figcaption><span>src/channels/intercom.ts</span></figcaption>
</figure>

The example handles two conversation topics with one grouped switch branch. Intercom’s topic catalog is broad and API-versioned, so the channel keeps `notification.topic` open and represents `notification.data.item` as JSON. Validate the fields used by each selected topic. Verified `ping` and future topics reach the same callback.

The HMAC-verified body already carries `app_id`, so the channel does not re-check workspace identity. Resource ids are not globally unique across Intercom workspaces, so the example combines `notification.app_id` and the conversation id into an instance id. An app that serves multiple workspaces filters on `notification.app_id` itself, or uses application-owned installation state to select credentials.

`initialData` is the instance’s creation data: recorded once when the event creates the instance and ignored afterward, so the channel passes it on every dispatch. It carries the workspace and conversation identifiers the tool needs — the agent reads them with `useInitialData()` instead of parsing the instance id.

## Official client

Keep the REST client in project code:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { IntercomClient, IntercomEnvironment } from &#39;intercom-client&#39;;

export type IntercomRegion = &#39;us&#39; | &#39;eu&#39; | &#39;au&#39;;

export interface IntercomClientOptions {
  region?: IntercomRegion;
  fetch?: typeof globalThis.fetch;
  maxRetries?: number;
}

export function createIntercomClient(
  token: string,
  options: IntercomClientOptions = {},
): IntercomClient {
  if (!token) throw new TypeError(&#39;Intercom access token must be non-empty.&#39;);
  return new IntercomClient({
    token,
    version: &#39;2.14&#39;,
    environment: environmentForRegion(options.region ?? &#39;us&#39;),
    ...(options.fetch === undefined ? {} : { fetch: options.fetch }),
    ...(options.maxRetries === undefined ? {} : { maxRetries: options.maxRetries }),
  });
}

function environmentForRegion(
  region: IntercomRegion,
): (typeof IntercomEnvironment)[keyof typeof IntercomEnvironment] {
  switch (region) {
    case &#39;us&#39;:
      return IntercomEnvironment.UsProduction;
    case &#39;eu&#39;:
      return IntercomEnvironment.EuProduction;
    case &#39;au&#39;:
      return IntercomEnvironment.AuProduction;
  }
}</code></pre>
<figcaption><span>src/intercom-client.ts</span></figcaption>
</figure>

The SDK supports US, EU, and AU API environments. Select the region in trusted configuration instead of accepting an API host from a model or webhook field.

Pin `version: '2.14'`. `intercom-client@7.0.3` generates its REST request and response types for API version 2.14. Newer webhook topic documentation does not make those generated REST types compatible with a manually forced 2.15 header. Use a narrow Fetch client for a genuinely 2.15-only operation until the official SDK supports it.

## Bind the tool

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>&#39;use agent&#39;;
import { useInitialData, useModel, useTool } from &#39;@flue/runtime&#39;;
import * as v from &#39;valibot&#39;;
import { retrieveConversation } from &#39;../channels/intercom.ts&#39;;

const initialData = v.object({
  workspaceId: v.string(),
  conversationId: v.string(),
});

export function Assistant() {
  useModel(&#39;anthropic/claude-haiku-4-5&#39;);
  const data = useInitialData&lt;v.InferOutput&lt;typeof initialData&gt;&gt;();
  if (!data) throw new Error(&#39;This agent is created by the Intercom channel dispatch.&#39;);
  useTool(retrieveConversation(data));
  return &#39;Help with the inbound Intercom conversation. Retrieve the current conversation when more context is needed.&#39;;
}

Assistant.initialData = initialData;</code></pre>
<figcaption><span>src/agents/assistant.ts</span></figcaption>
</figure>

The tool retrieves only the conversation already selected from a verified notification. It accepts no workspace, conversation id, token, or API host from the model.

The instance id is an identifier, not an authorization capability. Apply the project’s normal access control to direct agent routes, and verify the workspace again before selecting an installation token.

## Endpoint validation and signatures

The discovered channel serves both:

``` astro-code
HEAD /channels/intercom/webhook
POST /channels/intercom/webhook
```

The unsigned `HEAD` route returns an empty `200` for Intercom’s endpoint validation and never invokes application code.

Notifications require:

``` astro-code
X-Hub-Signature: sha1=<40 hexadecimal characters>
```

Intercom computes HMAC-SHA1 over the exact request body using the developer app client secret. `@flue/intercom` retains and verifies those bytes before UTF-8 decoding or JSON parsing. A changed body, missing or malformed signature, or wrong secret is rejected before `webhook` runs.

The callback receives `{ c, notification }`. The notification is Intercom’s own object, with its native field names and nesting:

- `topic` and workspace-scoped `app_id`;
- nullable `id`;
- `created_at`, `delivery_attempts`, and `first_sent_at`;
- provider-native JSON under `data.item`;
- optional `self`;
- any unmodeled top-level fields, forwarded unchanged.

The envelope is structurally checked, but item fields remain provider-native. Deletion, ticket, conversation-part, and future topics may have different shapes. Do not assume every conversation-related topic has `data.item.id` without validating that topic’s documented payload.

Intercom supplies no signed timestamp or protocol replay window. Signature verification authenticates delivery bytes but does not provide deduplication or freshness.

## Responses and delivery

Returning nothing produces an empty `200`. A JSON-compatible value becomes a JSON response with status `200`. A normal Hono or Fetch `Response` passes through unchanged. A thrown callback surfaces to the framework error handler as `500`.

Intercom acknowledges on any `2xx`. Use `200` for ordinary acknowledgment. Return another status only when its provider behavior is intentional: `410` disables the subscription, while `429` throttles it. Ordinary failures are retried once after approximately one minute.

Intercom expects a `2xx` within about five seconds and otherwise retries the notification once after one minute. The channel does not enforce this with a timer, because a promise timeout cannot cancel arbitrary JavaScript work. Admit durable work quickly — dispatch and return — and defer long-running processing beyond the acknowledgment path.

Notifications can be duplicated and arrive out of order. Use a non-null `notification.id` in application-owned durable storage when duplicate admission is unacceptable, and consider `created_at` when ordering matters. Setup or periodic pings may have a null id.

The package does not install an app, perform OAuth, select permissions, create subscriptions, store tokens, deduplicate notifications, persist conversations, or define outbound inbox policy.

## Cloudflare Workers

The verifier uses Web Crypto. The official `intercom-client@7.0.3` uses Fetch, has no runtime dependencies, and executes in workerd with Flue’s required `nodejs_compat` configuration. The example’s workerd test performs a real `client.conversations.find()` request through injected fake Fetch and confirms the expected EU URL, bearer token, `Intercom-Version: 2.14`, and workerd runtime header.

That execution proves the client operation shown here, not every SDK method. Test each additional operation used by the application against its actual Worker target. Cloudflare projects may use typed bindings instead of `process.env`; `nodejs_compat` is already part of Flue’s Worker configuration.

Create original synthetic notification bodies and local HMAC-SHA1 signatures. Exercise valid and tampered exact bytes, `HEAD`, ping, future topics, malformed JSON, body limits, handler results, a thrown callback surfacing as `500`, and instance-id round trips in Node and workerd.

For outbound tests, inject fail-closed Fetch into the actual official client, disable retries, assert the exact host, path, method, authorization, version, and region, and reject every unexpected destination. Do not register a webhook, perform OAuth, obtain a real token, or contact Intercom.

See the [`@flue/intercom` README](https://github.com/withastro/flue/tree/main/packages/intercom#readme).


## Docs Navigation

Current page: [Intercom](/docs/ecosystem/channels/intercom/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


