> Source: https://hermes-agent.nousresearch.com/docs/user-guide/configuration/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# Configuration


All settings are stored in the `~/.hermes/` directory for easy access.

## Directory Structure<a href="#directory-structure" class="hash-link" aria-label="Direct link to Directory Structure" translate="no" title="Direct link to Directory Structure">​</a>


``` prism-code
~/.hermes/
├── config.yaml     # Settings (model, terminal, TTS, compression, etc.)
├── .env            # API keys and secrets
├── auth.json       # OAuth provider credentials (Nous Portal, etc.)
├── SOUL.md         # Primary agent identity (slot #1 in system prompt)
├── memories/       # Persistent memory (MEMORY.md, USER.md)
├── skills/         # Agent-created skills (managed via skill_manage tool)
├── cron/           # Scheduled jobs
├── sessions/       # Gateway sessions
└── logs/           # Logs (errors.log, gateway.log — secrets auto-redacted)
```


## Managing Configuration<a href="#managing-configuration" class="hash-link" aria-label="Direct link to Managing Configuration" translate="no" title="Direct link to Managing Configuration">​</a>


``` prism-code
hermes config              # View current configuration
hermes config edit         # Open config.yaml in your editor
hermes config set KEY VAL  # Set a specific value
hermes config check        # Check for missing options (after updates)
hermes config migrate      # Interactively add missing options

# Examples:
hermes config set model anthropic/claude-opus-4
hermes config set terminal.backend docker
hermes config set OPENROUTER_API_KEY sk-or-...  # Saves to .env
```


The `hermes config set` command automatically routes values to the right file — API keys are saved to `.env`, everything else to `config.yaml`.


## Configuration Precedence<a href="#configuration-precedence" class="hash-link" aria-label="Direct link to Configuration Precedence" translate="no" title="Direct link to Configuration Precedence">​</a>

Settings are resolved in this order (highest priority first):

1.  **CLI arguments** — e.g., `hermes chat --model anthropic/claude-sonnet-4` (per-invocation override)
2.  **`~/.hermes/config.yaml`** — the primary config file for all non-secret settings
3.  **`~/.hermes/.env`** — fallback for env vars; **required** for secrets (API keys, tokens, passwords)
4.  **Built-in defaults** — hardcoded safe defaults when nothing else is set


Secrets (API keys, bot tokens, passwords) go in `.env`. Everything else (model, terminal backend, compression settings, memory limits, toolsets) goes in `config.yaml`. When both are set, `config.yaml` wins for non-secret settings.


## Environment Variable Substitution<a href="#environment-variable-substitution" class="hash-link" aria-label="Direct link to Environment Variable Substitution" translate="no" title="Direct link to Environment Variable Substitution">​</a>

You can reference environment variables in `config.yaml` using `${VAR_NAME}` syntax:


``` prism-code
auxiliary:
  vision:
    api_key: ${GOOGLE_API_KEY}
    base_url: ${CUSTOM_VISION_URL}

delegation:
  api_key: ${DELEGATION_KEY}
```


Multiple references in a single value work: `url: "${HOST}:${PORT}"`. If a referenced variable is not set, the placeholder is kept verbatim (`${UNDEFINED_VAR}` stays as-is). Only the `${VAR}` syntax is supported — bare `$VAR` is not expanded.

## Inference Providers<a href="#inference-providers" class="hash-link" aria-label="Direct link to Inference Providers" translate="no" title="Direct link to Inference Providers">​</a>

You need at least one way to connect to an LLM. Use `hermes model` to switch providers and models interactively, or configure directly:

| Provider               | Setup                                                                                               |
|------------------------|-----------------------------------------------------------------------------------------------------|
| **Nous Portal**        | `hermes model` (OAuth, subscription-based)                                                          |
| **OpenAI Codex**       | `hermes model` (ChatGPT OAuth, uses Codex models)                                                   |
| **GitHub Copilot**     | `hermes model` (OAuth device code flow, `COPILOT_GITHUB_TOKEN`, `GH_TOKEN`, or `gh auth token`)     |
| **GitHub Copilot ACP** | `hermes model` (spawns local `copilot --acp --stdio`)                                               |
| **Anthropic**          | `hermes model` (Claude Pro/Max via Claude Code auth, Anthropic API key, or manual setup-token)      |
| **OpenRouter**         | `OPENROUTER_API_KEY` in `~/.hermes/.env`                                                            |
| **AI Gateway**         | `AI_GATEWAY_API_KEY` in `~/.hermes/.env` (provider: `ai-gateway`)                                   |
| **z.ai / GLM**         | `GLM_API_KEY` in `~/.hermes/.env` (provider: `zai`)                                                 |
| **Kimi / Moonshot**    | `KIMI_API_KEY` in `~/.hermes/.env` (provider: `kimi-coding`)                                        |
| **MiniMax**            | `MINIMAX_API_KEY` in `~/.hermes/.env` (provider: `minimax`)                                         |
| **MiniMax China**      | `MINIMAX_CN_API_KEY` in `~/.hermes/.env` (provider: `minimax-cn`)                                   |
| **Alibaba Cloud**      | `DASHSCOPE_API_KEY` in `~/.hermes/.env` (provider: `alibaba`, aliases: `dashscope`, `qwen`)         |
| **Kilo Code**          | `KILOCODE_API_KEY` in `~/.hermes/.env` (provider: `kilocode`)                                       |
| **OpenCode Zen**       | `OPENCODE_ZEN_API_KEY` in `~/.hermes/.env` (provider: `opencode-zen`)                               |
| **OpenCode Go**        | `OPENCODE_GO_API_KEY` in `~/.hermes/.env` (provider: `opencode-go`)                                 |
| **Hugging Face**       | `HF_TOKEN` in `~/.hermes/.env` (provider: `huggingface`, aliases: `hf`)                             |
| **Custom Endpoint**    | `hermes model` (saved in `config.yaml`) or `OPENAI_BASE_URL` + `OPENAI_API_KEY` in `~/.hermes/.env` |


In the `model:` config section, you can use either `default:` or `model:` as the key name for your model ID. Both `model: { default: my-model }` and `model: { model: my-model }` work identically.


The OpenAI Codex provider authenticates via device code (open a URL, enter a code). Hermes stores the resulting credentials in its own auth store under `~/.hermes/auth.json` and can import existing Codex CLI credentials from `~/.codex/auth.json` when present. No Codex CLI installation is required.


Even when using Nous Portal, Codex, or a custom endpoint, some tools (vision, web summarization, MoA) use a separate "auxiliary" model — by default Gemini Flash via OpenRouter. An `OPENROUTER_API_KEY` enables these tools automatically. You can also configure which model and provider these tools use — see [Auxiliary Models](#auxiliary-models) below.


### Anthropic (Native)<a href="#anthropic-native" class="hash-link" aria-label="Direct link to Anthropic (Native)" translate="no" title="Direct link to Anthropic (Native)">​</a>

Use Claude models directly through the Anthropic API — no OpenRouter proxy needed. Supports three auth methods:


``` prism-code
# With an API key (pay-per-token)
export ANTHROPIC_API_KEY=***
hermes chat --provider anthropic --model claude-sonnet-4-6

# Preferred: authenticate through `hermes model`
# Hermes will use Claude Code's credential store directly when available
hermes model

# Manual override with a setup-token (fallback / legacy)
export ANTHROPIC_TOKEN=***  # setup-token or manual OAuth token
hermes chat --provider anthropic

# Auto-detect Claude Code credentials (if you already use Claude Code)
hermes chat --provider anthropic  # reads Claude Code credential files automatically
```


When you choose Anthropic OAuth through `hermes model`, Hermes prefers Claude Code's own credential store over copying the token into `~/.hermes/.env`. That keeps refreshable Claude credentials refreshable.

Or set it permanently:


``` prism-code
model:
  provider: "anthropic"
  default: "claude-sonnet-4-6"
```


`--provider claude` and `--provider claude-code` also work as shorthand for `--provider anthropic`.


### GitHub Copilot<a href="#github-copilot" class="hash-link" aria-label="Direct link to GitHub Copilot" translate="no" title="Direct link to GitHub Copilot">​</a>

Hermes supports GitHub Copilot as a first-class provider with two modes:

**`copilot` — Direct Copilot API** (recommended). Uses your GitHub Copilot subscription to access GPT-5.x, Claude, Gemini, and other models through the Copilot API.


``` prism-code
hermes chat --provider copilot --model gpt-5.4
```


**Authentication options** (checked in this order):

1.  `COPILOT_GITHUB_TOKEN` environment variable
2.  `GH_TOKEN` environment variable
3.  `GITHUB_TOKEN` environment variable
4.  `gh auth token` CLI fallback

If no token is found, `hermes model` offers an **OAuth device code login** — the same flow used by the Copilot CLI and opencode.


The Copilot API does **not** support classic Personal Access Tokens (`ghp_*`). Supported token types:

| Type             | Prefix        | How to get                                                                                         |
|------------------|---------------|----------------------------------------------------------------------------------------------------|
| OAuth token      | `gho_`        | `hermes model` → GitHub Copilot → Login with GitHub                                                |
| Fine-grained PAT | `github_pat_` | GitHub Settings → Developer settings → Fine-grained tokens (needs **Copilot Requests** permission) |
| GitHub App token | `ghu_`        | Via GitHub App installation                                                                        |

If your `gh auth token` returns a `ghp_*` token, use `hermes model` to authenticate via OAuth instead.


**API routing**: GPT-5+ models (except `gpt-5-mini`) automatically use the Responses API. All other models (GPT-4o, Claude, Gemini, etc.) use Chat Completions. Models are auto-detected from the live Copilot catalog.

**`copilot-acp` — Copilot ACP agent backend**. Spawns the local Copilot CLI as a subprocess:


``` prism-code
hermes chat --provider copilot-acp --model copilot-acp
# Requires the GitHub Copilot CLI in PATH and an existing `copilot login` session
```


**Permanent config:**


``` prism-code
model:
  provider: "copilot"
  default: "gpt-5.4"
```


| Environment variable         | Description                                               |
|------------------------------|-----------------------------------------------------------|
| `COPILOT_GITHUB_TOKEN`       | GitHub token for Copilot API (first priority)             |
| `HERMES_COPILOT_ACP_COMMAND` | Override the Copilot CLI binary path (default: `copilot`) |
| `HERMES_COPILOT_ACP_ARGS`    | Override ACP args (default: `--acp --stdio`)              |

### First-Class Chinese AI Providers<a href="#first-class-chinese-ai-providers" class="hash-link" aria-label="Direct link to First-Class Chinese AI Providers" translate="no" title="Direct link to First-Class Chinese AI Providers">​</a>

These providers have built-in support with dedicated provider IDs. Set the API key and use `--provider` to select:


``` prism-code
# z.ai / ZhipuAI GLM
hermes chat --provider zai --model glm-4-plus
# Requires: GLM_API_KEY in ~/.hermes/.env

# Kimi / Moonshot AI
hermes chat --provider kimi-coding --model moonshot-v1-auto
# Requires: KIMI_API_KEY in ~/.hermes/.env

# MiniMax (global endpoint)
hermes chat --provider minimax --model MiniMax-M2.7
# Requires: MINIMAX_API_KEY in ~/.hermes/.env

# MiniMax (China endpoint)
hermes chat --provider minimax-cn --model MiniMax-M2.7
# Requires: MINIMAX_CN_API_KEY in ~/.hermes/.env

# Alibaba Cloud / DashScope (Qwen models)
hermes chat --provider alibaba --model qwen3.5-plus
# Requires: DASHSCOPE_API_KEY in ~/.hermes/.env
```


Or set the provider permanently in `config.yaml`:


``` prism-code
model:
  provider: "zai"       # or: kimi-coding, minimax, minimax-cn, alibaba
  default: "glm-4-plus"
```


Base URLs can be overridden with `GLM_BASE_URL`, `KIMI_BASE_URL`, `MINIMAX_BASE_URL`, `MINIMAX_CN_BASE_URL`, or `DASHSCOPE_BASE_URL` environment variables.

### Hugging Face Inference Providers<a href="#hugging-face-inference-providers" class="hash-link" aria-label="Direct link to Hugging Face Inference Providers" translate="no" title="Direct link to Hugging Face Inference Providers">​</a>

<a href="https://huggingface.co/docs/inference-providers" target="_blank" rel="noopener noreferrer">Hugging Face Inference Providers</a> routes to 20+ open models through a unified OpenAI-compatible endpoint (`router.huggingface.co/v1`). Requests are automatically routed to the fastest available backend (Groq, Together, SambaNova, etc.) with automatic failover.


``` prism-code
# Use any available model
hermes chat --provider huggingface --model Qwen/Qwen3-235B-A22B-Thinking-2507
# Requires: HF_TOKEN in ~/.hermes/.env

# Short alias
hermes chat --provider hf --model deepseek-ai/DeepSeek-V3.2
```


Or set it permanently in `config.yaml`:


``` prism-code
model:
  provider: "huggingface"
  default: "Qwen/Qwen3-235B-A22B-Thinking-2507"
```


Get your token at <a href="https://huggingface.co/settings/tokens" target="_blank" rel="noopener noreferrer">huggingface.co/settings/tokens</a> — make sure to enable the "Make calls to Inference Providers" permission. Free tier included (\$0.10/month credit, no markup on provider rates).

You can append routing suffixes to model names: `:fastest` (default), `:cheapest`, or `:provider_name` to force a specific backend.

The base URL can be overridden with `HF_BASE_URL`.

## Custom & Self-Hosted LLM Providers<a href="#custom--self-hosted-llm-providers" class="hash-link" aria-label="Direct link to Custom &amp; Self-Hosted LLM Providers" translate="no" title="Direct link to Custom &amp; Self-Hosted LLM Providers">​</a>

Hermes Agent works with **any OpenAI-compatible API endpoint**. If a server implements `/v1/chat/completions`, you can point Hermes at it. This means you can use local models, GPU inference servers, multi-provider routers, or any third-party API.

### General Setup<a href="#general-setup" class="hash-link" aria-label="Direct link to General Setup" translate="no" title="Direct link to General Setup">​</a>

Three ways to configure a custom endpoint:

**Interactive setup (recommended):**


``` prism-code
hermes model
# Select "Custom endpoint (self-hosted / VLLM / etc.)"
# Enter: API base URL, API key, Model name
```


**Manual config (`config.yaml`):**


``` prism-code
# In ~/.hermes/config.yaml
model:
  default: your-model-name
  provider: custom
  base_url: http://localhost:8000/v1
  api_key: your-key-or-leave-empty-for-local
```


**Environment variables (`.env` file):**


``` prism-code
# Add to ~/.hermes/.env
OPENAI_BASE_URL=http://localhost:8000/v1
OPENAI_API_KEY=your-key     # Any non-empty string for local servers
LLM_MODEL=your-model-name
```


All three approaches end up in the same runtime path. `hermes model` persists provider, model, and base URL to `config.yaml` so later sessions keep using that endpoint even if env vars are not set.

### Switching Models with `/model`<a href="#switching-models-with-model" class="hash-link" aria-label="Direct link to switching-models-with-model" translate="no" title="Direct link to switching-models-with-model">​</a>

Once a custom endpoint is configured, you can switch models mid-session:


``` prism-code
/model custom:qwen-2.5          # Switch to a model on your custom endpoint
/model custom                    # Auto-detect the model from the endpoint
/model openrouter:claude-sonnet-4 # Switch back to a cloud provider
```


If you have **named custom providers** configured (see below), use the triple syntax:


``` prism-code
/model custom:local:qwen-2.5    # Use the "local" custom provider with model qwen-2.5
/model custom:work:llama3       # Use the "work" custom provider with llama3
```


When switching providers, Hermes persists the base URL and provider to config so the change survives restarts. When switching away from a custom endpoint to a built-in provider, the stale base URL is automatically cleared.


`/model custom` (bare, no model name) queries your endpoint's `/models` API and auto-selects the model if exactly one is loaded. Useful for local servers running a single model.


Everything below follows this same pattern — just change the URL, key, and model name.

------------------------------------------------------------------------

### Ollama — Local Models, Zero Config<a href="#ollama--local-models-zero-config" class="hash-link" aria-label="Direct link to Ollama — Local Models, Zero Config" translate="no" title="Direct link to Ollama — Local Models, Zero Config">​</a>

<a href="https://ollama.com/" target="_blank" rel="noopener noreferrer">Ollama</a> runs open-weight models locally with one command. Best for: quick local experimentation, privacy-sensitive work, offline use.


``` prism-code
# Install and run a model
ollama pull llama3.1:70b
ollama serve   # Starts on port 11434

# Configure Hermes
OPENAI_BASE_URL=http://localhost:11434/v1
OPENAI_API_KEY=ollama           # Any non-empty string
LLM_MODEL=llama3.1:70b
```


Ollama's OpenAI-compatible endpoint supports chat completions, streaming, and tool calling (for supported models). No GPU required for smaller models — Ollama handles CPU inference automatically.


List available models with `ollama list`. Pull any model from the <a href="https://ollama.com/library" target="_blank" rel="noopener noreferrer">Ollama library</a> with `ollama pull <model>`.


------------------------------------------------------------------------

### vLLM — High-Performance GPU Inference<a href="#vllm--high-performance-gpu-inference" class="hash-link" aria-label="Direct link to vLLM — High-Performance GPU Inference" translate="no" title="Direct link to vLLM — High-Performance GPU Inference">​</a>

<a href="https://docs.vllm.ai/" target="_blank" rel="noopener noreferrer">vLLM</a> is the standard for production LLM serving. Best for: maximum throughput on GPU hardware, serving large models, continuous batching.


``` prism-code
# Start vLLM server
pip install vllm
vllm serve meta-llama/Llama-3.1-70B-Instruct \
  --port 8000 \
  --tensor-parallel-size 2    # Multi-GPU

# Configure Hermes
OPENAI_BASE_URL=http://localhost:8000/v1
OPENAI_API_KEY=dummy
LLM_MODEL=meta-llama/Llama-3.1-70B-Instruct
```


vLLM supports tool calling, structured output, and multi-modal models. Use `--enable-auto-tool-choice` and `--tool-call-parser hermes` for Hermes-format tool calling with NousResearch models.

------------------------------------------------------------------------

### SGLang — Fast Serving with RadixAttention<a href="#sglang--fast-serving-with-radixattention" class="hash-link" aria-label="Direct link to SGLang — Fast Serving with RadixAttention" translate="no" title="Direct link to SGLang — Fast Serving with RadixAttention">​</a>

<a href="https://github.com/sgl-project/sglang" target="_blank" rel="noopener noreferrer">SGLang</a> is an alternative to vLLM with RadixAttention for KV cache reuse. Best for: multi-turn conversations (prefix caching), constrained decoding, structured output.


``` prism-code
# Start SGLang server
pip install "sglang[all]"
python -m sglang.launch_server \
  --model meta-llama/Llama-3.1-70B-Instruct \
  --port 8000 \
  --tp 2

# Configure Hermes
OPENAI_BASE_URL=http://localhost:8000/v1
OPENAI_API_KEY=dummy
LLM_MODEL=meta-llama/Llama-3.1-70B-Instruct
```


------------------------------------------------------------------------

### llama.cpp / llama-server — CPU & Metal Inference<a href="#llamacpp--llama-server--cpu--metal-inference" class="hash-link" aria-label="Direct link to llama.cpp / llama-server — CPU &amp; Metal Inference" translate="no" title="Direct link to llama.cpp / llama-server — CPU &amp; Metal Inference">​</a>

<a href="https://github.com/ggml-org/llama.cpp" target="_blank" rel="noopener noreferrer">llama.cpp</a> runs quantized models on CPU, Apple Silicon (Metal), and consumer GPUs. Best for: running models without a datacenter GPU, Mac users, edge deployment.


``` prism-code
# Build and start llama-server
cmake -B build && cmake --build build --config Release
./build/bin/llama-server \
  -m models/llama-3.1-8b-instruct-Q4_K_M.gguf \
  --port 8080 --host 0.0.0.0

# Configure Hermes
OPENAI_BASE_URL=http://localhost:8080/v1
OPENAI_API_KEY=dummy
LLM_MODEL=llama-3.1-8b-instruct
```


Download GGUF models from <a href="https://huggingface.co/models?library=gguf" target="_blank" rel="noopener noreferrer">Hugging Face</a>. Q4_K_M quantization offers the best balance of quality vs. memory usage.


------------------------------------------------------------------------

### LiteLLM Proxy — Multi-Provider Gateway<a href="#litellm-proxy--multi-provider-gateway" class="hash-link" aria-label="Direct link to LiteLLM Proxy — Multi-Provider Gateway" translate="no" title="Direct link to LiteLLM Proxy — Multi-Provider Gateway">​</a>

<a href="https://docs.litellm.ai/" target="_blank" rel="noopener noreferrer">LiteLLM</a> is an OpenAI-compatible proxy that unifies 100+ LLM providers behind a single API. Best for: switching between providers without config changes, load balancing, fallback chains, budget controls.


``` prism-code
# Install and start
pip install "litellm[proxy]"
litellm --model anthropic/claude-sonnet-4 --port 4000

# Or with a config file for multiple models:
litellm --config litellm_config.yaml --port 4000

# Configure Hermes
OPENAI_BASE_URL=http://localhost:4000/v1
OPENAI_API_KEY=sk-your-litellm-key
LLM_MODEL=anthropic/claude-sonnet-4
```


Example `litellm_config.yaml` with fallback:


``` prism-code
model_list:
  - model_name: "best"
    litellm_params:
      model: anthropic/claude-sonnet-4
      api_key: sk-ant-...
  - model_name: "best"
    litellm_params:
      model: openai/gpt-4o
      api_key: sk-...
router_settings:
  routing_strategy: "latency-based-routing"
```


------------------------------------------------------------------------

### ClawRouter — Cost-Optimized Routing<a href="#clawrouter--cost-optimized-routing" class="hash-link" aria-label="Direct link to ClawRouter — Cost-Optimized Routing" translate="no" title="Direct link to ClawRouter — Cost-Optimized Routing">​</a>

<a href="https://github.com/BlockRunAI/ClawRouter" target="_blank" rel="noopener noreferrer">ClawRouter</a> by BlockRunAI is a local routing proxy that auto-selects models based on query complexity. It classifies requests across 14 dimensions and routes to the cheapest model that can handle the task. Payment is via USDC cryptocurrency (no API keys).


``` prism-code
# Install and start
npx @blockrun/clawrouter    # Starts on port 8402

# Configure Hermes
OPENAI_BASE_URL=http://localhost:8402/v1
OPENAI_API_KEY=dummy
LLM_MODEL=blockrun/auto     # or: blockrun/eco, blockrun/premium, blockrun/agentic
```


Routing profiles:

| Profile            | Strategy               | Savings |
|--------------------|------------------------|---------|
| `blockrun/auto`    | Balanced quality/cost  | 74-100% |
| `blockrun/eco`     | Cheapest possible      | 95-100% |
| `blockrun/premium` | Best quality models    | 0%      |
| `blockrun/free`    | Free models only       | 100%    |
| `blockrun/agentic` | Optimized for tool use | varies  |


ClawRouter requires a USDC-funded wallet on Base or Solana for payment. All requests route through BlockRun's backend API. Run `npx @blockrun/clawrouter doctor` to check wallet status.


------------------------------------------------------------------------

### Other Compatible Providers<a href="#other-compatible-providers" class="hash-link" aria-label="Direct link to Other Compatible Providers" translate="no" title="Direct link to Other Compatible Providers">​</a>

Any service with an OpenAI-compatible API works. Some popular options:

| Provider                                                                                         | Base URL                                | Notes                         |
|--------------------------------------------------------------------------------------------------|-----------------------------------------|-------------------------------|
| <a href="https://together.ai" target="_blank" rel="noopener noreferrer">Together AI</a>          | `https://api.together.xyz/v1`           | Cloud-hosted open models      |
| <a href="https://groq.com" target="_blank" rel="noopener noreferrer">Groq</a>                    | `https://api.groq.com/openai/v1`        | Ultra-fast inference          |
| <a href="https://deepseek.com" target="_blank" rel="noopener noreferrer">DeepSeek</a>            | `https://api.deepseek.com/v1`           | DeepSeek models               |
| <a href="https://fireworks.ai" target="_blank" rel="noopener noreferrer">Fireworks AI</a>        | `https://api.fireworks.ai/inference/v1` | Fast open model hosting       |
| <a href="https://cerebras.ai" target="_blank" rel="noopener noreferrer">Cerebras</a>             | `https://api.cerebras.ai/v1`            | Wafer-scale chip inference    |
| <a href="https://mistral.ai" target="_blank" rel="noopener noreferrer">Mistral AI</a>            | `https://api.mistral.ai/v1`             | Mistral models                |
| <a href="https://openai.com" target="_blank" rel="noopener noreferrer">OpenAI</a>                | `https://api.openai.com/v1`             | Direct OpenAI access          |
| <a href="https://azure.microsoft.com" target="_blank" rel="noopener noreferrer">Azure OpenAI</a> | `https://YOUR.openai.azure.com/`        | Enterprise OpenAI             |
| <a href="https://localai.io" target="_blank" rel="noopener noreferrer">LocalAI</a>               | `http://localhost:8080/v1`              | Self-hosted, multi-model      |
| <a href="https://jan.ai" target="_blank" rel="noopener noreferrer">Jan</a>                       | `http://localhost:1337/v1`              | Desktop app with local models |


``` prism-code
# Example: Together AI
OPENAI_BASE_URL=https://api.together.xyz/v1
OPENAI_API_KEY=your-together-key
LLM_MODEL=meta-llama/Llama-3.1-70B-Instruct-Turbo
```


------------------------------------------------------------------------

### Context Length Detection<a href="#context-length-detection" class="hash-link" aria-label="Direct link to Context Length Detection" translate="no" title="Direct link to Context Length Detection">​</a>

Hermes uses a multi-source resolution chain to detect the correct context window for your model and provider:

1.  **Config override** — `model.context_length` in config.yaml (highest priority)
2.  **Custom provider per-model** — `custom_providers[].models.<id>.context_length`
3.  **Persistent cache** — previously discovered values (survives restarts)
4.  **Endpoint `/models`** — queries your server's API (local/custom endpoints)
5.  **Anthropic `/v1/models`** — queries Anthropic's API for `max_input_tokens` (API-key users only)
6.  **OpenRouter API** — live model metadata from OpenRouter
7.  **Nous Portal** — suffix-matches Nous model IDs against OpenRouter metadata
8.  **<a href="https://models.dev" target="_blank" rel="noopener noreferrer">models.dev</a>** — community-maintained registry with provider-specific context lengths for 3800+ models across 100+ providers
9.  **Fallback defaults** — broad model family patterns (128K default)

For most setups this works out of the box. The system is provider-aware — the same model can have different context limits depending on who serves it (e.g., `claude-opus-4.6` is 1M on Anthropic direct but 128K on GitHub Copilot).

To set the context length explicitly, add `context_length` to your model config:


``` prism-code
model:
  default: "qwen3.5:9b"
  base_url: "http://localhost:8080/v1"
  context_length: 131072  # tokens
```


For custom endpoints, you can also set context length per model:


``` prism-code
custom_providers:
  - name: "My Local LLM"
    base_url: "http://localhost:11434/v1"
    models:
      qwen3.5:27b:
        context_length: 32768
      deepseek-r1:70b:
        context_length: 65536
```


`hermes model` will prompt for context length when configuring a custom endpoint. Leave it blank for auto-detection.


- You're using Ollama with a custom `num_ctx` that's lower than the model's maximum
- You want to limit context below the model's maximum (e.g., 8k on a 128k model to save VRAM)
- You're running behind a proxy that doesn't expose `/v1/models`


------------------------------------------------------------------------

### Named Custom Providers<a href="#named-custom-providers" class="hash-link" aria-label="Direct link to Named Custom Providers" translate="no" title="Direct link to Named Custom Providers">​</a>

If you work with multiple custom endpoints (e.g., a local dev server and a remote GPU server), you can define them as named custom providers in `config.yaml`:


``` prism-code
custom_providers:
  - name: local
    base_url: http://localhost:8080/v1
    # api_key omitted — Hermes uses "no-key-required" for keyless local servers
  - name: work
    base_url: https://gpu-server.internal.corp/v1
    api_key: corp-api-key
    api_mode: chat_completions   # optional, auto-detected from URL
  - name: anthropic-proxy
    base_url: https://proxy.example.com/anthropic
    api_key: proxy-key
    api_mode: anthropic_messages  # for Anthropic-compatible proxies
```


Switch between them mid-session with the triple syntax:


``` prism-code
/model custom:local:qwen-2.5       # Use the "local" endpoint with qwen-2.5
/model custom:work:llama3-70b      # Use the "work" endpoint with llama3-70b
/model custom:anthropic-proxy:claude-sonnet-4  # Use the proxy
```


You can also select named custom providers from the interactive `hermes model` menu.

------------------------------------------------------------------------

### Choosing the Right Setup<a href="#choosing-the-right-setup" class="hash-link" aria-label="Direct link to Choosing the Right Setup" translate="no" title="Direct link to Choosing the Right Setup">​</a>

| Use Case                     | Recommended                                                   |
|------------------------------|---------------------------------------------------------------|
| **Just want it to work**     | OpenRouter (default) or Nous Portal                           |
| **Local models, easy setup** | Ollama                                                        |
| **Production GPU serving**   | vLLM or SGLang                                                |
| **Mac / no GPU**             | Ollama or llama.cpp                                           |
| **Multi-provider routing**   | LiteLLM Proxy or OpenRouter                                   |
| **Cost optimization**        | ClawRouter or OpenRouter with `sort: "price"`                 |
| **Maximum privacy**          | Ollama, vLLM, or llama.cpp (fully local)                      |
| **Enterprise / Azure**       | Azure OpenAI with custom endpoint                             |
| **Chinese AI models**        | z.ai (GLM), Kimi/Moonshot, or MiniMax (first-class providers) |


You can switch between providers at any time with `hermes model` — no restart required. Your conversation history, memory, and skills carry over regardless of which provider you use.


## Optional API Keys<a href="#optional-api-keys" class="hash-link" aria-label="Direct link to Optional API Keys" translate="no" title="Direct link to Optional API Keys">​</a>

| Feature                          | Provider                                                                                                                                                                                     | Env Variable                                    |
|----------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------|
| Web scraping                     | <a href="https://firecrawl.dev/" target="_blank" rel="noopener noreferrer">Firecrawl</a>                                                                                                     | `FIRECRAWL_API_KEY`, `FIRECRAWL_API_URL`        |
| Browser automation               | <a href="https://browserbase.com/" target="_blank" rel="noopener noreferrer">Browserbase</a>                                                                                                 | `BROWSERBASE_API_KEY`, `BROWSERBASE_PROJECT_ID` |
| Image generation                 | <a href="https://fal.ai/" target="_blank" rel="noopener noreferrer">FAL</a>                                                                                                                  | `FAL_KEY`                                       |
| Premium TTS voices               | <a href="https://elevenlabs.io/" target="_blank" rel="noopener noreferrer">ElevenLabs</a>                                                                                                    | `ELEVENLABS_API_KEY`                            |
| OpenAI TTS + voice transcription | <a href="https://platform.openai.com/api-keys" target="_blank" rel="noopener noreferrer">OpenAI</a>                                                                                          | `VOICE_TOOLS_OPENAI_KEY`                        |
| RL Training                      | <a href="https://tinker-console.thinkingmachines.ai/" target="_blank" rel="noopener noreferrer">Tinker</a> + <a href="https://wandb.ai/" target="_blank" rel="noopener noreferrer">WandB</a> | `TINKER_API_KEY`, `WANDB_API_KEY`               |
| Cross-session user modeling      | <a href="https://honcho.dev/" target="_blank" rel="noopener noreferrer">Honcho</a>                                                                                                           | `HONCHO_API_KEY`                                |

### Self-Hosting Firecrawl<a href="#self-hosting-firecrawl" class="hash-link" aria-label="Direct link to Self-Hosting Firecrawl" translate="no" title="Direct link to Self-Hosting Firecrawl">​</a>

By default, Hermes uses the <a href="https://firecrawl.dev/" target="_blank" rel="noopener noreferrer">Firecrawl cloud API</a> for web search and scraping. If you prefer to run Firecrawl locally, you can point Hermes at a self-hosted instance instead. See Firecrawl's <a href="https://github.com/firecrawl/firecrawl/blob/main/SELF_HOST.md" target="_blank" rel="noopener noreferrer">SELF_HOST.md</a> for complete setup instructions.

**What you get:** No API key required, no rate limits, no per-page costs, full data sovereignty.

**What you lose:** The cloud version uses Firecrawl's proprietary "Fire-engine" for advanced anti-bot bypassing (Cloudflare, CAPTCHAs, IP rotation). Self-hosted uses basic fetch + Playwright, so some protected sites may fail. Search uses DuckDuckGo instead of Google.

**Setup:**

1.  Clone and start the Firecrawl Docker stack (5 containers: API, Playwright, Redis, RabbitMQ, PostgreSQL — requires ~4-8 GB RAM):

    <div class="language-bash codeBlockContainer_Ckt0 theme-code-block" style="--prism-color:#F8F8F2;--prism-background-color:#282A36">

    <div class="codeBlockContent_QJqH">

    ``` prism-code
    git clone https://github.com/firecrawl/firecrawl
    cd firecrawl
    # In .env, set: USE_DB_AUTHENTICATION=false, HOST=0.0.0.0, PORT=3002
    docker compose up -d
    ```

    </div>

    </div>

2.  Point Hermes at your instance (no API key needed):

    <div class="language-bash codeBlockContainer_Ckt0 theme-code-block" style="--prism-color:#F8F8F2;--prism-background-color:#282A36">

    <div class="codeBlockContent_QJqH">

    ``` prism-code
    hermes config set FIRECRAWL_API_URL http://localhost:3002
    ```

    </div>

    </div>

You can also set both `FIRECRAWL_API_KEY` and `FIRECRAWL_API_URL` if your self-hosted instance has authentication enabled.

## OpenRouter Provider Routing<a href="#openrouter-provider-routing" class="hash-link" aria-label="Direct link to OpenRouter Provider Routing" translate="no" title="Direct link to OpenRouter Provider Routing">​</a>

When using OpenRouter, you can control how requests are routed across providers. Add a `provider_routing` section to `~/.hermes/config.yaml`:


``` prism-code
provider_routing:
  sort: "throughput"          # "price" (default), "throughput", or "latency"
  # only: ["anthropic"]      # Only use these providers
  # ignore: ["deepinfra"]    # Skip these providers
  # order: ["anthropic", "google"]  # Try providers in this order
  # require_parameters: true  # Only use providers that support all request params
  # data_collection: "deny"   # Exclude providers that may store/train on data
```


**Shortcuts:** Append `:nitro` to any model name for throughput sorting (e.g., `anthropic/claude-sonnet-4:nitro`), or `:floor` for price sorting.

## Fallback Model<a href="#fallback-model" class="hash-link" aria-label="Direct link to Fallback Model" translate="no" title="Direct link to Fallback Model">​</a>

Configure a backup provider:model that Hermes switches to automatically when your primary model fails (rate limits, server errors, auth failures):


``` prism-code
fallback_model:
  provider: openrouter                    # required
  model: anthropic/claude-sonnet-4        # required
  # base_url: http://localhost:8000/v1    # optional, for custom endpoints
  # api_key_env: MY_CUSTOM_KEY           # optional, env var name for custom endpoint API key
```


When activated, the fallback swaps the model and provider mid-session without losing your conversation. It fires **at most once** per session.

Supported providers: `openrouter`, `nous`, `openai-codex`, `copilot`, `anthropic`, `huggingface`, `zai`, `kimi-coding`, `minimax`, `minimax-cn`, `custom`.


Fallback is configured exclusively through `config.yaml` — there are no environment variables for it. For full details on when it triggers, supported providers, and how it interacts with auxiliary tasks and delegation, see [Fallback Providers](/docs/user-guide/features/fallback-providers).


## Smart Model Routing<a href="#smart-model-routing" class="hash-link" aria-label="Direct link to Smart Model Routing" translate="no" title="Direct link to Smart Model Routing">​</a>

Optional cheap-vs-strong routing lets Hermes keep your main model for complex work while sending very short/simple turns to a cheaper model.


``` prism-code
smart_model_routing:
  enabled: true
  max_simple_chars: 160
  max_simple_words: 28
  cheap_model:
    provider: openrouter
    model: google/gemini-2.5-flash
    # base_url: http://localhost:8000/v1  # optional custom endpoint
    # api_key_env: MY_CUSTOM_KEY          # optional env var name for that endpoint's API key
```


How it works:

- If a turn is short, single-line, and does not look code/tool/debug heavy, Hermes may route it to `cheap_model`
- If the turn looks complex, Hermes stays on your primary model/provider
- If the cheap route cannot be resolved cleanly, Hermes falls back to the primary model automatically

This is intentionally conservative. It is meant for quick, low-stakes turns like:

- short factual questions
- quick rewrites
- lightweight summaries

It will avoid routing prompts that look like:

- coding/debugging work
- tool-heavy requests
- long or multi-line analysis asks

Use this when you want lower latency or cost without fully changing your default model.

## Terminal Backend Configuration<a href="#terminal-backend-configuration" class="hash-link" aria-label="Direct link to Terminal Backend Configuration" translate="no" title="Direct link to Terminal Backend Configuration">​</a>

Configure which environment the agent uses for terminal commands:


``` prism-code
terminal:
  backend: local    # or: docker, ssh, singularity, modal, daytona
  cwd: "."          # Working directory ("." = current dir)
  timeout: 180      # Command timeout in seconds

  # Docker-specific settings
  docker_image: "nikolaik/python-nodejs:python3.11-nodejs20"
  docker_mount_cwd_to_workspace: false  # SECURITY: off by default. Opt in to mount the launch cwd into /workspace.
  docker_forward_env:              # Optional explicit allowlist for env passthrough
    - "GITHUB_TOKEN"
  docker_volumes:                    # Additional explicit host mounts
    - "/home/user/projects:/workspace/projects"
    - "/home/user/data:/data:ro"     # :ro for read-only

  # Container resource limits (docker, singularity, modal, daytona)
  container_cpu: 1                   # CPU cores
  container_memory: 5120             # MB (default 5GB)
  container_disk: 51200              # MB (default 50GB)
  container_persistent: true         # Persist filesystem across sessions

  # Persistent shell — keep a long-lived bash process across commands
  persistent_shell: true             # Enabled by default for SSH backend
```


### Common Terminal Backend Issues<a href="#common-terminal-backend-issues" class="hash-link" aria-label="Direct link to Common Terminal Backend Issues" translate="no" title="Direct link to Common Terminal Backend Issues">​</a>

If terminal commands fail immediately or the terminal tool is reported as disabled, check the following:

- **Local backend**

  - No special requirements. This is the safest default when you are just getting started.

- **Docker backend**

  - Ensure Docker Desktop (or the Docker daemon) is installed and running.
  - Hermes needs to be able to find the `docker` CLI. It checks your `$PATH` first and also probes common Docker Desktop install locations on macOS. Run:
    <div class="language-bash codeBlockContainer_Ckt0 theme-code-block" style="--prism-color:#F8F8F2;--prism-background-color:#282A36">

    <div class="codeBlockContent_QJqH">

    ``` prism-code
    docker version
    ```

    </div>

    </div>

    If this fails, fix your Docker installation or switch back to the local backend:
    <div class="language-bash codeBlockContainer_Ckt0 theme-code-block" style="--prism-color:#F8F8F2;--prism-background-color:#282A36">

    <div class="codeBlockContent_QJqH">

    ``` prism-code
    hermes config set terminal.backend local
    ```

    </div>

    </div>

- **SSH backend**

  - Both `TERMINAL_SSH_HOST` and `TERMINAL_SSH_USER` must be set, for example:
    <div class="language-bash codeBlockContainer_Ckt0 theme-code-block" style="--prism-color:#F8F8F2;--prism-background-color:#282A36">

    <div class="codeBlockContent_QJqH">

    ``` prism-code
    export TERMINAL_ENV=ssh
    export TERMINAL_SSH_HOST=my-server.example.com
    export TERMINAL_SSH_USER=ubuntu
    ```

    </div>

    </div>
  - If either value is missing, Hermes will log a clear error and refuse to use the SSH backend.

- **Modal backend**

  - You need either a `MODAL_TOKEN_ID` environment variable or a `~/.modal.toml` config file.
  - If neither is present, the backend check fails and Hermes will report that the Modal backend is not available.

When in doubt, set `terminal.backend` back to `local` and verify that commands run there first.

### Docker Volume Mounts<a href="#docker-volume-mounts" class="hash-link" aria-label="Direct link to Docker Volume Mounts" translate="no" title="Direct link to Docker Volume Mounts">​</a>

When using the Docker backend, `docker_volumes` lets you share host directories with the container. Each entry uses standard Docker `-v` syntax: `host_path:container_path[:options]`.


``` prism-code
terminal:
  backend: docker
  docker_volumes:
    - "/home/user/projects:/workspace/projects"   # Read-write (default)
    - "/home/user/datasets:/data:ro"              # Read-only
    - "/home/user/outputs:/outputs"               # Agent writes, you read
```


This is useful for:

- **Providing files** to the agent (datasets, configs, reference code)
- **Receiving files** from the agent (generated code, reports, exports)
- **Shared workspaces** where both you and the agent access the same files

Can also be set via environment variable: `TERMINAL_DOCKER_VOLUMES='["/host:/container"]'` (JSON array).

### Docker Credential Forwarding<a href="#docker-credential-forwarding" class="hash-link" aria-label="Direct link to Docker Credential Forwarding" translate="no" title="Direct link to Docker Credential Forwarding">​</a>

By default, Docker terminal sessions do not inherit arbitrary host credentials. If you need a specific token inside the container, add it to `terminal.docker_forward_env`.


``` prism-code
terminal:
  backend: docker
  docker_forward_env:
    - "GITHUB_TOKEN"
    - "NPM_TOKEN"
```


Hermes resolves each listed variable from your current shell first, then falls back to `~/.hermes/.env` if it was saved with `hermes config set`.


Anything listed in `docker_forward_env` becomes visible to commands run inside the container. Only forward credentials you are comfortable exposing to the terminal session.


### Optional: Mount the Launch Directory into `/workspace`<a href="#optional-mount-the-launch-directory-into-workspace" class="hash-link" aria-label="Direct link to optional-mount-the-launch-directory-into-workspace" translate="no" title="Direct link to optional-mount-the-launch-directory-into-workspace">​</a>

Docker sandboxes stay isolated by default. Hermes does **not** pass your current host working directory into the container unless you explicitly opt in.

Enable it in `config.yaml`:


``` prism-code
terminal:
  backend: docker
  docker_mount_cwd_to_workspace: true
```


When enabled:

- if you launch Hermes from `~/projects/my-app`, that host directory is bind-mounted to `/workspace`
- the Docker backend starts in `/workspace`
- file tools and terminal commands both see the same mounted project

When disabled, `/workspace` stays sandbox-owned unless you explicitly mount something via `docker_volumes`.

Security tradeoff:

- `false` preserves the sandbox boundary
- `true` gives the sandbox direct access to the directory you launched Hermes from

Use the opt-in only when you intentionally want the container to work on live host files.

### Persistent Shell<a href="#persistent-shell" class="hash-link" aria-label="Direct link to Persistent Shell" translate="no" title="Direct link to Persistent Shell">​</a>

By default, each terminal command runs in its own subprocess — working directory, environment variables, and shell variables reset between commands. When **persistent shell** is enabled, a single long-lived bash process is kept alive across `execute()` calls so that state survives between commands.

This is most useful for the **SSH backend**, where it also eliminates per-command connection overhead. Persistent shell is **enabled by default for SSH** and disabled for the local backend.


``` prism-code
terminal:
  persistent_shell: true   # default — enables persistent shell for SSH
```


To disable:


``` prism-code
hermes config set terminal.persistent_shell false
```


**What persists across commands:**

- Working directory (`cd /tmp` sticks for the next command)
- Exported environment variables (`export FOO=bar`)
- Shell variables (`MY_VAR=hello`)

**Precedence:**

| Level          | Variable                    | Default        |
|----------------|-----------------------------|----------------|
| Config         | `terminal.persistent_shell` | `true`         |
| SSH override   | `TERMINAL_SSH_PERSISTENT`   | follows config |
| Local override | `TERMINAL_LOCAL_PERSISTENT` | `false`        |

Per-backend environment variables take highest precedence. If you want persistent shell on the local backend too:


``` prism-code
export TERMINAL_LOCAL_PERSISTENT=true
```


Commands that require `stdin_data` or sudo automatically fall back to one-shot mode, since the persistent shell's stdin is already occupied by the IPC protocol.


See [Code Execution](/docs/user-guide/features/code-execution) and the [Terminal section of the README](/docs/user-guide/features/tools) for details on each backend.

## Memory Configuration<a href="#memory-configuration" class="hash-link" aria-label="Direct link to Memory Configuration" translate="no" title="Direct link to Memory Configuration">​</a>


``` prism-code
memory:
  memory_enabled: true
  user_profile_enabled: true
  memory_char_limit: 2200   # ~800 tokens
  user_char_limit: 1375     # ~500 tokens
```


## Git Worktree Isolation<a href="#git-worktree-isolation" class="hash-link" aria-label="Direct link to Git Worktree Isolation" translate="no" title="Direct link to Git Worktree Isolation">​</a>

Enable isolated git worktrees for running multiple agents in parallel on the same repo:


``` prism-code
worktree: true    # Always create a worktree (same as hermes -w)
# worktree: false # Default — only when -w flag is passed
```


When enabled, each CLI session creates a fresh worktree under `.worktrees/` with its own branch. Agents can edit files, commit, push, and create PRs without interfering with each other. Clean worktrees are removed on exit; dirty ones are kept for manual recovery.

You can also list gitignored files to copy into worktrees via `.worktreeinclude` in your repo root:


``` prism-code
# .worktreeinclude
.env
.venv/
node_modules/
```


## Context Compression<a href="#context-compression" class="hash-link" aria-label="Direct link to Context Compression" translate="no" title="Direct link to Context Compression">​</a>

Hermes automatically compresses long conversations to stay within your model's context window. The compression summarizer is a separate LLM call — you can point it at any provider or endpoint.

All compression settings live in `config.yaml` (no environment variables).

### Full reference<a href="#full-reference" class="hash-link" aria-label="Direct link to Full reference" translate="no" title="Direct link to Full reference">​</a>


``` prism-code
compression:
  enabled: true                                     # Toggle compression on/off
  threshold: 0.50                                   # Compress at this % of context limit
  summary_model: "google/gemini-3-flash-preview"    # Model for summarization
  summary_provider: "auto"                          # Provider: "auto", "openrouter", "nous", "codex", "main", etc.
  summary_base_url: null                            # Custom OpenAI-compatible endpoint (overrides provider)
```


### Common setups<a href="#common-setups" class="hash-link" aria-label="Direct link to Common setups" translate="no" title="Direct link to Common setups">​</a>

**Default (auto-detect) — no configuration needed:**


``` prism-code
compression:
  enabled: true
  threshold: 0.50
```


Uses the first available provider (OpenRouter → Nous → Codex) with Gemini Flash.

**Force a specific provider** (OAuth or API-key based):


``` prism-code
compression:
  summary_provider: nous
  summary_model: gemini-3-flash
```


Works with any provider: `nous`, `openrouter`, `codex`, `anthropic`, `main`, etc.

**Custom endpoint** (self-hosted, Ollama, zai, DeepSeek, etc.):


``` prism-code
compression:
  summary_model: glm-4.7
  summary_base_url: https://api.z.ai/api/coding/paas/v4
```


Points at a custom OpenAI-compatible endpoint. Uses `OPENAI_API_KEY` for auth.

### How the three knobs interact<a href="#how-the-three-knobs-interact" class="hash-link" aria-label="Direct link to How the three knobs interact" translate="no" title="Direct link to How the three knobs interact">​</a>

| `summary_provider`           | `summary_base_url` | Result                                              |
|------------------------------|--------------------|-----------------------------------------------------|
| `auto` (default)             | not set            | Auto-detect best available provider                 |
| `nous` / `openrouter` / etc. | not set            | Force that provider, use its auth                   |
| any                          | set                | Use the custom endpoint directly (provider ignored) |

The `summary_model` must support a context length at least as large as your main model's, since it receives the full middle section of the conversation for compression.

## Iteration Budget Pressure<a href="#iteration-budget-pressure" class="hash-link" aria-label="Direct link to Iteration Budget Pressure" translate="no" title="Direct link to Iteration Budget Pressure">​</a>

When the agent is working on a complex task with many tool calls, it can burn through its iteration budget (default: 90 turns) without realizing it's running low. Budget pressure automatically warns the model as it approaches the limit:

| Threshold | Level   | What the model sees                                         |
|-----------|---------|-------------------------------------------------------------|
| **70%**   | Caution | `[BUDGET: 63/90. 27 iterations left. Start consolidating.]` |
| **90%**   | Warning | `[BUDGET WARNING: 81/90. Only 9 left. Respond NOW.]`        |

Warnings are injected into the last tool result's JSON (as a `_budget_warning` field) rather than as separate messages — this preserves prompt caching and doesn't disrupt the conversation structure.


``` prism-code
agent:
  max_turns: 90                # Max iterations per conversation turn (default: 90)
```


Budget pressure is enabled by default. The agent sees warnings naturally as part of tool results, encouraging it to consolidate its work and deliver a response before running out of iterations.

## Context Pressure Warnings<a href="#context-pressure-warnings" class="hash-link" aria-label="Direct link to Context Pressure Warnings" translate="no" title="Direct link to Context Pressure Warnings">​</a>

Separate from iteration budget pressure, context pressure tracks how close the conversation is to the **compaction threshold** — the point where context compression fires to summarize older messages. This helps both you and the agent understand when the conversation is getting long.

| Progress               | Level   | What happens                                                         |
|------------------------|---------|----------------------------------------------------------------------|
| **≥ 60%** to threshold | Info    | CLI shows a cyan progress bar; gateway sends an informational notice |
| **≥ 85%** to threshold | Warning | CLI shows a bold yellow bar; gateway warns compaction is imminent    |

In the CLI, context pressure appears as a progress bar in the tool output feed:


``` prism-code
  ◐ context ████████████░░░░░░░░ 62% to compaction  48k threshold (50%) · approaching compaction
```


On messaging platforms, a plain-text notification is sent:


``` prism-code
◐ Context: ████████████░░░░░░░░ 62% to compaction (threshold: 50% of window).
```


If auto-compression is disabled, the warning tells you context may be truncated instead.

Context pressure is automatic — no configuration needed. It fires purely as a user-facing notification and does not modify the message stream or inject anything into the model's context.

## Auxiliary Models<a href="#auxiliary-models" class="hash-link" aria-label="Direct link to Auxiliary Models" translate="no" title="Direct link to Auxiliary Models">​</a>

Hermes uses lightweight "auxiliary" models for side tasks like image analysis, web page summarization, and browser screenshot analysis. By default, these use **Gemini Flash** via auto-detection — you don't need to configure anything.

### The universal config pattern<a href="#the-universal-config-pattern" class="hash-link" aria-label="Direct link to The universal config pattern" translate="no" title="Direct link to The universal config pattern">​</a>

Every model slot in Hermes — auxiliary tasks, compression, fallback — uses the same three knobs:

| Key        | What it does                                           | Default            |
|------------|--------------------------------------------------------|--------------------|
| `provider` | Which provider to use for auth and routing             | `"auto"`           |
| `model`    | Which model to request                                 | provider's default |
| `base_url` | Custom OpenAI-compatible endpoint (overrides provider) | not set            |

When `base_url` is set, Hermes ignores the provider and calls that endpoint directly (using `api_key` or `OPENAI_API_KEY` for auth). When only `provider` is set, Hermes uses that provider's built-in auth and base URL.

Available providers: `auto`, `openrouter`, `nous`, `codex`, `copilot`, `anthropic`, `main`, `zai`, `kimi-coding`, `minimax`, and any provider registered in the [provider registry](/docs/reference/environment-variables).

### Full auxiliary config reference<a href="#full-auxiliary-config-reference" class="hash-link" aria-label="Direct link to Full auxiliary config reference" translate="no" title="Direct link to Full auxiliary config reference">​</a>


``` prism-code
auxiliary:
  # Image analysis (vision_analyze tool + browser screenshots)
  vision:
    provider: "auto"           # "auto", "openrouter", "nous", "codex", "main", etc.
    model: ""                  # e.g. "openai/gpt-4o", "google/gemini-2.5-flash"
    base_url: ""               # Custom OpenAI-compatible endpoint (overrides provider)
    api_key: ""                # API key for base_url (falls back to OPENAI_API_KEY)
    timeout: 30                # seconds — increase for slow local vision models

  # Web page summarization + browser page text extraction
  web_extract:
    provider: "auto"
    model: ""                  # e.g. "google/gemini-2.5-flash"
    base_url: ""
    api_key: ""
    timeout: 30                # seconds

  # Dangerous command approval classifier
  approval:
    provider: "auto"
    model: ""
    base_url: ""
    api_key: ""
    timeout: 30                # seconds

  # Context compression timeout (separate from compression.* config)
  compression:
    timeout: 120               # seconds — compression summarizes long conversations, needs more time
```


Each auxiliary task has a configurable `timeout` (in seconds). Defaults: vision 30s, web_extract 30s, approval 30s, compression 120s. Increase these if you use slow local models for auxiliary tasks.


Context compression has its own top-level `compression:` block with `summary_provider`, `summary_model`, and `summary_base_url` — see [Context Compression](#context-compression) above. The fallback model uses a `fallback_model:` block — see [Fallback Model](#fallback-model) above. All three follow the same provider/model/base_url pattern.


### Changing the Vision Model<a href="#changing-the-vision-model" class="hash-link" aria-label="Direct link to Changing the Vision Model" translate="no" title="Direct link to Changing the Vision Model">​</a>

To use GPT-4o instead of Gemini Flash for image analysis:


``` prism-code
auxiliary:
  vision:
    model: "openai/gpt-4o"
```


Or via environment variable (in `~/.hermes/.env`):


``` prism-code
AUXILIARY_VISION_MODEL=openai/gpt-4o
```


### Provider Options<a href="#provider-options" class="hash-link" aria-label="Direct link to Provider Options" translate="no" title="Direct link to Provider Options">​</a>

| Provider       | Description                                                                                                                                                                                                                      | Requirements                           |
|----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------|
| `"auto"`       | Best available (default). Vision tries OpenRouter → Nous → Codex.                                                                                                                                                                | —                                      |
| `"openrouter"` | Force OpenRouter — routes to any model (Gemini, GPT-4o, Claude, etc.)                                                                                                                                                            | `OPENROUTER_API_KEY`                   |
| `"nous"`       | Force Nous Portal                                                                                                                                                                                                                | `hermes login`                         |
| `"codex"`      | Force Codex OAuth (ChatGPT account). Supports vision (gpt-5.3-codex).                                                                                                                                                            | `hermes model` → Codex                 |
| `"main"`       | Use your active custom/main endpoint. This can come from `OPENAI_BASE_URL` + `OPENAI_API_KEY` or from a custom endpoint saved via `hermes model` / `config.yaml`. Works with OpenAI, local models, or any OpenAI-compatible API. | Custom endpoint credentials + base URL |

### Common Setups<a href="#common-setups-1" class="hash-link" aria-label="Direct link to Common Setups" translate="no" title="Direct link to Common Setups">​</a>

**Using a direct custom endpoint** (clearer than `provider: "main"` for local/self-hosted APIs):


``` prism-code
auxiliary:
  vision:
    base_url: "http://localhost:1234/v1"
    api_key: "local-key"
    model: "qwen2.5-vl"
```


`base_url` takes precedence over `provider`, so this is the most explicit way to route an auxiliary task to a specific endpoint. For direct endpoint overrides, Hermes uses the configured `api_key` or falls back to `OPENAI_API_KEY`; it does not reuse `OPENROUTER_API_KEY` for that custom endpoint.

**Using OpenAI API key for vision:**


``` prism-code
# In ~/.hermes/.env:
# OPENAI_BASE_URL=https://api.openai.com/v1
# OPENAI_API_KEY=sk-...

auxiliary:
  vision:
    provider: "main"
    model: "gpt-4o"       # or "gpt-4o-mini" for cheaper
```


**Using OpenRouter for vision** (route to any model):


``` prism-code
auxiliary:
  vision:
    provider: "openrouter"
    model: "openai/gpt-4o"      # or "google/gemini-2.5-flash", etc.
```


**Using Codex OAuth** (ChatGPT Pro/Plus account — no API key needed):


``` prism-code
auxiliary:
  vision:
    provider: "codex"     # uses your ChatGPT OAuth token
    # model defaults to gpt-5.3-codex (supports vision)
```


**Using a local/self-hosted model:**


``` prism-code
auxiliary:
  vision:
    provider: "main"      # uses your active custom endpoint
    model: "my-local-model"
```


`provider: "main"` follows the same custom endpoint Hermes uses for normal chat. That endpoint can be set directly with `OPENAI_BASE_URL`, or saved once through `hermes model` and persisted in `config.yaml`.


If you use Codex OAuth as your main model provider, vision works automatically — no extra configuration needed. Codex is included in the auto-detection chain for vision.


**Vision requires a multimodal model.** If you set `provider: "main"`, make sure your endpoint supports multimodal/vision — otherwise image analysis will fail.


### Environment Variables (legacy)<a href="#environment-variables-legacy" class="hash-link" aria-label="Direct link to Environment Variables (legacy)" translate="no" title="Direct link to Environment Variables (legacy)">​</a>

Auxiliary models can also be configured via environment variables. However, `config.yaml` is the preferred method — it's easier to manage and supports all options including `base_url` and `api_key`.

| Setting              | Environment Variable             |
|----------------------|----------------------------------|
| Vision provider      | `AUXILIARY_VISION_PROVIDER`      |
| Vision model         | `AUXILIARY_VISION_MODEL`         |
| Vision endpoint      | `AUXILIARY_VISION_BASE_URL`      |
| Vision API key       | `AUXILIARY_VISION_API_KEY`       |
| Web extract provider | `AUXILIARY_WEB_EXTRACT_PROVIDER` |
| Web extract model    | `AUXILIARY_WEB_EXTRACT_MODEL`    |
| Web extract endpoint | `AUXILIARY_WEB_EXTRACT_BASE_URL` |
| Web extract API key  | `AUXILIARY_WEB_EXTRACT_API_KEY`  |

Compression and fallback model settings are config.yaml-only.


Run `hermes config` to see your current auxiliary model settings. Overrides only show up when they differ from the defaults.


## Reasoning Effort<a href="#reasoning-effort" class="hash-link" aria-label="Direct link to Reasoning Effort" translate="no" title="Direct link to Reasoning Effort">​</a>

Control how much "thinking" the model does before responding:


``` prism-code
agent:
  reasoning_effort: ""   # empty = medium (default). Options: xhigh (max), high, medium, low, minimal, none
```


When unset (default), reasoning effort defaults to "medium" — a balanced level that works well for most tasks. Setting a value overrides it — higher reasoning effort gives better results on complex tasks at the cost of more tokens and latency.

You can also change the reasoning effort at runtime with the `/reasoning` command:


``` prism-code
/reasoning           # Show current effort level and display state
/reasoning high      # Set reasoning effort to high
/reasoning none      # Disable reasoning
/reasoning show      # Show model thinking above each response
/reasoning hide      # Hide model thinking
```


## Tool-Use Enforcement<a href="#tool-use-enforcement" class="hash-link" aria-label="Direct link to Tool-Use Enforcement" translate="no" title="Direct link to Tool-Use Enforcement">​</a>

Some models (especially GPT-family) occasionally describe intended actions as text instead of making tool calls. Tool-use enforcement injects guidance that steers the model back to actually calling tools.


``` prism-code
agent:
  tool_use_enforcement: "auto"   # "auto" | true | false | ["model-substring", ...]
```


| Value                             | Behavior                                                                    |
|-----------------------------------|-----------------------------------------------------------------------------|
| `"auto"` (default)                | Enabled for GPT models (`gpt-`, `openai/gpt-`) and disabled for all others. |
| `true`                            | Always enabled for all models.                                              |
| `false`                           | Always disabled.                                                            |
| `["gpt-", "o1-", "custom-model"]` | Enabled only for models whose name contains one of the listed substrings.   |

When enabled, the system prompt includes guidance reminding the model to make actual tool calls rather than describing what it would do. This is transparent to the user and has no effect on models that already use tools reliably.

## TTS Configuration<a href="#tts-configuration" class="hash-link" aria-label="Direct link to TTS Configuration" translate="no" title="Direct link to TTS Configuration">​</a>


``` prism-code
tts:
  provider: "edge"              # "edge" | "elevenlabs" | "openai" | "neutts"
  edge:
    voice: "en-US-AriaNeural"   # 322 voices, 74 languages
  elevenlabs:
    voice_id: "pNInz6obpgDQGcFmaJgB"
    model_id: "eleven_multilingual_v2"
  openai:
    model: "gpt-4o-mini-tts"
    voice: "alloy"              # alloy, echo, fable, onyx, nova, shimmer
    base_url: "https://api.openai.com/v1"  # Override for OpenAI-compatible TTS endpoints
  neutts:
    ref_audio: ''
    ref_text: ''
    model: neuphonic/neutts-air-q4-gguf
    device: cpu
```


This controls both the `text_to_speech` tool and spoken replies in voice mode (`/voice tts` in the CLI or messaging gateway).

## Display Settings<a href="#display-settings" class="hash-link" aria-label="Direct link to Display Settings" translate="no" title="Direct link to Display Settings">​</a>


``` prism-code
display:
  tool_progress: all      # off | new | all | verbose
  tool_progress_command: false  # Enable /verbose slash command in messaging gateway
  skin: default           # Built-in or custom CLI skin (see user-guide/features/skins)
  theme_mode: auto        # auto | light | dark — color scheme for skin-aware rendering
  personality: "kawaii"  # Legacy cosmetic field still surfaced in some summaries
  compact: false          # Compact output mode (less whitespace)
  resume_display: full    # full (show previous messages on resume) | minimal (one-liner only)
  bell_on_complete: false # Play terminal bell when agent finishes (great for long tasks)
  show_reasoning: false   # Show model reasoning/thinking above each response (toggle with /reasoning show|hide)
  streaming: false        # Stream tokens to terminal as they arrive (real-time output)
  background_process_notifications: all  # all | result | error | off (gateway only)
  show_cost: false        # Show estimated $ cost in the CLI status bar
```


### Theme mode<a href="#theme-mode" class="hash-link" aria-label="Direct link to Theme mode" translate="no" title="Direct link to Theme mode">​</a>

The `theme_mode` setting controls whether skins render in light or dark mode:

| Mode             | Behavior                                                                                                                              |
|------------------|---------------------------------------------------------------------------------------------------------------------------------------|
| `auto` (default) | Detects your terminal's background color automatically. Falls back to `dark` if detection fails.                                      |
| `light`          | Forces light-mode skin colors. Skins that define a `colors_light` override use those colors instead of the default dark-mode palette. |
| `dark`           | Forces dark-mode skin colors.                                                                                                         |

This works with any skin — built-in or custom. Skin authors can provide `colors_light` in their skin definition for optimal light-terminal appearance.

| Mode      | What you see                                   |
|-----------|------------------------------------------------|
| `off`     | Silent — just the final response               |
| `new`     | Tool indicator only when the tool changes      |
| `all`     | Every tool call with a short preview (default) |
| `verbose` | Full args, results, and debug logs             |

In the CLI, cycle through these modes with `/verbose`. To use `/verbose` in messaging platforms (Telegram, Discord, Slack, etc.), set `tool_progress_command: true` in the `display` section above. The command will then cycle the mode and save to config.

## Privacy<a href="#privacy" class="hash-link" aria-label="Direct link to Privacy" translate="no" title="Direct link to Privacy">​</a>


``` prism-code
privacy:
  redact_pii: false  # Strip PII from LLM context (gateway only)
```


When `redact_pii` is `true`, the gateway redacts personally identifiable information from the system prompt before sending it to the LLM on supported platforms:

| Field                                      | Treatment                                                             |
|--------------------------------------------|-----------------------------------------------------------------------|
| Phone numbers (user ID on WhatsApp/Signal) | Hashed to `user_<12-char-sha256>`                                     |
| User IDs                                   | Hashed to `user_<12-char-sha256>`                                     |
| Chat IDs                                   | Numeric portion hashed, platform prefix preserved (`telegram:<hash>`) |
| Home channel IDs                           | Numeric portion hashed                                                |
| User names / usernames                     | **Not affected** (user-chosen, publicly visible)                      |

**Platform support:** Redaction applies to WhatsApp, Signal, and Telegram. Discord and Slack are excluded because their mention systems (`<@user_id>`) require the real ID in the LLM context.

Hashes are deterministic — the same user always maps to the same hash, so the model can still distinguish between users in group chats. Routing and delivery use the original values internally.

## Speech-to-Text (STT)<a href="#speech-to-text-stt" class="hash-link" aria-label="Direct link to Speech-to-Text (STT)" translate="no" title="Direct link to Speech-to-Text (STT)">​</a>


``` prism-code
stt:
  provider: "local"            # "local" | "groq" | "openai"
  local:
    model: "base"              # tiny, base, small, medium, large-v3
  openai:
    model: "whisper-1"         # whisper-1 | gpt-4o-mini-transcribe | gpt-4o-transcribe
  # model: "whisper-1"         # Legacy fallback key still respected
```


Provider behavior:

- `local` uses `faster-whisper` running on your machine. Install it separately with `pip install faster-whisper`.
- `groq` uses Groq's Whisper-compatible endpoint and reads `GROQ_API_KEY`.
- `openai` uses the OpenAI speech API and reads `VOICE_TOOLS_OPENAI_KEY`.

If the requested provider is unavailable, Hermes falls back automatically in this order: `local` → `groq` → `openai`.

Groq and OpenAI model overrides are environment-driven:


``` prism-code
STT_GROQ_MODEL=whisper-large-v3-turbo
STT_OPENAI_MODEL=whisper-1
GROQ_BASE_URL=https://api.groq.com/openai/v1
STT_OPENAI_BASE_URL=https://api.openai.com/v1
```


## Voice Mode (CLI)<a href="#voice-mode-cli" class="hash-link" aria-label="Direct link to Voice Mode (CLI)" translate="no" title="Direct link to Voice Mode (CLI)">​</a>


``` prism-code
voice:
  record_key: "ctrl+b"         # Push-to-talk key inside the CLI
  max_recording_seconds: 120    # Hard stop for long recordings
  auto_tts: false               # Enable spoken replies automatically when /voice on
  silence_threshold: 200        # RMS threshold for speech detection
  silence_duration: 3.0         # Seconds of silence before auto-stop
```


Use `/voice on` in the CLI to enable microphone mode, `record_key` to start/stop recording, and `/voice tts` to toggle spoken replies. See [Voice Mode](/docs/user-guide/features/voice-mode) for end-to-end setup and platform-specific behavior.

## Streaming<a href="#streaming" class="hash-link" aria-label="Direct link to Streaming" translate="no" title="Direct link to Streaming">​</a>

Stream tokens to the terminal or messaging platforms as they arrive, instead of waiting for the full response.

### CLI Streaming<a href="#cli-streaming" class="hash-link" aria-label="Direct link to CLI Streaming" translate="no" title="Direct link to CLI Streaming">​</a>


``` prism-code
display:
  streaming: true         # Stream tokens to terminal in real-time
  show_reasoning: true    # Also stream reasoning/thinking tokens (optional)
```


When enabled, responses appear token-by-token inside a streaming box. Tool calls are still captured silently. If the provider doesn't support streaming, it falls back to the normal display automatically.

### Gateway Streaming (Telegram, Discord, Slack)<a href="#gateway-streaming-telegram-discord-slack" class="hash-link" aria-label="Direct link to Gateway Streaming (Telegram, Discord, Slack)" translate="no" title="Direct link to Gateway Streaming (Telegram, Discord, Slack)">​</a>


``` prism-code
streaming:
  enabled: true           # Enable progressive message editing
  edit_interval: 0.3      # Seconds between message edits
  buffer_threshold: 40    # Characters before forcing an edit flush
  cursor: " ▉"            # Cursor shown during streaming
```


When enabled, the bot sends a message on the first token, then progressively edits it as more tokens arrive. Platforms that don't support message editing (Signal, Email) gracefully skip streaming and deliver the final response normally.


Streaming is disabled by default. Enable it in `~/.hermes/config.yaml` to try the streaming UX.


## Group Chat Session Isolation<a href="#group-chat-session-isolation" class="hash-link" aria-label="Direct link to Group Chat Session Isolation" translate="no" title="Direct link to Group Chat Session Isolation">​</a>

Control whether shared chats keep one conversation per room or one conversation per participant:


``` prism-code
group_sessions_per_user: true  # true = per-user isolation in groups/channels, false = one shared session per chat
```


- `true` is the default and recommended setting. In Discord channels, Telegram groups, Slack channels, and similar shared contexts, each sender gets their own session when the platform provides a user ID.
- `false` reverts to the old shared-room behavior. That can be useful if you explicitly want Hermes to treat a channel like one collaborative conversation, but it also means users share context, token costs, and interrupt state.
- Direct messages are unaffected. Hermes still keys DMs by chat/DM ID as usual.
- Threads stay isolated from their parent channel either way; with `true`, each participant also gets their own session inside the thread.

For the behavior details and examples, see [Sessions](/docs/user-guide/sessions) and the [Discord guide](/docs/user-guide/messaging/discord).

## Unauthorized DM Behavior<a href="#unauthorized-dm-behavior" class="hash-link" aria-label="Direct link to Unauthorized DM Behavior" translate="no" title="Direct link to Unauthorized DM Behavior">​</a>

Control what Hermes does when an unknown user sends a direct message:


``` prism-code
unauthorized_dm_behavior: pair

whatsapp:
  unauthorized_dm_behavior: ignore
```


- `pair` is the default. Hermes denies access, but replies with a one-time pairing code in DMs.
- `ignore` silently drops unauthorized DMs.
- Platform sections override the global default, so you can keep pairing enabled broadly while making one platform quieter.

## Quick Commands<a href="#quick-commands" class="hash-link" aria-label="Direct link to Quick Commands" translate="no" title="Direct link to Quick Commands">​</a>

Define custom commands that run shell commands without invoking the LLM — zero token usage, instant execution. Especially useful from messaging platforms (Telegram, Discord, etc.) for quick server checks or utility scripts.


``` prism-code
quick_commands:
  status:
    type: exec
    command: systemctl status hermes-agent
  disk:
    type: exec
    command: df -h /
  update:
    type: exec
    command: cd ~/.hermes/hermes-agent && git pull && pip install -e .
  gpu:
    type: exec
    command: nvidia-smi --query-gpu=name,utilization.gpu,memory.used,memory.total --format=csv,noheader
```


Usage: type `/status`, `/disk`, `/update`, or `/gpu` in the CLI or any messaging platform. The command runs locally on the host and returns the output directly — no LLM call, no tokens consumed.

- **30-second timeout** — long-running commands are killed with an error message
- **Priority** — quick commands are checked before skill commands, so you can override skill names
- **Autocomplete** — quick commands are resolved at dispatch time and are not shown in the built-in slash-command autocomplete tables
- **Type** — only `exec` is supported (runs a shell command); other types show an error
- **Works everywhere** — CLI, Telegram, Discord, Slack, WhatsApp, Signal, Email, Home Assistant

## Gateway Streaming<a href="#gateway-streaming" class="hash-link" aria-label="Direct link to Gateway Streaming" translate="no" title="Direct link to Gateway Streaming">​</a>

Enable progressive token delivery on messaging platforms. When streaming is enabled, responses appear character-by-character in Telegram, Discord, and Slack via message editing, rather than waiting for the full response.


``` prism-code
streaming:
  enabled: false              # Enable streaming token delivery (default: off)
  transport: edit             # "edit" (progressive message editing) or "off"
  edit_interval: 0.3          # Min seconds between message edits
  buffer_threshold: 40        # Characters accumulated before forcing an edit
  cursor: " ▉"               # Cursor character shown during streaming
```


**Platform support:** Telegram, Discord, and Slack support edit-based streaming. Platforms that don't support message editing (Signal, Email, Home Assistant) are auto-detected on the first attempt — streaming is gracefully disabled for that session with no flood of messages.

**Overflow handling:** If the streamed text exceeds the platform's message length limit (~4096 chars), the current message is finalized and a new one starts automatically.

## Human Delay<a href="#human-delay" class="hash-link" aria-label="Direct link to Human Delay" translate="no" title="Direct link to Human Delay">​</a>

Simulate human-like response pacing in messaging platforms:


``` prism-code
human_delay:
  mode: "off"                  # off | natural | custom
  min_ms: 800                  # Minimum delay (custom mode)
  max_ms: 2500                 # Maximum delay (custom mode)
```


## Code Execution<a href="#code-execution" class="hash-link" aria-label="Direct link to Code Execution" translate="no" title="Direct link to Code Execution">​</a>

Configure the sandboxed Python code execution tool:


``` prism-code
code_execution:
  timeout: 300                 # Max execution time in seconds
  max_tool_calls: 50           # Max tool calls within code execution
```


## Web Search Backends<a href="#web-search-backends" class="hash-link" aria-label="Direct link to Web Search Backends" translate="no" title="Direct link to Web Search Backends">​</a>

The `web_search`, `web_extract`, and `web_crawl` tools support three backend providers. Configure the backend in `config.yaml` or via `hermes tools`:


``` prism-code
web:
  backend: firecrawl    # firecrawl | parallel | tavily
```


| Backend                 | Env Var             | Search | Extract | Crawl |
|-------------------------|---------------------|--------|---------|-------|
| **Firecrawl** (default) | `FIRECRAWL_API_KEY` | ✔      | ✔       | ✔     |
| **Parallel**            | `PARALLEL_API_KEY`  | ✔      | ✔       | —     |
| **Tavily**              | `TAVILY_API_KEY`    | ✔      | ✔       | ✔     |

**Backend selection:** If `web.backend` is not set, the backend is auto-detected from available API keys. If only `TAVILY_API_KEY` is set, Tavily is used. If only `PARALLEL_API_KEY` is set, Parallel is used. Otherwise Firecrawl is the default.

**Self-hosted Firecrawl:** Set `FIRECRAWL_API_URL` to point at your own instance. When a custom URL is set, the API key becomes optional (set `USE_DB_AUTHENTICATION=false` on the server to disable auth).

**Parallel search modes:** Set `PARALLEL_SEARCH_MODE` to control search behavior — `fast`, `one-shot`, or `agentic` (default: `agentic`).

## Browser<a href="#browser" class="hash-link" aria-label="Direct link to Browser" translate="no" title="Direct link to Browser">​</a>

Configure browser automation behavior:


``` prism-code
browser:
  inactivity_timeout: 120        # Seconds before auto-closing idle sessions
  record_sessions: false         # Auto-record browser sessions as WebM videos to ~/.hermes/browser_recordings/
```


The browser toolset supports multiple providers. See the [Browser feature page](/docs/user-guide/features/browser) for details on Browserbase, Browser Use, and local Chrome CDP setup.

## Website Blocklist<a href="#website-blocklist" class="hash-link" aria-label="Direct link to Website Blocklist" translate="no" title="Direct link to Website Blocklist">​</a>

Block specific domains from being accessed by the agent's web and browser tools:


``` prism-code
security:
  website_blocklist:
    enabled: false               # Enable URL blocking (default: false)
    domains:                     # List of blocked domain patterns
      - "*.internal.company.com"
      - "admin.example.com"
      - "*.local"
    shared_files:                # Load additional rules from external files
      - "/etc/hermes/blocked-sites.txt"
```


When enabled, any URL matching a blocked domain pattern is rejected before the web or browser tool executes. This applies to `web_search`, `web_extract`, `browser_navigate`, and any tool that accesses URLs.

Domain rules support:

- Exact domains: `admin.example.com`
- Wildcard subdomains: `*.internal.company.com` (blocks all subdomains)
- TLD wildcards: `*.local`

Shared files contain one domain rule per line (blank lines and `#` comments are ignored). Missing or unreadable files log a warning but don't disable other web tools.

The policy is cached for 30 seconds, so config changes take effect quickly without restart.

## Smart Approvals<a href="#smart-approvals" class="hash-link" aria-label="Direct link to Smart Approvals" translate="no" title="Direct link to Smart Approvals">​</a>

Control how Hermes handles potentially dangerous commands:


``` prism-code
approvals:
  mode: manual   # manual | smart | off
```


| Mode               | Behavior                                                                                                                                                                                                |
|--------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| `manual` (default) | Prompt the user before executing any flagged command. In the CLI, shows an interactive approval dialog. In messaging, queues a pending approval request.                                                |
| `smart`            | Use an auxiliary LLM to assess whether a flagged command is actually dangerous. Low-risk commands are auto-approved with session-level persistence. Genuinely risky commands are escalated to the user. |
| `off`              | Skip all approval checks. Equivalent to `HERMES_YOLO_MODE=true`. **Use with caution.**                                                                                                                  |

Smart mode is particularly useful for reducing approval fatigue — it lets the agent work more autonomously on safe operations while still catching genuinely destructive commands.


Setting `approvals.mode: off` disables all safety checks for terminal commands. Only use this in trusted, sandboxed environments.


## Checkpoints<a href="#checkpoints" class="hash-link" aria-label="Direct link to Checkpoints" translate="no" title="Direct link to Checkpoints">​</a>

Automatic filesystem snapshots before destructive file operations. See the [Checkpoints feature page](/docs/user-guide/features/checkpoints) for details.


``` prism-code
checkpoints:
  enabled: true                  # Enable automatic checkpoints (also: hermes --checkpoints)
  max_snapshots: 50              # Max checkpoints to keep per directory
```


## Delegation<a href="#delegation" class="hash-link" aria-label="Direct link to Delegation" translate="no" title="Direct link to Delegation">​</a>

Configure subagent behavior for the delegate tool:


``` prism-code
delegation:
  # model: "google/gemini-3-flash-preview"  # Override model (empty = inherit parent)
  # provider: "openrouter"                  # Override provider (empty = inherit parent)
  # base_url: "http://localhost:1234/v1"    # Direct OpenAI-compatible endpoint (takes precedence over provider)
  # api_key: "local-key"                    # API key for base_url (falls back to OPENAI_API_KEY)
```


**Subagent provider:model override:** By default, subagents inherit the parent agent's provider and model. Set `delegation.provider` and `delegation.model` to route subagents to a different provider:model pair — e.g., use a cheap/fast model for narrowly-scoped subtasks while your primary agent runs an expensive reasoning model.

**Direct endpoint override:** If you want the obvious custom-endpoint path, set `delegation.base_url`, `delegation.api_key`, and `delegation.model`. That sends subagents directly to that OpenAI-compatible endpoint and takes precedence over `delegation.provider`. If `delegation.api_key` is omitted, Hermes falls back to `OPENAI_API_KEY` only.

The delegation provider uses the same credential resolution as CLI/gateway startup. All configured providers are supported: `openrouter`, `nous`, `copilot`, `zai`, `kimi-coding`, `minimax`, `minimax-cn`. When a provider is set, the system automatically resolves the correct base URL, API key, and API mode — no manual credential wiring needed.

**Precedence:** `delegation.base_url` in config → `delegation.provider` in config → parent provider (inherited). `delegation.model` in config → parent model (inherited). Setting just `model` without `provider` changes only the model name while keeping the parent's credentials (useful for switching models within the same provider like OpenRouter).

## Clarify<a href="#clarify" class="hash-link" aria-label="Direct link to Clarify" translate="no" title="Direct link to Clarify">​</a>

Configure the clarification prompt behavior:


``` prism-code
clarify:
  timeout: 120                 # Seconds to wait for user clarification response
```


## Context Files (SOUL.md, AGENTS.md)<a href="#context-files-soulmd-agentsmd" class="hash-link" aria-label="Direct link to Context Files (SOUL.md, AGENTS.md)" translate="no" title="Direct link to Context Files (SOUL.md, AGENTS.md)">​</a>

Hermes uses two different context scopes:

| File                       | Purpose                                                                               | Scope                                         |
|----------------------------|---------------------------------------------------------------------------------------|-----------------------------------------------|
| `SOUL.md`                  | **Primary agent identity** — defines who the agent is (slot \#1 in the system prompt) | `~/.hermes/SOUL.md` or `$HERMES_HOME/SOUL.md` |
| `.hermes.md` / `HERMES.md` | Project-specific instructions (highest priority)                                      | Walks to git root                             |
| `AGENTS.md`                | Project-specific instructions, coding conventions                                     | Recursive directory walk                      |
| `CLAUDE.md`                | Claude Code context files (also detected)                                             | Working directory only                        |
| `.cursorrules`             | Cursor IDE rules (also detected)                                                      | Working directory only                        |
| `.cursor/rules/*.mdc`      | Cursor rule files (also detected)                                                     | Working directory only                        |

- **SOUL.md** is the agent's primary identity. It occupies slot \#1 in the system prompt, completely replacing the built-in default identity. Edit it to fully customize who the agent is.
- If SOUL.md is missing, empty, or cannot be loaded, Hermes falls back to a built-in default identity.
- **Project context files use a priority system** — only ONE type is loaded (first match wins): `.hermes.md` → `AGENTS.md` → `CLAUDE.md` → `.cursorrules`. SOUL.md is always loaded independently.
- **AGENTS.md** is hierarchical: if subdirectories also have AGENTS.md, all are combined.
- Hermes automatically seeds a default `SOUL.md` if one does not already exist.
- All loaded context files are capped at 20,000 characters with smart truncation.

See also:

- [Personality & SOUL.md](/docs/user-guide/features/personality)
- [Context Files](/docs/user-guide/features/context-files)

## Working Directory<a href="#working-directory" class="hash-link" aria-label="Direct link to Working Directory" translate="no" title="Direct link to Working Directory">​</a>

| Context                                | Default                                                      |
|----------------------------------------|--------------------------------------------------------------|
| **CLI (`hermes`)**                     | Current directory where you run the command                  |
| **Messaging gateway**                  | Home directory `~` (override with `MESSAGING_CWD`)           |
| **Docker / Singularity / Modal / SSH** | User's home directory inside the container or remote machine |

Override the working directory:


``` prism-code
# In ~/.hermes/.env or ~/.hermes/config.yaml:
MESSAGING_CWD=/home/myuser/projects    # Gateway sessions
TERMINAL_CWD=/workspace                # All terminal sessions
```


- <a href="#directory-structure" class="table-of-contents__link toc-highlight">Directory Structure</a>
- <a href="#managing-configuration" class="table-of-contents__link toc-highlight">Managing Configuration</a>
- <a href="#configuration-precedence" class="table-of-contents__link toc-highlight">Configuration Precedence</a>
- <a href="#environment-variable-substitution" class="table-of-contents__link toc-highlight">Environment Variable Substitution</a>
- <a href="#inference-providers" class="table-of-contents__link toc-highlight">Inference Providers</a>
  - <a href="#anthropic-native" class="table-of-contents__link toc-highlight">Anthropic (Native)</a>
  - <a href="#github-copilot" class="table-of-contents__link toc-highlight">GitHub Copilot</a>
  - <a href="#first-class-chinese-ai-providers" class="table-of-contents__link toc-highlight">First-Class Chinese AI Providers</a>
  - <a href="#hugging-face-inference-providers" class="table-of-contents__link toc-highlight">Hugging Face Inference Providers</a>
- <a href="#custom--self-hosted-llm-providers" class="table-of-contents__link toc-highlight">Custom &amp; Self-Hosted LLM Providers</a>
  - <a href="#general-setup" class="table-of-contents__link toc-highlight">General Setup</a>
  - <a href="#switching-models-with-model" class="table-of-contents__link toc-highlight">Switching Models with <code>/model</code></a>
  - <a href="#ollama--local-models-zero-config" class="table-of-contents__link toc-highlight">Ollama — Local Models, Zero Config</a>
  - <a href="#vllm--high-performance-gpu-inference" class="table-of-contents__link toc-highlight">vLLM — High-Performance GPU Inference</a>
  - <a href="#sglang--fast-serving-with-radixattention" class="table-of-contents__link toc-highlight">SGLang — Fast Serving with RadixAttention</a>
  - <a href="#llamacpp--llama-server--cpu--metal-inference" class="table-of-contents__link toc-highlight">llama.cpp / llama-server — CPU &amp; Metal Inference</a>
  - <a href="#litellm-proxy--multi-provider-gateway" class="table-of-contents__link toc-highlight">LiteLLM Proxy — Multi-Provider Gateway</a>
  - <a href="#clawrouter--cost-optimized-routing" class="table-of-contents__link toc-highlight">ClawRouter — Cost-Optimized Routing</a>
  - <a href="#other-compatible-providers" class="table-of-contents__link toc-highlight">Other Compatible Providers</a>
  - <a href="#context-length-detection" class="table-of-contents__link toc-highlight">Context Length Detection</a>
  - <a href="#named-custom-providers" class="table-of-contents__link toc-highlight">Named Custom Providers</a>
  - <a href="#choosing-the-right-setup" class="table-of-contents__link toc-highlight">Choosing the Right Setup</a>
- <a href="#optional-api-keys" class="table-of-contents__link toc-highlight">Optional API Keys</a>
  - <a href="#self-hosting-firecrawl" class="table-of-contents__link toc-highlight">Self-Hosting Firecrawl</a>
- <a href="#openrouter-provider-routing" class="table-of-contents__link toc-highlight">OpenRouter Provider Routing</a>
- <a href="#fallback-model" class="table-of-contents__link toc-highlight">Fallback Model</a>
- <a href="#smart-model-routing" class="table-of-contents__link toc-highlight">Smart Model Routing</a>
- <a href="#terminal-backend-configuration" class="table-of-contents__link toc-highlight">Terminal Backend Configuration</a>
  - <a href="#common-terminal-backend-issues" class="table-of-contents__link toc-highlight">Common Terminal Backend Issues</a>
  - <a href="#docker-volume-mounts" class="table-of-contents__link toc-highlight">Docker Volume Mounts</a>
  - <a href="#docker-credential-forwarding" class="table-of-contents__link toc-highlight">Docker Credential Forwarding</a>
  - <a href="#optional-mount-the-launch-directory-into-workspace" class="table-of-contents__link toc-highlight">Optional: Mount the Launch Directory into <code>/workspace</code></a>
  - <a href="#persistent-shell" class="table-of-contents__link toc-highlight">Persistent Shell</a>
- <a href="#memory-configuration" class="table-of-contents__link toc-highlight">Memory Configuration</a>
- <a href="#git-worktree-isolation" class="table-of-contents__link toc-highlight">Git Worktree Isolation</a>
- <a href="#context-compression" class="table-of-contents__link toc-highlight">Context Compression</a>
  - <a href="#full-reference" class="table-of-contents__link toc-highlight">Full reference</a>
  - <a href="#common-setups" class="table-of-contents__link toc-highlight">Common setups</a>
  - <a href="#how-the-three-knobs-interact" class="table-of-contents__link toc-highlight">How the three knobs interact</a>
- <a href="#iteration-budget-pressure" class="table-of-contents__link toc-highlight">Iteration Budget Pressure</a>
- <a href="#context-pressure-warnings" class="table-of-contents__link toc-highlight">Context Pressure Warnings</a>
- <a href="#auxiliary-models" class="table-of-contents__link toc-highlight">Auxiliary Models</a>
  - <a href="#the-universal-config-pattern" class="table-of-contents__link toc-highlight">The universal config pattern</a>
  - <a href="#full-auxiliary-config-reference" class="table-of-contents__link toc-highlight">Full auxiliary config reference</a>
  - <a href="#changing-the-vision-model" class="table-of-contents__link toc-highlight">Changing the Vision Model</a>
  - <a href="#provider-options" class="table-of-contents__link toc-highlight">Provider Options</a>
  - <a href="#common-setups-1" class="table-of-contents__link toc-highlight">Common Setups</a>
  - <a href="#environment-variables-legacy" class="table-of-contents__link toc-highlight">Environment Variables (legacy)</a>
- <a href="#reasoning-effort" class="table-of-contents__link toc-highlight">Reasoning Effort</a>
- <a href="#tool-use-enforcement" class="table-of-contents__link toc-highlight">Tool-Use Enforcement</a>
- <a href="#tts-configuration" class="table-of-contents__link toc-highlight">TTS Configuration</a>
- <a href="#display-settings" class="table-of-contents__link toc-highlight">Display Settings</a>
  - <a href="#theme-mode" class="table-of-contents__link toc-highlight">Theme mode</a>
- <a href="#privacy" class="table-of-contents__link toc-highlight">Privacy</a>
- <a href="#speech-to-text-stt" class="table-of-contents__link toc-highlight">Speech-to-Text (STT)</a>
- <a href="#voice-mode-cli" class="table-of-contents__link toc-highlight">Voice Mode (CLI)</a>
- <a href="#streaming" class="table-of-contents__link toc-highlight">Streaming</a>
  - <a href="#cli-streaming" class="table-of-contents__link toc-highlight">CLI Streaming</a>
  - <a href="#gateway-streaming-telegram-discord-slack" class="table-of-contents__link toc-highlight">Gateway Streaming (Telegram, Discord, Slack)</a>
- <a href="#group-chat-session-isolation" class="table-of-contents__link toc-highlight">Group Chat Session Isolation</a>
- <a href="#unauthorized-dm-behavior" class="table-of-contents__link toc-highlight">Unauthorized DM Behavior</a>
- <a href="#quick-commands" class="table-of-contents__link toc-highlight">Quick Commands</a>
- <a href="#gateway-streaming" class="table-of-contents__link toc-highlight">Gateway Streaming</a>
- <a href="#human-delay" class="table-of-contents__link toc-highlight">Human Delay</a>
- <a href="#code-execution" class="table-of-contents__link toc-highlight">Code Execution</a>
- <a href="#web-search-backends" class="table-of-contents__link toc-highlight">Web Search Backends</a>
- <a href="#browser" class="table-of-contents__link toc-highlight">Browser</a>
- <a href="#website-blocklist" class="table-of-contents__link toc-highlight">Website Blocklist</a>
- <a href="#smart-approvals" class="table-of-contents__link toc-highlight">Smart Approvals</a>
- <a href="#checkpoints" class="table-of-contents__link toc-highlight">Checkpoints</a>
- <a href="#delegation" class="table-of-contents__link toc-highlight">Delegation</a>
- <a href="#clarify" class="table-of-contents__link toc-highlight">Clarify</a>
- <a href="#context-files-soulmd-agentsmd" class="table-of-contents__link toc-highlight">Context Files (SOUL.md, AGENTS.md)</a>
- <a href="#working-directory" class="table-of-contents__link toc-highlight">Working Directory</a>


