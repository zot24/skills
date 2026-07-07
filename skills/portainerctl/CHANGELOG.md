# Changelog

## [1.1.0](https://github.com/zot24/skills/compare/portainerctl-v1.0.0...portainerctl-v1.1.0) (2026-07-07)


### Features

* add 1password-cli and portainerctl CLI skills ([#122](https://github.com/zot24/skills/issues/122)) ([61a50bb](https://github.com/zot24/skills/commit/61a50bbc66dab8829e0973e1a73df8104f9b530c))


### Bug Fixes

* **commands:** use ${CLAUDE_PLUGIN_ROOT} paths in all command files, correct CLAUDE.md ([62c0feb](https://github.com/zot24/skills/commit/62c0feb31364c1be05c7b42edb8f9751b9f3567c))
* repair sync script, rebuild agent-skills with official Anthropic docs, fix command paths, sync hygiene ([61449aa](https://github.com/zot24/skills/commit/61449aa775d0b59ce99ccd78a5fa2967f9d9b76d))

## 1.0.0

### Features

* **portainerctl:** initial skill — Portainer's official CLI for driving Portainer Business Edition over its REST API (environments, stacks, GitOps, containers, Kubernetes, edge, users/teams/RBAC, registries, backups, licensing, observability)
* **docs:** cache 10 upstream pages from github.com/portainer/portainerctl (branch `develop`) — the raw upstream README plus topical references (installation, configuration, environments, stacks, docker-resources, kubernetes, edge, users-teams-rbac, administration) curated from the README command reference and the `cmd/*.go` command definitions
