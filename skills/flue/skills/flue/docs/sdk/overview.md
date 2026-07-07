> Source: https://flueframework.com/docs/sdk/overview



# SDK overview


Last updated Jun 20, 2026 <a href="/docs/sdk/overview/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


The client SDK is exported from `@flue/sdk`. Use it from applications that consume deployed Flue agents and workflows.

``` astro-code
import { createFlueClient } from '@flue/sdk';

const client = createFlueClient({
  baseUrl: 'https://example.com/api',
  token: process.env.FLUE_TOKEN,
});
```

## Client

[`createFlueClient(...)`](/docs/sdk/client/) configures access to a deployed Flue application.

## API namespaces

- [`client.agents`](/docs/sdk/agents/) invokes persistent agent instances and streams their events.
- [`client.workflows`](/docs/sdk/workflows/) starts workflow runs.
- [`client.runs`](/docs/sdk/runs/) inspects and streams runs exposed by their owning workflows.

Deployment-wide listing (all runs, all agents) is a server-side concern: compose your own endpoints from the `listRuns()`, `getRun()`, and `listAgents()` primitives exported by `@flue/runtime`. See [compose your own admin endpoints](/docs/api/routing-api/#compose-your-own-admin-endpoints).

## Shared types

- [Events and records](/docs/sdk/events/) describes observable events, records, and normalized model-turn data.
- [Errors](/docs/sdk/errors/) describes HTTP and stream errors.


## Docs Navigation

Current page: [SDK overview](/docs/sdk/overview/)

### Sections

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


