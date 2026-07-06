#!/bin/bash
# discover-pages.sh - Discover new Agent Skills docs pages not yet in sync.json
# Usage: ./discover-pages.sh [--auto-add]
#
# Fetches three llms.txt indexes and compares against sync.json:
#   1. https://agentskills.io/llms.txt              - open spec pages
#   2. https://code.claude.com/llms.txt              - filtered to skill|slash-command
#   3. https://platform.claude.com/llms.txt          - filtered to agent-skills|skills-guide
#
# Only agentskills.io discoveries are eligible for --auto-add (their entry
# shape is well known: extract-content, 14-day freshness, docs/<slug>.md).
# Anthropic-site discoveries are always report-only (NEW: lines) since their
# keyword filters are broad and could catch unrelated pages.
#
# URLs are normalized (trailing slash + optional .md suffix stripped) before
# comparison, and compared with exact match (grep -qxF).

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MANIFEST="$SCRIPT_DIR/sync.json"

AGENTSKILLS_BASE="https://agentskills.io"
AGENTSKILLS_INDEX="$AGENTSKILLS_BASE/llms.txt"
CODE_CLAUDE_INDEX="https://code.claude.com/llms.txt"
PLATFORM_CLAUDE_INDEX="https://platform.claude.com/llms.txt"

AUTO_ADD=false
[[ "${1:-}" == "--auto-add" ]] && AUTO_ADD=true

command -v jq   >/dev/null || { echo "ERROR: jq is required"   >&2; exit 1; }
command -v curl >/dev/null || { echo "ERROR: curl is required" >&2; exit 1; }

# Normalize a URL for comparison: strip trailing slash and a trailing .md
normalize() { echo "$1" | sed -E 's#\.md$##; s#/$##'; }

echo "Discovering Agent Skills docs pages..."

# --- 1. agentskills.io (open spec) ---
echo "Fetching: $AGENTSKILLS_INDEX"
RAW_AGENTSKILLS=$(curl -sSL "$AGENTSKILLS_INDEX" 2>/dev/null || true)
AGENTSKILLS_URLS=$(echo "$RAW_AGENTSKILLS" | \
    grep -oE 'https://agentskills\.io/[^ )]+\.md' | \
    while IFS= read -r u; do normalize "$u"; done | \
    sort -u || true)

# --- 2. code.claude.com (Claude Code + Agent SDK), filtered ---
echo "Fetching: $CODE_CLAUDE_INDEX"
RAW_CODE_CLAUDE=$(curl -sSL "$CODE_CLAUDE_INDEX" 2>/dev/null || true)
CODE_CLAUDE_URLS=$(echo "$RAW_CODE_CLAUDE" | \
    grep -oE 'https://code\.claude\.com/[^ )]+\.md' | \
    grep -E 'skill|slash-command' | \
    while IFS= read -r u; do normalize "$u"; done | \
    sort -u || true)

# --- 3. platform.claude.com (Claude API), filtered ---
echo "Fetching: $PLATFORM_CLAUDE_INDEX"
RAW_PLATFORM_CLAUDE=$(curl -sSL "$PLATFORM_CLAUDE_INDEX" 2>/dev/null || true)
PLATFORM_CLAUDE_URLS=$(echo "$RAW_PLATFORM_CLAUDE" | \
    grep -oE 'https://platform\.claude\.com/[^ )]+\.md' | \
    grep -E 'agent-skills|skills-guide' | \
    while IFS= read -r u; do normalize "$u"; done | \
    sort -u || true)

if [ -z "$AGENTSKILLS_URLS" ] && [ -z "$CODE_CLAUDE_URLS" ] && [ -z "$PLATFORM_CLAUDE_URLS" ]; then
    echo "WARNING: No candidate URLs discovered from any index. Sites may not expose llms.txt, or structure changed."
    exit 1
fi

echo "Found $(echo "$AGENTSKILLS_URLS" | grep -c . || true) agentskills.io candidates."
echo "Found $(echo "$CODE_CLAUDE_URLS" | grep -c . || true) code.claude.com candidates (filtered)."
echo "Found $(echo "$PLATFORM_CLAUDE_URLS" | grep -c . || true) platform.claude.com candidates (filtered)."

# Normalized set of URLs already tracked
EXISTING_NORM=$(jq -r '.sources[].url' "$MANIFEST" | while IFS= read -r u; do normalize "$u"; done | sort -u)

find_new() {
    local candidates="$1"
    local new=""
    while IFS= read -r url; do
        [ -z "$url" ] && continue
        if ! echo "$EXISTING_NORM" | grep -qxF "$url"; then
            new="${new}${url}\n"
        fi
    done <<< "$candidates"
    echo -e "$new" | grep -v '^$' | sort -u || true
}

NEW_AGENTSKILLS=$(find_new "$AGENTSKILLS_URLS")
NEW_CODE_CLAUDE=$(find_new "$CODE_CLAUDE_URLS")
NEW_PLATFORM_CLAUDE=$(find_new "$PLATFORM_CLAUDE_URLS")

TOTAL_NEW=$(printf '%s\n%s\n%s\n' "$NEW_AGENTSKILLS" "$NEW_CODE_CLAUDE" "$NEW_PLATFORM_CLAUDE" | grep -v '^$' || true)

if [ -z "$TOTAL_NEW" ]; then
    echo "All discovered pages are already tracked in sync.json."
    exit 0
fi

echo ""
echo "=== NEW PAGES NOT IN sync.json ==="
[ -n "$NEW_AGENTSKILLS" ] && echo "$NEW_AGENTSKILLS" | while IFS= read -r url; do [ -n "$url" ] && echo "  NEW: $url"; done
[ -n "$NEW_CODE_CLAUDE" ] && echo "$NEW_CODE_CLAUDE" | while IFS= read -r url; do [ -n "$url" ] && echo "  NEW: $url"; done
[ -n "$NEW_PLATFORM_CLAUDE" ] && echo "$NEW_PLATFORM_CLAUDE" | while IFS= read -r url; do [ -n "$url" ] && echo "  NEW: $url"; done

if [ "$AUTO_ADD" = "true" ]; then
    if [ -n "$NEW_AGENTSKILLS" ]; then
        echo ""
        echo "Auto-adding new agentskills.io pages to sync.json..."
        echo "$NEW_AGENTSKILLS" | while IFS= read -r url; do
            [ -z "$url" ] && continue
            # Derive docs/ target from URL path:
            #   https://agentskills.io/skill-creation/quickstart -> skill-creation-quickstart.md
            rel=$(echo "$url" | sed -E "s#^${AGENTSKILLS_BASE}/##; s#/#-#g")
            target="skills/agent-skills/docs/${rel}.md"
            tmp=$(mktemp)
            jq --arg url "${url}.md" --arg target "$target" \
                '.sources += [{"url": $url, "target": $target, "type": "extract-content", "freshness_days": 14}]' \
                "$MANIFEST" > "$tmp"
            mv "$tmp" "$MANIFEST"
            echo "  Added: $url -> $target"
        done
        echo ""
        echo "Done. Run sync to fetch the new pages:"
        echo "  .github/workflows/scripts/sync-skill.sh skills/agent-skills --force"
    else
        echo ""
        echo "No new agentskills.io pages to auto-add."
    fi
    if [ -n "$NEW_CODE_CLAUDE" ] || [ -n "$NEW_PLATFORM_CLAUDE" ]; then
        echo "Anthropic-site discoveries are report-only; review the NEW: lines above and add manually if relevant."
    fi
else
    echo ""
    echo "To auto-add agentskills.io pages to sync.json, run:"
    echo "  ./skills/agent-skills/discover-pages.sh --auto-add"
    echo "(Anthropic-site discoveries are always report-only and must be added manually.)"
fi
