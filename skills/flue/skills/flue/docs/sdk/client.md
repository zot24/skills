> Source: https://flueframework.com/docs/sdk/client

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# createFlueClient(...)


AI-generated, awaiting review <a href="/docs/sdk/client/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


``` astro-code
import { createFlueClient } from '@flue/sdk';

const client = createFlueClient({
  baseUrl: 'https://example.com/api',
  token: process.env.FLUE_TOKEN,
});
```

In a browser, `baseUrl` may be relative to `location.origin`. This is the usual same-origin setup:

``` astro-code
const client = createFlueClient({ baseUrl: '/api' });
```

Outside a browser, `baseUrl` must be absolute; a relative value throws an error.

## `createFlueClient(...)`

``` astro-code
function createFlueClient(options: CreateFlueClientOptions): FlueClient;
```

Creates a client for the public routes of a deployed Flue application.

## `CreateFlueClientOptions`

| Field     | Type             | Default        | Description                                                                                                       |
|-----------|------------------|----------------|-------------------------------------------------------------------------------------------------------------------|
| `baseUrl` | `string`         | —              | URL where the public `flue()` sub-app is mounted, including any pathname. Browser clients may use a relative URL. |
| `fetch`   | `typeof fetch`   | global `fetch` | Custom HTTP implementation. Also used for Durable Streams event streaming.                                        |
| `headers` | `RequestHeaders` | —              | Headers merged into each HTTP and stream request.                                                                 |
| `token`   | `string`         | —              | Bearer token added to HTTP and stream requests.                                                                   |

## `RequestHeaders`

``` astro-code
type RequestHeaders =
  | Record<string, string>
  | (() => Record<string, string> | Promise<Record<string, string>>);
```

Use a function to resolve headers separately for each HTTP request and stream reconnection.


## Docs Navigation

Current page: [createFlueClient(...)](/docs/sdk/client/)

### Sections

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


