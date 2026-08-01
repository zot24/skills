> Source: https://flueframework.com/docs/ecosystem/databases/mysql

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# MySQL


Last updated Jul 21, 2026<a href="/docs/ecosystem/databases/mysql/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a><a href="https://www.npmjs.com/package/@flue/mysql" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800" target="_blank" rel="noopener noreferrer">@flue/mysql</a>


## Quickstart

Add durable, shared MySQL persistence to an existing Flue project with the [MySQL](https://www.mysql.com) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add database mysql
```

## Overview

The MySQL blueprint installs `@flue/mysql` and `mysql2` and creates a source-root `db.ts`. The generated adapter uses a pool for ordinary queries and keeps each transaction on one checked-out connection:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { mysql, type MysqlQuery } from &#39;@flue/mysql&#39;;
import mysql2 from &#39;mysql2/promise&#39;;

const pool = mysql2.createPool(process.env.MYSQL_URL!);

const toRows = (result: unknown): Record&lt;string, unknown&gt;[] =&gt;
  Array.isArray(result) ? result.map((row) =&gt; ({ ...row })) : [];

export default mysql({
  query: async (text, params = []) =&gt; {
    const [result] = await pool.execute(text, params);
    return toRows(result);
  },
  transaction: async &lt;T&gt;(fn: (tx: { query: MysqlQuery }) =&gt; Promise&lt;T&gt;) =&gt; {
    const connection = await pool.getConnection();
    await connection.beginTransaction();
    // ...
  },
  close: () =&gt; pool.end(),
});</code></pre>
<figcaption><span>src/db.ts (abridged)</span></figcaption>
</figure>

Flue discovers the adapter at build time and wires it into the generated Node server. On startup, it creates and verifies the required MySQL 8 InnoDB tables. Canonical agent conversations, immutable attachments, and accepted submissions then survive process replacement. Replicas may share durable state, but each agent instance still requires one live Node owner. Application business data remains application-owned. The blueprint applies only to Node targets because Cloudflare deployments use Durable Object SQLite instead.

## Configure

| Variable    | Purpose                                                                     |
|-------------|-----------------------------------------------------------------------------|
| `MYSQL_URL` | **Required** — MySQL connection string, supplied by your database provider. |

The driver reads this value at runtime. Supply it through your platform’s secret store, never commit it, and configure `mysql2` TLS options when your provider requires them. For local development, `vite dev` loads the project `.env`, and `flue run --env <file>` loads any `.env`-format file.

The blueprint installs `@flue/mysql` and `mysql2`, then writes a source-root `db.ts`. Flue discovers that file at build time and wires it into the generated Node server.

`@flue/mysql` supports **MySQL 8 with InnoDB** on the **Node.js target**. The Cloudflare target uses Durable Object SQLite automatically and rejects `db.ts` at build time. See [Database](/docs/guide/database/) for persistence by target.

## Bring your own driver

`@flue/mysql` does not bundle a production driver. It accepts a runner so your application owns pooling, TLS, credentials, and connection lifecycle. The canonical `mysql2` runner uses `pool.execute()` for normal queries and one checked-out connection for each callback transaction:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { mysql, type MysqlQuery } from &#39;@flue/mysql&#39;;
import mysql2 from &#39;mysql2/promise&#39;;

const pool = mysql2.createPool(process.env.MYSQL_URL!);

const toRows = (result: unknown): Record&lt;string, unknown&gt;[] =&gt;
  Array.isArray(result) ? result.map((row) =&gt; ({ ...row })) : [];

export default mysql({
  query: async (text, params = []) =&gt; {
    const [result] = await pool.execute(text, params);
    return toRows(result);
  },
  transaction: async &lt;T&gt;(fn: (tx: { query: MysqlQuery }) =&gt; Promise&lt;T&gt;) =&gt; {
    const connection = await pool.getConnection();
    try {
      await connection.beginTransaction();
      const result = await fn({
        query: async (text, params = []) =&gt; {
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
  close: () =&gt; pool.end(),
});</code></pre>
<figcaption><span>src/db.ts</span></figcaption>
</figure>

The runner uses `?` placeholders and returns plain row objects. Every query in a transaction callback must use the checked-out connection; issuing those calls through the pool could move work onto another connection and outside the transaction.

## Migrations

The adapter’s `migrate()` hook runs automatically when the generated Node server starts. It creates Flue’s `flue_*` tables idempotently, verifies the complete schema, and then stamps its version. All transactional tables use InnoDB. There is no separate migration command, and a database written by a newer Flue version refuses to start rather than risking incompatible writes.

## What gets stored

A Flue database stores runtime state, not your whole application.

Stored by Flue:

- canonical agent conversation streams and compaction records;
- immutable attachment payloads;
- accepted direct prompts and `dispatch(...)` submissions;
- durable submission claims, leases, and settlement records.

Not stored by Flue:

- sandbox files and installed dependencies;
- external API side effects;
- application-owned business data;
- provider credentials or secrets.

See [Durability](/docs/guide/durability/) for recovery behavior and the [Data Persistence API](/docs/reference/data-persistence-api/) for the adapter contract.

## When to choose MySQL

Choose MySQL when your Node deployment already operates MySQL 8, or when replacement processes and multiple replicas need durable agent state in an InnoDB-backed database. Preserve one live owner per agent instance. For single-host persistence, file-backed `sqlite()` may be simpler. Choose [`@flue/postgres`](/docs/ecosystem/databases/postgres/) when Postgres is your existing operational standard, or [`@flue/libsql`](/docs/ecosystem/databases/libsql/) for SQLite and libSQL workloads.


## Docs Navigation

Current page: [MySQL](/docs/ecosystem/databases/mysql/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


