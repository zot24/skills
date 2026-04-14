<!-- Source: https://docs.honcho.dev/v3/guides/integrations/zo-computer -->

# Zo Computer Integration

## Overview

Add persistent memory to Zo Computer skills using Honcho. Enables workflows to save conversations, answer questions about past interactions, and inject context into LLM prompts.

## Three Core Tools

- **save_memory**: Persists user or assistant messages to a Honcho session
- **query_memory**: Answers natural language questions about stored memory
- **get_context**: Returns conversation history in OpenAI message format

## Installation

```bash
pip install honcho-ai python-dotenv
```

## Basic Usage

```python
save_memory("alice", "I love hiking", "user", "session-1")
answer = query_memory("alice", "What are my hobbies?", "session-1")
messages = get_context("alice", "session-1", "assistant", tokens=4000)
```

## Implementation Details

- **save_memory**: Automatically creates peers and sessions on first use
- **query_memory**: Uses Dialectic API, grounded in actual stored memory, with optional session filtering
- **get_context**: Returns formatted messages ready for LLM consumption, respecting token budgets

## Terminology Mapping

Zo Computer accounts -> workspaces, users -> peers, conversations -> sessions.
