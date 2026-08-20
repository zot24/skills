---
name: pr-standard
description: House standard for GitHub pull request descriptions. Use when opening or editing a pull request, running gh pr create or gh pr edit, writing or rewriting a PR body, or setting labels on a PR. Triggers on mentions of PR description, pull request body, gh pr create, gh pr edit, PR template, PR labels, priority label, t-shirt label, area label, ASD-STE100, Simplified Technical English, PR diagram, mermaid in a PR.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
---

# pr-standard — house PR bodies

Every pull request carries a filled template, a diagram, and four labels. The prose follows
**ASD-STE100 (Simplified Technical English)**. This is a hard rule for humans and for agents.

## Overview

- **Six writing rules.** One idea per sentence. The same word for the same thing. Active voice.
  Imperative in steps. No filler. Exact technical names.
- **Fill the template.** A PR body has Summary, How It Works, Linked issues, Testing evidence, and
  Notes. Never replace it with one paragraph.
- **One diagram, always.** Embed a mermaid block that shows the mechanism this PR changes.
- **Four labels.** Type, `priority:*`, `t-shirt:*`, and `area:*`.
- **Write the body in a forked chat.** The conversation that wrote the code writes for itself.
- **Length is whatever the reviewer needs.** STE100 makes the text clear. It does not cap the length.

## Hard rule for agents

Do not run `gh pr create -b "<one paragraph>"`. Fill the template. Write the body to a file, then
pass the file:

```bash
gh pr create --title "feat(api): add phone to leads" --body-file /tmp/pr-body.md \
  --label enhancement --label priority:high --label t-shirt:small --label area:api
```

Use `gh pr edit <number> --body-file <file>` to correct a body that is already open.

## The six writing rules

| Rule | Do this | Not this |
|---|---|---|
| One idea per sentence | "The endpoint reads `lead_id`. It returns 404 when the row is absent." | "The endpoint reads `lead_id` and returns 404 when the row is absent, which also covers the deleted case." |
| Same word for the same thing | `client` everywhere | `client`, `customer`, `account` in one PR |
| Active voice | "The migration adds `core.leads.phone`." | "`core.leads.phone` is added by the migration." |
| Imperative in steps | "Run `pnpm test`." | "You will want to run `pnpm test`." |
| No filler | "The view needs a base-table grant." | "Basically the view just needs a base-table grant in order to work." |
| Exact technical names | `public.processes`, `service_instance_id` | "the processes view", "the instance id" |

Banned filler words: **basically, simply, just, actually, in order to, obviously, of course**.

Pick one noun per concept and hold it for the whole PR. Read the repo's `CLAUDE.md` for a project
noun list before you invent one.

## The four labels

Set all four on every PR. Read [labels](docs/labels.md) for the full table.

| Slot | Values |
|---|---|
| Type | `bug`, `enhancement`, or `documentation` |
| Priority | `priority:critical`, `priority:high`, or `priority:medium` |
| Size | `t-shirt:small`, `t-shirt:medium`, or `t-shirt:big` |
| Area | that repo's existing `area:*` labels |

**Area names are per repo.** Run `gh label list --limit 100` and pick from the result. Do not invent
an `area:*` label. When the repo carries no `area:*` label, set the other three and say so in the PR.

## Documentation

- **[Writing rules](docs/writing-rules.md)** — the six rules, banned words, worked rewrites
- **[Body template](docs/body-template.md)** — the section shape, plus a copy-paste skeleton
- **[Labels](docs/labels.md)** — the four-pack, discovery commands, and label creation
- **[Diagrams](docs/diagrams.md)** — which diagram a change needs, and the three mermaid traps
- **[Forked chat](docs/forked-chat.md)** — the five-step workflow that produces the body

## Common workflows

**Open a PR.** Finish the code. Fork the chat. Hand the fork the diff summary, the diagram text, and
the linked issues. The fork fills the template, checks the mermaid, and runs `gh pr create
--body-file`. Drop the fork.

**Fix a thin body.** Read the diff with `gh pr diff <number>`. Rewrite the body against the template.
Run `gh pr edit <number> --body-file <file>`.

**Label an existing PR.** Run `gh label list --limit 100`. Map the change to the four slots. Run
`gh pr edit <number> --add-label <label>`.

## Scope

- New pull requests follow this card.
- Old open pull requests are not rewritten for the standard alone.
- When you edit an old body for another reason, bring it up to the standard while you are there.

## Repo-local rules win

A repo can add rules on top of this card — a required ERD, a diagram index, a CI check, an agreed
noun list. Read its `CLAUDE.md` and `.github/pull_request_template.md` first. This card is the floor,
not the ceiling.
