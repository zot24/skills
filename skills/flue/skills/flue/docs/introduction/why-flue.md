<!-- Source: https://flueframework.com/docs/introduction/why-flue -->

**Flue** is the TypeScript framework for building **autonomous AI agents** and the workflows around them. Flue is best-known for giving any model the same [harness-driven architecture](https://flueframework.com/docs/concepts/agents/) used by Claude Code and other coding agents: sessions, tools, skills, instructions, filesystem access, and a secure sandbox to work in. If you need agents that can do more than produce a single response—agents that operate in an environment your code defines, then run anywhere from local CI to a Node.js server to Cloudflare—then Flue is for you.

## Features [\#](https://flueframework.com/docs/introduction/why-flue/\#features)

**Flue is a complete framework for agentic software.** It includes everything you need to build, run, and deploy agents, built-in. It also connects to the wider ecosystem—MCP servers, sandbox adapters, chat surfaces, and observability backends—so you can customize a project to your exact use case and needs.

Some highlights include:

- **[Agents](https://flueframework.com/docs/concepts/agents/):** Autonomous agents that keep context across conversations and events.
- **[Workflows](https://flueframework.com/docs/guide/workflows/):** Structured automations from a clear input to a finished result.
- **[Sandboxes](https://flueframework.com/docs/guide/sandboxes/):** A secure environment where agents act and run code.
- **[CLI](https://flueframework.com/docs/cli/overview/):** Develop locally, run applications or jobs, and build them for deployment.
- **[Subagents](https://flueframework.com/docs/guide/subagents/):** Delegate specialized tasks to the right expert.
- **[Tools](https://flueframework.com/docs/guide/tools/):** Typed actions for calling APIs and changing data.
- **[Skills](https://flueframework.com/docs/guide/skills/):** Reusable expertise agents load on demand.
- **[MCP Servers](https://flueframework.com/docs/guide/tools/#connect-mcp-servers):** Connect tools and services over the open MCP ecosystem.
- **[Observability](https://flueframework.com/docs/guide/observability/):** Export telemetry with [OpenTelemetry](https://flueframework.com/docs/ecosystem/tooling/opentelemetry/), [Braintrust](https://flueframework.com/docs/ecosystem/tooling/braintrust/), [Sentry](https://flueframework.com/docs/ecosystem/tooling/sentry/), or your own observer.
- **[Channels](https://flueframework.com/docs/guide/channels/):** Receive verified provider events and connect them to agents or application code.

## Design Principles [\#](https://flueframework.com/docs/introduction/why-flue/\#design-principles)

Here are three core design principles to help explain why we built Flue, the problems that it exists to solve, and why Flue may be the best choice for your project or team.

Flue is…

1. **[Harness-first](https://flueframework.com/docs/introduction/why-flue/#harness-first):** A model pointed at a harness, not a script.
2. **[Open by default](https://flueframework.com/docs/introduction/why-flue/#open-by-default):** Open models, sandboxes, and deploys—no lock-in.
3. **[AI-first](https://flueframework.com/docs/introduction/why-flue/#ai-first):** Built to be used with your coding agent.

### Harness-first [\#](https://flueframework.com/docs/introduction/why-flue/\#harness-first)

**The harness is essential to building autonomous agents.** Instead of scripting an agent’s steps, you fill its harness with context: instructions, tools, skills, sessions, files, resources, MCP server connections, etc. etc. Then you point a model at it and tell it to go solve the task. No scripting required.

Without a harness, the model is confined too tightly to the API calls you’ve written for it. An agent without a harness is not a real agent.

This idea sits at the center of Flue. Read [What is an agent?](https://flueframework.com/docs/concepts/agents/) for a deep dive into the subject.

### Open by default [\#](https://flueframework.com/docs/introduction/why-flue/\#open-by-default)

**Flue is open at every layer — models, sandboxes, and deployment targets — so you are never locked in.** Many agent frameworks and SDKs are closed in some direction: they assume their own models, run only in their own sandbox, or deploy only to their own cloud. We think that’s backwards.

Flue is deliberately open:

- **Open models:** Connect to any supported LLM provider.
- **Open sandboxes:** Connect to a remote provider, or use the built-in virtual sandbox.
- **Open deploys:** Build your agent for Node.js, Cloudflare, GitHub, GitLab, etc.

See [Sandboxes](https://flueframework.com/docs/guide/sandboxes/) and the [CLI overview](https://flueframework.com/docs/cli/overview/) for more details.

### AI-first [\#](https://flueframework.com/docs/introduction/why-flue/\#ai-first)

**Flue is designed to be used with your coding agent.** This one borders on cliché for a product like ours, and one day it may be obvious enough to drop. For now, we want to be explicit: Flue is an AI-first framework, meant to be used by the developer alongside a coding agent like Claude Code or Codex.

That assumption shapes the experience. Setup, scaffolding, and several workflows are designed around handing a prompt to your coding agent and letting it do the work—and some flows are expected to work best, or only, with a coding agent available. That’s by design, not a gap. If you’re new to Flue, the fastest path is to point your coding agent at the [Getting Started](https://flueframework.com/docs/getting-started/quickstart/) guide and build alongside it.

## Docs Navigation

Current page: [Why Flue?](https://flueframework.com/docs/introduction/why-flue/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
