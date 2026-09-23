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


RPC mode runs Pi as a long-lived subprocess controlled through JSON records on stdin and stdout. Use it for language-independent integrations, process isolation, IDEs, and custom user interfaces.

For an in-process Node.js or Bun integration, prefer the [SDK](/docs/latest/sdk). For a subprocess-based TypeScript integration, prefer the exported `RpcClient`, which starts Pi, correlates responses, exposes typed command methods, and delivers events to listeners.

| Interface               | Process boundary | Control model                         | Best fit                                                     |
|-------------------------|------------------|---------------------------------------|--------------------------------------------------------------|
| [SDK](/docs/latest/sdk) | In process       | Direct TypeScript methods and events  | Node.js or Bun hosts that want complete API access           |
| RPC                     | Child process    | JSONL commands, responses, and events | Other languages, isolated processes, IDEs, or custom clients |


## Start RPC mode

<a href="#start-rpc-mode" class="heading-anchor" aria-label="Permalink: Start RPC mode" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#start-rpc-mode"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` bash
pi --mode rpc --no-session
```

Normal CLI options still select the working folder, model, tools, resources, and session behavior. Common choices include `--provider`, `--model`, `--name`, `--no-session`, and `--session-dir`. See [Command Line](/docs/latest/cli) for the complete, version-specific interface; `pi --help` is authoritative for the installed version.

RPC mode rejects `@file` prompt arguments. Send prompts through the [`prompt`](/docs/latest/rpc-commands#prompt) command instead.


## Protocol records

<a href="#protocol-records" class="heading-anchor" aria-label="Permalink: Protocol records" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#protocol-records"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


The protocol has four record families:

| Direction | Record              | Purpose                                                                      |
|-----------|---------------------|------------------------------------------------------------------------------|
| stdin     | Command             | Ask Pi to prompt, inspect state, change configuration, or manage the session |
| stdout    | `response`          | Report whether one command succeeded and return any command data             |
| stdout    | Session event       | Stream run, message, tool, queue, compaction, and retry activity             |
| Both      | Extension UI record | Forward supported extension interactions between Pi and the client           |

See [RPC Commands](/docs/latest/rpc-commands), [JSON Event Stream](/docs/latest/json), and [RPC Extension UI](/docs/latest/rpc-extension-ui) for the canonical record definitions.


### Correlate commands and responses

<a href="#correlate-commands-and-responses" class="heading-anchor" aria-label="Permalink: Correlate commands and responses" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#correlate-commands-and-responses"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Every command accepts an optional string `id`. A matching response repeats it:

``` json
{"id":"req-1","type":"get_state"}
{"id":"req-1","type":"response","command":"get_state","success":true,"data":{"...":"..."}}
```

Use unique IDs whenever more than one command can be outstanding. Command handling is asynchronous, so clients should correlate by ID rather than response order.

Session events generally have no command ID because they describe session activity. `bash_execution_update` is the exception: when the originating [`bash`](/docs/latest/rpc-commands#bash) command has an ID, its output events repeat that ID.

An `extension_ui_response` uses the ID supplied by its `extension_ui_request`. It does not produce a normal command response.


## Framing

<a href="#framing" class="heading-anchor" aria-label="Permalink: Framing" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#framing"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


RPC uses strict JSONL framing. Write one complete JSON object per record and terminate it with LF (`\n`). Read stdout as a byte or UTF-8 stream and split records only on LF. Strip an optional preceding carriage return to accept CRLF input.

Do not use a generic line reader that treats Unicode line or paragraph separators as record boundaries. In particular, Node.js `readline` also splits on `U+2028` and `U+2029`, which are valid inside JSON strings.

Read stdout continuously. Pi honors stdout backpressure, but a client that stops reading can stall the process. Honor stdin backpressure when writing commands. Stdout is reserved for protocol records; diagnostics and application logging go to stderr.


## Run lifecycle

<a href="#run-lifecycle" class="heading-anchor" aria-label="Permalink: Run lifecycle" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#run-lifecycle"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


A successful `prompt` response means the prompt was accepted, queued, or handled. It does not mean model work completed:

``` json
{"id":"req-2","type":"prompt","message":"Review this repository"}
{"id":"req-2","type":"response","command":"prompt","success":true}
```

Continue consuming [events](/docs/latest/json) after that response. `agent_end` marks the end of one low-level agent run, but retries, overflow recovery, compaction, steering, or follow-up work can still follow. Wait for `agent_settled` when the client needs to know Pi will not continue automatically.

Subscribe before sending a prompt to avoid missing a fast completion. `RpcClient.promptAndWait()` does this internally. If using separate `RpcClient` calls, install the event listener before `prompt()` and call `waitForIdle()` only while a run is active.


## Errors

<a href="#errors" class="heading-anchor" aria-label="Permalink: Errors" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#errors"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


A failed command returns one response with `success: false`:

``` json
{"id":"req-3","type":"response","command":"set_model","success":false,"error":"Model not found: invalid/model"}
```

Malformed JSON produces a parse response without a request ID:

``` json
{"type":"response","command":"parse","success":false,"error":"Failed to parse command: Unexpected token..."}
```

A success response only covers command handling. Provider failures and aborts after a prompt is accepted appear in the message and event stream.

Clients must also handle child-process startup failures, unexpected exits, stderr diagnostics, cancellation, and their own deadlines. Do not parse stderr as protocol data.


## Shutdown

<a href="#shutdown" class="heading-anchor" aria-label="Permalink: Shutdown" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#shutdown"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Close the child's stdin to request an orderly shutdown. Pi disposes the active runtime before exiting. Clients should still handle process signals and unexpected exits.

An extension can also request shutdown through its extension context. Pi completes shutdown after the current command or after the active run emits `agent_settled`.


## Minimal client

<a href="#minimal-client" class="heading-anchor" aria-label="Permalink: Minimal client" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#minimal-client"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


This Python example uses a binary pipe reader, which splits on LF without treating Unicode separators as protocol boundaries:

``` python
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

For maintained TypeScript clients, use the checked [RPC client example](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/rpc-client.ts). It requires a built Pi CLI because the repository example points to `dist/cli.js`.


## Reference

<a href="#reference" class="heading-anchor" aria-label="Permalink: Reference" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#reference"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


- [RPC Commands](/docs/latest/rpc-commands): every stdin command and response
- [JSON Event Stream](/docs/latest/json): shared stdout session events and streaming reconstruction
- [RPC Extension UI](/docs/latest/rpc-extension-ui): dialogs, notifications, responses, and limitations
- [Message Types](/docs/latest/message-types): messages and content blocks used by responses and events
- [Session File Format](/docs/latest/session-format): entries returned by session commands
- [`rpc-types.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/src/modes/rpc/rpc-types.ts): exported TypeScript protocol definitions
- [`RpcClient`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/src/modes/rpc/rpc-client.ts): subprocess client implementation


## Moved reference anchors

<a href="#moved-reference-anchors" class="heading-anchor" aria-label="Permalink: Moved reference anchors" data-copy="" data-copy-text="https://pi.dev/docs/latest/rpc#moved-reference-anchors"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


The detailed references formerly on this page now have dedicated pages. These anchors preserve existing links.


Command details moved to [RPC Commands](/docs/latest/rpc-commands).


Event details moved to [JSON Event Stream](/docs/latest/json).


Extension interaction details moved to [RPC Extension UI](/docs/latest/rpc-extension-ui).


