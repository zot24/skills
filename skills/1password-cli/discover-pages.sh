#!/bin/bash
# discover-pages.sh - Discover new 1Password CLI docs pages not yet in sync.json
# Usage: ./discover-pages.sh [--auto-add]
#
# Fetches the sitemap.xml from 1password.dev and compares against sync.json.
# Only /cli/ and /service-accounts/ and /connect/cli pages are considered.
# Reports any pages not yet tracked. With --auto-add, adds them to sync.json.
# URLs are normalized (trailing slash + optional .md suffix stripped) before comparison.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MANIFEST="$SCRIPT_DIR/sync.json"
BASE_URL="https://www.1password.dev"
INDEX_URL="$BASE_URL/sitemap.xml"

AUTO_ADD=false
[[ "${1:-}" == "--auto-add" ]] && AUTO_ADD=true

command -v jq   >/dev/null || { echo "ERROR: jq is required"   >&2; exit 1; }
command -v curl >/dev/null || { echo "ERROR: curl is required" >&2; exit 1; }

# Normalize a URL for comparison: strip trailing slash and a trailing .md
normalize() { echo "$1" | sed -E 's#\.md$##; s#/$##'; }

echo "Discovering CLI docs pages from: $INDEX_URL"

RAW_INDEX=$(curl -sSL "$INDEX_URL" 2>/dev/null || true)

# CLI-relevant pages only. Exclude the long per-tool shell-plugins list and the
# per-command reference leaves (a handful of the most useful reference pages are
# tracked explicitly in sync.json), to keep the cached set focused.
DISCOVERED_URLS=$(echo "$RAW_INDEX" | \
    grep -oE 'https://www\.1password\.dev/(cli|service-accounts|connect)[^<[:space:]]*' | \
    grep -vE '\.(png|jpg|jpeg|svg|gif|webp|ico|css|js)$' | \
    grep -vE '^https://www\.1password\.dev/cli/shell-plugins/.+' | \
    grep -vE '^https://www\.1password\.dev/connect/(api-reference|ansible|aws-ecs-fargate|concepts|get-started|manage-connect|security|server-configuration)' | \
    while IFS= read -r u; do normalize "$u"; done | \
    grep -vE '^https://www\.1password\.dev/(cli|service-accounts|connect)$' | \
    sort -u || true)

if [ -z "$DISCOVERED_URLS" ]; then
    echo "WARNING: No CLI docs URLs discovered. Site may not expose sitemap.xml, or structure changed."
    exit 1
fi

echo "Found $(echo "$DISCOVERED_URLS" | wc -l | tr -d ' ') candidate CLI docs URLs in index."

# Normalized set of URLs already tracked
EXISTING_NORM=$(jq -r '.sources[].url' "$MANIFEST" | while IFS= read -r u; do normalize "$u"; done | sort -u)

NEW_URLS=""
while IFS= read -r url; do
    [ -z "$url" ] && continue
    if ! echo "$EXISTING_NORM" | grep -qxF "$url"; then
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

if [ "$AUTO_ADD" = "true" ]; then
    echo ""
    echo "Auto-adding new pages to sync.json..."
    echo "$NEW_URLS" | while IFS= read -r url; do
        [ -z "$url" ] && continue
        # Derive docs/ target from URL path:
        #   /cli/item-create                    -> cli/item-create.md
        #   /service-accounts/use-with-...       -> service-accounts/use-with-...md
        #   /connect/cli                         -> connect/cli.md
        rel=$(echo "$url" | sed -E "s#^${BASE_URL}/##; s#/\$##")
        target="skills/1password-cli/docs/${rel}.md"
        tmp=$(mktemp)
        jq --arg url "$url/" --arg target "$target" \
            '.sources += [{"url": $url, "target": $target, "type": "extract-content", "freshness_days": 14}]' \
            "$MANIFEST" > "$tmp"
        mv "$tmp" "$MANIFEST"
        echo "  Added: $url -> $target"
    done
    echo ""
    echo "Done. Run sync to fetch the new pages:"
    echo "  .github/workflows/scripts/sync-skill.sh skills/1password-cli --force"
else
    echo ""
    echo "To auto-add these to sync.json, run:"
    echo "  ./skills/1password-cli/discover-pages.sh --auto-add"
fi
