> Source: https://flueframework.com/docs/ecosystem/databases/supabase

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Supabase


AI-generated, awaiting review <a href="/docs/ecosystem/databases/supabase/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a> <a href="https://www.npmjs.com/package/@flue/postgres" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800" target="_blank" rel="noopener noreferrer">@flue/postgres</a>


## Quickstart

Add durable, shared Postgres persistence to an existing Flue project with the [Supabase](https://supabase.com) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add database supabase
```

## Overview

The Supabase blueprint installs `@flue/postgres` and `pg`, adds the matching `@types/pg` development dependency, and creates a transaction-safe `db.ts` in the project’s source-root. It uses the project’s existing secret convention and updates an existing environment example or environment documentation when one is present.

The primary generated adapter uses one checked-out `pg` client for every query in a transaction:

``` astro-code
import { postgres } from '@flue/postgres';
import { Pool } from 'pg';

const pool = new Pool({ connectionString: process.env.SUPABASE_DATABASE_URL });

export default postgres({
  query: async (text, params) => (await pool.query(text, params)).rows,
  transaction: async (fn) => {
    const client = await pool.connect();
    // ...
  },
  close: () => pool.end(),
});
```

Flue discovers the adapter during a Node build, runs its migrations at server startup, and persists canonical agent conversations, immutable attachments, accepted submissions, workflow runs, and event state in Supabase so that state survives process replacement. Replicas may share durable state and workflow history, but each agent instance still requires one live Node owner. Application business data remains application-owned.

## Configure

| Variable                | Purpose                                                                  |
|-------------------------|--------------------------------------------------------------------------|
| `SUPABASE_DATABASE_URL` | **Required** — Connection string from **Supabase Dashboard \> Connect**. |

The blueprint installs the existing `@flue/postgres` adapter with `pg` and writes a source-root `db.ts`. There is no Supabase-specific Flue package. Flue discovers the file at build time and wires it into the generated Node server.

This integration is **Node.js only**. The Cloudflare target uses Durable Object SQLite automatically and rejects `db.ts` at build time. See [Database](/docs/guide/database/) for persistence by target.

Copy a connection string from **Supabase Dashboard \> Connect** and provide it at runtime as `SUPABASE_DATABASE_URL`:

| Deployment                           | Recommended connection        |
|--------------------------------------|-------------------------------|
| Persistent, IPv6-capable Node server | Direct connection             |
| Persistent, IPv4-only Node server    | Shared pooler in session mode |

The provider-specific environment variable makes the secret’s source clear. If your project already uses another database variable convention, use it consistently in `db.ts` instead. Supply the value through your platform’s secret store and never commit it. For local development, `flue dev --env <file>` and `flue run --env <file>` load any `.env`-format file.

Transaction-mode pooling is not the default. It can preserve an explicit transaction performed on one checked-out client and does not inherently break `BEGIN`/`COMMIT`, but it does not support prepared statements or session state. If your deployment requires transaction mode, keep `pg` queries unnamed as in the example: do not pass a `name` in query configuration or otherwise enable named prepared statements, and do not depend on session state.

## Use the transaction-safe runner

`@flue/postgres` accepts a runner so the application owns driver configuration, pooling, TLS, and credentials. The canonical `pg` runner checks out one client for the entire transaction callback:

``` astro-code
import { postgres } from '@flue/postgres';
import { Pool } from 'pg';

const pool = new Pool({ connectionString: process.env.SUPABASE_DATABASE_URL });

export default postgres({
  query: async (text, params) => (await pool.query(text, params)).rows,
  transaction: async (fn) => {
    const client = await pool.connect();
    try {
      await client.query('BEGIN');
      const result = await fn({
        query: async (text, params) => (await client.query(text, params)).rows,
      });
      await client.query('COMMIT');
      return result;
    } catch (error) {
      await client.query('ROLLBACK');
      throw error;
    } finally {
      client.release();
    }
  },
  close: () => pool.end(),
});
```

Every query in the callback uses the checked-out client. Sending those queries through the pool could move work onto another connection and outside the transaction. `@flue/postgres` uses transaction-scoped `pg_advisory_xact_lock`, not session advisory locks, to serialize session updates; each lock is released with its transaction.

## Migrations

The adapter’s `migrate()` hook runs automatically when the generated Node server starts. It creates Flue’s `flue_*` tables idempotently and stamps a schema version, so a fresh Supabase database is provisioned on first boot and an existing one is reused on restart. There is no separate migration command, and a database written by a newer Flue version refuses to start rather than risking incompatible writes.

## What gets stored

A Flue database stores runtime state, not the application’s whole data model.

| Stored by Flue                                                                                | Not stored by Flue                       |
|-----------------------------------------------------------------------------------------------|------------------------------------------|
| Canonical agent conversation streams and compaction records                                   | Sandbox files and installed dependencies |
| Immutable attachment payloads                                                                 | External API side effects                |
| Accepted direct prompts and `dispatch(...)` submissions                                       | Application-owned business data          |
| Durable submission claims and leases, workflow-run records, persisted events, and run indexes | Provider credentials or secrets          |
| Recovery state for accepted work                                                              | Provider credentials or secrets          |

See [Durable Agents](/docs/concepts/durable-execution/) for recovery behavior and the [Data Persistence API](/docs/api/data-persistence-api/) for the adapter contract.

## Verify

Build the configured Node target and confirm `db.ts` is discovered. Against a non-production Supabase project, start the server and confirm the `flue_*` tables are created. Create agent or workflow state, restart the server, and confirm that state is reloaded. If you use the shared pooler, verify that its mode matches the deployment and that transaction mode, when explicitly chosen, uses no named prepared statements or session state.

## When to choose Supabase

Choose Supabase when your persistent Node deployment needs durable shared Flue state and Supabase already provides its managed Postgres. Use the direct connection where IPv6 is available, or session-mode shared pooling for an IPv4-only server. For another managed or self-hosted Postgres deployment, use the general [Postgres guide](/docs/ecosystem/databases/postgres/).


## Docs Navigation

Current page: [Supabase](/docs/ecosystem/databases/supabase/)

### Sections

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


