<!-- Source: https://flueframework.com/docs/sdk/overview -->

The client SDK is exported from `@flue/sdk`. Use it from applications that consume deployed Flue agents and workflows.

```
import { createFlueClient } from '@flue/sdk';

const client = createFlueClient({
  baseUrl: 'https://example.com/api',
  token: process.env.FLUE_TOKEN,
});
```

## Client [\#](https://flueframework.com/docs/sdk/overview/\#client)

[`createFlueClient(...)`](https://flueframework.com/docs/sdk/client/) configures access to a deployed Flue application.

## API namespaces [\#](https://flueframework.com/docs/sdk/overview/\#api-namespaces)

- [`client.agents`](https://flueframework.com/docs/sdk/agents/) invokes persistent agent instances and streams their events.
- [`client.workflows`](https://flueframework.com/docs/sdk/workflows/) starts workflow runs.
- [`client.runs`](https://flueframework.com/docs/sdk/runs/) inspects and streams workflow runs.

Deployment-wide listing (all runs, all agents) is a server-side concern: compose your own endpoints from the `listRuns()`, `getRun()`, and `listAgents()` primitives exported by `@flue/runtime`. See [compose your own admin endpoints](https://flueframework.com/docs/api/routing-api/#compose-your-own-admin-endpoints).

## Shared types [\#](https://flueframework.com/docs/sdk/overview/\#shared-types)

- [Events and records](https://flueframework.com/docs/sdk/events/) describes observable events, records, and normalized model-turn data.
- [Errors](https://flueframework.com/docs/sdk/errors/) describes HTTP and stream errors.

## Docs Navigation

Current page: [SDK overview](https://flueframework.com/docs/sdk/overview/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
