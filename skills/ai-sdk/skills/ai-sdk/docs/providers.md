<!-- Source: https://ai-sdk.dev/docs/foundations/providers-and-models -->

# Providers and Models

Companies such as OpenAI and Anthropic (providers) offer access to a range of large language models (LLMs) with differing strengths and capabilities through their own APIs.

Each provider typically has its own unique method for interfacing with their models, complicating the process of switching providers and increasing the risk of vendor lock-in.

To solve these challenges, AI SDK Core offers a standardized approach to interacting with LLMs through a language model specification that abstracts differences between providers. This unified interface allows you to switch between providers with ease while using the same API for all providers.

## Vercel AI Gateway

By default, the AI SDK uses the Vercel AI Gateway to give access to all major providers out of the box:

```typescript
import { generateText } from 'ai';

const result = await generateText({
  model: 'anthropic/claude-opus-4.5', // or 'openai/gpt-5.2', 'google/gemini-3-flash'
  prompt: 'Hello!',
});
```

## AI SDK Providers

Official provider packages:

- [xAI Grok Provider](https://ai-sdk.dev/providers/ai-sdk-providers/xai) (`@ai-sdk/xai`)
- [OpenAI Provider](https://ai-sdk.dev/providers/ai-sdk-providers/openai) (`@ai-sdk/openai`)
- [Azure OpenAI Provider](https://ai-sdk.dev/providers/ai-sdk-providers/azure) (`@ai-sdk/azure`)
- [Anthropic Provider](https://ai-sdk.dev/providers/ai-sdk-providers/anthropic) (`@ai-sdk/anthropic`)
- [Amazon Bedrock Provider](https://ai-sdk.dev/providers/ai-sdk-providers/amazon-bedrock) (`@ai-sdk/amazon-bedrock`)
- [Google Generative AI Provider](https://ai-sdk.dev/providers/ai-sdk-providers/google-generative-ai) (`@ai-sdk/google`)
- [Google Vertex Provider](https://ai-sdk.dev/providers/ai-sdk-providers/google-vertex) (`@ai-sdk/google-vertex`)
- [Mistral Provider](https://ai-sdk.dev/providers/ai-sdk-providers/mistral) (`@ai-sdk/mistral`)
- [Together.ai Provider](https://ai-sdk.dev/providers/ai-sdk-providers/togetherai) (`@ai-sdk/togetherai`)
- [Cohere Provider](https://ai-sdk.dev/providers/ai-sdk-providers/cohere) (`@ai-sdk/cohere`)
- [Fireworks Provider](https://ai-sdk.dev/providers/ai-sdk-providers/fireworks) (`@ai-sdk/fireworks`)
- [DeepInfra Provider](https://ai-sdk.dev/providers/ai-sdk-providers/deepinfra) (`@ai-sdk/deepinfra`)
- [DeepSeek Provider](https://ai-sdk.dev/providers/ai-sdk-providers/deepseek) (`@ai-sdk/deepseek`)
- [Cerebras Provider](https://ai-sdk.dev/providers/ai-sdk-providers/cerebras) (`@ai-sdk/cerebras`)
- [Groq Provider](https://ai-sdk.dev/providers/ai-sdk-providers/groq) (`@ai-sdk/groq`)
- [Perplexity Provider](https://ai-sdk.dev/providers/ai-sdk-providers/perplexity) (`@ai-sdk/perplexity`)
- [ElevenLabs Provider](https://ai-sdk.dev/providers/ai-sdk-providers/elevenlabs) (`@ai-sdk/elevenlabs`)
- [LMNT Provider](https://ai-sdk.dev/providers/ai-sdk-providers/lmnt) (`@ai-sdk/lmnt`)
- [Hume Provider](https://ai-sdk.dev/providers/ai-sdk-providers/hume) (`@ai-sdk/hume`)
- [Rev.ai Provider](https://ai-sdk.dev/providers/ai-sdk-providers/revai) (`@ai-sdk/revai`)
- [Deepgram Provider](https://ai-sdk.dev/providers/ai-sdk-providers/deepgram) (`@ai-sdk/deepgram`)
- [Gladia Provider](https://ai-sdk.dev/providers/ai-sdk-providers/gladia) (`@ai-sdk/gladia`)
- [AssemblyAI Provider](https://ai-sdk.dev/providers/ai-sdk-providers/assemblyai) (`@ai-sdk/assemblyai`)
- [Baseten Provider](https://ai-sdk.dev/providers/ai-sdk-providers/baseten) (`@ai-sdk/baseten`)

OpenAI-compatible providers:

- [LM Studio](https://ai-sdk.dev/providers/openai-compatible-providers/lmstudio)
- [Heroku](https://ai-sdk.dev/providers/openai-compatible-providers/heroku)

## Community Providers

The open-source community has created these providers:

- [Ollama Provider](https://ai-sdk.dev/providers/community-providers/ollama) (`ollama-ai-provider`)
- [FriendliAI Provider](https://ai-sdk.dev/providers/community-providers/friendliai) (`@friendliai/ai-provider`)
- [Portkey Provider](https://ai-sdk.dev/providers/community-providers/portkey) (`@portkey-ai/vercel-provider`)
- [Cloudflare Workers AI Provider](https://ai-sdk.dev/providers/community-providers/cloudflare-workers-ai) (`workers-ai-provider`)
- [OpenRouter Provider](https://ai-sdk.dev/providers/community-providers/openrouter) (`@openrouter/ai-sdk-provider`)
- [Apertis Provider](https://ai-sdk.dev/providers/community-providers/apertis) (`@apertis/ai-sdk-provider`)
- [Aihubmix Provider](https://ai-sdk.dev/providers/community-providers/aihubmix) (`@aihubmix/ai-sdk-provider`)
- [Requesty Provider](https://ai-sdk.dev/providers/community-providers/requesty) (`@requesty/ai-sdk`)
- [Crosshatch Provider](https://ai-sdk.dev/providers/community-providers/crosshatch) (`@crosshatch/ai-provider`)
- [Mixedbread Provider](https://ai-sdk.dev/providers/community-providers/mixedbread) (`mixedbread-ai-provider`)
- [Voyage AI Provider](https://ai-sdk.dev/providers/community-providers/voyage-ai) (`voyage-ai-provider`)
- [Mem0 Provider](https://ai-sdk.dev/providers/community-providers/mem0) (`@mem0/vercel-ai-provider`)
- [Letta Provider](https://ai-sdk.dev/providers/community-providers/letta) (`@letta-ai/vercel-ai-sdk-provider`)
- [Supermemory Provider](https://ai-sdk.dev/providers/community-providers/supermemory) (`@supermemory/tools`)
- [Spark Provider](https://ai-sdk.dev/providers/community-providers/spark) (`spark-ai-provider`)
- [AnthropicVertex Provider](https://ai-sdk.dev/providers/community-providers/anthropic-vertex-ai) (`anthropic-vertex-ai`)
- [LangDB Provider](https://ai-sdk.dev/providers/community-providers/langdb) (`@langdb/vercel-provider`)
- [Dify Provider](https://ai-sdk.dev/providers/community-providers/dify) (`dify-ai-provider`)
- [Sarvam Provider](https://ai-sdk.dev/providers/community-providers/sarvam) (`sarvam-ai-provider`)
- [Claude Code Provider](https://ai-sdk.dev/providers/community-providers/claude-code) (`ai-sdk-provider-claude-code`)
- [Browser AI Provider](https://ai-sdk.dev/providers/community-providers/browser-ai) (`browser-ai`)
- [Gemini CLI Provider](https://ai-sdk.dev/providers/community-providers/gemini-cli) (`ai-sdk-provider-gemini-cli`)
- [A2A Provider](https://ai-sdk.dev/providers/community-providers/a2a) (`a2a-ai-provider`)
- [SAP-AI Provider](https://ai-sdk.dev/providers/community-providers/sap-ai) (`@mymediset/sap-ai-provider`)
- [AI/ML API Provider](https://ai-sdk.dev/providers/community-providers/aimlapi) (`@ai-ml.api/aimlapi-vercel-ai`)
- [MCP Sampling Provider](https://ai-sdk.dev/providers/community-providers/mcp-sampling) (`@mcpc-tech/mcp-sampling-ai-provider`)
- [ACP Provider](https://ai-sdk.dev/providers/community-providers/acp) (`@mcpc-tech/acp-ai-provider`)
- [OpenCode Provider](https://ai-sdk.dev/providers/community-providers/opencode-sdk) (`ai-sdk-provider-opencode-sdk`)
- [Codex CLI Provider](https://ai-sdk.dev/providers/community-providers/codex-cli) (`ai-sdk-provider-codex-cli`)
- [Soniox Provider](https://ai-sdk.dev/providers/community-providers/soniox) (`@soniox/vercel-ai-sdk-provider`)
- [Zhipu (Z.AI) Provider](https://ai-sdk.dev/providers/community-providers/zhipu) (`zhipu-ai-provider`)
- [OLLM Provider](https://ai-sdk.dev/providers/community-providers/ollm) (`@ofoundation/ollm`)

## Self-Hosted Models

Access self-hosted models with:

- [Ollama Provider](https://ai-sdk.dev/providers/community-providers/ollama)
- [LM Studio](https://ai-sdk.dev/providers/openai-compatible-providers/lmstudio)
- [Baseten](https://ai-sdk.dev/providers/ai-sdk-providers/baseten)
- [Browser AI](https://ai-sdk.dev/providers/community-providers/browser-ai)

Any self-hosted provider that supports the OpenAI specification can be used with the OpenAI Compatible Provider.

## Custom Providers

Create a custom provider for any OpenAI-compatible API:

```typescript
import { createOpenAI } from '@ai-sdk/openai';

const customProvider = createOpenAI({
  baseURL: 'https://your-api.com/v1',
  apiKey: process.env.CUSTOM_API_KEY,
});

const model = customProvider('model-name');
```

## Model Capabilities

Popular models and their capabilities:

| Provider | Model | Image Input | Object Generation | Tool Usage | Tool Streaming |
|----------|-------|-------------|-------------------|------------|----------------|
| xAI Grok | grok-4 | Yes | Yes | Yes | Yes |
| xAI Grok | grok-3 | Yes | Yes | Yes | Yes |
| OpenAI | gpt-5.2 | Yes | Yes | Yes | Yes |
| OpenAI | gpt-5 | Yes | Yes | Yes | Yes |
| OpenAI | gpt-5-mini | Yes | Yes | Yes | Yes |
| Anthropic | claude-opus-4-6 | Yes | Yes | Yes | Yes |
| Anthropic | claude-sonnet-4-6 | Yes | Yes | Yes | Yes |
| Anthropic | claude-opus-4-5 | Yes | Yes | Yes | Yes |
| Anthropic | claude-opus-4-1 | Yes | Yes | Yes | Yes |
| Anthropic | claude-3-5-haiku-latest | Yes | Yes | Yes | Yes |
| Mistral | mistral-large-latest | No | Yes | Yes | Yes |
| Mistral | mistral-medium-latest | No | Yes | Yes | Yes |
| Google | gemini-2.0-flash-exp | Yes | Yes | Yes | Yes |
| Google | gemini-1.5-pro | Yes | Yes | Yes | Yes |
| DeepSeek | deepseek-chat | No | Yes | Yes | Yes |
| Groq | llama-3.3-70b-versatile | No | Yes | Yes | Yes |

This table is not exhaustive. Additional models can be found in the provider documentation pages and on the provider websites.
