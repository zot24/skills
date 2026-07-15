# Changelog

## [2.0.2](https://github.com/zot24/skills/compare/chat-sdk-v2.0.1...chat-sdk-v2.0.2) (2026-07-15)


### Bug Fixes

* **docs:** sync documentation from upstream ([#139](https://github.com/zot24/skills/issues/139)) ([28e3f8c](https://github.com/zot24/skills/commit/28e3f8c6b0b1eff1db6a61f3ca9500cfde3c7aa1))

## [2.0.1](https://github.com/zot24/skills/compare/chat-sdk-v2.0.0...chat-sdk-v2.0.1) (2026-07-07)


### Bug Fixes

* **ci:** fence-aware MDX stripping in doc extractor; tolerate marketplace version lag in Validate ([e24d5eb](https://github.com/zot24/skills/commit/e24d5eb83a2baac7d6dd273b5fccee29b9e78f73))
* **ci:** strip Fumadocs MDX components in extract_content; re-sync chat-sdk docs ([a1b6f2f](https://github.com/zot24/skills/commit/a1b6f2fe2ff55d290c13239f49cfad023c5c3343))

## [2.0.0](https://github.com/zot24/skills/compare/chat-sdk-v1.1.5...chat-sdk-v2.0.0) (2026-07-07)


### ⚠ BREAKING CHANGES

* **chat-sdk:** chat-sdk.dev now hosts vercel/chat (unified TypeScript SDK for Slack/Teams/Discord/Telegram bots), not the AI Chatbot template. All docs, sources, and skill metadata now target the new product.

### Features

* **chat-sdk:** repurpose skill for the new multi-platform Chat SDK (vercel/chat) ([c640583](https://github.com/zot24/skills/commit/c6405832121f9a192481694eec32ff37a07e5da5))


### Bug Fixes

* **chat-sdk:** drop remaining wrong-product source, add discovery guard ([372f00d](https://github.com/zot24/skills/commit/372f00db627e9b12d1152575d6cf244ff40480db))
* **chat-sdk:** freeze docs for 6 dead sources after chat-sdk.dev domain repurposing ([8096482](https://github.com/zot24/skills/commit/8096482f1ed15c4c3ad008857b9b911dd71ddd59))
* repair 36 broken sources, harden workflows, consolidate versioning, repurpose chat-sdk for vercel/chat ([9f337ca](https://github.com/zot24/skills/commit/9f337ca8ffc4257a3dc949b8a0b47c3149f615f2))

## [1.1.5](https://github.com/zot24/skills/compare/chat-sdk-v1.1.4...chat-sdk-v1.1.5) (2026-07-07)


### Bug Fixes

* **commands:** use ${CLAUDE_PLUGIN_ROOT} paths in all command files, correct CLAUDE.md ([62c0feb](https://github.com/zot24/skills/commit/62c0feb31364c1be05c7b42edb8f9751b9f3567c))
* repair sync script, rebuild agent-skills with official Anthropic docs, fix command paths, sync hygiene ([61449aa](https://github.com/zot24/skills/commit/61449aa775d0b59ce99ccd78a5fa2967f9d9b76d))

## [1.1.4](https://github.com/zot24/skills/compare/chat-sdk-v1.1.3...chat-sdk-v1.1.4) (2026-06-15)


### Bug Fixes

* **docs:** sync documentation from upstream ([#116](https://github.com/zot24/skills/issues/116)) ([7406297](https://github.com/zot24/skills/commit/74062978533caba6a87c9738c0e95525d796bafa))

## [1.1.3](https://github.com/zot24/skills/compare/chat-sdk-v1.1.2...chat-sdk-v1.1.3) (2026-05-24)


### Bug Fixes

* **docs:** sync documentation from upstream ([#104](https://github.com/zot24/skills/issues/104)) ([b00738d](https://github.com/zot24/skills/commit/b00738d44dd66c7e47fe1e092c9067d16b39ad4e))

## [1.1.2](https://github.com/zot24/skills/compare/chat-sdk-v1.1.1...chat-sdk-v1.1.2) (2026-05-15)


### Bug Fixes

* **docs:** sync documentation from upstream ([#96](https://github.com/zot24/skills/issues/96)) ([15c2a56](https://github.com/zot24/skills/commit/15c2a56570865f768711746554a891ef800f7bc0))
