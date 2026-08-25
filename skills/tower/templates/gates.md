# Gates: <job name>

Scope: <one line>

- [ ] G1: <observable outcome>
  CHECK: <shell command>
  EXPECT: <line-anchored prefix token, or /regex/>
  EVIDENCE: pending

- [ ] G2: <another outcome>
  CHECK: <command>
  EXPECT: <line-anchored prefix token, or /regex/>
  EVIDENCE: pending

- [ ] G3: marker observed, not pending
  CHECK: test -f "$m" && ! grep -qE '^[[:space:]]*EVIDENCE: pending[[:space:]]*$' "$m" && echo marker-observed || echo marker-missing-or-pending
  EXPECT: marker-observed
  EVIDENCE: pending
