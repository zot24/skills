> Source: https://flueframework.com/docs/ecosystem/channels/notion

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Notion


Last updated Jul 21, 2026<a href="/docs/ecosystem/channels/notion/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a><a href="https://www.npmjs.com/package/@flue/notion" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800" target="_blank" rel="noopener noreferrer">@flue/notion</a>


## Quickstart

Add verified webhook ingress and application-owned API behavior to an existing Flue project with the [Notion](https://developers.notion.com) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add channel notion
```

## Overview

The blueprint installs `@flue/notion`, the official `@notionhq/client`, and its required TypeScript peer when needed. It creates `<source-root>/channels/notion.ts` with a named `channel`, project-owned `client`, local page identity helpers, and a page-bound retrieval tool, then wires that tool into an agent. It may also add `"node"` to a restrictive `compilerOptions.types` list.

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { Client } from &#39;@notionhq/client&#39;;
import { createNotionChannel } from &#39;@flue/notion&#39;;
import { dispatch, useModel } from &#39;@flue/runtime&#39;;
import { Assistant } from &#39;../agents/assistant.ts&#39;;

export const client = new Client({ auth: process.env.NOTION_TOKEN! });

export const channel = createNotionChannel({
  verificationToken: process.env.NOTION_WEBHOOK_VERIFICATION_TOKEN!,
  async webhook({ event }) {
    if (event.type !== &#39;page.content_updated&#39;) return;

    await dispatch(Assistant, {
      id: `notion-page:${encodeURIComponent(event.entity.id)}`,
      message: {
        kind: &#39;signal&#39;,
        type: `notion.${event.type}`,
        // `data` is Notion&#39;s event-specific detail object; page events
        // carry no natural message text.
        body: JSON.stringify(event.data ?? {}),
        attributes: {
          eventId: event.id,
          pageId: event.entity.id,
          attemptNumber: String(event.attempt_number),
          authorIds: event.authors.map((author) =&gt; author.id).join(&#39;,&#39;),
        },
      },
    });
  },
});</code></pre>
<figcaption><span>src/channels/notion.ts (abridged)</span></figcaption>
</figure>

A matching page update is admitted to the agent identified by that page, while other verified events receive an empty successful response. The full generated module handles additional page events, injects a Fetch implementation for Node and Cloudflare portability, and lets the bound agent retrieve current page state. Initial webhook verification uses a temporary setup callback, described below, before recurring signed delivery can begin.

## Mount the channel

A channel serves HTTP routes only where `app.ts` mounts it. Mount the module’s named `channel` export:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { channel as notion } from &#39;./channels/notion.ts&#39;;

app.route(&#39;/channels/notion&#39;, notion.route());</code></pre>
<figcaption><span>src/app.ts</span></figcaption>
</figure>

`channel.route()` is a pure router factory serving the channel’s declared routes relative to the mount path. The webhook paths in this guide assume the conventional `/channels/notion` mount; a different mount path shifts them accordingly. The dispatch-target agent module carries the `'use agent'` directive — the directive registers it, so a dispatch-only agent needs no HTTP mount of its own.

## Configure

| Variable                            | Purpose                                                                                  |
|-------------------------------------|------------------------------------------------------------------------------------------|
| `NOTION_WEBHOOK_VERIFICATION_TOKEN` | **Required after initial verification** — Verifies recurring webhook events after setup. |
| `NOTION_TOKEN`                      | **Required** — Authenticates outbound API calls.                                         |

It installs `@flue/notion` and the official `@notionhq/client@5.22.0`. The blueprint creates a channel module with named `channel` and `client` exports.

Configure the webhook URL as:

``` astro-code
https://example.com/channels/notion/webhook
```

The webhook verification token and outbound API token are separate credentials. During initial setup, use the `verification` callback described below to receive and securely persist the webhook verification token.

The package declares `@types/node` as a required peer because the official client’s declarations import `node:http`. Add it as a development dependency when the package manager does not install required peers automatically. This is a type dependency and does not add Node code to a Worker bundle. If `compilerOptions.types` is present, include `"node"` in that list.

## Channel module

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { Client } from &#39;@notionhq/client&#39;;
import { createNotionChannel } from &#39;@flue/notion&#39;;
import { defineTool, dispatch, useModel } from &#39;@flue/runtime&#39;;
import { Assistant } from &#39;../agents/assistant.ts&#39;;

const PAGE_INSTANCE_PREFIX = &#39;notion-page:&#39;;

const notionFetch: NonNullable&lt;NonNullable&lt;ConstructorParameters&lt;typeof Client&gt;[0]&gt;[&#39;fetch&#39;]&gt; = (
  url,
  init,
) =&gt;
  globalThis.fetch(url, {
    method: init?.method,
    headers: init?.headers,
    body: init?.body,
  });

const verificationToken = process.env.NOTION_WEBHOOK_VERIFICATION_TOKEN || undefined;

export const client = new Client({
  auth: process.env.NOTION_TOKEN!,
  fetch: notionFetch,
});

export const channel = createNotionChannel({
  ...(verificationToken ? { verificationToken } : {}),

  // Initial setup only: temporarily use this instead of verificationToken and
  // persist the received value through the project&#39;s secure secret workflow.
  // async verification({ verificationToken }) {
  //   await saveNotionWebhookVerificationToken(verificationToken);
  // },

  // Path: /channels/notion/webhook
  async webhook({ event }) {
    switch (event.type) {
      case &#39;page.created&#39;:
      case &#39;page.content_updated&#39;:
      case &#39;page.properties_updated&#39;:
      case &#39;page.moved&#39;:
      case &#39;page.undeleted&#39;:
      case &#39;page.locked&#39;:
      case &#39;page.unlocked&#39;: {
        await dispatch(Assistant, {
          id: pageInstanceId(event.entity.id),
          message: {
            kind: &#39;signal&#39;,
            type: `notion.${event.type}`,
            // `data` is Notion&#39;s event-specific detail object; page events
            // carry no natural message text.
            body: JSON.stringify(event.data ?? {}),
            attributes: {
              eventId: event.id,
              pageId: event.entity.id,
              attemptNumber: String(event.attempt_number),
              authorIds: event.authors.map((author) =&gt; author.id).join(&#39;,&#39;),
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

export function retrievePage(pageId: string) {
  return defineTool({
    name: &#39;retrieve_notion_page&#39;,
    description: &#39;Retrieve the Notion page bound to this agent.&#39;,
    async run() {
      const page = await client.pages.retrieve({ page_id: pageId });
      return {
        output: {
          id: page.id,
          object: page.object,
          archived: &#39;archived&#39; in page ? page.archived : null,
          inTrash: &#39;in_trash&#39; in page ? page.in_trash : null,
        },
      };
    },
  });
}

export function pageInstanceId(pageId: string): string {
  if (!pageId) throw new TypeError(&#39;Notion page id must be non-empty.&#39;);
  return `${PAGE_INSTANCE_PREFIX}${encodeURIComponent(pageId)}`;
}

export function pageIdFromInstanceId(id: string): string {
  if (!id.startsWith(PAGE_INSTANCE_PREFIX)) {
    throw new TypeError(&#39;Expected a local Notion page instance id.&#39;);
  }
  const pageId = decodeURIComponent(id.slice(PAGE_INSTANCE_PREFIX.length));
  if (!pageId) throw new TypeError(&#39;Expected a local Notion page instance id.&#39;);
  return pageId;
}</code></pre>
<figcaption><span>src/channels/notion.ts</span></figcaption>
</figure>

`event` is the official SDK’s provider-native webhook payload union, so `switch (event.type)` narrows each modeled variant to its snake-case payload shape. The channel widens only `authors`/`accessible_by` to include Notion’s documented `agent` author type, which the current SDK type omits. A verified event whose `type` is newer than the installed SDK is still forwarded — typed as the union, with its native fields intact — and handled from the `default` arm. There is no synthetic `type: 'unknown'` variant, `eventType`, or `raw` mirror.

The `notion-page:` id is a local application convention because `@flue/notion` does not invent one universal instance id for unrelated Notion resources. This example uses the page id because one project-owned client selects the installation. Include workspace or installation identity when one agent can cross credential domains.

## Bind the tool

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>&#39;use agent&#39;;
import { type AgentProps, useModel, useTool } from &#39;@flue/runtime&#39;;
import { pageIdFromInstanceId, retrievePage } from &#39;../channels/notion.ts&#39;;

export function Assistant({ id }: AgentProps) {
  useModel(&#39;anthropic/claude-haiku-4-5&#39;);
  const pageId = pageIdFromInstanceId(id);
  useTool(retrievePage(pageId));
  return &#39;Review the Notion page change. Retrieve the current page when its properties are needed.&#39;;
}</code></pre>
<figcaption><span>src/agents/assistant.ts</span></figcaption>
</figure>

The model can request the current page summary, but it cannot select another workspace, page, token, or API route. Trusted application code binds the page from the verified event.

Notion webhook payloads intentionally describe a change rather than returning all current resource state. Decide in application code whether an event should trigger a page, block, comment, database, data-source, view, or file fetch. Avoid retrieving every changed resource during ingress by default.

The example omits `page.deleted` because the bound retrieval tool may no longer be able to read that page. Route deletion events to application persistence when they matter. Comment events expose `event.data.page_id` and can use the same local page identity when that matches the application’s agent policy.

## Initial verification

Notion’s first request is different from recurring event delivery. It is an unsigned JSON object containing only `verification_token`, sent before a signing secret exists.

Temporarily replace `verificationToken` in the example with the commented `verification({ verificationToken })` callback. Persist the received token through the project’s secure secret workflow, then:

1.  Set `NOTION_WEBHOOK_VERIFICATION_TOKEN`.
2.  Redeploy with `verificationToken` enabled.
3.  Remove the temporary setup callback.

Do not log or dispatch the verification token. The callback is setup code, not authenticated application ingress. While no `verificationToken` is configured, signed recurring events receive `503` and the `webhook` callback is not run.

For recurring events, Notion sends `X-Notion-Signature: sha256=<hex-hmac>`. The package verifies HMAC-SHA256 over the exact request bytes before parsing. The per-subscription signing token already establishes the sending identity through signature verification, so the channel exposes no separate workspace, subscription, or integration constraint options.

## Delivery behavior

Notion can retry failed deliveries up to eight times with exponential backoff and does not guarantee event ordering. `event.id` is the delivery id and `event.attempt_number` identifies the retry attempt. Claim delivery ids in application-owned durable storage before dispatch when duplicate admission is unacceptable.

Returning nothing produces an empty `200`. A JSON-compatible value becomes the response body. A normal Hono or Fetch `Response` passes through unchanged. The package does not impose an invented handler deadline.

The application owns webhook subscription creation, event selection, OAuth, installation and token storage, deduplication, ordering recovery, resource fetching, and outbound tools.

## Cloudflare Workers

Ordinary API calls through `@notionhq/client@5.22.0` use the injected Fetch and execute in workerd with Flue’s required `nodejs_compat` configuration. Use `process.env` or typed Worker bindings according to the project’s credential convention, and verify the complete Worker build.

OAuth is outside this channel example. Validate any additional SDK operations the application chooses to ship.

Test with original synthetic verification and event bodies. Generate local HMAC signatures with Web Crypto, and exercise `Client.pages.retrieve()` through an injected fake Fetch in Node and workerd. The fake transport should reject unexpected URLs so tests cannot contact Notion.

See the [`@flue/notion` README](https://github.com/withastro/flue/tree/main/packages/notion#readme).


## Docs Navigation

Current page: [Notion](/docs/ecosystem/channels/notion/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


