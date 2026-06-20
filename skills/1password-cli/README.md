# 1Password CLI Skill

Expert knowledge about the [1Password CLI](https://www.1password.dev/cli/) — the `op` command for managing 1Password from your terminal and securely loading secrets into scripts, apps, and CI without storing plaintext credentials.

## What This Skill Covers

- **Getting started & auth**: install on macOS/Windows/Linux, desktop-app (biometric) integration, manual `op signin`, and using multiple accounts (`--account`, `OP_ACCOUNT`)
- **Secret references**: the `op://vault/item/[section/]field` syntax (attributes, files, OTP, SSH format) and resolving them with `op read`, `op run`, and `op inject`
- **Loading secrets**: `op run` (env vars, `.env` files, masking, 1Password Environments) and `op inject` (config-file templates)
- **Items & vaults**: full CRUD with `op item` and `op vault`, field types, JSON templates, share links, and granular permissions
- **Automation**: service accounts (`OP_SERVICE_ACCOUNT_TOKEN`, rate limits), Connect server (`OP_CONNECT_HOST`/`OP_CONNECT_TOKEN`), and headless/Docker installs
- **Integrations**: shell plugins (`op plugin`) for 80+ third-party CLIs behind biometric unlock, plus SSH keys, the 1Password SSH agent, and git commit signing
- **Reference**: command structure, global flags, environment variables, shell completion, and caching

## Usage

```
/1password-cli help                    # Show available commands
/1password-cli start                   # Install & enable app integration
/1password-cli signin                  # Authentication & multiple accounts
/1password-cli secrets                 # Secret references & op read
/1password-cli run                     # op run — secrets as env vars
/1password-cli inject                  # op inject — secrets into config files
/1password-cli item create             # Create/edit/share items
/1password-cli service-account         # Automation / CI auth
/1password-cli plugin                  # Shell plugins for third-party CLIs
/1password-cli ssh                     # SSH keys, agent, git signing
/1password-cli reference               # Command structure & flags
/1password-cli sync                    # Update docs from upstream
```

## Documentation Sources

All documentation is synced from [1password.dev/cli](https://www.1password.dev/cli/) and cached under `skills/1password-cli/docs/`, mirroring the upstream URL structure (`docs/cli/`, `docs/cli/reference/`, `docs/service-accounts/`, `docs/connect/`).

The `discover-pages.sh` script detects new upstream CLI pages not yet tracked in `sync.json`.

## Sync

```bash
# Check for new upstream pages
./skills/1password-cli/discover-pages.sh

# Auto-add new pages to sync.json
./skills/1password-cli/discover-pages.sh --auto-add

# Sync all documentation
.github/workflows/scripts/sync-skill.sh skills/1password-cli --force
```

## Upstream

- **Documentation**: https://www.1password.dev/cli/ (formerly https://developer.1password.com/docs/cli/)
- **Release history / changelog**: https://app-updates.agilebits.com/product_history/CLI2
- **Docker image**: `1password/op:2`
