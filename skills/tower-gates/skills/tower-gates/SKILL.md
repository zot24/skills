---
name: tower-gates
description: Tower acceptance gates — a gates file of CHECK/EXPECT/EVIDENCE outcomes, verified by a vendored checker. Use when writing a spec, writing a completion marker, or verifying a delivered job. Triggers on GATES.md, gates file, gate table, gate-check, MARKER_OK, an empty touch marker, EVIDENCE pending, CHECK/EXPECT, acceptance criteria for an agent job, unlazy.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash
---

# tower-gates

Reuse **unlazy v2** enforcement. Do not rebuild it. Do not run unlazy **orchestrated** mode inside a
herdr fleet — the space PM owns dispatch.

Checker: `scripts/gate-check.mjs` (MIT, Leonxlnx). Format: `templates/gates.md`.

## Rule

Before dispatch, the spec names a gates file. Each gate is one observable outcome with `CHECK`,
`EXPECT`, and `EVIDENCE: pending`.

Done means `gate-check.mjs --status <gates>` exits **0**. An empty `touch` marker is not done. A
checked box with `EVIDENCE: pending` is unmet.

```bash
CHECKER="${CLAUDE_PLUGIN_ROOT}/skills/tower-gates/scripts/gate-check.mjs"

node "$CHECKER" gates/<name>.md             # run unmet checks, flip boxes, write evidence
node "$CHECKER" --status gates/<name>.md    # report only, change nothing
echo $?                                     # must be 0
```

The completion marker may be the gates file itself, or a short file that points at it and pastes
`ALL MET`. The tower re-runs `--status`. Exit 1 means the job is not done.

## Gate shape

```markdown
- [ ] G1: zot24/skills has an open PR for this work
  CHECK: gh pr list --repo zot24/skills --state open --json title --jq 'map(.title)|join(",")'
  EXPECT: tower-gates
  EVIDENCE: pending
```

`EXPECT` is a substring, or `/regex/flags`. With an `EXPECT`, the match decides and the exit code is
ignored — a check may exit non-zero by design. With no `EXPECT`, the exit code decides.

## Manual gates

When no command can prove an outcome, omit `CHECK`. Fill `EVIDENCE:` with a quote, a `file:line`, or
a URL. `pending` is still unmet.

## Abandon, honestly

A gate you decided not to meet is recorded, not deleted:

```markdown
ABANDON: G3 the upstream API has no endpoint for this
```

An abandoned gate does not block exit 0. It stays visible in the file and in the summary line.

## Do not

- Do not install unlazy's Stop hook. It fights a herdr idle/done signal.
- Do not run `npx skills add`.
- Do not depth-tree or fan out through unlazy subagents. herdr worktrees already do that.
- Do not let the implementer be the only one who ran the checker. The parent re-runs `--status`.
- Do not write a second checker. This one is vendored for that reason.

## Documentation

- **[Gate format](docs/gate-format.md)** — the file shape, `CHECK` / `EXPECT` / `EVIDENCE`, `ABANDON`, and how to write a gate that means something
- **[Checker reference](docs/checker.md)** — CLI flags, exit codes, matching, file discovery, timeouts
- **[Workflow](docs/workflow.md)** — spec names the gates, implementer fills them, parent re-runs `--status`
- **[Boundaries and attribution](docs/boundaries.md)** — what this skill takes from unlazy, what it refuses, and the licence

## Files

| Path | What it is |
|---|---|
| `scripts/gate-check.mjs` | The checker. Vendored from Leonxlnx/unlazy, MIT. Zero dependencies, Node 16+ |
| `templates/gates.md` | The starting shape for a new gates file |
| `LICENSE.unlazy` | The upstream MIT licence. The header of `gate-check.mjs` points at it |

## Upstream

`scripts/gate-check.mjs` comes from
[Leonxlnx/unlazy](https://github.com/Leonxlnx/unlazy/blob/main/scripts/gate-check.mjs) under MIT.
Keep the four-line attribution header and `LICENSE.unlazy` together with the file. Re-vendor by hand.
Read [boundaries](docs/boundaries.md) before you change the checker.
