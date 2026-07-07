> Source: https://flueframework.com/docs/getting-started/quickstart



# Getting Started


Last updated May 29, 2026 <a href="/docs/getting-started/quickstart/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


**Flue** is a TypeScript framework for building AI agents. Define your agents using the exact same harness-driven architecture used by Claude Code and other coding agents to build truly autonomous software. Write your agents with Flue and then run them anywhere (local CI, Node.js server, Cloudflare, etc.).

## Prerequisites

- **Node.js** — `>=22.19.0` minimum required version.
- **LLM** — At least one model specifier to connect your agent to (for example, `anthropic/claude-sonnet-4-6` or `cloudflare/@cf/moonshotai/kimi-k2.6`)
- **LLM Provider** — API key(s) to connect to your favorite model provider. Cloudflare provides built-in `cloudflare/*` model access, no API keys required.
- **A coding agent (recommended)** — Several Flue features assume you have a coding agent available to run locally (Claude Code, Codex, etc.).
- **A container sandbox (optional)** — Flue includes a built-in virtual sandbox, suitable for many agentic workloads. If you need a real VM, consider a [container sandbox](/docs/ecosystem/#sandboxes).

## Automatic Installation


Copy this prompt and paste it into your coding agent. Your agent will guide you through setting up an agent in a new or existing project, and help answer any questions you might have along the way.

## Manual installation

**\*Note:** We recommend the AI-guided prompt above for most users. Follow the steps below if you prefer to set things up yourself.\*

### 1. Install Flue

In a new directory, install Flue and initialize your target. The `flue init` command creates `flue.config.ts`; you will add an agent module in the next step.

``` astro-code
npm install @flue/runtime
npm install --save-dev @flue/cli
echo 'ANTHROPIC_API_KEY="your-api-key"' > .env
npx flue init --target node # or: --target cloudflare
```

Add `.env` to `.gitignore` and do not commit provider credentials. We use Anthropic in this example, but you can use any LLM provider that Pi supports. Read Pi’s [“Providers” documentation](https://pi.dev/docs/latest/providers#api-keys) for the complete list of supported providers.

### 2. Create your first agent module

Create `agents/hello-world.ts`. This example uses Claude Sonnet, but you can choose any [supported model](https://pi.dev/models) and configure its provider credentials instead:

``` astro-code
import { defineAgent } from '@flue/runtime';

export default defineAgent(() => ({
 model: 'anthropic/claude-sonnet-4-6',
 instructions: 'Tell a funny "hello world" engineering joke.',
}));
```

The default export of `agents/hello-world.ts` is what registers the agent — the filename makes it available in Flue as `hello-world`.

### 3. Run your agent locally

Execute one prompt against the discovered agent:

``` astro-code
npx flue run hello-world --input '{"message":"Tell me a joke."}'
```

The command starts your configured Node.js or Cloudflare runtime, invokes the agent through the application, prints its response, and exits.

Congratulations! You have created and run your first Flue agent. From here, you can shape its behavior, add capabilities, or deploy it as part of an application.

## Next steps

- If you selected the Cloudflare target, continue with [Deploy on Cloudflare](/docs/ecosystem/deploy/cloudflare/) to configure and run your Worker.
- Learn how continuing interactions are modeled in [Agents](/docs/concepts/agents/).
- Create bounded operations around agents with [Workflows](/docs/guide/workflows/).
- Configure targets and local environment behavior in [Configuration](/docs/reference/configuration/).
- Choose execution capabilities in [Sandboxes](/docs/guide/sandboxes/).


## Docs Navigation

Current page: [Getting Started](/docs/getting-started/quickstart/)

### Sections

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


