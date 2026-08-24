# tower

One skill for running a control tower over a fleet of [herdr](https://github.com/herdrdev/herdr)
agents, including the acceptance gates that decide when a job is done.

- Protocol: dispatch from spec files, watch/poke on markers, staff only required seats,
  verify independently. See `skills/tower/SKILL.md` and `skills/tower/docs/`.
- Operating loop: at **session start** read the work graph and the status board; **catalog**
  entitled vs missing; settle every **unpaid ask** before starting a new job; **reconvene**
  with one owner table when a marker lands; **escalate** to the owner queue; do not trust a
  handoff note for liveness. A write starts on a worktree workspace, with agent names
  `<slug>-<N>-<role>`. Dispatch, watch, staffing, and gates stay as they are.
- Gates: a gates file of `CHECK` / `EXPECT` / `EVIDENCE` outcomes verified by the vendored
  zero-dependency checker `scripts/gate-check.mjs` (from Leonxlnx/unlazy, MIT).
  Done = exit 0. An empty marker is never done.
- Auto-wiki: `scripts/auto-wiki.py` plus `docs/auto-wiki.md` live in this package. A consumer
  hook calls that script. It rewrites a high-level page from the git diff. It does not paste
  the source file. nvk `wiki-manager` stays a separate install.
- Official `herdr` stays a separate install. This package folds house `herdr-fleet`
  (dispatch/supervise). It does not publish or replace the official CLI skill.

Merged from the former `herdr-tower` and `tower-gates` skills (v1.1.x) — same content,
one seat, one name.
