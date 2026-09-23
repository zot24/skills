> Source: https://pi.dev/docs/latest/sdk



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# SDK


`@earendil-works/pi-coding-agent` embeds Pi in a Node.js or Bun process. It provides direct TypeScript access to the agent, sessions, tools, models, and resources used by the command-line application.

Use the SDK for in-process TypeScript integration. For a language-independent or isolated subprocess, see [CLI Integration](/docs/latest/cli-integration).

``` typescript
import { createAgentSession } from "@earendil-works/pi-coding-agent";

const { session } = await createAgentSession();

try {
  await session.prompt("What files are in the current directory?");
  console.log(session.getLastAssistantText());
} finally {
  session.dispose();
}
```

This uses the working directory, discovered resources, stored settings, and configured credentials. `prompt()` resolves when the run finishes.

The [complete minimal example](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/01-minimal.ts) also streams text events. All [SDK examples](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk) are typechecked with the repository.


## Session lifecycle

<a href="#session-lifecycle" class="heading-anchor" aria-label="Permalink: Session lifecycle" data-copy="" data-copy-text="https://pi.dev/docs/latest/sdk#session-lifecycle"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


`createAgentSession()` creates an `AgentSession`. The session owns one conversation, its model and tools, queued messages, compaction state, and extension runtime.

Read current state through `session.messages`, `session.model`, `session.thinkingLevel`, `session.systemPrompt`, and `session.getActiveToolNames()`.

`session.systemPrompt` is read-only and returns the current effective system prompt, including changes that have not yet been sent to the model. Tool changes are declared to the model before the next request.


### Session storage

<a href="#session-storage" class="heading-anchor" aria-label="Permalink: Session storage" data-copy="" data-copy-text="https://pi.dev/docs/latest/sdk#session-storage"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Sessions are persistent by default. `SessionManager` owns the persisted or in-memory entry tree and tracks its active leaf. Branching changes that leaf without deleting abandoned branches. When Pi reconstructs model context, the manager selects the active branch and applies compaction.

`SessionManager` is authoritative for finalized model context. Restore external history by constructing the session with a manager containing those entries. Assigning `session.agent.state.messages` does not replace persisted context.

Use an in-memory manager when the host does not want session files:

``` typescript
import { createAgentSession, SessionManager } from "@earendil-works/pi-coding-agent";

const { session } = await createAgentSession({
  sessionManager: SessionManager.inMemory(),
});
```

See the checked [sessions example](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/11-sessions.ts) for creating, opening, continuing, listing, and forking sessions. [Session File Format](/docs/latest/session-format) defines the persisted JSONL contract, and [Message Types](/docs/latest/message-types) defines transcript values. For exact methods and signatures, use the exported TypeScript declarations or [`session-manager.ts`](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/src/core/session-manager.ts).

`cwd` selects the workspace used for project resource discovery, context files, session grouping, and built-in tool paths. Pass it explicitly when the target differs from `process.cwd()`.

`session.dispose()` aborts active work, invalidates extension contexts, disconnects from the agent, and removes event listeners. Call it when the session is no longer needed.

`AgentSessionRuntime` adds `newSession()`, `switchSession()`, `fork()`, and `importFromJsonl()`. Each operation replaces the active `AgentSession` and recreates services for the target working directory.

After a runtime replacement, subscriptions belong to the old `AgentSession` and must be rebound. See the [session runtime example](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/13-session-runtime.ts).


## Prompting

<a href="#prompting" class="heading-anchor" aria-label="Permalink: Prompting" data-copy="" data-copy-text="https://pi.dev/docs/latest/sdk#prompting"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


`prompt()` handles extension commands and expands file-based prompt templates before ordinary user messages enter the agent. For an accepted agent run, it resolves after the run finishes, including automatic retries.

A prompt sent while the session is already streaming must specify whether it should steer the current run or follow it. Calling `prompt()` without that choice rejects rather than guessing.

A steering message enters after the current assistant turn and its tool calls. A follow-up enters after the current run finishes its pending work. `steer()` and `followUp()` expose those behaviors directly.

`abort()` stops the active operation and waits for the session to become idle. `waitForIdle()` waits without aborting it.


## Subscribing to events

<a href="#subscribing-to-events" class="heading-anchor" aria-label="Permalink: Subscribing to events" data-copy="" data-copy-text="https://pi.dev/docs/latest/sdk#subscribing-to-events"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Subscribe before prompting when the host needs streamed output:

``` typescript
const unsubscribe = session.subscribe((event) => {
  if (event.type === "message_update" && event.assistantMessageEvent.type === "text_delta") {
    process.stdout.write(event.assistantMessageEvent.delta);
  }
});

try {
  await session.prompt("Explain this repository");
} finally {
  unsubscribe();
}
```

Session events report message updates, tool execution, queues, compaction, retries, and run lifecycle changes.

`message_end` contains the authoritative completed message. `agent_end` marks the end of one low-level agent run, but automatic recovery or queued work can still follow.

Use `agent_settled` when the host needs to know that Pi will not continue automatically.


## Configuring a session

<a href="#configuring-a-session" class="heading-anchor" aria-label="Permalink: Configuring a session" data-copy="" data-copy-text="https://pi.dev/docs/latest/sdk#configuring-a-session"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Without overrides, the factory creates a `ModelRuntime`, file-backed `SettingsManager`, persistent `SessionManager`, `DefaultResourceLoader`, and the configured default tools.

Each boundary can be supplied explicitly:

- `modelRuntime`, `model`, `thinkingLevel`, and `scopedModels` control model access and selection.
- `settingsManager` supplies merged settings or an in-memory configuration.
- `sessionManager` supplies persistent or in-memory conversation history.
- `resourceLoader` supplies extensions, skills, prompt templates, themes, and context files.
- `tools`, `noTools`, `excludeTools`, and `customTools` control the active tool set.

Use `DefaultResourceLoader` when you want standard discovery with selected overrides. Supply a custom `ResourceLoader` when the host owns resource storage and discovery completely.


Inline extension factories can be supplied through `DefaultResourceLoader`. Give one an `InlineExtension` name only when it needs a stable name in diagnostics and startup output.

See the focused examples for [models](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/02-custom-model.ts), [tools](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/05-tools.ts), [extensions](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/06-extensions.ts), and [full control](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/12-full-control.ts).


## Examples

<a href="#examples" class="heading-anchor" aria-label="Permalink: Examples" data-copy="" data-copy-text="https://pi.dev/docs/latest/sdk#examples"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Example                                                                                                                      | Purpose                                           |
|------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------|
| [Minimal](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/01-minimal.ts)                   | Create, prompt, observe, and dispose a session    |
| [Custom model](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/02-custom-model.ts)         | Select a model and thinking level                 |
| [System prompt](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/03-custom-prompt.ts)       | Replace or append to the system prompt            |
| [Skills](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/04-skills.ts)                     | Discover, filter, and add skills                  |
| [Tools](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/05-tools.ts)                       | Select built-in tools and their working directory |
| [Extensions](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/06-extensions.ts)             | Load file-based and inline extensions             |
| [Context files](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/07-context-files.ts)       | Add or replace project instructions               |
| [Prompt templates](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/08-prompt-templates.ts) | Add file-style prompt templates                   |
| [Credentials](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/09-api-keys-and-oauth.ts)    | Configure credential and model storage            |
| [Settings](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/10-settings.ts)                 | Supply file-backed or in-memory settings          |
| [Sessions](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/11-sessions.ts)                 | Control session persistence and restoration       |
| [Full control](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/12-full-control.ts)         | Replace default discovery and state services      |
| [Session runtime](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/13-session-runtime.ts)   | Replace the active session safely                 |


## Resources

<a href="#resources" class="heading-anchor" aria-label="Permalink: Resources" data-copy="" data-copy-text="https://pi.dev/docs/latest/sdk#resources"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


- [Choose a Model](/docs/latest/models) covers model selection and compatible endpoints; [Provider Authentication](/docs/latest/providers) covers credentials and cloud-provider setup.
- [Configuration](/docs/latest/configuration) explains normal discovery and settings; [Settings](/docs/latest/settings) lists every setting.
- [Sessions and Context](/docs/latest/sessions) explains session behavior; [Session Format](/docs/latest/session-format) defines persisted entries; [Message Types](/docs/latest/message-types) defines shared transcript values.
- [Extensions](/docs/latest/extensions), [Skills](/docs/latest/skills), and [Prompt Templates](/docs/latest/prompt-templates) document resources supplied through a `ResourceLoader`.
- [CLI Integration](/docs/latest/cli-integration) covers print, JSON, and RPC alternatives to an in-process SDK integration.


