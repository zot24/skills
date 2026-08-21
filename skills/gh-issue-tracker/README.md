# gh-issue-tracker skill

Claude Code plugin for [gh-issue-tracker](https://github.com/zot24/gh-issue-tracker) — lightweight error tracking that creates GitHub Issues.

## What it does

- Guided setup for any framework (Next.js, Express, generic Node.js)
- Architecture decisions (server-only vs client+server)
- Security recommendations and proxy patterns
- Verification and troubleshooting
- Issue triage and management workflows

## Install

From inside Claude Code:

```
/plugin marketplace add zot24/skills
/plugin install gh-issue-tracker@zot24-skills
```

`zot24/skills` is the repository. `zot24-skills` is the marketplace name declared in
`.claude-plugin/marketplace.json`, and that is what `/plugin install` expects after the `@`.

## Commands

| Command | Description |
|---------|-------------|
| `/gh-issue-tracker` | Guided setup: detect framework, install package, configure env vars |
| `/verify-error-tracking` | Verify setup: check token, trigger test error, confirm deduplication |

## Skills

| Skill | Triggers |
|-------|----------|
| `gh-issue-tracker` | "add error tracking", "install error tracker", "setup error monitoring" |
