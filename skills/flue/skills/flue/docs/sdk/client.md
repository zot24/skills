<!-- Source: https://flueframework.com/docs/sdk/client -->

```
import { createFlueClient } from '@flue/sdk';

const client = createFlueClient({
  baseUrl: 'https://example.com/api',
  token: process.env.FLUE_TOKEN,
});
```

In a browser, `baseUrl` may be relative to `location.origin`. This is the usual same-origin setup:

```
const client = createFlueClient({ baseUrl: '/api' });
```

Outside a browser, `baseUrl` must be absolute; a relative value throws an error.

## `createFlueClient(...)` [\#](https://flueframework.com/docs/sdk/client/\#createflueclient)

```
function createFlueClient(options: CreateFlueClientOptions): FlueClient;
```

Creates a client for the public routes of a deployed Flue application.

## `CreateFlueClientOptions` [\#](https://flueframework.com/docs/sdk/client/\#createflueclientoptions)

| Field | Type | Default | Description |
| --- | --- | --- | --- |
| `baseUrl` | `string` | — | URL where the public `flue()` sub-app is mounted, including any pathname. Browser clients may use a relative URL. |
| `fetch` | `typeof fetch` | global `fetch` | Custom HTTP implementation. Also used for Durable Streams event streaming. |
| `headers` | `RequestHeaders` | — | Headers merged into each HTTP and stream request. |
| `token` | `string` | — | Bearer token added to HTTP and stream requests. |

## `RequestHeaders` [\#](https://flueframework.com/docs/sdk/client/\#requestheaders)

```
type RequestHeaders =
  | Record<string, string>
  | (() => Record<string, string> | Promise<Record<string, string>>);
```

Use a function to resolve headers separately for each HTTP request and stream reconnection.

## Docs Navigation

Current page: [createFlueClient(...)](https://flueframework.com/docs/sdk/client/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
