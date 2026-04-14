<!-- Source: https://docs.honcho.dev/v3/documentation/reference/sdk -->

# SDK Reference

## Overview

Honcho provides SDKs for Python and TypeScript/JavaScript to build agentic AI applications with ergonomic interfaces.

## Installation

**Python:**
```bash
uv add honcho-ai
# or
pip install honcho-ai
```

**TypeScript/JavaScript:**
```bash
npm install @honcho-ai/sdk
# yarn add @honcho-ai/sdk
# pnpm add @honcho-ai/sdk
```

## Quick Start

Without configuration, the SDK uses the demo server. For production:
1. Obtain an API key at app.honcho.dev/api-keys
2. Set `environment="production"` with your `api_key`

**Python example:**
```python
from honcho import Honcho

honcho = Honcho()
alice = honcho.peer("alice")
session = honcho.session("conversation-1")
session.add_messages([alice.message("Hello!")])
```

**TypeScript example:**
```typescript
import { Honcho } from "@honcho-ai/sdk";

const honcho = new Honcho({});
const alice = await honcho.peer("alice");
const session = await honcho.session("conversation-1");
```

## Core Concepts

**Representations** model what peers understand. Each peer has:
- Global representation (knowledge across all sessions)
- Local representations (what specific peers know about them)

## Honcho Client

Main entry point with configuration options:

**Environment Variables:**
- `HONCHO_API_KEY` - Authentication key
- `HONCHO_BASE_URL` - API endpoint
- `HONCHO_WORKSPACE_ID` - Default workspace

**Key methods:**
- `peer(id)` - Get or create peer
- `session(id)` - Get or create session
- `peers()` / `sessions()` - List resources
- `search(query)` - Workspace-wide search
- `get_metadata()` / `set_metadata()` - Manage workspace metadata

## Peer Class

Represents conversation participants with the following capabilities:

**Core operations:**
- `chat()` - Query peer representations (supports streaming)
- `message()` - Create messages for sessions
- `sessions()` - Retrieve peer's sessions
- `search()` - Search peer's messages

**Knowledge management:**
- `get_card()` / `set_card()` - Biographical facts
- `context()` - Combined representation and card
- `representation()` - Working knowledge with semantic search
- `conclusions` / `conclusions_of()` - Access derived facts

**Metadata:**
- `get_metadata()` / `set_metadata()` - Store peer attributes

## Peer Card

Contains stable biographical information. Automatically maintained during message processing. Manually set with `set_card()` when needed.

```python
card = alice.get_card()  # Retrieve
alice.set_card(["Likes Python", "NYC resident"])  # Set
```

## Conclusions

Facts derived from messages, accessible and queryable:

```python
# Self-conclusions
self_conclusions = alice.conclusions.list()
results = alice.conclusions.query("preferences")

# About others
bob_conclusions = alice.conclusions_of("bob").list()
```

Create conclusions manually:
```python
bob_conclusions = alice.conclusions_of("bob")
created = bob_conclusions.create([
    {"content": "Prefers dark mode", "session_id": "session-1"}
])
```

## Session Class

Manages multi-party conversations:

**Peer management:**
- `add_peers()` - Include participants
- `set_peers()` - Replace all peers
- `remove_peers()` - Remove participants
- `peers()` - List session participants

**Message operations:**
- `add_messages()` - Add messages from peers
- `messages()` - Retrieve with pagination
- `get_message()` - Fetch specific message
- `upload_file()` - Create messages from files

**Context and search:**
- `context()` - Formatted conversation context
- `search()` - Find session content
- `representation()` - Query peer knowledge within session

**Advanced:**
- `clone()` - Copy session with all data
- `delete()` - Remove session asynchronously

**Metadata:**
- `set_metadata()` / `get_metadata()` - Store session attributes

## Session Peer Configuration

Control theory-of-mind modeling within sessions:

```python
from honcho.api_types import SessionPeerConfig

config = SessionPeerConfig(
    observe_others=False,  # Model other peers
    observe_me=True        # Allow others to model this peer
)
session.add_peers([(alice, config)])
```

## SessionContext

Provides LLM-ready conversation formatting:

```python
context = session.context(summary=True, tokens=1500)
openai_messages = context.to_openai(assistant=assistant)
anthropic_messages = context.to_anthropic(assistant=assistant)
```

**Structure includes:**
- Messages array with metadata
- Optional summary
- Optional peer representation and card

**Parameters:**
- `summary` - Include conversation summary
- `tokens` - Maximum tokens to include
- `peer_target` - Peer for representation
- `peer_perspective` - Perspective peer
- `limit_to_session` - Scope representation to session
- `representationOptions` - Semantic search configuration

## Advanced Usage

### Multi-Party Conversations

```python
users = [honcho.peer(f"user-{i}") for i in range(5)]
group_chat = honcho.session("group-discussion")
group_chat.add_peers(users)
user_perspective = users[0].chat("What are concerns?")
```

### LLM Integration

```python
context = session.context(tokens=3000)
messages = context.to_openai(assistant=assistant)
# Pass to OpenAI, Anthropic, etc.
```

### Custom Message Timestamps

```python
alice.message("Content", created_at="2024-01-01T12:00:00Z")
```

### Metadata and Filtering

```python
session.add_messages([
    alice.message("Text", metadata={"topic": "finance", "priority": "high"})
])
finance_msgs = session.messages(filters={"metadata": {"topic": "finance"}})
```

### Pagination

All list methods support `page`, `size`, and `reverse`:

```python
messages = session.messages(page=1, size=100, reverse=True)
filtered = session.messages(filters={"peer_id": "alice"}, size=10)
```

## Best Practices

**Resource Management:**
- Peers and sessions are lightweight; create as needed
- Use descriptive IDs for debugging

**Performance:**
- Create peers efficiently using batch operations
- Limit context tokens to control usage
- Batch message operations when possible
