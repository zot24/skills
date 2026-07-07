# Changelog

## [2.1.1](https://github.com/zot24/skills/compare/umbrel-app-v2.1.0...umbrel-app-v2.1.1) (2026-07-07)


### Bug Fixes

* **commands:** use ${CLAUDE_PLUGIN_ROOT} paths in all command files, correct CLAUDE.md ([62c0feb](https://github.com/zot24/skills/commit/62c0feb31364c1be05c7b42edb8f9751b9f3567c))
* repair sync script, rebuild agent-skills with official Anthropic docs, fix command paths, sync hygiene ([61449aa](https://github.com/zot24/skills/commit/61449aa775d0b59ce99ccd78a5fa2967f9d9b76d))

## [2.0.0](https://github.com/zot24/skills/compare/umbrel-app-v1.3.0...umbrel-app-v2.0.0) (2026-01-16)


### ⚠ BREAKING CHANGES

* Repository renamed from zot24/claude-plugins to zot24/skills. Update your marketplace commands:   /plugin marketplace add zot24/skills   /plugin install <skill>@zot24-skills

### refactor

* rename repository from claude-plugins to skills ([a29abcc](https://github.com/zot24/skills/commit/a29abccc4168211988feaf2c4f8405d9eda58217))

## [1.3.0](https://github.com/zot24/claude-plugins/compare/umbrel-app-v1.2.0...umbrel-app-v1.3.0) (2026-01-15)


### Features

* **agent-browser:** add plugin with progressive disclosure pattern ([#6](https://github.com/zot24/claude-plugins/issues/6)) ([e3c8d41](https://github.com/zot24/claude-plugins/commit/e3c8d416c01998ead8f68909182530b6f72222ac))
