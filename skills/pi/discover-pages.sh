#!/bin/bash
# discover-pages.sh - Discover new Pi docs pages not yet in sync.json
# Usage: ./discover-pages.sh [--auto-add]
#
# pi.dev has no sitemap.xml or llms.txt (both 404 as of 2026-08).
# Crawl the /docs/latest HTML hub. Do not parse docs.json: it is a
# strict subset of the HTML nav, and mapping index.md would re-add the
# overview on every CI run.
# Strip docs/latest/ (not docs/) when deriving targets.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MANIFEST="$SCRIPT_DIR/sync.json"
BASE_URL="https://pi.dev"
HUB_PATH="/docs/latest"

# Platform Setup (load-bearing) plus belt-and-braces for redirects / image assets.
# session, tree, and images/ do not appear as HTML hrefs today.
DENY_SLUGS="windows termux tmux terminal-setup shell-aliases session tree"

AUTO_ADD=false
[[ "${1:-}" == "--auto-add" ]] && AUTO_ADD=true

command -v jq   >/dev/null || { echo "ERROR: jq is required"   >&2; exit 1; }
command -v curl >/dev/null || { echo "ERROR: curl is required" >&2; exit 1; }

# Normalize a URL for comparison: strip trailing slash and a trailing .md
normalize() { echo "$1" | sed -E 's#\.md$##; s#/$##'; }

denied() {
    local rel="$1"
    case "$rel" in
        images|images/*) return 0 ;;
    esac
    for slug in $DENY_SLUGS; do
        if [ "$rel" = "$slug" ]; then
            return 0
        fi
    done
    return 1
}

# Bash expansion, not sed: macOS BSD sed treats s#pattern## as an
# unclosed substitute (the next # starts a comment), so chained
# s#...## commands fail and the denylist never sees a slug.
rel_from_url() {
    local url="$1"
    url="${url#"$BASE_URL"}"
    url="${url#/}"
    url="${url%/}"
    if [ -z "$url" ] || [ "$url" = "docs/latest" ]; then
        echo "index"
    else
        echo "${url#docs/latest/}"
    fi
}

echo "Crawling docs hub from: ${BASE_URL}${HUB_PATH}"

HTML=$(curl -sSL --max-time 15 "${BASE_URL}${HUB_PATH}" 2>/dev/null || true)
if [ -z "$HTML" ]; then
    echo "WARNING: could not fetch ${BASE_URL}${HUB_PATH}"
    exit 1
fi

LINKS=$(printf '%s' "$HTML" | grep -oE 'href="/docs/latest[^"#]*"' | sed 's/href="//;s/"$//' \
    | grep -vE '\.(css|js|png|jpg|jpeg|svg|gif|webp|ico|md|webmanifest)$' \
    | sed -E 's#/$##' \
    | sort -u)

DISCOVERED_URLS=$(printf '%s\n' "$LINKS" | grep -v '^$' | sed "s#^#${BASE_URL}#" | sort -u)

if [ -z "$DISCOVERED_URLS" ]; then
    echo "WARNING: No docs URLs discovered. Site structure may have changed further."
    exit 1
fi

echo "Found $(echo "$DISCOVERED_URLS" | wc -l | tr -d ' ') candidate URLs on the hub."

EXISTING_NORM=$(jq -r '.sources[].url' "$MANIFEST" | while IFS= read -r u; do normalize "$u"; done | sort -u)

NEW_URLS=""
while IFS= read -r url; do
    [ -z "$url" ] && continue
    norm=$(normalize "$url")
    rel=$(rel_from_url "$norm")
    case "$rel" in
        */latest/*|latest/*)
            echo "ERROR: derived rel still contains latest/: $rel (from $norm)" >&2
            exit 1
            ;;
    esac
    if denied "$rel"; then
        continue
    fi
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
    while IFS= read -r url; do
        [ -z "$url" ] && continue
        rel=$(rel_from_url "$url")
        target="skills/pi/docs/${rel}.md"
        case "$target" in
            */latest/*)
                echo "ERROR: target still contains latest/: $target" >&2
                exit 1
                ;;
        esac
        tmp=$(mktemp)
        jq --arg url "$url" --arg target "$target" \
            '.sources += [{"url": $url, "target": $target, "type": "extract-content", "freshness_days": 14}]' \
            "$MANIFEST" > "$tmp"
        mv "$tmp" "$MANIFEST"
        echo "  Added: $url -> $target"
    done < <(echo "$NEW_URLS")
    echo ""
    echo "Done. Run sync to fetch the new pages:"
    echo "  .github/workflows/scripts/sync-skill.sh skills/pi --force"
else
    echo ""
    echo "To auto-add these to sync.json, run:"
    echo "  ./skills/pi/discover-pages.sh --auto-add"
fi
