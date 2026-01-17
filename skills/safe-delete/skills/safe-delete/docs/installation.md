# Installation

## Install Trash Utility

### macOS (Homebrew)

```bash
brew install trash
```

After installation, add to your PATH:

```bash
echo 'export PATH="/opt/homebrew/opt/trash/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

Verify installation:

```bash
which trash
# /opt/homebrew/opt/trash/bin/trash
```

### Linux (trash-cli)

```bash
pip install trash-cli
```

Or via package manager:

```bash
# Ubuntu/Debian
sudo apt install trash-cli

# Fedora
sudo dnf install trash-cli

# Arch
sudo pacman -S trash-cli
```

Verify installation:

```bash
which trash-put
# /usr/bin/trash-put
```

Note: On Linux, the command is `trash-put` not `trash`. Create an alias:

```bash
echo 'alias trash="trash-put"' >> ~/.bashrc
source ~/.bashrc
```

## Install Safe-Delete Plugin

### Global Installation

Add to your global Claude settings (`~/.claude/settings.json`):

```json
{
  "plugins": [
    "path/to/skills/safe-delete"
  ]
}
```

### Per-Project Installation

Add to your project's `.claude/settings.json`:

```json
{
  "plugins": [
    "../path/to/skills/safe-delete"
  ]
}
```

Or add to your project's `.mcp.json` plugins section.

## Verify Installation

1. Start a new Claude session
2. Check that CLAUDE.md instructions are loaded
3. Try a test command:

```bash
# This should be transformed to: trash test.txt
rm test.txt
```

## Troubleshooting

### trash command not found

Ensure trash is in your PATH:

```bash
# Check current PATH
echo $PATH

# Add Homebrew bin to PATH (macOS)
export PATH="/opt/homebrew/opt/trash/bin:$PATH"

# Add to shell config for persistence
echo 'export PATH="/opt/homebrew/opt/trash/bin:$PATH"' >> ~/.zshrc
```

### Hook not triggering

1. Check that `hooks/hooks.json` exists
2. Verify `safe-delete-hook.sh` is executable: `chmod +x hooks/safe-delete-hook.sh`
3. Check Claude plugin loading in settings

### Permission denied on hook

```bash
chmod +x /path/to/skills/safe-delete/hooks/safe-delete-hook.sh
```
