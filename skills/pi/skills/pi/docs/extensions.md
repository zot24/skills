> Source: https://pi.dev/docs/latest/extensions



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# Extensions


Extensions are TypeScript modules that add executable behavior to Pi. Use one when a workflow needs tools, commands, event handlers, model providers, session state, or terminal UI rather than instructions alone.

An extension runs inside the Pi process with the same operating-system permissions. It can inspect prompts, tool calls, files, credentials, and session history, so load extensions only from sources you trust.

Typical extensions add an agent tool, protect paths, confirm dangerous commands, react to session events, modify context, expose a command, or display persistent status.


## Create and load an extension

<a href="#create-and-load-an-extension" class="heading-anchor" aria-label="Permalink: Create and load an extension" data-copy="" data-copy-text="https://pi.dev/docs/latest/extensions#create-and-load-an-extension"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


An extension exports a default factory that receives `ExtensionAPI`. The factory registers capabilities for the current extension runtime.

Create `~/.pi/agent/extensions/hello.ts`:

``` typescript
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  pi.registerCommand("hello", {
    description: "Show a greeting",
    handler: async (name, ctx) => {
      ctx.ui.notify(`Hello, ${name || "world"}!`, "info");
    },
  });
}
```

Start Pi and run `/hello`. During development, load a file directly:

``` bash
pi --extension ./hello.ts
```

Pi uses `jiti`, so local TypeScript extensions do not need a separate compilation step. Use [Pi packages](/docs/latest/packages) for distributed extensions and dependencies.


## Add it to Pi

<a href="#add-it-to-pi" class="heading-anchor" aria-label="Permalink: Add it to Pi" data-copy="" data-copy-text="https://pi.dev/docs/latest/extensions#add-it-to-pi"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Place the extension in your user or project extensions directory. Pi loads direct TypeScript or JavaScript files and subdirectories containing an `index.ts` or `index.js` entry point.

Use a single file for a small extension and a directory for a multi-file implementation. Put npm dependencies in a nearby `package.json`. See [Configuration](/docs/latest/configuration) for conventional locations and [Settings](/docs/latest/settings#resources) for additional paths.

Reload replaces the extension runtime, so code after `await ctx.reload()` must not reuse state from the old runtime. Only personal and explicit command-line extensions can participate in the `project_trust` event that runs before project extensions load.


## Respect the runtime lifecycle

<a href="#respect-the-runtime-lifecycle" class="heading-anchor" aria-label="Permalink: Respect the runtime lifecycle" data-copy="" data-copy-text="https://pi.dev/docs/latest/extensions#respect-the-runtime-lifecycle"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


The factory can be synchronous or asynchronous. Pi waits for an asynchronous factory before startup continues, allowing it to fetch configuration or register providers needed during startup.

Do not start processes, sockets, watchers, or timers in the factory because some invocations load extensions without starting a session. Start long-lived resources from `session_start` or from the command or tool that needs them. Close session-scoped resources from an idempotent `session_shutdown` handler.

A run proceeds from input and `before_agent_start`, through model, message, and tool events, to `agent_end`. Automatic retries, recovery, compaction, or queued work can continue afterward. <span id="agent_start--agent_end--agent_before_settle--agent_settled"></span>

`agent_before_settle` is the final actionable boundary: it can append entries and request one continuation. `agent_settled` is final and notification-only; use it when an integration needs to know Pi will not continue automatically.


## Choose an integration point

<a href="#choose-an-integration-point" class="heading-anchor" aria-label="Permalink: Choose an integration point" data-copy="" data-copy-text="https://pi.dev/docs/latest/extensions#choose-an-integration-point"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Capability                                    | Main API                                       |
|-----------------------------------------------|------------------------------------------------|
| Observe or modify lifecycle behavior          | `pi.on()`                                      |
| Add a model-callable operation                | `pi.registerTool()`                            |
| Add a `/` command                             | `pi.registerCommand()`                         |
| Add a shortcut or CLI flag                    | `pi.registerShortcut()` or `pi.registerFlag()` |
| Send user or custom messages                  | `pi.sendUserMessage()` or `pi.sendMessage()`   |
| Persist non-context session data              | `pi.appendEntry()`                             |
| Change active tools, model, or thinking level | Session control methods on `pi`                |
| Add a model provider                          | `pi.registerProvider()`                        |
| Add terminal rendering                        | Renderer registration and `ctx.ui`             |
| Communicate with another extension            | `pi.events`                                    |

Use the exported declarations in [`extensions/types.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/src/core/extensions/types.ts) for exact event, context, tool, and result types.


## Follow the extension contracts

<a href="#follow-the-extension-contracts" class="heading-anchor" aria-label="Permalink: Follow the extension contracts" data-copy="" data-copy-text="https://pi.dev/docs/latest/extensions#follow-the-extension-contracts"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


### Events and concurrency

<a href="#events-and-concurrency" class="heading-anchor" aria-label="Permalink: Events and concurrency" data-copy="" data-copy-text="https://pi.dev/docs/latest/extensions#events-and-concurrency"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Handlers run in extension load and registration order. `pi.on()` returns a function that unsubscribes that registration; changes do not affect a dispatch already in progress. Some events notify; others transform data, replace results, or cancel an operation. Use each event’s declared result type rather than assuming every return value has an effect.

Events cover resource discovery, sessions, agent and message lifecycle, providers, tools, and raw input.

`before_agent_start` exposes both the current prompt and its structured `systemPromptOptions`. Prefer changing prompt sections, selected tools, or guidelines so Pi can append a transcript delta. Returning `systemPrompt`, or setting `forceSystemPrompt`, replaces the whole prompt for that run while the transcript continues recording the structured sections. Providers receive the forced text as their leading system prompt.

`message_end` can replace a finalized message while preserving its role. `tool_call` can mutate input or block execution. `tool_result` handlers compose, with each handler seeing prior changes.


`context` transforms conversation messages without prompt and tool system messages; Pi restores that state afterward. Use `context_with_system` only when a request-local transformation must own the complete transcript, and keep a system message at index zero.

`turn_end` and `agent_before_settle` are actionable boundaries. Their handlers can chain proposed `custom`, `custom_message`, `context_edit`, or `compaction` entries and return `continue: true` for one next model request. Guard continuation conditions because an unconditional continuation can loop. Use the exported event declarations for the complete validation and ordering contract.


`cache_warming_decision` can override an idle prompt-cache refresh with `{ action: "warm" }` or `{ action: "stop" }`. The last handler that returns an action wins.

Tool calls from one assistant message can run in parallel. Do not assume a sibling call or result exists when another tool event runs. Use `ctx.signal` for nested work owned by an active turn; commands and idle session events often have no operation signal.

A `user_bash` handler that returns `undefined` passes the command to the next handler and then to local execution if no handler handles it. Returning `operations` or `result` stops propagation. A handler failure blocks the command rather than falling through to local execution.


### Tools

<a href="#tools" class="heading-anchor" aria-label="Permalink: Tools" data-copy="" data-copy-text="https://pi.dev/docs/latest/extensions#tools"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


A custom tool defines a name, model-facing description, TypeBox parameter schema, and `execute()` function. Its result requires model-facing `content` and a `details` field for rendering or state reconstruction. Use `details: undefined` when there are no structured details. If the tool makes nested model calls, include their `usage` in the result so session totals remain accurate.

Throw from `execute()` to produce a failed tool result. Returning an object does not mark it as an error. Return `terminate: true` only when the agent should skip its automatic follow-up after every completed tool in that batch agrees to terminate.

Use sequential execution when tools share mutable in-memory state. File-mutating tools should wrap the complete read-modify-write operation with `withFileMutationQueue()`. Truncate large model-facing results and tell the model where to read the complete output.

See [`hello.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/extensions/hello.ts), [`todo.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/extensions/todo.ts), [`dynamic-tools.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/extensions/dynamic-tools.ts), and [`truncated-tool.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/extensions/truncated-tool.ts).


### Activate tools dynamically

<a href="#activate-tools-dynamically" class="heading-anchor" aria-label="Permalink: Activate tools dynamically" data-copy="" data-copy-text="https://pi.dev/docs/latest/extensions#activate-tools-dynamically"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Register every tool first, keep optional tools inactive, and use `pi.setActiveTools()` from a loader tool to select the desired active tools. Names must already be registered; unknown names are ignored.

Pi records the initial prompt and tool set in the transcript's first system message, then appends tool and prompt changes before the next model request. Providers that cannot represent the transition receive a complete transcript checkpoint, which can invalidate the cached prefix.


### Context and session changes

<a href="#context-and-session-changes" class="heading-anchor" aria-label="Permalink: Context and session changes" data-copy="" data-copy-text="https://pi.dev/docs/latest/extensions#context-and-session-changes"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


`ExtensionContext` provides the working directory, mode, UI, session manager, model runtime, abort signal, context usage, and controls for compaction and shutdown. Use `ctx.modelRegistry.streamSimple()` for provider-neutral nested model calls.

Command handlers receive `ExtensionCommandContext`, which adds operations for waiting until idle, reloading, tree navigation, and session replacement. These operations are command-only because calling them from lifecycle handlers can deadlock the runtime.

Session replacement invalidates the old context. Capture only plain data before switching, then use the fresh context supplied to `withSession` for session-bound work.


### State

<a href="#state" class="heading-anchor" aria-label="Permalink: State" data-copy="" data-copy-text="https://pi.dev/docs/latest/extensions#state"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Choose storage based on how state participates in the conversation:

| State                                       | Storage               |
|---------------------------------------------|-----------------------|
| Tool state that follows the active branch   | Tool-result `details` |
| Durable data excluded from model context    | `pi.appendEntry()`    |
| Custom content stored and sent to the model | `pi.sendMessage()`    |
| Data outside one session                    | External storage      |

Reconstruct branch-sensitive state from `ctx.sessionManager.getBranch()` during `session_start`. Do not rebuild it from every file entry because abandoned branches represent alternative histories. Register an entry or message renderer when custom stored content should appear in the transcript.


### UI and modes

<a href="#ui-and-modes" class="heading-anchor" aria-label="Permalink: UI and modes" data-copy="" data-copy-text="https://pi.dev/docs/latest/extensions#ui-and-modes"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


`ctx.ui` provides dialogs, notifications, status text, widgets, titles, editor access, and custom components. Use `ctx.ui.custom()` only when the interaction needs its own rendering and input. See [Terminal UI](/docs/latest/tui) for component, focus, overlay, theme, and performance guidance.

Extensions load in interactive, RPC, JSON, and print modes. Interactive mode provides the complete terminal UI. RPC can forward supported dialogs and notifications through the [RPC Extension UI protocol](/docs/latest/rpc-extension-ui), but not custom terminal components; JSON and print modes have no UI. Guard terminal-only behavior with `ctx.mode === "tui"` and use `ctx.hasUI` for interactions supported by interactive and RPC clients.

Keep tool and event behavior independent from rendering so non-interactive modes remain functional.


### Errors and cleanup

<a href="#errors-and-cleanup" class="heading-anchor" aria-label="Permalink: Errors and cleanup" data-copy="" data-copy-text="https://pi.dev/docs/latest/extensions#errors-and-cleanup"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Pi reports handler errors and continues where possible. A `tool_call` handler failure blocks the tool as a fail-safe; a tool execution failure becomes an error result for the model.

Release resources in `session_shutdown` even when normal operation attempted cleanup. Keep cleanup idempotent because cancellation, reload, session replacement, and process exit can converge on the same path. Use `ctx.shutdown()` to request an orderly process shutdown.


## Examples and reference

<a href="#examples-and-reference" class="heading-anchor" aria-label="Permalink: Examples and reference" data-copy="" data-copy-text="https://pi.dev/docs/latest/extensions#examples-and-reference"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


The checked [extension examples](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/extensions) cover tools, lifecycle events, commands, flags, shortcuts, state, rendering, providers, OAuth, remote execution, and terminal components. Start with the smallest example matching your integration point.

Use [Custom Providers](/docs/latest/custom-provider) for model-service integrations, [Terminal UI](/docs/latest/tui) for custom components, and [Pi Packages](/docs/latest/packages) to install or distribute extensions with other resources.


