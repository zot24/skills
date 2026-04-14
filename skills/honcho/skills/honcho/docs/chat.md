<!-- Source: https://docs.honcho.dev/v3/documentation/features/chat -->

# Chat Endpoint

## Overview

The Chat endpoint (`peer.chat()`) functions as a natural language interface for reasoning about users. Rather than manually retrieving conclusions, your LLM can pose questions and receive synthesized answers based on Honcho's reasoning about a peer.

## Basic Usage

**Python:**
```python
from honcho import Honcho

honcho = Honcho()
peer = honcho.peer("user-123")
query = "What is the user's favorite way of completing the task?"
answer = peer.chat(query)
```

**TypeScript:**
```typescript
import { Honcho } from '@honcho-ai/sdk';

const honcho = new Honcho({});
const peer = await honcho.peer("user-123");
const query = "What is the user's favorite way of completing the task?";
const answer = await peer.chat(query);
```

The endpoint searches through the peer's representation and synthesizes natural language answers.

## Reasoning Level Parameter

The `reasoning_level` parameter optimizes speed versus depth, defaulting to `low`. Five options exist:

| Level | Purpose | Characteristics |
|-------|---------|-----------------|
| `minimal` | Fast factual lookups | Lower cost, minimal tools |
| `low` | Default balance | Standard tool set |
| `medium` | Multi-step or ambiguous questions | Extended thinking |
| `high` | Complex synthesis across sources | Enhanced tools and thinking |
| `max` | Deep research, most complex queries | Maximum resources |

## Streaming Responses

For extended answers, streaming provides incremental output:

**Python:**
```python
response_stream = peer.chat(query, stream=True)
for chunk in response_stream.iter_text():
    print(chunk, end="", flush=True)
```

**TypeScript:**
```typescript
const responseStream = await peer.chat(query, { stream: true });
for await (const chunk of responseStream.iter_text()) {
    process.stdout.write(chunk);
}
```

## Integration Patterns

### Dynamic Prompt Enhancement
The chat endpoint can inject user context into LLM prompts dynamically, enabling personalized responses based on Honcho's conclusions.

### Conditional Logic
Application logic can branch based on chat responses (e.g., showing onboarding flows conditionally).

### Preference Extraction
Multiple queries can gather insights about tone, expertise, and goals for agent configuration.

## How Honcho Answers

The process involves: searching peer representations, retrieving semantically relevant conclusions, combining with source message segments, and synthesizing coherent responses. Reasoning runs continuously in the background, processing new messages and updating representations.

## Best Practices

- Ask specific questions rather than broad inquiries
- Allow LLMs to formulate queries dynamically for context-aware personalization
- Use responses to drive application logic beyond prompt enhancement
- Combine `context()` for conversation data and `peer.chat()` for specific insights
