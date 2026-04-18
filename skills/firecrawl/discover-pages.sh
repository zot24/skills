#!/bin/bash
# discover-pages.sh - Discover new docs pages not yet in sync.json
# Usage: ./discover-pages.sh [--auto-add]
#
# Fetches the Firecrawl docs llms.txt index and compares against sync.json.
# Reports any pages not yet tracked. With --auto-add, adds them to sync.json.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MANIFEST="$SCRIPT_DIR/sync.json"
BASE_URL="https://docs.firecrawl.dev"
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

# Fetch llms.txt and extract URLs
RAW_INDEX=$(curl -sSL "$INDEX_URL" 2>/dev/null)

# Extract URLs from llms.txt (format: "- [Title](url): description" or plain URLs)
DISCOVERED_URLS=$(echo "$RAW_INDEX" | \
    grep -oE "https://docs\.firecrawl\.dev/[^ )\"'>]+" | \
    grep -vE '\.(json|yaml|yml|png|jpg|svg|css|js)$' | \
    sort -u)

if [ -z "$DISCOVERED_URLS" ]; then
    echo "WARNING: No docs URLs discovered. llms.txt may have changed format."
    exit 1
fi

echo "Found $(echo "$DISCOVERED_URLS" | wc -l | tr -d ' ') docs pages in llms.txt."

# Get URLs already in sync.json
EXISTING_URLS=$(jq -r '.sources[].url' "$MANIFEST" | sort -u)

# Find new pages not in sync.json
NEW_URLS=""
while IFS= read -r url; do
    [ -z "$url" ] && continue
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
        # e.g., https://docs.firecrawl.dev/features/scrape -> scrape.md
        path=$(echo "$url" | sed "s|${BASE_URL}/||;s|\.md$||")

        # Use last path segment for simple paths, prefix for deeper ones
        segments=$(echo "$path" | tr '/' '\n' | wc -l | tr -d ' ')
        if [ "$segments" -le 2 ]; then
            filename=$(basename "$path")
        else
            section=$(echo "$path" | cut -d'/' -f1)
            leaf=$(basename "$path")
            filename="${section}-${leaf}"
        fi

        target="skills/firecrawl/docs/${filename}.md"

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
    echo "  .github/workflows/scripts/sync-skill.sh skills/firecrawl --force"
else
    echo ""
    echo "To auto-add these to sync.json, run:"
    echo "  ./skills/firecrawl/discover-pages.sh --auto-add"
fi
