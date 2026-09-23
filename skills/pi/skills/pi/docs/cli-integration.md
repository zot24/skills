> Source: https://pi.dev/docs/latest/cli-integration



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# CLI Integration


By default, running `pi` opens the interactive terminal interface. When input or output is piped or redirected, Pi uses print mode instead. You can also select print, JSON, or RPC mode explicitly for scripts and applications.

All four modes use the same agent, sessions, resources, and tools. The mode determines how input enters Pi, how output is exposed, and whether the process remains available for more commands.

The SDK is not a CLI mode. It embeds the agent directly in a Node.js or Bun process. See the [SDK](/docs/latest/sdk) when direct TypeScript access is preferable to a process boundary.


## Choose a mode

<a href="#choose-a-mode" class="heading-anchor" aria-label="Permalink: Choose a mode" data-copy="" data-copy-text="https://pi.dev/docs/latest/cli-integration#choose-a-mode"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Mode        | Interface                             | Lifetime             | Use it when                                    |
|-------------|---------------------------------------|----------------------|------------------------------------------------|
| Interactive | Terminal UI                           | Until the user exits | A person is working with Pi directly           |
| Print       | Final text on stdout                  | One invocation       | A script needs the final assistant response    |
| JSON        | JSONL events on stdout                | One invocation       | A process needs structured progress from a run |
| RPC         | JSONL commands, responses, and events | Long-lived           | A process needs bidirectional control          |

CLI options still select the working directory, model, tools, resources, and session persistence independently of the mode. See [Command Line](/docs/latest/cli) for the complete startup options.


## Print to stdout

<a href="#print-to-stdout" class="heading-anchor" aria-label="Permalink: Print to stdout" data-copy="" data-copy-text="https://pi.dev/docs/latest/cli-integration#print-to-stdout"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Print mode runs the supplied prompts, writes the final assistant text to stdout, and exits:

``` bash
pi --print "Summarize the changes in this repository"
```

Use print mode when only the final text is needed, including command substitution, pipelines, and one-shot jobs. Intermediate events are not exposed.

Print mode writes errors to stderr. A final assistant response with an `error` or `aborted` stop reason produces a nonzero exit status.

When no mode is selected explicitly, non-TTY stdin or stdout also selects print mode. This allows piped input and output without adding `--print`.


## Stream JSON events

<a href="#stream-json-events" class="heading-anchor" aria-label="Permalink: Stream JSON events" data-copy="" data-copy-text="https://pi.dev/docs/latest/cli-integration#stream-json-events"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


JSON mode writes a session header followed by agent and session events as newline-delimited JSON:

``` bash
pi --mode json "Review this repository" > events.jsonl
```

This is structured event output, not a single JSON result or a constraint on the format of the model’s response.

All prompts are supplied when the process starts. The process streams events for that run and then exits; it does not accept later commands.

A failed or aborted assistant response appears in the event stream but does not by itself produce a nonzero exit status. Inspect the events when success or failure matters. Pi still exits nonzero if the invocation throws an error.

Streaming `message_update` records contain deltas rather than a growing message snapshot. Assemble live output from the delta events, then replace it with the authoritative message from `message_end`.

`agent_end` can be followed by automatic recovery or queued work. `agent_settled` marks the end of automatic work for the current run.

Stdout is reserved for JSONL. Diagnostics and application logging are written to stderr. See [JSON Event Stream](/docs/latest/json) for framing, event shapes, and reconstruction rules.


## Control Pi with RPC

<a href="#control-pi-with-rpc" class="heading-anchor" aria-label="Permalink: Control Pi with RPC" data-copy="" data-copy-text="https://pi.dev/docs/latest/cli-integration#control-pi-with-rpc"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


RPC mode keeps Pi running while another process sends commands and receives responses and events:

``` bash
pi --mode rpc --no-session
```

Commands are JSON objects written to stdin. Responses and events are JSON objects written to stdout. Every record occupies one line.

Add an `id` to commands that need correlation. The matching response repeats that ID. Events generally have no command ID because they describe session activity rather than one request.

A successful `prompt` response means the prompt was accepted, queued, or handled. It does not mean the run completed. Continue consuming events through `agent_settled` when completion matters.

RPC commands can change models, inspect state, manage sessions, run shell commands, and answer extension UI requests.

Extension dialogs form a request-response subprotocol. Other extension UI updates are notifications that a client may display or ignore. TUI-only extension capabilities are unavailable or degraded outside interactive mode.

For Node.js or TypeScript integrations, prefer `RpcClient` from `@earendil-works/pi-coding-agent`. It starts a Pi RPC child process, correlates requests, exposes typed command methods, and delivers session events to listeners.

The [RPC client example](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/rpc-client.ts) sends one prompt, streams text and tool activity, waits for `agent_settled`, and shuts down the child process. It is included in the repository’s TypeScript checks.

`RpcClient.promptAndWait()` installs its event listener before sending the prompt, avoiding a race with fast completions. For separate operations, subscribe before calling `prompt()` and call `waitForIdle()` only while a run is active.

The client requires a path to a runnable Pi CLI. The repository example points at `dist/cli.js`, so the package must be built before that example runs from a checkout.

If you are building a client without `RpcClient`, start with [RPC Protocol](/docs/latest/rpc), then use [RPC Commands](/docs/latest/rpc-commands) and [JSON Event Stream](/docs/latest/json) as the wire references.


## Fork and rebrand Pi

<a href="#fork-and-rebrand-pi" class="heading-anchor" aria-label="Permalink: Fork and rebrand Pi" data-copy="" data-copy-text="https://pi.dev/docs/latest/cli-integration#fork-and-rebrand-pi"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


A source fork can change the CLI name and configuration directory through `package.json`:

``` json
{
  "piConfig": {
    "name": "my-agent",
    "configDir": ".my-agent"
  }
}
```

Change the top-level `bin` field to set the executable name. These settings affect the CLI banner, configuration paths, and derived environment variable names.


## Examples and references

<a href="#examples-and-references" class="heading-anchor" aria-label="Permalink: Examples and references" data-copy="" data-copy-text="https://pi.dev/docs/latest/cli-integration#examples-and-references"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


- [RPC client](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/rpc-client.ts): typed Node.js integration
- [RPC extension UI](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/rpc-extension-ui.ts): custom terminal client with extension dialogs
- [Command Line](/docs/latest/cli): startup options and mode selection
- [JSON Event Stream](/docs/latest/json): JSON event reference
- [RPC Protocol](/docs/latest/rpc): RPC lifecycle, framing, errors, and shutdown
- [RPC Commands](/docs/latest/rpc-commands): command and response reference
- [RPC Extension UI](/docs/latest/rpc-extension-ui): extension interaction subprotocol
- [SDK examples](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk): in-process TypeScript integrations


