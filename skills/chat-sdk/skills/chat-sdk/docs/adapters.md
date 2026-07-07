> Source: https://chat-sdk.dev/docs/adapters.md

---
title: Overview
description: Overview of Chat SDK adapters and the static adapter catalog.
type: overview
prerequisites:
  - /docs/getting-started
---

# Overview


Adapters connect Chat SDK to messaging platforms and state backends. Install only the adapters you need, then register them on your `Chat` instance.

Use the dedicated guides for adapter-specific concepts:

* [Platform Adapters](/docs/platform-adapters) cover webhook verification, message parsing, API calls, feature support, and multi-platform bots.
* [State Adapters](/docs/state-adapters) cover subscriptions, distributed locking, and caching.
* Browse all official, vendor-official, and community adapters on the [Adapters](/adapters) listing page.

Ready to build your own? Follow the [building](/docs/contributing/building) guide.

## Adapter catalog (`chat/adapters`)

The `chat/adapters` subpath is a static catalog of official and vendor-official adapters. It imports no adapter packages, so you can use it from setup screens, build scripts, or onboarding flows without pulling in Slack, Teams, Redis, or other platform SDKs.

```typescript title="scripts/list-adapters.ts" lineNumbers
import { ADAPTER_NAMES, getAdapter } from "chat/adapters";

for (const slug of ADAPTER_NAMES) {
  const adapter = getAdapter(slug);
  console.log(adapter.name, adapter.packageName, adapter.peerDeps);
}
```

Use the env helpers when you need to show setup instructions or inject secrets for one adapter:

```typescript lineNumbers
import { getAdapter, getSecretEnvVars } from "chat/adapters";

const slack = getAdapter("slack");
const secrets = getSecretEnvVars("slack").map((envVar) => envVar.key);

console.log(slack.name, secrets);
```

The catalog intentionally covers official and vendor-official adapters. Community adapters live on the [Adapters](/adapters) listing page.

### Environment specs

Each adapter entry includes an `env` spec:

* `required` lists variables needed regardless of auth mode.
* `credentialModes` groups mutually exclusive ways to authenticate, such as a bot token vs OAuth client credentials.
* `optional` lists tuning variables that are safe to omit.
* `config` lists constructor options that do not have an environment-variable equivalent.

### Types

The main `CatalogAdapter` metadata shape is:


### Helpers

* `getAdapter(slug)` returns one catalog entry, or `undefined` for unknown slugs.
* `isAdapterSlug(slug)` narrows a string to `AdapterSlug`.
* `listEnvVars(slug)` flattens required, credential-mode, and optional env vars, de-duplicated by key.
* `getSecretEnvVars(slug)` returns the subset of `listEnvVars(slug)` marked as secrets.
