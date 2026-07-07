> Source: https://chat-sdk.dev/adapters/official/ioredis.md

---
title: ioredis
description: Redis state adapter using ioredis with Cluster and Sentinel support.
tagline: Alternative Redis state adapter for Chat SDK built on ioredis — use this if you already depend on ioredis or need Cluster/Sentinel support.
package: @chat-adapter/state-ioredis
---

# ioredis


## Install


## Quick start

```typescript title="lib/bot.ts" lineNumbers
import { Chat } from "chat";
import { createIoRedisState } from "@chat-adapter/state-ioredis";

const bot = new Chat({
  userName: "mybot",
  adapters: { /* ... */ },
  state: createIoRedisState({ url: process.env.REDIS_URL! }),
});
```

## Configuration


Either `url` or `client` is required.

## Advanced

### Using an existing client

```typescript title="lib/state.ts" lineNumbers
import Redis from "ioredis";
import { createIoRedisState } from "@chat-adapter/state-ioredis";

const client = new Redis("redis://localhost:6379");

export const state = createIoRedisState({ client });
```

### When to choose ioredis vs redis

Use [`@chat-adapter/state-ioredis`](/adapters/official/ioredis) when:

* You already use ioredis in your project.
* You need Redis Cluster support.
* You need Redis Sentinel support.
* You prefer the ioredis API.

Use [`@chat-adapter/state-redis`](/adapters/official/redis) when:

* You want the official Redis client.
* You're starting a new project.
* You don't need Cluster or Sentinel.

### Key structure

```
{keyPrefix}:subscriptions     - SET of subscribed thread IDs
{keyPrefix}:lock:{threadId}   - Lock key with TTL
```

## Feature support


