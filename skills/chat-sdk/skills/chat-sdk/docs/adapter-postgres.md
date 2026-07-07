> Source: https://chat-sdk.dev/adapters/official/postgres.md

---
title: PostgreSQL
description: Production state adapter using PostgreSQL via node-postgres.
tagline: Production state adapter for Chat SDK built on `pg` (node-postgres). Use this when PostgreSQL is your primary datastore and you don't want a separate Redis.
package: @chat-adapter/state-pg
---

# PostgreSQL


## Install


## Quick start


  The adapter auto-detects `POSTGRES_URL` (or `DATABASE_URL`) from the environment.


```typescript title="lib/bot.ts" lineNumbers
import { Chat } from "chat";
import { createPostgresState } from "@chat-adapter/state-pg";

const bot = new Chat({
  userName: "mybot",
  adapters: { /* ... */ },
  state: createPostgresState(),
});
```

The adapter creates its tables on `connect()` if they don't already exist.

## Configuration


Either `url`, `POSTGRES_URL`/`DATABASE_URL`, or `client` is required.

## Advanced

### Using an existing pool

```typescript title="lib/state.ts" lineNumbers
import pg from "pg";
import { createPostgresState } from "@chat-adapter/state-pg";

const client = new pg.Pool({ connectionString: process.env.POSTGRES_URL! });
export const state = createPostgresState({ client });
```

### Data model

The following tables are created on first connect:

```
chat_state_subscriptions
chat_state_locks
chat_state_cache
chat_state_lists
chat_state_queues
```

All rows are namespaced by `key_prefix`.

### Locking under high contention

The Redis adapters use atomic `SET NX PX` for lock acquisition. The Postgres adapter uses `INSERT ... ON CONFLICT DO UPDATE WHERE expires_at <= now()`, relying on row-level locking. Safe for typical workloads, but under extreme contention prefer a Redis adapter.

### Expired row cleanup

Postgres does not delete expired rows automatically. The adapter cleans up opportunistically — expired locks are overwritten on the next `acquireLock()`, expired cache entries are deleted on the next `get()`, and so on. For high-throughput deployments, run a periodic job:

```sql
DELETE FROM chat_state_locks WHERE expires_at <= now();
DELETE FROM chat_state_cache WHERE expires_at <= now();
DELETE FROM chat_state_lists WHERE expires_at <= now();
DELETE FROM chat_state_queues WHERE expires_at <= now();
```

## Feature support


