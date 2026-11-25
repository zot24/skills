> Source: https://pi.dev/docs/latest/rpc-commands



# RPC Commands


This reference lists commands accepted on stdin in <a href="/latest/rpc" class="link-module_root__svb26">RPC mode</a>. Each command and response is one JSON object. Shared message values use the <a href="/latest/message-types" class="link-module_root__svb26">message types</a>.


## Prompting


### prompt


Send a user prompt to the agent. The command response is emitted after the prompt is accepted, queued, or handled. Events continue streaming asynchronously after acceptance.

``` code-snippet-module_root__tK5do
{"id": "req-1", "type": "prompt", "message": "Hello, world!"}
```

With images:

``` code-snippet-module_root__tK5do
{"type": "prompt", "message": "What's in this image?", "images": [{"type": "image", "data": "base64-encoded-data", "mimeType": "image/png"}]}
```

**During streaming**: If the agent is already streaming, you must specify `streamingBehavior` to queue the message:

``` code-snippet-module_root__tK5do
{"type": "prompt", "message": "New instruction", "streamingBehavior": "steer"}
```

- `"steer"`: Queue the message while the agent is running. It is delivered after the current assistant turn finishes executing its tool calls, before the next LLM call.
- `"followUp"`: Wait until the agent finishes. Message is delivered only when agent stops.

If the agent is streaming and no `streamingBehavior` is specified, the command returns an error.

**Extension commands**: If the message is an extension command (e.g., `/mycommand`), it executes immediately even during streaming. Extension commands manage their own LLM interaction via `pi.sendMessage()`.

**Input expansion**: Skill commands (`/skill:name`) and prompt templates (`/template`) are expanded before sending/queueing.

Response:

``` code-snippet-module_root__tK5do
{"id": "req-1", "type": "response", "command": "prompt", "success": true, "data": {"disposition": "started"}}
```

`data.disposition` is `"handled"` if an extension command or input handler consumed the prompt, `"queued"` if Pi queued it during a run, or `"started"` if Pi accepted it to start a run. This describes the submitted prompt, not independent work started by an extension or a guarantee of completion.

`success: true` means the prompt was accepted, queued, or handled immediately. `success: false` means the prompt was rejected before acceptance. Failures after acceptance are reported through the normal event and message stream, not as a second `response` for the same request id.

The `images` field is optional. Each image uses `ImageContent` format: `{"type": "image", "data": "base64-encoded-data", "mimeType": "image/png"}`.


### steer


Queue a steering message while the agent is running. It is delivered after the current assistant turn finishes executing its tool calls, before the next LLM call. Skill commands and prompt templates are expanded. Extension commands are not allowed (use `prompt` instead).

``` code-snippet-module_root__tK5do
{"type": "steer", "message": "Stop and do this instead"}
```

With images:

``` code-snippet-module_root__tK5do
{"type": "steer", "message": "Look at this instead", "images": [{"type": "image", "data": "base64-encoded-data", "mimeType": "image/png"}]}
```

The `images` field is optional. Each image uses `ImageContent` format (same as `prompt`).

Response:

``` code-snippet-module_root__tK5do
{"type": "response", "command": "steer", "success": true, "data": {"disposition": "queued"}}
```

`data.disposition` is `"handled"` if an input handler consumed this steer, or `"queued"` if Pi queued it (including after a handler transformed it). It does not guarantee this message remains queued.

See <a href="#set_steering_mode" class="link-module_root__svb26">set_steering_mode</a> for controlling how steering messages are processed.


### follow_up


Queue a follow-up message to be processed after the agent finishes. Delivered only when agent has no more tool calls or steering messages. Skill commands and prompt templates are expanded. Extension commands are not allowed (use `prompt` instead).

``` code-snippet-module_root__tK5do
{"type": "follow_up", "message": "After you're done, also do this"}
```

With images:

``` code-snippet-module_root__tK5do
{"type": "follow_up", "message": "Also check this image", "images": [{"type": "image", "data": "base64-encoded-data", "mimeType": "image/png"}]}
```

The `images` field is optional. Each image uses `ImageContent` format (same as `prompt`).

Response:

``` code-snippet-module_root__tK5do
{"type": "response", "command": "follow_up", "success": true, "data": {"disposition": "queued"}}
```

`data.disposition` has the same `"handled"` or `"queued"` meaning as for `steer`, applied to this follow-up.

See <a href="#set_follow_up_mode" class="link-module_root__svb26">set_follow_up_mode</a> for controlling how follow-up messages are processed.


### abort


Abort the current operation and wait for the session to become idle before responding.

``` code-snippet-module_root__tK5do
{"type": "abort"}
```

Response:

``` code-snippet-module_root__tK5do
{"type": "response", "command": "abort", "success": true}
```


### clear_queue


Remove queued steering and follow-up messages and return their text.

``` code-snippet-module_root__tK5do
{"type": "clear_queue"}
```

Response:

``` code-snippet-module_root__tK5do
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


Start a fresh session. Can be canceled by a `session_before_switch` extension event handler.

``` code-snippet-module_root__tK5do
{"type": "new_session"}
```

With optional parent session tracking:

``` code-snippet-module_root__tK5do
{"type": "new_session", "parentSession": "/path/to/parent-session.jsonl"}
```

Response:

``` code-snippet-module_root__tK5do
{"type": "response", "command": "new_session", "success": true, "data": {"cancelled": false}}
```

If an extension canceled:

``` code-snippet-module_root__tK5do
{"type": "response", "command": "new_session", "success": true, "data": {"cancelled": true}}
```


## State


### get_state


Get current session state.

``` code-snippet-module_root__tK5do
{"type": "get_state"}
```

Response:

``` code-snippet-module_root__tK5do
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

The `model` field is a full <a href="#model-object" class="link-module_root__svb26">Model</a> object, or omitted when no model is selected. The `sessionName` field is the display name set via `set_session_name`, or omitted if not set.


### get_messages


Get all messages in the conversation.

``` code-snippet-module_root__tK5do
{"type": "get_messages"}
```

Response:

``` code-snippet-module_root__tK5do
{
  "type": "response",
  "command": "get_messages",
  "success": true,
  "data": {"messages": [...]}
}
```

Messages are `AgentMessage` objects (see <a href="/latest/message-types" class="link-module_root__svb26">Message Types</a>).


## Model


### set_model


Switch to a specific model.

``` code-snippet-module_root__tK5do
{"type": "set_model", "provider": "anthropic", "modelId": "claude-sonnet-4-20250514"}
```

Response contains the full <a href="#model-object" class="link-module_root__svb26">Model</a> object:

``` code-snippet-module_root__tK5do
{
  "type": "response",
  "command": "set_model",
  "success": true,
  "data": {...}
}
```


### cycle_model


Cycle to the next available model. Returns `null` data if only one model available.

``` code-snippet-module_root__tK5do
{"type": "cycle_model"}
```

Response:

``` code-snippet-module_root__tK5do
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

The `model` field is a full <a href="#model-object" class="link-module_root__svb26">Model</a> object.


### get_available_models


List all configured models.

``` code-snippet-module_root__tK5do
{"type": "get_available_models"}
```

Response contains an array of full <a href="#model-object" class="link-module_root__svb26">Model</a> objects:

``` code-snippet-module_root__tK5do
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


### set_thinking_level


Set the reasoning/thinking level for models that support it.

``` code-snippet-module_root__tK5do
{"type": "set_thinking_level", "level": "high"}
```

Levels: `"off"`, `"minimal"`, `"low"`, `"medium"`, `"high"`, `"xhigh"`, `"max"`

`"xhigh"` and `"max"` are exposed only when supported by the selected model. Some models, including GPT-5.6, expose both.

Response:

``` code-snippet-module_root__tK5do
{"type": "response", "command": "set_thinking_level", "success": true}
```


### cycle_thinking_level


Cycle through available thinking levels. Returns `null` data if model doesn't support thinking.

``` code-snippet-module_root__tK5do
{"type": "cycle_thinking_level"}
```

Response:

``` code-snippet-module_root__tK5do
{
  "type": "response",
  "command": "cycle_thinking_level",
  "success": true,
  "data": {"level": "high"}
}
```


### get_available_thinking_levels


List the thinking levels supported by the current model. Returns `["off"]` for a model without reasoning support.

``` code-snippet-module_root__tK5do
{"type": "get_available_thinking_levels"}
```

Response:

``` code-snippet-module_root__tK5do
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


### set_steering_mode


Control how steering messages (from `steer`) are delivered.

``` code-snippet-module_root__tK5do
{"type": "set_steering_mode", "mode": "one-at-a-time"}
```

Modes:

- `"all"`: Deliver all steering messages after the current assistant turn finishes executing its tool calls
- `"one-at-a-time"`: Deliver one steering message per completed assistant turn (default)

Response:

``` code-snippet-module_root__tK5do
{"type": "response", "command": "set_steering_mode", "success": true}
```


### set_follow_up_mode


Control how follow-up messages (from `follow_up`) are delivered.

``` code-snippet-module_root__tK5do
{"type": "set_follow_up_mode", "mode": "one-at-a-time"}
```

Modes:

- `"all"`: Deliver all follow-up messages when agent finishes
- `"one-at-a-time"`: Deliver one follow-up message per agent completion (default)

Response:

``` code-snippet-module_root__tK5do
{"type": "response", "command": "set_follow_up_mode", "success": true}
```


## Compaction


### compact


Manually compact conversation context to reduce token usage.

``` code-snippet-module_root__tK5do
{"type": "compact"}
```

With custom instructions:

``` code-snippet-module_root__tK5do
{"type": "compact", "customInstructions": "Focus on code changes"}
```

Response:

``` code-snippet-module_root__tK5do
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


Enable or disable automatic compaction when context is nearly full.

``` code-snippet-module_root__tK5do
{"type": "set_auto_compaction", "enabled": true}
```

Response:

``` code-snippet-module_root__tK5do
{"type": "response", "command": "set_auto_compaction", "success": true}
```


## Retry


### set_auto_retry


Enable or disable automatic retry on transient errors (overloaded, rate limit, 5xx).

``` code-snippet-module_root__tK5do
{"type": "set_auto_retry", "enabled": true}
```

Response:

``` code-snippet-module_root__tK5do
{"type": "response", "command": "set_auto_retry", "success": true}
```


### abort_retry


Abort an in-progress retry (cancel the delay and stop retrying).

``` code-snippet-module_root__tK5do
{"type": "abort_retry"}
```

Response:

``` code-snippet-module_root__tK5do
{"type": "response", "command": "abort_retry", "success": true}
```


## Bash


### bash


Execute a shell command and add output to conversation context. Output streams as `bash_execution_update` events while the command runs; the response contains the final result.

``` code-snippet-module_root__tK5do
{"id": "req-1", "type": "bash", "command": "ls -la"}
```

Set `excludeFromContext` to `true` when the command output should be stored in the session but omitted from the model context on the next prompt.

Include an `id` to associate streamed `bash_execution_update` events with this command.

Response:

``` code-snippet-module_root__tK5do
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

If output was truncated, includes `fullOutputPath`, or `fullOutputError` with the reason when the full output could not be saved (for example a full temp directory):

``` code-snippet-module_root__tK5do
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

```` code-snippet-module_root__tK5do
Ran `ls -la`
```
total 48
drwxr-xr-x ...
```
````

This means:

1.  Included bash output reaches the model on the **next prompt**, not immediately.
2.  Multiple bash commands can run before a prompt; Pi includes each output that does not set `excludeFromContext`.


### abort_bash


Abort a running bash command.

``` code-snippet-module_root__tK5do
{"type": "abort_bash"}
```

Response:

``` code-snippet-module_root__tK5do
{"type": "response", "command": "abort_bash", "success": true}
```


## Session


### get_session_stats


Get token usage, cost statistics, and current context window usage.

``` code-snippet-module_root__tK5do
{"type": "get_session_stats"}
```

Response:

``` code-snippet-module_root__tK5do
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


Export session to an HTML file.

``` code-snippet-module_root__tK5do
{"type": "export_html"}
```

With custom path:

``` code-snippet-module_root__tK5do
{"type": "export_html", "outputPath": "/tmp/session.html"}
```

Response:

``` code-snippet-module_root__tK5do
{
  "type": "response",
  "command": "export_html",
  "success": true,
  "data": {"path": "/tmp/session.html"}
}
```


### switch_session


Load a different session file. Can be canceled by a `session_before_switch` extension event handler.

``` code-snippet-module_root__tK5do
{"type": "switch_session", "sessionPath": "/path/to/session.jsonl"}
```

Response:

``` code-snippet-module_root__tK5do
{"type": "response", "command": "switch_session", "success": true, "data": {"cancelled": false}}
```

If an extension canceled the switch:

``` code-snippet-module_root__tK5do
{"type": "response", "command": "switch_session", "success": true, "data": {"cancelled": true}}
```


### fork


Create a new fork from a previous user message on the active branch. Can be canceled by a `session_before_fork` extension event handler. Returns the text of the message being forked from.

``` code-snippet-module_root__tK5do
{"type": "fork", "entryId": "abc123"}
```

Response:

``` code-snippet-module_root__tK5do
{
  "type": "response",
  "command": "fork",
  "success": true,
  "data": {"text": "The original prompt text...", "cancelled": false}
}
```

If an extension canceled the fork:

``` code-snippet-module_root__tK5do
{
  "type": "response",
  "command": "fork",
  "success": true,
  "data": {"cancelled": true}
}
```


### clone


Duplicate the current active branch into a new session at the current position. Can be canceled by a `session_before_fork` extension event handler.

``` code-snippet-module_root__tK5do
{"type": "clone"}
```

Response:

``` code-snippet-module_root__tK5do
{
  "type": "response",
  "command": "clone",
  "success": true,
  "data": {"cancelled": false}
}
```

If an extension canceled the clone:

``` code-snippet-module_root__tK5do
{
  "type": "response",
  "command": "clone",
  "success": true,
  "data": {"cancelled": true}
}
```


### get_fork_messages


Get user messages available for forking.

``` code-snippet-module_root__tK5do
{"type": "get_fork_messages"}
```

Response:

``` code-snippet-module_root__tK5do
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


Get all session entries in append order (excluding the session header). The session is an append-only tree of entries with stable ids, so an entry id works as a durable cursor: pass the last entry id you have seen as `since` to get only entries strictly after it, even across client restarts. Unlike `get_messages`, this includes pre-compaction history and abandoned branches.

``` code-snippet-module_root__tK5do
{"type": "get_entries"}
```

With a cursor:

``` code-snippet-module_root__tK5do
{"type": "get_entries", "since": "abc123"}
```

Response:

``` code-snippet-module_root__tK5do
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


Get the session as a tree of entries. Each node is `{entry, children, label?, labelTimestamp?}`. The result is an array because navigation APIs can create multiple roots; orphaned entries with broken parent chains also appear as roots.

``` code-snippet-module_root__tK5do
{"type": "get_tree"}
```

Response:

``` code-snippet-module_root__tK5do
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


Get the text content of the last assistant message. Messages without text from an aborted or failed turn, or that only call tools, are skipped.

``` code-snippet-module_root__tK5do
{"type": "get_last_assistant_text"}
```

Response:

``` code-snippet-module_root__tK5do
{
  "type": "response",
  "command": "get_last_assistant_text",
  "success": true,
  "data": {"text": "The assistant's response..."}
}
```

The `text` value is `null` if no assistant text exists.


### set_session_name


Set a display name for the current session. The name appears in session listings and helps identify sessions.

``` code-snippet-module_root__tK5do
{"type": "set_session_name", "name": "my-feature-work"}
```

Response:

``` code-snippet-module_root__tK5do
{
  "type": "response",
  "command": "set_session_name",
  "success": true
}
```

The current session name is available via `get_state` in the `sessionName` field. To set the initial name when starting RPC mode, pass `--name <name>` or `-n <name>` to the `pi --mode rpc` process.


## Discoverable commands


### get_commands


Get available commands (extension commands, prompt templates, and skills). Run one through the `prompt` command by prefixing its name with `/`.

``` code-snippet-module_root__tK5do
{"type": "get_commands"}
```

Response:

``` code-snippet-module_root__tK5do
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


Model commands return the complete configured model definition. Costs are in US dollars per million tokens.

``` code-snippet-module_root__tK5do
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

For model configuration, see <a href="/latest/models#configure-a-compatible-endpoint" class="link-module_root__svb26">Configure a compatible endpoint</a>. For TypeScript, use the exported `Model` type from `@earendil-works/pi-ai`.


