# Configuration

## Hook Configuration

### hooks.json

The hook is registered in `hooks/hooks.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PLUGIN_ROOT}/hooks/safe-delete-hook.sh"
          }
        ]
      }
    ]
  }
}
```

### CLAUDE_PLUGIN_ROOT

This environment variable is automatically set by Claude to the plugin directory. The hook script path is resolved relative to this.

## Customizing Blocked Patterns

Edit `hooks/safe-delete-hook.sh` to add or remove blocked patterns:

```bash
dangerous_patterns=(
    # Core patterns (don't remove these)
    'rm -rf /'
    'rm -rf ~'
    'rm -rf $HOME'
    'sudo rm -rf'

    # Add your own patterns
    'rm -rf /production'
    'rm -rf /var/www'
    'rm -rf /etc'
)
```

## Allow-List (Bypass Transformation)

To allow specific rm commands without transformation, add to the script:

```bash
# Before the transformation logic
allowed_patterns=(
    'rm -rf ./temp'
    'rm -rf /tmp/'
)

for pattern in "${allowed_patterns[@]}"; do
    if [[ "$command" == *"$pattern"* ]]; then
        exit 0  # Allow without transformation
    fi
done
```

## Disable Transformation (Block Only)

To only block dangerous patterns without transforming safe ones:

```bash
# Comment out or remove the STAGE 2 section in safe-delete-hook.sh
# ============================================================================
# STAGE 2: Transform rm to trash
# ============================================================================
# (comment out this entire section)
```

## Disable Blocking (Transform Only)

To only transform without blocking:

```bash
# Comment out or remove the STAGE 1 section in safe-delete-hook.sh
# ============================================================================
# STAGE 1: Block truly dangerous patterns
# ============================================================================
# (comment out this entire section)
```

## Environment Variables

You can use environment variables to configure behavior:

```bash
# In safe-delete-hook.sh, add at the top:
SAFE_DELETE_BLOCK_ONLY=${SAFE_DELETE_BLOCK_ONLY:-false}
SAFE_DELETE_TRANSFORM_ONLY=${SAFE_DELETE_TRANSFORM_ONLY:-false}

# Then conditionally skip stages based on these vars
```

## CLAUDE.md Customization

Edit `CLAUDE.md` to customize the instructions Claude receives:

```markdown
# Safe Delete

**NEVER use `rm` or `rm -rf`** — use `trash` instead.

## Exceptions

- OK to use `rm` in Dockerfiles (containers are ephemeral)
- OK to use `rm` in CI scripts (runners are disposable)
- Always use `trash` in development environments
```

## Per-Project Overrides

Create a project-specific `CLAUDE.md` that includes or overrides safe-delete rules:

```markdown
# Project Delete Policy

Include the safe-delete plugin CLAUDE.md, with these additions:

## Project-Specific Rules

- Never delete the `./data/` directory
- Always backup before deleting `./config/`
```

## Logging

To enable logging of hook decisions, add to `safe-delete-hook.sh`:

```bash
# At the top of the script
LOG_FILE="${CLAUDE_PLUGIN_ROOT}/.cache/hook.log"
mkdir -p "$(dirname "$LOG_FILE")"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >> "$LOG_FILE"
}

# In the deny function
deny() {
    local reason="$1"
    log "BLOCKED: $command - $reason"
    # ... rest of function
}

# In the transform function
transform() {
    local new_command="$1"
    log "TRANSFORMED: $command -> $new_command"
    # ... rest of function
}
```
