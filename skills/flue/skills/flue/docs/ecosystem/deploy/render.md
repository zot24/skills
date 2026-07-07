> Source: https://flueframework.com/docs/ecosystem/deploy/render

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Deploy Agents on Render


Last updated Jun 20, 2026 <a href="/docs/ecosystem/deploy/render/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


Flue’s Node target is a long-running HTTP server, not a serverless function, so it deploys to Render as a web service that stays up between requests. This guide covers the Render-specific setup; the build itself is the same `node` target described in [Deploy Agents on Node.js](/docs/ecosystem/deploy/node/) — `npx flue build --target node` produces `dist/server.mjs`, which you start with `node dist/server.mjs`.

The fastest start is the [Flue template](https://render.com/templates/flue): a one-click Blueprint that provisions a Node web service running the translation and assistant agents. The [Flue + Postgres template](https://render.com/templates/flue-with-postgresql) is the same service with a Render Postgres database wired in. Both render the rest of this guide as the explanation of what they set up.

## Deploy

Render reads a Blueprint — a `render.yaml` at the repo root — to provision the service as code. A Flue web service is a Node runtime with the build and start commands from the Node guide:

``` astro-code
services:
  - type: web
    name: flue-agents
    runtime: node
    plan: free
    buildCommand: npm ci && npx flue build --target node
    startCommand: node dist/server.mjs
    healthCheckPath: /health
    envVars:
      - key: ANTHROPIC_API_KEY
        sync: false
```

- `buildCommand` compiles the Flue Node target. The build externalizes your dependencies rather than bundling them, so `node_modules` must be present at runtime — `npm ci` installs them, and `@flue/cli` must be available to the build command.
- `startCommand` runs the generated server, which binds the `PORT` Render injects and serves agents at `/agents/<name>/<id>` and workflows at `/workflows/<name>`.
- `healthCheckPath` lets Render verify each deploy before shifting traffic to it — but only if your application defines that route (see [Health and streaming](#health-and-streaming)).

Push the file and create a Blueprint from the Render Dashboard (**New \> Blueprint**), or click **Deploy to Render** from a template. Render copies the template repo to your GitHub account, prompts for any `sync: false` secrets, and deploys. To auto-deploy on every push, set `autoDeployTrigger: commit` on the service (this replaces the deprecated `autoDeploy` field).

The template uses `plan: free`, so first deploys cost nothing. Free web services spin down after 15 minutes without inbound traffic, and the next request pays a cold start — about a minute — while the Node process restarts. In-memory conversation and submission state is also lost across that restart. For agents that see sporadic production traffic, move to `starter` or higher to keep the service warm, and add Postgres for durable recovery.

## Environment and secrets

The built server reads only the environment present when it starts — it does not load `.env` — so configuration lives in Render environment variables, set in the Dashboard or declared in `render.yaml`. Flue needs the API key for your model provider, plus an optional model specifier:

| Variable                               | Purpose                                                                                                 |
|----------------------------------------|---------------------------------------------------------------------------------------------------------|
| `ANTHROPIC_API_KEY` / `OPENAI_API_KEY` | Authenticates calls to your model provider. Use the name your provider expects.                         |
| `MODEL_SPECIFIER`                      | Optional default model, e.g. `anthropic/claude-sonnet-4-6`, if your app reads one from the environment. |

Declare secret values with `sync: false` so they stay out of the Blueprint — Render prompts for them on first deploy and stores them on the service. Non-secret values like a model specifier can carry a literal `value`:

``` astro-code
envVars:
  - key: MODEL_SPECIFIER
    value: anthropic/claude-sonnet-4-6
  - key: ANTHROPIC_API_KEY
    sync: false
```

Render ignores `sync: false` variables when updating an existing Blueprint, so rotate those secrets from the Dashboard. Do not set the reserved `FLUE_MODE` or `FLUE_CLI_*` variables in production.

## Persistence

The Node target keeps canonical agent conversations and accepted submissions in memory by default. That state is lost on every restart, deploy, and free-plan spin-down.

For durable process or host replacement, add a Render Postgres database to the Blueprint and wire its connection string into the web service with `fromDatabase`. A shared database does not enable active-active ownership of one agent instance: route each instance to one live Node process and avoid overlapping owners during replacement.

``` astro-code
databases:
  - name: flue-db
    plan: basic-256mb

services:
  - type: web
    name: flue-agents
    runtime: node
    plan: free
    buildCommand: npm ci && npx flue build --target node
    startCommand: node dist/server.mjs
    healthCheckPath: /health
    envVars:
      - key: DATABASE_URL
        fromDatabase:
          name: flue-db
          property: connectionString
      - key: ANTHROPIC_API_KEY
        sync: false
```

`fromDatabase` supplies the database’s internal connection string — the one Render recommends for services in the same account and region, since it stays on the private network. Install the adapter and read `DATABASE_URL` in `db.ts`:

``` astro-code
npm install @flue/postgres
```

``` astro-code
import { postgres } from '@flue/postgres';

export default postgres(process.env.DATABASE_URL!);
```

Flue discovers `db.ts` at build time and wires it into the generated server — schema creation, canonical conversation streams, immutable attachments, durable submission state, and workflow history are handled by the adapter. See [Database](/docs/guide/database/) for the adapter contract and alternatives. Note that a `free` Postgres database expires 30 days after creation; use a `basic-256mb` or larger plan for anything you intend to keep.

## Health and streaming

Flue does not generate a `/health` route. If you set `healthCheckPath`, define the matching route in `app.ts` — otherwise the check never passes and Render holds the deploy back. Drop `healthCheckPath` if you don’t want a health gate.

Exposed workflow runs are served through long-lived `GET /runs/:runId` reads (long-poll/SSE). Render imposes no fixed idle timeout and allows a request to run up to 100 minutes. Instance replacement can still close connections, so retain the invocation’s `runId` and resume the run stream rather than relying on one blocking `?wait=result` request. The server’s `SIGTERM` shutdown delay (default 30s, up to 300s via `maxShutdownDelaySeconds`) governs graceful shutdown. See [Workflow HTTP exports](/docs/api/workflow-api/#http-exports).

## Going further

- **Scheduled workflows.** Model periodic tasks as a Render cron job that calls the deployed application’s authenticated workflow endpoint, or set its command to `npx flue run workflow:<name> --server https://<host>/<flue-mount>`. Remote attachment avoids rebuilding and starting a second application runtime for every fire. Render runs at most one instance of a given cron job at a time and stops a run after 12 hours.
- **Background workers.** For continuous, queue-driven delivery, add a `type: worker` service. A worker has no public port; it runs `node dist/server.mjs` (or a custom entry), makes attached agent requests and waits for results, or has application code call `dispatch(...)` for asynchronous delivery identified by `dispatchId`.

## References

- [Blueprint YAML reference](https://render.com/docs/blueprint-spec) — official `render.yaml` field reference: `type`, `runtime`, `buildCommand`, `startCommand`, `healthCheckPath`, `envVars` with `sync: false`, `autoDeployTrigger`, `databases`, and `fromDatabase`.
- [Free instances](https://render.com/docs/free) — official spin-down (15 min), cold-start, and free-Postgres expiry (30 days) behavior.
- [Connect to Render Postgres](https://render.com/docs/postgresql-creating-connecting) — official internal vs. external connection string guidance.
- [Cron jobs](https://render.com/docs/cronjobs) — official scheduling rules: UTC, standard cron syntax, single active run, 12-hour max.
- [Background workers](https://render.com/docs/background-workers) — official guide to no-public-port worker services.
- [Real-time AI chat infrastructure](https://render.com/articles/real-time-ai-chat-websockets-infrastructure) — Render’s own write-up of the 100-minute max request duration and persistent-connection model for streaming.


## Docs Navigation

Current page: [Deploy Agents on Render](/docs/ecosystem/deploy/render/)

### Sections

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


