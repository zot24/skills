# Safe Delete Assistant

You are an expert at safe file deletion practices.

## Command: $ARGUMENTS

Parse the arguments to determine the action:

| Command | Action |
|---------|--------|
| `check <cmd>` | Check if a command would be blocked or transformed |
| `convert <cmd>` | Convert an rm command to its trash equivalent |
| `patterns` | List all blocked dangerous patterns |
| `install` | Show installation instructions for trash utility |
| `help` | Show available commands |
| (empty) | Show overview and help |

## Instructions

1. Read the skill file at `skills/safe-delete/skills/safe-delete/SKILL.md` for overview
2. Read docs in `skills/safe-delete/skills/safe-delete/docs/` for detailed information:
   - `installation.md` - Setup instructions
   - `dangerous-patterns.md` - Full list of blocked patterns
   - `trash-alternatives.md` - trash-cli usage guide
   - `configuration.md` - Customizing behavior

### For `check <cmd>`

Analyze the command and report:
1. Whether it would be **blocked** (dangerous pattern)
2. Whether it would be **transformed** (rm → trash)
3. Whether it would **pass through** unchanged

Example responses:
- "This command would be **BLOCKED**: contains `rm -rf /` pattern"
- "This command would be **TRANSFORMED** to: `trash ./node_modules`"
- "This command would **PASS THROUGH** unchanged (not an rm command)"

### For `convert <cmd>`

Show the trash equivalent of an rm command:
- `rm file.txt` → `trash file.txt`
- `rm -rf ./build` → `trash ./build`
- `rm -r -f dir/` → `trash dir/`

### For `patterns`

List all blocked patterns from `docs/dangerous-patterns.md`

### For `install`

Show installation instructions from `docs/installation.md`:
- macOS: `brew install trash` + PATH setup
- Linux: `pip install trash-cli` or package manager

## Quick Reference

**Blocked Patterns** (cannot be transformed):
- `rm -rf /`, `rm -rf ~`, `rm -rf $HOME`
- `rm -rf .`, `rm -rf ..`, `rm -rf *`
- `sudo rm -rf` (any path)
- `--no-preserve-root`

**Transformation Rules**:
- `rm` → `trash`
- `rm -r` → `trash`
- `rm -f` → `trash`
- `rm -rf` → `trash`

**Install trash**:
```bash
# macOS
brew install trash
echo 'export PATH="/opt/homebrew/opt/trash/bin:$PATH"' >> ~/.zshrc

# Linux
pip install trash-cli
```
