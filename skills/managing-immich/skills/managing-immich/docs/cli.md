<!-- Source: https://docs.immich.app/features/command-line-interface -->

# Immich CLI

## Installation

Requires Node.js 20+ and npm:

```bash
npm i -g @immich/cli
```

A Docker alternative is available for systems without Node.js.

## Authentication

```bash
immich login-key <url> <api-key>
# Example:
immich login-key http://localhost:2283 your-api-key-here
```

API keys are created in the Immich web UI under user Settings > API Keys.

```bash
immich logout  # Remove stored credentials
```

## Commands

| Command | Description |
|---------|-------------|
| `login-key <url> <key>` | Authenticate with API credentials |
| `logout` | Remove stored credentials |
| `server-info` | Display server details |
| `upload [paths...]` | Transfer photos and videos to Immich |

## Upload Options

| Flag | Description | Default |
|------|-------------|---------|
| `-r, --recursive` | Include subdirectories | — |
| `-a, --album` | Auto-create albums from folder names | — |
| `-A, --album-name <name>` | Assign to specific album | — |
| `-i, --ignore <pattern>` | Exclude matching files | — |
| `-c, --concurrency <number>` | Parallel uploads | 4 |
| `--dry-run` | Preview actions without executing | — |
| `--watch` | Monitor for automatic uploads | — |
| `--delete` | Remove local files post-upload | — |

## Environment Variables

| Variable | Description |
|----------|-------------|
| `IMMICH_INSTANCE_URL` | Server address |
| `IMMICH_API_KEY` | Authentication token |
| `IMMICH_CONFIG_DIR` | Credentials storage location |

## Examples

```bash
# Upload a directory recursively
immich upload --recursive /path/to/photos

# Upload and auto-create albums from folder structure
immich upload --recursive /path/to/photos --album

# Upload to a specific album
immich upload --recursive /path/to/photos --album-name "Vacation 2024"

# Dry run to preview what would be uploaded
immich upload --recursive /path/to/photos --dry-run

# Watch a directory for new files and auto-upload
immich upload --recursive /path/to/photos --watch
```
