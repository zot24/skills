# Gates: <job name> (integration)

Scope: children <list child markers or gates files> merged into one working whole

- [ ] N1: every child gates file is fully checked
  CHECK: node /Users/anon/orchestrator/.pi/skills/tower-gates/scripts/gate-check.mjs --status <child-a.md> <child-b.md>
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
  EXPECT: <success marker>
  EVIDENCE: pending

<!--
Branch gates exist because finished parts do not imply a finished whole.
Do not mark N1 by trusting child reports: re-run their checks yourself.
-->
