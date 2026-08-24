#!/usr/bin/env bash
# tower-poke.sh — prompt the tower's own herdr agent when a completion marker appears.
#
# Called by tower-watch.sh. This is how a control tower hears about a landing without sitting in
# the chat polling. It costs one prompt. It never treats idle as done, and it never restarts the
# job — it asks the tower to reconvene and VERIFY.
#
#   tower-poke.sh --marker PATH
#
# Environment:
#   TOWER_ROOT   tower directory, used to find the tower agent by cwd (default: $PWD)
#   TOWER_AGENT  preferred agent name to poke (default: tower)
#   TOWER_KIND   herdr agent kind to fall back to when no agent carries that name (default: claude)
set -euo pipefail

MARKER=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --marker) MARKER="${2:-}"; shift 2 ;;
    *) echo "unknown arg: $1" >&2; exit 2 ;;
  esac
done

if [[ -z "$MARKER" ]]; then
  echo '{"ok":false,"error":"--marker required"}' >&2
  exit 2
fi

if [[ "${HERDR_ENV:-}" != "1" ]]; then
  echo '{"ok":false,"error":"HERDR_ENV!=1"}'
  exit 0
fi

TOWER_ROOT="${TOWER_ROOT:-$PWD}" \
TOWER_AGENT="${TOWER_AGENT:-tower}" \
TOWER_KIND="${TOWER_KIND:-claude}" \
python3 - "$MARKER" <<'PY'
import json, os, subprocess, sys
from datetime import datetime
from pathlib import Path

marker = sys.argv[1]
now = datetime.now().astimezone().isoformat(timespec="seconds")
tower_root = str(Path(os.environ["TOWER_ROOT"]).expanduser().resolve())
tower_name = os.environ["TOWER_AGENT"]
tower_kind = os.environ["TOWER_KIND"]


def herdr(*args):
    raw = subprocess.check_output(["herdr", *args], stderr=subprocess.DEVNULL, text=True, timeout=20)
    return json.loads(raw)


try:
    data = herdr("agent", "list")
except Exception as e:
    print(json.dumps({"ok": False, "ts": now, "error": f"agent list: {e}"}))
    sys.exit(0)

agents = (data.get("result") or {}).get("agents") or []

# 1) the agent explicitly named as the tower
pick = next((a for a in agents if (a.get("name") or "") == tower_name), None)
# 2) otherwise the agent of the tower's kind whose cwd IS the tower root
if pick is None:
    pick = next(
        (a for a in agents
         if (a.get("agent") or "") == tower_kind
         and str(a.get("cwd") or "").rstrip("/") == tower_root),
        None,
    )

if pick is None:
    print(json.dumps({"ok": False, "ts": now,
                      "error": f"no agent named {tower_name!r} and no {tower_kind} agent in {tower_root}"}))
    sys.exit(0)

target = pick.get("name") or pick.get("pane_id")
if not pick.get("name"):
    # name it so the next poke is unambiguous
    try:
        herdr("agent", "rename", pick.get("pane_id"), tower_name)
        target = tower_name
    except Exception as e:
        print(json.dumps({"ok": False, "ts": now, "error": f"rename: {e}", "pane": pick.get("pane_id")}))
        sys.exit(0)

text = (
    f"MARKER_OK {marker}. "
    "Reconvene now: read the matching deliverable, verify its central claim against the source "
    "of truth yourself, flip the work-graph node, and report one status table. "
    "Do not restart the job. Idle is not done — the marker is."
)

try:
    herdr("agent", "prompt", str(target), text)
    # land-check: a prompt that returned ok is not necessarily a prompt that arrived
    subprocess.run(["herdr", "agent", "send-keys", str(target), "enter"],
                   check=False, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, timeout=10)
    print(json.dumps({"ok": True, "ts": now, "poked": target, "marker": marker}))
except Exception as e:
    print(json.dumps({"ok": False, "ts": now, "error": str(e), "target": target}))
PY
