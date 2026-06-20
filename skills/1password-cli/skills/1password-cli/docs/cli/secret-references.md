<!-- Source: https://www.1password.dev/cli/secret-references/ -->

# Use Secret References with 1Password CLI

## Overview

1Password CLI enables secure loading of secrets into environment variables, configuration files, and scripts without exposing plaintext credentials. Secret references use a URI format to point to stored secrets in your 1Password vault.

## Secret Reference Format

The basic structure for a secret reference URI is:

```
op://<vault-name>/<item-name>/[section-name/]<field-name>
```

## Requirements

Before using secret references, you need to:

1. Sign up for a 1Password account
2. Install 1Password CLI
3. Save secrets in your 1Password vault

## Step 1: Obtaining Secret References

You can retrieve secret references through:

- The 1Password desktop application (open the item, select the dropdown next to a field, choose **Copy Secret Reference**)
- 1Password for VS Code
- The command line using `op item get`
- Manual creation following the syntax rules

## Step 2: Replacing Plaintext Secrets

Substitute plaintext credentials with secret reference URIs in your code and configuration files. This allows files to be safely stored in version control.

Example environment file:
```
GITHUB_TOKEN=op://development/GitHub/credentials/personal_token
```

## Step 3: Resolving Secret References at Runtime

Three methods are available for replacing references with actual secrets.

### Using `op read`

Print secrets to stdout or write to a file:

```shell
op read op://development/GitHub/credentials/personal_token
```

Write to a file:
```shell
op read --out-file token.txt op://development/GitHub/credentials/personal_token
```

Use in scripts:
```bash
#!/bin/bash
docker login -u "$(op read op://prod/docker/username)" -p "$(op read op://prod/docker/password)"
```

**Query Parameters**

Access field metadata and attributes:

```
op://<vault>/<item>[/<section>]/<field>?attribute=<attribute-value>
```

Available field attributes: `type`, `value`, `title`, `id`, `purpose`, `otp`

Available file attributes: `content`, `size`, `id`, `name`, `type`

Retrieve OTP:
```shell
op read "op://development/GitHub/Security/one-time password?attribute=otp"
```

Get SSH key in OpenSSH format:
```shell
op read "op://Private/ssh keys/ssh key/private key?ssh-format=openssh"
```

### Using `op run`

Pass secrets as environment variables to applications and scripts. The command scans environment variables for secret references, retrieves values from 1Password, and executes the provided command with secrets available.

Setting environment variables:

**Bash/Zsh/sh:**
```shell
export DB_USER="op://app-dev/db/user"
export DB_PASSWORD="op://app-dev/db/password"
```

**fish:**
```shell
set -x DB_USER "op://app-dev/db/user"
set -x DB_PASSWORD "op://app-dev/db/password"
```

**PowerShell:**
```powershell
$Env:DB_USER = "op://app-dev/db/user"
$Env:DB_PASSWORD = "op://app-dev/db/password"
```

Run the command:
```shell
op run -- node app.js
```

**Using environment files:**

Create an environment file with secret references:
```
DB_USER="op://app-dev/db/user"
DB_PASSWORD="op://app-dev/db/password"
```

Execute with the file:
```shell
op run --env-file="./node.env" -- node app.js
```

**Masking secrets in output:**

By default, secrets printed by subprocesses are concealed. Use `--no-masking` to display actual values:

```shell
op run -- printenv DB_PASSWORD
# Output: <concealed by 1Password>

op run --no-masking -- printenv DB_PASSWORD
# Output: fX6nWkhANeyGE27SQGhYQ
```

### Using `op inject`

Replace secret references in files and scripts with actual secrets. Accepts input from stdin or files, outputs to stdout or files.

Simple command:
```shell
echo "GitHub token: op://development/GitHub/credentials/personal_token" | op inject
```

Using configuration files:

Template file (`config.yml.tpl`):
```yaml
database:
    host: http://localhost
    port: 5432
    username: op://prod/mysql/username
    password: op://prod/mysql/password
```

Inject secrets:
```shell
op inject --in-file config.yml.tpl --out-file config.yml
```

## Best Practices

The documentation recommends using service accounts to follow the principle of least privilege, restricting CLI access to specific vaults.

## Related Resources

- [Secret reference syntax](/cli/secret-reference-syntax/)
- [Load secrets into the environment](/cli/secrets-environment-variables/)
- [Load secrets into config files](/cli/secrets-config-files/)
- [Use service accounts with 1Password CLI](/service-accounts/use-with-1password-cli/)
