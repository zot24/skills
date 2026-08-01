> Source: https://flueframework.com/docs/ecosystem/databases/postgres

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Postgres


Last updated Jul 21, 2026<a href="/docs/ecosystem/databases/postgres/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a><a href="https://www.npmjs.com/package/@flue/postgres" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800" target="_blank" rel="noopener noreferrer">@flue/postgres</a>


## Quickstart

Add durable, shared Postgres persistence to an existing Flue project with the [Postgres](https://www.postgresql.org) blueprint. Run the following command in your terminal or coding agent of choice:

``` astro-code
flue add database postgres
```

## Overview

The Postgres blueprint installs `@flue/postgres` and reuses an existing Postgres driver, or adds `pg` and the matching `@types/pg` development dependency by default. It creates a source-root `db.ts` and updates existing environment documentation when the project has it. The default generated adapter uses a pool for ordinary queries and keeps each transaction on one checked-out connection:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { postgres } from &#39;@flue/postgres&#39;;
import { Pool } from &#39;pg&#39;;

const pool = new Pool({ connectionString: process.env.DATABASE_URL });

export default postgres({
  query: async (text, params) =&gt; (await pool.query(text, params)).rows,
  transaction: async (fn) =&gt; {
    const client = await pool.connect();
    try {
      await client.query(&#39;BEGIN&#39;);
      const result = await fn({
        query: async (text, params) =&gt; (await client.query(text, params)).rows,
      });
      await client.query(&#39;COMMIT&#39;);
      return result;
    } catch (error) {
      await client.query(&#39;ROLLBACK&#39;);
      throw error;
    } finally {
      client.release();
    }
  },
  close: () =&gt; pool.end(),
});</code></pre>
<figcaption><span>src/db.ts (abridged)</span></figcaption>
</figure>

Flue discovers the adapter at build time and wires it into the generated Node server. On startup, it creates or verifies the required `flue_*` tables. Canonical agent conversations, immutable attachments, and accepted submissions then survive process replacement. Replicas may share durable state, but each agent instance still requires one live Node owner; Postgres does not enable active-active same-instance execution. Application business data remains application-owned. The blueprint applies only to Node targets because Cloudflare deployments use Durable Object SQLite instead.

## Configure

| Variable       | Purpose                                                                                |
|----------------|----------------------------------------------------------------------------------------|
| `DATABASE_URL` | **Required** — Postgres connection string, e.g. `postgresql://user:pass@host:5432/db`. |

Your driver reads `DATABASE_URL` at runtime — it is not baked into the build. For local development, `vite dev` loads the project `.env`, and `flue run --env <file>` selects an alternate `.env`-format file. In production, supply it from your platform’s secret store.

The blueprint installs `@flue/postgres` with `pg` by default and writes a source-root `db.ts` that wraps it. Flue discovers `db.ts` at build time and wires it into the generated Node server. After running the command, canonical agent conversations, immutable attachments, and accepted submissions persist to Postgres instead of in-memory state.

`@flue/postgres` is a **Node.js** adapter. The Cloudflare target uses Durable Object SQLite automatically and rejects a `db.ts` file at build time, so this guide applies to Node deployments. See [Database](/docs/guide/database/) for the full picture of how state is stored on each target.

## Bring your own driver

`@flue/postgres` does not pick or bundle a database driver. It runs against a small runner you wrap around your configured driver, so you own driver choice, pooling, TLS, and every other connection option. A runner is three functions: `query` (a SQL string with numbered `$N` placeholders plus positional params, resolving to result rows), `transaction` (runs its callback inside one transaction on a single connection), and `close`.

With [`pg`](https://node-postgres.com/) (node-postgres), `transaction` checks out a single client and issues `BEGIN`/`COMMIT`/`ROLLBACK` itself — a pool cannot run a transaction across arbitrary connections:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="ts"><code>import { postgres } from &#39;@flue/postgres&#39;;
import { Pool } from &#39;pg&#39;;

const pool = new Pool({ connectionString: process.env.DATABASE_URL });

export default postgres({
  query: async (text, params) =&gt; (await pool.query(text, params)).rows,
  transaction: async (fn) =&gt; {
    const client = await pool.connect();
    // ...
  },
  close: () =&gt; pool.end(),
});</code></pre>
<figcaption><span>src/db.ts</span></figcaption>
</figure>

The same seam adapts drivers that support interactive transactions on one connection. For Neon, use its WebSocket `Pool`; the HTTP query client cannot implement this callback transaction contract.

## Migrations

The adapter’s `migrate()` hook runs automatically when the generated Node server starts. It creates Flue’s `flue_*` tables idempotently and stamps a format version, so a fresh database is provisioned on first boot and an existing one is reused on restart. There is no separate migration command to run, and a database written by a newer Flue refuses to start rather than corrupting state.

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
- application-owned business data, unless your own tools store it;
- provider credentials or secrets.

The submission rows are what make accepted work recoverable after an interruption. See [Durability](/docs/guide/durability/) for how recovery uses them, and the [Data Persistence API](/docs/reference/data-persistence-api/) for the exact adapter contract.

## When to choose Postgres

| Use case                                                       | Adapter                                                       |
|----------------------------------------------------------------|---------------------------------------------------------------|
| Local development, or restart persistence is unnecessary       | `sqlite()` from `@flue/runtime/node` (file path or in-memory) |
| Single-host Node deployment                                    | File-backed `sqlite()`                                        |
| Multi-replica Node deployment, or state must survive host loss | `@flue/postgres`, with one live owner per agent instance      |
| Cloudflare deployment                                          | Built-in Durable Object SQLite (no `db.ts`)                   |

Choose Postgres when a replacement process must recover accepted work, when replicas need shared conversation state, or when a single host’s disk is not a durable enough home for state. Keep one live owner for each agent instance and use instance-affine routing across replicas. Managed Postgres pairs naturally with the container deploy targets — see [Deploy on AWS](/docs/ecosystem/deploy/aws/) for RDS, and the other [deploy guides](/docs/ecosystem/deploy/node/) for provisioning a database alongside the server.


## Docs Navigation

Current page: [Postgres](/docs/ecosystem/databases/postgres/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


