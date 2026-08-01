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

## Docs

- [Introduction](/docs) | Type: Overview | Lastmod: 2026-07-31 | Summary: A unified SDK for building chat bots across Slack, Microsoft Teams, Google Chat, Discord, Telegram, and more.

    - [Actions](/docs/actions) | Type: Guide | Lastmod: 2026-07-31 | Summary: Handle button clicks and interactive card events across platforms. | Prerequisites: /docs/cards | Topics: actions

    - [Overview](/docs/adapters) | Type: Overview | Lastmod: 2026-07-31 | Summary: Overview of Chat SDK adapters and the static adapter catalog. | Prerequisites: /docs/getting-started | Topics: adapters

    - [Overview](/docs/ai) | Type: Overview | Lastmod: 2026-07-31 | Summary: AI utilities that ship with Chat SDK — agent tools, message conversion, and supporting types. | Prerequisites: /docs | Topics: ai

        - [AI SDK Tools](/docs/ai/ai-sdk-tools) | Type: Guide | Lastmod: 2026-07-31 | Summary: Give an AI agent the ability to operate inside your workspace. Post messages, send DMs, react, edit, delete; all with built-in approval gates. | Prerequisites: /docs/usage | Topics: ai, ai-sdk-tools

        - [toAiMessages](/docs/ai/to-ai-messages) | Type: Reference | Lastmod: 2026-07-31 | Summary: Convert Chat SDK messages to AI SDK conversation format. | Prerequisites: /docs/ai | Topics: ai, to-ai-messages

        - [Types](/docs/ai/types) | Type: Reference | Lastmod: 2026-07-31 | Summary: TypeScript types exported from the chat/ai subpath. | Prerequisites: /docs/ai | Topics: ai, types

    - [Overview](/docs/api) | Type: Overview | Lastmod: 2026-07-31 | Summary: API reference for the Chat SDK core package. | Prerequisites: /docs | Topics: api

        - [Cards](/docs/api/cards) | Type: Reference | Lastmod: 2026-07-31 | Summary: Rich card components for cross-platform interactive messages. | Prerequisites: /docs/api | Topics: api, cards

        - [Channel](/docs/api/channel) | Type: Reference | Lastmod: 2026-07-31 | Summary: Channel container that holds threads, with methods for listing, posting, and iteration. | Prerequisites: /docs/api | Topics: api, channel

        - [Chat](/docs/api/chat) | Type: Reference | Lastmod: 2026-07-31 | Summary: The main entry point for creating a multi-platform chat bot. | Prerequisites: /docs/api | Topics: api, chat

        - [Markdown](/docs/api/markdown) | Type: Reference | Lastmod: 2026-07-31 | Summary: AST builder functions and utilities for programmatic message formatting. | Prerequisites: /docs/api | Topics: api, markdown

        - [Message](/docs/api/message) | Type: Reference | Lastmod: 2026-07-31 | Summary: Normalized message format with text, AST, author, and metadata. | Prerequisites: /docs/api | Topics: api, message

        - [Modals](/docs/api/modals) | Type: Reference | Lastmod: 2026-07-31 | Summary: Modal form components for collecting user input. | Prerequisites: /docs/api | Topics: api, modals

        - [PostableMessage](/docs/api/postable-message) | Type: Reference | Lastmod: 2026-07-31 | Summary: The union type accepted by thread.post() for sending messages. | Prerequisites: /docs/api | Topics: api, postable-message

        - [Thread](/docs/api/thread) | Type: Reference | Lastmod: 2026-07-31 | Summary: Represents a conversation thread with methods for posting, subscribing, and state management. | Prerequisites: /docs/api | Topics: api, thread

        - [Transcripts](/docs/api/transcripts) | Type: Reference | Lastmod: 2026-07-31 | Summary: Cross-platform per-user transcript persistence — configuration, methods, and entry shape. | Prerequisites: /docs/api | Topics: api, transcripts

    - [Approvals](/docs/approvals) | Type: Guide | Lastmod: 2026-07-31 | Summary: Pause a durable workflow until a human approves it in chat. | Prerequisites: /docs/cards, /docs/actions | Topics: approvals

    - [Cards](/docs/cards) | Type: Guide | Lastmod: 2026-07-31 | Summary: Send rich interactive cards with buttons, fields, and images across all platforms. | Prerequisites: /docs/usage | Topics: cards

    - [Overlapping Messages](/docs/concurrency) | Type: Guide | Lastmod: 2026-07-31 | Summary: Control how overlapping messages on the same thread are handled - burst, queue, debounce, drop, or process concurrently. | Prerequisites: /docs/handling-events | Topics: concurrency

    - [Conversation History](/docs/conversation-history) | Type: Guide | Lastmod: 2026-07-31 | Summary: Persist messages per user across every platform — for LLM context, audit, or compliance. | Prerequisites: /docs/state-adapters | Topics: conversation-history

    - [CLI](/docs/create-chat-sdk) | Type: Conceptual | Lastmod: 2026-07-31 | Summary: Scaffold a Chat SDK bot app with a single command. | Prerequisites: /docs | Topics: create-chat-sdk

    - [Direct Messages](/docs/direct-messages) | Type: Guide | Lastmod: 2026-07-31 | Summary: Initiate DM conversations with users programmatically. | Prerequisites: /docs/usage | Topics: direct-messages

    - [Emoji](/docs/emoji) | Type: Reference | Lastmod: 2026-07-31 | Summary: Type-safe, cross-platform emoji that automatically convert to each platform's format. | Prerequisites: /docs | Topics: emoji

    - [Ephemeral Messages](/docs/ephemeral-messages) | Type: Guide | Lastmod: 2026-07-31 | Summary: Send messages visible only to a specific user. | Prerequisites: /docs/usage | Topics: ephemeral-messages

    - [Error Handling](/docs/error-handling) | Type: Guide | Lastmod: 2026-07-31 | Summary: Handle rate limits, unsupported features, and other errors from adapters. | Prerequisites: /docs/usage | Topics: error-handling

    - [File Uploads](/docs/files) | Type: Guide | Lastmod: 2026-07-31 | Summary: Send and receive files across chat platforms. | Prerequisites: /docs/usage | Topics: files

    - [Getting Started](/docs/getting-started) | Type: Guide | Lastmod: 2026-07-31 | Summary: Pick a guide to start building with Chat SDK. | Prerequisites: /docs | Topics: getting-started

    - [Handling Events](/docs/handling-events) | Type: Guide | Lastmod: 2026-07-31 | Summary: Register handlers for mentions, messages, reactions, member joins, and platform-specific events. | Prerequisites: /docs/getting-started | Topics: handling-events

    - [Modals](/docs/modals) | Type: Guide | Lastmod: 2026-07-31 | Summary: Collect structured user input through modal dialogs with text fields, dropdowns, and validation. | Prerequisites: /docs/actions | Topics: modals

    - [Platform Adapters](/docs/platform-adapters) | Type: Overview | Lastmod: 2026-07-31 | Summary: Platform-specific adapters that connect your bot to any messaging platform. | Prerequisites: /docs/getting-started, /docs/adapters | Topics: platform-adapters

    - [Posting Messages](/docs/posting-messages) | Type: Guide | Lastmod: 2026-07-31 | Summary: Different ways to render and send messages with thread.post(). | Prerequisites: /docs/usage | Topics: posting-messages

    - [Slack Low-Level APIs](/docs/slack-primitives) | Type: Guide | Lastmod: 2026-07-31 | Summary: Use Slack request verification, formatting, Web API, and Block Kit helpers without the full Chat runtime. | Prerequisites: /adapters/official/slack | Topics: slack-primitives

    - [Slash Commands](/docs/slash-commands) | Type: Guide | Lastmod: 2026-07-31 | Summary: Handle slash command invocations and respond with messages or modals. | Prerequisites: /docs/getting-started | Topics: slash-commands

    - [State Adapters](/docs/state-adapters) | Type: Overview | Lastmod: 2026-07-31 | Summary: Pluggable state adapters for thread subscriptions, distributed locking, and caching. | Prerequisites: /docs/getting-started | Topics: state-adapters

    - [Streaming](/docs/streaming) | Type: Guide | Lastmod: 2026-07-31 | Summary: Stream real-time text responses from AI models and other async sources to chat platforms. | Prerequisites: /docs/usage | Topics: streaming

    - [Message Subject](/docs/subject) | Type: Guide | Lastmod: 2026-07-31 | Summary: Fetch the parent resource that a message is about. | Prerequisites: /docs/handling-events | Topics: subject

    - [Teams Low-Level APIs](/docs/teams-primitives) | Type: Guide | Lastmod: 2026-07-31 | Summary: Use Teams Activity parsing, Bot Connector calls, Graph reads, formatting, Adaptive Cards, and Task Module helpers without the full Chat runtime. | Prerequisites: /adapters/official/teams | Topics: teams-primitives

    - [Testing](/docs/testing) | Type: Guide | Lastmod: 2026-07-31 | Summary: Test your bot handlers and custom adapters with @chat-adapter/tests — Vitest factories, custom matchers, and a setup file. | Prerequisites: /docs/getting-started | Topics: testing

    - [Threads, Messages, and Channels](/docs/threads-messages-channels) | Type: Guide | Lastmod: 2026-07-31 | Summary: Work with threads, messages, and channels across platforms. | Prerequisites: /docs/usage | Topics: threads-messages-channels

    - [Creating a Chat Instance](/docs/usage) | Type: Guide | Lastmod: 2026-07-31 | Summary: Initialize the Chat class with adapters, state, and configuration options. | Prerequisites: /docs/getting-started | Topics: usage

    - [Vercel Connect](/docs/vercel-connect) | Type: Overview | Lastmod: 2026-07-31 | Summary: Authenticate Slack, GitHub, and Linear adapters with Vercel Connect — short-lived runtime tokens for outbound calls and OIDC-verified inbound webhooks, with no stored provider secrets. | Prerequisites: /docs | Topics: vercel-connect

- [Building a community adapter](/docs/contributing/building) | Type: Guide | Lastmod: 2026-07-31 | Summary: Learn how to build, package, and publish your own Chat SDK adapter for any messaging platform. | Prerequisites: /docs/getting-started, /docs/adapters | Topics: contributing, building

- [Documenting your adapter](/docs/contributing/documenting) | Type: Guide | Lastmod: 2026-07-31 | Summary: Write a README, configuration reference, and usage examples for your community adapter. | Prerequisites: /docs/contributing/building, /docs/contributing/testing | Topics: contributing, documenting

- [Publishing your adapter](/docs/contributing/publishing) | Type: Guide | Lastmod: 2026-07-31 | Summary: Package, version, and publish your community Chat SDK adapter to npm. | Prerequisites: /docs/contributing/building, /docs/contributing/testing, /docs/contributing/documenting | Topics: contributing, publishing

- [Testing adapters](/docs/contributing/testing) | Type: Guide | Lastmod: 2026-07-31 | Summary: Write unit tests, integration tests, and replay tests for community Chat SDK adapters. | Prerequisites: /docs/contributing/building | Topics: contributing, testing

## Adapters

- [Baileys (WhatsApp)](/adapters/community/baileys) | Type: Platform | Lastmod: 2026-07-31 | Summary: Community WhatsApp adapter for Chat SDK using Baileys, the unofficial WhatsApp Web API. Self-hosted via WebSocket, with QR / pairing-code auth, multi-account support, and WhatsApp-specific extensions. | Topics: adapters, community, baileys

- [Blooio](/adapters/community/blooio) | Type: Platform | Lastmod: 2026-07-31 | Summary: Community Blooio adapter for Chat SDK. Send and receive iMessage, RCS, and SMS through Blooio's hosted gateway. | Topics: adapters, community, blooio

- [Cloudflare Durable Objects](/adapters/community/cloudflare-do) | Type: State | Lastmod: 2026-07-31 | Summary: Community state adapter for Chat SDK backed by a SQLite-powered Cloudflare Durable Object. Persistent subscriptions, distributed locking, queues, lists, and caching with zero external dependencies. | Topics: adapters, community, cloudflare-do

- [Mattermost](/adapters/community/mattermost) | Type: Platform | Lastmod: 2026-07-31 | Summary: Community Mattermost adapter for Chat SDK with support for posts, edits, reactions, ephemeral messages, typing indicators, file uploads, and interactive actions. | Topics: adapters, community, mattermost

- [MySQL](/adapters/community/mysql) | Type: State | Lastmod: 2026-07-31 | Summary: Community MySQL state adapter for Chat SDK built on mysql2. Persistence, distributed locking, caching, lists, and queues without a separate Redis dependency. | Topics: adapters, community, mysql

- [QQ Bot](/adapters/community/qq) | Type: Platform | Lastmod: 2026-07-31 | Summary: Community QQ Bot adapter for Chat SDK with WebSocket and webhook modes, multi-scene support (DM, group, text channel), rich media, and Ed25519 signature verification. | Topics: adapters, community, qq

- [Webex](/adapters/community/webex) | Type: Platform | Lastmod: 2026-07-31 | Summary: Community Webex adapter for Chat SDK with support for spaces, threads, adaptive cards, and modals. | Topics: adapters, community, webex

- [WeCom](/adapters/community/wecom) | Type: Platform | Lastmod: 2026-07-31 | Summary: Community WeCom (企业微信) adapter for Chat SDK covering group webhook bots, smart bots, and apps, with template cards, rich media, and AES-256-CBC encryption. | Topics: adapters, community, wecom

- [Weixin](/adapters/community/weixin) | Type: Platform | Lastmod: 2026-07-31 | Summary: Community Weixin (WeChat) iLink bot adapter for Chat SDK with long polling, QR login, media, and typing indicators. | Topics: adapters, community, weixin

- [Zaileys (WhatsApp)](/adapters/community/zaileys) | Type: Platform | Lastmod: 2026-07-31 | Summary: Community WhatsApp adapter for Chat SDK powered by Zaileys, a batteries-included wrapper around the unofficial WhatsApp Web API. Self-hosted via WebSocket with QR / pairing-code auth, real message history, native buttons from Cards, decrypted poll votes, and scheduled messages. | Topics: adapters, community, zaileys

- [Zalo](/adapters/community/zalo) | Type: Platform | Lastmod: 2026-07-31 | Summary: Community Zalo Bot adapter for Chat SDK using the Zalo Bot Platform API. | Topics: adapters, community, zalo

- [Discord](/adapters/official/discord) | Type: Platform | Lastmod: 2026-07-31 | Summary: Discord adapter with HTTP Interactions and Gateway WebSocket support. | Topics: adapters, official, discord

- [Google Chat](/adapters/official/gchat) | Type: Platform | Lastmod: 2026-07-31 | Summary: Google Chat adapter with service account auth and optional Pub/Sub. | Topics: adapters, official, gchat

- [GitHub](/adapters/official/github) | Type: Platform | Lastmod: 2026-07-31 | Summary: Respond to @mentions in PR and issue comment threads. | Topics: adapters, official, github

- [ioredis](/adapters/official/ioredis) | Type: State | Lastmod: 2026-07-31 | Summary: Redis state adapter using ioredis with Cluster and Sentinel support. | Topics: adapters, official, ioredis

- [Linear](/adapters/official/linear) | Type: Platform | Lastmod: 2026-07-31 | Summary: Respond to @mentions in Linear issue comment threads and agent sessions. | Topics: adapters, official, linear

- [Memory](/adapters/official/memory) | Type: State | Lastmod: 2026-07-31 | Summary: In-memory state adapter for development and testing. | Topics: adapters, official, memory

- [Messenger](/adapters/official/messenger) | Type: Platform | Lastmod: 2026-07-31 | Summary: Facebook Messenger adapter using the Messenger Platform API. | Topics: adapters, official, messenger

- [PostgreSQL](/adapters/official/postgres) | Type: State | Lastmod: 2026-07-31 | Summary: Production state adapter using PostgreSQL via node-postgres. | Topics: adapters, official, postgres

- [Redis](/adapters/official/redis) | Type: State | Lastmod: 2026-07-31 | Summary: Production state adapter using the official `redis` package. | Topics: adapters, official, redis

- [Slack](/adapters/official/slack) | Type: Platform | Lastmod: 2026-07-31 | Summary: Slack adapter with single-workspace and multi-workspace OAuth support. | Topics: adapters, official, slack

- [Microsoft Teams](/adapters/official/teams) | Type: Platform | Lastmod: 2026-07-31 | Summary: Microsoft Teams adapter with Adaptive Cards and modal support. | Topics: adapters, official, teams

- [Telegram](/adapters/official/telegram) | Type: Platform | Lastmod: 2026-07-31 | Summary: Telegram adapter for Chat SDK with webhook and polling modes. | Topics: adapters, official, telegram

- [Twilio](/adapters/official/twilio) | Type: Platform | Lastmod: 2026-07-31 | Summary: Twilio SMS and MMS adapter for Chat SDK. | Topics: adapters, official, twilio

- [Web](/adapters/official/web) | Type: Platform | Lastmod: 2026-07-31 | Summary: Web chat adapter that speaks the AI SDK useChat protocol. | Topics: adapters, official, web

- [WhatsApp Business Cloud](/adapters/official/whatsapp) | Type: Platform | Lastmod: 2026-07-31 | Summary: WhatsApp Business Cloud adapter for Chat SDK. | Topics: adapters, official, whatsapp

- [X](/adapters/official/x) | Type: Platform | Lastmod: 2026-07-31 | Summary: X (Twitter) adapter using the X API v2 and the X Activity API. | Topics: adapters, official, x

- [XChat](/adapters/official/xchat) | Type: Platform | Lastmod: 2026-07-31 | Summary: XChat (encrypted messaging) adapter using the X API v2 chat endpoints and the X Activity API. | Topics: adapters, official, xchat

- [AgentPhone](/adapters/vendor-official/agentphone) | Type: Platform | Lastmod: 2026-07-31 | Summary: Unified SMS, MMS, iMessage, and voice adapter for Chat SDK. Send and receive messages across all channels with a single integration. | Topics: adapters, vendor-official, agentphone

- [Cloudflare Agents](/adapters/vendor-official/cloudflare-agents) | Type: State | Lastmod: 2026-07-31 | Summary: Vendor-official state adapter for Chat SDK backed by Cloudflare Agents. Stores subscriptions, locks, queues, dedupe keys, thread and channel state, transcripts, and message history in Durable Object SQLite via ChatSdkStateAgent sub-agents. | Topics: adapters, vendor-official, cloudflare-agents

- [Dial](/adapters/vendor-official/dial) | Type: Platform | Lastmod: 2026-07-31 | Summary: SMS, MMS, iMessage, and inbound voice-call transcripts for Chat SDK, built and maintained by Dial. One handler answers phone traffic the same way it answers Slack/Teams/Discord — signed webhooks, thread-per-phone-pair, replies over @getdial/sdk. | Topics: adapters, vendor-official, dial

- [Kapso](/adapters/vendor-official/kapso) | Type: Platform | Lastmod: 2026-07-31 | Summary: Kapso-first WhatsApp adapter for Chat SDK. Receive Kapso platform webhooks, reply through Chat SDK threads, send cards/buttons and media, and fetch Kapso conversation history. | Topics: adapters, vendor-official, kapso

- [Lark / Feishu](/adapters/vendor-official/lark) | Type: Platform | Lastmod: 2026-07-31 | Summary: Chat SDK adapter for Lark / Feishu. WebSocket long-connection event subscription, native cardkit typewriter streaming, interactive cards, and reactions. | Topics: adapters, vendor-official, lark

- [Linq](/adapters/vendor-official/linq) | Type: Platform | Lastmod: 2026-07-31 | Summary: iMessage and SMS adapter for Chat SDK, built and maintained by Linq. Send and receive texts, media, and tapback reactions over Apple Messages and SMS, with HMAC-verified webhooks and stable threading. | Topics: adapters, vendor-official, linq

- [Liveblocks](/adapters/vendor-official/liveblocks) | Type: Platform | Lastmod: 2026-07-31 | Summary: Chat SDK adapter backed by Liveblocks Comments. Build bots that read and post in Liveblocks comment threads using the Chat SDK Channel/Thread/Message model. | Topics: adapters, vendor-official, liveblocks

- [Beeper Matrix](/adapters/vendor-official/matrix) | Type: Platform | Lastmod: 2026-07-31 | Summary: Matrix adapter for Chat SDK that runs over Matrix sync, with first-class support for E2EE, Beeper conversations, and bridged networks like WhatsApp, Telegram, Instagram, and Signal. | Topics: adapters, vendor-official, matrix

- [Novu](/adapters/vendor-official/novu) | Type: Platform | Lastmod: 2026-07-31 | Summary: Multi-channel adapter for Chat SDK backed by Novu. Put your agent in front of customers on Slack, Microsoft Teams, WhatsApp, Telegram, and email with one handler set, while Novu manages credentials, identity, and delivery. | Topics: adapters, vendor-official, novu

- [Photon](/adapters/vendor-official/photon) | Type: Platform | Lastmod: 2026-07-31 | Summary: iMessage adapter for Chat SDK, built and maintained by Photon. Cloud, self-hosted, and on-device (local, macOS) iMessage over spectrum-ts, with HMAC-signed webhooks, tapback reactions, and DM sends that work from a cold webhook delivery. | Topics: adapters, vendor-official, photon

- [Resend](/adapters/vendor-official/resend) | Type: Platform | Lastmod: 2026-07-31 | Summary: Bidirectional email adapter for Chat SDK. Receive emails via Resend webhooks and send rich HTML emails via the Resend API. | Topics: adapters, vendor-official, resend

- [Sendblue](/adapters/vendor-official/sendblue) | Type: Platform | Lastmod: 2026-07-31 | Summary: Sendblue adapter for Chat SDK. Send and receive iMessage, SMS, and RCS through Sendblue's hosted gateway. | Topics: adapters, vendor-official, sendblue

- [Velt](/adapters/vendor-official/velt) | Type: Platform | Lastmod: 2026-07-31 | Summary: Chat SDK adapter backed by Velt Comments. Build bots that read, reply, mention, and start threads in anchored comments across documents, rich-text editors, canvases, PDFs, and video. Includes per-comment document context and a streaming AI reply flow. | Topics: adapters, vendor-official, velt

- [Zernio](/adapters/vendor-official/zernio) | Type: Platform | Lastmod: 2026-07-31 | Summary: Multi-platform messaging adapter for Chat SDK. Build chatbots that work across Instagram, Facebook, Twitter/X, Telegram, WhatsApp, Bluesky, and Reddit through a single integration. | Topics: adapters, vendor-official, zernio
