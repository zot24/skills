<!-- Source: https://www.1password.dev/cli/use-multiple-accounts/ -->

# Use Multiple 1Password Accounts with 1Password CLI

When you use the 1Password desktop app integration to sign in to 1Password CLI, you can access any 1Password account you've added to the app on the command line.

By default, all 1Password CLI commands are executed with the account you most recently signed in to, unless an account is specified with the `--account` flag.

## Choose an Account to Sign In to with `op signin`

To choose an account to sign in to, run `op signin` and select the account you want to sign in to from the list of accounts added to your 1Password app.

```shell
op signin
```

Output:
```
Select account  [Use arrows to move, type to filter]
> ACME Corp (acme.1password.com)
  AgileBits (agilebits.1password.com)
  Add another account
```

If you don't see the account you want to use, you may need to add it to the 1Password app.

## Specify an Account Per Command with the `--account` Flag

You can execute a command with a specific account by including the `--account` flag along with the account's sign-in address (with or without https://) or ID.

For example, to get a list of all vaults in an account with the sign-in address `my.1password.com`:

```shell
op vault ls --account my.1password.com
```

You can use the `--account` flag to specify different accounts in scripts:

```shell
PASSWORD_1="$(op read --account agilebits-inc.1password.com op://my-vault/some-item/password)"
PASSWORD_2="$(op read --account acme.1password.com op://other-vault/other-item/password)"
```

## Set an Account with the `OP_ACCOUNT` Environment Variable

If you only want to sign in to a specific account, set the `OP_ACCOUNT` environment variable to the account's sign-in address or ID.

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

## Find an Account Sign-in Address or ID

To find details about all the accounts you've added to the 1Password app, run `op account list`.

```shell
op account list
```

Output:
```
URL                            EMAIL                              USER ID
my.1password.com               wendy.c.appleseed@gmail.com        JDFU...
agilebits-inc.1password.com    wendy_appleseed@agilebits.com      ASDU...
```

You can use the sign-in address listed under `URL` or the unique identifier listed under `USER ID` to refer to the account.
