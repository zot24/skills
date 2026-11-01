> Source: https://honcho.dev/docs/v3/guides/integrations/cursor.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# Cursor

> Add AI-native memory to Cursor

Give Cursor long-term memory that survives new chats, context wipes, and project switches. The Honcho plugin connects Cursor's agent to the hosted Honcho MCP server and ships the skills that make it recall what it knows about you before working and record each exchange afterwards. The same marketplace listing installs into [Grok Bot](https://honcho.dev/docs/v3/guides/integrations/grok-bot.md).

The core needs nothing local: no API key to paste and no local server. Cursor users can add automatic capture on top with one command.

## Quick Start

**1. Install the plugin**

Open **Customize** in Cursor's sidebar, find **Honcho** under Plugins, and choose **Install**. Pick user scope to have memory in every project, or project scope for one.

**2. Sign in**

In the same panel, open the **honcho** MCP server and choose **Authenticate**. A browser window signs you in to Honcho with OAuth. If you do not have an account yet, create one at [app.honcho.dev](https://app.honcho.dev) first.

**3. Run setup once**

Start a new chat and run `/honcho-setup`. The agent asks two questions: whether to keep Cursor's memory on its own or share it with another Honcho tool, and what Honcho should call you. It stores both answers in Honcho, so you are never asked again, in any project or on any machine.

> [!TIP]
>
> Already using Honcho with Claude Code or another tool? Choose that tool's workspace and the same handle during setup, and Cursor shares the same memory of you. See [Unified Memory Setup](https://honcho.dev/docs/v3/guides/recipes/unified-memory-setup.md).

## What You Get

* **Recall on every conversation.** The agent reads Honcho's picture of you (`get_peer_context`) before it starts working, and searches past sessions or asks Honcho a reasoned question (`chat`) when context would help.
* **Record after every exchange.** Your messages and the agent's replies go to Honcho, which reasons over them in the background. The agent replaces anything that looks like a secret with `[redacted]` and never records raw tool output.
* **One session per project.** Each project maps to one Honcho session, named from its git remote so two clones share it and two projects with the same folder name do not. A project's context accumulates instead of fragmenting by day.
* **A `/recall` command.** `/recall <topic>` asks Honcho what it remembers about a topic. To save something, tell the agent to remember it.
* **An always-on rule** reminds the agent to recall and record, so you do not have to ask.
* **Automatic capture**, if you run `honcho init`: three hooks inject memory before your first prompt and record every turn without the agent's involvement. See below.

## How Memory Is Organized

| Honcho concept | Value in Cursor |
| - | - |
| Workspace | `cursor`, or the shared workspace you picked during setup |
| User peer | the handle you chose, stored as workspace metadata |
| Agent peer | `cursor` |
| Session | `cursor-<owner>-<repo>` from the project's git remote, or `cursor-<folder>` without one |

The workspace and user peer live in Honcho's workspace metadata, so every agent on the account resolves the same values with two cheap reads at the start of a conversation.

## Automatic Capture

The skills ask the agent to record each exchange, and it almost always does. Cursor can also do it in code. The plugin ships three lifecycle hooks: `sessionStart` injects Honcho's picture of you into the conversation before your first prompt, `beforeSubmitPrompt` records what you typed with secrets redacted, and `afterAgentResponse` records the reply with long code blocks collapsed.

A hook is a separate process and cannot use the OAuth token Cursor holds for the MCP server, so the hooks read `~/.honcho/config.json`. Run `honcho init` once (or reuse the file if you already have claude-honcho or kilo-honcho) and the hooks turn on at the next session; without the file they exit silently and the skills keep working. The hooks run with [`bun`](https://bun.sh), like Cursor's own plugins. When capture is automatic, the session-start context says so, and the agent stops recording turns itself.

## Manual MCP Setup

If you prefer not to use the plugin, Cursor can connect to the Honcho MCP server directly with an API key. The config block is in the [MCP guide](https://honcho.dev/docs/v3/guides/integrations/mcp.md#cursor). You lose the skills, rule and `/recall` command, so you will need to ask the agent to use its memory.

## Troubleshooting

**The agent says it needs to sign in.** Open Customize, select the honcho MCP server, and choose Authenticate or Reconnect. OAuth tokens refresh on their own once the first sign-in completes.

**Memory seems empty.** Run `/honcho-setup` and check the status it reports. Honcho reasons asynchronously, so a conversation recorded a moment ago shows up in the next one, not the current one. The [`honcho` CLI](https://honcho.dev/docs/v3/documentation/reference/cli) can show exactly which messages and conclusions have landed.

**Two agents disagree about who you are.** They are using different workspaces or handles. Run `/honcho-setup` in each and give the same answers.

## Source

The plugin lives in the Honcho monorepo under [`integrations/cursor/`](https://github.com/plastic-labs/honcho/tree/main/integrations/cursor). Issues and pull requests go to [plastic-labs/honcho](https://github.com/plastic-labs/honcho).


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
