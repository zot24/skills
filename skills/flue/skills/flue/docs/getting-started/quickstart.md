> Source: https://flueframework.com/docs/getting-started/quickstart

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Getting Started


Last updated Jul 21, 2026<a href="/docs/guide/getting-started/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


**Flue** is the open agent framework, from the creators of [Astro](https://astro.build/). Use a React-like hooks API to build agents in TypeScript using your favorite LLMs. Run them locally or deploy them anywhere: Node.js, Cloudflare, GitHub Actions, GitHub CI/CD, etc.

## Prerequisites

- **Node.js** — `>=22.19.0` minimum required version.
- **LLM** — API key(s) to connect to your favorite model provider. Flue is built on Pi, and supports [all Pi providers](https://pi.dev/docs/latest/providers) out of the box. Flue’s [Cloudflare runtime](docs/guide/targets/cloudflare/) provides a built-in `cloudflare/*` AI gateway, no API keys required.

## Automatic Installation


Copy this prompt and paste it into your coding agent. Your agent will guide you through setting up an agent in a new or existing project, and help answer any questions you might have along the way.

Your coding agent will run [`flue init`](/docs/cli/init/) to automatically initialize a new Flue project in the directory of your choice. You can run this command yourself as well, if you prefer.

## Manual Installation

> *The AI-guided prompt above is strongly recommended for most users. Follow the steps below if you prefer to set things up yourself.*

In a new directory, install the runtime and the CLI:

``` astro-code
npm install @flue/runtime @flue/cli
```

Then, create a basic `flue.config.ts` file:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e;overflow-x:auto" tabindex="0" data-language="ts"><code>import { defineConfig } from &#39;@flue/runtime/config&#39;;

export default defineConfig({
 target: &#39;node&#39;, // or &#39;cloudflare&#39;
});</code></pre>
<figcaption><span>flue.config.ts</span></figcaption>
</figure>

And finally, create your first `src/agents/assistant.ts`:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e;overflow-x:auto" tabindex="0" data-language="ts"><code>// The `&#39;use agent&#39;` directive marks the Assistant() function below as a Flue agent.
&#39;use agent&#39;;
import { useModel } from &#39;@flue/runtime&#39;;

// This is your first agent: `Assistant`.
// It&#39;s return value is your agent&#39;s instructions, which become the agent&#39;s &quot;system&quot; instructions.
// Flue Hooks like `useModel()` allow you to customize and modify your agent abilities.
export function Assistant() {
 useModel(&#39;anthropic/claude-haiku-4-5&#39;);
 return &#39;You are a helpful assistant. Keep replies short.&#39;;
}</code></pre>
<figcaption><span>src/agents/assistant.ts</span></figcaption>
</figure>

Congratulations, you just built your first agent! From here you can shape its behavior and add capabilities — or keep going and put it behind a real server.

You can use any [Model/Provider](/docs/guide/models/) that Pi supports. In the example above, we use Claude Haiku. Whichever you choose, just be sure to provide the required API keys to the agent runtime. Its recommended to use a `.env` file to manage your API keys:

``` astro-code
# .env
ANTHROPIC_API_KEY="your-api-key"
```

## Run your agent locally

You can now spin up new agents from your terminal, running on your local machine:

``` astro-code
npx flue run src/agents/assistant.ts --message "Say hello in five words or fewer."
```

Agents are addressable, so you can message with a specific agent by passing an agent ID (`--id`). Agent conversations are persistent — the second message remembers the first. See [`flue run`](/docs/cli/run/) for the full set of flags.

``` astro-code
npx flue run src/agents/assistant.ts --id hello-1 --message "What's a good name for a pet crab?"
npx flue run src/agents/assistant.ts --id hello-1 --message "Give me three more."
```

Congratulations! You just ran your first Flue agent. You can use `flue run` to run agents on your local machine, or in CI environments like [GitHub Actions](/docs/ecosystem/deploy/github-actions/) and [GitLab CI/CD](/docs/ecosystem/deploy/gitlab-ci/).

## Deploy your agent

To host your agent remotely, you’ll need to deploy it. Flue uses [Hono](http://hono.dev/) and [Vite](https://vite.dev/) to power its server framework and build pipeline, respectively. Follow the following steps to build your agent for deployment.

### 1. Install dependencies

``` astro-code
npm install @flue/vite hono vite
```

### 2. Configure the project

Create two small config files at the project root:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e;overflow-x:auto" tabindex="0" data-language="ts"><code>import { flue } from &#39;@flue/vite&#39;;
import { defineConfig } from &#39;vite&#39;;

export default defineConfig({
 plugins: [flue()],
});</code></pre>
<figcaption><span>vite.config.ts</span></figcaption>
</figure>

If you are deploying to Cloudflare, then you should also install `@cloudflare/vite-plugin` and add `cloudflare()` after `flue()` in the Vite plugins array. see the [Cloudflare runtime](/docs/guide/cloudflare-target/) guide for more.

### 3. Build your app router

`src/app.ts` is the special file where your Flue app router always lives. Create your [Hono](https://hono.dev/) application instance, mount your agent, and export it so that it gets picked up by your build.

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e;overflow-x:auto" tabindex="0" data-language="ts"><code>import { createAgentRouter } from &#39;@flue/runtime/routing&#39;;
import { Hono } from &#39;hono&#39;;
import { Assistant } from &#39;./agents/assistant.ts&#39;;

// 1. Create your Hono application instance.
const app = new Hono();
// 2. Define your agent routes.
app.route(&#39;/agents/assistant&#39;, createAgentRouter(Assistant));
// 3. Export your application.
export default app;</code></pre>
<figcaption><span>src/app.ts</span></figcaption>
</figure>

The `createAgentRouter()` helper will define and mount your agent routes: `POST /:id`, `GET /:id`, `POST /:id/abort`, etc. See [Routing](/docs/guide/routing/) for a full walkthrough of how routing works in Flue.

### 4. Start the dev server

As mentioned, Flue leverages Vite to power its dev and build pipeline. To spin up your dev server, run `vite dev`:

``` astro-code
npx vite dev
```

Vite spins up your `app.ts` (by default at `http://localhost:5173`) application and servers your agents at the routes that you defined. Test your setup by sending your agent a message — one `POST` per message, `202` on admission:

``` astro-code
curl -X POST http://localhost:5173/agents/assistant/hello-1 \
  -H 'content-type: application/json' \
  -d '{"kind":"user","body":"Tell me a joke."}'
```

The `hello-1` in the URL is the agent ID, the same `--id` you passed to `flue run` above. Read the conversation back with `curl "http://localhost:5173/agents/assistant/hello-1?view=history"`, or use the [Flue Agent SDK](/docs/sdk/overview/) and [React hooks](/docs/guide/react/) when you’re ready to build real product experiences.

`vite build` will produce a runnable `dist/server.mjs` build output for the `"node"` runtime target, or a deployable Cloudflare Worker when configured with the `"cloudflare"` runtime target.

Congratulations, you’ve completed our quickstart guide! You have created your first Flue agent, run it locally, and successfully built it for production.

## Next steps

- [Agents](/docs/guide/building-agents/) — configure the model, add capabilities, and understand how conversations persist over time.
- [Tools](/docs/guide/tools/), [Skills](/docs/guide/skills/), and [Sandboxes](/docs/guide/sandboxes/) — give your agent real capabilities and a workspace to work in.
- [Routing](/docs/guide/routing/) — mount additional agents and application routes in `app.ts`.
- [Deploy to Cloudflare](/docs/ecosystem/deploy/cloudflare/) or [Node.js](/docs/ecosystem/deploy/node/) — host your agent for real traffic.
- [Agent SDK](/docs/sdk/overview/) and [React](/docs/guide/react/) — build product experiences on top of a deployed agent.


## Docs Navigation

Current page: [Getting Started](/docs/guide/getting-started/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


