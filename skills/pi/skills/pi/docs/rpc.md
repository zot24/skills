> Source: https://pi.dev/docs/latest/rpc



# RPC Mode


RPC mode runs Pi as a long-lived subprocess controlled through JSON records on stdin and stdout. Use it for language-independent integrations, process isolation, IDEs, and custom user interfaces.

For an in-process Node.js or Bun integration, prefer the <a href="/latest/sdk" class="link-module_root__svb26">SDK</a>. For a subprocess-based TypeScript integration, prefer the exported `RpcClient`, which starts Pi, correlates responses, exposes typed command methods, and delivers events to listeners.


| Interface | Process boundary | Control model | Best fit |
|----|----|----|----|
| <a href="/latest/sdk" class="link-module_root__svb26">SDK</a> | In process | Direct TypeScript methods and events | Node.js or Bun hosts that want complete API access |
| RPC | Child process | JSONL commands, responses, and events | Other languages, isolated processes, IDEs, or custom clients |


## Start RPC mode


``` code-snippet-module_root__tK5do
pi --mode rpc --no-session
```

Normal CLI options still select the working folder, model, tools, resources, and session behavior. Common choices include `--provider`, `--model`, `--name`, `--no-session`, and `--session-dir`. See <a href="/latest/cli" class="link-module_root__svb26">Command Line</a> for the complete, version-specific interface; `pi --help` is authoritative for the installed version.

RPC mode rejects `@file` prompt arguments. Send prompts through the <a href="/latest/rpc-commands#prompt" class="link-module_root__svb26"><code class="inline-code-module_root__fGvLx" data-variant="soft">prompt</code></a> command instead.


## Protocol records


The protocol has four record families:


| Direction | Record | Purpose |
|----|----|----|
| stdin | Command | Ask Pi to prompt, inspect state, change configuration, or manage the session |
| stdout | `response` | Report whether one command succeeded and return any command data |
| stdout | Session event | Stream run, message, tool, queue, compaction, and retry activity |
| Both | Extension UI record | Forward supported extension interactions between Pi and the client |


See <a href="/latest/rpc-commands" class="link-module_root__svb26">RPC Commands</a>, <a href="/latest/json" class="link-module_root__svb26">JSON Event Stream</a>, and <a href="/latest/rpc-extension-ui" class="link-module_root__svb26">RPC Extension UI</a> for the canonical record definitions.


### Correlate commands and responses


Every command accepts an optional string `id`. A matching response repeats it:

``` code-snippet-module_root__tK5do
{"id":"req-1","type":"get_state"}
{"id":"req-1","type":"response","command":"get_state","success":true,"data":{"...":"..."}}
```

Use unique IDs whenever more than one command can be outstanding. Command handling is asynchronous, so clients should correlate by ID rather than response order.

Session events generally have no command ID because they describe session activity. `bash_execution_update` is the exception: when the originating <a href="/latest/rpc-commands#bash" class="link-module_root__svb26"><code class="inline-code-module_root__fGvLx" data-variant="soft">bash</code></a> command has an ID, its output events repeat that ID.

An `extension_ui_response` uses the ID supplied by its `extension_ui_request`. It does not produce a normal command response.


## Framing


RPC uses strict JSONL framing. Write one complete JSON object per record and terminate it with LF (`\n`). Read stdout as a byte or UTF-8 stream and split records only on LF. Strip an optional preceding carriage return to accept CRLF input.

Do not use a generic line reader that treats Unicode line or paragraph separators as record boundaries. In particular, Node.js `readline` also splits on `U+2028` and `U+2029`, which are valid inside JSON strings.

Read stdout continuously. Pi honors stdout backpressure, but a client that stops reading can stall the process. Honor stdin backpressure when writing commands. Stdout is reserved for protocol records; diagnostics and application logging go to stderr.


## Run lifecycle


A successful `prompt` response means the prompt was accepted, queued, or handled. It does not mean model work completed:

``` code-snippet-module_root__tK5do
{"id":"req-2","type":"prompt","message":"Review this repository"}
{"id":"req-2","type":"response","command":"prompt","success":true,"data":{"disposition":"started"}}
```

`data.disposition` reports what happened to the prompt. If it is `"handled"`, no run started for this prompt, so don't wait for `agent_settled`. See <a href="/latest/rpc-commands#prompt" class="link-module_root__svb26">RPC Commands</a> for all values.

Continue consuming <a href="/latest/json" class="link-module_root__svb26">events</a> after that response. `agent_end` marks the end of one low-level agent run, but retries, overflow recovery, compaction, steering, or follow-up work can still follow. Wait for `agent_settled` when the client needs to know Pi will not continue automatically.

Subscribe before sending a prompt to avoid missing a fast completion. `RpcClient.promptAndWait()` does this internally. If using separate `RpcClient` calls, install the event listener before `prompt()` and call `waitForIdle()` only while a run is active.


## Errors


A failed command returns one response with `success: false`:

``` code-snippet-module_root__tK5do
{"id":"req-3","type":"response","command":"set_model","success":false,"error":"Model not found: invalid/model"}
```

Malformed JSON produces a parse response without a request ID:

``` code-snippet-module_root__tK5do
{"type":"response","command":"parse","success":false,"error":"Failed to parse command: Unexpected token..."}
```

A success response only covers command handling. Provider failures and aborts after a prompt is accepted appear in the message and event stream.

Clients must also handle child-process startup failures, unexpected exits, stderr diagnostics, cancellation, and their own deadlines. Do not parse stderr as protocol data.


## Shutdown


Close the child's stdin to request an orderly shutdown. Pi disposes the active runtime and waits for pending work to finish before exiting, so give it time to exit before killing it. Clients should still handle process signals and unexpected exits.

SIGTERM and SIGHUP also start an orderly shutdown. Once a shutdown has started, from either stdin EOF or a signal, a stdin EOF or a single signal does not interrupt it; a second signal exits at once. Closing stdin and sending SIGTERM together is safe.

An extension can also request shutdown with `ctx.shutdown()`. If the session is idle and no command is being handled, Pi shuts down right away. Otherwise it shuts down once the current command finishes (for `prompt`, once the prompt settles) or the active run emits `agent_settled`. (A request made while an extension-started compaction is running waits for the next command or run to finish.)


## Minimal client


This Python example uses a binary pipe reader, which splits on LF without treating Unicode separators as protocol boundaries:

``` code-snippet-module_root__tK5do
import json
import subprocess

process = subprocess.Popen(
    ["pi", "--mode", "rpc", "--no-session"],
    stdin=subprocess.PIPE,
    stdout=subprocess.PIPE,
)

assert process.stdin is not None
assert process.stdout is not None

command = {"id": "prompt-1", "type": "prompt", "message": "Hello"}
process.stdin.write(json.dumps(command).encode("utf-8") + b"\n")
process.stdin.flush()

while line := process.stdout.readline():
    record = json.loads(line)
    if record.get("type") == "message_update":
        update = record["assistantMessageEvent"]
        if update["type"] == "text_delta":
            print(update["delta"], end="", flush=True)
    elif record.get("type") == "agent_settled":
        print()
        break

process.stdin.close()
process.wait()
```

For maintained TypeScript clients, use the checked <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/rpc-client.ts" class="link-module_root__svb26">RPC client example</a>. It requires a built Pi CLI because the repository example points to `dist/cli.js`.


## Reference


- <a href="/latest/rpc-commands" class="link-module_root__svb26">RPC Commands</a>: every stdin command and response
- <a href="/latest/json" class="link-module_root__svb26">JSON Event Stream</a>: shared stdout session events and streaming reconstruction
- <a href="/latest/rpc-extension-ui" class="link-module_root__svb26">RPC Extension UI</a>: dialogs, notifications, responses, and limitations
- <a href="/latest/message-types" class="link-module_root__svb26">Message Types</a>: messages and content blocks used by responses and events
- <a href="/latest/session-format" class="link-module_root__svb26">Session File Format</a>: entries returned by session commands
- <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/src/modes/rpc/rpc-types.ts" class="link-module_root__svb26"><code class="inline-code-module_root__fGvLx" data-variant="soft">rpc-types.ts</code></a>: exported TypeScript protocol definitions
- <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/src/modes/rpc/rpc-client.ts" class="link-module_root__svb26"><code class="inline-code-module_root__fGvLx" data-variant="soft">RpcClient</code></a>: subprocess client implementation


## Moved reference anchors


The detailed references formerly on this page now have dedicated pages. These anchors preserve existing links.


Command details moved to <a href="/latest/rpc-commands" class="link-module_root__svb26">RPC Commands</a>.


Event details moved to <a href="/latest/json" class="link-module_root__svb26">JSON Event Stream</a>.


Extension interaction details moved to <a href="/latest/rpc-extension-ui" class="link-module_root__svb26">RPC Extension UI</a>.


