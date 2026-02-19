<!-- Source: https://ai-sdk.dev/docs/ai-sdk-ui/overview -->

# AI SDK UI

AI SDK UI is designed to help you build interactive chat, completion, and assistant applications with ease. It is a **framework-agnostic toolkit**, streamlining the integration of advanced AI functionalities into your applications.

AI SDK UI provides robust abstractions that simplify the complex tasks of managing chat streams and UI updates on the frontend, enabling you to develop dynamic AI-driven interfaces more efficiently. With three main hooks -- **`useChat`**, **`useCompletion`**, and **`useObject`** -- you can incorporate real-time chat capabilities, text completions, streamed JSON, and interactive assistant features into your app.

## Primary Hooks

### useChat

Offers real-time streaming of chat messages, abstracting state management for inputs, messages, loading, and errors, allowing for seamless integration into any UI design.

```typescript
'use client';
import { useChat } from '@ai-sdk/react';

export default function Chat() {
  const { messages, input, handleInputChange, handleSubmit, status } = useChat();

  return (
    <div>
      {messages.map(message => (
        <div key={message.id}>
          <strong>{message.role}:</strong>
          {message.parts.map((part, index) => {
            switch (part.type) {
              case 'text':
                return <div key={index}>{part.text}</div>;
            }
          })}
        </div>
      ))}

      <form onSubmit={handleSubmit}>
        <input
          value={input}
          onChange={handleInputChange}
          disabled={status !== 'ready'}
        />
        <button type="submit">Send</button>
      </form>
    </div>
  );
}
```

### useCompletion

Enables you to handle text completions in your applications, managing the prompt input and automatically updating the UI as new completions are streamed.

```typescript
'use client';
import { useCompletion } from '@ai-sdk/react';

export default function Completion() {
  const { completion, input, handleInputChange, handleSubmit, isLoading } =
    useCompletion();

  return (
    <div>
      <form onSubmit={handleSubmit}>
        <input value={input} onChange={handleInputChange} />
        <button type="submit">Complete</button>
      </form>

      {isLoading && <div>Generating...</div>}
      <div>{completion}</div>
    </div>
  );
}
```

### useObject

A hook that allows you to consume streamed JSON objects, providing a simple way to handle and display structured data in your application.

```typescript
'use client';
import { useObject } from '@ai-sdk/react';
import { z } from 'zod';

const schema = z.object({
  notifications: z.array(
    z.object({
      title: z.string(),
      message: z.string(),
    }),
  ),
});

export default function Notifications() {
  const { object, submit, isLoading } = useObject({
    api: '/api/notifications',
    schema,
  });

  return (
    <div>
      <button onClick={() => submit({ prompt: 'Generate notifications' })}>
        Generate
      </button>

      {object?.notifications?.map((n, i) => (
        <div key={i}>
          <h3>{n.title}</h3>
          <p>{n.message}</p>
        </div>
      ))}
    </div>
  );
}
```

## UI Framework Support

| Hook | React `@ai-sdk/react` | Vue.js `@ai-sdk/vue` | Svelte `@ai-sdk/svelte` | Angular `@ai-sdk/angular` | SolidJS (community) |
|------|----------------------|---------------------|------------------------|--------------------------|---------------------|
| useChat | useChat | useChat | Chat | Chat | useChat |
| useCompletion | useCompletion | useCompletion | Completion | Completion | useCompletion |
| useObject | useObject | useObject | StructuredObject | StructuredObject | useObject |

## Framework Examples

- [**Next.js**](https://github.com/vercel/ai/tree/main/examples/next-openai)
- [**Nuxt**](https://github.com/vercel/ai/tree/main/examples/nuxt-openai)
- [**SvelteKit**](https://github.com/vercel/ai/tree/main/examples/sveltekit-openai)
- [**Angular**](https://github.com/vercel/ai/tree/main/examples/angular)

## Server-Side API Routes

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

### Agent-based Route

```typescript
// app/api/chat/route.ts
import { createAgentUIStreamResponse } from 'ai';
import { myAgent } from '@/agent/my-agent';

export async function POST(req: Request) {
  const { messages } = await req.json();

  return createAgentUIStreamResponse({
    agent: myAgent,
    uiMessages: messages,
  });
}
```

## Key Topics

- **[Chatbot](https://ai-sdk.dev/docs/ai-sdk-ui/chatbot)** - Building chat interfaces
- **[Chatbot Message Persistence](https://ai-sdk.dev/docs/ai-sdk-ui/chatbot-message-persistence)** - Persisting messages
- **[Chatbot Resume Streams](https://ai-sdk.dev/docs/ai-sdk-ui/chatbot-resume-streams)** - Resuming interrupted streams
- **[Chatbot Tool Usage](https://ai-sdk.dev/docs/ai-sdk-ui/chatbot-tool-usage)** - Using tools in chat UIs
- **[Generative User Interfaces](https://ai-sdk.dev/docs/ai-sdk-ui/generative-user-interfaces)** - Dynamic AI-driven UIs
- **[Completion](https://ai-sdk.dev/docs/ai-sdk-ui/completion)** - Text completion interfaces
- **[Object Generation](https://ai-sdk.dev/docs/ai-sdk-ui/object-generation)** - Streaming structured objects
- **[Streaming Custom Data](https://ai-sdk.dev/docs/ai-sdk-ui/streaming-data)** - Custom data streaming
- **[Error Handling](https://ai-sdk.dev/docs/ai-sdk-ui/error-handling)** - Error management
- **[Transport](https://ai-sdk.dev/docs/ai-sdk-ui/transport)** - Transport protocols
- **[Reading UIMessage Streams](https://ai-sdk.dev/docs/ai-sdk-ui/reading-ui-message-streams)** - Consuming streams
- **[Message Metadata](https://ai-sdk.dev/docs/ai-sdk-ui/message-metadata)** - Adding metadata to messages
- **[Stream Protocols](https://ai-sdk.dev/docs/ai-sdk-ui/stream-protocol)** - Protocol details

## API Reference

Please check out the [AI SDK UI API Reference](https://ai-sdk.dev/docs/reference/ai-sdk-ui) for more details on each function.
