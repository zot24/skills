<!-- Source: https://www.1password.dev/cli/sign-in-manually/ -->

# Sign in to your 1Password account manually

## Overview

As an alternative to using the 1Password desktop app integration, you can manually authenticate with 1Password CLI through terminal commands. However, this approach carries security considerations.

### Security Warning

"If you sign in to 1Password CLI manually, any process running under the current user can, on some platforms, potentially access your 1Password account." The documentation recommends using the 1Password app integration for enhanced security protections.

When signing in manually, 1Password CLI stores your encrypted session key on disk along with a random wrapper key in your current shell environment. Sessions automatically expire after 30 minutes of inactivity.

## Manual Sign-In Process

### Step 1: Add an Account

Use the `op account add` command to register a 1Password account:

```shell
op account add
```

You'll be prompted to provide:
- Your sign-in address
- Email address
- Secret Key
- Account password

#### Custom Account Shorthand

Set a custom identifier for your account using the `--shorthand` flag:

```shell
op account add --shorthand personal
```

### Step 2: Sign In

Execute the sign-in command appropriate for your shell:

**Bash, Zsh, sh, fish:**
```shell
eval "$(op signin)"
```

**PowerShell:**
```powershell
Invoke-Expression "$(op signin)"
```

This creates a session token and sets the `OP_SESSION` environment variable. Use `--raw` to manually export the token.

## Managing Multiple Accounts

Sign in to multiple accounts sequentially:

**Bash, Zsh, sh, fish:**
```shell
eval "$(op signin --account personal)" && eval "$(op signin --account agilebits)"
```

**PowerShell:**
```powershell
Invoke-Expression "$(op signin --account personal)"; Invoke-Expression "$(op signin --account agilebits)"
```

Specify which account executes commands using the `--account` flag:

```shell
op vault list --account personal
op vault list --account agilebits
```

### Set Default Account

Configure a default account via environment variable:

**Bash, Zsh, sh:**
```shell
export OP_ACCOUNT=my.1password.com
```

**fish:**
```shell
set -x OP_ACCOUNT my.1password.com
```

**PowerShell:**
```powershell
$Env:OP_ACCOUNT = "my.1password.com"
```

## Session Management

Sign out immediately using:

```shell
op signout
```

Sessions expire after 30 minutes without activity, requiring re-authentication.

## View Added Accounts

List all configured accounts with their shorthands and details:

```shell
op account list
```

Example output:
```
SHORTHAND       URL                                     EMAIL                           USER UUID
my              https://my.1password.com                wendy.c.appleseed@gmail.com     A10S...
agilebits       https://agilebits-inc.1password.com     wendy_appleseed@agilebits.com   ONJ9...
```

Reference accounts by shorthand, sign-in address, or user ID in commands.

## Troubleshooting

If the 1Password app integration is already enabled, disable it before adding accounts via the command line.
