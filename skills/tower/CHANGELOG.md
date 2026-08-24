# Changelog

## [3.1.0](https://github.com/zot24/skills/compare/tower-v3.0.0...tower-v3.1.0) (2026-08-24)


### Features

* **tower:** add escalate and handoff pointers; worktree default seat ([#208](https://github.com/zot24/skills/issues/208)) ([3749d56](https://github.com/zot24/skills/commit/3749d5609783823f69f46772a4cb9773cdbf3212))

## [3.0.0](https://github.com/zot24/skills/compare/tower-v2.0.0...tower-v3.0.0) (2026-08-24)


### ⚠ BREAKING CHANGES

* the herdr-tower and tower-gates plugins are removed and replaced by the single tower plugin (commands: /tower with dispatch, spec, watch, verify, staff, close, gates new|run|status|verify).

### Features

* merge herdr-tower + tower-gates into one tower skill ([#200](https://github.com/zot24/skills/issues/200)) ([a971078](https://github.com/zot24/skills/commit/a971078b100aac1abe36627f33b7d8bcc0342583))
* **tower:** fold daily-os session loop and plane/spec rules ([#205](https://github.com/zot24/skills/issues/205)) ([ef6138e](https://github.com/zot24/skills/commit/ef6138e88e8aa1b93c421aff8d5fc4a221067c3c))

## [2.0.0](https://github.com/zot24/skills) (2026-08-23)

### Features

* merge herdr-tower (protocol) and tower-gates (acceptance gates) into one `tower` skill
