# Changelog

## [1.1.0](https://github.com/zot24/skills/compare/1password-cli-v1.0.0...1password-cli-v1.1.0) (2026-07-07)


### Features

* add 1password-cli and portainerctl CLI skills ([#122](https://github.com/zot24/skills/issues/122)) ([61a50bb](https://github.com/zot24/skills/commit/61a50bbc66dab8829e0973e1a73df8104f9b530c))


### Bug Fixes

* **commands:** use ${CLAUDE_PLUGIN_ROOT} paths in all command files, correct CLAUDE.md ([62c0feb](https://github.com/zot24/skills/commit/62c0feb31364c1be05c7b42edb8f9751b9f3567c))
* repair sync script, rebuild agent-skills with official Anthropic docs, fix command paths, sync hygiene ([61449aa](https://github.com/zot24/skills/commit/61449aa775d0b59ce99ccd78a5fa2967f9d9b76d))

## 1.0.0

### Features

* **1password-cli:** initial skill — the 1Password CLI (`op` command) for managing 1Password from the terminal and securely loading secrets into scripts and CI
* **docs:** cache 21 upstream pages from 1password.dev/cli (get-started/auth, secret references, op run/inject, items, vaults, service accounts, Connect, shell plugins, SSH, and the command reference), mirroring the upstream URL structure
