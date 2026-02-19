# MCP (Model Context Protocol) Integration Guide

> **Source**: Official Claude Code Documentation & MCP Specification
> **Source URL**: https://code.claude.com/docs/en/mcp
> **Last Updated**: 2026-02-19

## Overview

The Model Context Protocol (MCP) is an open protocol that standardizes how applications provide context to Large Language Models (LLMs). MCP enables Claude Code to connect to external data sources, tools, and services through a unified interface.

## What is MCP?

MCP creates a standardized way for LLMs to interact with external systems by defining:
- **Resources**: Data and content exposed by servers
- **Prompts**: Reusable prompt templates and workflows
- **Tools**: Functions that LLMs can invoke to perform actions

### Key Benefits

1. **Unified Integration**: Single protocol for all external connections
2. **Composability**: Mix and match different MCP servers
3. **Security**: Controlled access with OAuth 2.0 and scoped permissions
4. **Extensibility**: Easy to add new capabilities
5. **Reusability**: Share servers across projects and users
6. **Multiple Transports**: HTTP (recommended), SSE, and stdio support

## MCP Architecture

### Three Core Components

```
+-------------+          +-------------+          +-------------+
|   Claude    | <--MCP--> | MCP Server  | <------> |  External   |
|    Code     |          |             |          |   System    |
|  (Client)   |          |  (Bridge)   |          | (Database,  |
|             |          |             |          |  API, etc)  |
+-------------+          +-------------+          +-------------+
```

**Claude Code (MCP Client)**:
- Discovers available MCP servers
- Queries resources and tools
- Executes tool calls
- Manages server lifecycle

**MCP Server**:
- Exposes resources (data)
- Provides tools (actions)
- Offers prompts (templates)
- Handles external system communication

**External System**:
- Database, filesystem, API, or service
- Original source of data/functionality
- Accessed by MCP server

### Communication Transports

MCP supports three transport types:

| Transport | Recommended | Description |
|-----------|-------------|-------------|
| **HTTP** (Streamable) | **Yes** | HTTP-based transport with streaming support. Recommended for new servers. |
| **SSE** (Server-Sent Events) | Deprecated | Legacy HTTP+SSE transport. Use HTTP instead for new implementations. |
| **stdio** | For local | Standard input/output. Best for local processes and CLI tools. |

### Communication Model

MCP uses JSON-RPC 2.0 for communication:
```json
{
  "jsonrpc": "2.0",
  "method": "tools/call",
  "params": {
    "name": "query_database",
    "arguments": {
      "sql": "SELECT * FROM users"
    }
  },
  "id": 1
}
```

## MCP Configuration Scopes

Claude Code supports three scopes for MCP server configuration:

| Scope | Location | Shared | Use Case |
|-------|----------|--------|----------|
| **Local** | `.claude.local/settings.json` | No (gitignored) | Personal servers with credentials |
| **Project** | `.mcp.json` or `.claude/settings.json` | Yes (via git) | Team-shared servers |
| **User** | `~/.claude/settings.json` | Across projects | Personal global servers |

### Project-Level MCP Configuration (`.mcp.json`)

The recommended approach for team-shared MCP configuration:

```json
{
  "mcpServers": {
    "server-name": {
      "command": "npx",
      "args": ["-y", "@org/mcp-server"],
      "env": {
        "API_KEY": "${API_KEY}"
      }
    }
  }
}
```

**Note**: Environment variables use `${VAR_NAME}` syntax for expansion. This allows team members to use different credentials while sharing the same configuration.

### Adding MCP Servers via CLI

The `claude mcp add` command is the easiest way to configure servers:

```bash
# Add a stdio server
claude mcp add my-server -- npx -y @org/mcp-server

# Add with environment variables
claude mcp add my-server -e API_KEY=abc123 -- npx -y @org/mcp-server

# Add to specific scope
claude mcp add my-server --scope project -- npx -y @org/mcp-server
claude mcp add my-server --scope user -- npx -y @org/mcp-server
claude mcp add my-server --scope local -- npx -y @org/mcp-server

# Add an HTTP/SSE server
claude mcp add my-server --transport http --url https://example.com/mcp

# List configured servers
claude mcp list

# Remove a server
claude mcp remove my-server
```

### OAuth 2.0 Authentication

MCP servers can use OAuth 2.0 for authentication:

```bash
# Add server with OAuth (browser-based auth flow)
claude mcp add my-server --transport http --url https://api.example.com/mcp
```

When connecting to an OAuth-enabled server, Claude Code will:
1. Open a browser for authentication
2. Complete the OAuth flow
3. Store tokens securely
4. Automatically refresh tokens as needed

## Core MCP Primitives

### 1. Resources

**Purpose**: Expose data and content to Claude

Resources can be accessed using the `@` mention syntax in conversations:
```
@mcp-server-name://resource-path
```

**Example Resource Types**:
```markdown
# File system resource
file:///path/to/document.txt

# Database query result
postgres://localhost/mydb?query=SELECT*FROM users

# API endpoint data
http://api.example.com/v1/users
```

**Resource Schema**:
```typescript
interface Resource {
  uri: string;              // Unique identifier
  name: string;             // Human-readable name
  description?: string;     // What this resource contains
  mimeType?: string;        // Content type
  text?: string;            // Text content
  blob?: Uint8Array;        // Binary content
}
```

### 2. Prompts

**Purpose**: Reusable prompt templates and workflows

**Prompt Schema**:
```typescript
interface Prompt {
  name: string;
  description?: string;
  arguments?: PromptArgument[];
}

interface PromptArgument {
  name: string;
  description?: string;
  required?: boolean;
}
```

### 3. Tools

**Purpose**: Actions that Claude can execute

**Tool Schema**:
```typescript
interface Tool {
  name: string;
  description?: string;
  inputSchema: {
    type: "object";
    properties?: Record<string, JSONSchema>;
    required?: string[];
  };
}
```

## MCP Server Configuration Examples

### stdio Transport (Local Servers)

#### PostgreSQL Server
```json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-postgres",
        "postgresql://localhost/mydb"
      ]
    }
  }
}
```

#### Filesystem Server
```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/path/to/allowed/directory"
      ]
    }
  }
}
```

#### GitHub Server
```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-github"
      ],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

### HTTP Transport (Remote Servers)

```json
{
  "mcpServers": {
    "remote-api": {
      "type": "http",
      "url": "https://api.example.com/mcp",
      "headers": {
        "Authorization": "Bearer ${API_TOKEN}"
      }
    }
  }
}
```

### Multiple Servers Configuration

```json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres", "postgresql://localhost/db1"]
    },
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-filesystem", "/Users/username/projects"]
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    },
    "remote-service": {
      "type": "http",
      "url": "https://mcp.example.com/api"
    }
  }
}
```

## MCP Tool Search

Claude Code includes a **Tool Search** feature that helps discover relevant MCP tools across all configured servers:

- Claude can search for tools by description or capability
- Tool Search works across all configured MCP servers
- Useful when you have many MCP servers and need to find the right tool
- Claude automatically uses Tool Search when a user request might benefit from MCP tools

## Plugin-Provided MCP Servers

Plugins can bundle MCP servers that are automatically configured when the plugin is installed:

```json
{
  "mcpServers": {
    "plugin-server": {
      "command": "node",
      "args": ["./mcp-server/index.js"]
    }
  }
}
```

Plugin-provided servers are configured in the plugin's `plugin.json` and automatically available to Claude Code users who install the plugin.

## Managed MCP Configuration

Organizations can deploy MCP servers through managed settings:

- Administrators configure MCP servers centrally
- Servers are automatically available to all team members
- Credentials and access are managed at the organization level
- Overrides local and project-level configurations when specified

## Using MCP in Claude Code

### Tool Discovery

When MCP servers are configured, their tools appear alongside native Claude Code tools:

```markdown
Available tools:
- Read (native)
- Write (native)
- Grep (native)
- mcp__postgres__query (MCP)
- mcp__github__create_issue (MCP)
- mcp__filesystem__read_file (MCP)
```

### Tool Naming Convention

MCP tools follow the pattern: `mcp__{server}__{tool_name}`

Examples:
- `mcp__postgres__execute_query`
- `mcp__github__search_repositories`
- `mcp__slack__post_message`

### Invoking MCP Tools

Claude can automatically invoke MCP tools when appropriate:

```markdown
User: "Query the users table in the database"

Claude uses: mcp__postgres__query
Parameters: {sql: "SELECT * FROM users LIMIT 10"}
```

### Accessing MCP Resources with @-mentions

Resources from MCP servers can be referenced using the `@` syntax:

```markdown
User: "Look at @postgres://users/schema"

Claude accesses the resource from the postgres MCP server.
```

## MCP in Subagents

### Inheriting MCP Tools

Agents inherit MCP tools when `tools` field is omitted:

```yaml
---
name: database-analyst
description: Analyze database queries and performance
# tools field omitted - inherits all tools including MCP
model: sonnet
---

You are a database analyst with access to PostgreSQL tools.
Use the database query tools to analyze data and performance.
```

### Restricting MCP Access

Limit agent to specific tools:

```yaml
---
name: readonly-reviewer
description: Review code without modification capabilities
tools: Read, Grep, Glob, mcp__github__get_file
model: sonnet
---

You can read files and access GitHub for code review,
but cannot modify files or create issues.
```

### Specifying MCP Servers for Agents

Use the `mcpServers` field to control which MCP servers an agent can access:

```yaml
---
name: data-analyst
description: Analyze data using database tools
mcpServers: postgres, analytics-server
tools: Read, Grep
model: sonnet
---

You have access to the postgres and analytics MCP servers.
```

## Building Custom MCP Servers

### Server Implementation Options

**Node.js/TypeScript** (Recommended):
```typescript
import { Server } from "@modelcontextprotocol/sdk/server/index.js";
import { StdioServerTransport } from "@modelcontextprotocol/sdk/server/stdio.js";

const server = new Server({
  name: "my-server",
  version: "1.0.0"
}, {
  capabilities: {
    tools: {}
  }
});

// Define tools
server.setRequestHandler("tools/list", async () => ({
  tools: [{
    name: "my_tool",
    description: "Does something useful",
    inputSchema: {
      type: "object",
      properties: {
        param: { type: "string" }
      }
    }
  }]
}));

// Start server
const transport = new StdioServerTransport();
await server.connect(transport);
```

**Python**:
```python
from mcp.server import Server
from mcp.types import Tool, TextContent

server = Server("my-server")

@server.list_tools()
async def list_tools() -> list[Tool]:
    return [
        Tool(
            name="my_tool",
            description="Does something useful",
            inputSchema={
                "type": "object",
                "properties": {
                    "param": {"type": "string"}
                }
            }
        )
    ]

@server.call_tool()
async def call_tool(name: str, arguments: dict) -> list[TextContent]:
    if name == "my_tool":
        result = do_something(arguments["param"])
        return [TextContent(type="text", text=result)]
```

### Server Development Best Practices

1. **Clear Tool Descriptions**: Help Claude understand when to use tools
2. **Comprehensive Schemas**: Define all parameters with types and descriptions
3. **Error Handling**: Return meaningful error messages
4. **Security**: Validate inputs, limit access, use authentication
5. **Use HTTP Transport**: Recommended for new servers (over SSE or stdio)
6. **OAuth 2.0**: Implement OAuth for servers requiring authentication
7. **Documentation**: Provide usage examples and limitations
8. **Testing**: Verify tool behavior with various inputs

## Security Considerations

### Authentication

```json
{
  "mcpServers": {
    "secure-api": {
      "command": "npx",
      "args": ["-y", "@company/mcp-server"],
      "env": {
        "API_KEY": "${API_KEY}",
        "API_SECRET": "${API_SECRET}"
      }
    }
  }
}
```

### OAuth 2.0 for Remote Servers

For HTTP-based MCP servers, OAuth 2.0 provides secure authentication:
- Browser-based authorization flow
- Automatic token refresh
- Secure credential storage
- No manual token management required

### Access Control

- **Filesystem servers**: Limit to specific directories
- **Database servers**: Use read-only credentials when possible
- **API servers**: Implement rate limiting and scoping
- **Use scopes**: Place sensitive servers in local scope (`.claude.local/settings.json`)

### Data Privacy

- **Local processing**: stdio MCP servers run locally
- **Credential management**: Store secrets in environment variables with `${VAR}` expansion
- **Audit logging**: Track MCP tool usage
- **Scope separation**: Use local scope for credentials, project scope for shared config

## Troubleshooting

### Server Not Starting

```bash
# Check server installation
npx -y @modelcontextprotocol/server-postgres --version

# List configured MCP servers
claude mcp list

# Check environment variables
echo $GITHUB_TOKEN
```

### Tools Not Appearing

1. Verify server is in configuration file
2. Run `claude mcp list` to check status
3. Restart Claude Code
4. Check server logs for errors
5. Validate JSON syntax in config files

### Tool Execution Failures

1. Check input schema matches arguments
2. Verify credentials and permissions
3. Review server logs
4. Test tool independently

### Performance Issues

1. Add caching in server implementation
2. Limit data returned from resources
3. Use pagination for large datasets
4. Optimize database queries
5. Consider HTTP transport for remote servers (better connection management)

## Official MCP Servers

### Database Servers
- **PostgreSQL** (`@modelcontextprotocol/server-postgres`)
- **SQLite** (`@modelcontextprotocol/server-sqlite`)

### Filesystem Servers
- **Filesystem** (`@modelcontextprotocol/server-filesystem`)
- **Memory** (`@modelcontextprotocol/server-memory`)

### Development Servers
- **GitHub** (`@modelcontextprotocol/server-github`)
- **GitLab** (`@modelcontextprotocol/server-gitlab`)
- **Sentry** (`@modelcontextprotocol/server-sentry`)

### Productivity Servers
- **Google Drive** (`@modelcontextprotocol/server-gdrive`)
- **Google Maps** (`@modelcontextprotocol/server-google-maps`)
- **Slack** (`@modelcontextprotocol/server-slack`)

### AI & Search Servers
- **Brave Search** (`@modelcontextprotocol/server-brave-search`)
- **Fetch** (`@modelcontextprotocol/server-fetch`)
- **Puppeteer** (`@modelcontextprotocol/server-puppeteer`)

## Resources

### Official Documentation
- MCP Specification: https://modelcontextprotocol.io/
- Server SDK: https://github.com/modelcontextprotocol/sdk
- Example Servers: https://github.com/modelcontextprotocol/servers

### Community
- Server Directory: https://modelcontextprotocol.io/servers
- GitHub Discussions: Community support and examples

## Quick Reference

### Add MCP Server (CLI)
```bash
claude mcp add server-name -- npx -y @org/mcp-server
claude mcp add server-name -e KEY=val -- npx -y @org/mcp-server
claude mcp add server-name --transport http --url https://example.com/mcp
```

### Project Config (`.mcp.json`)
```json
{
  "mcpServers": {
    "server-name": {
      "command": "npx",
      "args": ["-y", "@org/server-package"],
      "env": {"KEY": "${ENV_VAR}"}
    }
  }
}
```

### Use MCP Tool in Agent
```yaml
---
name: mcp-agent
description: Agent with MCP access
mcpServers: server-name
# Or omit tools to inherit all MCP tools
---
```

### Invoke MCP Tool
```markdown
Claude automatically selects appropriate MCP tools based on:
- Tool descriptions
- User request context
- Available parameters
- Tool Search across all servers
```

### Check Available MCP Tools
```bash
claude mcp list
```
Look for tools prefixed with `mcp__` in tool listings.
