<!-- Source: https://www.1password.dev/cli/reference/ -->

# 1Password CLI Reference

## Overview

The 1Password CLI uses a "noun-verb command structure that groups commands by topic rather than by operation." Commands follow the basic pattern: `op [command] <flags>`.

## Command Reference

### Core Commands

- **account** — Manage locally configured 1Password accounts
- **completion** — Generate shell completion information
- **connect** — Manage Connect server instances and tokens
- **document** — Perform CRUD operations on Document items
- **environment** — Manage 1Password Environments and variables (Beta)
- **events-api** — Manage Events API integrations
- **group** — Manage groups in your account
- **inject** — Inject secrets into a config file
- **item** — Perform CRUD operations on vault items
- **plugin** — Manage shell plugins for third-party CLI authentication
- **read** — Read a secret reference
- **run** — Pass secrets as environment variables to a process
- **service-account** — Manage service accounts
- **signin** — Sign in to a 1Password account
- **signout** — Sign out of an account
- **update** — Check for and download updates
- **user** — Manage users within your account
- **vault** — Manage permissions and vault CRUD operations
- **whoami** — Get information about a signed-in account

## Global Flags

| Flag | Description |
|------|-------------|
| `--account string` | Select account by shorthand, address, ID, or user ID |
| `--cache` | Store and use cached information (default: true on UNIX; unavailable on Windows) |
| `--config directory` | Specify configuration directory |
| `--debug` | Enable debug mode |
| `--encoding type` | Character encoding (UTF-8 default; supports SHIFT_JIS, gbk) |
| `--format string` | Output format: 'human-readable' or 'json' (default: human-readable) |
| `-h, --help` | Display help information |
| `--iso-timestamps` | Format timestamps per ISO 8601/RFC 3339 |
| `--no-color` | Print output without color |
| `--session token` | Authenticate with session token |

## Environment Variables

- `OP_ACCOUNT` — Set default account
- `OP_CACHE` — Enable/disable caching
- `OP_DEBUG` — Enable debug mode
- `OP_FORMAT` — Set output format
- `OP_ISO_TIMESTAMPS` — Enable ISO timestamp formatting
- `OP_SERVICE_ACCOUNT_TOKEN` — Authenticate with a service account
- `OP_CONNECT_HOST` / `OP_CONNECT_TOKEN` — Authenticate against a Connect server
- `OP_BIOMETRIC_UNLOCK_ENABLED` — Toggle desktop app biometric unlock
- `OP_INCLUDE_ARCHIVE` — Include archived items in item commands

## Unique Identifiers (IDs)

Objects have 26-character alphanumeric IDs. IDs are more stable than names — "An item's ID only changes when you move the item to a different vault." IDs improve command speed and efficiency. Retrieve IDs using `op item get`, `op user get`, `op vault list`, or similar commands.

## Shell Completion

Enable tab-completion by adding completion initialization to your shell configuration:

- **Bash:** Add `source <(op completion bash)` to `.bashrc`
- **Zsh:** Add `eval "$(op completion zsh)"; compdef _op op` to `.zshrc`
- **Fish:** Add `op completion fish | source` to `.fish`
- **PowerShell:** Add `op completion powershell | Out-String | Invoke-Expression` to your profile

PowerShell requires execution policy adjustment: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned`

## Caching

On UNIX-like systems, caching is enabled by default, optimizing performance and reducing API calls. The daemon encrypts cached data in memory. Disable caching with `--cache=false` or `OP_CACHE=false`. Caching is unavailable on Windows.

## Character Encoding

UTF-8 is the default. Alternative encodings (`gbk`, `shift-jis`) are supported via the `--encoding` option.

## JSON Parsing

Use `--format json` or `OP_FORMAT=json` for JSON output, then parse with `jq` for field extraction.

## Common Usage Examples

```shell
# Retrieve item information
op item get <item-name>

# Get specific fields
op item get "item name" --fields label=username,label=password

# User details
op user get "User Name"

# List group members
op group user list "Group Name"

# Create vault
op vault create <vault-name>

# Get vault details / list vaults
op vault get <vault-name>
op vault list

# Resolve secret references
op read "op://vault-name/item-name/field-name"
```

Secret references follow the format: `op://vault-name/item-name/[section-name/]field-name`.

## Getting Help

Use `op <command> [subcommand] --help` for command-specific assistance.

## Management Command Reference Pages

The full reference is split per topic at `/cli/reference/management-commands/<topic>` and `/cli/reference/commands/<command>`:

- `account`, `connect`, `document`, `environment`, `events-api`, `group`, `item`, `plugin`, `service-account`, `user`, `vault`
- `completion`, `inject`, `read`, `run`, `signin`, `signout`, `update`, `whoami`
