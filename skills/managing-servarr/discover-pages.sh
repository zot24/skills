#!/bin/bash
# discover-pages.sh - Discover new docs pages from wiki.servarr.com
# Usage: ./discover-pages.sh [--auto-add]
#
# Crawls the Servarr wiki navigation and compares against sync.json.
# Reports any pages not yet tracked. With --auto-add, adds them to sync.json.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MANIFEST="$SCRIPT_DIR/sync.json"
BASE_URL="https://wiki.servarr.com"

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

echo "Discovering docs pages from: $BASE_URL"

# Target apps to crawl
APPS=("sonarr" "radarr" "lidarr" "prowlarr" "bazarr")

ALL_DISCOVERED=""

for APP in "${APPS[@]}"; do
    APP_URL="${BASE_URL}/en/${APP}"
    echo "Crawling: $APP_URL"

    RAW_HTML=$(curl -sSL "$APP_URL" 2>/dev/null || echo "")

    if [ -z "$RAW_HTML" ]; then
        echo "  WARNING: Could not fetch $APP_URL"
        continue
    fi

    # Extract unique /en/<app>/ links from navigation
    PATHS=$(echo "$RAW_HTML" | \
        grep -oE "href=\"(/en/${APP}/[^\"#]+)\"" | \
        sed 's/href="//;s/"$//' | \
        grep -vE '\.(css|js|ico|png|jpg|svg)$' | \
        sort -u)

    if [ -n "$PATHS" ]; then
        COUNT=$(echo "$PATHS" | wc -l | tr -d ' ')
        echo "  Found $COUNT pages for $APP"
        ALL_DISCOVERED="${ALL_DISCOVERED}${PATHS}\n"
    fi
done

ALL_DISCOVERED=$(echo -e "$ALL_DISCOVERED" | grep -v '^$' | sort -u || true)

if [ -z "$ALL_DISCOVERED" ]; then
    echo "WARNING: No pages discovered. Wiki may use JavaScript rendering."
    echo "Consider using Firecrawl to scrape: firecrawl crawl $BASE_URL"
    exit 1
fi

echo ""
echo "Total pages discovered: $(echo "$ALL_DISCOVERED" | wc -l | tr -d ' ')"

# Get URLs already in sync.json
EXISTING_URLS=$(jq -r '.sources[].url' "$MANIFEST" | sort -u)

# Find new pages not in sync.json
NEW_PAGES=""
while IFS= read -r path; do
    [ -z "$path" ] && continue
    full_url="${BASE_URL}${path}"
    if ! echo "$EXISTING_URLS" | grep -qF "$full_url"; then
        NEW_PAGES="${NEW_PAGES}${path}\n"
    fi
done <<< "$ALL_DISCOVERED"

NEW_PAGES=$(echo -e "$NEW_PAGES" | grep -v '^$' || true)

if [ -z "$NEW_PAGES" ]; then
    echo "All discovered pages are already tracked in sync.json."
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

        # Generate target filename: /en/sonarr/settings -> sonarr-settings.md
        filename=$(echo "$path" | sed 's:^/en/::;s:/*$::' | tr '/' '-')
        target="skills/managing-servarr/docs/${filename}.md"

        tmp=$(mktemp)
        jq --arg url "$full_url" --arg target "$target" \
            '.sources += [{"url": $url, "target": $target, "type": "extract-content", "freshness_days": 30}]' \
            "$MANIFEST" > "$tmp"
        mv "$tmp" "$MANIFEST"

        echo "  Added: $full_url -> $target"
    done

    echo ""
    echo "Done. Run sync to fetch the new pages:"
    echo "  .github/workflows/scripts/sync-skill.sh skills/managing-servarr --force"
else
    echo ""
    echo "To auto-add these to sync.json, run:"
    echo "  ./skills/managing-servarr/discover-pages.sh --auto-add"
    echo ""
    echo "Alternatively, use Firecrawl for better content extraction:"
    echo "  firecrawl crawl $BASE_URL --output skills/managing-servarr/docs/"
fi
