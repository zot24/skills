> Source: https://chat-sdk.dev/sitemap.md

# Documentation Sitemap

## Purpose

This file is a high-level semantic index of the documentation.
It is intended for:

- LLM-assisted navigation (ChatGPT, Claude, etc.)
- Quick orientation for contributors
- Identifying relevant documentation areas during development

It is not intended to replace individual docs.

---

- [Introduction](/docs) | Type: Overview | Lastmod: 2026-07-01 | Summary: A unified SDK for building chat bots across Slack, Microsoft Teams, Google Chat, Discord, Telegram, and more.

    - [Actions](/docs/actions) | Type: Guide | Lastmod: 2026-07-01 | Summary: Handle button clicks and interactive card events across platforms. | Prerequisites: /docs/cards | Topics: actions

    - [Overview](/docs/adapters) | Type: Overview | Lastmod: 2026-07-01 | Summary: Overview of Chat SDK adapters and the static adapter catalog. | Prerequisites: /docs/getting-started | Topics: adapters

    - [Overview](/docs/ai) | Type: Overview | Lastmod: 2026-07-01 | Summary: AI utilities that ship with Chat SDK — agent tools, message conversion, and supporting types. | Prerequisites: Introduction | Topics: ai

        - [AI SDK Tools](/docs/ai/ai-sdk-tools) | Type: Guide | Lastmod: 2026-07-01 | Summary: Give an AI agent the ability to operate inside your workspace. Post messages, send DMs, react, edit, delete; all with built-in approval gates. | Prerequisites: /docs/usage | Topics: ai, ai-sdk-tools

        - [toAiMessages](/docs/ai/to-ai-messages) | Type: Reference | Lastmod: 2026-07-01 | Summary: Convert Chat SDK messages to AI SDK conversation format. | Prerequisites: Overview | Topics: ai, to-ai-messages

        - [Types](/docs/ai/types) | Type: Reference | Lastmod: 2026-07-01 | Summary: TypeScript types exported from the chat/ai subpath. | Prerequisites: Overview | Topics: ai, types

    - [Overview](/docs/api) | Type: Overview | Lastmod: 2026-07-01 | Summary: API reference for the Chat SDK core package. | Prerequisites: Introduction | Topics: api

        - [Cards](/docs/api/cards) | Type: Reference | Lastmod: 2026-07-01 | Summary: Rich card components for cross-platform interactive messages. | Prerequisites: Overview | Topics: api, cards

        - [Channel](/docs/api/channel) | Type: Reference | Lastmod: 2026-07-01 | Summary: Channel container that holds threads, with methods for listing, posting, and iteration. | Prerequisites: Overview | Topics: api, channel

        - [Chat](/docs/api/chat) | Type: Reference | Lastmod: 2026-07-01 | Summary: The main entry point for creating a multi-platform chat bot. | Prerequisites: Overview | Topics: api, chat

        - [Markdown](/docs/api/markdown) | Type: Reference | Lastmod: 2026-07-01 | Summary: AST builder functions and utilities for programmatic message formatting. | Prerequisites: Overview | Topics: api, markdown

        - [Message](/docs/api/message) | Type: Reference | Lastmod: 2026-07-01 | Summary: Normalized message format with text, AST, author, and metadata. | Prerequisites: Overview | Topics: api, message

        - [Modals](/docs/api/modals) | Type: Reference | Lastmod: 2026-07-01 | Summary: Modal form components for collecting user input. | Prerequisites: Overview | Topics: api, modals

        - [PostableMessage](/docs/api/postable-message) | Type: Reference | Lastmod: 2026-07-01 | Summary: The union type accepted by thread.post() for sending messages. | Prerequisites: Overview | Topics: api, postable-message

        - [Thread](/docs/api/thread) | Type: Reference | Lastmod: 2026-07-01 | Summary: Represents a conversation thread with methods for posting, subscribing, and state management. | Prerequisites: Overview | Topics: api, thread

        - [Transcripts](/docs/api/transcripts) | Type: Reference | Lastmod: 2026-07-01 | Summary: Cross-platform per-user transcript persistence — configuration, methods, and entry shape. | Prerequisites: Overview | Topics: api, transcripts

    - [Cards](/docs/cards) | Type: Guide | Lastmod: 2026-07-01 | Summary: Send rich interactive cards with buttons, fields, and images across all platforms. | Prerequisites: /docs/usage | Topics: cards

    - [Overlapping Messages](/docs/concurrency) | Type: Guide | Lastmod: 2026-07-01 | Summary: Control how overlapping messages on the same thread are handled - burst, queue, debounce, drop, or process concurrently. | Prerequisites: /docs/handling-events | Topics: concurrency

    - [Conversation History](/docs/conversation-history) | Type: Guide | Lastmod: 2026-07-01 | Summary: Persist messages per user across every platform — for LLM context, audit, or compliance. | Prerequisites: /docs/state-adapters | Topics: conversation-history

    - [CLI](/docs/create-chat-sdk) | Type: Conceptual | Lastmod: 2026-07-01 | Summary: Scaffold a Chat SDK bot app with a single command. | Prerequisites: Introduction | Topics: create-chat-sdk

    - [Direct Messages](/docs/direct-messages) | Type: Guide | Lastmod: 2026-07-01 | Summary: Initiate DM conversations with users programmatically. | Prerequisites: /docs/usage | Topics: direct-messages

    - [Emoji](/docs/emoji) | Type: Reference | Lastmod: 2026-07-01 | Summary: Type-safe, cross-platform emoji that automatically convert to each platform's format. | Prerequisites: Introduction | Topics: emoji

    - [Ephemeral Messages](/docs/ephemeral-messages) | Type: Guide | Lastmod: 2026-07-01 | Summary: Send messages visible only to a specific user. | Prerequisites: /docs/usage | Topics: ephemeral-messages

    - [Error Handling](/docs/error-handling) | Type: Guide | Lastmod: 2026-07-01 | Summary: Handle rate limits, unsupported features, and other errors from adapters. | Prerequisites: /docs/usage | Topics: error-handling

    - [File Uploads](/docs/files) | Type: Guide | Lastmod: 2026-07-01 | Summary: Send and receive files across chat platforms. | Prerequisites: /docs/usage | Topics: files

    - [Getting Started](/docs/getting-started) | Type: Guide | Lastmod: 2026-07-01 | Summary: Pick a guide to start building with Chat SDK. | Prerequisites: Introduction | Topics: getting-started

    - [Handling Events](/docs/handling-events) | Type: Guide | Lastmod: 2026-07-01 | Summary: Register handlers for mentions, messages, reactions, member joins, and platform-specific events. | Prerequisites: /docs/getting-started | Topics: handling-events

    - [Modals](/docs/modals) | Type: Guide | Lastmod: 2026-07-01 | Summary: Collect structured user input through modal dialogs with text fields, dropdowns, and validation. | Prerequisites: /docs/actions | Topics: modals

    - [Platform Adapters](/docs/platform-adapters) | Type: Overview | Lastmod: 2026-07-01 | Summary: Platform-specific adapters that connect your bot to any messaging platform. | Prerequisites: /docs/getting-started, /docs/adapters | Topics: platform-adapters

    - [Posting Messages](/docs/posting-messages) | Type: Guide | Lastmod: 2026-07-01 | Summary: Different ways to render and send messages with thread.post(). | Prerequisites: /docs/usage | Topics: posting-messages

    - [Slack Low-Level APIs](/docs/slack-primitives) | Type: Guide | Lastmod: 2026-07-01 | Summary: Use Slack request verification, formatting, Web API, and Block Kit helpers without the full Chat runtime. | Prerequisites: /adapters/official/slack | Topics: slack-primitives

    - [Slash Commands](/docs/slash-commands) | Type: Guide | Lastmod: 2026-07-01 | Summary: Handle slash command invocations and respond with messages or modals. | Prerequisites: /docs/getting-started | Topics: slash-commands

    - [State Adapters](/docs/state-adapters) | Type: Overview | Lastmod: 2026-07-01 | Summary: Pluggable state adapters for thread subscriptions, distributed locking, and caching. | Prerequisites: /docs/getting-started | Topics: state-adapters

    - [Streaming](/docs/streaming) | Type: Guide | Lastmod: 2026-07-01 | Summary: Stream real-time text responses from AI models and other async sources to chat platforms. | Prerequisites: /docs/usage | Topics: streaming

    - [Message Subject](/docs/subject) | Type: Guide | Lastmod: 2026-07-01 | Summary: Fetch the parent resource that a message is about. | Prerequisites: /docs/handling-events | Topics: subject

    - [Teams Low-Level APIs](/docs/teams-primitives) | Type: Guide | Lastmod: 2026-07-01 | Summary: Use Teams Activity parsing, Bot Connector calls, Graph reads, formatting, Adaptive Cards, and Task Module helpers without the full Chat runtime. | Prerequisites: /adapters/official/teams | Topics: teams-primitives

    - [Testing](/docs/testing) | Type: Guide | Lastmod: 2026-07-01 | Summary: Test your bot handlers and custom adapters with @chat-adapter/tests — Vitest factories, custom matchers, and a setup file. | Prerequisites: /docs/getting-started | Topics: testing

    - [Threads, Messages, and Channels](/docs/threads-messages-channels) | Type: Guide | Lastmod: 2026-07-01 | Summary: Work with threads, messages, and channels across platforms. | Prerequisites: /docs/usage | Topics: threads-messages-channels

    - [Creating a Chat Instance](/docs/usage) | Type: Guide | Lastmod: 2026-07-01 | Summary: Initialize the Chat class with adapters, state, and configuration options. | Prerequisites: /docs/getting-started | Topics: usage

- [Building a community adapter](/docs/contributing/building) | Type: Guide | Lastmod: 2026-07-01 | Summary: Learn how to build, package, and publish your own Chat SDK adapter for any messaging platform. | Prerequisites: /docs/getting-started, /docs/adapters | Topics: contributing, building

- [Documenting your adapter](/docs/contributing/documenting) | Type: Guide | Lastmod: 2026-07-01 | Summary: Write a README, configuration reference, and usage examples for your community adapter. | Prerequisites: /docs/contributing/building, /docs/contributing/testing | Topics: contributing, documenting

- [Publishing your adapter](/docs/contributing/publishing) | Type: Guide | Lastmod: 2026-07-01 | Summary: Package, version, and publish your community Chat SDK adapter to npm. | Prerequisites: /docs/contributing/building, /docs/contributing/testing, /docs/contributing/documenting | Topics: contributing, publishing

- [Testing adapters](/docs/contributing/testing) | Type: Guide | Lastmod: 2026-07-01 | Summary: Write unit tests, integration tests, and replay tests for community Chat SDK adapters. | Prerequisites: /docs/contributing/building | Topics: contributing, testing
