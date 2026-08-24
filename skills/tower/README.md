# tower

One skill for running a control tower over a fleet of [herdr](https://github.com/herdrdev/herdr)
agents, including the acceptance gates that decide when a job is done.

- Protocol: dispatch from spec files, watch/poke on markers, staff only required seats,
  verify independently. See `skills/tower/SKILL.md` and `skills/tower/docs/`.
- Gates: a gates file of `CHECK` / `EXPECT` / `EVIDENCE` outcomes verified by the vendored
  zero-dependency checker `scripts/gate-check.mjs` (from Leonxlnx/unlazy, MIT).
  Done = exit 0. An empty marker is never done.

Merged from the former `herdr-tower` and `tower-gates` skills (v1.1.x) — same content,
one seat, one name.
