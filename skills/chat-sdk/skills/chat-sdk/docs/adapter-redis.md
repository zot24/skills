> Source: https://chat-sdk.dev/adapters/official/redis.md

---
title: Redis
description: Production state adapter using the official `redis` package.
tagline: Production state adapter for Chat SDK using the official `redis` client. Persistence, distributed locking, and caching out of the box.
package: @chat-adapter/state-redis
---

# Redis


## Install

<PackageInstall package="@chat-adapter/state-redis" />

## Quick start

<Callout type="info">
  The adapter auto-detects `REDIS_URL` from the environment.
</Callout>

```typescript title="lib/bot.ts" lineNumbers


const bot = new Chat({
  userName: "mybot",
  adapters: { /* ... */ },
  state: createRedisState(),
});
```

## Configuration

<TypeTable
  type={{
  url: {
    type: "string",
    description:
      "Redis connection URL. Auto-detected from `REDIS_URL` if not provided.",
  },
  client: {
    type: "RedisClient",
    description:
      "An existing `redis` client instance. Use this if you already manage the connection elsewhere.",
  },
  keyPrefix: {
    type: "string",
    default: '"chat-sdk"',
    description: "Prefix applied to every key written by the adapter.",
  },
  logger: {
    type: "Logger",
    description:
      "Logger instance. Defaults to `ConsoleLogger(\"info\")`.",
  },
}}
/>

Either `url`, the `REDIS_URL` env var, or `client` is required.

## Advanced

### Using an existing client

```typescript title="lib/state.ts" lineNumbers


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

<FeatureSupport />
