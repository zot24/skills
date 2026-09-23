> Source: https://pi.dev/docs/latest/models



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# Choose a Model


For a built-in provider, start with `/login`, then choose a model with `/model`. Use custom model configuration only when Pi does not already include the provider or endpoint you need.


## Choose a connection

<a href="#choose-a-connection" class="heading-anchor" aria-label="Permalink: Choose a connection" data-copy="" data-copy-text="https://pi.dev/docs/latest/models#choose-a-connection"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| What you have                                            | Recommended setup                                         |
|----------------------------------------------------------|-----------------------------------------------------------|
| A supported subscription                                 | Sign in through `/login`                                  |
| A provider API key                                       | Store it through `/login` or set its environment variable |
| A local GGUF model                                       | Connect Pi to the llama.cpp router                        |
| An OpenAI-, Anthropic-, or Google-compatible endpoint    | Add it to `models.json`                                   |
| A provider with a custom protocol or authentication flow | Build or install a provider extension                     |

Browse the [model catalog](https://pi.dev/models) for current providers, model IDs, capabilities, context limits, and pricing. Pi starts with its bundled catalog and can overlay newer catalog data from pi.dev. Cached catalog data remains available offline; run `pi update --models` to force a refresh.


## Authenticate

<a href="#authenticate" class="heading-anchor" aria-label="Permalink: Authenticate" data-copy="" data-copy-text="https://pi.dev/docs/latest/models#authenticate"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Run `/login` and select a provider. Pi stores credentials in [`auth.json`](/docs/latest/configuration#agent-directory). Run `/logout` to remove stored credentials for a provider.

You can instead provide an API key through the provider's environment variable. This is useful in CI and other environments where Pi should not write credentials. [Provider Authentication](/docs/latest/providers) lists the variables and cloud-provider setup.

When several credential sources are configured, Pi uses a runtime `--api-key` first, then a stored `auth.json` credential, an `apiKey` from `models.json`, and finally the provider's environment variables or ambient cloud credentials. Provider extensions can define their own authentication behavior.

Keep `auth.json` and any credential commands private. Project settings and extensions can execute inside the Pi process after you trust a project. Review [Security](/docs/latest/security) before loading configuration from an untrusted directory.


## Select a model

<a href="#select-a-model" class="heading-anchor" aria-label="Permalink: Select a model" data-copy="" data-copy-text="https://pi.dev/docs/latest/models#select-a-model"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Run `/model` to search available models. The picker shows models whose providers have usable authentication. Press `Ctrl+S` on a model to save it as the default for new sessions.

Run `/thinking` to select the thinking level for the current model. Press `Ctrl+S` there to save the startup level. Pi limits the choices to levels supported by the selected model.

`Ctrl+P` cycles through available models. Use `/scoped-models` to control that cycle and save the selection, or configure model patterns through [Settings](/docs/latest/settings#model-cycling).

A session records model and thinking-level changes. Resuming the session restores them without changing defaults for new sessions.


## Connect local models

<a href="#connect-local-models" class="heading-anchor" aria-label="Permalink: Connect local models" data-copy="" data-copy-text="https://pi.dev/docs/latest/models#connect-local-models"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Pi integrates directly with the llama.cpp router. The router discovers GGUF files and loads models on demand. Pi's `/llama` command manages the router, while `/model` selects one of its loaded models.

Follow [Local Models with llama.cpp](/docs/latest/llama-cpp) for server startup, model layout, downloads, and connection troubleshooting.

For Ollama, LM Studio, vLLM, SGLang, and other compatible servers, [configure a compatible endpoint](#configure-a-compatible-endpoint) in `models.json`.


## Configure a compatible endpoint

<a href="#configure-a-compatible-endpoint" class="heading-anchor" aria-label="Permalink: Configure a compatible endpoint" data-copy="" data-copy-text="https://pi.dev/docs/latest/models#configure-a-compatible-endpoint"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Use [`models.json`](/docs/latest/configuration#agent-directory) when an endpoint speaks an API Pi already supports. This includes most Ollama, LM Studio, vLLM, SGLang, and proxy deployments.

``` json
{
  "providers": {
    "ollama": {
      "baseUrl": "http://localhost:11434/v1",
      "api": "openai-completions",
      "apiKey": "ollama",
      "models": [
        { "id": "qwen2.5-coder:7b" }
      ]
    }
  }
}
```

The dummy key makes the model available to Pi; Ollama ignores it. For an authenticated endpoint, `apiKey` and header values can use `$NAME` or `${NAME}` environment interpolation, a literal value, or a leading `!command`. Commands in `models.json` run at request time and are not cached by Pi.

Opening `/model` reloads the file. A `models` entry adds or replaces a model with the same ID on that provider. Use `modelOverrides` to change metadata for an existing built-in or extension-provided model without replacing the provider's model list. Unknown override IDs are ignored.


### Describe model input and caching

<a href="#describe-model-input-and-caching" class="heading-anchor" aria-label="Permalink: Describe model input and caching" data-copy="" data-copy-text="https://pi.dev/docs/latest/models#describe-model-input-and-caching"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Use `inputLimits.images.resize` to control how Pi encodes new image attachments, `read` results, and tool-result images before storing them in conversation history:

``` json
{
  "id": "vision-model",
  "input": ["text", "image"],
  "inputLimits": {
    "images": {
      "resize": {
        "maxWidth": 1568,
        "maxHeight": 1568,
        "maxBytes": 524288,
        "jpegQuality": 75
      }
    }
  }
}
```

`maxBytes` limits the base64-encoded payload. Omitted resize fields use conservative defaults of 2000 by 2000 pixels, 4.5 MiB encoded, and JPEG quality 80. Images are encoded once; changing models does not rewrite historical images. The catalog can also describe hard request limits with `inputLimits.maxRequestBytes`, `images.maxPerMessage`, and `images.maxPerRequest`, but Pi does not yet rewrite or reject history based on them.


Use `promptCache` to declare the provider's best-effort cache lifetime in seconds for the `short` or `long` retention tier:

``` json
{ "id": "claude-sonnet-5", "promptCache": { "short": 300, "long": 3600 } }
```

Choose the conservative end of any published range. A model without a lifetime for the active tier is not eligible for cache warming. A `modelOverrides` entry can set `inputLimits` or `promptCache` for a built-in or extension model, including a model accessed through a validated proxy. See [`cacheWarming`](/docs/latest/settings#model-and-thinking).

Compatibility settings should describe verified differences in the endpoint's request or response behavior. Do not enable them based only on an endpoint advertising OpenAI or Anthropic compatibility.


## Add a custom provider

<a href="#add-a-custom-provider" class="heading-anchor" aria-label="Permalink: Add a custom provider" data-copy="" data-copy-text="https://pi.dev/docs/latest/models#add-a-custom-provider"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Use an extension when the provider needs custom streaming, model discovery, or authentication behavior. See [Custom Providers](/docs/latest/custom-provider) for the extension workflow.


## Troubleshooting

<a href="#troubleshooting" class="heading-anchor" aria-label="Permalink: Troubleshooting" data-copy="" data-copy-text="https://pi.dev/docs/latest/models#troubleshooting"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


### A model does not appear

<a href="#a-model-does-not-appear" class="heading-anchor" aria-label="Permalink: A model does not appear" data-copy="" data-copy-text="https://pi.dev/docs/latest/models#a-model-does-not-appear"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Confirm that its provider has usable authentication. Custom models can load from `models.json` but remain unavailable in `/model` until Pi can resolve credentials. For llama.cpp, only models currently loaded by the router appear.


### Authentication works in one shell only

<a href="#authentication-works-in-one-shell-only" class="heading-anchor" aria-label="Permalink: Authentication works in one shell only" data-copy="" data-copy-text="https://pi.dev/docs/latest/models#authentication-works-in-one-shell-only"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Check whether the key came from an environment variable rather than `auth.json`. Environment variables must be present in the process that starts Pi.


### Sign-in opens a browser on a remote machine

<a href="#sign-in-opens-a-browser-on-a-remote-machine" class="heading-anchor" aria-label="Permalink: Sign-in opens a browser on a remote machine" data-copy="" data-copy-text="https://pi.dev/docs/latest/models#sign-in-opens-a-browser-on-a-remote-machine"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Complete the provider's headless authentication flow when available. Some providers let you paste the final redirect URL or authorization code back into Pi. See [Authenticate interactively](/docs/latest/providers#authenticate-interactively).


### A compatible endpoint rejects requests

<a href="#a-compatible-endpoint-rejects-requests" class="heading-anchor" aria-label="Permalink: A compatible endpoint rejects requests" data-copy="" data-copy-text="https://pi.dev/docs/latest/models#a-compatible-endpoint-rejects-requests"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Check its API type and compatibility settings in `models.json`. The upstream server must support the corresponding request fields and behavior.


