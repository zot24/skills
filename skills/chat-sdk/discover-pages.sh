#!/bin/bash
# discover-pages.sh - Discover new Chat SDK docs pages not yet in sync.json
# Usage: ./discover-pages.sh [--auto-add]
#
# chat-sdk.dev has been repurposed for an unrelated multi-platform chat-bot
# SDK product (Slack/Teams/Discord/etc adapters) and no longer hosts the
# Vercel AI Chatbot template docs this skill covers. Its llms.txt/sitemap
# only list unrelated-product pages, so there is nothing on that domain left
# to discover. The only remaining tracked source is the upstream GitHub
# README. This script checks that source is still reachable and otherwise
# no-ops, rather than crawling wrong-product pages into sync.json.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MANIFEST="$SCRIPT_DIR/sync.json"
README_URL="https://raw.githubusercontent.com/vercel/ai-chatbot/main/README.md"

AUTO_ADD=false
[[ "${1:-}" == "--auto-add" ]] && AUTO_ADD=true

command -v jq   >/dev/null || { echo "ERROR: jq is required"   >&2; exit 1; }
command -v curl >/dev/null || { echo "ERROR: curl is required" >&2; exit 1; }

echo "chat-sdk.dev has been repurposed for an unrelated product; skipping site crawl."
echo "Checking the only remaining tracked source: $README_URL"

HTTP_CODE=$(curl -sSL -o /dev/null -w '%{http_code}' --max-time 15 "$README_URL" 2>/dev/null || echo "000")

if [ "$HTTP_CODE" != "200" ]; then
    echo "WARNING: README fetch returned HTTP $HTTP_CODE. It may have moved." >&2
    exit 1
fi

TRACKED=$(jq -r '.sources[].url' "$MANIFEST" | sort -u)
if ! echo "$TRACKED" | grep -qxF "$README_URL"; then
    echo "WARNING: $README_URL is reachable but not tracked in sync.json." >&2
    exit 1
fi

echo "README source is reachable and tracked. Nothing to discover."
echo "If chat-sdk.dev is ever migrated back to Vercel AI Chatbot docs, add sources manually and revisit this script."

if [ "$AUTO_ADD" = "true" ]; then
    echo ""
    echo "Nothing to auto-add."
fi
