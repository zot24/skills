<!-- Source: https://www.1password.dev/service-accounts/use-with-1password-cli/ -->

# Use Service Accounts with 1Password CLI

## Overview

Service accounts enable vault and item management through 1Password CLI with programmatic authentication — ideal for CI/CD, headless servers, and automation. A service account is scoped to specific vaults, following the principle of least privilege.

## Prerequisites

- Active 1Password subscription
- 1Password CLI version 2.18.0 or later
- A created service account and its token

## Configuration Steps

### 1. Set Environment Variable

Export your service account token based on your shell:

**bash, sh, zsh:**
```shell
export OP_SERVICE_ACCOUNT_TOKEN=<your-service-account-token>
```

**fish:**
```shell
set -x OP_SERVICE_ACCOUNT_TOKEN <your-service-account-token>
```

**PowerShell:**
```powershell
$Env:OP_SERVICE_ACCOUNT_TOKEN = "<your-service-account-token>"
```

### 2. Verify Configuration

```shell
op user get --me
```

Returns service account details including ID, name, email, and status.

## Important Notice

Connect environment variables (`OP_CONNECT_HOST`, `OP_CONNECT_TOKEN`) take precedence over service account tokens. Clear them to use service account authentication instead.

## Supported Commands

**General use:** `op read`, `op inject`, `op run`, `op vault create`, `op service-account ratelimit`

**Requires `--vault` flag (for multi-vault access):** `op item`, `op document`

**Service account-created vaults only:** `op vault delete`, `op vault group grant/revoke`, `op vault user grant/revoke`

## Unsupported Commands

`op connect`; `op group` (provision, get, list); `op user` (provision, confirm, suspend, delete, recovery, get, list); `op events-api`; `op vault edit`.

## Rate Limiting

Service accounts have hourly and daily request limits. Pass unique identifiers (IDs) instead of names to reduce API calls.

### Multi-Request Commands

| Command | Requests | Optimization |
|---------|----------|---------------|
| `op item list` | 1 + 1 per vault | Use `--vault` flag with ID |
| `op item get` | 3 reads | Pass item and vault IDs (1 request) |
| `op item create` | 1 read + 1 write | Pass vault ID (1 request) |
| `op item delete` | 5 reads + 1 write | Pass vault ID (reduces reads by 1) |
| `op item edit` | 5 reads + 1 write | Pass vault ID (reduces reads by 1) |
| `op read` | 3 reads | Pass item and vault IDs (1 request) |
| `op vault delete` | 2 reads + 1 write | Pass vault ID (reduces reads by 1) |
| `op vault get` | 2 reads | Pass vault ID (reduces reads by 1) |
