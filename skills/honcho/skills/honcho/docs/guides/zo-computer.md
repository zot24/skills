> Source: https://docs.honcho.dev/v3/guides/integrations/zo-computer.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.honcho.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Zo Computer

> Add persistent memory to Zo Computer skills using Honcho

[Zo Computer](https://zo.computer) is a cloud AI platform where users build reusable workflows called skills. The Honcho memory skill gives any Zo workflow persistent memory — saving conversations, answering questions about past interactions, and injecting context into LLM prompts.


  The full source code is available on [GitHub](https://github.com/plastic-labs/honcho/tree/main/examples/zo) with working tests and Zo marketplace submission instructions.


## What It Does

The skill provides three tools that any Zo workflow can call:

| Tool           | Description                                                                 |
| -------------- | --------------------------------------------------------------------------- |
| `save_memory`  | Save user or assistant messages to a Honcho session                         |
| `query_memory` | Ask natural language questions about what Honcho remembers                  |
| `get_context`  | Retrieve conversation history formatted for LLM use (OpenAI message format) |

## Setup

Install dependencies:

```bash
pip install honcho-ai python-dotenv
```

Set your environment variables:

```bash
HONCHO_API_KEY=your-api-key
HONCHO_WORKSPACE_ID=default  # optional, defaults to "default"
```

Get your API key at [app.honcho.dev](https://app.honcho.dev).

## Quick Start

```python
from tools.save_memory import save_memory
from tools.query_memory import query_memory
from tools.get_context import get_context

# Save conversation turns
save_memory("alice", "I love hiking in the mountains", "user", "session-1")
save_memory("alice", "That sounds wonderful!", "assistant", "session-1")

# Query what Honcho remembers
answer = query_memory("alice", "What are my hobbies?", "session-1")
print(answer)  # "Alice enjoys hiking in the mountains."

# Get context ready for an LLM call
messages = get_context("alice", "session-1", "assistant", tokens=4000)
# Returns [{"role": "user", "content": "..."}, ...]
```

## Saving Messages

`save_memory` creates peers and sessions automatically on first use and persists the message.

```python
save_memory(
    user_id="alice",          # unique user identifier
    content="Hello!",         # message text
    role="user",              # "user" or "assistant"
    session_id="session-1",   # conversation identifier
    assistant_id="assistant", # optional, defaults to "assistant"
)
```

## Querying Memory

`query_memory` uses Honcho's Dialectic API to answer natural language questions grounded in stored memory.

```python
answer = query_memory(
    user_id="alice",
    query="What are my interests?",
    session_id="session-1",  # optional — omit to query global memory
)
```

## Retrieving Context

`get_context` fetches recent conversation history within a token budget and returns it in OpenAI message format — ready to pass directly to an LLM.

```python
messages = get_context(
    user_id="alice",
    session_id="session-1",
    assistant_id="assistant",
    tokens=4000,  # max tokens to include
)
# Use directly: llm.chat.completions.create(messages=messages)
```

## Concept Mapping

| Zo Computer  | Honcho    |
| ------------ | --------- |
| Account      | Workspace |
| User         | Peer      |
| Conversation | Session   |
| Message      | Message   |

## Publishing to the Zo Marketplace

To submit the skill to the [Zo Skills Registry](https://github.com/zocomputer/skills):

1. Fork the `zocomputer/skills` repository
2. Copy the `examples/zo` directory into `/Community/honcho-memory/` in your fork
3. Run `bun validate` to check the skill format
4. Submit a pull request

## Next Steps


    Full source, tests, and SKILL.md for the Zo integration


    Understand peers, sessions, and how memory works


    Learn more about querying peer memory with the Dialectic API


    Details on retrieving and formatting conversation context


