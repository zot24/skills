<!-- Source: https://www.1password.dev/cli/reference/commands/run/ -->

# op run

Pass secrets as environment variables to an application or script.

```
op run -- <command> <command>... [flags]
```

## Flags

```
--env-file stringArray   Enable Dotenv integration with specific Dotenv files to
                         parse. For example: --env-file=.env.
--no-masking             Disable masking of secrets on stdout and stderr.
--environment            Load variables from a 1Password Environment using its UUID.
```

## Overview

Use `op run` to securely load project secrets from 1Password, then execute a provided command in a subprocess with the secrets made available as environment variables only for the duration of the subprocess.

To limit which 1Password items processes in your authorized terminal session can access, authenticate 1Password CLI with a service account that only has access to the required secrets. You can scope service accounts to specific vaults and 1Password Environments.

## Load secrets using secret references

`op run` can scan environment variables and files for secret references, then load the provided command with the referenced secrets made available as environment variables.

Secret references are URIs that point to the ID or name of the vault, item, section, and field where a secret is stored in 1Password. You can export environment variables to secret references on the command line or using an `.env` file.

Secrets printed to stdout or stderr are concealed by default. Include the `--no-masking` flag to turn off masking.

When referencing an environment variable assigned to a secret reference within a command, `op run` must replace the reference with the actual secret value before the variable expands. To make sure this order of operations is followed, run the command that expands the variable in a subshell.

## Load variables from Environments (beta)

Use `op run` with the `--environment` flag and an Environment's ID to load variables from a 1Password Environment.

To find an Environment's ID, open the 1Password app, navigate to Developer > View Environments > then select View environment > Manage environment > Copy environment ID.

```shell
op run --environment <environment-uuid> -- printenv
```

## Environment variable precedence

If the same environment variable name exists in multiple sources, the source with higher precedence takes effect. Precedence from highest to lowest:

1. 1Password Environments (`--environment`)
2. Environment files (`--env-file`)
3. Shell environment variables

If the same variable name exists in multiple environment files, the last environment file takes precedence. If it exists in multiple 1Password Environments, the last Environment specified takes precedence.

## Examples

**Print secret value:**
```shell
export DB_PASSWORD="op://app-prod/db/password"
op run -- printenv DB_PASSWORD
# <concealed by 1Password>
op run --no-masking -- printenv DB_PASSWORD
# fX6nWkhANeyGE27SQGhYQ
```

**Specify an environment file and use it:**
```shell
echo "DB_PASSWORD=op://app-dev/db/password" > .env
op run --env-file="./.env" -- printenv DB_PASSWORD
# password
```

**Use variables in secret references to switch between sets of secrets:**
```shell
cat .env
# DB_USERNAME = op://$APP_ENV/db/username
# DB_PASSWORD = op://$APP_ENV/db/password

export APP_ENV="dev"
op run --env-file="./.env" -- printenv DB_PASSWORD
# dev

export APP_ENV="prod"
op run --env-file="./.env" -- printenv DB_PASSWORD
# prod
```
