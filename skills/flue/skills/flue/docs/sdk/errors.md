> Source: https://flueframework.com/docs/sdk/errors



# Errors


AI-generated, awaiting review <a href="/docs/sdk/errors/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


See [Errors Reference](/docs/api/errors-reference/) for shared transport envelopes and stable public error categories.

## `FlueApiError`

``` astro-code
class FlueApiError extends Error {
  readonly status: number;
  readonly body: unknown;
}
```

Failed SDK HTTP JSON request. `status` is the HTTP response status. `body` is the parsed response body when available, or the response text otherwise. Framework-owned routes normally return `{ error: FluePublicError }`; application-owned middleware may return arbitrary bodies.

## `FluePublicError`

``` astro-code
interface FluePublicError {
  type: string;
  message: string;
  details: string;
  dev?: string;
  meta?: Record<string, unknown>;
}
```

Structured server error data used by transport error responses.

## Stream errors

`stream()` and `events()` reads are backed by [`@durable-streams/client`](https://www.npmjs.com/package/@durable-streams/client), and stream failures surface as that package’s error classes. The SDK re-exports the ones reachable through its read paths so you can `instanceof`-match them without installing the package yourself. Their shapes are owned by `@durable-streams/client` and track its releases.

### `DurableStreamError`

``` astro-code
class DurableStreamError extends Error {
  status?: number;
  code: string;
  details?: unknown;
}
```

Protocol-level stream failure. `code` is a structured error code for programmatic handling (for example `NOT_FOUND` for a missing stream, `BAD_REQUEST` for invalid parameters); `status` is the HTTP status when applicable.

### `StreamClosedError`

``` astro-code
class StreamClosedError extends DurableStreamError {
  readonly code: 'STREAM_CLOSED';
  readonly status: 409;
  readonly finalOffset?: string;
}
```

The stream was closed. `finalOffset` is the stream’s final offset when the server reports it.

### `FetchError`

``` astro-code
class FetchError extends Error {
  url: string;
  status: number;
  text?: string;
  json?: object;
  headers: Record<string, string>;
}
```

Transport-level HTTP failure during a stream read.

### `FetchBackoffAbortError`

``` astro-code
class FetchBackoffAbortError extends Error {}
```

A stream request was aborted while waiting to retry.


## Docs Navigation

Current page: [Errors](/docs/sdk/errors/)

### Sections

- [Guide](/docs/getting-started/quickstart/)
- [Reference](/docs/api/agent-api/)
- [CLI](/docs/cli/overview/)
- [SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


