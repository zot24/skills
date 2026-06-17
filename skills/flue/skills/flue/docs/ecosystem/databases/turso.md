<!-- Source: https://flueframework.com/docs/ecosystem/databases/turso -->

## Quickstart [\#](https://flueframework.com/docs/ecosystem/databases/turso/\#quickstart)

Add durable, hosted database persistence to an existing Flue project with the [Turso](https://turso.tech/) blueprint. Run the following command in your terminal or coding agent of choice:

```
flue add database turso
```

## Overview [\#](https://flueframework.com/docs/ecosystem/databases/turso/\#overview)

The Turso blueprint installs `@flue/libsql` and `@libsql/client`, creates a source-root `db.ts`, and updates existing environment documentation when the project has it. It uses the libSQL adapter with Turso’s database URL and auth token:

```
import { libsql } from '@flue/libsql';
import { createClient, type ResultSet } from '@libsql/client';

const client = createClient({
  url: process.env.TURSO_DATABASE_URL!,
  authToken: process.env.TURSO_AUTH_TOKEN!,
});

const toRows = (rs: ResultSet) =>
  rs.rows.map((row) => Object.fromEntries(rs.columns.map((column) => [column, row[column]])));

export default libsql({
  query: async (text, params = []) => toRows(await client.execute({ sql: text, args: params })),
  transaction: async (fn) => {
    const tx = await client.transaction('write');
    // ...
  },
  close: () => client.close(),
});
```

Flue discovers the adapter at build time and wires it into the generated Node server. On startup, it creates or verifies the required `flue_*` tables. Agent sessions, accepted submissions, and workflow-run records then survive process restarts in hosted Turso and can be shared across replicas; application business data remains application-owned. The blueprint applies only to Node targets because Cloudflare deployments use Durable Object SQLite instead.

## Configure [\#](https://flueframework.com/docs/ecosystem/databases/turso/\#configure)

| Variable | Purpose |
| --- | --- |
| `TURSO_DATABASE_URL` | **Required** — The database’s `libsql://` URL. |
| `TURSO_AUTH_TOKEN` | **Required** — Auth token for the database. |

`createClient` reads these at runtime — they are not baked into the build. For
local development, `flue dev --env <file>` and `flue run --env <file>` load any
`.env`-format file. In production, supply them from your platform’s secret store.

Turso is hosted, replicated libSQL. The blueprint installs `@flue/libsql` and
the official `@libsql/client`, and writes a source-root `db.ts` that wraps the
client with a Turso configuration — it is the **same adapter** as
[`flue add database libsql`](https://flueframework.com/docs/ecosystem/databases/libsql/), pointed at a Turso
database. Flue discovers `db.ts` at build time and wires it into the generated
Node server.

`@flue/libsql` is a **Node.js** adapter. The Cloudflare target uses Durable
Object SQLite automatically and rejects a `db.ts` file at build time, so this
guide applies to Node deployments. See [Database](https://flueframework.com/docs/guide/database/) for the
full picture of how state is stored on each target.

## Create a database [\#](https://flueframework.com/docs/ecosystem/databases/turso/\#create-a-database)

Create a database and an auth token with the
[Turso CLI](https://docs.turso.tech/cli/introduction):

```
turso db create flue-agents
turso db show --url flue-agents      # → TURSO_DATABASE_URL (libsql://…)
turso db tokens create flue-agents   # → TURSO_AUTH_TOKEN
```

```
import { libsql } from '@flue/libsql';
import { createClient, type ResultSet } from '@libsql/client';

const client = createClient({
  url: process.env.TURSO_DATABASE_URL!,
  authToken: process.env.TURSO_AUTH_TOKEN!,
});

const toRows = (rs: ResultSet) =>
  rs.rows.map((row) => Object.fromEntries(rs.columns.map((column) => [column, row[column]])));

export default libsql({
  query: async (text, params = []) => toRows(await client.execute({ sql: text, args: params })),
  transaction: async (fn) => {
    const tx = await client.transaction('write');
    try {
      const result = await fn({
        query: async (text, params = []) => toRows(await tx.execute({ sql: text, args: params })),
      });
      await tx.commit();
      return result;
    } catch (error) {
      await tx.rollback();
      throw error;
    } finally {
      tx.close();
    }
  },
  close: () => client.close(),
});
```

Turso serializes writes server-side, so there is no embedded-file concurrency
concern. The runner shape (`query`, `transaction`, `close`) and the `ResultSet`
mapping are explained in the [libSQL guide](https://flueframework.com/docs/ecosystem/databases/libsql/).

## Embedded replicas [\#](https://flueframework.com/docs/ecosystem/databases/turso/\#embedded-replicas)

For lower read latency, Turso supports **embedded replicas** — a local SQLite
file kept in sync with the remote database, so reads hit local disk and writes
forward to Turso. Point `url` at a local file and add `syncUrl`:

```
const client = createClient({
  url: 'file:flue-replica.db',
  syncUrl: process.env.TURSO_DATABASE_URL!,
  authToken: process.env.TURSO_AUTH_TOKEN!,
});
```

The rest of the `db.ts` is unchanged. Reach for this when read latency matters;
the plain remote client above is the default.

## Migrations [\#](https://flueframework.com/docs/ecosystem/databases/turso/\#migrations)

The adapter’s `migrate()` hook runs automatically when the generated Node
server starts. It creates Flue’s `flue_*` tables idempotently and stamps a
schema version, so a fresh database is provisioned on first boot and an existing
one is reused on restart. There is no separate migration command to run, and a
database written by a newer Flue refuses to start rather than corrupting state.

## What gets stored [\#](https://flueframework.com/docs/ecosystem/databases/turso/\#what-gets-stored)

A Flue database stores runtime state, not your whole application.

| Stored by Flue | Not stored by Flue |
| --- | --- |
| Agent session messages and compaction state | Sandbox files and installed dependencies |
| Accepted direct prompts and `dispatch(...)` submissions | External API side effects |
| Workflow-run records and persisted events | Application-owned business data unless your own tools store it |
| Run indexing for `/runs` lookups and `listRuns()` | Provider credentials or secrets |

See [Durable Agents](https://flueframework.com/docs/concepts/durable-execution/) for how recovery uses
submission state, and the [Data Persistence API](https://flueframework.com/docs/api/data-persistence-api/)
for the exact adapter contract.

## When to choose Turso [\#](https://flueframework.com/docs/ecosystem/databases/turso/\#when-to-choose-turso)

Choose Turso when you want a managed, replicated SQLite without running a
server, and optionally embedded replicas for low-latency reads. For a local
file or a libSQL server you operate yourself, use the same adapter via the
[libSQL guide](https://flueframework.com/docs/ecosystem/databases/libsql/). For a multi-replica Node
deployment on Postgres, see [`@flue/postgres`](https://flueframework.com/docs/ecosystem/databases/postgres/).

## Docs Navigation

Current page: [Turso](https://flueframework.com/docs/ecosystem/databases/turso/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
