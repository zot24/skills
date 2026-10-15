> Source: https://chat-sdk.dev/docs/getting-started.md

---
title: Getting Started
description: Pick a guide to start building with Chat SDK.
docs_index: /llms.txt
lastUpdated: 2026-10-14
related:
  - /docs/usage
  - /docs/platform-adapters
  - /docs/vercel-connect
  - /docs/create-chat-sdk
---

> For an index of all documentation, see [/llms.txt](/llms.txt).

Start with the usage guides to learn how a bot handles incoming events and posts messages, then add the adapters for your chat platforms and state backend.

## Usage

Learn the core patterns for handling incoming events and posting messages back to your users.

#### [Creating a Chat Instance](/docs/usage)

Initialize the Chat class with adapters, state, and configuration options.

#### [Threads, Messages, and Channels](/docs/threads-messages-channels)

Work with threads, messages, and channels across platforms.

#### [Handling Events](/docs/handling-events)

Register handlers for mentions, messages, reactions, and platform-specific events.

#### [Posting Messages](/docs/posting-messages)

Send plain text, markdown, cards, and streams with thread.post().

## Adapters

Connect your bot to chat platforms and persist state across restarts.

#### [Platform Adapters](/docs/platform-adapters)

Connect your bot to messaging platforms with webhook verification, parsing, and native formatting.

#### [State Adapters](/docs/state-adapters)

Pluggable state adapters for thread subscriptions, distributed locking, and caching.

Browse all official, vendor-official, and community adapters on the [Adapters](/adapters) page.

## Resources

- [The Complete Guide to Chat SDK](https://vercel.com/kb/guide/the-complete-guide-to-chat-sdk?utm_source=chat-sdk_site\&utm_medium=docs\&utm_campaign=getting-started\&utm_content=the-complete-guide-to-chat-sdk): an end-to-end walkthrough that takes you from an empty project to a deployed multi-platform bot, covering adapters, state, handlers, cards, and streaming.

See all guides and templates on the [resources](/resources?utm_source=chat-sdk_site\&utm_medium=docs\&utm_campaign=getting-started\&utm_content=resources) page.

---

For a semantic overview of all documentation, see [/sitemap.md](/sitemap.md)

For an index of all available documentation, see [/llms.txt](/llms.txt)

For agent-facing discovery, including API and MCP surfaces, see [/agents.md](/agents.md)
