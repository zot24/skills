# tower-gates Skill

Acceptance gates for agent work. A gates file lists observable outcomes. A vendored, zero-dependency
checker runs them, flips the boxes, and writes the evidence back. "Done" becomes an exit code.

```
node gate-check.mjs --status gates/2026-08-20-job.md ; echo $?
```

`0` accepts. `1` sends the job back and names the gate.

## What This Skill Covers

- **The gate format** — `- [ ] G1: outcome` with `CHECK`, `EXPECT`, and `EVIDENCE: pending`, plus
  manual gates and honest `ABANDON:` lines
- **The checker** — run mode versus `--status`, exit codes, substring and `/regex/` matching,
  per-check timeouts, what lands in `EVIDENCE`
- **The workflow** — the spec names the gates file, the implementer fills it, the marker carries the
  output, and the parent re-runs `--status`
- **The refusals** — no Stop hook, no orchestrated mode, no subagent fan-out, no second checker
- **Attribution** — the MIT header and `LICENSE.unlazy` travel with the vendored file

## Usage

```
/tower-gates:tower-gates help                 # Show available commands
/tower-gates:tower-gates new gates/job.md     # Start a gates file from the template
/tower-gates:tower-gates run gates/job.md     # Run unmet checks, write evidence
/tower-gates:tower-gates status gates/job.md  # Report only, change nothing
/tower-gates:tower-gates verify gates/job.md  # Parent-side acceptance
/tower-gates:tower-gates marker gates/job.md  # Write a marker that carries the output
/tower-gates:tower-gates format               # The gate file shape
/tower-gates:tower-gates checker              # Flags, exit codes, matching
/tower-gates:tower-gates boundaries           # Refusals, attribution, re-vendoring
```

## The rule

- A checked box with `EVIDENCE: pending` is **unmet**. The checker re-runs that gate.
- An empty `touch <marker>.done` is **not done**. A marker carries the checker output.
- The implementer must not be the only one who ran the checker. The parent re-runs `--status`.
- Do not write a second checker. Two checkers disagree eventually, and then "done" means nothing.

## Example

```markdown
- [ ] G4: zot24/skills has an OPEN PR whose title names tower-gates
  CHECK: gh pr list --repo zot24/skills --state open --json number,title --jq '[.[] | select(.title | test("tower-gates";"i")) | .number] | if length>0 then "pr-open" else "none" end'
  EXPECT: pr-open
  EVIDENCE: pending
```

After `node gate-check.mjs gates/job.md`:

```markdown
- [x] G4: zot24/skills has an OPEN PR whose title names tower-gates
  CHECK: gh pr list --repo zot24/skills --state open --json number,title --jq '[.[] | select(.title | test("tower-gates";"i")) | .number] | if length>0 then "pr-open" else "none" end'
  EXPECT: pr-open
  EVIDENCE: pr-open
```

## Files

| Path | What it is |
|---|---|
| `skills/tower-gates/SKILL.md` | The rule, the gate shape, and the refusals |
| `skills/tower-gates/scripts/gate-check.mjs` | The checker. Zero dependencies, Node 16+ |
| `skills/tower-gates/templates/gates.md` | The starting shape for a new gates file |
| `skills/tower-gates/LICENSE.unlazy` | Upstream MIT licence, referenced by the checker header |
| `skills/tower-gates/docs/` | Gate format, checker reference, workflow, boundaries |

## Documentation

- [Gate format](./skills/tower-gates/docs/gate-format.md)
- [Checker reference](./skills/tower-gates/docs/checker.md)
- [Workflow](./skills/tower-gates/docs/workflow.md)
- [Boundaries and attribution](./skills/tower-gates/docs/boundaries.md)

## Upstream and licence

`skills/tower-gates/scripts/gate-check.mjs` is copyright (c) 2026 **Leonxlnx**, MIT, from
[Leonxlnx/unlazy](https://github.com/Leonxlnx/unlazy/blob/main/scripts/gate-check.mjs). The file
keeps its four-line attribution header, and `LICENSE.unlazy` sits one directory above `scripts/`,
which is where that header points.

The checker is **vendored by hand, not synced**. `sync.json` carries an empty `sources` array,
because an automated fetch would overwrite the attribution header. The re-vendoring steps are in
[boundaries](./skills/tower-gates/docs/boundaries.md).

This skill takes the checker and the discipline. It does not take unlazy's Stop hook, its
orchestrated mode, or its depth-tree subagent fan-out.
