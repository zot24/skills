# Changelog

## [1.1.0](https://github.com/zot24/skills/compare/flue-v1.0.0...flue-v1.1.0) (2026-07-07)


### Features

* **flue:** add Flue open agent framework skill ([#118](https://github.com/zot24/skills/issues/118)) ([074c9f7](https://github.com/zot24/skills/commit/074c9f75aba77ad639184a5a79c054b060f3a722))


### Bug Fixes

* **commands:** use ${CLAUDE_PLUGIN_ROOT} paths in all command files, correct CLAUDE.md ([62c0feb](https://github.com/zot24/skills/commit/62c0feb31364c1be05c7b42edb8f9751b9f3567c))
* **flue:** repair broken upstream sources after site restructure ([3bc3484](https://github.com/zot24/skills/commit/3bc34842706379203124c221e91d9394c418629c))
* repair 36 broken sources, harden workflows, consolidate versioning, repurpose chat-sdk for vercel/chat ([9f337ca](https://github.com/zot24/skills/commit/9f337ca8ffc4257a3dc949b8a0b47c3149f615f2))
* repair sync script, rebuild agent-skills with official Anthropic docs, fix command paths, sync hygiene ([61449aa](https://github.com/zot24/skills/commit/61449aa775d0b59ce99ccd78a5fa2967f9d9b76d))

## 1.0.0

### Features

* **flue:** initial skill — Flue open agent framework (durable AI agents & workflows on the Pi harness)
* **docs:** cache 110 upstream pages from flueframework.com (concepts, guides, CLI, SDK, API reference, and the deploy/channel/sandbox/database/tooling ecosystem), mirroring the upstream URL structure
