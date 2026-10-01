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

## Adapter tiers

| Tier            | Who maintains it           |
| --------------- | -------------------------- |
| Official        | Vercel (`@chat-adapter/*`) |
| Vendor-official | The platform vendor        |
| Community       | Third-party developers     |

Browse all three tiers on the [Adapters](/adapters) listing page. To ship your own, start with [Building an adapter](/docs/contributing/building), then list it as a [community](/docs/contributing/publishing#listing-on-chat-sdkdev) or [vendor-official](/docs/contributing/vendor-official) adapter.

Each kind of adapter has its own guide:

* [Platform Adapters](/docs/platform-adapters) covers webhook verification, message parsing, feature support by platform, and bots that run on several platforms.
* [State Adapters](/docs/state-adapters) covers subscriptions, distributed locking, and caching.

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

Community adapters aren't in the catalog. Find them on the [Adapters](/adapters) listing page.

### Environment specs

Each adapter entry includes an `env` spec:

* `required` lists variables needed regardless of auth mode.
* `credentialModes` groups mutually exclusive ways to authenticate, such as a bot token or OAuth client credentials.
* `optional` lists tuning variables that are safe to omit.
* `config` lists constructor options that do not have an environment-variable equivalent.

### Types

Each catalog entry is a `CatalogAdapter`:


`AdapterEnvSpec` describes the `env` field:


`EnvGroup` describes one credential mode:


`EnvVar` describes one environment variable:


### Helpers

* `getAdapter(slug)` returns one catalog entry, or `undefined` for unknown slugs.
* `isAdapterSlug(slug)` narrows a string to `AdapterSlug`.
* `listEnvVars(slug)` flattens required, credential-mode, and optional env vars, de-duplicated by key.
* `getSecretEnvVars(slug)` returns the subset of `listEnvVars(slug)` marked as secrets.


---

For a semantic overview of all documentation, see [/sitemap.md](/sitemap.md)

For an index of all available documentation, see [/llms.txt](/llms.txt)

For agent-facing discovery, including API and MCP surfaces, see [/agents.md](/agents.md)
