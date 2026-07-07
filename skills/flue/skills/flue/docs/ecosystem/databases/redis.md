> Source: https://flueframework.com/docs/ecosystem/databases/redis

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Redis


AI-generated, awaiting review <a href="/docs/ecosystem/databases/redis/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a> <a href="https://www.npmjs.com/package/@flue/redis" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800" target="_blank" rel="noopener noreferrer">@flue/redis</a>


## Quickstart

Add durable, shared state to an existing Flue project with the [Redis](https://redis.io) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add database redis
```

## Overview

The Redis blueprint installs `@flue/redis` and the official `redis` client, creates a `db.ts` in the project’s source-root, and follows the project’s existing secret convention for `REDIS_URL`. It does not modify deployment configuration because persistence and recovery settings remain owned by the Redis deployment.

The primary generated adapter connects the client and translates Flue database operations into Redis commands:

``` astro-code
import { redis } from '@flue/redis';
import { createClient } from 'redis';

const client = createClient({ url: process.env.REDIS_URL });
await client.connect();

export default redis({
  command: (command, args = []) => client.sendCommand([command, ...args.map(String)]),
  eval: (script, keys, args = []) => client.eval(script, { keys, arguments: args.map(String) }),
  close: () => client.close(),
});
```

This abridged excerpt omits the generated pipeline helper, which batches commands and rejects any `Error` result. Flue discovers the adapter during a Node build, checks and migrates its Redis namespace at server startup, and persists canonical agent conversations, immutable attachments, accepted submissions, workflow runs, and event streams so that they survive Flue process restarts. Durability across Redis server loss depends on the deployment’s AOF or snapshot configuration.

## Configure

| Variable    | Purpose                                                                                     |
|-------------|---------------------------------------------------------------------------------------------|
| `REDIS_URL` | **Required** — Connection URL for a persistent standalone or single-shard Redis deployment. |

The blueprint installs `@flue/redis` and the official `redis` (node-redis) client, then writes a source-root `db.ts`. This is a **Node.js** adapter. The Cloudflare target uses Durable Object SQLite and rejects `db.ts`.

Set `REDIS_URL` to a persistent standalone Redis server or managed single-shard endpoint. Redis Cluster and cache-only configurations are unsupported. Configure `maxmemory-policy noeviction`, plus AOF with an explicit fsync policy and/or durable snapshots appropriate to your recovery objective. `noeviction` avoids silent eviction; it does not make acknowledged writes durable across server loss.

The canonical runner uses the official client:

``` astro-code
import { redis } from '@flue/redis';
import { createClient } from 'redis';

const client = createClient({ url: process.env.REDIS_URL });
await client.connect();

export default redis({
  command: (command, args = []) => client.sendCommand([command, ...args.map(String)]),
  eval: (script, keys, args = []) =>
    client.eval(script, {
      keys,
      arguments: args.map(String),
    }),
  pipeline: async (commands) => {
    const multi = client.multi();
    for (const { command, args = [] } of commands) multi.addCommand([command, ...args.map(String)]);
    const results = await multi.exec();
    for (const result of results) if (result instanceof Error) throw result;
    return results;
  },
  close: () => client.close(),
});
```

## Inspection and isolation

At startup, `inspectServer` uses `CONFIG GET`, falling back to `INFO`, to verify that Cluster is disabled and the eviction policy is `noeviction`. Startup fails when either requirement cannot be verified. Set `inspectServer: false` only when a managed single-shard provider denies both commands and you have independently verified the configuration.

Use a dedicated Redis database or pass a stable, unique `keyPrefix` as the adapter’s second argument. The default is `flue`. Changing it selects a separate namespace; it does not move existing keys.

## Migrations and stored data

Flue runs `migrate()` at startup. It initializes schema-version metadata idempotently and refuses data from an unsupported newer schema; there is no separate migration command.

Redis stores append-only canonical conversation records and compaction facts, immutable attachment payloads, accepted prompts and dispatches, recovery claims and leases, workflow runs and indexes, and persisted event streams. It does not store session transcript snapshots, sandbox files, external API side effects, secrets, or application business data.

## Verify durability

Build the Node target, start it against a throwaway correctly configured Redis, create state, restart Flue, and confirm the state reloads. Separately test the chosen AOF or snapshot recovery procedure: restarting Flue does not prove that Redis survives server loss.


## Docs Navigation

Current page: [Redis](/docs/ecosystem/databases/redis/)

### Sections

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


