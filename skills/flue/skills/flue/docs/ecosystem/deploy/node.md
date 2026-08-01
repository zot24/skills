> Source: https://flueframework.com/docs/ecosystem/deploy/node

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Deploy Agents on Node.js


Last updated Jul 21, 2026<a href="/docs/ecosystem/deploy/node/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


Build and deploy Flue agents as a Node.js server. This guide walks you through creating your first agent, running it locally, and deploying it anywhere you can run Node.js — a VPS, Docker, Railway, Fly.io, or any cloud platform.

By the end, you will have a Flue agent running as a Node.js server, and you will know how to add subagents, sandbox context, external CLIs, remote sandboxes, and durable session storage when your agent needs them.

Flue is a Vite plugin: `vite dev` serves the application locally and `vite build` produces the deployable server artifact. First review [Routing](/docs/guide/routing/) for how `app.ts` mounts agent routes and how server code can `dispatch(...)` into agents. To package the server as a container image, see [Deploy Agents with Docker](/docs/ecosystem/deploy/docker/).

## Hello World

The simplest agent — no container, no storage, just a prompt and a reply.

### 1. Set up your project

``` astro-code
mkdir my-flue-server && cd my-flue-server
npm init -y
npm install @flue/runtime hono valibot
npm install -D @flue/vite @flue/cli vite
```

Add the Vite plugin:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { flue } from &#39;@flue/vite&#39;;
import { defineConfig } from &#39;vite&#39;;

export default defineConfig({
  plugins: [flue()],
});</code></pre>
<figcaption><span>vite.config.ts</span></figcaption>
</figure>

And the scripts:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="jsonc"><code>{
  &quot;scripts&quot;: {
    &quot;dev&quot;: &quot;vite dev&quot;,
    &quot;build&quot;: &quot;vite build&quot;,
  },
}</code></pre>
<figcaption><span>package.json</span></figcaption>
</figure>

### 2. Create your first agent

An agent module is an ordinary TypeScript file plus one line: the `'use agent'` directive. The directive is how an agent joins the application — the build scans your source root for marked modules, every exported function with a capitalized name is an agent, and the function’s name becomes the agent’s durable identity (an optional `Translator.agentName = '...'` string-literal static overrides it).

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="typescript"><code>&#39;use agent&#39;;
import { useModel } from &#39;@flue/runtime&#39;;

export function Translator() {
  useModel(&#39;openai/gpt-5.5&#39;);
  return &#39;Translate the user message into the requested language. Reply with the translation only.&#39;;
}</code></pre>
<figcaption><span>src/agents/translator.ts</span></figcaption>
</figure>

Agents that need a filesystem can attach an in-memory [virtual sandbox](/docs/guide/sandboxes/#the-virtual-sandbox) powered by [just-bash](https://github.com/vercel-labs/just-bash) — no container needed.

### 3. Create app.ts — the route map

`app.ts` is the only required file. Its default export owns the request pipeline, and every route is mounted explicitly — `app.ts` IS the routing table:

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

`createAgentRouter(Translator)` is a pure router factory: the mount path is yours to choose, and per-agent middleware is plain Hono at the mount (`app.use('/agents/translator/*', <middleware>)` before the `app.route(...)` line) to authenticate requests before they reach the agent. See [Routing](/docs/guide/routing/).

### 4. Add your API key

Put provider API keys in a `.env` file at the project root:

``` astro-code
cat > .env <<'EOF'
OPENAI_API_KEY="your-api-key"
EOF

printf '\n.env\n' >> .gitignore
```

Use the env var name your provider expects — `OPENAI_API_KEY` for OpenAI, `ANTHROPIC_API_KEY` for Anthropic, and so on. Do not commit `.env`.

### 5. Run it

For local development, `vite dev` serves `app.ts` with hot reload, loading your `.env` automatically (shell-exported values win):

``` astro-code
npx vite dev
```

Talk to the agent over HTTP. A conversation lives at the mount path plus any id you choose; the `POST` returns `202` immediately and the reply lands in the conversation:

``` astro-code
curl -X POST 'http://localhost:5173/agents/translator/demo-1' \
  -H "Content-Type: application/json" \
  -d '{"kind": "user", "body": "Translate to French: Hello world"}'

# read the conversation (the reply appears once the agent settles)
curl 'http://localhost:5173/agents/translator/demo-1'
```

Application code should use the [Flue Agent SDK](/docs/sdk/overview/) instead of raw curl — `createFlueClient({ url }).send(...)` plus `wait()`/`observe()` handles admission and streaming for you.

For a one-shot local check without any server, `flue run` executes the agent module directly — transport-free, no port:

``` astro-code
npx flue run src/agents/translator.ts --message "Translate to French: Hello world"
```

### 6. Build for production

``` astro-code
npx vite build
set -a; source .env; set +a
node dist/server.mjs
```

`vite build` compiles your project into `./dist/server.mjs` without packaging `.env` credentials into the server; the built server reads only the environment supplied when you start it. It uses [Hono](https://hono.dev/) under the hood and listens on port 3000 by default (configurable via `PORT`). Your project’s `node_modules` are still needed at runtime — the build externalizes your dependencies rather than bundling them.

To verify the artifact before deploying, `vite preview` serves the built application (it imports `dist/app.mjs` directly, with production behavior), or run it for real with `node dist/server.mjs`.

## Deterministic tool calls

For structured, schema-validated work inside the conversation, give the agent a harness-connected tool with `useTool({ harness: true })`: `run` receives the agent’s runtime (sandbox and model access) and can call back into the model for sub-tasks.

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="typescript"><code>&#39;use agent&#39;;
import { useModel, useTool } from &#39;@flue/runtime&#39;;
import * as v from &#39;valibot&#39;;

export function Reporter() {
  useModel(&#39;openai/gpt-5.5&#39;);
  useTool({
    name: &#39;compile-report&#39;,
    description: &#39;Compile the weekly metrics report.&#39;,
    input: v.object({ period: v.string() }),
    harness: true,
    async run({ harness, data }) {
      const response = await harness.prompt(`Compile the metrics report for ${data.period}.`, {
        result: v.object({ summary: v.string() }),
      });
      return { output: response.data };
    },
  });
  return &#39;When asked for a report, call the `compile-report` tool.&#39;;
}</code></pre>
<figcaption><span>src/agents/reporter.ts</span></figcaption>
</figure>

Drive it with `flue run src/agents/reporter.ts --message "Compile the weekly report."`, a `dispatch()` from server code, or the SDK.

## Subagents

`useSubagent(...)` declares a named delegate the model can hand focused work to via a task:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="typescript"><code>&#39;use agent&#39;;
import { useModel, useSubagent } from &#39;@flue/runtime&#39;;

function Analyst() {
  return &#39;Focus on quantitative insights, trends, and actionable takeaways.&#39;;
}

export function Reporter() {
  useSubagent({
    name: &#39;analyst&#39;,
    description: &#39;Analyzes metrics for quantitative insights and actionable takeaways.&#39;,
    agent: Analyst,
  });
  return &#39;Delegate metric analysis to the `analyst` subagent via a task.&#39;;
}</code></pre>
<figcaption><span>src/agents/reporter.ts</span></figcaption>
</figure>

## Sandbox context

The agent reads `AGENTS.md` and skills from its sandbox at runtime. With `local()`, that’s your real project root, so any files there are visible. With the virtual sandbox the filesystem starts empty — you’d set up context via `harness.sandbox`. Agents without a sandbox skip workspace discovery entirely.

**Skills** are reusable agent tasks defined as markdown files in `.agents/skills/`. They give the agent a focused instruction set for a specific job:

`.agents/skills/summarize/SKILL.md`:

``` astro-code
---
name: summarize
description: Summarize a document or text input.
---

Given the text provided in the arguments, produce a concise summary.
Focus on the key points and keep it to 2-3 sentences.
```

**`AGENTS.md`** at the root of the sandbox is the agent’s system prompt — it provides global context about the project.

Direct a skill from an Action or tool body with `harness.prompt(...)` — it shares the agent’s own conversation context, so naming the skill is enough for the model to activate it:

``` astro-code
import * as v from 'valibot';

const { data } = await harness.prompt(`Apply the summarize skill to this text:\n\n${document}`, {
  result: v.object({ summary: v.string() }),
});
```

## Using the local sandbox

`local()` is where Node really shines compared to other targets. The agent runs directly against the host filesystem and shell — `cwd` is `process.cwd()`, shell commands go through `child_process`, and `AGENTS.md` and skills are discovered from the project root.

Run flue itself inside an isolation boundary you trust — a CI runner, a container, a sandbox VM. There is no second layer of isolation between the agent and the host.

Env exposure is opt-in. By default only shell essentials (`PATH`, `HOME`, locale, etc.) are inherited from `process.env`; anything else — API keys, tokens, deploy credentials — has to be passed explicitly via `local({ env: { ... } })`. That keeps the model’s `bash` tool from seeing host secrets by accident.

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="typescript"><code>&#39;use agent&#39;;
import { useModel, useSandbox } from &#39;@flue/runtime&#39;;
import { local } from &#39;@flue/runtime/node&#39;;

export function Reviewer() {
  useModel(&#39;anthropic/claude-sonnet-4-6&#39;);
  useSandbox(local());
  return &#39;Review the codebase and identify potential issues in the area the user names.&#39;;
}</code></pre>
<figcaption><span>src/agents/reviewer.ts</span></figcaption>
</figure>

The agent reads, searches, and modifies files via its built-in tools — read, write, edit, grep, glob, bash. Anything on `$PATH` (`git`, `npm`, `gh`, `docker`) is reachable from the bash tool. Env vars are opt-in via `local({ env: { ... } })` — pass `process.env.GH_TOKEN`, `process.env.NPM_TOKEN`, etc. into the sandbox for the binaries that need them.

### When to use it

- **Self-hosted coding agents** — review PRs, fix bugs, refactor against the actual repo.
- **File processing** — read documents, transform data, generate reports from local files.
- **Dev tooling** — analyze project structure, run linters, generate boilerplate.
- **CI** — issue triage, deploy checks, anything where the runner already provides isolation. `flue run` is a natural fit here: one agent, one message, no port.

No container startup, real project context, fast iteration. If you need a tighter boundary on a specific operation — agent can call it, never sees the underlying secret — wrap it as a custom tool via `useTool(...)` in the agent function. The tool reads `process.env`; the agent only sees the tool’s params and result.

## Connecting a remote sandbox

The examples above use either the virtual sandbox or the local sandbox. When you need full isolation per session — each user gets their own Linux environment with git, Node.js, Python, etc. — you want a remote sandbox.

Flue connects to remote sandboxes through project-owned sandbox adapters installed from `flue add` blueprints. Run `flue add` with no arguments to see what’s currently supported, or `flue add sandbox <url>` to have your coding agent build an adapter for an unsupported provider against the [Sandbox Adapter API](/docs/reference/sandbox-api/).

The Ecosystem catalog lists available provider integrations, including [Daytona](/docs/ecosystem/sandboxes/daytona/), [E2B](/docs/ecosystem/sandboxes/e2b/), [Modal](/docs/ecosystem/sandboxes/modal/), and [Vercel Sandbox](/docs/ecosystem/sandboxes/vercel/). Other adapters follow the same application-owned lifecycle shape.

### When to use a remote sandbox

The **local and virtual sandboxes** start in milliseconds; the local sandbox shares the host filesystem, and neither gives per-session isolation — a fit for single-tenant use and CI. A **remote sandbox** takes seconds to start (cached images are faster) and gives each session its own fully isolated environment, which multi-tenant and SaaS deployments need.

Start with the local or virtual sandbox. Move to a remote sandbox when you need per-session isolation.

## Conversation persistence

On Node.js, canonical agent conversations, attachments, and accepted submissions use in-memory SQLite by default in the built server, so they persist for the lifetime of one process but are lost on restart. (`vite dev` points the same default at a local disk file so history survives reloads within a dev session.) Add `db.ts` when that state must survive restart or support replacement recovery. A shared database does not remove the requirement for one live Node owner per agent instance.

See [Database](/docs/guide/database/) for `db.ts`, SQLite, Postgres, and custom adapter setup. See [Data Persistence API](/docs/reference/data-persistence-api/) for the adapter contract.

## Building and deploying

Flue compiles your project into a Node.js server:

``` astro-code
# Build
npx vite build

# Run locally
node dist/server.mjs

# Run on a custom port
PORT=8080 node dist/server.mjs
```

The built server never runs in local dev mode: developer-only error guidance and the dev SQLite file are wired only through `vite dev`, not through environment variables.

The deployed server exposes exactly the routes `app.ts` mounts. For each mounted agent, relative to its mount:

- `POST /:id` — deliver a message into a conversation (`202` admission);
- `GET /:id` — read the conversation (materialized history or live updates via the Durable Streams protocol);
- `POST /:id/abort` — abort in-flight and queued work.

Flue does not add a health endpoint or inspection routes by default. Define a host-required health route in `app.ts` and compose any operator endpoints behind your own authorization. See [Routing](/docs/guide/routing/).

### Choosing a sandbox strategy

Here’s the progression of sandbox types available on Node.js, from simplest to most powerful:

1.  **Empty virtual sandbox** — an agent function with just `useModel(...)`. Fast, cheap, stateless. Good for prompt-and-response agents.
2.  **Virtual sandbox with shell setup** — Use `harness.sandbox` to write files and configure the workspace. Still fast and cheap, good for agents that need small amounts of static context.
3.  **Local sandbox** — `useSandbox(local())` in the agent function. Direct host filesystem and shell access. Ideal for self-hosted agents, CI tasks, and dev tooling — anywhere the host environment already provides isolation. Import `local` from `@flue/runtime/node` and pass `env: { ... }` to expose specific host env vars to the agent’s shell.
4.  **Remote sandbox** — Full isolated Linux environment via a sandbox adapter. For multi-tenant agents, coding sandboxes, and anything that needs per-session isolation.

Start simple. Move up when you need to.


## Docs Navigation

Current page: [Deploy Agents on Node.js](/docs/ecosystem/deploy/node/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


