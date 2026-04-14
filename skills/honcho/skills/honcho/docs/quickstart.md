<!-- Source: https://docs.honcho.dev/v3/documentation/introduction/quickstart -->

# Quickstart

Honcho enables developers to build AI agents with persistent memory capabilities. This quickstart demonstrates setting up a workspace, ingesting multi-session conversations, and querying synthesized insights about users.

## Prerequisites

- API key from [app.honcho.dev](https://app.honcho.dev)
- $100 free credits upon signup
- Estimated cost for quickstart: ~$0.04

## Installation

**Python:**
```bash
uv add honcho-ai
# or
pip install honcho-ai
```

**TypeScript:**
```bash
npm install @honcho-ai/sdk
yarn add @honcho-ai/sdk
pnpm add @honcho-ai/sdk
```

## Implementation Steps

### 1. Initialize Client

Python:
```python
from honcho import Honcho
honcho = Honcho(workspace_id="first-honcho-test", api_key=HONCHO_API_KEY)
```

TypeScript:
```typescript
import { Honcho } from '@honcho-ai/sdk';
const honcho = new Honcho({ 
  workspaceId: "first-honcho-test", 
  apiKey: HONCHO_API_KEY 
});
```

### 2. Create Peers

Define conversation participants:
```python
user = honcho.peer("user")
assistant = honcho.peer("assistant")
```

### 3. Ingest Messages

Load conversation data and populate sessions:
```python
import json

with open("conversation.json", "r") as f:
    data = json.load(f)

for session_data in data["sessions"]:
    session = honcho.session(session_data["id"])
    session.add_peers([user, assistant])
    
    messages = []
    for msg in session_data["messages"]:
        if msg["role"] == "user":
            messages.append(user.message(msg["content"]))
        elif msg["role"] == "assistant":
            messages.append(assistant.message(msg["content"]))
    
    session.add_messages(messages)
```

### 4. Query Insights

```python
response = user.chat("What should I know about this user? 3 sentences max")
print(response)
```

## Key Capabilities

Honcho performs reasoning to extract implicit insights. For example, it identifies user traits like "notably thoughtful about product design" and "business-minded" from conversation patterns without explicit statements.

This synthesized context enables multiple downstream use cases:
- Life coaches identifying motivation patterns
- Productivity agents optimizing time allocation
- Financial advisors assessing entrepreneurial readiness

## Performance Notes

Message processing requires brief processing time. Use queue status utilities to monitor completion before querying results.

## Next Steps

- Explore [Get Context](/v3/documentation/features/get-context) for agent response optimization
- Review [Architecture](/v3/documentation/core-concepts/architecture) documentation
- Study [Chat Endpoint](/v3/documentation/features/chat) capabilities
- Examine [Guides](/v3/guides/overview) for integration patterns
