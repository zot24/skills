<!-- Source: https://docs.honcho.dev/v3/guides/integrations/mcp -->

# MCP Server

## Overview

The Honcho Model Context Protocol server provides persistent memory and personalization capabilities to MCP-compatible AI tools.

**Server Endpoint:** `https://mcp.honcho.dev`

An API key from app.honcho.dev is required for access.

## Client Setup

### Claude Desktop
Use npx to run `mcp-remote` with authorization headers. Config files:
- **macOS:** `~/Library/Application Support/Claude/claude_desktop_config.json`
- **Windows:** `%APPDATA%\Claude\claude_desktop_config.json`

### Claude Code
```bash
claude mcp add honcho --transport http --url "https://mcp.honcho.dev"
```

### Other Clients
- **Codex:** `~/.codex/config.toml` (stdio transport via mcp-remote bridge)
- **Cursor:** `~/.cursor/mcp.json` (native HTTP support)
- **Windsurf:** `~/.codeium/windsurf/mcp_config.json` (uses "serverUrl")
- **VS Code:** `.vscode/mcp.json` or User Settings JSON
- **Cline:** Application Support directory
- **Zed:** `~/.config/zed/settings.json` (requires v0.214.5+)

## Required Headers

| Header | Status | Purpose |
|--------|--------|---------|
| Authorization | Required | Bearer token format |
| X-Honcho-User-Name | Required | Name for AI to use |
| X-Honcho-Assistant-Name | Optional | AI peer identifier (default: "Assistant") |
| X-Honcho-Workspace-ID | Optional | Project isolation (default: "default") |

## Available Tools

- **Workspace**: inspect, list, search, metadata management
- **Peer**: creation, listing, chat, card operations, context retrieval
- **Session**: creation, listing, deletion, cloning, peer/message management
- **Conclusions**: listing, querying, creation, deletion
- **System**: dream scheduling, queue status monitoring

## Troubleshooting

| Issue | Resolution |
|-------|-----------|
| Tools unavailable | Complete client restart after configuration |
| Authentication failures | Verify API key format (starts with `hch-`) |
| Missing npx | Install Node.js runtime |
| No personalization data | Expected for new accounts; requires multiple conversations |
| Connection problems | Confirm network accessibility to server endpoint |
