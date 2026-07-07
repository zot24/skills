> Source: https://chat-sdk.dev/adapters/official/ioredis.md

---
title: ioredis
description: Redis state adapter using ioredis with Cluster and Sentinel support.
tagline: Alternative Redis state adapter for Chat SDK built on ioredis — use this if you already depend on ioredis or need Cluster/Sentinel support.
package: @chat-adapter/state-ioredis
---

# ioredis


## Install

<PackageInstall package="@chat-adapter/state-ioredis" />

## Quick start

```typescript title="lib/bot.ts" lineNumbers


const bot = new Chat({
  userName: "mybot",
  adapters: { /* ... */ },
  state: createIoRedisState({ url: process.env.REDIS_URL! }),
});
```

## Configuration

<TypeTable
  type={{
  url: {
    type: "string",
    description: "Redis connection URL. Required if `client` is not provided.",
  },
  client: {
    type: "Redis",
    description:
      "An existing `ioredis` client instance. Use this for Cluster, Sentinel, or shared connection setups.",
  },
  keyPrefix: {
    type: "string",
    default: '"chat-sdk"',
    description: "Prefix applied to every key written by the adapter.",
  },
}}
/>

Either `url` or `client` is required.

## Advanced

### Using an existing client

```typescript title="lib/state.ts" lineNumbers


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

<FeatureSupport />
