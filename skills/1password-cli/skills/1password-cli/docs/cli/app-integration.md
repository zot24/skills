<!-- Source: https://www.1password.dev/cli/app-integration/ -->

# Use the 1Password Desktop App to Sign In to 1Password CLI

## Overview

The 1Password desktop app integration enables you to authenticate the CLI using methods like fingerprint, face recognition, Apple Watch, Windows Hello PIN, or your device password. This approach tracks recent CLI activity and allows seamless access to accounts already configured in your app.

## Requirements

**Mac**: 1Password subscription and 1Password for Mac

**Windows**: 1Password subscription and 1Password for Windows

**Linux**: 1Password subscription, 1Password for Linux, PolKit (typically pre-installed), and an active PolKit authentication agent

## Configuration Steps

### Enable the App Integration

**Mac**:
1. Open and unlock 1Password
2. Select your account/collection at the sidebar top
3. Navigate to Settings > Developer
4. Select "Integrate with 1Password CLI"
5. Optionally enable Touch ID for fingerprint authentication

**Windows**:
1. Open and unlock 1Password
2. Select your account/collection at the sidebar top
3. Enable Windows Hello in the app
4. Go to Settings > Developer
5. Select "Integrate with 1Password CLI"

**Linux**:
1. Open and unlock 1Password
2. Select your account/collection at the sidebar top
3. Go to Settings > Security
4. Enable "Unlock using system authentication"
5. Navigate to Settings > Developer
6. Select "Integrate with 1Password CLI"

### Sign In

After enabling integration, run any CLI command. You'll receive an authentication prompt. For example:

```shell
op vault list
```

## Multiple Account Management

Run `op signin` to select from accounts added to your desktop app. Use arrow keys to navigate:

```shell
op signin
```

Alternatively, use the `--account` flag per command:

```shell
op vault ls --account my.1password.com
```

Or set the `OP_ACCOUNT` environment variable to your account's sign-in address or ID.

## Clean Previous Account Configuration

If you previously added account details manually and want to use only the app integration:

```shell
op account forget --all
```

Your configuration file is located at `~/.op/config`, `~/.config/op/config`, or `~/.config/.op/config`.

## Toggle Biometric Unlock

**Enable integration**:
- Bash/Zsh/sh: `export OP_BIOMETRIC_UNLOCK_ENABLED=true`
- Fish: `set -x OP_BIOMETRIC_UNLOCK_ENABLED true`
- PowerShell: `$Env:OP_BIOMETRIC_UNLOCK_ENABLED = "true"`

**Disable integration**:
- Bash/Zsh/sh: `export OP_BIOMETRIC_UNLOCK_ENABLED=false`
- Fish: `set -x OP_BIOMETRIC_UNLOCK_ENABLED false`
- PowerShell: `$Env:OP_BIOMETRIC_UNLOCK_ENABLED = "false"`

## Activity Tracking

Access your CLI activity log by:
1. Opening and unlocking the 1Password desktop app
2. Selecting Developer in the sidebar
3. Selecting "View CLI"

The activity table shows recent commands, timestamps, applications, and accessed accounts. Activity data is encrypted locally; older entries are purged regularly. Disable tracking by turning off "Record and display activity" in Developer settings.

## Troubleshooting

**Account not listed in `op signin`**: The command returns accounts added to your desktop app. To use a new account, add it to the app first via account settings.

**Connection errors** ("connectionreset" or connection failure):

- *Mac*: Verify "Allow in background" is enabled in System Settings > General > Login Items for 1Password. Update to the latest version, restart the app. For versions 8.10.12 and earlier, ensure the CLI binary is in `/usr/local/bin/`.
- *Windows*: Update to the latest version and restart the app.
- *Linux*: Update to the latest version and restart the app.

**"LostConnectionToApp" error during authentication**:

- *Mac*: Enable "Keep 1Password in the menu bar" via Settings > General.
- *Windows*: Enable "Keep 1Password in the notification area" via Settings > General.
- *Linux*: Enable "Keep 1Password in the system tray" via Settings > General.

**Missing expected authentication method**:

- *Mac*: Set up Touch ID or Apple Watch unlock in the app.
- *Windows*: Set up Windows Hello unlock in the app.
- *Linux*: Configure system authentication and update your login method to use fingerprint or biometrics instead of your password.

## Additional Resources

- [Use Multiple 1Password Accounts with CLI](/cli/use-multiple-accounts/)
- [1Password App Integration Security](/cli/app-integration-security/)
