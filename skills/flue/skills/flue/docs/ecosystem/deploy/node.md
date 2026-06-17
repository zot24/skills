<!-- Source: https://flueframework.com/docs/ecosystem/deploy/node -->

Build and deploy Flue agents as a Node.js server. This guide walks you through creating your first agent, running it locally, and deploying it anywhere you can run Node.js — a VPS, Docker, Railway, Fly.io, or any cloud platform.

By the end, you will have a Flue agent running as a Node.js server, and you will know how to add subagents, sandbox context, external CLIs, remote sandboxes, and durable session storage when your agent needs them.

This guide focuses on deploying the generated Node server. First review the [CLI overview](https://flueframework.com/docs/cli/overview/) for the development lifecycle and build output, then see [Routing](https://flueframework.com/docs/guide/routing/) for direct HTTP agent delivery, workflow endpoints, and asynchronous `dispatch(...)` from application-owned routes. To package the server as a container image, see [Deploy Agents with Docker](https://flueframework.com/docs/ecosystem/deploy/docker/).

## Project layout [\#](https://flueframework.com/docs/ecosystem/deploy/node/\#project-layout)

The project root is your project directory. Flue selects authored source from `.flue/`, then `src/`, then the project root. The first matching directory wins, and layouts never mix. See [Project Layout](https://flueframework.com/docs/guide/project-layout/) for the full convention.

By default `flue build` writes to `./dist/` at the project root; pass `--output <path>` to redirect the build elsewhere. Examples in this guide use the `./.flue/` layout.

## Hello World [\#](https://flueframework.com/docs/ecosystem/deploy/node/\#hello-world)

The simplest agent — no container, no storage, just a prompt and a typed result.

### 1\. Set up your project [\#](https://flueframework.com/docs/ecosystem/deploy/node/\#1-set-up-your-project)

```
mkdir my-flue-server && cd my-flue-server
npm init -y
npm install @flue/runtime valibot
npm install -D @flue/cli
```

### 2\. Create your first agent [\#](https://flueframework.com/docs/ecosystem/deploy/node/\#2-create-your-first-agent)

`.flue/workflows/translate.ts`:

```
import { createAgent, type FlueContext, type WorkflowRouteHandler } from '@flue/runtime';
import * as v from 'valibot';

export const route: WorkflowRouteHandler = async (_c, next) => next();

const translator = createAgent(() => ({ model: 'openai/gpt-5.5' }));

export async function run({ init, payload }: FlueContext<{ text: string; language: string }>) {
  const harness = await init(translator);
  const session = await harness.session();

  const { data } = await session.prompt(
    `Translate this to ${payload.language}: "${payload.text}"`,
    {
      result: v.object({
        translation: v.string(),
        confidence: v.picklist(['low', 'medium', 'high']),
      }),
    },
  );

  return data;
}
```

A few things to note:

- **`route`** — Export Hono middleware to expose this workflow via HTTP. It may perform authentication before calling `next()`.
- **`createAgent(...)` \+ `init(agent)`** — Created agents declare model and sandbox configuration; workflows initialize them when needed. `init(agent)` fails unless its created agent config provides a model, sets `model: false`, or supplies a profile with a model. By default, Flue gives initialized agents a virtual sandbox powered by [just-bash](https://github.com/vercel-labs/just-bash). No container needed.
- **Schemas** — The [Valibot](https://valibot.dev/) schema defines the expected output shape. Flue parses the agent’s response and returns it on `response.data`, fully typed.

### 3\. Add your API key [\#](https://flueframework.com/docs/ecosystem/deploy/node/\#3-add-your-api-key)

Put provider API keys in a `.env` file at the project root:

```
cat > .env <<'EOF'
OPENAI_API_KEY="your-api-key"
EOF

printf '\n.env\n' >> .gitignore
```

Use the env var name your provider expects — `OPENAI_API_KEY` for OpenAI, `ANTHROPIC_API_KEY` for Anthropic, and so on. Do not commit `.env`.

### 4\. Build and run [\#](https://flueframework.com/docs/ecosystem/deploy/node/\#4-build-and-run)

For local development, `flue dev --target node` is the fastest path. It loads project-root `.env` before configuration, builds your project, starts the server on port 3583, and reloads local runtime environment values when `.env` is created, edited, deleted, or recreated.

```
npx flue dev --target node
```

Test it:

```
curl 'http://localhost:3583/workflows/translate?wait=result' \
  -H "Content-Type: application/json" \
  -d '{"text": "Hello world", "language": "French"}'
```

The `?wait=result` mode keeps this request attached until the workflow completes and returns its result. Without it, an admitted HTTP workflow responds immediately with `202` and a `runId` for later inspection.

Every workflow that exports `route` gets an HTTP endpoint automatically. The middleware may authenticate the request and call `next()` to admit it. The route follows the pattern `/workflows/<name>` — for example, `.flue/workflows/translate.ts` becomes `/workflows/translate`.

For a production-style server, build and then start the generated artifact. `flue build` loads `.env` for configuration and build-time evaluation, while the built server reads only the environment supplied when you start it:

```
npx flue build --target node
set -a; source .env; set +a
node dist/server.mjs
```

`flue build --target node` compiles your project into a `./dist` directory without packaging `.env` credentials into the server. The built server uses [Hono](https://hono.dev/) under the hood and listens on port 3000 by default (configurable via `PORT`). Your project’s `node_modules` are still needed at runtime — the build externalizes your dependencies rather than bundling them.

You can also invoke any workflow from the CLI without starting a server. `flue run` loads project-root `.env` automatically; pass `--env` only to select one alternate file:

```
npx flue run translate --target node \
  --payload '{"text": "Hello world", "language": "French"}'
```

## Subagents [\#](https://flueframework.com/docs/ecosystem/deploy/node/\#subagents)

Subagents define named delegates for detached task sessions:

```
import { createAgent, defineAgentProfile } from '@flue/runtime';

const analyst = defineAgentProfile({
  name: 'analyst',
  instructions: 'Focus on quantitative insights, trends, and actionable takeaways.',
});
const reportAgent = createAgent(() => ({ model: 'openai/gpt-5.5', subagents: [analyst] }));

const harness = await init(reportAgent);
const session = await harness.session();
const analysis = await session.task("Analyze this quarter's metrics", { agent: 'analyst' });
```

## Sandbox context [\#](https://flueframework.com/docs/ecosystem/deploy/node/\#sandbox-context)

The agent reads `AGENTS.md` and skills from its sandbox at runtime. With `local()`, that’s your real project root, so any files there are visible. With the default virtual sandbox the filesystem starts empty — you’d set up context via `session.shell()` or skip these features for simple prompt-and-response agents.

**Skills** are reusable agent tasks defined as markdown files in `.agents/skills/`. They give the agent a focused instruction set for a specific job:

`.agents/skills/summarize/SKILL.md`:

```
---
name: summarize
description: Summarize a document or text input.
---

Given the text provided in the arguments, produce a concise summary.
Focus on the key points and keep it to 2-3 sentences.
```

**`AGENTS.md`** at the root of the sandbox is the agent’s system prompt — it provides global context about the project.

Call a skill from your agent:

```
import * as v from 'valibot';

const { data } = await session.skill('summarize', {
  args: { text: document },
  result: v.object({ summary: v.string() }),
});
```

## Using the local sandbox [\#](https://flueframework.com/docs/ecosystem/deploy/node/\#using-the-local-sandbox)

`local()` is where Node really shines compared to other targets. The agent runs directly against the host filesystem and shell — `cwd` is `process.cwd()`, shell commands go through `child_process`, and `AGENTS.md` and skills are discovered from the project root.

Run flue itself inside an isolation boundary you trust — a CI runner, a container, a sandbox VM. There is no second layer of isolation between the agent and the host.

Env exposure is opt-in. By default only shell essentials (`PATH`, `HOME`, locale, etc.) are inherited from `process.env`; anything else — API keys, tokens, deploy credentials — has to be passed explicitly via `local({ env: { ... } })`. That keeps the model’s `bash` tool from seeing host secrets by accident.

`.flue/workflows/reviewer.ts`:

```
import { createAgent, type FlueContext, type WorkflowRouteHandler } from '@flue/runtime';
import { local } from '@flue/runtime/node';
import * as v from 'valibot';

export const route: WorkflowRouteHandler = async (_c, next) => next();

const reviewer = createAgent(() => ({ sandbox: local(), model: 'anthropic/claude-sonnet-4-6' }));

export async function run({ init, payload }: FlueContext<{ topic: string }>) {
  const harness = await init(reviewer);
  const session = await harness.session();

  const { data } = await session.prompt(
    `Review the codebase and identify potential issues in the area
    related to: ${payload.topic}`,
    {
      result: v.object({
        issues: v.array(
          v.object({
            file: v.string(),
            line: v.optional(v.number()),
            severity: v.picklist(['low', 'medium', 'high']),
            description: v.string(),
          }),
        ),
        summary: v.string(),
      }),
    },
  );

  return data;
}
```

The agent reads, searches, and modifies files via its built-in tools — read, write, edit, grep, glob, bash. Anything on `$PATH` (`git`, `npm`, `gh`, `docker`) is reachable from the bash tool. Env vars are opt-in via `local({ env: { ... } })` — pass `process.env.GH_TOKEN`, `process.env.NPM_TOKEN`, etc. into the sandbox for the binaries that need them.

### When to use it [\#](https://flueframework.com/docs/ecosystem/deploy/node/\#when-to-use-it)

- **Self-hosted coding agents** — review PRs, fix bugs, refactor against the actual repo.
- **File processing** — read documents, transform data, generate reports from local files.
- **Dev tooling** — analyze project structure, run linters, generate boilerplate.
- **CI** — issue triage, deploy checks, anything where the runner already provides isolation.

No container startup, real project context, fast iteration. If you need a tighter boundary on a specific operation — agent can call it, never sees the underlying secret — wrap it as a custom tool via `createAgent(() => ({ tools: [...] }))`. The tool reads `process.env`; the agent only sees the tool’s params and result.

## Connecting a remote sandbox [\#](https://flueframework.com/docs/ecosystem/deploy/node/\#connecting-a-remote-sandbox)

The examples above use either the default virtual sandbox or the local sandbox. When you need full isolation per session — each user gets their own Linux environment with git, Node.js, Python, etc. — you want a remote sandbox.

Flue connects to remote sandboxes through project-owned sandbox adapters installed from `flue add` blueprints. Run `flue add` with no arguments to see what’s currently supported, or `flue add sandbox <url>` to have your coding agent build an adapter for an unsupported provider against the [Sandbox Adapter API](https://flueframework.com/docs/api/sandbox-api/).

The Ecosystem catalog lists available provider integrations, including [Daytona](https://flueframework.com/docs/ecosystem/sandboxes/daytona/), [E2B](https://flueframework.com/docs/ecosystem/sandboxes/e2b/), [Modal](https://flueframework.com/docs/ecosystem/sandboxes/modal/), and [Vercel Sandbox](https://flueframework.com/docs/ecosystem/sandboxes/vercel/). Other adapters follow the same application-owned lifecycle shape.

### When to use a remote sandbox [\#](https://flueframework.com/docs/ecosystem/deploy/node/\#when-to-use-a-remote-sandbox)

| Local / virtual sandbox | Remote sandbox |
| --- | --- |
| Millisecond startup | Seconds to start (cached images are faster) |
| Shares host filesystem (local) | Fully isolated per session |
| No per-session isolation | Each user gets their own environment |
| Great for single-tenant / CI | Great for multi-tenant / SaaS |

Start with the local or virtual sandbox. Move to a remote sandbox when you need per-session isolation.

## Session persistence [\#](https://flueframework.com/docs/ecosystem/deploy/node/\#session-persistence)

On Node.js, agent sessions and accepted submissions use in-memory SQLite by default, so they persist for the lifetime of one process but are lost on restart. Add `db.ts` when that state must survive restart or be shared outside one process.

See [Database](https://flueframework.com/docs/guide/database/) for `db.ts`, SQLite, Postgres, and custom adapter setup. See [Data Persistence API](https://flueframework.com/docs/api/data-persistence-api/) for the adapter contract.

## Building and deploying [\#](https://flueframework.com/docs/ecosystem/deploy/node/\#building-and-deploying)

Flue compiles your project into a Node.js server:

```
# Build
npx flue build --target node

# Run locally
node dist/server.mjs

# Run on a custom port
PORT=8080 node dist/server.mjs
```

The `FLUE_MODE`, `FLUE_CLI_*`, and `FLUE_INTERNAL_CLI_IPC` environment variables are reserved by the Flue CLI — do not set them when starting the built server. In particular, `FLUE_MODE=local` in production includes developer guidance in error envelopes.

The default root-mounted Flue application can expose:

- `POST /agents/:name/:id` — send an attached prompt to an agent module that exports `route`;
- `GET /agents/:name/:id` — stream agent events via the Durable Streams protocol;
- `POST /workflows/:name` — invoke a workflow module that exports `route`;
- `GET /runs/:runId` — stream workflow-run events via the Durable Streams protocol (`?meta` reads the run record).

Flue does not add a health endpoint or deployment-inspection routes by default. Define a host-required health route in `app.ts`, and [compose your own admin endpoints](https://flueframework.com/docs/api/routing-api/#compose-your-own-admin-endpoints) behind operator authorization if deployment-wide inspection is required. Agent prompt routes advance sessions without creating runs; workflow invocations are the executions represented by workflow run IDs and inspectable through run tooling.

### Choosing a sandbox strategy [\#](https://flueframework.com/docs/ecosystem/deploy/node/\#choosing-a-sandbox-strategy)

Here’s the progression of sandbox types available on Node.js, from simplest to most powerful:

1. **Empty virtual sandbox** — `createAgent(() => ({ model: 'openai/gpt-5.5' }))`. Fast, cheap, stateless. Good for prompt-and-response agents.
2. **Virtual sandbox with shell setup** — Use `session.shell()` to write files and configure the workspace. Still fast and cheap, good for agents that need small amounts of static context.
3. **Local sandbox** — `createAgent(() => ({ sandbox: local(), model: 'anthropic/claude-sonnet-4-6' }))`. Direct host filesystem and shell access. Ideal for self-hosted agents, CI tasks, and dev tooling — anywhere the host environment already provides isolation. Import `local` from `@flue/runtime/node` and pass `env: { ... }` to expose specific host env vars to the agent’s shell.
4. **Remote sandbox** — Full isolated Linux environment via a sandbox adapter. For multi-tenant agents, coding sandboxes, and anything that needs per-session isolation.

Start simple. Move up when you need to.

## Docs Navigation

Current page: [Deploy Agents on Node.js](https://flueframework.com/docs/ecosystem/deploy/node/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
