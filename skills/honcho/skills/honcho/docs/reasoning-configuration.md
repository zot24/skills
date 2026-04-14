<!-- Source: https://docs.honcho.dev/v3/documentation/features/advanced/reasoning-configuration -->

# Reasoning Configuration

## Overview

Honcho implements a hierarchical configuration system that allows customization of reasoning behavior across multiple levels. Configuration follows a hierarchy: **message > session > workspace > global defaults**.

## Configuration Hierarchy

The system operates with four tiers:

1. **Global Defaults** - System baseline settings
2. **Workspace Configuration** - Applied across all sessions in a workspace
3. **Session Configuration** - Applied to all messages within a session
4. **Message Configuration** - Applied to specific messages

More specific levels override general ones, enabling fine-grained control. All configuration fields are optional. If not specified, the value is inherited from the next level up.

## Key Configuration Options

**Reasoning Configuration**: Controls whether the system analyzes messages. The `enabled` boolean field determines if facts or representations are generated.

**Peer Card Configuration**: Two boolean fields manage biographical information cards:
- `use`: Activates peer cards during reasoning
- `create`: Generates or updates cards based on message content

**Summary Configuration**: Available only at workspace/session levels with three fields:
- `enabled`: Activates summarization
- `messages_per_short_summary`: Minimum 10 messages between short summaries
- `messages_per_long_summary`: Must be >=20 and greater than short summary interval

**Dream Configuration**: Controls the consolidation process, with `enabled` field that automatically disables if reasoning is disabled.

## Peer Observation

By default, Honcho observes all peers to generate representations. The `observe_me` configuration flag can disable this for peers like assistants where reasoning isn't needed.
