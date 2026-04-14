<!-- Source: https://docs.honcho.dev/v3/documentation/introduction/vibecoding -->

# Agentic Development

Honcho provides tools for building persistent memory into AI agents through the Model Context Protocol (MCP) server, Claude Code integration, and agent skills for various coding assistants.

## MCP Server Setup

The fastest implementation path involves three steps:

1. Obtain credentials at app.honcho.dev
2. Configure your client using the appropriate template
3. Restart your application

Configuration examples are provided for Claude Desktop, Cursor, and Claude Code, each requiring an API key and optional user identifier.

## Claude Code Plugin

Developers can integrate Honcho directly into Claude Code through the marketplace:

```
/plugin marketplace add plastic-labs/claude-honcho
/plugin install honcho@honcho
/plugin install honcho-dev@honcho
```

This approach enables persistent memory that survives context wipes and session restarts.

## Agent Skills

Installation uses npx (recommended) or manual curl-based setup. Three skills are available:

**honcho-integration**: Guides new implementations by exploring codebases, conducting interviews about architecture preferences, and implementing full integration with the SDK.

**migrate-honcho-py / migrate-honcho-ts**: Handles version upgrades from 1.6.0 to 2.0.0+, addressing API changes like terminology shifts and method renames.

## Key Resources

- Main documentation: https://docs.honcho.dev
- API reference and quickstart guides available
- GitHub repositories for Python SDK, TypeScript SDK, and starter templates
- Discord and Telegram bot examples provided

## Core Concept

Honcho is an open source memory library with a managed service for building stateful agents. It processes messages through background reasoning to generate conclusions stored as queryable representations.
