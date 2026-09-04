> Source: https://pi.dev/docs/latest/rpc



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# RPC Mode


RPC mode enables headless operation of the coding agent via a JSON protocol over stdin/stdout. This is useful for embedding the agent in other applications, IDEs, or custom UIs.

**Note for Node.js/TypeScript users**: If you're building a Node.js application, consider using `AgentSession` directly from `@earendil-works/pi-coding-agent` instead of spawning a subprocess. See [`src/core/agent-session.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/src/core/agent-session.ts) for the API. For a subprocess-based TypeScript client, see [`src/modes/rpc/rpc-client.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/src/modes/rpc/rpc-client.ts).


## Starting RPC Mode

<a href="#starting-rpc-mode" class="heading-anchor" aria-label="Permalink: Starting RPC Mode" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#starting-rpc-mode"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` bash
pi --mode rpc [options]
```

Common options:

- `--provider <name>`: Set the LLM provider (anthropic, openai, google, etc.)
- `--model <pattern>`: Model pattern or ID (supports `provider/id` and optional `:<thinking>`)
- `--name <name>` / `-n <name>`: Set the session display name at startup
- `--no-session`: Disable session persistence
- `--session-dir <path>`: Custom session storage directory


## Protocol Overview

<a href="#protocol-overview" class="heading-anchor" aria-label="Permalink: Protocol Overview" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#protocol-overview"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


- **Commands**: JSON objects sent to stdin, one per line
- **Responses**: JSON objects with `type: "response"` indicating command success/failure
- **Events**: Agent events streamed to stdout as JSON lines

All commands support an optional `id` field for request/response correlation. If provided, the corresponding response will include the same `id`. `bash_execution_update` events also include the `id` of their originating `bash` command.


### Framing

<a href="#framing" class="heading-anchor" aria-label="Permalink: Framing" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#framing"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


RPC mode uses strict JSONL semantics with LF (`\n`) as the only record delimiter.

This matters for clients:

- Split records on `\n` only
- Accept optional `\r\n` input by stripping a trailing `\r`
- Do not use generic line readers that treat Unicode separators as newlines

In particular, Node `readline` is not protocol-compliant for RPC mode because it also splits on `U+2028` and `U+2029`, which are valid inside JSON strings.


## Commands

<a href="#commands" class="heading-anchor" aria-label="Permalink: Commands" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#commands"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


### Prompting

<a href="#prompting" class="heading-anchor" aria-label="Permalink: Prompting" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#prompting"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


#### prompt

<a href="#prompt" class="heading-anchor" aria-label="Permalink: prompt" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#prompt"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Send a user prompt to the agent. The command response is emitted after the prompt is accepted, queued, or handled. Events continue streaming asynchronously after acceptance.

``` json
{"id": "req-1", "type": "prompt", "message": "Hello, world!"}
```

With images:

``` json
{"type": "prompt", "message": "What's in this image?", "images": [{"type": "image", "data": "base64-encoded-data", "mimeType": "image/png"}]}
```

**During streaming**: If the agent is already streaming, you must specify `streamingBehavior` to queue the message:

``` json
{"type": "prompt", "message": "New instruction", "streamingBehavior": "steer"}
```

- `"steer"`: Queue the message while the agent is running. It is delivered after the current assistant turn finishes executing its tool calls, before the next LLM call.
- `"followUp"`: Wait until the agent finishes. Message is delivered only when agent stops.

If the agent is streaming and no `streamingBehavior` is specified, the command returns an error.

**Extension commands**: If the message is an extension command (e.g., `/mycommand`), it executes immediately even during streaming. Extension commands manage their own LLM interaction via `pi.sendMessage()`.

**Input expansion**: Skill commands (`/skill:name`) and prompt templates (`/template`) are expanded before sending/queueing.

Response:

``` json
{"id": "req-1", "type": "response", "command": "prompt", "success": true}
```

`success: true` means the prompt was accepted, queued, or handled immediately. `success: false` means the prompt was rejected before acceptance. Failures after acceptance are reported through the normal event and message stream, not as a second `response` for the same request id.

The `images` field is optional. Each image uses `ImageContent` format: `{"type": "image", "data": "base64-encoded-data", "mimeType": "image/png"}`.


#### steer

<a href="#steer" class="heading-anchor" aria-label="Permalink: steer" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#steer"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Queue a steering message while the agent is running. It is delivered after the current assistant turn finishes executing its tool calls, before the next LLM call. Skill commands and prompt templates are expanded. Extension commands are not allowed (use `prompt` instead).

``` json
{"type": "steer", "message": "Stop and do this instead"}
```

With images:

``` json
{"type": "steer", "message": "Look at this instead", "images": [{"type": "image", "data": "base64-encoded-data", "mimeType": "image/png"}]}
```

The `images` field is optional. Each image uses `ImageContent` format (same as `prompt`).

Response:

``` json
{"type": "response", "command": "steer", "success": true}
```

See [set_steering_mode](#set_steering_mode) for controlling how steering messages are processed.


#### follow_up

<a href="#follow_up" class="heading-anchor" aria-label="Permalink: follow_up" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#follow_up"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Queue a follow-up message to be processed after the agent finishes. Delivered only when agent has no more tool calls or steering messages. Skill commands and prompt templates are expanded. Extension commands are not allowed (use `prompt` instead).

``` json
{"type": "follow_up", "message": "After you're done, also do this"}
```

With images:

``` json
{"type": "follow_up", "message": "Also check this image", "images": [{"type": "image", "data": "base64-encoded-data", "mimeType": "image/png"}]}
```

The `images` field is optional. Each image uses `ImageContent` format (same as `prompt`).

Response:

``` json
{"type": "response", "command": "follow_up", "success": true}
```

See [set_follow_up_mode](#set_follow_up_mode) for controlling how follow-up messages are processed.


#### abort

<a href="#abort" class="heading-anchor" aria-label="Permalink: abort" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#abort"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Abort the current operation and wait for the session to become idle before responding.

``` json
{"type": "abort"}
```

Response:

``` json
{"type": "response", "command": "abort", "success": true}
```


#### clear_queue

<a href="#clear_queue" class="heading-anchor" aria-label="Permalink: clear_queue" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#clear_queue"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Remove queued steering and follow-up messages and return their text.

``` json
{"type": "clear_queue"}
```

Response:

``` json
{
  "type": "response",
  "command": "clear_queue",
  "success": true,
  "data": {
    "steering": ["Change direction"],
    "followUp": ["Summarize when finished"]
  }
}
```

To implement interactive Esc behavior, send `clear_queue` before `abort`, then restore the returned text in the client editor. `abort` continues queued messages when they remain in the session.


#### new_session

<a href="#new_session" class="heading-anchor" aria-label="Permalink: new_session" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#new_session"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Start a fresh session. Can be cancelled by a `session_before_switch` extension event handler.

``` json
{"type": "new_session"}
```

With optional parent session tracking:

``` json
{"type": "new_session", "parentSession": "/path/to/parent-session.jsonl"}
```

Response:

``` json
{"type": "response", "command": "new_session", "success": true, "data": {"cancelled": false}}
```

If an extension cancelled:

``` json
{"type": "response", "command": "new_session", "success": true, "data": {"cancelled": true}}
```


### State

<a href="#state" class="heading-anchor" aria-label="Permalink: State" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#state"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


#### get_state

<a href="#get_state" class="heading-anchor" aria-label="Permalink: get_state" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#get_state"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Get current session state.

``` json
{"type": "get_state"}
```

Response:

``` json
{
  "type": "response",
  "command": "get_state",
  "success": true,
  "data": {
    "model": {...},
    "thinkingLevel": "medium",
    "isStreaming": false,
    "isCompacting": false,
    "steeringMode": "all",
    "followUpMode": "one-at-a-time",
    "sessionFile": "/path/to/session.jsonl",
    "sessionId": "abc123",
    "sessionName": "my-feature-work",
    "autoCompactionEnabled": true,
    "messageCount": 5,
    "pendingMessageCount": 0
  }
}
```

The `model` field is a full [Model](#model) object or `null`. The `sessionName` field is the display name set via `set_session_name`, or omitted if not set.


#### get_messages

<a href="#get_messages" class="heading-anchor" aria-label="Permalink: get_messages" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#get_messages"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Get all messages in the conversation.

``` json
{"type": "get_messages"}
```

Response:

``` json
{
  "type": "response",
  "command": "get_messages",
  "success": true,
  "data": {"messages": [...]}
}
```

Messages are `AgentMessage` objects (see [Message Types](#message-types)).


### Model

<a href="#model" class="heading-anchor" aria-label="Permalink: Model" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#model"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


#### set_model

<a href="#set_model" class="heading-anchor" aria-label="Permalink: set_model" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#set_model"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Switch to a specific model.

``` json
{"type": "set_model", "provider": "anthropic", "modelId": "claude-sonnet-4-20250514"}
```

Response contains the full [Model](#model) object:

``` json
{
  "type": "response",
  "command": "set_model",
  "success": true,
  "data": {...}
}
```


#### cycle_model

<a href="#cycle_model" class="heading-anchor" aria-label="Permalink: cycle_model" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#cycle_model"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Cycle to the next available model. Returns `null` data if only one model available.

``` json
{"type": "cycle_model"}
```

Response:

``` json
{
  "type": "response",
  "command": "cycle_model",
  "success": true,
  "data": {
    "model": {...},
    "thinkingLevel": "medium",
    "isScoped": false
  }
}
```

The `model` field is a full [Model](#model) object.


#### get_available_models

<a href="#get_available_models" class="heading-anchor" aria-label="Permalink: get_available_models" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#get_available_models"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


List all configured models.

``` json
{"type": "get_available_models"}
```

Response contains an array of full [Model](#model) objects:

``` json
{
  "type": "response",
  "command": "get_available_models",
  "success": true,
  "data": {
    "models": [...]
  }
}
```


### Thinking

<a href="#thinking" class="heading-anchor" aria-label="Permalink: Thinking" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#thinking"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


#### set_thinking_level

<a href="#set_thinking_level" class="heading-anchor" aria-label="Permalink: set_thinking_level" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#set_thinking_level"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Set the reasoning/thinking level for models that support it.

``` json
{"type": "set_thinking_level", "level": "high"}
```

Levels: `"off"`, `"minimal"`, `"low"`, `"medium"`, `"high"`, `"xhigh"`, `"max"`

`"xhigh"` and `"max"` are exposed only when supported by the selected model. Some models, including GPT-5.6, expose both.

Response:

``` json
{"type": "response", "command": "set_thinking_level", "success": true}
```


#### cycle_thinking_level

<a href="#cycle_thinking_level" class="heading-anchor" aria-label="Permalink: cycle_thinking_level" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#cycle_thinking_level"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Cycle through available thinking levels. Returns `null` data if model doesn't support thinking.

``` json
{"type": "cycle_thinking_level"}
```

Response:

``` json
{
  "type": "response",
  "command": "cycle_thinking_level",
  "success": true,
  "data": {"level": "high"}
}
```


#### get_available_thinking_levels

<a href="#get_available_thinking_levels" class="heading-anchor" aria-label="Permalink: get_available_thinking_levels" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#get_available_thinking_levels"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


List the thinking levels supported by the current model. Returns `["off"]` for a model without reasoning support.

``` json
{"type": "get_available_thinking_levels"}
```

Response:

``` json
{
  "type": "response",
  "command": "get_available_thinking_levels",
  "success": true,
  "data": {
    "levels": ["off", "minimal", "low", "medium", "high"]
  }
}
```


### Queue Modes

<a href="#queue-modes" class="heading-anchor" aria-label="Permalink: Queue Modes" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#queue-modes"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


#### set_steering_mode

<a href="#set_steering_mode" class="heading-anchor" aria-label="Permalink: set_steering_mode" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#set_steering_mode"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Control how steering messages (from `steer`) are delivered.

``` json
{"type": "set_steering_mode", "mode": "one-at-a-time"}
```

Modes:

- `"all"`: Deliver all steering messages after the current assistant turn finishes executing its tool calls
- `"one-at-a-time"`: Deliver one steering message per completed assistant turn (default)

Response:

``` json
{"type": "response", "command": "set_steering_mode", "success": true}
```


#### set_follow_up_mode

<a href="#set_follow_up_mode" class="heading-anchor" aria-label="Permalink: set_follow_up_mode" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#set_follow_up_mode"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Control how follow-up messages (from `follow_up`) are delivered.

``` json
{"type": "set_follow_up_mode", "mode": "one-at-a-time"}
```

Modes:

- `"all"`: Deliver all follow-up messages when agent finishes
- `"one-at-a-time"`: Deliver one follow-up message per agent completion (default)

Response:

``` json
{"type": "response", "command": "set_follow_up_mode", "success": true}
```


### Compaction

<a href="#compaction" class="heading-anchor" aria-label="Permalink: Compaction" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#compaction"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


#### compact

<a href="#compact" class="heading-anchor" aria-label="Permalink: compact" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#compact"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Manually compact conversation context to reduce token usage.

``` json
{"type": "compact"}
```

With custom instructions:

``` json
{"type": "compact", "customInstructions": "Focus on code changes"}
```

Response:

``` json
{
  "type": "response",
  "command": "compact",
  "success": true,
  "data": {
    "summary": "Summary of conversation...",
    "firstKeptEntryId": "abc123",
    "tokensBefore": 150000,
    "estimatedTokensAfter": 32000,
    "usage": {
      "input": 32000,
      "output": 1200,
      "cacheRead": 0,
      "cacheWrite": 0,
      "totalTokens": 33200,
      "cost": {"input": 0.01, "output": 0.02, "cacheRead": 0, "cacheWrite": 0, "total": 0.03}
    },
    "details": {}
  }
}
```

`estimatedTokensAfter` is a heuristic estimate over the rebuilt message context immediately after compaction, not a provider-exact token count. `usage` reports the LLM call or calls that generated the summary and may be omitted by custom compaction handlers.


#### set_auto_compaction

<a href="#set_auto_compaction" class="heading-anchor" aria-label="Permalink: set_auto_compaction" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#set_auto_compaction"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Enable or disable automatic compaction when context is nearly full.

``` json
{"type": "set_auto_compaction", "enabled": true}
```

Response:

``` json
{"type": "response", "command": "set_auto_compaction", "success": true}
```


### Retry

<a href="#retry" class="heading-anchor" aria-label="Permalink: Retry" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#retry"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


#### set_auto_retry

<a href="#set_auto_retry" class="heading-anchor" aria-label="Permalink: set_auto_retry" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#set_auto_retry"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Enable or disable automatic retry on transient errors (overloaded, rate limit, 5xx).

``` json
{"type": "set_auto_retry", "enabled": true}
```

Response:

``` json
{"type": "response", "command": "set_auto_retry", "success": true}
```


#### abort_retry

<a href="#abort_retry" class="heading-anchor" aria-label="Permalink: abort_retry" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#abort_retry"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Abort an in-progress retry (cancel the delay and stop retrying).

``` json
{"type": "abort_retry"}
```

Response:

``` json
{"type": "response", "command": "abort_retry", "success": true}
```


### Bash

<a href="#bash" class="heading-anchor" aria-label="Permalink: Bash" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#bash"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


#### bash

<a href="#bash-1" class="heading-anchor" aria-label="Permalink: bash" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#bash-1"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Execute a shell command and add output to conversation context. Output streams as `bash_execution_update` events while the command runs; the response contains the final result.

``` json
{"id": "req-1", "type": "bash", "command": "ls -la"}
```

Include an `id` to associate streamed `bash_execution_update` events with this command.

Response:

``` json
{
  "id": "req-1",
  "type": "response",
  "command": "bash",
  "success": true,
  "data": {
    "output": "total 48\ndrwxr-xr-x ...",
    "exitCode": 0,
    "cancelled": false,
    "truncated": false
  }
}
```

If output was truncated, includes `fullOutputPath`:

``` json
{
  "type": "response",
  "command": "bash",
  "success": true,
  "data": {
    "output": "truncated output...",
    "exitCode": 0,
    "cancelled": false,
    "truncated": true,
    "fullOutputPath": "/tmp/pi-bash-abc123.log"
  }
}
```

**How bash results reach the LLM:**

The `bash` command executes immediately and returns a `BashResult`. Internally, a `BashExecutionMessage` is created and stored in the agent's message state.

When the next `prompt` command is sent, all messages (including `BashExecutionMessage`) are transformed before being sent to the LLM. The `BashExecutionMessage` is converted to a `UserMessage` with this format:

    Ran `ls -la`
    ```
    total 48
    drwxr-xr-x ...
    ```

This means:

1.  Bash output is included in the LLM context on the **next prompt**, not immediately
2.  Multiple bash commands can be executed before a prompt; all outputs will be included


#### abort_bash

<a href="#abort_bash" class="heading-anchor" aria-label="Permalink: abort_bash" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#abort_bash"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Abort a running bash command.

``` json
{"type": "abort_bash"}
```

Response:

``` json
{"type": "response", "command": "abort_bash", "success": true}
```


### Session

<a href="#session" class="heading-anchor" aria-label="Permalink: Session" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#session"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


#### get_session_stats

<a href="#get_session_stats" class="heading-anchor" aria-label="Permalink: get_session_stats" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#get_session_stats"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Get token usage, cost statistics, and current context window usage.

``` json
{"type": "get_session_stats"}
```

Response:

``` json
{
  "type": "response",
  "command": "get_session_stats",
  "success": true,
  "data": {
    "sessionFile": "/path/to/session.jsonl",
    "sessionId": "abc123",
    "userMessages": 5,
    "assistantMessages": 5,
    "toolCalls": 12,
    "toolResults": 12,
    "totalMessages": 22,
    "tokens": {
      "input": 50000,
      "output": 10000,
      "cacheRead": 40000,
      "cacheWrite": 5000,
      "total": 105000
    },
    "cost": 0.45,
    "contextUsage": {
      "tokens": 60000,
      "contextWindow": 200000,
      "percent": 30
    }
  }
}
```

`tokens` and `cost` include assistant messages, usage reported by tools, and compaction/branch-summary generation across the full session. `contextUsage` contains the actual current context-window estimate used for compaction and footer display.

`contextUsage` is omitted when no model or context window is available. `contextUsage.tokens` and `contextUsage.percent` are `null` immediately after compaction until a fresh post-compaction assistant response provides valid usage data.


#### export_html

<a href="#export_html" class="heading-anchor" aria-label="Permalink: export_html" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#export_html"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Export session to an HTML file.

``` json
{"type": "export_html"}
```

With custom path:

``` json
{"type": "export_html", "outputPath": "/tmp/session.html"}
```

Response:

``` json
{
  "type": "response",
  "command": "export_html",
  "success": true,
  "data": {"path": "/tmp/session.html"}
}
```


#### switch_session

<a href="#switch_session" class="heading-anchor" aria-label="Permalink: switch_session" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#switch_session"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Load a different session file. Can be cancelled by a `session_before_switch` extension event handler.

``` json
{"type": "switch_session", "sessionPath": "/path/to/session.jsonl"}
```

Response:

``` json
{"type": "response", "command": "switch_session", "success": true, "data": {"cancelled": false}}
```

If an extension cancelled the switch:

``` json
{"type": "response", "command": "switch_session", "success": true, "data": {"cancelled": true}}
```


#### fork

<a href="#fork" class="heading-anchor" aria-label="Permalink: fork" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#fork"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Create a new fork from a previous user message on the active branch. Can be cancelled by a `session_before_fork` extension event handler. Returns the text of the message being forked from.

``` json
{"type": "fork", "entryId": "abc123"}
```

Response:

``` json
{
  "type": "response",
  "command": "fork",
  "success": true,
  "data": {"text": "The original prompt text...", "cancelled": false}
}
```

If an extension cancelled the fork:

``` json
{
  "type": "response",
  "command": "fork",
  "success": true,
  "data": {"text": "The original prompt text...", "cancelled": true}
}
```


#### clone

<a href="#clone" class="heading-anchor" aria-label="Permalink: clone" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#clone"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Duplicate the current active branch into a new session at the current position. Can be cancelled by a `session_before_fork` extension event handler.

``` json
{"type": "clone"}
```

Response:

``` json
{
  "type": "response",
  "command": "clone",
  "success": true,
  "data": {"cancelled": false}
}
```

If an extension cancelled the clone:

``` json
{
  "type": "response",
  "command": "clone",
  "success": true,
  "data": {"cancelled": true}
}
```


#### get_fork_messages

<a href="#get_fork_messages" class="heading-anchor" aria-label="Permalink: get_fork_messages" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#get_fork_messages"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Get user messages available for forking.

``` json
{"type": "get_fork_messages"}
```

Response:

``` json
{
  "type": "response",
  "command": "get_fork_messages",
  "success": true,
  "data": {
    "messages": [
      {"entryId": "abc123", "text": "First prompt..."},
      {"entryId": "def456", "text": "Second prompt..."}
    ]
  }
}
```


#### get_entries

<a href="#get_entries" class="heading-anchor" aria-label="Permalink: get_entries" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#get_entries"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Get all session entries in append order (excluding the session header). The session is an append-only tree of entries with stable ids, so an entry id works as a durable cursor: pass the last entry id you have seen as `since` to get only entries strictly after it, even across client restarts. Unlike `get_messages`, this includes pre-compaction history and abandoned branches.

``` json
{"type": "get_entries"}
```

With a cursor:

``` json
{"type": "get_entries", "since": "abc123"}
```

Response:

``` json
{
  "type": "response",
  "command": "get_entries",
  "success": true,
  "data": {
    "entries": [
      {"type": "message", "id": "def456", "parentId": "abc123", "timestamp": "...", "message": {"role": "user", "...": "..."}}
    ],
    "leafId": "def456"
  }
}
```

`leafId` is the id of the current leaf entry (`null` for an empty session), so a client can tell in one round trip whether the active branch moved. If `since` does not match any entry id, the response is `success: false`.


#### get_tree

<a href="#get_tree" class="heading-anchor" aria-label="Permalink: get_tree" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#get_tree"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Get the session as a tree of entries. Each node is `{entry, children, label?, labelTimestamp?}`. A well-formed session has a single root; orphaned entries (broken parent chain) also appear as roots.

``` json
{"type": "get_tree"}
```

Response:

``` json
{
  "type": "response",
  "command": "get_tree",
  "success": true,
  "data": {
    "tree": [
      {
        "entry": {"type": "message", "id": "abc123", "parentId": null, "...": "..."},
        "children": [
          {"entry": {"type": "message", "id": "def456", "parentId": "abc123", "...": "..."}, "children": []}
        ]
      }
    ],
    "leafId": "def456"
  }
}
```


#### get_last_assistant_text

<a href="#get_last_assistant_text" class="heading-anchor" aria-label="Permalink: get_last_assistant_text" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#get_last_assistant_text"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Get the text content of the last assistant message.

``` json
{"type": "get_last_assistant_text"}
```

Response:

``` json
{
  "type": "response",
  "command": "get_last_assistant_text",
  "success": true,
  "data": {"text": "The assistant's response..."}
}
```

Returns `{"text": null}` if no assistant messages exist.


#### set_session_name

<a href="#set_session_name" class="heading-anchor" aria-label="Permalink: set_session_name" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#set_session_name"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Set a display name for the current session. The name appears in session listings and helps identify sessions.

``` json
{"type": "set_session_name", "name": "my-feature-work"}
```

Response:

``` json
{
  "type": "response",
  "command": "set_session_name",
  "success": true
}
```

The current session name is available via `get_state` in the `sessionName` field. To set the initial name when starting RPC mode, pass `--name <name>` or `-n <name>` to the `pi --mode rpc` process.


### Commands

<a href="#commands-1" class="heading-anchor" aria-label="Permalink: Commands" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#commands-1"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


#### get_commands

<a href="#get_commands" class="heading-anchor" aria-label="Permalink: get_commands" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#get_commands"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Get available commands (extension commands, prompt templates, and skills). These can be invoked via the `prompt` command by prefixing with `/`.

``` json
{"type": "get_commands"}
```

Response:

``` json
{
  "type": "response",
  "command": "get_commands",
  "success": true,
  "data": {
    "commands": [
      {"name": "session-name", "description": "Set or clear session name", "source": "extension", "path": "/home/user/.pi/agent/extensions/session.ts"},
      {"name": "fix-tests", "description": "Fix failing tests", "source": "prompt", "location": "project", "path": "/home/user/myproject/.pi/agent/prompts/fix-tests.md"},
      {"name": "skill:brave-search", "description": "Web search via Brave API", "source": "skill", "location": "user", "path": "/home/user/.pi/agent/skills/brave-search/SKILL.md"}
    ]
  }
}
```

Each command has:

- `name`: Command name (invoke with `/name`)
- `description`: Human-readable description (optional for extension commands)
- `source`: What kind of command:
  - `"extension"`: Registered via `pi.registerCommand()` in an extension
  - `"prompt"`: Loaded from a prompt template `.md` file
  - `"skill"`: Loaded from a skill directory (name is prefixed with `skill:`)
- `location`: Where it was loaded from (optional, not present for extensions):
  - `"user"`: User-level (`~/.pi/agent/`)
  - `"project"`: Project-level (`./.pi/agent/`)
  - `"path"`: Explicit path via CLI or settings
- `path`: Absolute file path to the command source (optional)

**Note**: Built-in TUI commands (`/settings`, `/hotkeys`, etc.) are not included. They are handled only in interactive mode and would not execute if sent via `prompt`.


## Events

<a href="#events" class="heading-anchor" aria-label="Permalink: Events" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#events"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Events are streamed to stdout as JSON lines during agent operation. Events do not generally include an `id` field; `bash_execution_update` includes the `id` of its originating `bash` command when one was provided.


### Event Types

<a href="#event-types" class="heading-anchor" aria-label="Permalink: Event Types" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#event-types"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Event                               | Description                                                                                             |
|-------------------------------------|---------------------------------------------------------------------------------------------------------|
| `agent_start`                       | Agent begins processing                                                                                 |
| `agent_end`                         | One low-level agent run completes (may still be followed by retry, compaction, or queued continuations) |
| `agent_settled`                     | Agent run is fully settled; no automatic retry, compaction retry, or queued continuation remains        |
| `turn_start`                        | New turn begins                                                                                         |
| `turn_end`                          | Turn completes (includes assistant message and tool results)                                            |
| `message_start`                     | Message begins                                                                                          |
| `message_update`                    | Streaming update (text/thinking/toolcall deltas)                                                        |
| `message_end`                       | Message completes                                                                                       |
| `bash_execution_update`             | Direct RPC bash command output chunk                                                                    |
| `tool_execution_start`              | Tool begins execution                                                                                   |
| `tool_execution_update`             | Tool execution progress (streaming output)                                                              |
| `tool_execution_end`                | Tool completes                                                                                          |
| `queue_update`                      | Pending steering/follow-up queue changed                                                                |
| `compaction_start`                  | Compaction begins                                                                                       |
| `compaction_end`                    | Compaction completes                                                                                    |
| `auto_retry_start`                  | Auto-retry begins (after transient error)                                                               |
| `auto_retry_end`                    | Auto-retry completes (success or final failure)                                                         |
| `summarization_retry_scheduled`     | Retry scheduled for a transient compaction or branch-summary summarization error                        |
| `summarization_retry_attempt_start` | Retried summarization request starts                                                                    |
| `summarization_retry_finished`      | Summarization retry loop completes                                                                      |
| `extension_error`                   | Extension threw an error                                                                                |


### agent_start

<a href="#agent_start" class="heading-anchor" aria-label="Permalink: agent_start" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#agent_start"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Emitted when the agent begins processing a prompt.

``` json
{"type": "agent_start"}
```


### agent_end

<a href="#agent_end" class="heading-anchor" aria-label="Permalink: agent_end" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#agent_end"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Emitted when one low-level agent run completes. Contains all messages generated during this run. If `willRetry` is true, an automatic retry will follow.

``` json
{
  "type": "agent_end",
  "messages": [...],
  "willRetry": false
}
```


### agent_settled

<a href="#agent_settled" class="heading-anchor" aria-label="Permalink: agent_settled" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#agent_settled"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Emitted after the full session-level run settles. At this point Pi will not continue automatically through retry, compaction retry, or queued follow-up messages.

``` json
{"type": "agent_settled"}
```


### turn_start / turn_end

<a href="#turn_start--turn_end" class="heading-anchor" aria-label="Permalink: turn_start / turn_end" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#turn_start--turn_end"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


A turn consists of one assistant response plus any resulting tool calls and results.

``` json
{"type": "turn_start"}
```

``` json
{
  "type": "turn_end",
  "message": {...},
  "toolResults": [...]
}
```


### message_start / message_end

<a href="#message_start--message_end" class="heading-anchor" aria-label="Permalink: message_start / message_end" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#message_start--message_end"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Emitted when a message begins and completes. The `message` field contains an `AgentMessage`.

``` json
{"type": "message_start", "message": {...}}
{"type": "message_end", "message": {...}}
```


### message_update (Streaming)

<a href="#message_update-streaming" class="heading-anchor" aria-label="Permalink: message_update (Streaming)" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#message_update-streaming"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Emitted during streaming of assistant messages. Contains a delta event without a cumulative message snapshot.

``` json
{
  "type": "message_update",
  "usage": {
    "input": 100,
    "output": 1,
    "cacheRead": 0,
    "cacheWrite": 0,
    "totalTokens": 101,
    "cost": {"input": 0, "output": 0, "cacheRead": 0, "cacheWrite": 0, "total": 0}
  },
  "assistantMessageEvent": {
    "type": "text_delta",
    "contentIndex": 0,
    "delta": "Hello "
  }
}
```

The `assistantMessageEvent` field contains one of these delta types:

| Type             | Description                                       |
|------------------|---------------------------------------------------|
| `text_start`     | Text content block started                        |
| `text_delta`     | Text content chunk                                |
| `text_end`       | Text content block ended                          |
| `thinking_start` | Thinking block started                            |
| `thinking_delta` | Thinking content chunk                            |
| `thinking_end`   | Thinking block ended                              |
| `toolcall_start` | Tool call started (includes `id` and `toolName`)  |
| `toolcall_delta` | Tool call arguments chunk                         |
| `toolcall_end`   | Tool call ended (includes full `toolCall` object) |

Example streaming a text response:

``` json
{"type":"message_update","usage":{...},"assistantMessageEvent":{"type":"text_start","contentIndex":0}}
{"type":"message_update","usage":{...},"assistantMessageEvent":{"type":"text_delta","contentIndex":0,"delta":"Hello"}}
{"type":"message_update","usage":{...},"assistantMessageEvent":{"type":"text_delta","contentIndex":0,"delta":" world"}}
{"type":"message_update","usage":{...},"assistantMessageEvent":{"type":"text_end","contentIndex":0,"content":"Hello world"}}
```

The top-level `usage` field contains the latest cumulative provider-reported usage. It may remain zero until completion when a provider does not report usage during streaming.

Example starting a tool call:

``` json
{"type":"message_update","usage":{...},"assistantMessageEvent":{"type":"toolcall_start","contentIndex":1,"id":"call_abc123","toolName":"write"}}
```

`message_update` intentionally omits the former cumulative `message` field and `assistantMessageEvent.partial`. Clients that need a live partial message must assemble it from `message_start` and subsequent events using `contentIndex`. Treat `message_end.message` as authoritative. For tool calls, `toolcall_start` provides the call `id` and `toolName`; buffer `toolcall_delta.delta` for arguments. `toolcall_end.toolCall` contains the completed call.


### bash_execution_update

<a href="#bash_execution_update" class="heading-anchor" aria-label="Permalink: bash_execution_update" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#bash_execution_update"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Emitted once for each output chunk from a direct `bash` command. `id` matches the command's `id`, allowing clients to associate output with the correct command.

Events stream all output while the command runs, even if the final `bash` response's `output` is truncated.

``` json
{
  "type": "bash_execution_update",
  "id": "req-1",
  "delta": "total 48\n"
}
```


### tool_execution_start / tool_execution_update / tool_execution_end

<a href="#tool_execution_start--tool_execution_update--tool_execution_end" class="heading-anchor" aria-label="Permalink: tool_execution_start / tool_execution_update / tool_execution_end" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#tool_execution_start--tool_execution_update--tool_execution_end"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Emitted when a tool begins, streams progress, and completes execution.

``` json
{
  "type": "tool_execution_start",
  "toolCallId": "call_abc123",
  "toolName": "bash",
  "args": {"command": "ls -la"}
}
```

During execution, `tool_execution_update` events stream partial results (e.g., bash output as it arrives):

``` json
{
  "type": "tool_execution_update",
  "toolCallId": "call_abc123",
  "toolName": "bash",
  "args": {"command": "ls -la"},
  "partialResult": {
    "content": [{"type": "text", "text": "partial output so far..."}],
    "details": {"truncation": null, "fullOutputPath": null}
  }
}
```

When complete:

``` json
{
  "type": "tool_execution_end",
  "toolCallId": "call_abc123",
  "toolName": "bash",
  "result": {
    "content": [{"type": "text", "text": "total 48\n..."}],
    "details": {...}
  },
  "isError": false
}
```

Use `toolCallId` to correlate events. The `partialResult` in `tool_execution_update` contains the accumulated output so far (not just the delta), allowing clients to simply replace their display on each update.


### queue_update

<a href="#queue_update" class="heading-anchor" aria-label="Permalink: queue_update" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#queue_update"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Emitted whenever the pending steering or follow-up queue changes.

``` json
{
  "type": "queue_update",
  "steering": ["Focus on error handling"],
  "followUp": ["After that, summarize the result"]
}
```


### compaction_start / compaction_end

<a href="#compaction_start--compaction_end" class="heading-anchor" aria-label="Permalink: compaction_start / compaction_end" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#compaction_start--compaction_end"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Emitted when compaction runs, whether manual or automatic.

``` json
{"type": "compaction_start", "reason": "threshold"}
```

The `reason` field is `"manual"`, `"threshold"`, or `"overflow"`.

``` json
{
  "type": "compaction_end",
  "reason": "threshold",
  "result": {
    "summary": "Summary of conversation...",
    "firstKeptEntryId": "abc123",
    "tokensBefore": 150000,
    "estimatedTokensAfter": 32000,
    "usage": {
      "input": 32000,
      "output": 1200,
      "cacheRead": 0,
      "cacheWrite": 0,
      "totalTokens": 33200,
      "cost": {"input": 0.01, "output": 0.02, "cacheRead": 0, "cacheWrite": 0, "total": 0.03}
    },
    "details": {}
  },
  "aborted": false,
  "willRetry": false
}
```

If `reason` was `"overflow"` and compaction succeeds, `willRetry` is `true` and the agent will automatically retry the prompt.

If compaction was aborted, `result` is `null` and `aborted` is `true`.

If compaction failed (e.g., API quota exceeded), `result` is `null`, `aborted` is `false`, and `errorMessage` contains the error description.


### auto_retry_start / auto_retry_end

<a href="#auto_retry_start--auto_retry_end" class="heading-anchor" aria-label="Permalink: auto_retry_start / auto_retry_end" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#auto_retry_start--auto_retry_end"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Emitted when automatic retry is triggered after a transient error (overloaded, rate limit, 5xx).

``` json
{
  "type": "auto_retry_start",
  "attempt": 1,
  "maxAttempts": 3,
  "delayMs": 2000,
  "errorMessage": "529 {\"type\":\"error\",\"error\":{\"type\":\"overloaded_error\",\"message\":\"Overloaded\"}}"
}
```

``` json
{
  "type": "auto_retry_end",
  "success": true,
  "attempt": 2
}
```

On final failure (max retries exceeded):

``` json
{
  "type": "auto_retry_end",
  "success": false,
  "attempt": 3,
  "finalError": "529 overloaded_error: Overloaded"
}
```


### summarization_retry_scheduled / summarization_retry_attempt_start / summarization_retry_finished

<a href="#summarization_retry_scheduled--summarization_retry_attempt_start--summarization_retry_finished" class="heading-anchor" aria-label="Permalink: summarization_retry_scheduled / summarization_retry_attempt_start / summarization_retry_finished" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#summarization_retry_scheduled--summarization_retry_attempt_start--summarization_retry_finished"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Emitted when compaction or branch-summary summarization retries after a transient provider error. These events use the same retry settings as automatic assistant-turn retries.

``` json
{
  "type": "summarization_retry_scheduled",
  "attempt": 1,
  "maxAttempts": 3,
  "delayMs": 2000,
  "errorMessage": "terminated"
}
```

``` json
{
  "type": "summarization_retry_attempt_start",
  "source": "compaction",
  "reason": "threshold"
}
```

For branch summaries, `source` is `"branchSummary"` and no `reason` is present.

``` json
{
  "type": "summarization_retry_finished"
}
```


### extension_error

<a href="#extension_error" class="heading-anchor" aria-label="Permalink: extension_error" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#extension_error"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Emitted when an extension throws an error.

``` json
{
  "type": "extension_error",
  "extensionPath": "/path/to/extension.ts",
  "event": "tool_call",
  "error": "Error message..."
}
```


## Extension UI Protocol

<a href="#extension-ui-protocol" class="heading-anchor" aria-label="Permalink: Extension UI Protocol" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#extension-ui-protocol"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Extensions can request user interaction via `ctx.ui.select()`, `ctx.ui.confirm()`, etc. In RPC mode, these are translated into a request/response sub-protocol on top of the base command/event flow.

There are two categories of extension UI methods:

- **Dialog methods** (`select`, `confirm`, `input`, `editor`): emit an `extension_ui_request` on stdout and block until the client sends back an `extension_ui_response` on stdin with the matching `id`.
- **Fire-and-forget methods** (`notify`, `setStatus`, `setWidget`, `setTitle`, `set_editor_text`): emit an `extension_ui_request` on stdout but do not expect a response. The client can display the information or ignore it.

If a dialog method includes a `timeout` field, the agent-side will auto-resolve with a default value when the timeout expires. The client does not need to track timeouts.

Some `ExtensionUIContext` methods are not supported or degraded in RPC mode because they require direct TUI access:

- `custom()` returns `undefined`
- `setWorkingMessage()`, `setWorkingIndicator()`, `setFooter()`, `setHeader()`, `setEditorComponent()`, `setToolsExpanded()` are no-ops
- `getEditorText()` returns `""`
- `getToolsExpanded()` returns `false`
- `pasteToEditor()` delegates to `setEditorText()` (no paste/collapse handling)
- `getAllThemes()` returns `[]`
- `getTheme()` returns `undefined`
- `setTheme()` returns `{ success: false, error: "..." }`

Note: `ctx.mode` is `"rpc"` and `ctx.hasUI` is `true` in RPC mode because the dialog and fire-and-forget methods are functional via the extension UI sub-protocol. Use `ctx.mode === "tui"` to guard TUI-specific features like `custom()` that require a real terminal.


### Extension UI Requests (stdout)

<a href="#extension-ui-requests-stdout" class="heading-anchor" aria-label="Permalink: Extension UI Requests (stdout)" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#extension-ui-requests-stdout"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


All requests have `type: "extension_ui_request"`, a unique `id`, and a `method` field.


#### select

<a href="#select" class="heading-anchor" aria-label="Permalink: select" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#select"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Prompt the user to choose from a list. Dialog methods with a `timeout` field include the timeout in milliseconds; the agent auto-resolves with `undefined` if the client doesn't respond in time.

``` json
{
  "type": "extension_ui_request",
  "id": "uuid-1",
  "method": "select",
  "title": "Allow dangerous command?",
  "options": ["Allow", "Block"],
  "timeout": 10000
}
```

Expected response: `extension_ui_response` with `value` (the selected option string) or `cancelled: true`.


#### confirm

<a href="#confirm" class="heading-anchor" aria-label="Permalink: confirm" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#confirm"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Prompt the user for yes/no confirmation.

``` json
{
  "type": "extension_ui_request",
  "id": "uuid-2",
  "method": "confirm",
  "title": "Clear session?",
  "message": "All messages will be lost.",
  "timeout": 5000
}
```

Expected response: `extension_ui_response` with `confirmed: true/false` or `cancelled: true`.


#### input

<a href="#input" class="heading-anchor" aria-label="Permalink: input" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#input"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Prompt the user for free-form text.

``` json
{
  "type": "extension_ui_request",
  "id": "uuid-3",
  "method": "input",
  "title": "Enter a value",
  "placeholder": "type something..."
}
```

Expected response: `extension_ui_response` with `value` (the entered text) or `cancelled: true`.


#### editor

<a href="#editor" class="heading-anchor" aria-label="Permalink: editor" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#editor"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Open a multi-line text editor with optional prefilled content.

``` json
{
  "type": "extension_ui_request",
  "id": "uuid-4",
  "method": "editor",
  "title": "Edit some text",
  "prefill": "Line 1\nLine 2\nLine 3"
}
```

Expected response: `extension_ui_response` with `value` (the edited text) or `cancelled: true`.


#### notify

<a href="#notify" class="heading-anchor" aria-label="Permalink: notify" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#notify"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Display a notification. Fire-and-forget, no response expected.

``` json
{
  "type": "extension_ui_request",
  "id": "uuid-5",
  "method": "notify",
  "message": "Command blocked by user",
  "notifyType": "warning"
}
```

The `notifyType` field is `"info"`, `"warning"`, or `"error"`. Defaults to `"info"` if omitted.


#### setStatus

<a href="#setstatus" class="heading-anchor" aria-label="Permalink: setStatus" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#setstatus"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Set or clear a status entry in the footer/status bar. Fire-and-forget.

``` json
{
  "type": "extension_ui_request",
  "id": "uuid-6",
  "method": "setStatus",
  "statusKey": "my-ext",
  "statusText": "Turn 3 running..."
}
```

Send `statusText: undefined` (or omit it) to clear the status entry for that key.


#### setWidget

<a href="#setwidget" class="heading-anchor" aria-label="Permalink: setWidget" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#setwidget"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Set or clear a widget (block of text lines) displayed above or below the editor. Fire-and-forget.

``` json
{
  "type": "extension_ui_request",
  "id": "uuid-7",
  "method": "setWidget",
  "widgetKey": "my-ext",
  "widgetLines": ["--- My Widget ---", "Line 1", "Line 2"],
  "widgetPlacement": "aboveEditor"
}
```

Send `widgetLines: undefined` (or omit it) to clear the widget. The `widgetPlacement` field is `"aboveEditor"` (default) or `"belowEditor"`. Only string arrays are supported in RPC mode; component factories are ignored.


#### setTitle

<a href="#settitle" class="heading-anchor" aria-label="Permalink: setTitle" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#settitle"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Set the terminal window/tab title. Fire-and-forget.

``` json
{
  "type": "extension_ui_request",
  "id": "uuid-8",
  "method": "setTitle",
  "title": "pi - my project"
}
```


#### set_editor_text

<a href="#set_editor_text" class="heading-anchor" aria-label="Permalink: set_editor_text" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#set_editor_text"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Set the text in the input editor. Fire-and-forget.

``` json
{
  "type": "extension_ui_request",
  "id": "uuid-9",
  "method": "set_editor_text",
  "text": "prefilled text for the user"
}
```


### Extension UI Responses (stdin)

<a href="#extension-ui-responses-stdin" class="heading-anchor" aria-label="Permalink: Extension UI Responses (stdin)" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#extension-ui-responses-stdin"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Responses are sent for dialog methods only (`select`, `confirm`, `input`, `editor`). The `id` must match the request.


#### Value response (select, input, editor)

<a href="#value-response-select-input-editor" class="heading-anchor" aria-label="Permalink: Value response (select, input, editor)" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#value-response-select-input-editor"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` json
{"type": "extension_ui_response", "id": "uuid-1", "value": "Allow"}
```


#### Confirmation response (confirm)

<a href="#confirmation-response-confirm" class="heading-anchor" aria-label="Permalink: Confirmation response (confirm)" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#confirmation-response-confirm"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` json
{"type": "extension_ui_response", "id": "uuid-2", "confirmed": true}
```


#### Cancellation response (any dialog)

<a href="#cancellation-response-any-dialog" class="heading-anchor" aria-label="Permalink: Cancellation response (any dialog)" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#cancellation-response-any-dialog"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Dismiss any dialog method. The extension receives `undefined` (for select/input/editor) or `false` (for confirm).

``` json
{"type": "extension_ui_response", "id": "uuid-3", "cancelled": true}
```


## Error Handling

<a href="#error-handling" class="heading-anchor" aria-label="Permalink: Error Handling" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#error-handling"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Failed commands return a response with `success: false`:

``` json
{
  "type": "response",
  "command": "set_model",
  "success": false,
  "error": "Model not found: invalid/model"
}
```

Parse errors:

``` json
{
  "type": "response",
  "command": "parse",
  "success": false,
  "error": "Failed to parse command: Unexpected token..."
}
```


## Types

<a href="#types" class="heading-anchor" aria-label="Permalink: Types" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#types"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Source files:

- [`packages/ai/src/types.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/ai/src/types.ts) - `Model`, `UserMessage`, `AssistantMessage`, `ToolResultMessage`
- [`packages/agent/src/types.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/agent/src/types.ts) - `AgentMessage`, `AgentEvent`
- [`src/core/messages.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/src/core/messages.ts) - `BashExecutionMessage`
- [`src/modes/json-event.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/src/modes/json-event.ts) - `JsonAgentSessionEvent`
- [`src/modes/rpc/rpc-types.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/src/modes/rpc/rpc-types.ts) - RPC command/response types, extension UI request/response types


### Model

<a href="#model-1" class="heading-anchor" aria-label="Permalink: Model" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#model-1"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` json
{
  "id": "claude-sonnet-4-20250514",
  "name": "Claude Sonnet 4",
  "api": "anthropic-messages",
  "provider": "anthropic",
  "baseUrl": "https://api.anthropic.com",
  "reasoning": true,
  "input": ["text", "image"],
  "contextWindow": 200000,
  "maxTokens": 16384,
  "cost": {
    "input": 3.0,
    "output": 15.0,
    "cacheRead": 0.3,
    "cacheWrite": 3.75
  }
}
```


### UserMessage

<a href="#usermessage" class="heading-anchor" aria-label="Permalink: UserMessage" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#usermessage"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` json
{
  "role": "user",
  "content": "Hello!",
  "timestamp": 1733234567890,
  "attachments": []
}
```

The `content` field can be a string or an array of `TextContent`/`ImageContent` blocks.


### AssistantMessage

<a href="#assistantmessage" class="heading-anchor" aria-label="Permalink: AssistantMessage" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#assistantmessage"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` json
{
  "role": "assistant",
  "content": [
    {"type": "text", "text": "Hello! How can I help?"},
    {"type": "thinking", "thinking": "User is greeting me..."},
    {"type": "toolCall", "id": "call_123", "name": "bash", "arguments": {"command": "ls"}}
  ],
  "api": "anthropic-messages",
  "provider": "anthropic",
  "model": "claude-sonnet-4-20250514",
  "usage": {
    "input": 100,
    "output": 50,
    "cacheRead": 0,
    "cacheWrite": 0,
    "cost": {"input": 0.0003, "output": 0.00075, "cacheRead": 0, "cacheWrite": 0, "total": 0.00105}
  },
  "stopReason": "stop",
  "timestamp": 1733234567890
}
```

Stop reasons: `"stop"`, `"length"`, `"toolUse"`, `"error"`, `"aborted"`


### ToolResultMessage

<a href="#toolresultmessage" class="heading-anchor" aria-label="Permalink: ToolResultMessage" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#toolresultmessage"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` json
{
  "role": "toolResult",
  "toolCallId": "call_123",
  "toolName": "bash",
  "content": [{"type": "text", "text": "total 48\ndrwxr-xr-x ..."}],
  "usage": {
    "input": 100,
    "output": 50,
    "cacheRead": 0,
    "cacheWrite": 0,
    "totalTokens": 150,
    "cost": {"input": 0.0003, "output": 0.00075, "cacheRead": 0, "cacheWrite": 0, "total": 0.00105}
  },
  "isError": false,
  "timestamp": 1733234567890
}
```

`usage` is optional and reports nested LLM work performed by the tool. When present, it contributes to session token and cost totals.


### BashExecutionMessage

<a href="#bashexecutionmessage" class="heading-anchor" aria-label="Permalink: BashExecutionMessage" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#bashexecutionmessage"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Created by the `bash` RPC command (not by LLM tool calls):

``` json
{
  "role": "bashExecution",
  "command": "ls -la",
  "output": "total 48\ndrwxr-xr-x ...",
  "exitCode": 0,
  "cancelled": false,
  "truncated": false,
  "fullOutputPath": null,
  "timestamp": 1733234567890
}
```


### Attachment

<a href="#attachment" class="heading-anchor" aria-label="Permalink: Attachment" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#attachment"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` json
{
  "id": "img1",
  "type": "image",
  "fileName": "photo.jpg",
  "mimeType": "image/jpeg",
  "size": 102400,
  "content": "base64-encoded-data...",
  "extractedText": null,
  "preview": null
}
```


## Example: Basic Client (Python)

<a href="#example-basic-client-python" class="heading-anchor" aria-label="Permalink: Example: Basic Client (Python)" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#example-basic-client-python"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` python
import subprocess
import json

proc = subprocess.Popen(
    ["pi", "--mode", "rpc", "--no-session"],
    stdin=subprocess.PIPE,
    stdout=subprocess.PIPE,
    text=True
)

def send(cmd):
    proc.stdin.write(json.dumps(cmd) + "\n")
    proc.stdin.flush()

def read_events():
    for line in proc.stdout:
        yield json.loads(line)

# Send prompt
send({"type": "prompt", "message": "Hello!"})

# Process events
for event in read_events():
    if event.get("type") == "message_update":
        delta = event.get("assistantMessageEvent", {})
        if delta.get("type") == "text_delta":
            print(delta["delta"], end="", flush=True)

    if event.get("type") == "agent_end":
        print()
        break
```


## Example: Interactive Client (Node.js)

<a href="#example-interactive-client-nodejs" class="heading-anchor" aria-label="Permalink: Example: Interactive Client (Node.js)" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#example-interactive-client-nodejs"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


See [`test/rpc-example.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/test/rpc-example.ts) for a complete interactive example, or [`src/modes/rpc/rpc-client.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/src/modes/rpc/rpc-client.ts) for a typed client implementation.

For a complete example of handling the extension UI protocol, see [`examples/rpc-extension-ui.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/rpc-extension-ui.ts) which pairs with the [`examples/extensions/rpc-demo.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/extensions/rpc-demo.ts) extension.

``` javascript
const { spawn } = require("child_process");
const { StringDecoder } = require("string_decoder");

const agent = spawn("pi", ["--mode", "rpc", "--no-session"]);

function attachJsonlReader(stream, onLine) {
    const decoder = new StringDecoder("utf8");
    let buffer = "";

    stream.on("data", (chunk) => {
        buffer += typeof chunk === "string" ? chunk : decoder.write(chunk);

        while (true) {
            const newlineIndex = buffer.indexOf("\n");
            if (newlineIndex === -1) break;

            let line = buffer.slice(0, newlineIndex);
            buffer = buffer.slice(newlineIndex + 1);
            if (line.endsWith("\r")) line = line.slice(0, -1);
            onLine(line);
        }
    });

    stream.on("end", () => {
        buffer += decoder.end();
        if (buffer.length > 0) {
            onLine(buffer.endsWith("\r") ? buffer.slice(0, -1) : buffer);
        }
    });
}

attachJsonlReader(agent.stdout, (line) => {
    const event = JSON.parse(line);

    if (event.type === "message_update") {
        const { assistantMessageEvent } = event;
        if (assistantMessageEvent.type === "text_delta") {
            process.stdout.write(assistantMessageEvent.delta);
        }
    }
});

// Send prompt
agent.stdin.write(JSON.stringify({ type: "prompt", message: "Hello" }) + "\n");

// Abort on Ctrl+C
process.on("SIGINT", () => {
    agent.stdin.write(JSON.stringify({ type: "abort" }) + "\n");
});
```


