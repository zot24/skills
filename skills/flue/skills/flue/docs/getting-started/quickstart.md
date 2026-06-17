<!-- Source: https://flueframework.com/docs/getting-started/quickstart -->

**Flue** is a TypeScript framework for building AI agents. Define your agents using the exact same harness-driven architecture used by Claude Code and other coding agents to build truly autonomous software. Write your agents with Flue and then run them anywhere (local CI, Node.js server, Cloudflare, etc.).

## Prerequisites [\#](https://flueframework.com/docs/getting-started/quickstart/\#prerequisites)

- **Node.js** — `>=22.19.0` minimum required version.
- **LLM** — At least one model specifier to connect your agent to (for example, `anthropic/claude-sonnet-4-6` or `cloudflare/@cf/moonshotai/kimi-k2.6`)
- **LLM Provider** — API key(s) to connect to your favorite model provider. Cloudflare provides built-in `cloudflare/*` model access, no API keys required.
- **A coding agent (recommended)** — Several Flue features assume you have a coding agent available to run locally (Claude Code, Codex, etc.).
- **A container sandbox (optional)** — Flue includes a built-in virtual sandbox, suitable for many agentic workloads. If you need a real VM, consider a [container sandbox](https://flueframework.com/docs/ecosystem/#sandboxes).

## Automatic Installation [\#](https://flueframework.com/docs/getting-started/quickstart/\#automatic-installation)

Copy Prompt

“Read https://flueframework.com/start.md then help create my first agent...”

Copy this prompt and paste it into your coding agent. Your agent will guide you through setting up an agent in a new or existing project, and help answer any questions you might have along the way.

## Manual installation [\#](https://flueframework.com/docs/getting-started/quickstart/\#manual-installation)

**\*Note:** We recommend the AI-guided prompt above for most users. Follow the steps below if you prefer to set things up yourself.\*

### 1\. Install Flue [\#](https://flueframework.com/docs/getting-started/quickstart/\#1-install-flue)

In a new directory, install Flue and initialize your target. The `flue init` command creates `flue.config.ts`; you will add an agent module in the next step.

```
npm install @flue/runtime
npm install --save-dev @flue/cli
echo 'ANTHROPIC_API_KEY="your-api-key"' > .env
npx flue init --target node # or: --target cloudflare
```

Add `.env` to `.gitignore` and do not commit provider credentials. We use Anthropic in this example, but you can use any LLM provider that Pi supports. Read Pi’s [“Providers” documentation](https://pi.dev/docs/latest/providers#api-keys) for the complete list of supported providers.

### 2\. Create your first agent module [\#](https://flueframework.com/docs/getting-started/quickstart/\#2-create-your-first-agent-module)

Create `agents/hello-world.ts`. This example uses Claude Sonnet, but you can choose any [supported model](https://pi.dev/models) and configure its provider credentials instead:

```
import { createAgent } from '@flue/runtime';

export default createAgent(() => ({
	model: 'anthropic/claude-sonnet-4-6',
	instructions: 'Tell a funny "hello world" engineering joke.',
}));
```

The default export of `agents/hello-world.ts` is what registers the agent — the filename makes it available in Flue as `hello-world`.

### 3\. Talk to your agent locally [\#](https://flueframework.com/docs/getting-started/quickstart/\#3-talk-to-your-agent-locally)

For a Node.js target, open an interactive session with the discovered agent:

```
npx flue connect hello-world local
```

Once connected, type a message and press Enter. In this command, `hello-world` is the module name and `local` is the ID for this agent instance.

```
$ npx flue connect hello-world local
[flue] Connected to hello-world/local. Enter a prompt per line; Ctrl-D to exit.
Hello! What can you help me with?
{
  "text": "I can help answer questions, draft content, summarize information, and more."
}
```

Congratulations! You have created your first Flue agent and opened a local conversation with it. From here, you can shape its behavior, add capabilities, or deploy it as part of an application.

## Next steps [\#](https://flueframework.com/docs/getting-started/quickstart/\#next-steps)

- If you selected the Cloudflare target, continue with [Deploy on Cloudflare](https://flueframework.com/docs/ecosystem/deploy/cloudflare/) to configure and run your Worker.
- Learn how continuing interactions are modeled in [Agents](https://flueframework.com/docs/concepts/agents/).
- Create bounded operations around agents with [Workflows](https://flueframework.com/docs/guide/workflows/).
- Configure targets and local environment behavior in [Configuration](https://flueframework.com/docs/reference/configuration/).
- Choose execution capabilities in [Sandboxes](https://flueframework.com/docs/guide/sandboxes/).

## Docs Navigation

Current page: [Getting Started](https://flueframework.com/docs/getting-started/quickstart/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
