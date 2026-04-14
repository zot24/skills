<!-- Source: https://docs.honcho.dev/v3/guides/integrations/langgraph -->

# LangGraph Integration

## Overview

Building a stateful conversational AI agent by combining LangGraph's orchestration capabilities with Honcho's memory layer. Enables agents to maintain context across multiple conversation sessions.

## Key Architecture

- **LangGraph**: Manages conversation flow
- **Honcho**: Handles message storage and context retrieval
- **LLM**: Generates responses using formatted context

This separation eliminates manual management of conversation history, token constraints, and message formatting.

## Installation

Python: `honcho-ai`, `langgraph`, `langchain-core`, `openai`, `python-dotenv`

TypeScript: `@honcho-ai/sdk`, `@langchain/langgraph`, `openai`, `dotenv`

## Core Implementation

**State Definition**: TypedDict or Annotation stores user messages, assistant responses, and Honcho objects (Peer instances and Session).

**Chatbot Function** (4 steps):
1. Store user messages in the session
2. Retrieve relevant conversation history with token limits
3. Generate LLM responses using formatted context
4. Store assistant responses for future retrieval

**Graph Construction**: Simple linear flow: START -> chatbot node -> END.

## Context Retrieval

The `context()` method automatically manages conversation history, respects token limits, handles lengthy conversations through message summarization, and provides peer-specific understanding. The `SessionContext` object includes messages, summaries, peer representations, and peer cards.

## Production Considerations

Honcho accepts nanoid-compatible strings for identifiers, enabling direct integration with authentication systems (Auth0, Firebase, Clerk) without modification.

## Enhancement Opportunities

- Custom LangChain tools leveraging Honcho's memory and context features
- Multi-agent systems where each agent operates as a distinct Honcho Peer with independent memory
