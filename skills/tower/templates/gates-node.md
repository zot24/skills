# Gates: <job name> (integration)

Scope: children <list child markers or gates files> merged into one working whole

- [ ] N1: every child gates file is fully checked
  CHECK: node scripts/gate-check.mjs --status <child-a.md> <child-b.md>
  EXPECT: ALL MET
  EVIDENCE: pending

- [ ] N2: interfaces match the spec contract
  CHECK: <build / typecheck / import test>
  EXPECT: <success marker>
  EVIDENCE: pending

- [ ] N3: cross-child behavior works end to end
  CHECK: <integration test, smoke, or curl sequence>
  EXPECT: <success marker>
  EVIDENCE: pending

- [ ] N4: nothing regressed in siblings this merge touched
  CHECK: <targeted re-run of affected sibling checks>
  EXPECT: <line-anchored prefix token, or /regex/>
  EVIDENCE: pending

- [ ] N5: marker observed, not pending
  CHECK: test -f "$m" && ! grep -qE '^[[:space:]]*EVIDENCE: pending[[:space:]]*$' "$m" && echo marker-observed || echo marker-missing-or-pending
  EXPECT: marker-observed
  EVIDENCE: pending

<!--
Trap (a): grep -q 'EVIDENCE: pending' matches a complete marker that mentions
the phrase. Anchor '^[[:space:]]*EVIDENCE: pending[[:space:]]*$' (N5 above).
Trap (b): do not assert a remote branch still exists; that is transient
world-state. Assert a property of the work.
Trap (c): scan credential values (ghp_, AKIA, xox[baprs]-, sk-, JWT), never
dictionary words (password|secret|api_key).
-->

<!--
Branch gates exist because finished parts do not imply a finished whole.
Do not mark N1 by trusting child reports: re-run their checks yourself.
-->
