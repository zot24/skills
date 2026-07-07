#!/bin/bash
# discover-pages.sh - Discover new Chat SDK docs pages not yet in sync.json
# Usage: ./discover-pages.sh [--auto-add]
#
# Fetches https://chat-sdk.dev/llms.txt and compares its listed .md URLs
# against sync.json. Reports any pages not yet tracked. With --auto-add,
# adds them to sync.json using the same URL -> target slug mapping used to
# build the manifest (see plans/011-chat-sdk-repurpose.md for the rule set).

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MANIFEST="$SCRIPT_DIR/sync.json"
BASE_URL="https://chat-sdk.dev"
INDEX_URL="$BASE_URL/llms.txt"

AUTO_ADD=false
[[ "${1:-}" == "--auto-add" ]] && AUTO_ADD=true

command -v jq   >/dev/null || { echo "ERROR: jq is required"   >&2; exit 1; }
command -v curl >/dev/null || { echo "ERROR: curl is required" >&2; exit 1; }

echo "Discovering Chat SDK docs pages from: $INDEX_URL"

RAW_INDEX=$(curl -sSL "$INDEX_URL" 2>/dev/null || true)

# All chat-sdk.dev .md URLs, excluding the llms-full.txt concatenated dump
# (llms-full.txt is not itself a .md URL, but guard anyway).
DISCOVERED_URLS=$(echo "$RAW_INDEX" | \
    grep -oE 'https://chat-sdk\.dev/[^)[:space:]]*\.md' | \
    grep -v 'llms-full' | \
    sort -u || true)

if [ -z "$DISCOVERED_URLS" ]; then
    echo "WARNING: No Chat SDK docs URLs discovered. Site may not expose llms.txt, or structure changed."
    exit 1
fi

echo "Found $(echo "$DISCOVERED_URLS" | wc -l | tr -d ' ') candidate docs URLs in index."

# Set of URLs already tracked in sync.json
EXISTING_URLS=$(jq -r '.sources[].url' "$MANIFEST" | sort -u)

NEW_URLS=""
while IFS= read -r url; do
    [ -z "$url" ] && continue
    if ! echo "$EXISTING_URLS" | grep -qxF "$url"; then
        NEW_URLS="${NEW_URLS}${url}\n"
    fi
done <<< "$DISCOVERED_URLS"

NEW_URLS=$(echo -e "$NEW_URLS" | grep -v '^$' | sort -u || true)

if [ -z "$NEW_URLS" ]; then
    echo "All discovered pages are already tracked in sync.json."
    exit 0
fi

echo ""
echo "=== NEW PAGES NOT IN sync.json ==="
echo "$NEW_URLS" | while IFS= read -r url; do [ -n "$url" ] && echo "  $url"; done

# Derive a docs/ target filename from a chat-sdk.dev URL, mirroring the
# mapping used to build sync.json:
#   https://chat-sdk.dev/docs.md                              -> introduction.md
#   https://chat-sdk.dev/docs/<path>.md                       -> <path with / -> -).md
#   https://chat-sdk.dev/adapters/official/<name>.md          -> adapter-<name>.md
#   https://chat-sdk.dev/adapters/vendor-official/<name>.md   -> adapter-vendor-<name>.md
#   https://chat-sdk.dev/adapters/community/<name>.md         -> adapter-community-<name>.md
#   anything else (e.g. sitemap.md)                           -> <basename>.md
slug_for() {
    local url="$1"
    local rest="${url#${BASE_URL}/}"
    rest="${rest%.md}"
    case "$rest" in
        docs)
            echo "introduction.md" ;;
        docs/*)
            local path="${rest#docs/}"
            echo "${path//\//-}.md" ;;
        adapters/official/*)
            echo "adapter-${rest#adapters/official/}.md" ;;
        adapters/vendor-official/*)
            echo "adapter-vendor-${rest#adapters/vendor-official/}.md" ;;
        adapters/community/*)
            echo "adapter-community-${rest#adapters/community/}.md" ;;
        *)
            echo "${rest}.md" ;;
    esac
}

if [ "$AUTO_ADD" = "true" ]; then
    echo ""
    echo "Auto-adding new pages to sync.json..."
    echo "$NEW_URLS" | while IFS= read -r url; do
        [ -z "$url" ] && continue
        slug="$(slug_for "$url")"
        target="skills/chat-sdk/docs/${slug}"
        tmp=$(mktemp)
        jq --arg url "$url" --arg target "$target" \
            '.sources += [{"url": $url, "target": $target, "type": "extract-content", "freshness_days": 14}]' \
            "$MANIFEST" > "$tmp"
        mv "$tmp" "$MANIFEST"
        echo "  Added: $url -> $target"
    done
    echo ""
    echo "Done. Run sync to fetch the new pages:"
    echo "  .github/workflows/scripts/sync-skill.sh skills/chat-sdk --force"
else
    echo ""
    echo "To auto-add these to sync.json, run:"
    echo "  ./skills/chat-sdk/discover-pages.sh --auto-add"
fi
