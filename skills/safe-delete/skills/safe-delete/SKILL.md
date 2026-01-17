---
name: safe-delete
description: Prevents catastrophic file deletion by transforming rm to trash and blocking dangerous patterns. Use when discussing file deletion safety, rm alternatives, or trash utilities.
allowed-tools: Read, Bash, Glob, Grep
---

# Safe Delete

Expert on safe file deletion practices using trash instead of rm.

## Overview

- **Blocks dangerous patterns** like `rm -rf /`, `rm -rf ~`, `sudo rm -rf`
- **Transforms rm to trash** for recoverable deletion
- **Uses PreToolUse hooks** to intercept Bash commands
- **Provides CLAUDE.md instructions** so Claude uses trash by default
- **Works globally or per-project** via plugin installation

## How It Works

### Two-Layer Protection

1. **CLAUDE.md Instructions** - Tells Claude to use `trash` instead of `rm`
2. **PreToolUse Hook** - Catches rm commands and either blocks or transforms them

### Hook Processing Stages

**Stage 1: Block dangerous patterns**
- `rm -rf /`, `rm -rf ~`, `rm -rf .`, `rm -rf *`
- `sudo rm -rf` (any path)
- `--no-preserve-root` flag

**Stage 2: Transform safe rm to trash**
- `rm file.txt` → `trash file.txt`
- `rm -rf ./build` → `trash ./build`
- `rm -r dir/` → `trash dir/`

## Quick Start

```bash
# Install trash (macOS)
brew install trash
echo 'export PATH="/opt/homebrew/opt/trash/bin:$PATH"' >> ~/.zshrc

# Install trash (Linux)
pip install trash-cli
```

## Documentation

- **[Installation](docs/installation.md)** - Setup for macOS, Linux, global/per-project
- **[Dangerous Patterns](docs/dangerous-patterns.md)** - Full list of blocked patterns
- **[Trash Alternatives](docs/trash-alternatives.md)** - trash-cli usage guide
- **[Configuration](docs/configuration.md)** - Customizing blocked patterns

## Command Examples

```bash
# Check if a command would be blocked or transformed
/safe-delete check "rm -rf ./node_modules"

# Convert an rm command to trash
/safe-delete convert "rm -rf ./dist"

# List all blocked patterns
/safe-delete patterns

# Install trash utility
/safe-delete install
```

## Why Use This

| Command | Risk | Recovery |
|---------|------|----------|
| `rm -rf ./build` | Permanent deletion | None |
| `trash ./build` | Moves to Trash | Easy restore |
| `rm -rf /` | System destruction | Reinstall OS |

## Hook Response Examples

```json
// Blocked (dangerous)
{
  "decision": "block",
  "reason": "Blocked dangerous command: 'sudo rm -rf' pattern detected."
}

// Transformed (safe)
{
  "decision": "modify",
  "modifiedToolInput": {
    "command": "trash ./node_modules"
  }
}
```
