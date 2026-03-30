#!/bin/bash
# discover-pages.sh - Discover new docs pages not yet in sync.json
# Usage: ./discover-pages.sh [--auto-add]
#
# Crawls the Hermes docs site navigation and compares against sync.json.
# Reports any pages not yet tracked. With --auto-add, adds them to sync.json.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MANIFEST="$SCRIPT_DIR/sync.json"
BASE_URL="https://hermes-agent.nousresearch.com"
DOCS_URL="$BASE_URL/docs/"

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

echo "Discovering docs pages from: $DOCS_URL"

# Fetch the docs index and extract all /docs/ links from navigation
RAW_HTML=$(curl -sSL "$DOCS_URL" 2>/dev/null)

# Extract unique /docs/ paths from href attributes
DISCOVERED_PATHS=$(echo "$RAW_HTML" | \
    grep -oE 'href="(/docs/[^"#]+)"' | \
    sed 's/href="//;s/"$//' | \
    sed 's:/*$:/:' | \
    grep -vE '\.(css|js|ico|png|jpg|svg|woff|ttf|eot)/' | \
    grep -vE '/assets/' | \
    grep -vE '/img/' | \
    sort -u)

if [ -z "$DISCOVERED_PATHS" ]; then
    echo "WARNING: No docs paths discovered. Site may have changed structure."
    exit 1
fi

echo "Found $(echo "$DISCOVERED_PATHS" | wc -l | tr -d ' ') docs pages on site."

# Get URLs already in sync.json (normalize trailing slashes)
EXISTING_URLS=$(jq -r '.sources[].url' "$MANIFEST" | sed 's:/*$:/:' | sort -u)

# Find new pages not in sync.json
NEW_PAGES=""
while IFS= read -r path; do
    full_url="${BASE_URL}${path}"
    if ! echo "$EXISTING_URLS" | grep -qF "$full_url"; then
        NEW_PAGES="${NEW_PAGES}${path}\n"
    fi
done <<< "$DISCOVERED_PATHS"

# Filter out the bare /docs/ index (not a content page)
NEW_PAGES=$(echo -e "$NEW_PAGES" | grep -v '^/docs/$' | grep -v '^$' || true)

if [ -z "$NEW_PAGES" ]; then
    echo "All docs pages are already tracked in sync.json."
    exit 0
fi

echo ""
echo "=== NEW PAGES NOT IN sync.json ==="
echo -e "$NEW_PAGES" | while IFS= read -r path; do
    [ -z "$path" ] && continue
    echo "  ${BASE_URL}${path}"
done

if [ "$AUTO_ADD" = "true" ]; then
    echo ""
    echo "Auto-adding new pages to sync.json..."

    echo -e "$NEW_PAGES" | while IFS= read -r path; do
        [ -z "$path" ] && continue

        full_url="${BASE_URL}${path}"

        # Generate target filename from path
        # e.g., /docs/user-guide/profiles/ -> profiles.md
        # e.g., /docs/guides/use-mcp-with-hermes/ -> guide-use-mcp-with-hermes.md
        filename=$(echo "$path" | sed 's:^/docs/::;s:/*$::' | tr '/' '-')
        # Simplify: use just the last path segment for simple paths
        segments=$(echo "$path" | sed 's:^/docs/::;s:/*$::' | tr '/' '\n' | wc -l | tr -d ' ')
        if [ "$segments" -le 2 ]; then
            filename=$(basename "$path")
        else
            # For deeper paths, prefix with section
            section=$(echo "$path" | sed 's:^/docs/::' | cut -d'/' -f1)
            leaf=$(basename "$path")
            filename="${section}-${leaf}"
        fi

        target="skills/hermes/docs/${filename}.md"

        # Add to sync.json using jq
        tmp=$(mktemp)
        jq --arg url "$full_url" --arg target "$target" \
            '.sources += [{"url": $url, "target": $target, "type": "extract-content", "freshness_days": 7}]' \
            "$MANIFEST" > "$tmp"
        mv "$tmp" "$MANIFEST"

        echo "  Added: $full_url -> $target"
    done

    echo ""
    echo "Done. Run sync to fetch the new pages:"
    echo "  .github/workflows/scripts/sync-skill.sh skills/hermes --force"
else
    echo ""
    echo "To auto-add these to sync.json, run:"
    echo "  ./skills/hermes/discover-pages.sh --auto-add"
fi
