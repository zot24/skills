# Tower Gates Assistant

You are an expert at acceptance gates: a gates file of observable outcomes, verified by the vendored
`gate-check.mjs`, so that "done" is an exit code and not a claim.

## Command: $ARGUMENTS

Parse the arguments to determine the action:

| Command | Action |
|---------|--------|
| `new <path>` | Write a fresh gates file from `templates/gates.md` for the job at hand |
| `run <file>` | Run the unmet checks, flip the boxes, write the evidence back |
| `status <file>` | Report only. Change nothing. Report the exit code |
| `verify <file>` | Parent-side acceptance: re-run `--status` and accept only on exit 0 |
| `marker <file>` | Write a completion marker that pastes the checker output. Never an empty `touch` |
| `format` | The gate file shape, `CHECK` / `EXPECT` / `EVIDENCE`, and `ABANDON` |
| `checker` | CLI flags, exit codes, matching rules, timeouts |
| `workflow` | Spec → gates → work → marker → parent re-runs `--status` |
| `boundaries` | What this skill takes from unlazy, what it refuses, and the licence |
| `help` | Show available commands |

## Instructions

1. Read the skill file at `${CLAUDE_PLUGIN_ROOT}/skills/tower-gates/SKILL.md` for the rule
2. Read detailed docs in `${CLAUDE_PLUGIN_ROOT}/skills/tower-gates/docs/`:
   - `gate-format.md` — the file shape and how to write a gate that means something
   - `checker.md` — flags, exit codes, matching, timeouts
   - `workflow.md` — the five steps from spec to acceptance
   - `boundaries.md` — refusals, attribution, and how to re-vendor
3. The checker is `${CLAUDE_PLUGIN_ROOT}/skills/tower-gates/scripts/gate-check.mjs`. Run it with
   `node`. It has no dependencies and needs Node 16 or later
4. The template is `${CLAUDE_PLUGIN_ROOT}/skills/tower-gates/templates/gates.md`

## Hard rules

- Do not write a second checker. Run the vendored one.
- Do not tick a box by hand. Run the checker, or fill `EVIDENCE:` with a quote, a `file:line`, or a
  URL for a manual gate.
- A checked box with `EVIDENCE: pending` is unmet.
- A completion marker is never an empty `touch`. It carries the checker output, including `ALL MET`.
- The implementer must not be the only one who ran the checker. The parent re-runs `--status`.
- Do not install unlazy's Stop hook, run `npx skills add`, or fan out through unlazy subagents.
- Keep the attribution header on `gate-check.mjs` and keep `LICENSE.unlazy` next to it.

## Quick Reference

```bash
CHECKER="${CLAUDE_PLUGIN_ROOT}/skills/tower-gates/scripts/gate-check.mjs"

node "$CHECKER" gates/<name>.md               # run, flip boxes, write evidence
node "$CHECKER" --status gates/<name>.md      # report only
node "$CHECKER" --timeout 300 gates/<name>.md # per-check timeout, default 120s
echo $?                                       # 0 met, 1 unmet, 2 usage error
```

```markdown
- [ ] G1: <observable outcome>
  CHECK: <shell command>
  EXPECT: <substring or /regex/>
  EVIDENCE: pending

ABANDON: G3 <reason this outcome was dropped>
```
