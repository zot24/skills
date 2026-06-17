---
name: flue
description: Expert on Flue — the open-source TypeScript framework (by the Astro team) for building durable, autonomous AI agents and workflows on the Pi harness. Use when building Flue agents, workflows, channels, tools, or skills; deploying agents to Cloudflare/Node/AWS/etc.; or using the flue CLI/SDK/React hooks. Triggers on mentions of Flue, flueframework, @flue/runtime, @flue/cli, @flue/sdk, createAgent, flue add, durable agents.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# Flue — The Open Agent Framework

Flue is an open-source TypeScript framework for building **durable, autonomous AI agents and the workflows around them**, from the team behind [Astro](https://astro.build). Pitch: *"Build durable AI agents and workflows with a programmable TypeScript harness. Write once, deploy anywhere, use any LLM."* Built on the **Pi** agent harness, **Vite** for builds, and **Durable Streams** for the replayable event log.

## Overview

- **Agents** — stateful, long-lived; you fill a *harness* with context (model, tools, skills, sandbox, instructions, subagents) and point a model at it — *"a model pointed at a harness, not a script."*
- **Workflows** — finite, deterministic `run(...)` functions you author start-to-finish; each invocation gets a `runId` (not resumable).
- **Channels** — receive *verified* inbound provider events (Slack mention, GitHub issue, Stripe webhook) and dispatch them to an agent.
- **Tools / Skills / Subagents / MCP** — typed actions, on-demand `SKILL.md` capability packs, named delegates, and MCP server connections.
- **Durable** — every session is recorded to a Durable Stream; on restart another process replays the log and resumes. *"Agents can't die when the server goes down."*
- **Open & AI-first** — any model/sandbox/deploy target; designed to be driven by a coding agent (`flue add` hands your agent a Markdown blueprint, "like shadcn for agents").

## Quick Start

```bash
npm install @flue/runtime
npm install --save-dev @flue/cli
echo 'ANTHROPIC_API_KEY="your-api-key"' > .env
npx flue init --target node        # or: --target cloudflare
```

```typescript
// agents/hello-world.ts — default export registers the agent as `hello-world`
import { createAgent } from '@flue/runtime';

export default createAgent(() => ({
  model: 'anthropic/claude-sonnet-4-6',   // provider-prefixed model id
  instructions: 'Tell a funny "hello world" engineering joke.',
}));
```

```bash
npx flue connect hello-world local   # interactive session (Node target)
```

## Core Concepts

- **Harness-first**: agents are context, not scripts — *"an agent without a harness is not a real agent."*
- **Models** are provider-prefixed string ids (`anthropic/claude-sonnet-4-6`, `openai/gpt-5.5`, `cloudflare/@cf/...`) via Pi's unified API; output validated with [Valibot](https://valibot.dev) schemas.
- **Durability differs by target**: durable-by-default on Cloudflare (Durable Objects); opt-in on Node via a persistence adapter.

## Documentation

### Getting started
- **[Why Flue?](docs/introduction/why-flue.md)** — the three design principles
- **[Quickstart](docs/getting-started/quickstart.md)** — install, first agent, run locally
- **[What is an agent?](docs/concepts/agents.md)** / **[Durable Agents](docs/concepts/durable-execution.md)** — mental model + durability

### Guides
- **[Building Agents](docs/guide/building-agents.md)** · **[Workflows](docs/guide/workflows.md)** · **[Subagents](docs/guide/subagents.md)**
- **[Tools](docs/guide/tools.md)** · **[Skills](docs/guide/skills.md)** · **[Channels](docs/guide/channels.md)** · **[Routing](docs/guide/routing.md)**
- **[Models](docs/guide/models.md)** · **[Database](docs/guide/database.md)** · **[Sandboxes](docs/guide/sandboxes.md)** · **[Observability](docs/guide/observability.md)**
- **[Project Layout](docs/guide/project-layout.md)** · **[React](docs/guide/react.md)** · Targets: **[Cloudflare](docs/guide/targets/cloudflare.md)** / **[Node](docs/guide/targets/node.md)**

### Reference
- **[CLI](docs/cli/overview.md)** — `init`, `dev`, `run`, `connect`, `build`, `add`, `update`, `logs`, `docs`
- **[SDK](docs/sdk/overview.md)** — `createFlueClient`, `client.agents`, `client.workflows`, `client.runs`, `events`, `errors`
- **[API Reference](docs/api/agent-api.md)** — agent, routing, provider, sandbox, data-persistence, channel APIs, [errors](docs/api/errors-reference.md)
- **[Configuration](docs/reference/configuration.md)** — `flue.config.ts`

### Ecosystem (first-party adapters)
- **Deploy (10):** [Cloudflare](docs/ecosystem/deploy/cloudflare.md), AWS, Docker, Fly, Node, Railway, Render, SST, GitHub Actions, GitLab CI
- **Channels (17):** [Slack](docs/ecosystem/channels/slack.md), GitHub, Discord, Stripe, Linear, Telegram, WhatsApp, Notion, Teams, Twilio, Zendesk, Intercom, Resend, Shopify, Messenger, Google Chat, Salesforce
- **Sandboxes (10):** [Cloudflare](docs/ecosystem/sandboxes/cloudflare.md), E2B, Daytona, Modal, Vercel, boxd, exe.dev, islo, Mirage, Cloudflare Shell
- **Databases (8):** [Postgres](docs/ecosystem/databases/postgres.md), Redis, MongoDB, MySQL, libSQL, Turso, Supabase, Valkey
- **Tooling (3):** [OpenTelemetry](docs/ecosystem/tooling/opentelemetry.md), Braintrust, Sentry

## Common Workflows

- **Add an integration**: `npx flue add channel slack` (or `sandbox daytona`, `database postgres`, `tooling opentelemetry`) — hands your coding agent a Markdown blueprint to wire it into *your* codebase. See [flue add](docs/cli/add.md).
- **Deploy to Cloudflare** (durable by default): `flue dev --target cloudflare` locally, then build/deploy — see [targets/cloudflare](docs/guide/targets/cloudflare.md) and [deploy/cloudflare](docs/ecosystem/deploy/cloudflare.md).
- **Frontend integration**: `@flue/react` `useFlueAgent()` / `useFlueWorkflow()` stream live data — see [React guide](docs/guide/react.md).

## Upstream Sources

- **Documentation**: https://flueframework.com/docs
- **Repository**: https://github.com/withastro/flue
- **Offline docs**: `flue docs` ships searchable offline docs for coding agents
