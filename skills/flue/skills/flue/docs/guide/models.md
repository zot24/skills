<!-- Source: https://flueframework.com/docs/guide/models -->

Models determine what kind of work an agent can perform. Providers determine how your application reaches those models, authenticates its requests, and applies any transport-specific configuration.

This guide covers model selection and provider setup. For configuring addressable agents, see [Agents](https://flueframework.com/docs/guide/building-agents/). For running model-driven work inside finite orchestration, see [Workflows](https://flueframework.com/docs/guide/workflows/). For provider registration signatures, see the [Provider API](https://flueframework.com/docs/api/provider-api/). For operation inputs and results, see the [Agent API](https://flueframework.com/docs/api/agent-api/).

## Model specifier [\#](https://flueframework.com/docs/guide/models/\#model-specifier)

A model specifier is the unique string Flue uses to refer to a specific model across providers. It combines a provider ID, such as `anthropic`, `cloudflare`, `openai`, or `openrouter`, with a model ID recognized by that provider:

| Model specifier | Provider ID | Model ID |
| --- | --- | --- |
| `anthropic/claude-sonnet-4-6` | `anthropic` | `claude-sonnet-4-6` |
| `openai/gpt-5.5` | `openai` | `gpt-5.5` |
| `openrouter/moonshotai/kimi-k2.6` | `openrouter` | `moonshotai/kimi-k2.6` |
| `cloudflare/@cf/moonshotai/kimi-k2.6` | `cloudflare` | `@cf/moonshotai/kimi-k2.6` |
| `cloudflare/openai/gpt-5.5` | `cloudflare` | `openai/gpt-5.5` |

Use a model specifier to choose an agent’s default model:

```
import { createAgent } from '@flue/runtime';

export default createAgent(() => ({
  model: 'anthropic/claude-sonnet-4-6',
}));
```

Model specifiers can also be supplied by reusable profiles and subagents, or used to override the default model for an individual prompt, skill, or task operation. Responses report the selected model as `{ provider, id }`, preserving the provider ID and model ID from this specifier. See [Agents](https://flueframework.com/docs/guide/building-agents/), [Subagents](https://flueframework.com/docs/guide/subagents/), and the [Agent API](https://flueframework.com/docs/api/agent-api/) for those API-specific behaviors.

## Model reasoning effort [\#](https://flueframework.com/docs/guide/models/\#model-reasoning-effort)

Reasoning effort controls how much additional reasoning Flue requests from a model. Set it with `thinkingLevel`, using one of the supported levels:

| Value | Intent |
| --- | --- |
| `'off'` | Do not request additional reasoning. |
| `'minimal'` | Request the smallest reasoning effort. |
| `'low'` | Favor lower reasoning cost or latency. |
| `'medium'` | Balance reasoning effort and cost. This is Flue’s default. |
| `'high'` | Favor more careful reasoning. |
| `'xhigh'` | Request the highest exposed effort tier. |

Set the ordinary reasoning effort for an agent alongside its model:

```
import { createAgent } from '@flue/runtime';

export default createAgent(() => ({
  model: 'anthropic/claude-sonnet-4-6',
  thinkingLevel: 'high',
}));
```

Like a model specifier, `thinkingLevel` can be supplied by a reusable profile or overridden for an individual prompt, skill, or task operation. If no level is configured, Flue uses `'medium'`.

Reasoning support depends on both the selected model and its provider integration. When that path supports `thinkingLevel`, Flue passes your selected level through; unsupported paths ignore the setting, as noted for Workers AI bindings below.

## Providers [\#](https://flueframework.com/docs/guide/models/\#providers)

A provider is the service through which Flue reaches a model. A model may be available from more than one provider: for example, an Anthropic model may be accessed through Anthropic itself or through a gateway such as OpenRouter. The provider ID in a model specifier identifies that connection path, including its available models, authentication, billing, and transport behavior. Flue preserves this selected provider ID when reporting the model used for an operation.

### Authentication [\#](https://flueframework.com/docs/guide/models/\#authentication)

Most hosted providers require credentials before they will accept model requests. Flue uses the provider integrations from [Pi](https://pi.dev/docs/latest/providers), including their standard environment-variable conventions. For built-in providers, making the expected credential available to your running application is normally all that is required:

| Provider ID | Environment variable |
| --- | --- |
| `anthropic` | `ANTHROPIC_API_KEY` |
| `openai` | `OPENAI_API_KEY` |
| `openrouter` | `OPENROUTER_API_KEY` |

Keep credential values out of agent modules and committed configuration files. `flue build`, `flue dev`, `flue run`, and `flue connect` load project-root `.env` before configuration, with `--env` available to select one alternate file. During Cloudflare development, Worker runtime variables continue to use `.env` or `.dev.vars` through Workers tooling. See [Configuration](https://flueframework.com/docs/reference/configuration/) for details.

Some provider paths authenticate through their platform integration instead of a model-provider API key. In particular, the binding-backed `cloudflare/...` provider uses your Worker’s `AI` binding, as described in [Cloudflare Workers AI](https://flueframework.com/docs/guide/models/#cloudflare-workers-ai-cloudflare-only).

### Built-in providers [\#](https://flueframework.com/docs/guide/models/\#built-in-providers)

Flue includes Pi’s catalog-backed providers and models. To use a built-in provider, choose one of its supported model specifiers and make its required credentials available at runtime; you do not need to register the provider in application code.

See Pi’s [provider documentation](https://pi.dev/docs/latest/providers) for the built-in providers, their supported authentication variables, and their model catalog.

### Cloudflare providers [\#](https://flueframework.com/docs/guide/models/\#cloudflare-providers)

Cloudflare provides several ways to reach models from a Flue application. Choose the provider ID that matches how you want calls to be executed:

- `cloudflare/...` uses Flue’s Workers AI binding integration. It requires the Cloudflare target and an `AI` binding, and is covered in [Cloudflare Workers AI](https://flueframework.com/docs/guide/models/#cloudflare-workers-ai-cloudflare-only) below.
- `cloudflare-workers-ai/...` uses URL-backed [Workers AI](https://developers.cloudflare.com/workers-ai/) access through the Cloudflare API. It can be used from Node.js or Cloudflare applications with the applicable credentials.
- `cloudflare-ai-gateway/...` uses URL-backed [Cloudflare AI Gateway](https://developers.cloudflare.com/ai-gateway/) access. It can be used from Node.js or Cloudflare applications when you want gateway-managed observability and controls.

### Built-in provider overrides [\#](https://flueframework.com/docs/guide/models/\#built-in-provider-overrides)

Use `registerProvider(...)` in `src/app.ts` when a built-in provider should retain its known model catalog but send requests through application-specific transport configuration, such as an AI gateway or proxy. Registering a built-in provider ID preserves its catalog metadata — cost, context window, and wire protocol — and layers your options on top.

```
import { registerProvider } from '@flue/runtime';
import { flue } from '@flue/runtime/routing';
import { Hono } from 'hono';

if (process.env.ANTHROPIC_GATEWAY_URL) {
  registerProvider('anthropic', {
    baseUrl: process.env.ANTHROPIC_GATEWAY_URL,
    apiKey: process.env.ANTHROPIC_API_KEY,
  });
}

const app = new Hono();
app.route('/', flue());

export default app;
```

A provider override can change its endpoint, API key, or headers without changing the provider ID used in your model specifiers. It can also opt into hosted response persistence for supported OpenAI Responses API providers. Each `registerProvider(...)` call replaces the previous registration for that provider ID; the effective settings are always the catalog defaults plus the latest call’s options. Keep this runtime setup in `app.ts` rather than repeating it in agents or individual operations.

### Custom providers [\#](https://flueframework.com/docs/guide/models/\#custom-providers)

Use `registerProvider(...)` in `src/app.ts` when you want to connect Flue to a model provider that is not built in. Registering a provider assigns it a provider ID, which you can then use in model specifiers throughout your application. Provider IDs outside the built-in catalog must supply `api` and `baseUrl`.

For example, you can register a local Ollama server through its OpenAI-compatible endpoint:

```
import { registerProvider } from '@flue/runtime';
import { flue } from '@flue/runtime/routing';
import { Hono } from 'hono';

registerProvider('ollama', {
  api: 'openai-completions',
  baseUrl: 'http://localhost:11434/v1',
});

const app = new Hono();
app.route('/', flue());

export default app;
```

The registered provider ID is now available anywhere you select a model:

```
import { createAgent } from '@flue/runtime';

export default createAgent(() => ({
  model: 'ollama/llama3.1:8b',
}));
```

A provider registration can also supply authentication, headers, and model metadata when your endpoint requires them. Most OpenAI-compatible services can use the built-in `openai-completions` protocol shown above. For an endpoint with a different wire protocol, advanced integrations can import `registerApiProvider(...)` from `@flue/runtime` and use it to register that protocol before registering a provider ID for it.

Choose a new provider ID unless you intend to override a built-in connection path. For example, registering `cloudflare` yourself takes precedence over Flue’s generated `cloudflare/...` binding default, which is how the customization below takes effect.

## Cloudflare Workers AI (Cloudflare only) [\#](https://flueframework.com/docs/guide/models/\#cloudflare-workers-ai-cloudflare-only)

For applications built with `--target cloudflare`, Flue provides the `cloudflare/...` provider ID for running model calls through a [Workers AI](https://developers.cloudflare.com/workers-ai/) binding. This path uses the binding attached to your Worker rather than URL-backed provider credentials.

Everything after `cloudflare/` is passed as the model ID to `env.AI.run(...)`. Use Workers AI model IDs such as `@cf/moonshotai/kimi-k2.6`, or a binding-supported AI Gateway model ID such as `openai/gpt-5.5` when your Worker should reach that model through Cloudflare’s binding and gateway path. Use `openai/gpt-5.5` without the `cloudflare/` prefix only when you intend to use Flue’s direct OpenAI provider and its credentials.

```
import { createAgent } from '@flue/runtime';

export default createAgent(() => ({
  model: 'cloudflare/@cf/moonshotai/kimi-k2.6',
}));
```

Declare an `AI` binding in your project’s Wrangler configuration:

```
{
  "$schema": "./node_modules/wrangler/config-schema.json",
  "ai": {
    "binding": "AI",
  },
}
```

A `cloudflare/...` model call does not need an API key in your application environment. Authorization and billing follow the Worker account associated with the binding, including the [Workers AI pricing and daily free allocation](https://developers.cloudflare.com/workers-ai/platform/pricing/).

### Advanced: Customize AI Gateway behavior [\#](https://flueframework.com/docs/guide/models/\#advanced-customize-ai-gateway-behavior)

By default, Flue routes `cloudflare/...` binding calls through Cloudflare AI Gateway with gateway ID `default`. To choose a named gateway, set cache or logging options, or bypass the gateway option, register the `cloudflare` provider ID yourself in `src/app.ts`:

```
import { env } from 'cloudflare:workers';
import { registerProvider } from '@flue/runtime';
import { flue } from '@flue/runtime/routing';
import { Hono } from 'hono';

registerProvider('cloudflare', {
  api: 'cloudflare-ai-binding',
  binding: env.AI,
  gateway: {
    id: 'production-agent-traffic',
    cacheTtl: 300,
    metadata: { application: 'support' },
    collectLog: true,
  },
});

const app = new Hono();
app.route('/', flue());

export default app;
```

Set `gateway: false` in that registration when you do not want Flue to pass a gateway option. See Cloudflare’s [Workers bindings documentation](https://developers.cloudflare.com/ai-gateway/integrations/worker-binding-methods/) for gateway behavior and supported options.

## Docs Navigation

Current page: [LLM (Models & Providers)](https://flueframework.com/docs/guide/models/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
