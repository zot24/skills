> Source: https://hermes-agent.nousresearch.com/docs/user-guide/features/mcp/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# MCP (Model Context Protocol)


MCP lets Hermes Agent connect to external tool servers so the agent can use tools that live outside Hermes itself — GitHub, databases, file systems, browser stacks, internal APIs, and more.

If you have ever wanted Hermes to use a tool that already exists somewhere else, MCP is usually the cleanest way to do it.

## What MCP gives you<a href="#what-mcp-gives-you" class="hash-link" aria-label="Direct link to What MCP gives you" translate="no" title="Direct link to What MCP gives you">​</a>

- Access to external tool ecosystems without writing a native Hermes tool first
- Local stdio servers and remote HTTP MCP servers in the same config
- Automatic tool discovery and registration at startup
- Utility wrappers for MCP resources and prompts when supported by the server
- Per-server filtering so you can expose only the MCP tools you actually want Hermes to see

## Quick start<a href="#quick-start" class="hash-link" aria-label="Direct link to Quick start" translate="no" title="Direct link to Quick start">​</a>

1.  Install MCP support (already included if you used the standard install script):


``` prism-code
cd ~/.hermes/hermes-agent
uv pip install -e ".[mcp]"
```


2.  Add an MCP server to `~/.hermes/config.yaml`:


``` prism-code
mcp_servers:
  filesystem:
    command: "npx"
    args: ["-y", "@modelcontextprotocol/server-filesystem", "/home/user/projects"]
```


3.  Start Hermes:


``` prism-code
hermes chat
```


4.  Ask Hermes to use the MCP-backed capability.

For example:


``` prism-code
List the files in /home/user/projects and summarize the repo structure.
```


Hermes will discover the MCP server's tools and use them like any other tool.

## Two kinds of MCP servers<a href="#two-kinds-of-mcp-servers" class="hash-link" aria-label="Direct link to Two kinds of MCP servers" translate="no" title="Direct link to Two kinds of MCP servers">​</a>

### Stdio servers<a href="#stdio-servers" class="hash-link" aria-label="Direct link to Stdio servers" translate="no" title="Direct link to Stdio servers">​</a>

Stdio servers run as local subprocesses and talk over stdin/stdout.


``` prism-code
mcp_servers:
  github:
    command: "npx"
    args: ["-y", "@modelcontextprotocol/server-github"]
    env:
      GITHUB_PERSONAL_ACCESS_TOKEN: "***"
```


Use stdio servers when:

- the server is installed locally
- you want low-latency access to local resources
- you are following MCP server docs that show `command`, `args`, and `env`

### HTTP servers<a href="#http-servers" class="hash-link" aria-label="Direct link to HTTP servers" translate="no" title="Direct link to HTTP servers">​</a>

HTTP MCP servers are remote endpoints Hermes connects to directly.


``` prism-code
mcp_servers:
  remote_api:
    url: "https://mcp.example.com/mcp"
    headers:
      Authorization: "Bearer ***"
```


Use HTTP servers when:

- the MCP server is hosted elsewhere
- your organization exposes internal MCP endpoints
- you do not want Hermes spawning a local subprocess for that integration

## Basic configuration reference<a href="#basic-configuration-reference" class="hash-link" aria-label="Direct link to Basic configuration reference" translate="no" title="Direct link to Basic configuration reference">​</a>

Hermes reads MCP config from `~/.hermes/config.yaml` under `mcp_servers`.

### Common keys<a href="#common-keys" class="hash-link" aria-label="Direct link to Common keys" translate="no" title="Direct link to Common keys">​</a>

| Key               | Type    | Meaning                                          |
|-------------------|---------|--------------------------------------------------|
| `command`         | string  | Executable for a stdio MCP server                |
| `args`            | list    | Arguments for the stdio server                   |
| `env`             | mapping | Environment variables passed to the stdio server |
| `url`             | string  | HTTP MCP endpoint                                |
| `headers`         | mapping | HTTP headers for remote servers                  |
| `timeout`         | number  | Tool call timeout                                |
| `connect_timeout` | number  | Initial connection timeout                       |
| `enabled`         | bool    | If `false`, Hermes skips the server entirely     |
| `tools`           | mapping | Per-server tool filtering and utility policy     |

### Minimal stdio example<a href="#minimal-stdio-example" class="hash-link" aria-label="Direct link to Minimal stdio example" translate="no" title="Direct link to Minimal stdio example">​</a>


``` prism-code
mcp_servers:
  filesystem:
    command: "npx"
    args: ["-y", "@modelcontextprotocol/server-filesystem", "/tmp"]
```


### Minimal HTTP example<a href="#minimal-http-example" class="hash-link" aria-label="Direct link to Minimal HTTP example" translate="no" title="Direct link to Minimal HTTP example">​</a>


``` prism-code
mcp_servers:
  company_api:
    url: "https://mcp.internal.example.com"
    headers:
      Authorization: "Bearer ***"
```


## How Hermes registers MCP tools<a href="#how-hermes-registers-mcp-tools" class="hash-link" aria-label="Direct link to How Hermes registers MCP tools" translate="no" title="Direct link to How Hermes registers MCP tools">​</a>

Hermes prefixes MCP tools so they do not collide with built-in names:


``` prism-code
mcp_<server_name>_<tool_name>
```


Examples:

| Server       | MCP tool       | Registered name            |
|--------------|----------------|----------------------------|
| `filesystem` | `read_file`    | `mcp_filesystem_read_file` |
| `github`     | `create-issue` | `mcp_github_create_issue`  |
| `my-api`     | `query.data`   | `mcp_my_api_query_data`    |

In practice, you usually do not need to call the prefixed name manually — Hermes sees the tool and chooses it during normal reasoning.

## MCP utility tools<a href="#mcp-utility-tools" class="hash-link" aria-label="Direct link to MCP utility tools" translate="no" title="Direct link to MCP utility tools">​</a>

When supported, Hermes also registers utility tools around MCP resources and prompts:

- `list_resources`
- `read_resource`
- `list_prompts`
- `get_prompt`

These are registered per server with the same prefix pattern, for example:

- `mcp_github_list_resources`
- `mcp_github_get_prompt`

### Important<a href="#important" class="hash-link" aria-label="Direct link to Important" translate="no" title="Direct link to Important">​</a>

These utility tools are now capability-aware:

- Hermes only registers resource utilities if the MCP session actually supports resource operations
- Hermes only registers prompt utilities if the MCP session actually supports prompt operations

So a server that exposes callable tools but no resources/prompts will not get those extra wrappers.

## Per-server filtering<a href="#per-server-filtering" class="hash-link" aria-label="Direct link to Per-server filtering" translate="no" title="Direct link to Per-server filtering">​</a>

You can control which tools each MCP server contributes to Hermes, allowing fine-grained management of your tool namespace.

### Disable a server entirely<a href="#disable-a-server-entirely" class="hash-link" aria-label="Direct link to Disable a server entirely" translate="no" title="Direct link to Disable a server entirely">​</a>


``` prism-code
mcp_servers:
  legacy:
    url: "https://mcp.legacy.internal"
    enabled: false
```


If `enabled: false`, Hermes skips the server completely and does not even attempt a connection.

### Whitelist server tools<a href="#whitelist-server-tools" class="hash-link" aria-label="Direct link to Whitelist server tools" translate="no" title="Direct link to Whitelist server tools">​</a>


``` prism-code
mcp_servers:
  github:
    command: "npx"
    args: ["-y", "@modelcontextprotocol/server-github"]
    env:
      GITHUB_PERSONAL_ACCESS_TOKEN: "***"
    tools:
      include: [create_issue, list_issues]
```


Only those MCP server tools are registered.

### Blacklist server tools<a href="#blacklist-server-tools" class="hash-link" aria-label="Direct link to Blacklist server tools" translate="no" title="Direct link to Blacklist server tools">​</a>


``` prism-code
mcp_servers:
  stripe:
    url: "https://mcp.stripe.com"
    tools:
      exclude: [delete_customer]
```


All server tools are registered except the excluded ones.

### Precedence rule<a href="#precedence-rule" class="hash-link" aria-label="Direct link to Precedence rule" translate="no" title="Direct link to Precedence rule">​</a>

If both are present:


``` prism-code
tools:
  include: [create_issue]
  exclude: [create_issue, delete_issue]
```


`include` wins.

### Filter utility tools too<a href="#filter-utility-tools-too" class="hash-link" aria-label="Direct link to Filter utility tools too" translate="no" title="Direct link to Filter utility tools too">​</a>

You can also separately disable Hermes-added utility wrappers:


``` prism-code
mcp_servers:
  docs:
    url: "https://mcp.docs.example.com"
    tools:
      prompts: false
      resources: false
```


That means:

- `tools.resources: false` disables `list_resources` and `read_resource`
- `tools.prompts: false` disables `list_prompts` and `get_prompt`

### Full example<a href="#full-example" class="hash-link" aria-label="Direct link to Full example" translate="no" title="Direct link to Full example">​</a>


``` prism-code
mcp_servers:
  github:
    command: "npx"
    args: ["-y", "@modelcontextprotocol/server-github"]
    env:
      GITHUB_PERSONAL_ACCESS_TOKEN: "***"
    tools:
      include: [create_issue, list_issues, search_code]
      prompts: false

  stripe:
    url: "https://mcp.stripe.com"
    headers:
      Authorization: "Bearer ***"
    tools:
      exclude: [delete_customer]
      resources: false

  legacy:
    url: "https://mcp.legacy.internal"
    enabled: false
```


## What happens if everything is filtered out?<a href="#what-happens-if-everything-is-filtered-out" class="hash-link" aria-label="Direct link to What happens if everything is filtered out?" translate="no" title="Direct link to What happens if everything is filtered out?">​</a>

If your config filters out all callable tools and disables or omits all supported utilities, Hermes does not create an empty runtime MCP toolset for that server.

That keeps the tool list clean.

## Runtime behavior<a href="#runtime-behavior" class="hash-link" aria-label="Direct link to Runtime behavior" translate="no" title="Direct link to Runtime behavior">​</a>

### Discovery time<a href="#discovery-time" class="hash-link" aria-label="Direct link to Discovery time" translate="no" title="Direct link to Discovery time">​</a>

Hermes discovers MCP servers at startup and registers their tools into the normal tool registry.

### Dynamic Tool Discovery<a href="#dynamic-tool-discovery" class="hash-link" aria-label="Direct link to Dynamic Tool Discovery" translate="no" title="Direct link to Dynamic Tool Discovery">​</a>

MCP servers can notify Hermes when their available tools change at runtime by sending a `notifications/tools/list_changed` notification. When Hermes receives this notification, it automatically re-fetches the server's tool list and updates the registry — no manual `/reload-mcp` required.

This is useful for MCP servers whose capabilities change dynamically (e.g. a server that adds tools when a new database schema is loaded, or removes tools when a service goes offline).

The refresh is lock-protected so rapid-fire notifications from the same server don't cause overlapping refreshes. Prompt and resource change notifications (`prompts/list_changed`, `resources/list_changed`) are received but not yet acted on.

### Reloading<a href="#reloading" class="hash-link" aria-label="Direct link to Reloading" translate="no" title="Direct link to Reloading">​</a>

If you change MCP config, use:


``` prism-code
/reload-mcp
```


This reloads MCP servers from config and refreshes the available tool list. For runtime tool changes pushed by the server itself, see [Dynamic Tool Discovery](#dynamic-tool-discovery) above.

### Toolsets<a href="#toolsets" class="hash-link" aria-label="Direct link to Toolsets" translate="no" title="Direct link to Toolsets">​</a>

Each configured MCP server also creates a runtime toolset when it contributes at least one registered tool:


``` prism-code
mcp-<server>
```


That makes MCP servers easier to reason about at the toolset level.

## Security model<a href="#security-model" class="hash-link" aria-label="Direct link to Security model" translate="no" title="Direct link to Security model">​</a>

### Stdio env filtering<a href="#stdio-env-filtering" class="hash-link" aria-label="Direct link to Stdio env filtering" translate="no" title="Direct link to Stdio env filtering">​</a>

For stdio servers, Hermes does not blindly pass your full shell environment.

Only explicitly configured `env` plus a safe baseline are passed through. This reduces accidental secret leakage.

### Config-level exposure control<a href="#config-level-exposure-control" class="hash-link" aria-label="Direct link to Config-level exposure control" translate="no" title="Direct link to Config-level exposure control">​</a>

The new filtering support is also a security control:

- disable dangerous tools you do not want the model to see
- expose only a minimal whitelist for a sensitive server
- disable resource/prompt wrappers when you do not want that surface exposed

## Example use cases<a href="#example-use-cases" class="hash-link" aria-label="Direct link to Example use cases" translate="no" title="Direct link to Example use cases">​</a>

### GitHub server with a minimal issue-management surface<a href="#github-server-with-a-minimal-issue-management-surface" class="hash-link" aria-label="Direct link to GitHub server with a minimal issue-management surface" translate="no" title="Direct link to GitHub server with a minimal issue-management surface">​</a>


``` prism-code
mcp_servers:
  github:
    command: "npx"
    args: ["-y", "@modelcontextprotocol/server-github"]
    env:
      GITHUB_PERSONAL_ACCESS_TOKEN: "***"
    tools:
      include: [list_issues, create_issue, update_issue]
      prompts: false
      resources: false
```


Use it like:


``` prism-code
Show me open issues labeled bug, then draft a new issue for the flaky MCP reconnection behavior.
```


### Stripe server with dangerous actions removed<a href="#stripe-server-with-dangerous-actions-removed" class="hash-link" aria-label="Direct link to Stripe server with dangerous actions removed" translate="no" title="Direct link to Stripe server with dangerous actions removed">​</a>


``` prism-code
mcp_servers:
  stripe:
    url: "https://mcp.stripe.com"
    headers:
      Authorization: "Bearer ***"
    tools:
      exclude: [delete_customer, refund_payment]
```


Use it like:


``` prism-code
Look up the last 10 failed payments and summarize common failure reasons.
```


### Filesystem server for a single project root<a href="#filesystem-server-for-a-single-project-root" class="hash-link" aria-label="Direct link to Filesystem server for a single project root" translate="no" title="Direct link to Filesystem server for a single project root">​</a>


``` prism-code
mcp_servers:
  project_fs:
    command: "npx"
    args: ["-y", "@modelcontextprotocol/server-filesystem", "/home/user/my-project"]
```


Use it like:


``` prism-code
Inspect the project root and explain the directory layout.
```


## Troubleshooting<a href="#troubleshooting" class="hash-link" aria-label="Direct link to Troubleshooting" translate="no" title="Direct link to Troubleshooting">​</a>

### MCP server not connecting<a href="#mcp-server-not-connecting" class="hash-link" aria-label="Direct link to MCP server not connecting" translate="no" title="Direct link to MCP server not connecting">​</a>

Check:


``` prism-code
# Verify MCP deps are installed (already included in standard install)
cd ~/.hermes/hermes-agent && uv pip install -e ".[mcp]"

node --version
npx --version
```


Then verify your config and restart Hermes.

### Tools not appearing<a href="#tools-not-appearing" class="hash-link" aria-label="Direct link to Tools not appearing" translate="no" title="Direct link to Tools not appearing">​</a>

Possible causes:

- the server failed to connect
- discovery failed
- your filter config excluded the tools
- the utility capability does not exist on that server
- the server is disabled with `enabled: false`

If you are intentionally filtering, this is expected.

### Why didn't resource or prompt utilities appear?<a href="#why-didnt-resource-or-prompt-utilities-appear" class="hash-link" aria-label="Direct link to Why didn&#39;t resource or prompt utilities appear?" translate="no" title="Direct link to Why didn&#39;t resource or prompt utilities appear?">​</a>

Because Hermes now only registers those wrappers when both are true:

1.  your config allows them
2.  the server session actually supports the capability

This is intentional and keeps the tool list honest.

## MCP Sampling Support<a href="#mcp-sampling-support" class="hash-link" aria-label="Direct link to MCP Sampling Support" translate="no" title="Direct link to MCP Sampling Support">​</a>

MCP servers can request LLM inference from Hermes via the `sampling/createMessage` protocol. This allows an MCP server to ask Hermes to generate text on its behalf — useful for servers that need LLM capabilities but don't have their own model access.

Sampling is **enabled by default** for all MCP servers (when the MCP SDK supports it). Configure it per-server under the `sampling` key:


``` prism-code
mcp_servers:
  my_server:
    command: "my-mcp-server"
    sampling:
      enabled: true            # Enable sampling (default: true)
      model: "openai/gpt-4o"  # Override model for sampling requests (optional)
      max_tokens_cap: 4096     # Max tokens per sampling response (default: 4096)
      timeout: 30              # Timeout in seconds per request (default: 30)
      max_rpm: 10              # Rate limit: max requests per minute (default: 10)
      max_tool_rounds: 5       # Max tool-use rounds in sampling loops (default: 5)
      allowed_models: []       # Allowlist of model names the server may request (empty = any)
      log_level: "info"        # Audit log level: debug, info, or warning (default: info)
```


The sampling handler includes a sliding-window rate limiter, per-request timeouts, and tool-loop depth limits to prevent runaway usage. Metrics (request count, errors, tokens used) are tracked per server instance.

To disable sampling for a specific server:


``` prism-code
mcp_servers:
  untrusted_server:
    url: "https://mcp.example.com"
    sampling:
      enabled: false
```


## Running Hermes as an MCP server<a href="#running-hermes-as-an-mcp-server" class="hash-link" aria-label="Direct link to Running Hermes as an MCP server" translate="no" title="Direct link to Running Hermes as an MCP server">​</a>

In addition to connecting **to** MCP servers, Hermes can also **be** an MCP server. This lets other MCP-capable agents (Claude Code, Cursor, Codex, or any MCP client) use Hermes's messaging capabilities — list conversations, read message history, and send messages across all your connected platforms.

### When to use this<a href="#when-to-use-this" class="hash-link" aria-label="Direct link to When to use this" translate="no" title="Direct link to When to use this">​</a>

- You want Claude Code, Cursor, or another coding agent to send and read Telegram/Discord/Slack messages through Hermes
- You want a single MCP server that bridges to all of Hermes's connected messaging platforms at once
- You already have a running Hermes gateway with connected platforms

### Quick start<a href="#quick-start-1" class="hash-link" aria-label="Direct link to Quick start" translate="no" title="Direct link to Quick start">​</a>


``` prism-code
hermes mcp serve
```


This starts a stdio MCP server. The MCP client (not you) manages the process lifecycle.

### MCP client configuration<a href="#mcp-client-configuration" class="hash-link" aria-label="Direct link to MCP client configuration" translate="no" title="Direct link to MCP client configuration">​</a>

Add Hermes to your MCP client config. For example, in Claude Code's `~/.claude/claude_desktop_config.json`:


``` prism-code
{
  "mcpServers": {
    "hermes": {
      "command": "hermes",
      "args": ["mcp", "serve"]
    }
  }
}
```


Or if you installed Hermes in a specific location:


``` prism-code
{
  "mcpServers": {
    "hermes": {
      "command": "/home/user/.hermes/hermes-agent/venv/bin/hermes",
      "args": ["mcp", "serve"]
    }
  }
}
```


### Available tools<a href="#available-tools" class="hash-link" aria-label="Direct link to Available tools" translate="no" title="Direct link to Available tools">​</a>

The MCP server exposes 10 tools, matching OpenClaw's channel bridge surface plus a Hermes-specific channel browser:

| Tool                    | Description                                                                     |
|-------------------------|---------------------------------------------------------------------------------|
| `conversations_list`    | List active messaging conversations. Filter by platform or search by name.      |
| `conversation_get`      | Get detailed info about one conversation by session key.                        |
| `messages_read`         | Read recent message history for a conversation.                                 |
| `attachments_fetch`     | Extract non-text attachments (images, media) from a specific message.           |
| `events_poll`           | Poll for new conversation events since a cursor position.                       |
| `events_wait`           | Long-poll / block until the next event arrives (near-real-time).                |
| `messages_send`         | Send a message through a platform (e.g. `telegram:123456`, `discord:#general`). |
| `channels_list`         | List available messaging targets across all platforms.                          |
| `permissions_list_open` | List pending approval requests observed during this bridge session.             |
| `permissions_respond`   | Allow or deny a pending approval request.                                       |

### Event system<a href="#event-system" class="hash-link" aria-label="Direct link to Event system" translate="no" title="Direct link to Event system">​</a>

The MCP server includes a live event bridge that polls Hermes's session database for new messages. This gives MCP clients near-real-time awareness of incoming conversations:


``` prism-code
# Poll for new events (non-blocking)
events_poll(after_cursor=0)

# Wait for next event (blocks up to timeout)
events_wait(after_cursor=42, timeout_ms=30000)
```


Event types: `message`, `approval_requested`, `approval_resolved`

The event queue is in-memory and starts when the bridge connects. Older messages are available through `messages_read`.

### Options<a href="#options" class="hash-link" aria-label="Direct link to Options" translate="no" title="Direct link to Options">​</a>


``` prism-code
hermes mcp serve              # Normal mode
hermes mcp serve --verbose    # Debug logging on stderr
```


### How it works<a href="#how-it-works" class="hash-link" aria-label="Direct link to How it works" translate="no" title="Direct link to How it works">​</a>

The MCP server reads conversation data directly from Hermes's session store (`~/.hermes/sessions/sessions.json` and the SQLite database). A background thread polls the database for new messages and maintains an in-memory event queue. For sending messages, it uses the same `send_message` infrastructure as the Hermes agent itself.

The gateway does NOT need to be running for read operations (listing conversations, reading history, polling events). It DOES need to be running for send operations, since the platform adapters need active connections.

### Current limits<a href="#current-limits" class="hash-link" aria-label="Direct link to Current limits" translate="no" title="Direct link to Current limits">​</a>

- Stdio transport only (no HTTP MCP transport yet)
- Event polling at ~200ms intervals via mtime-optimized DB polling (skips work when files are unchanged)
- No `claude/channel` push notification protocol yet
- Text-only sends (no media/attachment sending through `messages_send`)

## Related docs<a href="#related-docs" class="hash-link" aria-label="Direct link to Related docs" translate="no" title="Direct link to Related docs">​</a>

- [Use MCP with Hermes](/docs/guides/use-mcp-with-hermes)
- [CLI Commands](/docs/reference/cli-commands)
- [Slash Commands](/docs/reference/slash-commands)
- [FAQ](/docs/reference/faq)


- <a href="#what-mcp-gives-you" class="table-of-contents__link toc-highlight">What MCP gives you</a>
- <a href="#quick-start" class="table-of-contents__link toc-highlight">Quick start</a>
- <a href="#two-kinds-of-mcp-servers" class="table-of-contents__link toc-highlight">Two kinds of MCP servers</a>
  - <a href="#stdio-servers" class="table-of-contents__link toc-highlight">Stdio servers</a>
  - <a href="#http-servers" class="table-of-contents__link toc-highlight">HTTP servers</a>
- <a href="#basic-configuration-reference" class="table-of-contents__link toc-highlight">Basic configuration reference</a>
  - <a href="#common-keys" class="table-of-contents__link toc-highlight">Common keys</a>
  - <a href="#minimal-stdio-example" class="table-of-contents__link toc-highlight">Minimal stdio example</a>
  - <a href="#minimal-http-example" class="table-of-contents__link toc-highlight">Minimal HTTP example</a>
- <a href="#how-hermes-registers-mcp-tools" class="table-of-contents__link toc-highlight">How Hermes registers MCP tools</a>
- <a href="#mcp-utility-tools" class="table-of-contents__link toc-highlight">MCP utility tools</a>
  - <a href="#important" class="table-of-contents__link toc-highlight">Important</a>
- <a href="#per-server-filtering" class="table-of-contents__link toc-highlight">Per-server filtering</a>
  - <a href="#disable-a-server-entirely" class="table-of-contents__link toc-highlight">Disable a server entirely</a>
  - <a href="#whitelist-server-tools" class="table-of-contents__link toc-highlight">Whitelist server tools</a>
  - <a href="#blacklist-server-tools" class="table-of-contents__link toc-highlight">Blacklist server tools</a>
  - <a href="#precedence-rule" class="table-of-contents__link toc-highlight">Precedence rule</a>
  - <a href="#filter-utility-tools-too" class="table-of-contents__link toc-highlight">Filter utility tools too</a>
  - <a href="#full-example" class="table-of-contents__link toc-highlight">Full example</a>
- <a href="#what-happens-if-everything-is-filtered-out" class="table-of-contents__link toc-highlight">What happens if everything is filtered out?</a>
- <a href="#runtime-behavior" class="table-of-contents__link toc-highlight">Runtime behavior</a>
  - <a href="#discovery-time" class="table-of-contents__link toc-highlight">Discovery time</a>
  - <a href="#dynamic-tool-discovery" class="table-of-contents__link toc-highlight">Dynamic Tool Discovery</a>
  - <a href="#reloading" class="table-of-contents__link toc-highlight">Reloading</a>
  - <a href="#toolsets" class="table-of-contents__link toc-highlight">Toolsets</a>
- <a href="#security-model" class="table-of-contents__link toc-highlight">Security model</a>
  - <a href="#stdio-env-filtering" class="table-of-contents__link toc-highlight">Stdio env filtering</a>
  - <a href="#config-level-exposure-control" class="table-of-contents__link toc-highlight">Config-level exposure control</a>
- <a href="#example-use-cases" class="table-of-contents__link toc-highlight">Example use cases</a>
  - <a href="#github-server-with-a-minimal-issue-management-surface" class="table-of-contents__link toc-highlight">GitHub server with a minimal issue-management surface</a>
  - <a href="#stripe-server-with-dangerous-actions-removed" class="table-of-contents__link toc-highlight">Stripe server with dangerous actions removed</a>
  - <a href="#filesystem-server-for-a-single-project-root" class="table-of-contents__link toc-highlight">Filesystem server for a single project root</a>
- <a href="#troubleshooting" class="table-of-contents__link toc-highlight">Troubleshooting</a>
  - <a href="#mcp-server-not-connecting" class="table-of-contents__link toc-highlight">MCP server not connecting</a>
  - <a href="#tools-not-appearing" class="table-of-contents__link toc-highlight">Tools not appearing</a>
  - <a href="#why-didnt-resource-or-prompt-utilities-appear" class="table-of-contents__link toc-highlight">Why didn't resource or prompt utilities appear?</a>
- <a href="#mcp-sampling-support" class="table-of-contents__link toc-highlight">MCP Sampling Support</a>
- <a href="#running-hermes-as-an-mcp-server" class="table-of-contents__link toc-highlight">Running Hermes as an MCP server</a>
  - <a href="#when-to-use-this" class="table-of-contents__link toc-highlight">When to use this</a>
  - <a href="#quick-start-1" class="table-of-contents__link toc-highlight">Quick start</a>
  - <a href="#mcp-client-configuration" class="table-of-contents__link toc-highlight">MCP client configuration</a>
  - <a href="#available-tools" class="table-of-contents__link toc-highlight">Available tools</a>
  - <a href="#event-system" class="table-of-contents__link toc-highlight">Event system</a>
  - <a href="#options" class="table-of-contents__link toc-highlight">Options</a>
  - <a href="#how-it-works" class="table-of-contents__link toc-highlight">How it works</a>
  - <a href="#current-limits" class="table-of-contents__link toc-highlight">Current limits</a>
- <a href="#related-docs" class="table-of-contents__link toc-highlight">Related docs</a>


