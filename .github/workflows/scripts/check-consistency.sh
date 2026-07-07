#!/bin/bash
# check-consistency.sh - Verify all skill manifests agree on the skill set and versions.
#
# Checks (against `.claude-plugin/marketplace.json` as the reference set):
#   1. Every skills/*/ dir with a .claude-plugin/plugin.json is in the marketplace, and vice versa.
#   2. skills.toml names match the reference set exactly.
#   3. release-please-config.json packages match the reference set minus EXEMPT_RELEASE.
#   4. sync-docs.yml SKILLS array matches the reference set minus EXEMPT_SYNC.
#   5. Per-skill version agreement across sync.json, plugin.json, and marketplace.json.
#
# Usage: .github/workflows/scripts/check-consistency.sh
# Requires: jq

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
cd "$REPO_ROOT"

# Allowlists: skills deliberately exempt from a given manifest. Empty by default.
EXEMPT_RELEASE=""
EXEMPT_SYNC="safe-delete gh-issue-tracker"

MISMATCHES=0

mismatch() {
  echo "MISMATCH: $1 $2 $3"
  MISMATCHES=$((MISMATCHES + 1))
}

contains() {
  # contains <needle> <haystack-words...>
  local needle="$1"
  shift
  local w
  for w in "$@"; do
    [ "$w" = "$needle" ] && return 0
  done
  return 1
}

# --- Reference set: marketplace.json plugin names ---
REF=($(jq -r '.plugins[].name' .claude-plugin/marketplace.json | sort))

# --- Check 1: skills/*/ dirs with plugin.json vs marketplace ---
SKILL_DIRS=($(find skills -maxdepth 1 -mindepth 1 -type d -exec test -f '{}/.claude-plugin/plugin.json' \; -print | xargs -n1 basename | sort))

for name in "${SKILL_DIRS[@]}"; do
  if ! contains "$name" "${REF[@]}"; then
    mismatch "marketplace.json" "missing" "$name"
  fi
done
for name in "${REF[@]}"; do
  if ! contains "$name" "${SKILL_DIRS[@]}"; then
    mismatch "skills/*/.claude-plugin/plugin.json" "missing" "$name"
  fi
done

# --- Check 2: skills.toml ---
TOML_NAMES=($(grep -E '^[[:space:]]*name[[:space:]]*=[[:space:]]*"' skills.toml | sed -E 's/^[[:space:]]*name[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/' | sort))

for name in "${REF[@]}"; do
  if ! contains "$name" "${TOML_NAMES[@]}"; then
    mismatch "skills.toml" "missing" "$name"
  fi
done
for name in "${TOML_NAMES[@]}"; do
  if ! contains "$name" "${REF[@]}"; then
    mismatch "skills.toml" "extra" "$name"
  fi
done

# --- Check 3: release-please-config.json ---
RP_NAMES=($(jq -r '.packages | keys[]' release-please-config.json | sed 's#^skills/##' | sort))

for name in "${REF[@]}"; do
  if contains "$name" $EXEMPT_RELEASE; then
    continue
  fi
  if ! contains "$name" "${RP_NAMES[@]}"; then
    mismatch "release-please-config.json" "missing" "$name"
  fi
done
for name in "${RP_NAMES[@]}"; do
  if ! contains "$name" "${REF[@]}"; then
    mismatch "release-please-config.json" "extra" "$name"
  fi
done

# --- Check 4: sync-docs.yml SKILLS array ---
SYNC_LINE=$(grep -m1 'SKILLS=(' .github/workflows/sync-docs.yml || true)
SYNC_NAMES=($(echo "$SYNC_LINE" | grep -oE '"[^"]+"' | tr -d '"' | sort))

for name in "${REF[@]}"; do
  if contains "$name" $EXEMPT_SYNC; then
    continue
  fi
  if ! contains "$name" "${SYNC_NAMES[@]}"; then
    mismatch "sync-docs.yml SKILLS" "missing" "$name"
  fi
done
for name in "${SYNC_NAMES[@]}"; do
  if contains "$name" $EXEMPT_SYNC; then
    mismatch "sync-docs.yml SKILLS" "extra (should be exempt)" "$name"
    continue
  fi
  if ! contains "$name" "${REF[@]}"; then
    mismatch "sync-docs.yml SKILLS" "extra" "$name"
  fi
done

# --- Check 5: per-skill version agreement ---
for name in "${REF[@]}"; do
  sync_file="skills/$name/sync.json"
  plugin_file="skills/$name/.claude-plugin/plugin.json"

  if [ ! -f "$sync_file" ] || [ ! -f "$plugin_file" ]; then
    mismatch "version files" "missing" "$name"
    continue
  fi

  sync_ver=$(jq -r '.version // "MISSING"' "$sync_file")
  plugin_ver=$(jq -r '.version // "MISSING"' "$plugin_file")
  market_ver=$(jq -r --arg n "$name" '.plugins[] | select(.name==$n) | .version' .claude-plugin/marketplace.json)

  if [ "$sync_ver" != "$plugin_ver" ] || [ "$plugin_ver" != "$market_ver" ]; then
    mismatch "version" "disagreement" "$name (sync=$sync_ver plugin=$plugin_ver marketplace=$market_ver)"
  fi
done

if [ "$MISMATCHES" -gt 0 ]; then
  echo "Found $MISMATCHES mismatch(es)."
  exit 1
fi

echo "All manifests consistent"
exit 0
