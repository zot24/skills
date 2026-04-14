<!-- Source: https://docs.honcho.dev/v3/documentation/features/storing-data -->

# Storing Data

## Overview

The foundational element in Honcho's system is the `Message` object, which originates from a `Peer` and is stored within a `Session`.

## Basic Implementation

**Python Example:**
```python
from honcho import Honcho

honcho = Honcho()
peer = honcho.peer("sample-peer")
session = honcho.session("sample-session")
message = peer.message("Hello, world!")
session.add_messages([message])
```

**TypeScript Example:**
```typescript
import { Honcho } from '@honcho-ai/sdk';

const honcho = new Honcho({});
const peer = await honcho.peer('sample-peer');
const session = await honcho.session('sample-session');
const message = peer.message('Hello, world!');
await session.addMessages([message]);
```

## Automatic Processing

When you preserve a `Message` in Honcho, it will kick off a background task that looks at the new data to generate insights about the `Peer` that sent the `Message`. This automated behavior can be disabled through peer or session configuration.

## Architecture Flexibility

The Peer-Session-Message framework adapts to various scenarios. Some implementations use multiple sessions for a single peer, while others employ just one session across the entire application.

## Chat Bot Use Case

For chatbot applications (like ChatGPT or Claude):
- Create one `Peer` representing the user
- Create another `Peer` for the AI
- Establish a `Session` per conversation thread
- Store `Messages` from both participants for each exchange
