> Source: https://flueframework.com/docs/ecosystem/deploy/cloudflare

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Deploy to Cloudflare


Last updated Jul 21, 2026<a href="/docs/ecosystem/deploy/cloudflare/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


Build and deploy Flue agents on Cloudflare Workers. This guide walks you through the different kinds of agents you can build — from simple prompt-and-response endpoints to full coding agents backed by persistent storage and remote sandboxes.

By the end, you will have a Flue agent running on Cloudflare Workers, and you will know how to add subagents, R2-backed context, Cloudflare sandboxes, and Durable Object-backed sessions.

On Cloudflare, Flue is two Vite plugins side by side: `flue()` from `@flue/vite` plus the official `@cloudflare/vite-plugin`. `flue()` scans your `'use agent'` modules, generates the Worker entry (one Durable Object class per agent), and merges its contributions into your Wrangler config; the Cloudflare plugin owns workerd dev and the deployable Worker output.

## Hello World

The simplest agent — no container, no storage, just a prompt and a reply.

### 1. Set up your project

``` astro-code
mkdir my-flue-worker && cd my-flue-worker
npm init -y
npm install @flue/runtime hono
npm install -D @flue/vite @cloudflare/vite-plugin vite wrangler
```

Flue builds on `agents`, Cloudflare’s Agents SDK — it uses the SDK’s Durable Object base class and native lifecycle capabilities while retaining ownership of application routing. `@flue/vite` ships the SDK as its own dependency, so each Flue release runs against the SDK minor it was tested with and your project doesn’t declare it. To run a different SDK version, add your own `agents` dependency — a copy installed in your project always wins; the generated worker checks at runtime that the SDK provides the durability API Flue relies on (such as `runFiber`) and fails with an explicit error if it does not. If you also need a remote sandbox, additionally install `@cloudflare/sandbox` (see [Connecting a remote sandbox](#connecting-a-remote-sandbox) below).

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { cloudflare } from &#39;@cloudflare/vite-plugin&#39;;
import { flue } from &#39;@flue/vite&#39;;
import { defineConfig } from &#39;vite&#39;;

// flue() must come before cloudflare(): it prepares the generated Worker
// entry and the merged wrangler config that the Cloudflare plugin consumes.
// The cloudflare target is auto-detected from the presence of cloudflare()
// in the plugin array.
export default defineConfig({
  plugins: [flue(), cloudflare()],
});</code></pre>
<figcaption><span>vite.config.ts</span></figcaption>
</figure>

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="jsonc"><code>{
  &quot;scripts&quot;: {
    &quot;dev&quot;: &quot;vite dev&quot;,
    &quot;build&quot;: &quot;vite build&quot;,
    &quot;deploy&quot;: &quot;vite build &amp;&amp; wrangler deploy&quot;,
  },
}</code></pre>
<figcaption><span>package.json</span></figcaption>
</figure>

### 2. Create your first agent

An agent module is an ordinary TypeScript file plus one line: the `'use agent'` directive. The directive is how an agent joins the application — the build scans your source root for marked modules, every exported function with a capitalized name is an agent, and the build emits one Durable Object class per agent. The function’s name becomes the agent’s durable identity (an optional `Translator.agentName = '...'` string-literal static overrides it).

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="typescript"><code>&#39;use agent&#39;;
import { useModel } from &#39;@flue/runtime&#39;;

export function Translator() {
  useModel(&#39;anthropic/claude-sonnet-4-6&#39;);
  return &#39;Translate the user message into the requested language. Reply with the translation only.&#39;;
}</code></pre>
<figcaption><span>src/agents/translator.ts</span></figcaption>
</figure>

Agents that need a filesystem can attach an in-memory [virtual sandbox](/docs/guide/sandboxes/#the-virtual-sandbox) powered by [just-bash](https://github.com/vercel-labs/just-bash) — no container needed.

### 3. Create app.ts — the route map

`app.ts` is the only required file. Its default export owns the request pipeline; each mounted agent route resolves the generated binding and forwards to that agent’s Durable Object, and everything else is just a Hono app running in the Worker isolate:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="typescript"><code>import { createAgentRouter } from &#39;@flue/runtime/routing&#39;;
import { Hono } from &#39;hono&#39;;
import { Translator } from &#39;./agents/translator.ts&#39;;

const app = new Hono();

app.route(&#39;/agents/translator&#39;, createAgentRouter(Translator));
app.get(&#39;/api/ping&#39;, (c) =&gt; c.text(&#39;pong&#39;));

export default app;</code></pre>
<figcaption><span>src/app.ts</span></figcaption>
</figure>

The mount path is yours to choose; the exported function’s name (the agent’s durable identity) is what keys conversations and the Durable Object class. See [Routing](/docs/guide/routing/).

### 4. Configure Durable Object migrations

Cloudflare requires an explicit migration whenever a Worker adds a Durable Object class. Flue generates the classes and bindings for scanned agents, but your project owns the ordered migration history in `wrangler.jsonc`:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="jsonc"><code>{
  &quot;$schema&quot;: &quot;./node_modules/wrangler/config-schema.json&quot;,
  &quot;name&quot;: &quot;my-flue-worker&quot;,
  &quot;compatibility_date&quot;: &quot;2026-06-01&quot;,
  &quot;compatibility_flags&quot;: [&quot;nodejs_compat&quot;],
  &quot;migrations&quot;: [
    { &quot;tag&quot;: &quot;flue-class-FlueTranslatorAgent&quot;, &quot;new_sqlite_classes&quot;: [&quot;FlueTranslatorAgent&quot;] },
  ],
}</code></pre>
<figcaption><span>wrangler.jsonc</span></figcaption>
</figure>

Class names derive from agent identities (the exported function’s name, or its `agentName` static override), with camel boundaries split for the binding: the `Translator` agent produces the class `FlueTranslatorAgent` and the binding `FLUE_TRANSLATOR_AGENT`, and an `IssueTriage` agent would produce `FlueIssueTriageAgent` and `FLUE_ISSUE_TRIAGE_AGENT`. Flue requires `nodejs_compat` and a `compatibility_date` of `2026-04-01` or newer, and validates both at build time.

**Adding an agent is a triple**: the `'use agent'` file, the `app.route(...)` mount, and a uniquely tagged migration for its new class. Keep deployed migration entries in order and append, never rewrite. Generated Flue agent classes require Durable Object SQLite: introduce them through `new_sqlite_classes`, not legacy `new_classes`.

Renaming an agent **function** is a storage-identity change — the class name follows the identity, which follows the function name unless an `agentName` static pins it. Express an identity change with wrangler-native `renamed_classes` (`{ "from": "FlueOldNameAgent", "to": "FlueNewNameAgent" }`) to keep the deployed Durable Objects. Renaming the file alone changes nothing, and re-mounting an agent at a different URL is not an identity change — neither needs a migration.

### 5. Add your API key

For local Cloudflare development, put provider API keys in `.dev.vars` beside your Wrangler configuration:

``` astro-code
cat > .dev.vars <<'EOF'
ANTHROPIC_API_KEY="your-api-key"
EOF

printf '\n.dev.vars*\n.env*\n' >> .gitignore
```

Use the variable name your provider expects — `ANTHROPIC_API_KEY` for Anthropic, `OPENAI_API_KEY` for OpenAI, and so on. Do not commit local secret files. Cloudflare also supports `.env`-based local variables, but use either `.dev.vars` or `.env`, not both; when `.dev.vars` exists, `.env` values are not loaded into local Worker bindings. Worker runtime variables follow Cloudflare’s local-variable rules (`.dev.vars`, `.env`, `CLOUDFLARE_ENV`).

Alternatively, route model traffic through the [Workers AI binding](/docs/guide/models/) (`cloudflare/...` model specifiers) and skip API keys entirely.

For a deployed Worker, add secrets through Wrangler rather than treating a local-development file as production configuration:

``` astro-code
npx wrangler secret put ANTHROPIC_API_KEY
```

For CI or a managed deployment pipeline, `wrangler deploy --secrets-file <path>` is also available when your pipeline provides a protected secrets file.

### 6. Try it locally

`vite dev` runs the Worker in local workerd through the official Cloudflare Vite integration, with Flue’s generated entry and merged config:

``` astro-code
npx vite dev
```

Then talk to the agent — a conversation lives at the mount path plus any id you choose:

``` astro-code
curl -X POST 'http://localhost:5173/agents/translator/demo-1' \
  -H "Content-Type: application/json" \
  -d '{"kind": "user", "body": "Translate to French: Hello world"}'
# → 202 { "streamUrl": "...", "offset": "...", "submissionId": "..." }

curl 'http://localhost:5173/agents/translator/demo-1'   # read the conversation
```

Application code should use the [Flue Agent SDK](/docs/sdk/overview/) — `createFlueClient({ url }).send(...)` plus `wait()`/`observe()` handles admission and streaming.

Adding or removing an agent file regenerates the Worker entry and wrangler config automatically; body edits inside an agent are ordinary hot updates.

Route middleware (plain Hono middleware applied at the agent’s mount path in `app.ts`, before the `createAgentRouter(...)` mount) sees the original inbound HTTP request before Flue forwards accepted work into its Durable Object. Durable agent processing is a later boundary: after admission, Flue uses a deterministic internal request and does not persist or reconstruct the caller’s original headers, cookies, query parameters, URL, or body. Authenticate before admission and carry any non-secret correlation you need later in application-owned input or storage.

`flue run` does not emulate Cloudflare: it is Node-local, and agent modules that import `cloudflare:*` fail under it with a pointer at `vite dev`.

### 7. Build and deploy

``` astro-code
npx vite build
npx wrangler deploy
```

`vite build` writes the Workers-compatible artifact plus its finalized Wrangler config into `dist/`, and the Cloudflare Vite plugin records a deploy redirect so `wrangler deploy` (and `wrangler dev`) read that built output — deploy from the project root with no `--config` flag. Run `wrangler deploy --dry-run` first to validate.

Flue never rewrites your authored `wrangler.jsonc`. It reads it, layers its contributions (the generated `main`, one Durable Object binding per scanned agent) into a generated, gitignored Vite input config (`.flue-vite.wrangler.jsonc`), and hands that to the Cloudflare plugin. Migration history passes through from your file unchanged. Durable-object bindings whose names collide with Flue’s generated `FLUE_*_AGENT` names are a build error.

### Serving assets from the same Worker

Workers static assets are served before your Worker script unless `assets.run_worker_first` says otherwise. If a single Worker serves a front-end build and application routes that invoke Flue, include every application-owned API prefix — including every prefix where `app.ts` mounts agents or channels — in `run_worker_first` so those requests reach Hono instead of the asset handler or SPA fallback:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="jsonc"><code>{
  &quot;assets&quot;: {
    &quot;directory&quot;: &quot;./dist/client&quot;,
    &quot;binding&quot;: &quot;ASSETS&quot;,
    &quot;not_found_handling&quot;: &quot;single-page-application&quot;,
    &quot;run_worker_first&quot;: [&quot;/api/*&quot;, &quot;/agents/*&quot;, &quot;/channels/*&quot;],
  },
}</code></pre>
<figcaption><span>wrangler.jsonc</span></figcaption>
</figure>

Adjust the prefixes to match your `app.ts` route map.

### Extending generated Cloudflare Durable Objects

Flue normally owns each generated agent Durable Object class. When an agent needs native Cloudflare Agents SDK capabilities such as `onStart()`, `schedule()`, `scheduleEvery()`, or `queue()`, export a `cloudflare` extension descriptor from its module:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>&#39;use agent&#39;;
import { useModel } from &#39;@flue/runtime&#39;;
import { extend } from &#39;@flue/runtime/cloudflare&#39;;

export function Heartbeat() {
  useModel(&#39;anthropic/claude-sonnet-4-6&#39;);
}

export const cloudflare = extend({
  base: (Base) =&gt;
    class extends Base {
      async onStart() {
        await this.scheduleEvery(60, &#39;heartbeat&#39;);
      }

      async heartbeat() {
        this.setState({ ...this.state, lastHeartbeatAt: Date.now() });
      }
    },
});</code></pre>
<figcaption><span>src/agents/heartbeat.ts</span></figcaption>
</figure>

This is an advanced Cloudflare-only extension point. Flue applies `base` first, then defines its own Durable Object subclass with the generated binding and class identity. For the `Heartbeat` agent, authored Worker code can access the namespace as `env.FLUE_HEARTBEAT_AGENT`, and Wrangler binds that name to `FlueHeartbeatAgent`. Use `base` for native SDK lifecycle hooks and additional named methods. Do not override `fetch()`, `onRequest()`, `onFiberRecovered()`, or `alarm()`: Flue and the Agents SDK use those methods for routing, interruption recovery, and alarm multiplexing.

Use `wrap` when an integration needs to wrap the final Flue-generated Durable Object class:

``` astro-code
import * as Sentry from '@sentry/cloudflare';

export const cloudflare = extend({
  wrap: (Final) =>
    Sentry.instrumentDurableObjectWithSentry((env: Env) => ({ dsn: env.SENTRY_DSN }), Final),
});
```

Both `base` and `wrap` are optional. This module-local export is distinct from the optional source-root `cloudflare.ts` deployment module below. Native SDK callbacks run as Durable Object activity: they do not receive a Flue harness or session automatically.

### Extending the Worker

Add an optional `src/cloudflare.ts` module (path configurable via the `cloudflare` field in `flue.config.ts`) when your deployment needs native Cloudflare capabilities outside Flue’s generated classes. Named exports become top-level Worker exports, which lets the same Worker define application-owned Durable Objects:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { DurableObject } from &#39;cloudflare:workers&#39;;

export class SalesforceAuthCache extends DurableObject {
  async refreshIfNeeded() {
    return await this.ctx.storage.get(&#39;token&#39;);
  }
}</code></pre>
<figcaption><span>src/cloudflare.ts</span></figcaption>
</figure>

Declare the corresponding binding and migration in your project-root `wrangler.jsonc`:

``` astro-code
{
  "durable_objects": {
    "bindings": [{ "name": "SALESFORCE_AUTH_CACHE", "class_name": "SalesforceAuthCache" }],
  },
  "migrations": [{ "tag": "v2", "new_sqlite_classes": ["SalesforceAuthCache"] }],
}
```

Your agents receive the namespace through `env.SALESFORCE_AUTH_CACHE`. Keep bindings, containers, and ordered migration history in Wrangler configuration; `cloudflare.ts` provides the Worker code exports but does not infer deployment topology.

An optional default export adds non-HTTP Worker handlers:

``` astro-code
export default {
  async scheduled(_controller, env) {
    await env.SALESFORCE_AUTH_CACHE.getByName('default').refreshIfNeeded();
  },
};
```

Use `app.ts` for custom HTTP routes and middleware. `cloudflare.ts` must not export a default `fetch` handler because Flue keeps HTTP composition in `app.ts`.

## Subagents

`useSubagent(...)` declares a named delegate the model can hand focused work to via a task:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="typescript"><code>&#39;use agent&#39;;
import { useModel, useSubagent } from &#39;@flue/runtime&#39;;

function Triager() {
  return &#39;Search thoroughly, cite sources, and stay concise.&#39;;
}

export function Assistant() {
  useModel(&#39;anthropic/claude-sonnet-4-6&#39;);
  useSubagent({
    name: &#39;triager&#39;,
    description: &#39;Researches a topic thoroughly and reports back with cited sources.&#39;,
    agent: Triager,
  });
  return &#39;Delegate research to the `triager` subagent via a task.&#39;;
}</code></pre>
<figcaption><span>src/agents/assistant.ts</span></figcaption>
</figure>

## Using the sandbox

By default, the virtual sandbox starts empty — no files, no skills, no context. This is fine for stateless prompt-and-response agents like the translator above. But many agents need files to work with.

Because the agent has shell access, it can set up its own workspace on the fly, and a harness-connected tool (`useTool({ harness: true })`) can seed context before prompting:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="typescript"><code>&#39;use agent&#39;;
import { useModel, useTool } from &#39;@flue/runtime&#39;;
import * as v from &#39;valibot&#39;;

export function Support() {
  useModel(&#39;anthropic/claude-sonnet-4-6&#39;);
  useTool({
    name: &#39;answer&#39;,
    description: &#39;Answer one support request using the workspace articles.&#39;,
    input: v.object({ message: v.string() }),
    harness: true,
    async run({ harness, data }) {
      await harness.sandbox.writeFile(
        &#39;/workspace/articles/reset-password.md&#39;,
        &#39;# Reset your password\n\nUse the account settings page to request a password reset email.&#39;,
      );

      const { text } = await harness.prompt(
        `Search the workspace for articles relevant to this request, then write a helpful response.\n\nCustomer: ${data.message}`,
      );
      return text;
    },
  });
  return &#39;For each support request, call the `answer` tool with the customer message.&#39;;
}</code></pre>
<figcaption><span>src/agents/support.ts</span></figcaption>
</figure>

The agent can use its built-in tools — grep, glob, read — to search and read these files. This is still running on a virtual sandbox (no container), so it’s fast and cheap. If an application needs durable external storage or a full Linux environment, choose and own a sandbox adapter appropriate to that requirement.

## Connecting a remote sandbox

The examples above all run on virtual sandboxes — no container needed. But for agents that need a full Linux environment — git, Node.js, a browser, system packages — you want a remote sandbox.

Cloudflare has native container support via [`@cloudflare/sandbox`](https://developers.cloudflare.com/containers/). Each session gets its own isolated container with a persistent filesystem, shell, and full Linux userspace.

If you’d rather connect to an external provider — e.g. Daytona — instead of running the sandbox on Cloudflare, see [Connect a Daytona Sandbox](/docs/ecosystem/sandboxes/daytona/).

### Setup

You own the container config. That means four things:

1.  Install `@cloudflare/sandbox`: `npm install @cloudflare/sandbox`.
2.  Export the Sandbox class from `src/cloudflare.ts`.
3.  Declare the Durable Object binding, migration, and container image in your `wrangler.jsonc` at the project root.
4.  Commit a `Dockerfile` at the path your `containers[].image` points to.

Append the Sandbox migration to the same top-level history you use for generated Flue classes; do not replace migrations that have already been deployed.

### Example

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>export { Sandbox } from &#39;@cloudflare/sandbox&#39;;</code></pre>
<figcaption><span>src/cloudflare.ts</span></figcaption>
</figure>

`wrangler.jsonc` (at the project root, alongside `package.json`):

``` astro-code
{
  "$schema": "./node_modules/wrangler/config-schema.json",
  "name": "my-agent",
  "compatibility_date": "2026-06-01",
  "compatibility_flags": ["nodejs_compat"],
  "durable_objects": {
    "bindings": [{ "class_name": "Sandbox", "name": "Sandbox" }],
  },
  "migrations": [
    { "tag": "v1", "new_sqlite_classes": ["FlueAssistantAgent"] },
    { "tag": "v2", "new_sqlite_classes": ["Sandbox"] },
  ],
  "containers": [{ "class_name": "Sandbox", "image": "./Dockerfile" }],
}
```

`Dockerfile` (at the project root):

``` astro-code
FROM docker.io/cloudflare/sandbox:0.9.2
```

The base image is published by Cloudflare and bundles the control-plane HTTP server that `@cloudflare/sandbox` needs to communicate with the container, along with `node`, `git`, `curl`, and a working directory at `/workspace`. Pin the tag to match the `@cloudflare/sandbox` version in your `package.json` — they’re versioned together. Add your own `RUN` lines to install extra tools as needed.

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="typescript"><code>&#39;use agent&#39;;
import { env } from &#39;cloudflare:workers&#39;;
import { type AgentProps, useModel, useSandbox } from &#39;@flue/runtime&#39;;
import { cloudflareSandbox } from &#39;@flue/runtime/cloudflare&#39;;
import { getSandbox } from &#39;@cloudflare/sandbox&#39;;

interface Env {
  Sandbox: DurableObjectNamespace;
}

export function Assistant({ id }: AgentProps) {
  useModel(&#39;anthropic/claude-opus-4-7&#39;);
  const { Sandbox } = env as unknown as Env;
  useSandbox(cloudflareSandbox(getSandbox(Sandbox, id)));
  return &#39;You have a full Linux sandbox. Use it to complete whatever the user asks.&#39;;
}</code></pre>
<figcaption><span>src/agents/assistant.ts</span></figcaption>
</figure>

### Multiple sandboxes

Different agents can use different container images. Export a separate alias for each Sandbox class, then declare each binding and container entry:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>export { Sandbox as PyBoxSandbox } from &#39;@cloudflare/sandbox&#39;;
export { Sandbox as NodeSandbox } from &#39;@cloudflare/sandbox&#39;;</code></pre>
<figcaption><span>src/cloudflare.ts</span></figcaption>
</figure>

``` astro-code
{
  "durable_objects": {
    "bindings": [
      { "class_name": "PyBoxSandbox", "name": "PyBox" },
      { "class_name": "NodeSandbox", "name": "NodeBox" },
    ],
  },
  "migrations": [
    { "tag": "v1", "new_sqlite_classes": ["FlueAssistantAgent"] },
    { "tag": "v2", "new_sqlite_classes": ["PyBoxSandbox", "NodeSandbox"] },
  ],
  "containers": [
    { "class_name": "PyBoxSandbox", "image": "./docker/python.Dockerfile" },
    { "class_name": "NodeSandbox", "image": "./docker/node.Dockerfile" },
  ],
}
```

Each agent grabs the sandbox it needs: `cloudflareSandbox(getSandbox(env.PyBox, id))` or `cloudflareSandbox(getSandbox(env.NodeBox, id))`.

### Secure egress with outbound Workers

When your agent runs in a container, it may need to call external APIs — GitHub, npm registries, internal services. The traditional approach is to inject API tokens as environment variables, but that means the agent (and the LLM) has direct access to those secrets.

Cloudflare Sandboxes solve this with [outbound Workers](https://blog.cloudflare.com/sandbox-auth/) — a programmable egress proxy that intercepts outgoing HTTP/HTTPS requests from the container. Secrets are injected at the proxy layer, so the container never sees them. This is configured on the Cloudflare Sandbox class, outside of your Flue agent code:

``` astro-code
import { Sandbox } from '@cloudflare/sandbox';

export class MySandbox extends Sandbox {
  static outboundByHost = {
    'api.github.com': (request, env, ctx) => {
      const headers = new Headers(request.headers);
      headers.set('Authorization', `Bearer ${env.GITHUB_TOKEN}`);
      return fetch(request, { headers });
    },
  };
}
```

This is a zero-trust model — no token is ever granted to the untrusted sandbox. The proxy runs on the same machine as the container, so latency is minimal. You can also use outbound Workers to log requests, block specific domains, or enforce dynamic policies that change over the lifetime of a session.

For full details, see the [outbound Workers documentation](https://developers.cloudflare.com/containers/platform-details/outbound-traffic/).

### When to use a remote sandbox

A **virtual sandbox** starts in milliseconds, works from R2 or inline files, provides grep, glob, read, and a basic shell, and suits high-traffic, high-scale agents. A **remote sandbox** takes seconds to start (cached images are faster) in exchange for a full Linux environment — git, Node.js, Python, browsers — and a real persistent filesystem, which coding agents and complex dev environments need.

Most agents don’t need a remote sandbox. Start with a virtual sandbox and only move to a remote sandbox when you need the full environment.

## Conversation persistence

Generated Cloudflare applications store one append-only canonical conversation stream per agent instance in Durable Object SQLite, with attachment bytes in a separate immutable store. Sessions select conversations from that stream; there is no second session transcript or persisted conversation snapshot. `db.ts` is a Node-only convention — on Cloudflare, Durable Object SQLite is the persistence layer.

Filesystem durability remains a separate decision. The default lightweight sandbox uses an in-memory filesystem and must not be treated as durable merely because conversation state is stored in a Durable Object. Use a durable workspace or container-backed integration when files or installed artifacts must survive later activity.

Clients read materialized history or projected updates with a `GET` on the conversation URL; see the [Streaming Protocol](/docs/reference/streaming-protocol/).

## Interruption and recovery semantics

A deployment or code update can reset a Durable Object while an operation is running. Flue handles interrupted Cloudflare operations conservatively:

| Operation                   | After interruption                                                                                                                                                                                                                                                            |
|-----------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Direct attached HTTP prompt | The accepted prompt remains queued independently of its transport. Flue requeues only when canonical input is provably absent, recognizes provably completed canonical output, and otherwise records a visible terminal interruption without blindly replaying provider work. |
| Dispatched agent input      | Durable delivery and internal deduplication are keyed by `submissionId` and persisted submission state. Direct and dispatched inputs to one agent instance share one accepted order. Reconciliation uses the same conservative replay rules.                                  |

Cloudflare direct prompts and dispatched inputs enter one SQLite-backed submission queue owned by the target agent Durable Object. The attached transport observes accepted backend work but does not own it: losing an HTTP response does not cancel the accepted submission. Conversation records are durably stored and the conversation stream can be replayed from any offset via the Durable Streams protocol.

Before provider processing starts, Flue persists canonical submitted input and records an operational input-application boundary. After interruption, Flue retries only when it can prove provider work did not cross that boundary. If replay safety is uncertain, it appends a framework interruption advisory to canonical session history and terminalizes the operational submission instead of risking duplicate model work or external effects. Later prompts to the same agent instance can see that factual advisory.

External effects remain application-owned. An interruption can leave the outcome of already-started model or tool activity uncertain, and an explicit caller retry can repeat effects. For dispatched agent work, correlate effects with `submissionId` or an application-level idempotency key.

Submission payloads are durable application data while queued and running. Settled submission data is retained indefinitely. Dispatch receipt rows persist indefinitely as well, providing duplicate-delivery protection for repeated forwarding of one `submissionId`; there is no public submission lookup API. Treat persisted inputs as sensitive: do not submit secrets unless your application retention and access policy permits storing them.

Flue does not automatically propagate a trace carrier with dispatched input or preserve the original attached direct request after durable admission. For trace interpretation and application-owned HTTP extraction, see [OpenTelemetry](/docs/ecosystem/tooling/opentelemetry/#propagation-and-recovery).

For jobs that require durable step-level continuation, implement those steps with [Cloudflare Workflows](https://developers.cloudflare.com/workflows/).

### Persisted-format boundary

Flue stamps every Durable Object database with its persisted format version in a one-row `flue_meta` table the first time it opens it, and refuses to open a database stamped by an unknown or newer format version (for example, after rolling back a deploy). There is no in-place format migration: state stamped by a different format version must be cleared, or its class retired. KV-backed Durable Object classes remain outside this boundary because Cloudflare cannot convert them to SQLite in place — generated Flue agent classes must be introduced with `new_sqlite_classes`.

## Sandbox context

`AGENTS.md` and skills are optional workspace-context files that the agent reads from its sandbox at `init()` time. They live at conventional paths inside whatever sandbox the agent is using — Flue looks for `<cwd>/AGENTS.md` and `<cwd>/.agents/skills/<name>/SKILL.md`. Whatever’s there gets loaded; whatever isn’t, doesn’t. Most agents don’t need either to do useful work.

If you want to use them, put them in your sandbox. How you do that depends on which sandbox you’re using: write them in via `harness.sandbox` for the virtual sandbox, or `COPY` them in for a container.

**Skills** are reusable agent tasks defined as markdown files in `.agents/skills/`:

`.agents/skills/greet/SKILL.md`:

``` astro-code
---
name: greet
description: Generate a personalized greeting for a given name.
---

Given the name provided in the arguments, generate a warm, personalized
greeting. Keep it to one or two sentences.
```

**`AGENTS.md`** at the root of the sandbox is the agent’s system prompt — it provides global context about the project.

Direct a skill from an Action or tool body with `harness.prompt(...)` — it shares the agent’s own conversation context, so naming the skill is enough for the model to activate it:

``` astro-code
const { data } = await harness.prompt('Apply the greet skill for the name "World".', {
  result: v.object({ greeting: v.string() }),
});
```

## Building and deploying

``` astro-code
# Local development (reads local variables from .dev.vars or .env)
npx vite dev

# Build the deployable Worker output
npx vite build

# Configure a deployed secret interactively, then deploy the built output
npx wrangler secret put ANTHROPIC_API_KEY
npx wrangler deploy
```

Every mounted agent’s conversations are addressable at your chosen mount path:

``` astro-code
curl -X POST 'https://my-agent.<your-subdomain>.workers.dev/agents/translator/customer-123' \
  -H "Content-Type: application/json" \
  -d '{"kind": "user", "body": "Translate to French: Hello world"}'
```

Read the conversation with `GET .../agents/translator/customer-123` (history), or follow live updates with `?view=updates&offset=...&live=sse` (see the [Streaming Protocol](/docs/reference/streaming-protocol/)).

### Choosing a sandbox strategy

Here’s the progression of sandbox types available on Cloudflare, from simplest to most powerful:

1.  **Empty virtual sandbox** — an agent function with just `useModel(...)`. Fast, cheap, stateless. Good for prompt-and-response agents.
2.  **Virtual sandbox with shell setup** — Use `harness.sandbox` to write files and configure the workspace. Still fast and cheap, good for agents that need small amounts of static context.
3.  **Container sandbox** — Full Linux environment via `@cloudflare/sandbox`. For coding agents, complex dev environments, and anything that needs real system tools.

Start simple. Move up when you need to.

## Observability

Enable Cloudflare’s observability products for the deployed Worker in `wrangler.jsonc`:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="jsonc"><code>{
  &quot;observability&quot;: {
    &quot;enabled&quot;: true,
    &quot;traces&quot;: { &quot;enabled&quot;: true },
  },
}</code></pre>
<figcaption><span>wrangler.jsonc</span></figcaption>
</figure>

With logs enabled, tool and hook logs from agent work appear in the [Workers Observability](https://developers.cloudflare.com/workers/observability/) dashboard, attributed to the work that wrote them. With traces enabled (open beta), each agent response produces one trace — the Durable Object invocation that ran the response end to end, with Workers AI calls and other subrequests as spans inside it.

With traces enabled, each trace also carries agent-level spans — `invoke_agent`, `chat` per model turn, `execute_tool` per tool call — with conversation content included; [`createCloudflareTracing()`](/docs/guide/cloudflare-target/#createcloudflaretracing) covers customizing content capture, and [`tracing: false`](/docs/reference/configuration/#tracing) opts out. See Cloudflare’s [Workers Logs](https://developers.cloudflare.com/workers/observability/logs/workers-logs/) and [Traces](https://developers.cloudflare.com/workers/observability/traces/) documentation for sampling, retention, and pricing.

For the runtime-level view — token usage, tool payloads, settlements, and exporters like Sentry and OpenTelemetry — see [Observability](/docs/guide/observability/#cloudflare). For how agent execution maps onto platform invocations, see the [Cloudflare target guide](/docs/guide/cloudflare-target/#durable-agent-execution).


## Docs Navigation

Current page: [Deploy to Cloudflare](/docs/ecosystem/deploy/cloudflare/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


