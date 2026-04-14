#!/bin/bash
# discover-pages.sh - Discover new docs pages not yet in sync.json
# Usage: ./discover-pages.sh [--auto-add]
#
# Fetches the llms.txt index from docs.honcho.dev and compares against sync.json.
# Reports any pages not yet tracked. With --auto-add, adds them to sync.json.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MANIFEST="$SCRIPT_DIR/sync.json"
BASE_URL="https://docs.honcho.dev"
INDEX_URL="$BASE_URL/llms.txt"

AUTO_ADD=false
[[ "${1:-}" == "--auto-add" ]] && AUTO_ADD=true

if ! command -v jq &> /dev/null; then
    echo "ERROR: jq is required" >&2
    exit 1
fi

if ! command -v curl &> /dev/null; then
    echo "ERROR: curl is required" >&2
    exit 1
fi

echo "Discovering docs pages from: $INDEX_URL"

# Fetch the llms.txt index and extract all doc URLs
RAW_INDEX=$(curl -sSL "$INDEX_URL" 2>/dev/null)

# Extract URLs from markdown links like [Title](URL)
DISCOVERED_URLS=$(echo "$RAW_INDEX" | \
    grep -oE 'https://docs\.honcho\.dev/[^)]+\.md' | \
    grep -v 'openapi' | \
    sort -u)

if [ -z "$DISCOVERED_URLS" ]; then
    echo "WARNING: No docs URLs discovered. Site may have changed structure."
    exit 1
fi

echo "Found $(echo "$DISCOVERED_URLS" | wc -l | tr -d ' ') docs pages in index."

# Get URLs already in sync.json
EXISTING_URLS=$(jq -r '.sources[].url' "$MANIFEST" | sort -u)

# Find new pages not in sync.json
NEW_URLS=""
while IFS= read -r url; do
    if ! echo "$EXISTING_URLS" | grep -qF "$url"; then
        NEW_URLS="${NEW_URLS}${url}\n"
    fi
done <<< "$DISCOVERED_URLS"

NEW_URLS=$(echo -e "$NEW_URLS" | grep -v '^$' || true)

if [ -z "$NEW_URLS" ]; then
    echo "All docs pages are already tracked in sync.json."
    exit 0
fi

echo ""
echo "=== NEW PAGES NOT IN sync.json ==="
echo -e "$NEW_URLS" | while IFS= read -r url; do
    [ -z "$url" ] && continue
    echo "  $url"
done

if [ "$AUTO_ADD" = "true" ]; then
    echo ""
    echo "Auto-adding new pages to sync.json..."

    echo -e "$NEW_URLS" | while IFS= read -r url; do
        [ -z "$url" ] && continue

        # Generate target filename from URL path
        # e.g., /v3/documentation/core-concepts/architecture.md -> architecture.md
        # e.g., /v3/guides/integrations/langgraph.md -> guides/langgraph.md
        path=$(echo "$url" | sed "s|${BASE_URL}/||")

        # Determine subdirectory based on URL structure
        if echo "$path" | grep -q 'api-reference/endpoint'; then
            # API endpoint -> docs/api/
            filename=$(echo "$path" | sed 's|.*/endpoint/||' | tr '/' '-' | sed 's/\.md$//')
            target="skills/honcho/docs/api/${filename}.md"
        elif echo "$path" | grep -q 'guides/'; then
            # Guide -> docs/guides/
            filename=$(basename "$path" .md)
            target="skills/honcho/docs/guides/${filename}.md"
        elif echo "$path" | grep -q 'contributing/'; then
            filename=$(basename "$path" .md)
            target="skills/honcho/docs/${filename}.md"
        elif echo "$path" | grep -q 'changelog/'; then
            filename=$(basename "$path" .md)
            target="skills/honcho/docs/${filename}.md"
        else
            # Core docs -> docs/
            filename=$(basename "$path" .md)
            target="skills/honcho/docs/${filename}.md"
        fi

        # Add to sync.json using jq
        tmp=$(mktemp)
        jq --arg url "$url" --arg target "$target" \
            '.sources += [{"url": $url, "target": $target, "type": "extract-content", "freshness_days": 14}]' \
            "$MANIFEST" > "$tmp"
        mv "$tmp" "$MANIFEST"

        echo "  Added: $url -> $target"
    done

    echo ""
    echo "Done. Run sync to fetch the new pages:"
    echo "  .github/workflows/scripts/sync-skill.sh skills/honcho --force"
else
    echo ""
    echo "To auto-add these to sync.json, run:"
    echo "  ./skills/honcho/discover-pages.sh --auto-add"
fi
