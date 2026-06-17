<!-- Source: https://flueframework.com/docs/ecosystem/databases/postgres -->

## Quickstart [\#](https://flueframework.com/docs/ecosystem/databases/postgres/\#quickstart)

Add durable, shared Postgres persistence to an existing Flue project with the [Postgres](https://www.postgresql.org/) blueprint. Run the following command in your terminal or coding agent of choice:

```
flue add database postgres
```

## Overview [\#](https://flueframework.com/docs/ecosystem/databases/postgres/\#overview)

The Postgres blueprint installs `@flue/postgres` and reuses an existing Postgres driver, or adds `pg` and the matching `@types/pg` development dependency by default. It creates a source-root `db.ts` and updates existing environment documentation when the project has it. The default generated adapter uses a pool for ordinary queries and keeps each transaction on one checked-out connection:

```
import { postgres } from '@flue/postgres';
import { Pool } from 'pg';

const pool = new Pool({ connectionString: process.env.DATABASE_URL });

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

Flue discovers the adapter at build time and wires it into the generated Node server. On startup, it creates or verifies the required `flue_*` tables. Agent sessions, accepted submissions, and workflow-run records then survive process restarts and can be shared across replicas; application business data remains application-owned. The blueprint applies only to Node targets because Cloudflare deployments use Durable Object SQLite instead.

## Configure [\#](https://flueframework.com/docs/ecosystem/databases/postgres/\#configure)

| Variable | Purpose |
| --- | --- |
| `DATABASE_URL` | **Required** — Postgres connection string, e.g. `postgresql://user:pass@host:5432/db`. |

Your driver reads `DATABASE_URL` at runtime — it is not baked into the build.
For local development, `flue dev --env <file>` and `flue run --env <file>` load
any `.env`-format file. In production, supply it from your platform’s secret
store.

The blueprint installs `@flue/postgres` with `pg` by default and writes a
source-root `db.ts` that wraps it. Flue discovers `db.ts` at build
time and wires it into the generated Node server. After running the command,
your agents’ sessions, accepted submissions, and workflow-run records persist to
Postgres instead of in-memory state.

`@flue/postgres` is a **Node.js** adapter. The Cloudflare target uses Durable
Object SQLite automatically and rejects a `db.ts` file at build time, so this
guide applies to Node deployments. See [Database](https://flueframework.com/docs/guide/database/) for the
full picture of how state is stored on each target.

## Bring your own driver [\#](https://flueframework.com/docs/ecosystem/databases/postgres/\#bring-your-own-driver)

`@flue/postgres` does not pick or bundle a database driver. It runs against a
small runner you wrap around your configured driver, so you own driver choice,
pooling, TLS, and every other connection option. A runner is three functions:
`query` (a SQL string with numbered `$N` placeholders plus positional params,
resolving to result rows), `transaction` (runs its callback inside one
transaction on a single connection), and `close`.

With [`pg`](https://node-postgres.com/) (node-postgres), `transaction` checks
out a single client and issues `BEGIN`/`COMMIT`/`ROLLBACK` itself — a pool
cannot run a transaction across arbitrary connections:

```
import { postgres } from '@flue/postgres';
import { Pool } from 'pg';

const pool = new Pool({ connectionString: process.env.DATABASE_URL });

export default postgres({
  query: async (text, params) => (await pool.query(text, params)).rows,
  transaction: async (fn) => {
    const client = await pool.connect();
    // ...
  },
  close: () => pool.end(),
});
```

The same seam adapts drivers that support interactive transactions on one
connection. For Neon, use its WebSocket `Pool`; the HTTP query client cannot
implement this callback transaction contract.

## Migrations [\#](https://flueframework.com/docs/ecosystem/databases/postgres/\#migrations)

The adapter’s `migrate()` hook runs automatically when the generated Node
server starts. It creates Flue’s `flue_*` tables idempotently and stamps a
schema version, so a fresh database is provisioned on first boot and an existing
one is reused on restart. There is no separate migration command to run, and a
database written by a newer Flue refuses to start rather than corrupting state.

## What gets stored [\#](https://flueframework.com/docs/ecosystem/databases/postgres/\#what-gets-stored)

A Flue database stores runtime state, not your whole application.

| Stored by Flue | Not stored by Flue |
| --- | --- |
| Agent session messages and compaction state | Sandbox files and installed dependencies |
| Accepted direct prompts and `dispatch(...)` submissions | External API side effects |
| Workflow-run records and persisted events | Application-owned business data unless your own tools store it |
| Run indexing for `/runs` lookups and `listRuns()` | Provider credentials or secrets |

The submission rows and their turn journals are what make accepted work
recoverable after an interruption. See [Durable Agents](https://flueframework.com/docs/concepts/durable-execution/)
for how recovery uses them, and the [Data Persistence API](https://flueframework.com/docs/api/data-persistence-api/)
for the exact adapter contract.

## When to choose Postgres [\#](https://flueframework.com/docs/ecosystem/databases/postgres/\#when-to-choose-postgres)

| Use case | Adapter |
| --- | --- |
| Local development, or restart persistence is unnecessary | `sqlite()` from `@flue/runtime/node` (file path or in-memory) |
| Single-host Node deployment | File-backed `sqlite()` |
| Multi-replica Node deployment, or state must survive host loss | `@flue/postgres` |
| Cloudflare deployment | Built-in Durable Object SQLite (no `db.ts`) |

Choose Postgres when more than one process needs the same accepted work and
run history, or when a single host’s disk is not a durable enough home for
state. Managed Postgres pairs naturally with the container deploy targets —
see [Deploy on AWS](https://flueframework.com/docs/ecosystem/deploy/aws/) for RDS, and the other
[deploy guides](https://flueframework.com/docs/ecosystem/deploy/node/) for provisioning a database
alongside the server.

## Docs Navigation

Current page: [Postgres](https://flueframework.com/docs/ecosystem/databases/postgres/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
