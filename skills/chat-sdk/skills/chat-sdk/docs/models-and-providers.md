<!-- Source: https://chat-sdk.dev/docs/customization/models-and-providers -->

# Models and Providers

Chat SDK integrates with AI SDK Gateway as its default provider, enabling unified access to models from OpenAI, Anthropic, Google, xAI, and additional vendors. Because Chat SDK leverages the AI SDK framework, which offers extensive provider support, you can switch between different providers as needed.

## Modifying Model Configuration

To change models, update the `myProvider` custom provider located in your project:

```ts
// lib/ai/models.ts
import { customProvider, extractReasoningMiddleware, wrapLanguageModel } from "ai";
import { gateway } from "@ai-sdk/gateway";

export const myProvider = customProvider({
  languageModels: {
    "chat-model": gateway.languageModel("xai/grok-2-vision-1212"),
    "chat-model-reasoning": wrapLanguageModel({
      model: gateway.languageModel('xai/grok-3-mini-beta'),
      middleware: extractReasoningMiddleware({ tagName: "think" }),
    }),
    "title-model": gateway.languageModel("xai/grok-2-1212"),
    "artifact-model": gateway.languageModel("xai/grok-2-1212"),
  },
});
```

You may substitute any model identifier supported by AI SDK Gateway.

## Example: Switching to Anthropic

Here is an example switching the chat model to Anthropic's Claude:

```ts
// lib/ai/models.ts
import { customProvider, extractReasoningMiddleware, wrapLanguageModel } from "ai";
import { gateway } from "@ai-sdk/gateway";

export const myProvider = customProvider({
  languageModels: {
    "chat-model": gateway.languageModel("anthropic/claude-3-5-sonnet-20241022"),
    "chat-model-reasoning": wrapLanguageModel({
      model: gateway.languageModel('xai/grok-3-mini-beta'),
      middleware: extractReasoningMiddleware({ tagName: "think" }),
    }),
    "title-model": gateway.languageModel("xai/grok-2-1212"),
    "artifact-model": gateway.languageModel("xai/grok-2-1212"),
  },
});
```

## Model Roles

The Chat SDK uses four model roles:

| Role | Purpose | Default |
|------|---------|---------|
| `chat-model` | Primary conversational model | xai/grok-2-vision-1212 |
| `chat-model-reasoning` | Reasoning/thinking model with middleware | xai/grok-3-mini-beta |
| `title-model` | Chat title generation | xai/grok-2-1212 |
| `artifact-model` | Artifact content generation | xai/grok-2-1212 |

## AI SDK Gateway

AI SDK Gateway provides a unified interface to access multiple AI providers:

- **For Vercel deployments**: Authentication is handled automatically via OIDC tokens
- **For non-Vercel deployments**: Set the `AI_GATEWAY_API_KEY` environment variable in `.env.local`

## Using Direct Providers

With the AI SDK, you can also switch to direct LLM providers instead of using the Gateway:

```ts
import { openai } from '@ai-sdk/openai';
import { anthropic } from '@ai-sdk/anthropic';
import { google } from '@ai-sdk/google';
```

Consult the [AI SDK provider documentation](https://sdk.vercel.ai/providers) for available model identifiers and configurations. After updating your selections, your chatbot will immediately use the new models.
