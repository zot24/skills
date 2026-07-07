#!/bin/bash
# discover-pages.sh - Discover new Flue docs pages not yet in sync.json
# Usage: ./discover-pages.sh [--auto-add]
#
# flueframework.com has no sitemap.xml or llms.txt (both 404 as of 2026-07).
# Its docs site renders a section-scoped sub-navigation on every page (Guide,
# Reference, CLI, SDK, Ecosystem), so visiting one representative page per
# top-level section is enough to enumerate that section's pages without a
# full site crawl. Reports any pages not yet tracked. With --auto-add, adds
# them to sync.json.
# URLs are normalized (trailing slash + optional .md suffix stripped) before comparison,
# since sync.json tracks canonical HTML URLs.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MANIFEST="$SCRIPT_DIR/sync.json"
BASE_URL="https://flueframework.com"

# One representative page per top-level docs section; each renders that
# section's full sub-navigation.
HUB_PATHS=(
    "/docs"
    "/docs/introduction/why-flue"
    "/docs/concepts/agents"
    "/docs/guide/channels"
    "/docs/api/agent-api"
    "/docs/sdk/overview"
    "/docs/cli/overview"
    "/docs/ecosystem"
    "/docs/reference/configuration"
)

AUTO_ADD=false
[[ "${1:-}" == "--auto-add" ]] && AUTO_ADD=true

command -v jq   >/dev/null || { echo "ERROR: jq is required"   >&2; exit 1; }
command -v curl >/dev/null || { echo "ERROR: curl is required" >&2; exit 1; }

# Normalize a URL for comparison: strip trailing slash and a trailing .md
normalize() { echo "$1" | sed -E 's#\.md$##; s#/$##'; }

echo "Crawling docs section hubs from: $BASE_URL/docs"

DISCOVERED_URLS=""
for hub in "${HUB_PATHS[@]}"; do
    HTML=$(curl -sSL --max-time 15 "${BASE_URL}${hub}" 2>/dev/null || true)
    if [ -z "$HTML" ]; then
        echo "  WARNING: could not fetch ${BASE_URL}${hub}"
        continue
    fi

    LINKS=$(printf '%s' "$HTML" | grep -oE 'href="/docs/[^"#]*"' | sed 's/href="//;s/"$//' \
        | grep -vE '\.(css|js|png|jpg|jpeg|svg|gif|webp|ico|md|webmanifest)$' \
        | sed -E 's#/$##' \
        | sort -u)
    DISCOVERED_URLS="${DISCOVERED_URLS}${LINKS}
"
done

DISCOVERED_URLS=$(printf '%s\n' "$DISCOVERED_URLS" | grep -v '^$' | sed "s#^#${BASE_URL}#" | sort -u)

if [ -z "$DISCOVERED_URLS" ]; then
    echo "WARNING: No docs URLs discovered. Site structure may have changed further."
    exit 1
fi

echo "Found $(echo "$DISCOVERED_URLS" | wc -l | tr -d ' ') candidate URLs across ${#HUB_PATHS[@]} section hubs."

# Normalized set of URLs already tracked
EXISTING_NORM=$(jq -r '.sources[].url' "$MANIFEST" | while IFS= read -r u; do normalize "$u"; done | sort -u)

NEW_URLS=""
while IFS= read -r url; do
    [ -z "$url" ] && continue
    norm=$(normalize "$url")
    if ! echo "$EXISTING_NORM" | grep -qxF "$norm"; then
        NEW_URLS="${NEW_URLS}${norm}\n"
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

if [ "$AUTO_ADD" = "true" ]; then
    echo ""
    echo "Auto-adding new pages to sync.json..."
    echo "$NEW_URLS" | while IFS= read -r url; do
        [ -z "$url" ] && continue
        # Derive docs/ target from URL path (mirrors build layout):
        #   /                     -> home.md
        #   /docs/guide/tools     -> guide/tools.md
        #   /blog/flue-1-0-beta   -> blog/flue-1-0-beta.md
        path=$(echo "$url" | sed -E "s#^${BASE_URL}##; s#^/##; s#/$##")
        if [ -z "$path" ]; then
            rel="home"
        else
            rel=$(echo "$path" | sed -E 's#^docs/##')
        fi
        target="skills/flue/docs/${rel}.md"
        tmp=$(mktemp)
        jq --arg url "$url" --arg target "$target" \
            '.sources += [{"url": $url, "target": $target, "type": "extract-content", "freshness_days": 14}]' \
            "$MANIFEST" > "$tmp"
        mv "$tmp" "$MANIFEST"
        echo "  Added: $url -> $target"
    done
    echo ""
    echo "Done. Run sync to fetch the new pages:"
    echo "  .github/workflows/scripts/sync-skill.sh skills/flue --force"
else
    echo ""
    echo "To auto-add these to sync.json, run:"
    echo "  ./skills/flue/discover-pages.sh --auto-add"
fi
