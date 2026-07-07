> Source: https://chat-sdk.dev/adapters/official/redis.md

---
title: Redis
description: Production state adapter using the official `redis` package.
tagline: Production state adapter for Chat SDK using the official `redis` client. Persistence, distributed locking, and caching out of the box.
package: @chat-adapter/state-redis
---

# Redis


## Install


## Quick start


  The adapter auto-detects `REDIS_URL` from the environment.


```typescript title="lib/bot.ts" lineNumbers
import { Chat } from "chat";
import { createRedisState } from "@chat-adapter/state-redis";

const bot = new Chat({
  userName: "mybot",
  adapters: { /* ... */ },
  state: createRedisState(),
});
```

## Configuration


Either `url`, the `REDIS_URL` env var, or `client` is required.

## Advanced

### Using an existing client

```typescript title="lib/state.ts" lineNumbers
import { createClient } from "redis";
import { createRedisState } from "@chat-adapter/state-redis";

const client = createClient({ url: "redis://localhost:6379" });
await client.connect();

export const state = createRedisState({ client });
```

### Custom key prefix

All keys are namespaced under `keyPrefix` (default: `"chat-sdk"`):

```typescript
createRedisState({
  url: process.env.REDIS_URL!,
  keyPrefix: "my-bot",
});
```

### Key structure

```
{keyPrefix}:subscriptions     - SET of subscribed thread IDs
{keyPrefix}:lock:{threadId}   - Lock key with TTL
```

### Production recommendations

* Run Redis 6.0+ for best performance.
* Enable persistence (RDB or AOF).
* Use Redis Cluster for high availability.
* Set explicit memory limits.

For serverless deployments (Vercel, AWS Lambda), use a serverless-compatible Redis provider like [Upstash](https://upstash.com).

## Feature support


