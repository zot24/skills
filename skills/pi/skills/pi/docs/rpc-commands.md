> Source: https://pi.dev/docs/latest/rpc-commands



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# RPC Commands


This reference lists commands accepted on stdin in [RPC mode](/docs/latest/rpc). Each command and response is one JSON object. Shared message values use the [message types](/docs/latest/message-types).


## Prompting

<a href="#prompting" class="heading-anchor" aria-label="Permalink: Prompting" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#prompting"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


### prompt

<a href="#prompt" class="heading-anchor" aria-label="Permalink: prompt" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#prompt"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


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


### steer

<a href="#steer" class="heading-anchor" aria-label="Permalink: steer" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#steer"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


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


### follow_up

<a href="#follow_up" class="heading-anchor" aria-label="Permalink: follow_up" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#follow_up"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


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


### abort

<a href="#abort" class="heading-anchor" aria-label="Permalink: abort" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#abort"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Abort the current operation and wait for the session to become idle before responding.

``` json
{"type": "abort"}
```

Response:

``` json
{"type": "response", "command": "abort", "success": true}
```


### clear_queue

<a href="#clear_queue" class="heading-anchor" aria-label="Permalink: clear_queue" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#clear_queue"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


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


### new_session

<a href="#new_session" class="heading-anchor" aria-label="Permalink: new_session" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#new_session"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Start a fresh session. Can be canceled by a `session_before_switch` extension event handler.

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

If an extension canceled:

``` json
{"type": "response", "command": "new_session", "success": true, "data": {"cancelled": true}}
```


## State

<a href="#state" class="heading-anchor" aria-label="Permalink: State" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#state"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


### get_state

<a href="#get_state" class="heading-anchor" aria-label="Permalink: get_state" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#get_state"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


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

The `model` field is a full [Model](#model-object) object, or omitted when no model is selected. The `sessionName` field is the display name set via `set_session_name`, or omitted if not set.


### get_messages

<a href="#get_messages" class="heading-anchor" aria-label="Permalink: get_messages" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#get_messages"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


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

Messages are `AgentMessage` objects (see [Message Types](/docs/latest/message-types)).


## Model

<a href="#model" class="heading-anchor" aria-label="Permalink: Model" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#model"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


### set_model

<a href="#set_model" class="heading-anchor" aria-label="Permalink: set_model" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#set_model"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Switch to a specific model.

``` json
{"type": "set_model", "provider": "anthropic", "modelId": "claude-sonnet-4-20250514"}
```

Response contains the full [Model](#model-object) object:

``` json
{
  "type": "response",
  "command": "set_model",
  "success": true,
  "data": {...}
}
```


### cycle_model

<a href="#cycle_model" class="heading-anchor" aria-label="Permalink: cycle_model" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#cycle_model"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


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

The `model` field is a full [Model](#model-object) object.


### get_available_models

<a href="#get_available_models" class="heading-anchor" aria-label="Permalink: get_available_models" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#get_available_models"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


List all configured models.

``` json
{"type": "get_available_models"}
```

Response contains an array of full [Model](#model-object) objects:

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


## Thinking

<a href="#thinking" class="heading-anchor" aria-label="Permalink: Thinking" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#thinking"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


### set_thinking_level

<a href="#set_thinking_level" class="heading-anchor" aria-label="Permalink: set_thinking_level" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#set_thinking_level"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


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


### cycle_thinking_level

<a href="#cycle_thinking_level" class="heading-anchor" aria-label="Permalink: cycle_thinking_level" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#cycle_thinking_level"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


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


### get_available_thinking_levels

<a href="#get_available_thinking_levels" class="heading-anchor" aria-label="Permalink: get_available_thinking_levels" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#get_available_thinking_levels"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


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


## Queue modes

<a href="#queue-modes" class="heading-anchor" aria-label="Permalink: Queue modes" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#queue-modes"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


### set_steering_mode

<a href="#set_steering_mode" class="heading-anchor" aria-label="Permalink: set_steering_mode" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#set_steering_mode"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


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


### set_follow_up_mode

<a href="#set_follow_up_mode" class="heading-anchor" aria-label="Permalink: set_follow_up_mode" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#set_follow_up_mode"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


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


## Compaction

<a href="#compaction" class="heading-anchor" aria-label="Permalink: Compaction" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#compaction"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


### compact

<a href="#compact" class="heading-anchor" aria-label="Permalink: compact" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#compact"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


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


### set_auto_compaction

<a href="#set_auto_compaction" class="heading-anchor" aria-label="Permalink: set_auto_compaction" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#set_auto_compaction"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Enable or disable automatic compaction when context is nearly full.

``` json
{"type": "set_auto_compaction", "enabled": true}
```

Response:

``` json
{"type": "response", "command": "set_auto_compaction", "success": true}
```


## Retry

<a href="#retry" class="heading-anchor" aria-label="Permalink: Retry" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#retry"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


### set_auto_retry

<a href="#set_auto_retry" class="heading-anchor" aria-label="Permalink: set_auto_retry" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#set_auto_retry"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Enable or disable automatic retry on transient errors (overloaded, rate limit, 5xx).

``` json
{"type": "set_auto_retry", "enabled": true}
```

Response:

``` json
{"type": "response", "command": "set_auto_retry", "success": true}
```


### abort_retry

<a href="#abort_retry" class="heading-anchor" aria-label="Permalink: abort_retry" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#abort_retry"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Abort an in-progress retry (cancel the delay and stop retrying).

``` json
{"type": "abort_retry"}
```

Response:

``` json
{"type": "response", "command": "abort_retry", "success": true}
```


## Bash

<a href="#bash" class="heading-anchor" aria-label="Permalink: Bash" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#bash"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


### bash

<a href="#bash-1" class="heading-anchor" aria-label="Permalink: bash" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#bash-1"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Execute a shell command and add output to conversation context. Output streams as `bash_execution_update` events while the command runs; the response contains the final result.

``` json
{"id": "req-1", "type": "bash", "command": "ls -la"}
```

Set `excludeFromContext` to `true` when the command output should be stored in the session but omitted from the model context on the next prompt.

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

When the next `prompt` command is sent, Pi transforms context messages before sending them to the model. Unless `excludeFromContext` is true, the `BashExecutionMessage` becomes a `UserMessage` with this format:

    Ran `ls -la`
    ```
    total 48
    drwxr-xr-x ...
    ```

This means:

1.  Included bash output reaches the model on the **next prompt**, not immediately.
2.  Multiple bash commands can run before a prompt; Pi includes each output that does not set `excludeFromContext`.


### abort_bash

<a href="#abort_bash" class="heading-anchor" aria-label="Permalink: abort_bash" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#abort_bash"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Abort a running bash command.

``` json
{"type": "abort_bash"}
```

Response:

``` json
{"type": "response", "command": "abort_bash", "success": true}
```


## Session

<a href="#session" class="heading-anchor" aria-label="Permalink: Session" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#session"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


### get_session_stats

<a href="#get_session_stats" class="heading-anchor" aria-label="Permalink: get_session_stats" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#get_session_stats"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


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


### export_html

<a href="#export_html" class="heading-anchor" aria-label="Permalink: export_html" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#export_html"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


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


### switch_session

<a href="#switch_session" class="heading-anchor" aria-label="Permalink: switch_session" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#switch_session"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Load a different session file. Can be canceled by a `session_before_switch` extension event handler.

``` json
{"type": "switch_session", "sessionPath": "/path/to/session.jsonl"}
```

Response:

``` json
{"type": "response", "command": "switch_session", "success": true, "data": {"cancelled": false}}
```

If an extension canceled the switch:

``` json
{"type": "response", "command": "switch_session", "success": true, "data": {"cancelled": true}}
```


### fork

<a href="#fork" class="heading-anchor" aria-label="Permalink: fork" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#fork"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Create a new fork from a previous user message on the active branch. Can be canceled by a `session_before_fork` extension event handler. Returns the text of the message being forked from.

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

If an extension canceled the fork:

``` json
{
  "type": "response",
  "command": "fork",
  "success": true,
  "data": {"cancelled": true}
}
```


### clone

<a href="#clone" class="heading-anchor" aria-label="Permalink: clone" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#clone"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Duplicate the current active branch into a new session at the current position. Can be canceled by a `session_before_fork` extension event handler.

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

If an extension canceled the clone:

``` json
{
  "type": "response",
  "command": "clone",
  "success": true,
  "data": {"cancelled": true}
}
```


### get_fork_messages

<a href="#get_fork_messages" class="heading-anchor" aria-label="Permalink: get_fork_messages" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#get_fork_messages"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


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


### get_entries

<a href="#get_entries" class="heading-anchor" aria-label="Permalink: get_entries" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#get_entries"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


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


### get_tree

<a href="#get_tree" class="heading-anchor" aria-label="Permalink: get_tree" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#get_tree"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Get the session as a tree of entries. Each node is `{entry, children, label?, labelTimestamp?}`. The result is an array because navigation APIs can create multiple roots; orphaned entries with broken parent chains also appear as roots.

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


### get_last_assistant_text

<a href="#get_last_assistant_text" class="heading-anchor" aria-label="Permalink: get_last_assistant_text" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#get_last_assistant_text"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


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

The `text` value is `null` if no assistant text exists.


### set_session_name

<a href="#set_session_name" class="heading-anchor" aria-label="Permalink: set_session_name" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#set_session_name"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


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


## Discoverable commands

<a href="#discoverable-commands" class="heading-anchor" aria-label="Permalink: Discoverable commands" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#discoverable-commands"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


### get_commands

<a href="#get_commands" class="heading-anchor" aria-label="Permalink: get_commands" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#get_commands"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Get available commands (extension commands, prompt templates, and skills). Run one through the `prompt` command by prefixing its name with `/`.

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
      {
        "name": "fix-tests",
        "description": "Fix failing tests",
        "source": "prompt",
        "sourceInfo": {
          "path": "/home/user/myproject/.pi/agent/prompts/fix-tests.md",
          "source": "local",
          "scope": "project",
          "origin": "top-level"
        }
      }
    ]
  }
}
```

Each command has:

- `name`: Command name (use `/name`)
- `description`: Human-readable description (optional for extension commands)
- `source`: What kind of command:
  - `"extension"`: Registered via `pi.registerCommand()` in an extension
  - `"prompt"`: Loaded from a prompt template `.md` file
  - `"skill"`: Loaded from a skill directory (name is prefixed with `skill:`)
- `sourceInfo`: Metadata for the resource that registered the command:
  - `path`: Absolute path to the resource
  - `source`: How Pi discovered it, such as `"local"`, `"auto"`, or `"cli"`
  - `scope`: `"user"`, `"project"`, or `"temporary"`
  - `origin`: `"top-level"` for a directly loaded resource or `"package"` for a package resource
  - `baseDir`: Package base directory, when applicable

**Note**: Built-in TUI commands (`/settings`, `/hotkeys`, etc.) are not included. They are handled only in interactive mode and would not execute if sent via `prompt`.


## Model object

<a href="#model-object" class="heading-anchor" aria-label="Permalink: Model object" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc-commands#model-object"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Model commands return the complete configured model definition. Costs are in US dollars per million tokens.

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

For model configuration, see [Configure a compatible endpoint](/docs/latest/models#configure-a-compatible-endpoint). For TypeScript, use the exported `Model` type from `@earendil-works/pi-ai`.


