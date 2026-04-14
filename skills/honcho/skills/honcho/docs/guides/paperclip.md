<!-- Source: https://docs.honcho.dev/v3/guides/integrations/paperclip -->

# Paperclip Integration

## Overview

The Honcho plugin for Paperclip enables persistent memory while maintaining Paperclip as the primary system of record. Supports tools, synchronization, migration imports, and manual prompt previews.

## Installation

Navigate to Instance Settings -> Plugins in Paperclip, select Install Plugin, enter `@honcho-ai/paperclip-honcho`.

## Configuration

Key settings:
- **`honchoApiKey`** - Required, pointing to stored credential
- **`honchoApiBaseUrl`** - Defaults to `https://api.honcho.dev`
- **`workspacePrefix`** - Defaults to `paperclip`
- **`syncIssueComments`** and **`syncIssueDocuments`** - Enabled by default
- **`enablePeerChat`** - Required for peer chat functionality
- **`observe_me`** and **`observe_others`** - Both default to `true`

## Memory Organization

- Each company -> one workspace
- Each issue -> a session
- Humans and agents -> peers participating across scopes

## Agent Tools

Nine specialized tools available:
- `honcho_get_issue_context` and `honcho_get_workspace_context` for broad recall
- `honcho_search_memory`, `honcho_search_messages`, `honcho_search_conclusions` for targeted retrieval
- `honcho_ask_peer` for peer chat queries
- Context retrieval tools for sessions, agents, and delegated work

## Operator Capabilities

Configuration validation, connection testing, memory initialization, source rescanning, history import, prompt previews, mapping repair, and issue resync.
