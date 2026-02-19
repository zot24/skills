<!-- Source: https://chat-sdk.dev/docs/architecture -->

# Architecture

The Chat SDK leverages several open source libraries to enable core chatbot features like authentication, persistence, text generation, and file storage.

## Key Components

### Application Framework
Built on Next.js with the App Router, the SDK organizes code into `(chat)/` and `(auth)/` route segments, with API endpoints functioning as serverless route handlers.

### Model Providers
The AI SDK connects to language models from various providers, enabling text generation, structured data creation, and advanced features including Tool Use, Retrieval Augmented Generation, and Reasoning.

### Authentication
Auth.js handles user authentication, which is required by default for creating and saving chats.

### Persistence
PostgreSQL stores chat history and user data, accessed via Drizzle ORM. This approach supports multiple database providers like Neon and Supabase without requiring query modifications.

### Blob Storage
Vercel Blob enables file uploads as chat attachments and stores user avatars and other assets.

### Security
It is recommended to enable Vercel Firewall and rate limiting on endpoints like `/api/chat` to prevent costly abuse. Alternatively, use a key-value store to track requests and define thresholds.

### Testing
Playwright runs end-to-end tests to verify user workflows and detect breaking changes during customization.

## Project Structure

```
ai-chatbot/
├── app/                    # Next.js App Router
│   ├── (auth)/            # Authentication routes
│   ├── (chat)/            # Chat interface routes
│   ├── api/               # API routes
│   └── layout.tsx         # Root layout
├── artifacts/             # Artifact implementations
│   ├── code/             # Code execution artifact
│   ├── image/            # Image artifact
│   ├── sheet/            # Sheet/tabular data artifact
│   └── text/             # Text editing artifact
├── components/            # React components
│   ├── ui/               # shadcn/ui components
│   └── ...               # Feature components
├── lib/                   # Shared utilities
│   ├── ai/               # AI SDK configuration
│   │   ├── models.ts     # Model configuration
│   │   ├── providers.ts  # Provider setup
│   │   └── prompts.ts    # System prompts
│   ├── artifacts/        # Artifact server handlers
│   ├── db/               # Database utilities
│   │   ├── schema.ts     # Drizzle ORM schema
│   │   └── queries.ts    # Database queries
│   └── utils/            # Helper functions
├── hooks/                 # Custom React hooks
└── public/               # Static assets
```

## Message Flow

When users send messages, the process follows this sequence:

1. User submits message via the `useChat` hook
2. Optional file uploads are sent to Vercel Blob
3. Request is routed through `/api/chat`
4. Model selection occurs and response is streamed
5. Messages are persisted to the database afterward

## Server Components vs Client Components

- **Server Components**: Data fetching, database queries, heavy computations
- **Client Components**: Interactive UI, real-time updates, user input

## Streaming Architecture

Chat SDK uses resumable streams for reliable message delivery:
- Automatic reconnection on network issues
- State preservation during interruptions
- Progressive rendering of AI responses
