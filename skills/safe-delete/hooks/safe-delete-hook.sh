#!/usr/bin/env bash
#
# Safe Delete Hook - PreToolUse hook for Bash commands
#
# Two-stage processing:
# 1. BLOCK truly dangerous patterns (rm -rf /, rm -rf ~, etc.)
# 2. TRANSFORM rm commands to trash equivalents
#
# Exit codes:
# - 0 with no output: Allow command unchanged
# - 0 with JSON output: Transform or block command
# - Non-zero: Hook error (command proceeds)

set -euo pipefail

# Read input from stdin
input=$(cat)

# Extract the command from JSON input
command=$(echo "$input" | jq -r '.tool_input.command // empty')

# If no command found, allow through
if [[ -z "$command" ]]; then
    exit 0
fi

# Function to output a deny response
deny() {
    local reason="$1"
    cat <<EOF
{
    "decision": "block",
    "reason": "$reason"
}
EOF
    exit 0
}

# Function to output a transform response
transform() {
    local new_command="$1"
    cat <<EOF
{
    "decision": "modify",
    "modifiedToolInput": {
        "command": "$new_command"
    }
}
EOF
    exit 0
}

# ============================================================================
# STAGE 1: Block truly dangerous patterns
# ============================================================================

# Normalize command for pattern matching (collapse whitespace)
normalized=$(echo "$command" | tr -s ' \t')

# Block exact dangerous patterns using string matching
# These patterns require exact matching (not regex) to avoid false positives

# Check for sudo rm -rf (always block)
if [[ "$normalized" == *"sudo rm -rf"* ]] || \
   [[ "$normalized" == *"sudo rm -Rf"* ]] || \
   [[ "$normalized" == *"sudo rm -fr"* ]]; then
    deny "Blocked dangerous command: 'sudo rm -rf' detected. This could cause catastrophic data loss."
fi

# Check for --no-preserve-root
if [[ "$normalized" == *"--no-preserve-root"* ]]; then
    deny "Blocked dangerous command: '--no-preserve-root' detected. This could cause catastrophic data loss."
fi

# Block rm -rf / (root directory) - must end with / or have / followed by space/end
if [[ "$normalized" =~ rm[[:space:]]+-[rRfF]+[[:space:]]+/[[:space:]]*$ ]] || \
   [[ "$normalized" =~ rm[[:space:]]+-[rRfF]+[[:space:]]+/$ ]]; then
    deny "Blocked dangerous command: 'rm -rf /' detected. Cannot delete root directory."
fi

# Block rm -rf ~ (home directory)
if [[ "$normalized" =~ rm[[:space:]]+-[rRfF]+[[:space:]]+~[[:space:]]*$ ]] || \
   [[ "$normalized" =~ rm[[:space:]]+-[rRfF]+[[:space:]]+~/ ]]; then
    deny "Blocked dangerous command: 'rm -rf ~' detected. Cannot delete home directory."
fi

# Block rm -rf $HOME or ${HOME}
if [[ "$normalized" == *'rm -rf $HOME'* ]] || \
   [[ "$normalized" == *'rm -rf ${HOME}'* ]] || \
   [[ "$normalized" == *'rm -Rf $HOME'* ]] || \
   [[ "$normalized" == *'rm -Rf ${HOME}'* ]]; then
    deny "Blocked dangerous command: 'rm -rf \$HOME' detected. Cannot delete home directory."
fi

# Block rm -rf . (current directory - exact match, not ./something)
if [[ "$normalized" =~ rm[[:space:]]+-[rRfF]+[[:space:]]+\.[[:space:]]*$ ]]; then
    deny "Blocked dangerous command: 'rm -rf .' detected. Cannot delete current directory."
fi

# Block rm -rf .. (parent directory)
if [[ "$normalized" =~ rm[[:space:]]+-[rRfF]+[[:space:]]+\.\.[[:space:]]*$ ]] || \
   [[ "$normalized" =~ rm[[:space:]]+-[rRfF]+[[:space:]]+\.\./ ]]; then
    deny "Blocked dangerous command: 'rm -rf ..' detected. Cannot delete parent directory."
fi

# Block rm -rf * (wildcard in current directory)
if [[ "$normalized" =~ rm[[:space:]]+-[rRfF]+[[:space:]]+\*[[:space:]]*$ ]]; then
    deny "Blocked dangerous command: 'rm -rf *' detected. Cannot delete with bare wildcard."
fi


# ============================================================================
# STAGE 2: Transform rm to trash
# ============================================================================

# Check if command contains rm (but not in a different context like "perform")
if [[ "$command" =~ (^|[[:space:]]|;|&&|\|\|)rm[[:space:]] ]]; then
    # Extract the rm portion and transform it
    # Handle various rm flags: -r, -f, -rf, -fr, -R, -Rf, etc.

    # Simple transformation: replace "rm" with "trash" and remove flags
    # trash doesn't need -r or -f flags

    new_command="$command"

    # Replace rm -rf, rm -fr, rm -Rf, rm -fR with trash
    new_command=$(echo "$new_command" | sed -E 's/(^|[[:space:];]|&&|\|\|)rm[[:space:]]+-[rRfF]+[[:space:]]+/\1trash /g')

    # Replace rm -r or rm -R with trash
    new_command=$(echo "$new_command" | sed -E 's/(^|[[:space:];]|&&|\|\|)rm[[:space:]]+-[rR][[:space:]]+/\1trash /g')

    # Replace rm -f with trash
    new_command=$(echo "$new_command" | sed -E 's/(^|[[:space:];]|&&|\|\|)rm[[:space:]]+-f[[:space:]]+/\1trash /g')

    # Replace plain rm with trash
    new_command=$(echo "$new_command" | sed -E 's/(^|[[:space:];]|&&|\|\|)rm[[:space:]]+/\1trash /g')

    # Only transform if something changed
    if [[ "$new_command" != "$command" ]]; then
        transform "$new_command"
    fi
fi

# No transformation needed, allow command through
exit 0
