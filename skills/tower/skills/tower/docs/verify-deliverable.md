# verify-deliverable — independent re-check after a marker

Folded from the former house skill `verify-deliverable`. Not a separate plugin. The check
table lives in [watch & poke](watch-and-poke.md). This file is the seven-step list the
tower runs after `MARKER_OK`.

1. Read the deliverable path.
2. Extract the **central claim**.
3. Re-check yourself:
   - GitHub → `gh`
   - files → disk
   - DB → query
4. Grade each load-bearing claim: VERIFIED / INFERRED / NOT DETERMINED.
5. If nothing is NOT DETERMINED, ask whether the bar was too low.
6. Verdict: `pass` | `partial` | `fail` + next action (fix spec, escalate, close).
7. Flip the work-graph node only on `pass`. Marker without this check leaves it `live`.

A ledger of verify events is instance config. It is not this skill.

`gate-check.mjs --status` exit 0 is the gates half of done. This file is the **claim** half.
Both are required. See [gates workflow](workflow.md).
