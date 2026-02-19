<!-- Source: https://ai-sdk.dev/docs/foundations/overview -->

# AI SDK Foundations Overview

The AI SDK standardizes integrating artificial intelligence (AI) models across supported providers. This enables developers to focus on building great AI applications, not waste time on technical details.

## Quick Example

```typescript
import { generateText } from 'ai';

const { text } = await generateText({
  model: 'anthropic/claude-sonnet-4.5', // Vercel AI Gateway
  prompt: 'What is love?',
});
```

## Key Concepts

### Generative Artificial Intelligence

Generative artificial intelligence refers to models that predict and generate various types of outputs (such as text, images, or audio) based on what's statistically likely, pulling from patterns they've learned from their training data. For example:

- Given a photo, a generative model can generate a caption.
- Given an audio file, a generative model can generate a transcription.
- Given a text description, a generative model can generate an image.

### Large Language Models

A large language model (LLM) is a subset of generative models focused primarily on text. An LLM takes a sequence of words as input and aims to predict the most likely sequence to follow. It assigns probabilities to potential next sequences and then selects one. The model continues to generate sequences until it meets a specified stopping criterion.

LLMs learn by training on massive collections of written text, which means they will be better suited to some use cases than others. For example, a model trained on GitHub data would understand the probabilities of sequences in source code particularly well.

However, it's crucial to understand LLMs' limitations. When asked about less known or absent information, like the birthday of a personal relative, LLMs might "hallucinate" or make up information. It's essential to consider how well-represented the information you need is in the model.

### Embedding Models

An embedding model is used to convert complex data (like words or images) into a dense vector (a list of numbers) representation, known as an embedding. Unlike generative models, embedding models do not generate new text or data. Instead, they provide representations of semantic and syntactic relationships between entities that can be used as input for other models or other natural language processing tasks.

## AI SDK Architecture

The AI SDK is organized into several modules:

### AI SDK Core

Core functions for generating text, structured data, and tool calls:

- `generateText` / `streamText` - Text generation
- `generateObject` / `streamObject` - Structured data generation (with Zod schemas)
- Tool calling with `tool()` helper and `stopWhen` for multi-step execution
- Embeddings, reranking, image generation, transcription, speech, video generation
- Language model middleware, provider management, error handling
- Testing, telemetry, and DevTools

### AI SDK UI

Framework-agnostic hooks for building chat and generative UIs:

- `useChat` - Real-time streaming chat
- `useCompletion` - Text completions
- `useObject` - Streamed JSON objects
- Supports React, Vue, Svelte, Angular, SolidJS (community)

### AI SDK Agents

Build intelligent agents with the `ToolLoopAgent` class:

- Automatic tool loop orchestration
- `stopWhen` for configurable stopping conditions
- `prepareStep` for per-step configuration
- Subagent delegation
- Memory management

### AI SDK RSC

React Server Components integration for server-side AI rendering.

## Foundations

The documentation covers these foundational topics:

- **[Providers and Models](https://ai-sdk.dev/docs/foundations/providers-and-models)** - Available providers and model capabilities
- **[Prompts](https://ai-sdk.dev/docs/foundations/prompts)** - How to structure prompts
- **[Tools](https://ai-sdk.dev/docs/foundations/tools)** - How tools work with LLMs
- **[Streaming](https://ai-sdk.dev/docs/foundations/streaming)** - Real-time streaming support
