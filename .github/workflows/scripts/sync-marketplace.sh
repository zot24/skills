#!/usr/bin/env bash
# Sync .claude-plugin/marketplace.json plugin entries from each skill's plugin.json version.
# Idempotent: only writes when a version has actually drifted.
#
# This is a safety net for the release-please cross-package extra-files path
# (../../.claude-plugin/marketplace.json). If that resolves correctly, this is a no-op.
# If it doesn't, this script keeps marketplace.json in sync with plugin.json on push to main.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
cd "$REPO_ROOT"

MP=".claude-plugin/marketplace.json"
if [ ! -f "$MP" ]; then
  echo "marketplace.json not found at $MP" >&2
  exit 1
fi

CHANGED=0
for plugin_file in skills/*/.claude-plugin/plugin.json; do
  [ -f "$plugin_file" ] || continue
  SKILL=$(basename "$(dirname "$(dirname "$plugin_file")")")
  PLUGIN_VERSION=$(jq -r '.version' "$plugin_file")

  if [ -z "$PLUGIN_VERSION" ] || [ "$PLUGIN_VERSION" = "null" ]; then
    echo "Warning: $SKILL plugin.json missing .version" >&2
    continue
  fi

  MP_VERSION=$(jq -r --arg n "$SKILL" '.plugins[] | select(.name == $n) | .version' "$MP")
  if [ -z "$MP_VERSION" ] || [ "$MP_VERSION" = "null" ]; then
    echo "Warning: $SKILL has no entry in marketplace.json" >&2
    continue
  fi

  if [ "$PLUGIN_VERSION" != "$MP_VERSION" ]; then
    echo "Updating $SKILL: $MP_VERSION -> $PLUGIN_VERSION"
    tmp=$(mktemp)
    jq --arg n "$SKILL" --arg v "$PLUGIN_VERSION" \
      '(.plugins[] | select(.name == $n) | .version) = $v' "$MP" > "$tmp"
    mv "$tmp" "$MP"
    CHANGED=1
  fi
done

if [ "$CHANGED" = "1" ]; then
  echo "marketplace.json updated."
else
  echo "marketplace.json already in sync."
fi
