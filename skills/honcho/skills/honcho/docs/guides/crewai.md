<!-- Source: https://docs.honcho.dev/v3/guides/integrations/crewai -->

# CrewAI Integration

## Overview

Integrating Honcho's persistent memory system with CrewAI's agent orchestration framework. Enables AI agents to maintain and retrieve conversation history across sessions.

## Key Components

- **CrewAI**: Orchestrates agent behavior and task execution
- **Honcho**: Manages message storage and retrieves relevant context through semantic search

CrewAI automatically retrieves relevant conversation history from Honcho without needing to manually manage context, token limits, or message formatting.

## Installation

```bash
pip install honcho-crewai crewai python-dotenv
```

## HonchoStorage Implementation

`HonchoStorage` implements CrewAI's Storage interface through three methods:

- **save()** - Stores messages in Honcho sessions with peer associations
- **search()** - Performs semantic vector search with optional filtering
- **reset()** - Initiates new sessions for fresh conversations

### Filter Syntax

Search supports filters for peer_id, metadata, time ranges, and complex logical operators (AND, OR, NOT).

## Memory Integration Approaches

**Automatic Memory (HonchoStorage):** CrewAI handles memory transparently; suitable for straightforward conversational workflows.

**Tool-Based Memory:** Agents explicitly control when and how to query memory; ideal for multi-step reasoning and multi-agent systems.

### Available Tools

- **HonchoGetContextTool** - Retrieves comprehensive conversation history with token management
- **HonchoSearchTool** - Performs targeted semantic searches
- **HonchoDialecticTool** - Queries peer representations for preferences and characteristics
