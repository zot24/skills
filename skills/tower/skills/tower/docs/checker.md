# Checker reference

`scripts/gate-check.mjs` is vendored from [Leonxlnx/unlazy](https://github.com/Leonxlnx/unlazy)
under MIT. Zero dependencies. Node 16 or later.

## Usage

```bash
# cwd: ${CLAUDE_PLUGIN_ROOT}
node scripts/gate-check.mjs [file ...]              # run unmet gates' checks, update the files
node scripts/gate-check.mjs --status [file ...]     # report only, change nothing
node scripts/gate-check.mjs --timeout 60 [file ...] # per-check timeout in seconds, default 120
```

With no file argument it reads `GATES.md` in the current directory, then every `gates/*.md`.

## Exit codes

| Code | Meaning |
|---|---|
| `0` | Every gate is met, or honestly abandoned |
| `1` | Unmet gates remain |
| `2` | Usage error, or a gate file it cannot read |

The last line of output is the summary: `ALL MET (4 met)` or `UNMET: 1 (met: 3)`.

## The two modes

**Run mode** (no `--status`) executes the `CHECK` of every gate that is unchecked, or checked with
`EVIDENCE: pending`. On a pass it writes the file: the box becomes `- [x]` and the evidence line
becomes the tail of the output. It never re-runs a gate that is already checked with real evidence,
so a green gates file is cheap to re-verify.

**Status mode** (`--status`) executes nothing and writes nothing. It reads the file and reports.
This is the mode a parent runs to accept a delivery, and the mode the tower re-runs later.

```
  UNMET G4 (unchecked): zot24/skills has an OPEN PR whose files include tower SKILL.md
gates/2026-08-20-tower.md: 4 gates
UNMET: 1 (met: 3)
```

## How a check is executed

Each `CHECK` runs through the shell, with a timeout (120 seconds by default) and an 8 MB output
buffer. stdout and stderr are concatenated before matching, so a command that writes its proof to
stderr still works.

Matching:

- `EXPECT` present → the combined output must contain the substring, or match `/regex/flags`. The
  exit code is ignored.
- `EXPECT` absent → exit status `0` passes.
- A regex that does not compile never matches. It does not crash the run.

## What lands in EVIDENCE

The last two non-empty output lines, trimmed, joined with ` | `, cut to 200 characters. Empty output
becomes `(no output)`.

So a check that ends in a short, stable marker produces readable evidence. A check that ends in a
progress bar produces noise. Put `&& echo <marker>` at the end of a silent command.

## Timeouts

`--timeout <seconds>` applies per check, not to the whole run. A check that times out fails and
reports the Node error message as the reason. Raise it for a build, lower it for a fleet of network
probes.

## Idempotence

Running the checker twice on a passing file changes nothing the second time: every gate is checked
with real evidence, so nothing needs to run. Running it on a file where you hand-ticked a box but
left `EVIDENCE: pending` **does** re-run that check, which is how the format resists a false tick.

## What it does not do

- It does not create gates. You write them.
- It does not fill a manual gate. A gate with no `CHECK` is yours to evidence.
- It does not delete an abandoned gate. `ABANDON:` records the decision in the file.
- It does not read a PR body, a chat log, or a task tracker. Only commands and their output.
