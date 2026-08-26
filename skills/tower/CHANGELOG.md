# Changelog

## [3.2.3](https://github.com/zot24/skills/compare/tower-v3.2.2...tower-v3.2.3) (2026-08-26)


### Bug Fixes

* **tower:** document three unsound gate patterns ([#225](https://github.com/zot24/skills/issues/225)) ([6207601](https://github.com/zot24/skills/commit/62076016787dab6b172c300ca865a897e83bd924))
* **tower:** line-anchor EXPECT match at a token boundary ([#224](https://github.com/zot24/skills/issues/224)) ([74caaab](https://github.com/zot24/skills/commit/74caaab1e2f7e8f308e96992b577db107967f92c))


### Documentation

* **tower:** ship Can't-tell-is-not-dead liveness vocabulary ([#222](https://github.com/zot24/skills/issues/222)) ([a116ba4](https://github.com/zot24/skills/commit/a116ba4b3bd442a9b5efb34662727f167d670416))

## [3.2.2](https://github.com/zot24/skills/compare/tower-v3.2.1...tower-v3.2.2) (2026-08-25)


### Bug Fixes

* **tower:** resolve documented script paths against the plugin root ([#220](https://github.com/zot24/skills/issues/220)) ([d442c3a](https://github.com/zot24/skills/commit/d442c3acc392fd20014067cfe0c2b3e6785d8bcd))

## [3.2.1](https://github.com/zot24/skills/compare/tower-v3.2.0...tower-v3.2.1) (2026-08-25)


### Documentation

* **tower:** fusion-opinion and talk-to-owner patterns ([#218](https://github.com/zot24/skills/issues/218)) ([ae52367](https://github.com/zot24/skills/commit/ae523670ab9f4eb033644a9f32361ce127699ce7)), closes [#196](https://github.com/zot24/skills/issues/196)

## [3.2.0](https://github.com/zot24/skills/compare/tower-v3.1.1...tower-v3.2.0) (2026-08-25)


### Features

* **tower:** fold house leftovers and add auto-wiki ([#216](https://github.com/zot24/skills/issues/216)) ([45e7fe7](https://github.com/zot24/skills/commit/45e7fe776eb8c962e75628a2ce3d8635aa80dd63)), closes [#191](https://github.com/zot24/skills/issues/191)

## [3.1.1](https://github.com/zot24/skills/compare/tower-v3.1.0...tower-v3.1.1) (2026-08-24)


### Bug Fixes

* **tower:** cap SKILL.md description at 1024 ([#213](https://github.com/zot24/skills/issues/213)) ([9e60db8](https://github.com/zot24/skills/commit/9e60db85678838e760a5e8115c1bdd6fceb5d1e6))

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
