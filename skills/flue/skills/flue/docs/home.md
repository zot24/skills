<!-- Source: https://flueframework.com -->

[1.0 Beta — Read the announcement→](https://flueframework.com/blog/flue-1-0-beta/)

# The Open Agent Framework

Build durable AI agents and workflows with Flue's programmable TypeScript harness. Write once, deploy anywhere, use any LLM.

Copy Prompt“Read https://flueframework.com/start.md then help create my first agent...”✓!Copied — now paste that into your coding agent for a guided walkthrough!Could not copy prompt

Watch Video

agents/triage.ts

flue connect triage

POST /agents/triage/:id

```
import { createAgent } from '@flue/runtime';
import { local } from '@flue/runtime/node';
import triage from '../skills/triage/SKILL.md' with { type: 'skill' };
import verify from '../skills/verify/SKILL.md' with { type: 'skill' };
import { replyToIssue } from '../tools/github.ts';

// Expose (and protect) your agents to the world:
export const route = (c, next) => next();

// Give agents the autonomy to solve complex tasks:
const instructions = `
Triage a bug report end-to-end: reproduce the bug,
diagnose the root cause, verify whether the behavior is
intentional, and attempt a fix.`;

// Compose the context your agent needs to do real work,
// complete with virtual, local, or remote container sandbox.
export default createAgent(() => ({
  model:   'anthropic/claude-sonnet-4-6',
  tools:   [replyToIssue],
  skills:  [triage, verify],
  sandbox: local(),
  instructions,
}));
```

## Powered by Pi, the open agent harness.

Flue is powered by Pi, the trusted agent harness used by OpenClaw and millions worldwide. Pi gives you the tools you need to unlock real agent autonomy, moving beyond simple chatbots.

Pi is the core of our open tech stack including [Durable Streams](https://durablestreams.com/), [Vite](https://vite.dev/), and a flexible [Sandbox API](https://flueframework.com/docs/guide/sandboxes/#remote-sandboxes). Deploy Flue anywhere with confidence.

Flue agent architectureAn isometric agent harness powered by Pi, stacked above the Flue runtime.RUNTIMESANDBOX · DATABASE · DEPLOYMENTHARNESSSESSIONS · TOOLS · SKILLS

## Durability. Recovery. It's all handled for you.

Agents can’t die when the server goes down. Flue records every session in a durable stream, then safely resumes interrupted work when the runtime comes back online. Run one agent or a multi-agent swarm on the same durable foundation.

- Accepted work is never lost

- Interrupted sessions resume automatically

- Clients reconnect without starting over


0 agents online\[disrupt\]

## Bring the stack you already love.

[Explore our ecosystem →](https://flueframework.com/docs/ecosystem/)

- [![](https://svgl.app/library/cloudflare.svg)](https://flueframework.com/docs/ecosystem/deploy/cloudflare/)
- [![](https://svgl.app/library/slack.svg)](https://flueframework.com/docs/ecosystem/channels/slack/)
- [![](https://svgl.app/library/github_light.svg)](https://flueframework.com/docs/ecosystem/channels/github/)
- [![](https://svgl.app/library/postgresql.svg)](https://flueframework.com/docs/ecosystem/databases/postgres/)
- [![](https://svgl.app/library/discord.svg)](https://flueframework.com/docs/ecosystem/channels/discord/)
- [![](https://svgl.app/library/docker.svg)](https://flueframework.com/docs/ecosystem/deploy/docker/)
- [![](https://svgl.app/library/stripe.svg)](https://flueframework.com/docs/ecosystem/channels/stripe/)
- [![](https://svgl.app/library/aws_dark.svg)](https://flueframework.com/docs/ecosystem/deploy/aws/)
- [![](https://svgl.app/library/shopify.svg)](https://flueframework.com/docs/ecosystem/channels/shopify/)
- [![](data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%2027%2027%22%3E%3Cpath%20fill%3D%22%23fff%22%20d%3D%22M9.552%200c1.507%200%202.729%201.237%202.729%202.762v2.76c0%201.525-1.222%202.762-2.729%202.762H8.188v1.074h1.364c1.507%200%202.729%201.236%202.729%202.761v2.762c0%201.525-1.222%202.761-2.729%202.761H8.188v1.074h1.364c1.507%200%202.729%201.237%202.729%202.762v2.76c0%201.525-1.222%202.762-2.729%202.762h-2.73c-1.507%200-2.728-1.237-2.728-2.762v-1.917H2.729C1.222%2022.321%200%2021.085%200%2019.56v-2.762c0-1.525%201.223-2.761%202.729-2.761h1.365v-1.074H2.729C1.223%2012.963%200%2011.727%200%2010.202V7.44c0-1.525%201.222-2.761%202.729-2.761h1.365V2.762C4.094%201.237%205.315%200%206.822%200zm9.4%200c1.507%200%202.729%201.237%202.729%202.762v1.917h1.365c1.507%200%202.728%201.237%202.728%202.761v2.762c0%201.525-1.221%202.761-2.728%202.761h-1.365v1.074h1.365c1.507%200%202.728%201.236%202.728%202.761v2.762c0%201.524-1.221%202.761-2.728%202.761h-1.365v1.917c0%201.525-1.222%202.762-2.729%202.762h-2.729c-1.507%200-2.728-1.237-2.728-2.762v-2.76c0-1.525%201.221-2.762%202.728-2.762h1.364v-1.074h-1.364c-1.507%200-2.728-1.236-2.728-2.761v-2.762c0-1.525%201.221-2.761%202.728-2.761h1.364V8.284h-1.364c-1.507%200-2.728-1.237-2.728-2.762v-2.76C13.495%201.237%2014.716%200%2016.223%200z%22%2F%3E%3C%2Fsvg%3E)](https://flueframework.com/docs/ecosystem/tooling/braintrust/)
- [![](https://svgl.app/library/linear.svg)](https://flueframework.com/docs/ecosystem/channels/linear/)
- [![](https://svgl.app/library/sentry.svg)](https://flueframework.com/docs/ecosystem/tooling/sentry/)
- [![](https://svgl.app/library/whatsapp-icon.svg)](https://flueframework.com/docs/ecosystem/channels/whatsapp/)
- [![](https://svgl.app/library/railway.svg)](https://flueframework.com/docs/ecosystem/deploy/railway/)
- [![](https://svgl.app/library/supabase.svg)](https://flueframework.com/docs/ecosystem/databases/supabase/)
- [![](https://svgl.app/library/notion.svg)](https://flueframework.com/docs/ecosystem/channels/notion/)
- [Daytona](https://flueframework.com/docs/ecosystem/sandboxes/daytona/)
- [![](https://svgl.app/library/render_black.svg)](https://flueframework.com/docs/ecosystem/deploy/render/)
- [![](https://svgl.app/library/vercel.svg)](https://flueframework.com/docs/ecosystem/sandboxes/vercel/)
- [![](https://svgl.app/library/telegram.svg)](https://flueframework.com/docs/ecosystem/channels/telegram/)
- [![](https://svgl.app/library/gitlab.svg)](https://flueframework.com/docs/ecosystem/deploy/gitlab-ci/)
- [![](https://svgl.app/library/google-chat.svg)](https://flueframework.com/docs/ecosystem/channels/google-chat/)
- [![](https://svgl.app/library/microsoft-teams.svg)](https://flueframework.com/docs/ecosystem/channels/teams/)
- [![](https://svgl.app/library/mysql-icon-light.svg)](https://flueframework.com/docs/ecosystem/databases/mysql/)
- [![](https://svgl.app/library/nodejs.svg)](https://flueframework.com/docs/ecosystem/deploy/node/)
- [![](https://svgl.app/library/redis.svg)](https://flueframework.com/docs/ecosystem/databases/redis/)
- [E2B](https://flueframework.com/docs/ecosystem/sandboxes/e2b/)
- [![](https://svgl.app/library/mongodb-icon-light.svg)](https://flueframework.com/docs/ecosystem/databases/mongodb/)
- [![](data:image/svg+xml,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20viewBox%3D%220%200%20128%20128%22%3E%3Cpath%20fill%3D%22%23f5a800%22%20d%3D%22M67.648%2069.797c-5.246%205.25-5.246%2013.758%200%2019.008%205.25%205.246%2013.758%205.246%2019.004%200%205.25-5.25%205.25-13.758%200-19.008-5.246-5.246-13.754-5.246-19.004%200Zm14.207%2014.219a6.649%206.649%200%200%201-9.41%200%206.65%206.65%200%200%201%200-9.407%206.649%206.649%200%200%201%209.41%200c2.598%202.586%202.598%206.809%200%209.407ZM86.43%203.672l-8.235%208.234a4.17%204.17%200%200%200%200%205.875l32.149%2032.149a4.17%204.17%200%200%200%205.875%200l8.234-8.235c1.61-1.61%201.61-4.261%200-5.87L92.29%203.671a4.159%204.159%200%200%200-5.86%200ZM28.738%20108.895a3.763%203.763%200%200%200%200-5.31l-4.183-4.187a3.768%203.768%200%200%200-5.313%200l-8.644%208.649-.016.012-2.371-2.375c-1.313-1.313-3.45-1.313-4.75%200-1.313%201.312-1.313%203.449%200%204.75l14.246%2014.242a3.353%203.353%200%200%200%204.746%200c1.3-1.313%201.313-3.45%200-4.746l-2.375-2.375.016-.012Zm43.559-81.582L54.004%2045.605c-1.625%201.625-1.625%204.301%200%205.926L65.3%2062.824c7.984-5.746%2019.18-5.035%2026.363%202.153l9.148-9.149c1.622-1.625%201.622-4.297%200-5.922L78.22%2027.313a4.185%204.185%200%200%200-5.922%200ZM60.55%2067.585l-6.672-6.672c-1.563-1.562-4.125-1.562-5.684%200l-23.53%2023.54a4.036%204.036%200%200%200%200%205.687l13.331%2013.332a4.036%204.036%200%200%200%205.688%200l15.132-15.157c-3.199-6.609-2.625-14.593%201.735-20.73Z%22%2F%3E%3C%2Fsvg%3E)](https://flueframework.com/docs/ecosystem/tooling/opentelemetry/)
- [![](https://svgl.app/library/twilio.svg)](https://flueframework.com/docs/ecosystem/channels/twilio/)
- [![](https://svgl.app/library/salesforce.svg)](https://flueframework.com/docs/ecosystem/channels/salesforce-marketing-cloud/)
- [![](https://svgl.app/library/sst.svg)](https://flueframework.com/docs/ecosystem/deploy/sst/)
- [![](https://svgl.app/library/resend-icon-white.svg)](https://flueframework.com/docs/ecosystem/channels/resend/)
- [![](https://svgl.app/library/fly.svg)](https://flueframework.com/docs/ecosystem/deploy/fly/)
- [Explore the full ecosystem](https://flueframework.com/docs/ecosystem/)

Show more

## Features

Build agents that can safely take action, maintain continuity, and connect to the systems where work already happens.

[**Agents** \\
\\
Build agents that can keep context across conversations and events as they autonomously work toward a goal.](https://flueframework.com/docs/concepts/agents/) [**Workflows** \\
\\
Run structured automations where your code guides agent reasoning from a clear input to a finished result.](https://flueframework.com/docs/guide/workflows/) [**Sandboxes** \\
Give agents a secure environment where they can use tools, modify files, and autonomously complete real work.](https://flueframework.com/docs/guide/sandboxes/) [**Durable Execution** \\
Learn how agents preserve progress through failures and restarts with durable recovery for accepted work.](https://flueframework.com/docs/guide/durable-execution/) [**Subagents** \\
Define specialized roles for different tasks, then let your agent delegate work to the right expert.](https://flueframework.com/docs/guide/subagents/) [**Tools** \\
Give agents typed actions for calling APIs, querying data, and making controlled changes through your application.](https://flueframework.com/docs/guide/tools/) [**Skills** \\
Package reusable expertise and workflows that agents can load whenever a task needs specialized guidance.](https://flueframework.com/docs/guide/skills/) [**MCP Servers** \\
Connect agents to authenticated tools and services through the open Model Context Protocol ecosystem.](https://flueframework.com/docs/guide/tools/#connect-mcp-tools) [**Observability** \\
Monitor your agents and export telemetry with OpenTelemetry, Braintrust, Sentry, or your own observer.](https://flueframework.com/docs/guide/observability/) [**Chat** \\
Connect agents to where your work happens across Slack, Teams, Discord, GitHub, and more.](https://flueframework.com/docs/guide/chat/) [**Explore the docs** \\
Learn how to build, run, and deploy production-ready agents with Flue.\\
Read the docs →](https://flueframework.com/docs/getting-started/quickstart/)
