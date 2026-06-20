---
name: 1password-cli
description: Expert on the 1Password CLI (the `op` command) for managing 1Password from the terminal and securely loading secrets into scripts and CI. Use when the user wants to read/inject secrets, use secret references (op://vault/item/field), run `op run` or `op inject` or `op read`, manage items/vaults, set up service accounts for automation, configure shell plugins (`op plugin`), use the 1Password SSH agent or git commit signing, or enable biometric/desktop-app integration. Triggers on mentions of 1Password CLI, `op` command, op cli, secret references, op run, op inject, op read, service account, secrets automation, 1Password vault/item from terminal, op plugin, 1Password SSH agent.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, WebFetch
---

# 1Password CLI (`op`)

The 1Password CLI brings password management to your terminal. Authenticate with biometrics via the desktop app, or with a service account / Connect server for automation — then read secrets, inject them into files and processes, and manage items, vaults, and users.

## Overview

- **`op` command structure** — noun-verb: `op <command> <subcommand> [flags]` (e.g. `op item get`, `op vault list`).
- **Secret references** — `op://vault/item/[section/]field` URIs let you keep plaintext secrets out of code; resolve them with `op read`, `op run`, or `op inject`.
- **Three auth modes** — desktop **app integration** (biometric, interactive), **service accounts** (`OP_SERVICE_ACCOUNT_TOKEN`, for CI/headless), and **Connect server** (`OP_CONNECT_HOST`/`OP_CONNECT_TOKEN`, self-hosted).
- **Manage items & vaults** — full CRUD with `op item` and `op vault`, JSON templates for sensitive values, share links, and granular permissions.
- **Shell plugins** — `op plugin` injects credentials into 80+ third-party CLIs (aws, gh, stripe…) behind biometric unlock.
- **SSH & git** — read SSH keys in OpenSSH format, and pair with the 1Password SSH agent for SSH auth and git commit signing.

## Quick Start

```shell
# Install (macOS), then enable desktop-app integration in Settings > Developer
brew install 1password-cli && op --version

# Sign in (picks an account from the app)
op signin

# Read a single secret
op read "op://Private/GitHub/token"

# Get a field from an item
op item get "GitHub" --fields label=username,label=password

# Inject secrets into a process via env vars
export DB_PASSWORD="op://prod/db/password"
op run -- ./start-server.sh
```

## Core Concepts

- **Secret references** — `op://<vault>/<item>/[<section>/]<field>`; case-insensitive, quote anything with spaces. Supports `?attribute=otp` and `?ssh-format=openssh`. See [secret-reference-syntax](docs/cli/secret-reference-syntax.md).
- **`op run` vs `op inject`** — `op run -- <cmd>` resolves references in env vars and runs a command (secrets masked by default); `op inject -i tpl -o out` substitutes references inside a file. See [secret-references](docs/cli/secret-references.md).
- **Interactive vs automated** — app integration is for humans (biometric); service accounts and Connect are for scripts/CI and follow least-privilege via vault scoping. See [service-accounts](docs/service-accounts/use-with-1password-cli.md).
- **IDs over names** — pass 26-char IDs in scripts: more stable and fewer API requests (matters for service-account rate limits).

## Documentation

### Getting started & auth
- **[Get Started / Install](docs/cli/get-started.md)** — install on macOS/Windows/Linux, enable app integration, first sign-in
- **[Desktop App Integration](docs/cli/app-integration.md)** — biometric unlock, `OP_BIOMETRIC_UNLOCK_ENABLED`, troubleshooting
- **[Sign In Manually](docs/cli/sign-in-manually.md)** — `op account add`, `eval "$(op signin)"`, sessions
- **[Use Multiple Accounts](docs/cli/use-multiple-accounts.md)** — `--account` flag, `OP_ACCOUNT`, `op account list`

### Secrets
- **[Secret References](docs/cli/secret-references.md)** — `op read` / `op run` / `op inject`
- **[Secret Reference Syntax](docs/cli/secret-reference-syntax.md)** — the `op://` URI, attributes, files, OTP, SSH
- **[Load Secrets into the Environment](docs/cli/secrets-environment-variables.md)** — `op run`, `.env` files, Environments
- **[Load Secrets into Config Files](docs/cli/secrets-config-files.md)** — `op inject` templates
- **[`op run` reference](docs/cli/reference/commands/run.md)** — flags, precedence, examples

### Items & vaults
- **[Create Items](docs/cli/item-create.md)** · **[Edit Items](docs/cli/item-edit.md)** · **[Item Fields](docs/cli/item-fields.md)**
- **[Vault Permissions](docs/cli/vault-permissions.md)** — `op vault` CRUD, grant/revoke, permission deps
- **[`op item` reference](docs/cli/reference/management-commands/item.md)** — full CRUD + share/move/template

### Automation & integrations
- **[Service Accounts](docs/service-accounts/use-with-1password-cli.md)** — `OP_SERVICE_ACCOUNT_TOKEN`, rate limits
- **[Connect Server](docs/connect/cli.md)** — `OP_CONNECT_HOST`/`OP_CONNECT_TOKEN`, CI
- **[Install on a Server](docs/cli/install-server.md)** — Linux/Docker for headless
- **[Shell Plugins](docs/cli/shell-plugins.md)** — `op plugin` for third-party CLIs
- **[SSH Keys & Agent](docs/cli/ssh-keys.md)** — generate/read keys, SSH agent, git signing

### Reference
- **[Command Reference](docs/cli/reference.md)** — command list, global flags, env vars, completion, caching
- **[Best Practices](docs/cli/best-practices.md)** — least privilege, JSON templates, updates

## Common Workflows

- **Inject secrets into a local app**: put `KEY=op://vault/item/field` lines in a `.env`, then `op run --env-file=./.env -- npm start`.
- **CI without plaintext**: create a service account scoped to one vault, set `OP_SERVICE_ACCOUNT_TOKEN`, and use `op run`/`op inject` (pass vault/item **IDs** to stay under rate limits).
- **Biometric auth for any CLI**: `op plugin init aws`, source `~/.config/op/plugins.sh`, then run `aws …` — credentials are unlocked with your fingerprint.

## Upstream Sources

- **Documentation**: https://www.1password.dev/cli/ (formerly https://developer.1password.com/docs/cli/)
- **Release history / changelog**: https://app-updates.agilebits.com/product_history/CLI2
- **Docker image**: `1password/op:2`

## Sync & Update

Docs under `docs/` mirror the upstream `1password.dev/cli/` URL structure. Run `discover-pages.sh` to detect new upstream CLI pages from the site's `llms.txt`/`sitemap.xml`; run the sync script (or `sync`) to refresh cached docs. On `diff`, compare current docs/ vs upstream.
