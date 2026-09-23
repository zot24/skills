> Source: https://pi.dev/docs/latest/how-pi-works



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# How Pi Works


Pi coordinates model requests, tool execution, context assembly, and session storage. A session is Pi's record of a conversation, including messages, tool calls and results, model changes, compactions, and other events.

Messages and events in a session form a tree. Each path through that tree is a branch. The branch ending at the current entry is the active branch and supplies the history for the next model request.


## Agent loop

<a href="#agent-loop" class="heading-anchor" aria-label="Permalink: Agent loop" data-copy="" data-copy-text="https://pi.dev/docs/latest/how-pi-works#agent-loop"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


A submitted message is added to the active branch. Pi builds a model request from the system prompt, active branch, available tools, and model settings, then sends it through the selected provider.

The provider streams an assistant response, which can contain text and tool calls. Pi records the response, executes each tool call, and records the results. That completes one turn. If tool results or queued messages require another model request, Pi starts another turn. Otherwise, the run ends.

Steering messages enter after the current assistant turn. Follow-up messages enter after the agent has finished its pending work. Aborting stops the current run and returns queued messages to the editor.


## Context

<a href="#context" class="heading-anchor" aria-label="Permalink: Context" data-copy="" data-copy-text="https://pi.dev/docs/latest/how-pi-works#context"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


The active branch supplies conversation history. Pi converts its session entries into model-compatible user, assistant, and tool-result messages.

Pi builds the system prompt from its base instructions and discovered context files. The request also carries tool definitions and skill descriptions.

Full skill instructions are loaded on demand. Extensions can add instructions or transform context.

Prompt templates expand editor input before it becomes a user message. Selected files, images, pasted text, and shell output can become message content.


## Sessions

<a href="#sessions" class="heading-anchor" aria-label="Permalink: Sessions" data-copy="" data-copy-text="https://pi.dev/docs/latest/how-pi-works#sessions"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Persistent sessions are JSONL files. Each tree entry has an ID and refers to its parent. The current entry identifies the active branch.

Continuing from an earlier entry creates another branch in the same file. Forking and cloning copy selected history into a new session file.

Model context is reconstructed from the active branch. Compaction inserts a summary entry that replaces older messages in subsequent model requests. The original entries remain in the session tree.


## Interfaces

<a href="#interfaces" class="heading-anchor" aria-label="Permalink: Interfaces" data-copy="" data-copy-text="https://pi.dev/docs/latest/how-pi-works#interfaces"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Interactive mode renders session and agent events in the terminal. Print mode runs a prompt and writes the final response. JSON mode writes agent events as JSONL.

RPC mode accepts JSONL commands on stdin and writes responses and events to stdout. The TypeScript SDK creates and controls agent sessions in process.

All interfaces use the same agent and session mechanisms.


## Extensions and resources

<a href="#extensions-and-resources" class="heading-anchor" aria-label="Permalink: Extensions and resources" data-copy="" data-copy-text="https://pi.dev/docs/latest/how-pi-works#extensions-and-resources"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Extensions are TypeScript modules loaded into the Pi process. Their factory functions register tools, commands, shortcuts, providers, event handlers, renderers, and terminal UI.

Skills provide on-demand instructions and supporting files. Prompt templates provide reusable message text. Themes provide terminal colors. Pi packages distribute these resources through npm or git.


## Trust and permissions

<a href="#trust-and-permissions" class="heading-anchor" aria-label="Permalink: Trust and permissions" data-copy="" data-copy-text="https://pi.dev/docs/latest/how-pi-works#trust-and-permissions"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Pi resolves project trust before loading project settings and resources. After the trust decision and project-resource loading, Pi loads context files. Enabled tools use the operating-system permissions of the Pi process. Extensions execute inside that process.


