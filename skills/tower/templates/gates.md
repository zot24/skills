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

<!--
Trap (a) #215: do not grep -q 'EVIDENCE: pending' — a complete marker that
mentions the phrase fails itself. Anchor the whole attribute line (G3 above).

Trap (b) PR #224: do not assert a remote branch still exists. GitHub deletes
it on merge. Assert a property of the work (merge commit on main, or PR
number whose state is OPEN or MERGED).

Trap (c) digest Phase B: do not grep dictionary words (password|secret|api_key).
That flagged "offline password vault" and "NO new secret" with zero credentials.
Scan values:

  ghp_[A-Za-z0-9]{36}
  AKIA[0-9A-Z]{16}
  xox[baprs]-[A-Za-z0-9-]{10,}
  sk-[A-Za-z0-9]{20,}
  eyJ[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+
  (api[_-]?key|password)\s*=\s*["'][^"']{16,}["']
-->
