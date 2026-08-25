#!/usr/bin/env bash
# tower-watch.sh — poll a completion marker file, optionally alongside a herdr agent prefix.
#
# Done is a MARKER FILE, never `idle` and never a pane regex. This script costs nothing:
# one stat() and one `herdr agent list` per tick, no model tokens.
#
#   tower-watch.sh start  --marker PATH [--prefix NAME] [--interval SEC] [--log PATH]
#   tower-watch.sh once   --marker PATH [--prefix NAME]
#   tower-watch.sh status --marker PATH [--log PATH]
#   tower-watch.sh stop   --marker PATH
#
# On MARKER_OK the watcher calls tower-poke.sh, which prompts the tower's own herdr agent with
# one line. It never treats idle as done.
#
# Environment:
#   TOWER_ROOT   tower directory; state lives in $TOWER_ROOT/scratchpad/watch (default: $PWD)
#   TOWER_AGENT  agent name to poke (default: tower)          — see tower-poke.sh
#   TOWER_KIND   herdr agent kind of the tower (default: claude)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="${TOWER_ROOT:-$PWD}"
CMD="${1:-status}"
shift || true

MARKER=""
PREFIX=""
INTERVAL=120
LOG=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --marker)   MARKER="${2:-}";   shift 2 ;;
    --prefix)   PREFIX="${2:-}";   shift 2 ;;
    --interval) INTERVAL="${2:-120}"; shift 2 ;;
    --log)      LOG="${2:-}";      shift 2 ;;
    *) echo "unknown arg: $1" >&2; exit 2 ;;
  esac
done

if [[ -z "$MARKER" ]]; then
  echo '{"ok":false,"error":"--marker required"}' >&2
  exit 2
fi

MARKER="$(python3 -c 'import os,sys; print(os.path.abspath(os.path.expanduser(sys.argv[1])))' "$MARKER")"
slug="$(python3 -c 'import hashlib,sys; print(hashlib.sha1(sys.argv[1].encode()).hexdigest()[:12])' "$MARKER")"
RUNDIR="$ROOT/scratchpad/watch"
mkdir -p "$RUNDIR"
PIDFILE="$RUNDIR/$slug.pid"
LOG="${LOG:-$RUNDIR/$slug.log}"

once() {
  python3 - "$MARKER" "$PREFIX" <<'PY'
import json, os, subprocess, sys
from datetime import datetime
from pathlib import Path

marker, prefix = sys.argv[1], sys.argv[2]
exists = Path(marker).is_file()
agents, err = [], None
herdr_bin = os.environ.get("HERDR_BIN") or "herdr"
if os.environ.get("HERDR_ENV") != "1":
    err = "HERDR_ENV!=1"
else:
    try:
        raw = subprocess.check_output(
            [herdr_bin, "agent", "list"], stderr=subprocess.DEVNULL, text=True, timeout=15
        )
        for a in (json.loads(raw).get("result") or {}).get("agents") or []:
            name = a.get("name") or ""
            if prefix and not name.startswith(prefix):
                continue
            agents.append({
                "name": name or None,
                "kind": a.get("agent"),
                "status": a.get("agent_status"),
                "pane_id": a.get("pane_id"),
            })
    except Exception as e:  # herdr absent, socket down, malformed payload
        err = str(e)

print(json.dumps({
    "ok": True,
    "ts": datetime.now().astimezone().isoformat(timespec="seconds"),
    "marker": marker,
    "marker_exists": exists,
    "prefix": prefix or None,
    "agents": agents,
    "herdr_error": err,
    "done": exists,          # the marker is the only completion signal
}, indent=2))
PY
}

case "$CMD" in
  once)
    once
    ;;

  status)
    running=false
    if [[ -f "$PIDFILE" ]] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then running=true; fi
    once
    echo "watch_running $running pidfile $PIDFILE log $LOG"
    if [[ -f "$LOG" ]]; then echo "--- log tail ---"; tail -8 "$LOG"; fi
    ;;

  stop)
    if [[ -f "$PIDFILE" ]]; then
      pid="$(cat "$PIDFILE")"
      kill "$pid" 2>/dev/null || true
      rm -f "$PIDFILE"
      echo "{\"ok\":true,\"stopped\":true,\"pid\":$pid}"
    else
      echo '{"ok":true,"stopped":false,"note":"no pidfile"}'
    fi
    ;;

  start)
    if [[ -f "$PIDFILE" ]] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
      echo "{\"ok\":true,\"already_running\":true,\"pid\":$(cat "$PIDFILE"),\"log\":\"$LOG\"}"
      exit 0
    fi
    nohup env \
      HERDR_ENV="${HERDR_ENV:-}" \
      TOWER_ROOT="$ROOT" \
      TOWER_AGENT="${TOWER_AGENT:-tower}" \
      TOWER_KIND="${TOWER_KIND:-claude}" \
      bash -c "
      while true; do
        now=\$(date '+%Y-%m-%d %H:%M:%S')
        if [ -f '$MARKER' ]; then
          echo \"\$now MARKER_OK $MARKER\" >> '$LOG'
          '$SCRIPT_DIR/tower-poke.sh' --marker '$MARKER' >> '$LOG' 2>&1 || true
          rm -f '$PIDFILE'
          exit 0
        fi
        line=\$('$SCRIPT_DIR/tower-watch.sh' once --marker '$MARKER' --prefix '$PREFIX' 2>/dev/null \
          | python3 -c 'import json,sys
try:
  d = json.load(sys.stdin)
  if d.get(\"herdr_error\"):
    print(\"unverifiable\")
  else:
    xs = [\"%s=%s\" % (a.get(\"name\") or \"—\", a.get(\"status\")) for a in d.get(\"agents\") or []]
    print(\" \".join(xs) or \"no-agents\")
except Exception:
  print(\"parse-err\")
')
        echo \"\$now still-open \$line\" >> '$LOG'
        sleep $INTERVAL
      done
    " >/dev/null 2>&1 &
    echo $! > "$PIDFILE"
    echo "{\"ok\":true,\"started\":true,\"pid\":$(cat "$PIDFILE"),\"marker\":\"$MARKER\",\"interval\":$INTERVAL,\"log\":\"$LOG\"}"
    ;;

  *)
    echo "usage: $0 start|once|status|stop --marker PATH [--prefix NAME] [--interval SEC]" >&2
    exit 2
    ;;
esac
