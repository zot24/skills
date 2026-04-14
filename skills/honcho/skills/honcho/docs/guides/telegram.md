<!-- Source: https://docs.honcho.dev/v3/guides/telegram -->

# Telegram Bots with Honcho

## Overview

This guide demonstrates integrating Honcho with Telegram bots to implement conversational memory and context management. A complete example is available on [GitHub](https://github.com/plastic-labs/telegram-python-starter).

## Message Handling Architecture

1. Validate the incoming message
2. Extract and sanitize text content
3. Retrieve or create peer and session objects
4. Generate an LLM response
5. Persist both user input and bot response

## Key Patterns

### Peer/Session Model

```python
peer = honcho_client.peer(id=user_identifier)
session = honcho_client.session(id=chat_identifier)
```

Messages are persisted using `session.add_messages()` with both user and assistant message objects.

### LLM Integration

Uses `session.context().to_openai()` for automatic format conversion of chat history.

### Message Sending

Handles Telegram's 4096-character limit by automatically splitting lengthy responses.

## Chat Type Behavior

| Chat Type | Response Trigger | Session Scope | Memory Type |
|-----------|------------------|---------------|------------|
| Private | All messages | Per-user | Individual conversation history |
| Group | Mentions/replies | Shared group | Group conversation context |

## Commands

- `/dialectic`: Query conversation history through Honcho's chat API
- `/start`: User onboarding

## Configuration

- Honcho client initialization
- Assistant peer with observation disabled
- OpenAI client (configurable for OpenRouter)
- Environment variables: BOT_TOKEN, MODEL_NAME, MODEL_API_KEY
