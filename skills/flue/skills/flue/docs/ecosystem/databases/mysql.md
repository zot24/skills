<!-- Source: https://flueframework.com/docs/ecosystem/databases/mysql -->

## Quickstart [\#](https://flueframework.com/docs/ecosystem/databases/mysql/\#quickstart)

Add durable, shared MySQL persistence to an existing Flue project with the [MySQL](https://www.mysql.com/) blueprint. Run the following command in your terminal or coding agent of choice:

```
flue add database mysql
```

## Overview [\#](https://flueframework.com/docs/ecosystem/databases/mysql/\#overview)

The MySQL blueprint installs `@flue/mysql` and `mysql2` and creates a source-root `db.ts`. The generated adapter uses a pool for ordinary queries and keeps each transaction on one checked-out connection:

```
import { mysql, type MysqlQuery } from '@flue/mysql';
import mysql2 from 'mysql2/promise';

const pool = mysql2.createPool(process.env.MYSQL_URL!);

const toRows = (result: unknown): Record<string, unknown>[] =>
  Array.isArray(result) ? result.map((row) => ({ ...row })) : [];

export default mysql({
  query: async (text, params = []) => {
    const [result] = await pool.execute(text, params);
    return toRows(result);
  },
  transaction: async <T>(fn: (tx: { query: MysqlQuery }) => Promise<T>) => {
    const connection = await pool.getConnection();
    await connection.beginTransaction();
    // ...
  },
  close: () => pool.end(),
});
```

Flue discovers the adapter at build time and wires it into the generated Node server. On startup, it creates and verifies the required MySQL 8 InnoDB tables. Agent sessions, accepted submissions, and workflow-run records then survive process restarts and can be shared across replicas; application business data remains application-owned. The blueprint applies only to Node targets because Cloudflare deployments use Durable Object SQLite instead.

## Configure [\#](https://flueframework.com/docs/ecosystem/databases/mysql/\#configure)

| Variable | Purpose |
| --- | --- |
| `MYSQL_URL` | **Required** — MySQL connection string, supplied by your database provider. |

The driver reads this value at runtime. Supply it through your platform’s
secret store, never commit it, and configure `mysql2` TLS options when your
provider requires them. For local development, `flue dev --env <file>` and
`flue run --env <file>` load any `.env`-format file.

The blueprint installs `@flue/mysql` and `mysql2`, then writes a source-root
`db.ts`. Flue discovers that file at build time and wires it into the generated
Node server.

`@flue/mysql` supports **MySQL 8 with InnoDB** on the **Node.js target**. The
Cloudflare target uses Durable Object SQLite automatically and rejects `db.ts`
at build time. See [Database](https://flueframework.com/docs/guide/database/) for persistence by target.

## Bring your own driver [\#](https://flueframework.com/docs/ecosystem/databases/mysql/\#bring-your-own-driver)

`@flue/mysql` does not bundle a production driver. It accepts a runner so your
application owns pooling, TLS, credentials, and connection lifecycle. The
canonical `mysql2` runner uses `pool.execute()` for normal queries and one
checked-out connection for each callback transaction:

```
import { mysql, type MysqlQuery } from '@flue/mysql';
import mysql2 from 'mysql2/promise';

const pool = mysql2.createPool(process.env.MYSQL_URL!);

const toRows = (result: unknown): Record<string, unknown>[] =>
  Array.isArray(result) ? result.map((row) => ({ ...row })) : [];

export default mysql({
  query: async (text, params = []) => {
    const [result] = await pool.execute(text, params);
    return toRows(result);
  },
  transaction: async <T>(fn: (tx: { query: MysqlQuery }) => Promise<T>) => {
    const connection = await pool.getConnection();
    try {
      await connection.beginTransaction();
      const result = await fn({
        query: async (text, params = []) => {
          const [rows] = await connection.execute(text, params);
          return toRows(rows);
        },
      });
      await connection.commit();
      return result;
    } catch (error) {
      await connection.rollback();
      throw error;
    } finally {
      connection.release();
    }
  },
  close: () => pool.end(),
});
```

The runner uses `?` placeholders and returns plain row objects. Every query in a
transaction callback must use the checked-out connection; issuing those calls
through the pool could move work onto another connection and outside the
transaction.

## Migrations [\#](https://flueframework.com/docs/ecosystem/databases/mysql/\#migrations)

The adapter’s `migrate()` hook runs automatically when the generated Node
server starts. It creates Flue’s `flue_*` tables idempotently, verifies the
complete schema, and then stamps its version. All transactional tables use
InnoDB. There is no separate migration command, and a database written by a
newer Flue version refuses to start rather than risking incompatible writes.

## What gets stored [\#](https://flueframework.com/docs/ecosystem/databases/mysql/\#what-gets-stored)

A Flue database stores runtime state, not your whole application.

| Stored by Flue | Not stored by Flue |
| --- | --- |
| Agent session messages, compaction state, and persisted image chunks | Sandbox files and installed dependencies |
| Accepted direct prompts and `dispatch(...)` submissions | External API side effects |
| Durable turn journals, claims, and leases | Application-owned business data |
| Workflow-run records, persisted events, and run indexes | Provider credentials or secrets |

See [Durable Agents](https://flueframework.com/docs/concepts/durable-execution/) for recovery behavior
and the [Data Persistence API](https://flueframework.com/docs/api/data-persistence-api/) for the adapter
contract.

## When to choose MySQL [\#](https://flueframework.com/docs/ecosystem/databases/mysql/\#when-to-choose-mysql)

Choose MySQL when your Node deployment already operates MySQL 8, or when
multiple replicas need durable shared agent and workflow state in an
InnoDB-backed database. For single-host persistence, file-backed `sqlite()` may
be simpler. Choose [`@flue/postgres`](https://flueframework.com/docs/ecosystem/databases/postgres/) when
Postgres is your existing operational standard, or
[`@flue/libsql`](https://flueframework.com/docs/ecosystem/databases/libsql/) for SQLite and libSQL
workloads.

## Docs Navigation

Current page: [MySQL](https://flueframework.com/docs/ecosystem/databases/mysql/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
