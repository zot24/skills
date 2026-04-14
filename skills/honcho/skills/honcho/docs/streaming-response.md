<!-- Source: https://docs.honcho.dev/v3/documentation/features/advanced/streaming-response -->

# Streaming Responses

## Overview

The Honcho SDK provides streaming functionality for AI-generated content, enabling applications to display responses as they're produced rather than waiting for completion.

## Primary Use Cases

Streaming proves beneficial for:

- Real-time chat interfaces
- Long-form content generation
- Applications prioritizing perceived responsiveness
- Interactive agent experiences
- Reducing latency for initial content delivery

## Chat Endpoint Streaming

The chat endpoint enables streaming the AI's reasoning about a user in real-time.

### Setup Requirements

Initialize the Honcho client, create peer objects representing conversation participants, establish a session, and optionally add contextual messages:

**Python:**
```python
from honcho import Honcho

honcho = Honcho()
user = honcho.peer("demo-user")
assistant = honcho.peer("assistant")
session = honcho.session("demo-session")
session.add_peers([user, assistant])
```

**TypeScript:**
```typescript
import { Honcho } from '@honcho-ai/sdk';

const honcho = new Honcho({});
const user = await honcho.peer('demo-user');
const assistant = await honcho.peer('assistant');
const session = await honcho.session('demo-session');
await session.addPeers([user, assistant]);
```

## Implementation Patterns

Consider these approaches when handling streaming data:

1. **Progressive Rendering** -- Update interfaces incrementally as chunks arrive
2. **Buffered Processing** -- Collect chunks until logical breaks occur
3. **Token Counting** -- Monitor usage in real-time for quota-aware applications
4. **Error Handling** -- Address interrupted stream scenarios appropriately

## Performance Recommendations

Account for connection reliability, implement operation timeouts, monitor memory accumulation, and apply robust error handling for network disruptions.
