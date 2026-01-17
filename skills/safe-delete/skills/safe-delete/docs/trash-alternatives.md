# Trash Alternatives

## Overview

The `trash` command moves files to the system Trash/Recycle Bin instead of permanently deleting them. This allows recovery if you delete something by mistake.

## macOS: trash (Homebrew)

### Installation

```bash
brew install trash
echo 'export PATH="/opt/homebrew/opt/trash/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

### Usage

```bash
# Move file to Trash
trash file.txt

# Move directory to Trash
trash ./directory

# Move multiple items
trash file1.txt file2.txt directory/

# Verbose mode (show what's happening)
trash -v file.txt
```

### Trash Location

Files go to: `~/.Trash/`

### Recovery

1. Open Finder
2. Go to Trash (Cmd+Shift+Delete or click Trash in Dock)
3. Right-click file → "Put Back"

Or via command line:

```bash
# List trashed files
ls ~/.Trash/

# Restore manually
mv ~/.Trash/file.txt ./file.txt
```

## Linux: trash-cli

### Installation

```bash
# pip
pip install trash-cli

# Ubuntu/Debian
sudo apt install trash-cli

# Fedora
sudo dnf install trash-cli
```

### Commands

| Command | Description |
|---------|-------------|
| `trash-put` | Move files to trash |
| `trash-list` | List trashed files |
| `trash-restore` | Restore files from trash |
| `trash-empty` | Empty the trash |
| `trash-rm` | Remove specific items from trash |

### Usage

```bash
# Move to trash
trash-put file.txt

# Create alias for compatibility
alias trash="trash-put"

# List trashed files
trash-list

# Restore a file
trash-restore

# Empty trash (older than 30 days)
trash-empty 30

# Empty all trash
trash-empty
```

### Trash Location

Files go to: `~/.local/share/Trash/`

## Cross-Platform: Node.js trash-cli

### Installation

```bash
npm install -g trash-cli
```

### Usage

```bash
# Move to trash
trash file.txt

# Move directory
trash directory/
```

Works on macOS, Windows, and Linux.

## Comparison: rm vs trash

| Aspect | `rm` | `trash` |
|--------|------|---------|
| Recovery | Impossible | Easy |
| Speed | Faster | Slightly slower |
| Disk space | Freed immediately | Freed when emptied |
| Undo | No | Yes |
| System | Any Unix | Requires installation |

## Best Practices

1. **Always use trash for manual deletion**
   ```bash
   # Good
   trash ./node_modules

   # Risky
   rm -rf ./node_modules
   ```

2. **Use rm only in scripts where recovery isn't needed**
   ```bash
   # CI/CD cleanup (ephemeral environment)
   rm -rf ./dist
   ```

3. **Empty trash periodically**
   ```bash
   # Empty files older than 30 days
   trash-empty 30
   ```

4. **Check before emptying**
   ```bash
   # List what's in trash
   trash-list

   # Then empty if safe
   trash-empty
   ```
