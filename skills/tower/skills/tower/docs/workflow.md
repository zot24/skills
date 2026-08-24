# The workflow

Gates exist so that "done" is a command, not a claim.

```
spec names a gates file
        │
        ▼
gates file written with EVIDENCE: pending
        │
        ▼
implementer does the work, runs the checker
        │
        ▼
completion marker holds the checker output
        │
        ▼
parent re-runs --status   ── exit 1 ──▶ not done, back to the implementer
        │
     exit 0
        │
        ▼
accepted
```

## 1. The spec names the gates file

Write the gates before dispatch, not after. A gate written after the work describes what happened.
A gate written before describes what was wanted.

```markdown
Gates file (fill by running the checker, do not tick boxes by hand):
`scratchpad/gates/<date>-<job>.md`
```

## 2. Write the gates

Copy `templates/gates.md`. One gate per outcome. Every `EVIDENCE:` starts at `pending`. Read
[gate-format](gate-format.md).

## 3. The implementer runs the checker

Not at the end alone — a gate that cannot pass is worth finding early.

```bash
node "$CHECKER" scratchpad/gates/<date>-<job>.md
```

Boxes flip and evidence lands in the file. A `FAIL` line names the gate and the reason.

## 4. The marker is not an empty file

`touch <marker>.done` proves that a process reached the end. It proves nothing about the work.

A marker is one of two things:

- the gates file itself, or
- a short file that names the gates file and pastes the checker output, including the `ALL MET` line.

Give the marker a timestamp and a pointer to the deliverable. Anyone reading it later should be able
to re-run the proof without asking you.

## 5. The parent re-runs `--status`

The implementer is the worst judge of its own delivery. The parent — a tower, a PM, a reviewer —
re-runs the same command against the same file:

```bash
node "$CHECKER" --status scratchpad/gates/<date>-<job>.md
echo $?
```

Exit `0` accepts. Exit `1` sends it back, and the output names which gate.

Status mode changes nothing, so the parent cannot accidentally turn a red file green.

## Failure modes this catches

| Claim | What the gate does |
|---|---|
| "Done" with an empty marker | `--status` reports `UNMET` on every gate |
| A hand-ticked box | The evidence is still `pending`, so the gate is unmet and the check re-runs |
| Work that passed once, on one machine | The parent re-runs the same command later |
| A gate quietly dropped from the file | `ABANDON:` is the only recorded way out, and it stays visible |
| A check that always passes | Review the `CHECK` at spec time, when it is cheap to fix |

## What gates are not

Gates are acceptance criteria, not a test suite. They prove the outcome the spec asked for. They do
not replace lint, types, unit tests, or CI — a gate can *invoke* those, which is usually the right
move.
