<!-- Source: https://docs.honcho.dev/v3/guides/integrations/claude-code -->

# Claude Code with Honcho

## Overview

Honcho provides persistent memory capabilities for Claude Code, enabling Claude to retain information across context window resets, session restarts, and tool switches.

## Quick Start

1. Obtain an API key from app.honcho.dev
2. Add environment variables to your shell configuration
3. Install the plugin via `/plugin marketplace add plastic-labs/claude-honcho`
4. Restart Claude Code

## Key Features

- **Persistent cross-session memory** that survives context resets
- **Git awareness** for branch detection and change tracking
- **Flexible session mapping** with three strategy options (per-directory, git-branch, or chat-instance)
- **Multi-tool support** allowing context sharing between Claude Code and Cursor
- **Team collaboration** through shared workspaces with namespace isolation

## Configuration

Configuration is managed through `~/.honcho/config.json`. All configuration lives in a single global file. You can edit it directly, use the /honcho:config skill interactively, or use the set_config MCP tool.

Session strategies determine memory organization:
- **Per-directory** (default): One session per project
- **Git-branch**: Sessions tied to branch names
- **Chat-instance**: Fresh sessions on each restart

## MCP Tools & Commands

Available tools include semantic search, knowledge queries, insight storage, and configuration management. Skills (slash commands) provide interactive setup, configuration, status checking, and user preference interviews.

## Claude Desktop Integration

Honcho integrates with Claude Desktop through Model Context Protocol (MCP) configuration, requiring Node.js and custom server setup in the Claude Desktop settings.
