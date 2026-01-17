# Dangerous Patterns

These patterns are **blocked completely** by the safe-delete hook. They cannot be transformed safely and will return a deny response.

## Root and Home Directory

| Pattern | Risk Level | Description |
|---------|------------|-------------|
| `rm -rf /` | Critical | Deletes entire filesystem |
| `rm -rf ~` | Critical | Deletes user home directory |
| `rm -rf $HOME` | Critical | Deletes home (variable form) |
| `rm -rf ${HOME}` | Critical | Deletes home (braced form) |

## Current Directory and Wildcards

| Pattern | Risk Level | Description |
|---------|------------|-------------|
| `rm -rf .` | Critical | Deletes current directory |
| `rm -rf ..` | Critical | Deletes parent directory |
| `rm -rf *` | High | Deletes all files in current dir |

## Sudo Variants

| Pattern | Risk Level | Description |
|---------|------------|-------------|
| `sudo rm -rf` | Critical | Elevated privilege deletion |
| `sudo rm -Rf` | Critical | Case variant |
| `sudo rm -fr` | Critical | Flag order variant |

## Flag Variations

All of these are blocked with the patterns above:

| Flags | Meaning |
|-------|---------|
| `-rf` | Recursive, force |
| `-Rf` | Recursive (alt), force |
| `-fr` | Force, recursive |
| `-fR` | Force, recursive (alt) |

## Special Flags

| Pattern | Risk Level | Description |
|---------|------------|-------------|
| `--no-preserve-root` | Critical | Bypasses rm's built-in root protection |

## Regex Patterns Used

The hook uses these detection patterns:

```bash
# Direct pattern matching
'rm -rf /'
'rm -rf ~'
'sudo rm -rf'

# Regex for root-level paths
rm[[:space:]]+-[rRf]+[[:space:]]+\/[[:space:]]*$
```

## Why These Can't Be Transformed

1. **No safe equivalent** - `trash /` doesn't make sense
2. **Scope too broad** - Wildcards affect unknown files
3. **Elevated privileges** - sudo bypasses user protections
4. **Destructive flags** - `--no-preserve-root` indicates malicious intent

## What Gets Transformed Instead

Safe patterns with specific paths get transformed:

```bash
# These ARE transformed (not blocked)
rm -rf ./node_modules  →  trash ./node_modules
rm -rf ./build         →  trash ./build
rm ./temp.txt          →  trash ./temp.txt
```

## Adding Custom Patterns

To add your own blocked patterns, edit `hooks/safe-delete-hook.sh`:

```bash
dangerous_patterns=(
    # ... existing patterns ...

    # Add your custom patterns
    'rm -rf /important/path'
    'rm -rf /production'
)
```
