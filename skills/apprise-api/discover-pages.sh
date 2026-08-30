#!/bin/bash
# discover-pages.sh - Discover new Apprise docs pages not yet in sync.json
# Usage: ./discover-pages.sh [--auto-add]
#
# appriseit.com is a statically generated site with no sitemap.xml or llms.txt,
# but its Markdown source lives in caronc/apprise-docs under locales/en/. This
# script enumerates that tree via the GitHub API and reports pages relevant to
# the API skill that sync.json does not already track. With --auto-add, it
# appends them to sync.json with a derived docs/ target.
#
# Scope: api/, getting-started/, cli/, qa/, guides/ plus the two services pages
# the skill tracks. The 200+ per-service pages, the Python library section, the
# mobile app, and contributing docs are deliberately out of scope.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MANIFEST="$SCRIPT_DIR/sync.json"
REPO="caronc/apprise-docs"
BRANCH="master"
RAW_BASE="https://raw.githubusercontent.com/${REPO}/${BRANCH}/locales/en"

# Path prefixes worth tracking for an API-focused skill
INCLUDE_PREFIXES=(
    "api/"
    "getting-started/"
    "cli/"
    "qa/"
    "guides/"
)
# Individual pages outside those prefixes
INCLUDE_EXACT=(
    "services/index.md"
    "services/apprise_api/index.md"
)

AUTO_ADD=false
[[ "${1:-}" == "--auto-add" ]] && AUTO_ADD=true

command -v jq   >/dev/null || { echo "ERROR: jq is required"   >&2; exit 1; }
command -v curl >/dev/null || { echo "ERROR: curl is required" >&2; exit 1; }

echo "Listing docs tree from: github.com/${REPO}@${BRANCH} (locales/en)"

AUTH=()
[ -n "${GITHUB_TOKEN:-}" ] && AUTH=(-H "Authorization: Bearer ${GITHUB_TOKEN}")

TREE=$(curl -sSL --max-time 30 ${AUTH[@]+"${AUTH[@]}"} \
    "https://api.github.com/repos/${REPO}/git/trees/${BRANCH}?recursive=1" 2>/dev/null || true)

if [ -z "$TREE" ] || [ "$(printf '%s' "$TREE" | jq -r 'has("tree")')" != "true" ]; then
    echo "ERROR: could not list the repository tree (rate limited, or the repo/branch moved)." >&2
    exit 1
fi

if [ "$(printf '%s' "$TREE" | jq -r '.truncated')" = "true" ]; then
    echo "WARNING: GitHub truncated the tree listing; results may be incomplete."
fi

ALL_PATHS=$(printf '%s' "$TREE" \
    | jq -r '.tree[] | select(.type == "blob") | .path' \
    | sed -n 's#^locales/en/##p' \
    | grep -E '\.(md|mdx)$' \
    | sort -u)

# Filter to the in-scope subset
CANDIDATES=""
while IFS= read -r rel; do
    [ -z "$rel" ] && continue
    keep=false
    for p in "${INCLUDE_PREFIXES[@]}"; do
        case "$rel" in "$p"*) keep=true ;; esac
    done
    for e in "${INCLUDE_EXACT[@]}"; do
        [ "$rel" = "$e" ] && keep=true
    done
    # Skip partials/templates, which are fragments rather than pages
    case "$rel" in _*/*|*/_*) keep=false ;; esac
    [ "$keep" = true ] && CANDIDATES="${CANDIDATES}${rel}"$'\n'
done <<< "$ALL_PATHS"

CANDIDATES=$(printf '%s' "$CANDIDATES" | grep -v '^$' | sort -u || true)

if [ -z "$CANDIDATES" ]; then
    echo "WARNING: No in-scope pages found. The docs repo layout may have changed."
    exit 1
fi

echo "Found $(printf '%s\n' "$CANDIDATES" | wc -l | tr -d ' ') in-scope pages."

EXISTING=$(jq -r '.sources[].url' "$MANIFEST" | sort -u)

# Derive a docs/ target basename from an upstream relative path:
#   api/endpoints.md              -> endpoints.md
#   api/reference/environment.md  -> reference-environment.md
#   services/apprise_api/index.md -> services-apprise-api.md
#   qa/index.md                   -> qa.md
derive_target() {
    printf '%s' "$1" \
        | sed -E 's#\.mdx?$##; s#/index$##' \
        | tr '/_' '--' \
        | sed -E 's#-+#-#g'
}

NEW_PAGES=""
while IFS= read -r rel; do
    [ -z "$rel" ] && continue
    url="${RAW_BASE}/${rel}"
    if ! printf '%s\n' "$EXISTING" | grep -qxF "$url"; then
        NEW_PAGES="${NEW_PAGES}${rel}"$'\n'
    fi
done <<< "$CANDIDATES"

NEW_PAGES=$(printf '%s' "$NEW_PAGES" | grep -v '^$' || true)

if [ -z "$NEW_PAGES" ]; then
    echo "All in-scope pages are already tracked in sync.json."
    exit 0
fi

echo ""
echo "=== NEW PAGES NOT IN sync.json ==="
printf '%s\n' "$NEW_PAGES" | while IFS= read -r rel; do
    [ -n "$rel" ] && echo "  ${rel}  ->  docs/$(derive_target "$rel").md"
done

if [ "$AUTO_ADD" = "true" ]; then
    echo ""
    echo "Auto-adding new pages to sync.json..."
    while IFS= read -r rel; do
        [ -z "$rel" ] && continue
        url="${RAW_BASE}/${rel}"
        target="skills/apprise-api/docs/$(derive_target "$rel").md"
        # .mdx sources carry MDX imports/components; extract-content strips them
        case "$rel" in
            *.mdx) type="extract-content" ;;
            *)     type="raw" ;;
        esac
        tmp=$(mktemp)
        jq --arg url "$url" --arg target "$target" --arg type "$type" \
            '.sources += [{"url": $url, "target": $target, "type": $type, "freshness_days": 14}]' \
            "$MANIFEST" > "$tmp"
        mv "$tmp" "$MANIFEST"
        echo "  Added: $rel -> $target"
    done <<< "$NEW_PAGES"
    echo ""
    echo "Done. Run sync to fetch the new pages:"
    echo "  .github/workflows/scripts/sync-skill.sh skills/apprise-api --force"
else
    echo ""
    echo "To auto-add these to sync.json, run:"
    echo "  ./skills/apprise-api/discover-pages.sh --auto-add"
fi
