<!-- Source: https://flueframework.com/docs/api/provider-api -->

The provider API configures model connection paths at runtime. Import ordinary provider APIs from `@flue/runtime`. For model selection, authentication setup, and Workers AI examples, see [Models & Providers](https://flueframework.com/docs/guide/models/).

## Imports [\#](https://flueframework.com/docs/api/provider-api/\#imports)

```
import {
  registerApiProvider,
  registerProvider,
  type HttpProviderRegistration,
  type ProviderRegistration,
} from '@flue/runtime';
```

## `registerProvider()` [\#](https://flueframework.com/docs/api/provider-api/\#registerprovider)

```
function registerProvider(providerId: string, registration: ProviderRegistration): void;
```

Registers a model provider keyed by the provider ID used in model specifiers. The provider ID is the prefix used in model specifiers, such as `anthropic` in `anthropic/claude-sonnet-4-6`.

When the provider ID is a catalog provider, models resolve from the catalog — preserving metadata such as cost, context window, and wire protocol — with this call’s options layered on top. That makes routing a built-in provider through a gateway one call:

```
registerProvider('anthropic', {
  baseUrl: 'https://gateway.example.com/anthropic',
  apiKey: process.env.GATEWAY_KEY,
});
```

Provider IDs the catalog doesn’t know are registered from scratch and must supply `api` and `baseUrl`. For example, registering `ollama` makes model specifiers such as `ollama/llama3.1:8b` available to agents and operations:

```
registerProvider('ollama', {
  api: 'openai-completions',
  baseUrl: 'http://localhost:11434/v1',
});
```

Each call replaces the provider ID’s previous registration; calls do not accumulate. The effective settings are always the catalog defaults (when the ID is known) plus the latest call’s options.

### `ProviderRegistration` [\#](https://flueframework.com/docs/api/provider-api/\#providerregistration)

```
type ProviderRegistration = HttpProviderRegistration | CloudflareAIBindingRegistration;
```

Use an HTTP registration for ordinary URL-backed providers. Workers AI binding registrations are Cloudflare-specific and described below.

### `HttpProviderRegistration` [\#](https://flueframework.com/docs/api/provider-api/\#httpproviderregistration)

```
interface HttpProviderRegistration {
  api?: Api;
  baseUrl?: string;
  apiKey?: string;
  headers?: Record<string, string>;
  contextWindow?: number;
  maxTokens?: number;
  models?: Record<
    string,
    {
      contextWindow?: number;
      maxTokens?: number;
    }
  >;
  storeResponses?: boolean;
}
```

| Property | Purpose |
| --- | --- |
| `api` | Wire protocol used for requests. Use a Pi-provided API slug or register one with `registerApiProvider()`. Required for non-catalog provider IDs; defaults to the catalog protocol. |
| `baseUrl` | Endpoint root, such as `https://api.anthropic.com/v1`. Required for non-catalog provider IDs; defaults to the catalog endpoint. |
| `apiKey` | Optional API key. When omitted, the underlying provider integration may use its normal environment-variable lookup. |
| `headers` | Headers sent on outgoing requests. Merged per key over the catalog model’s headers when the provider ID hydrates from the catalog; the registration’s values win on conflict. |
| `contextWindow` | Default context-window size for models resolved through this registration. Falls back to the catalog value for catalog models, then to `0`, meaning unknown. |
| `maxTokens` | Default output-token limit for models resolved through this registration. Falls back to the catalog value for catalog models, then to `0`. |
| `models` | Per-model `contextWindow` and `maxTokens` overrides keyed by model ID. Per-model values override provider-level defaults. |
| `storeResponses` | Send `store: true` for OpenAI Responses API providers. Enable only when your application accepts the provider’s retention policy. |

Registering a non-catalog provider ID without `api` and `baseUrl` throws a `ProviderRegistrationError`.

## `registerApiProvider()` [\#](https://flueframework.com/docs/api/provider-api/\#registerapiprovider)

```
const registerApiProvider: typeof import('@earendil-works/pi-ai').registerApiProvider;
```

Registers a wire-protocol handler for an API slug not shipped by Pi. Register the protocol first, then pass its `api` slug to `registerProvider()`.

Pi’s API-provider registry is module-scoped and last-write-wins. Registering the same API slug again replaces the previous handler.

## Cloudflare binding registrations [\#](https://flueframework.com/docs/api/provider-api/\#cloudflare-binding-registrations)

Import Workers AI binding registration types from `@flue/runtime/cloudflare`:

```
import {
  type CloudflareAIBinding,
  type CloudflareAIBindingRegistration,
  type CloudflareGatewayOptions,
} from '@flue/runtime/cloudflare';
```

`CloudflareAIBindingRegistration` registers a provider backed by an `env.AI` Workers AI binding instead of an HTTP endpoint. Its optional `gateway` setting forwards AI Gateway options to each `env.AI.run(...)` call; set `gateway: false` to omit the gateway option.

Cloudflare builds register the `cloudflare` provider ID automatically unless `app.ts` registers it first. Register that provider ID in `app.ts` when you intentionally want an authored binding registration to take precedence over the generated default. See [Cloudflare Workers AI](https://flueframework.com/docs/guide/models/#cloudflare-workers-ai-cloudflare-only) for setup and gateway examples.

## Docs Navigation

Current page: [Provider API](https://flueframework.com/docs/api/provider-api/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
