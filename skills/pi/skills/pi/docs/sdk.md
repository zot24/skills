> Source: https://pi.dev/docs/latest/sdk



# SDK


`@earendil-works/pi-coding-agent` embeds Pi in a Node.js or Bun process. It provides direct TypeScript access to the agent, sessions, tools, models, and resources used by the command-line application.

Use the SDK for in-process TypeScript integration. For a language-independent or isolated subprocess, see <a href="/latest/cli-integration" class="link-module_root__svb26">CLI Integration</a>.

``` code-snippet-module_root__tK5do
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

The <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/01-minimal.ts" class="link-module_root__svb26">complete minimal example</a> also streams text events. All <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk" class="link-module_root__svb26">SDK examples</a> are typechecked with the repository.


## Session lifecycle


`createAgentSession()` creates an `AgentSession`. The session owns one conversation, its model and tools, queued messages, compaction state, and extension runtime.

Read current state through `session.messages`, `session.model`, `session.thinkingLevel`, `session.systemPrompt`, and `session.getActiveToolNames()`.

`session.systemPrompt` is read-only and returns the current effective system prompt, including changes that have not yet been sent to the model. Tool changes are declared to the model before the next request.


### Session storage


Sessions are persistent by default. `SessionManager` owns the persisted or in-memory entry tree and tracks its active leaf. Branching changes that leaf without deleting abandoned branches. When Pi reconstructs model context, the manager selects the active branch and applies compaction.

`SessionManager` is authoritative for finalized model context. Restore external history by constructing the session with a manager containing those entries. Assigning `session.agent.state.messages` does not replace persisted context.

Use an in-memory manager when the host does not want session files:

``` code-snippet-module_root__tK5do
import { createAgentSession, SessionManager } from "@earendil-works/pi-coding-agent";

const { session } = await createAgentSession({
  sessionManager: SessionManager.inMemory(),
});
```

See the checked <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/11-sessions.ts" class="link-module_root__svb26">sessions example</a> for creating, opening, continuing, listing, and forking sessions. <a href="/latest/session-format" class="link-module_root__svb26">Session File Format</a> defines the persisted JSONL contract, and <a href="/latest/message-types" class="link-module_root__svb26">Message Types</a> defines transcript values. For exact methods and signatures, use the exported TypeScript declarations or <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/src/core/session-manager.ts" class="link-module_root__svb26"><code class="inline-code-module_root__fGvLx" data-variant="soft">session-manager.ts</code></a>.

`cwd` selects the workspace used for project resource discovery, context files, session grouping, and built-in tool paths. Pass it explicitly when the target differs from `process.cwd()`.

`session.dispose()` aborts active work, invalidates extension contexts, disconnects from the agent, and removes event listeners. Call it when the session is no longer needed.

`AgentSessionRuntime` adds `newSession()`, `switchSession()`, `fork()`, and `importFromJsonl()`. Each operation replaces the active `AgentSession` and recreates services for the target working directory.

After a runtime replacement, subscriptions belong to the old `AgentSession` and must be rebound. See the <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/13-session-runtime.ts" class="link-module_root__svb26">session runtime example</a>.


## Prompting


`prompt()` handles extension commands and expands file-based prompt templates before ordinary user messages enter the agent. For an accepted agent run, it resolves after the run finishes, including automatic retries.

A prompt sent while the session is already streaming must specify whether it should steer the current run or follow it. Calling `prompt()` without that choice rejects rather than guessing.

A steering message enters after the current assistant turn and its tool calls. A follow-up enters after the current run finishes its pending work. `steer()` and `followUp()` expose those behaviors directly and return `"queued"` if the input was queued (including after an extension transformed it), or `"handled"` if an extension consumed it.

`abort()` stops the active operation and waits for the session to become idle. `waitForIdle()` waits without aborting it.


## Subscribing to events


Subscribe before prompting when the host needs streamed output:

``` code-snippet-module_root__tK5do
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


Without overrides, the factory creates a `ModelRuntime`, file-backed `SettingsManager`, persistent `SessionManager`, `DefaultResourceLoader`, and the configured default tools.

Each boundary can be supplied explicitly:

- `modelRuntime`, `model`, `thinkingLevel`, and `scopedModels` control model access and selection.
- `settingsManager` supplies merged settings or an in-memory configuration.
- `sessionManager` supplies persistent or in-memory conversation history.
- `resourceLoader` supplies extensions, skills, prompt templates, themes, and context files.
- `tools`, `noTools`, `excludeTools`, and `customTools` control the active tool set.

Use `DefaultResourceLoader` when you want standard discovery with selected overrides. Supply a custom `ResourceLoader` when the host owns resource storage and discovery completely.


Inline extension factories can be supplied through `DefaultResourceLoader`. Give one an `InlineExtension` name only when it needs a stable name in diagnostics and startup output. A named inline extension with `replaceable: true` is left out when another extension registers a tool, command, or flag with a name it registers during loading, instead of both loading with a conflict. The CLI's built-in codemode, tool search, and MCP extensions are replaceable. A named entry with `builtin: true` is not an inline extension: it supplies the code of the `builtin:<name>` extension, which loads like a configured extension file. It loads by default, is listed in `pi config`, and is disabled by `-builtin:<name>` in the `extensions` setting or by `noExtensions`; `additionalExtensionPaths: ["builtin:<name>"]` loads it explicitly. It loads after project trust is resolved, so it cannot handle `project_trust`. The CLI's built-in extensions use it.


The CLI loads `codemode`, `tool_search`, and MCP as built-in extensions. SDK sessions do not; add `createCodemodeExtension()`, `createToolSearchExtension()`, and `createMcpExtension()` to the `extensionFactories` of `DefaultResourceLoader`. `codemode` and `tool_search` are registered inactive: enable them through the `defaultTools` setting (`["+codemode", "+tool_search"]` keeps the other default tools), or let the MCP extension activate them: `codemode` for servers with `codemode` exposure, `tool_search` for servers with `deferred` exposure. The MCP extension connects its servers on `session_start`, so call `session.bindExtensions()`. See <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/14-codemode-mcp.ts" class="link-module_root__svb26">Codemode and MCP</a>.

See the focused examples for <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/02-custom-model.ts" class="link-module_root__svb26">models</a>, <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/05-tools.ts" class="link-module_root__svb26">tools</a>, <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/06-extensions.ts" class="link-module_root__svb26">extensions</a>, and <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/12-full-control.ts" class="link-module_root__svb26">full control</a>.


## Examples


| Example | Purpose |
|----|----|
| <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/01-minimal.ts" class="link-module_root__svb26">Minimal</a> | Create, prompt, observe, and dispose a session |
| <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/02-custom-model.ts" class="link-module_root__svb26">Custom model</a> | Select a model and thinking level |
| <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/03-custom-prompt.ts" class="link-module_root__svb26">System prompt</a> | Replace or append to the system prompt |
| <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/04-skills.ts" class="link-module_root__svb26">Skills</a> | Discover, filter, and add skills |
| <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/05-tools.ts" class="link-module_root__svb26">Tools</a> | Select built-in tools and their working directory |
| <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/06-extensions.ts" class="link-module_root__svb26">Extensions</a> | Load file-based and inline extensions |
| <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/07-context-files.ts" class="link-module_root__svb26">Context files</a> | Add or replace project instructions |
| <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/08-prompt-templates.ts" class="link-module_root__svb26">Prompt templates</a> | Add file-style prompt templates |
| <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/09-api-keys-and-oauth.ts" class="link-module_root__svb26">Credentials</a> | Configure credential and model storage |
| <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/10-settings.ts" class="link-module_root__svb26">Settings</a> | Supply file-backed or in-memory settings |
| <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/11-sessions.ts" class="link-module_root__svb26">Sessions</a> | Control session persistence and restoration |
| <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/12-full-control.ts" class="link-module_root__svb26">Full control</a> | Replace default discovery and state services |
| <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/13-session-runtime.ts" class="link-module_root__svb26">Session runtime</a> | Replace the active session safely |
| <a href="https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/sdk/14-codemode-mcp.ts" class="link-module_root__svb26">Codemode and MCP</a> | Add the `codemode`, `tool_search`, and MCP extensions |


## Resources


- <a href="/latest/models" class="link-module_root__svb26">Choose a Model</a> covers model selection and compatible endpoints; <a href="/latest/providers" class="link-module_root__svb26">Providers</a> covers credentials and provider-specific setup.
- <a href="/latest/configuration" class="link-module_root__svb26">Configuration</a> explains normal discovery and settings; <a href="/latest/settings" class="link-module_root__svb26">Settings</a> lists every setting.
- <a href="/latest/sessions" class="link-module_root__svb26">Sessions and Context</a> explains session behavior; <a href="/latest/session-format" class="link-module_root__svb26">Session Format</a> defines persisted entries; <a href="/latest/message-types" class="link-module_root__svb26">Message Types</a> defines shared transcript values.
- <a href="/latest/extensions" class="link-module_root__svb26">Extensions</a>, <a href="/latest/skills" class="link-module_root__svb26">Skills</a>, and <a href="/latest/prompt-templates" class="link-module_root__svb26">Prompt Templates</a> document resources supplied through a `ResourceLoader`.
- <a href="/latest/cli-integration" class="link-module_root__svb26">CLI Integration</a> covers print, JSON, and RPC alternatives to an in-process SDK integration.


