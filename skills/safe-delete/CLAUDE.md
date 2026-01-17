# Safe Delete

**NEVER use `rm` or `rm -rf`** — use `trash` instead.

## Required

- Always use `trash <path>` instead of `rm <path>`
- Always use `trash <path>` instead of `rm -rf <path>`
- The `trash` command moves files to Trash (recoverable) instead of permanent deletion

## Installation

If `trash` is not available, install it:

**macOS:**
```bash
brew install trash
echo 'export PATH="/opt/homebrew/opt/trash/bin:$PATH"' >> ~/.zshrc
```

**Linux:**
```bash
pip install trash-cli
```

## Why

- `rm -rf` permanently deletes files with no recovery option
- `trash` moves files to system Trash where they can be restored
- This prevents catastrophic data loss from typos or wrong paths
