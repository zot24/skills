<!-- Source: https://ai-sdk.dev/docs/getting-started -->

# Getting Started

The following guides provide an introduction to some of the core features provided by the AI SDK.

## Prerequisites

- Node.js 18+
- npm, pnpm, or yarn
- API key from your chosen provider (OpenAI, Anthropic, etc.)

## Installation

```bash
# Core package
npm install ai

# Provider packages (install as needed)
npm install @ai-sdk/openai
npm install @ai-sdk/anthropic
npm install @ai-sdk/google
```

## Vercel AI Gateway (Default)

By default, the AI SDK uses the Vercel AI Gateway. Just pass a model string:

```typescript
import { generateText } from 'ai';

const { text } = await generateText({
  model: 'anthropic/claude-sonnet-4.5', // or 'openai/gpt-5', 'google/gemini-3-flash'
  prompt: 'Hello!',
});
```

## Direct Provider Usage

Connect to providers directly using their SDK packages:

```typescript
import { generateText } from 'ai';
import { anthropic } from '@ai-sdk/anthropic';

const { text } = await generateText({
  model: anthropic('claude-sonnet-4-5-20250414'),
  prompt: 'Hello!',
});
```

## Environment Setup

Create a `.env.local` file:

```bash
# OpenAI
OPENAI_API_KEY=sk-...

# Anthropic
ANTHROPIC_API_KEY=sk-ant-...

# Google
GOOGLE_GENERATIVE_AI_API_KEY=...
```

## Framework Quick Starts

### Next.js App Router

```typescript
// app/api/chat/route.ts
import { streamText } from 'ai';

export async function POST(req: Request) {
  const { messages } = await req.json();

  const result = streamText({
    model: 'anthropic/claude-sonnet-4.5',
    messages,
  });

  return result.toUIMessageStreamResponse();
}
```

```typescript
// app/page.tsx
'use client';
import { useChat } from '@ai-sdk/react';

export default function Chat() {
  const { messages, input, handleInputChange, handleSubmit } = useChat();

  return (
    <div>
      {messages.map(m => (
        <div key={m.id}>
          {m.parts.map((part, i) => {
            switch (part.type) {
              case 'text':
                return <div key={i}>{part.text}</div>;
            }
          })}
        </div>
      ))}
      <form onSubmit={handleSubmit}>
        <input value={input} onChange={handleInputChange} />
        <button type="submit">Send</button>
      </form>
    </div>
  );
}
```

### Node.js

```typescript
import { generateText } from 'ai';

async function main() {
  const { text } = await generateText({
    model: 'openai/gpt-5',
    prompt: 'Hello, AI!',
  });

  console.log(text);
}

main();
```

## Backend Framework Examples

You can use AI SDK Core and AI SDK UI with the following backend frameworks:

- **Node.js HTTP Server** - Send AI responses from a Node.js HTTP server
- **Express** - Send AI responses from an Express server
- **Hono** - Send AI responses from a Hono server
- **Fastify** - Send AI responses from a Fastify server
- **Nest.js** - Send AI responses from a Nest.js server

## Supported Frameworks

### Frontend
- React (@ai-sdk/react)
- Vue.js (@ai-sdk/vue)
- Svelte (@ai-sdk/svelte)
- Angular (@ai-sdk/angular)
- SolidJS (community)

### Backend
- Next.js (App Router & Pages Router)
- SvelteKit
- Nuxt
- Express
- Hono
- Fastify
- Nest.js
- Node.js HTTP Server
- Expo
- TanStack Start
