#!/usr/bin/env bash
# discover-pages.sh - upstream drift detector for the x-engagement skill.
#
# This skill's analytical docs are hand-derived from source files in
# xai-org/x-algorithm. sync-skill.sh can copy those files, but it cannot
# re-derive the prose. So the failure mode is silent: upstream deletes the file
# a claim rests on, the copy 404s (or the constant quietly changes), and the
# skill keeps asserting something that is no longer true.
#
# On 2026-08-13 xAI added 21 top-level directories and deleted
# grox/classifiers/content/banger_initial_screen.py, which is where the skill's
# "quality_score >= 0.4" gate came from. Nothing in CI noticed. This script
# exists so that class of change is loud.
#
# It checks two things against the live default branch:
#   1. Top-level tree drift vs the recorded snapshot (.upstream-tree)
#   2. That every source URL in sync.json still resolves (HTTP 200)
#
# It deliberately does NOT auto-add sources. A new upstream directory needs a
# human to decide whether it changes the guidance; silently appending a URL
# would just grow the cache without correcting any prose.
#
# Usage:
#   ./discover-pages.sh              report drift, exit 0
#   ./discover-pages.sh --auto-add   same, plus rewrite .upstream-tree (CI mode)
#   ./discover-pages.sh --strict     exit 1 on drift (for local verification)
#
# Dependencies: curl, jq

set -uo pipefail

SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MANIFEST="$SKILL_DIR/sync.json"
TREE_FILE="$SKILL_DIR/.upstream-tree"
REPO="xai-org/x-algorithm"
API="https://api.github.com/repos/$REPO"

AUTO_ADD=false
STRICT=false
for arg in "$@"; do
    case "$arg" in
        --auto-add) AUTO_ADD=true ;;
        --strict)   STRICT=true ;;
        --help|-h)  sed -n '2,28p' "${BASH_SOURCE[0]}"; exit 0 ;;
    esac
done

log()  { echo "[discover] $1"; }
warn() { echo "::warning::$1"; echo "[discover] WARN: $1"; }

for dep in curl jq; do
    command -v "$dep" >/dev/null 2>&1 || { warn "$dep not installed - skipping discovery"; exit 0; }
done

# GITHUB_TOKEN lifts the 60/hr anonymous rate limit when running in Actions.
# Expanded as ${AUTH[@]+"${AUTH[@]}"} below: bash 3.2 (macOS) treats an empty
# array as unbound under `set -u`.
AUTH=()
if [ -n "${GITHUB_TOKEN:-}" ]; then
    AUTH=(-H "Authorization: Bearer $GITHUB_TOKEN")
fi

DRIFT=0

# --- 1. Top-level tree drift -------------------------------------------------

BRANCH=$(curl -sS ${AUTH[@]+"${AUTH[@]}"} "$API" | jq -r '.default_branch // "main"')
TREE_JSON=$(curl -sS ${AUTH[@]+"${AUTH[@]}"} "$API/git/trees/$BRANCH")

if ! echo "$TREE_JSON" | jq -e '.tree' >/dev/null 2>&1; then
    warn "could not read tree for $REPO@$BRANCH (rate limited or offline) - skipping tree check"
else
    LIVE=$(echo "$TREE_JSON" | jq -r '.tree[] | select(.type=="tree") | .path' | sort)

    if [ ! -f "$TREE_FILE" ]; then
        log "no $TREE_FILE recorded yet - creating baseline"
        printf '%s\n' "$LIVE" > "$TREE_FILE"
    else
        RECORDED=$(grep -v '^\s*#' "$TREE_FILE" | grep -v '^\s*$' | sort)
        ADDED=$(comm -23 <(printf '%s\n' "$LIVE") <(printf '%s\n' "$RECORDED"))
        REMOVED=$(comm -13 <(printf '%s\n' "$LIVE") <(printf '%s\n' "$RECORDED"))

        if [ -n "$ADDED" ]; then
            DRIFT=1
            warn "$REPO added top-level directories since last review:"
            printf '           + %s\n' $ADDED
            echo "           -> new subsystems may change the guidance. Review, then update"
            echo "              docs/ and sync.json snapshot_commit by hand."
        fi
        if [ -n "$REMOVED" ]; then
            DRIFT=1
            warn "$REPO removed top-level directories since last review:"
            printf '           - %s\n' $REMOVED
            echo "           -> any doc citing these is now stale."
        fi
        [ -z "$ADDED$REMOVED" ] && log "top-level tree unchanged ($(printf '%s\n' "$LIVE" | wc -l | tr -d ' ') dirs)"

        if [ "$AUTO_ADD" = true ] && [ -n "$ADDED$REMOVED" ]; then
            printf '%s\n' "$LIVE" > "$TREE_FILE"
            log "updated $TREE_FILE baseline"
        fi
    fi
fi

# --- 2. Cited sources still resolve ------------------------------------------

if [ -f "$MANIFEST" ]; then
    while IFS= read -r url; do
        [ -z "$url" ] && continue
        code=$(curl -sS -o /dev/null -w "%{http_code}" -L "$url" 2>/dev/null || echo "000")
        if [ "$code" != "200" ]; then
            DRIFT=1
            warn "source no longer resolves (HTTP $code): $url"
            echo "           -> a doc derived from this file is asserting something that"
            echo "              may no longer exist upstream. Re-derive it by hand."
        fi
    done < <(jq -r '.sources[].url' "$MANIFEST" 2>/dev/null)
    log "checked $(jq -r '.sources | length' "$MANIFEST" 2>/dev/null || echo 0) source URLs"
else
    warn "sync.json not found at $MANIFEST"
fi

# --- Result ------------------------------------------------------------------

if [ "$DRIFT" -eq 1 ]; then
    SNAP=$(jq -r '.snapshot_commit // "unknown"' "$MANIFEST" 2>/dev/null)
    echo ""
    echo "[discover] Upstream drift detected. The analytical docs were derived at"
    echo "[discover] snapshot $SNAP and may now be stale. CI can refresh the cached"
    echo "[discover] files under docs/upstream/, but the prose needs a human."
    [ "$STRICT" = true ] && exit 1
else
    log "no drift detected"
fi

exit 0
