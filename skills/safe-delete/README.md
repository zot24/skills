# Safe Delete

Prevents catastrophic file deletion by transforming `rm` commands to `trash` and blocking dangerous patterns like `rm -rf /`.

## Features

- **CLAUDE.md Instructions** - Tells Claude to always use `trash` instead of `rm`
- **PreToolUse Hook** - Intercepts Bash commands to block or transform `rm` usage
- **Two-Stage Protection**:
  1. Block truly dangerous patterns (no transformation possible)
  2. Transform safe `rm` commands to `trash` equivalents

## Installation

### 1. Install trash utility

**macOS:**
```bash
brew install trash
echo 'export PATH="/opt/homebrew/opt/trash/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

**Linux:**
```bash
pip install trash-cli
# Create alias for compatibility
echo 'alias trash="trash-put"' >> ~/.bashrc
```

### 2. Install plugin

Add to your Claude settings:

```json
{
  "plugins": [
    "path/to/skills/safe-delete"
  ]
}
```

## How It Works

### Blocked Patterns (Stage 1)

These commands are **blocked completely**:

| Pattern | Risk |
|---------|------|
| `rm -rf /` | Deletes entire filesystem |
| `rm -rf ~` | Deletes home directory |
| `rm -rf .` | Deletes current directory |
| `rm -rf *` | Deletes all files |
| `sudo rm -rf` | Elevated privilege deletion |

### Transformed Commands (Stage 2)

Safe `rm` commands are transformed:

| Original | Transformed |
|----------|-------------|
| `rm file.txt` | `trash file.txt` |
| `rm -rf ./build` | `trash ./build` |
| `rm -r directory/` | `trash directory/` |

## Slash Command

```bash
# Check if a command would be blocked/transformed
/safe-delete check "rm -rf ./node_modules"

# Convert rm to trash
/safe-delete convert "rm -rf ./dist"

# List blocked patterns
/safe-delete patterns

# Installation help
/safe-delete install
```

## Files

```
safe-delete/
├── .claude-plugin/
│   └── plugin.json           # Plugin metadata
├── CLAUDE.md                 # Instructions for Claude
├── commands/
│   └── safe-delete.md        # Slash command
├── hooks/
│   ├── hooks.json            # Hook configuration
│   └── safe-delete-hook.sh   # Block + transform logic
├── skills/safe-delete/
│   ├── SKILL.md              # Skill overview
│   └── docs/
│       ├── installation.md
│       ├── dangerous-patterns.md
│       ├── trash-alternatives.md
│       └── configuration.md
├── sync.json
├── .gitignore
└── README.md
```

## Why trash Instead of rm

| Aspect | `rm` | `trash` |
|--------|------|---------|
| Recovery | Impossible | Open Trash, restore |
| Undo | No | Yes |
| Risk | High | Low |

## Configuration

See `skills/safe-delete/docs/configuration.md` for:
- Adding custom blocked patterns
- Creating allow-lists
- Enabling logging
- Environment variables

## License

MIT
