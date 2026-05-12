#!/usr/bin/env bash
# Legacy bootstrap. Prefer `zskills sync` against the included skills.toml.
#
#   cargo install --git https://github.com/zot24/zskills
#   zskills sync --file ./skills.toml
#
# Kept for reference / minimal environments without Rust.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SKILLS_FILE="${1:-$SCRIPT_DIR/skills.txt}"

if [[ ! -f "$SKILLS_FILE" ]]; then
  echo "Error: skills file not found: $SKILLS_FILE" >&2
  exit 1
fi

while IFS= read -r line || [[ -n "$line" ]]; do
  [[ -z "$line" || "$line" =~ ^# ]] && continue
  source=$(echo "$line" | awk '{print $1}')
  skill=$(echo "$line" | awk '{print $2}')
  echo "==> Installing $skill from $source"
  bunx skills add "$source" --skill "$skill" --all -y
done < "$SKILLS_FILE"
