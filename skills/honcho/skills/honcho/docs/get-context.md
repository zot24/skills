<!-- Source: https://docs.honcho.dev/v3/documentation/features/get-context -->

# Get Context

## Overview

The `context()` method retrieves and formats conversation history from sessions, enabling seamless integration with LLMs like OpenAI and Anthropic. By default, it combines summaries with recent messages covering the entire session history.

## Basic Usage

Available on all Session objects, `context()` returns a `SessionContext` containing formatted conversation history:

**Python:**
```python
from honcho import Honcho

honcho = Honcho()
session = honcho.session("conversation-1")
context = session.context()
```

**TypeScript:**
```typescript
import { Honcho } from "@honcho-ai/sdk";

const honcho = new Honcho({});
const session = await honcho.session("conversation-1");
const context = await session.context();
```

## Key Parameters

| Parameter | Type | Purpose |
|-----------|------|---------|
| `summary` | bool | Enable/disable summary inclusion (default: true) |
| `tokens` | int | Maximum tokens to include |
| `peer_target` | str | Peer ID for representation data |
| `peer_perspective` | str | Perspective viewpoint (requires peer_target) |
| `search_query` | str | Semantic search query |
| `limit_to_session` | bool | Restrict to current session conclusions |
| `search_top_k` | int | Number of semantic results (1-100) |
| `search_max_distance` | float | Semantic distance threshold (0.0-1.0) |
| `include_most_frequent` | bool | Include frequent conclusions |
| `max_conclusions` | int | Maximum conclusions (1-100) |

## Token Management

Control context size through token limits:

```python
context = session.context(tokens=1500)
context = session.context(tokens=3000)
```

Combine parameters strategically -- disable summaries to maximize recent messages within token constraints.

## LLM Format Conversion

The `SessionContext` provides methods for popular LLM APIs. You must specify the assistant peer when converting to OpenAI format.

**OpenAI Format:**
```python
context = session.context()
openai_messages = context.to_openai(assistant=assistant)
```

**Anthropic Format:**
```python
context = session.context()
anthropic_messages = context.to_anthropic(assistant=assistant)
```

## Practical Integration Example

For a support chat workflow:

```python
session = honcho.session("support-chat")
user = honcho.peer("user-123")
assistant = honcho.peer("support-bot")

session.add_messages([
    user.message("Login trouble"),
    assistant.message("What error appears?")
])

messages = session.context(tokens=2000).to_openai(assistant=assistant)
response = openai_client.chat.completions.create(
    model="gpt-4",
    messages=messages
)
```

## Best Practices

- **Token Management:** Set appropriate limits per model (3000 for GPT-4, 1500 for smaller models)
- **Caching:** Reuse context objects for multiple format conversions
- **Error Handling:** Wrap context retrieval in try-catch blocks with fallback strategies
- **Long Conversations:** Enable summaries to manage token usage effectively

## Advanced Features

### Semantic Search
Retrieve semantically relevant conclusions:
```python
context = session.context(
    peer_target="user-123",
    search_query="coding preferences?",
    search_top_k=10,
    search_max_distance=0.8
)
```

### Session-Scoped Representations
Limit conclusions to current session only:
```python
context = session.context(
    peer_target="user-123",
    limit_to_session=True
)
```

### Multi-Assistant Perspectives
Format the same conversation for different assistants:
```python
chatbot_context = session.context().to_openai(assistant=chatbot)
analyzer_context = session.context().to_openai(assistant=analyzer)
```

The `context()` method enables sophisticated AI applications maintaining conversation continuity while managing token constraints across LLM providers.
