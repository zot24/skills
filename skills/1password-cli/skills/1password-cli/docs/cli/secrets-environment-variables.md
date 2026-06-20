<!-- Source: https://www.1password.dev/cli/secrets-environment-variables/ -->

# Load secrets into the environment

## Overview

The `op run` command enables you to provide project secrets directly from 1Password to applications or scripts as environment variables at runtime. This approach avoids hardcoding plaintext secrets and facilitates switching between different secret sets for various development contexts.

## Configuration Methods

1Password CLI offers multiple approaches:

* **1Password Environments (beta)**: Create Environments containing all environment variables for specific workflows. These can be shared with teams and separated by project, application, or context (staging/production).
* **Secret references**: URIs pointing to secret storage locations in your 1Password account, using vault, item, section, and field names or unique identifiers. These can be set via command line or `.env` files.
* **Hybrid approach**: Combine `op run` to load variables from a 1Password Environment alongside secret references from `.env` files or exported variables.

## Requirements

**For 1Password Environments:** Sign up for 1Password, install 1Password CLI beta version `2.33.0-beta.02` or later.

**For Secret References:** Sign up for 1Password, install 1Password CLI.

## Step 1: Store Secrets in 1Password

**Using 1Password Environments:** Create an Environment and import a `.env` file or manually add variables.

**Using Secret References:** Save secrets as vault items, then create references using the desktop app, VS Code, `op item get`, or manual syntax.

## Step 2: Pass Secrets to Application

### Option A: 1Password Environment (beta)

1. Open 1Password app → **Developer** > **Environments**
2. Select your Environment → **Manage environment** > **Copy environment ID**
3. Run the command:

```shell
op run --environment <environmentID> -- <command>
```

Example:

```shell
op run --environment blgexucrwfr2dtsxe2q4uu7dp4 -- ./my-script.sh
```

### Option B: Secret References

#### Using Environment Files

Create a `.env` file with secret references as `KEY=VALUE` pairs:

```shell
AWS_ACCESS_KEY_ID="op://development/aws/Access Keys/access_key_id"
AWS_SECRET_ACCESS_KEY="op://development/aws/Access Keys/secret_access_key"
```

**Environment File Syntax Rules:**

* Variables defined as `KEY=VALUE` statements separated by newlines
* Multi-line values supported when enclosed in quotes
* Empty lines skipped; lines starting with `#` are comments
* Empty values become empty strings (`EMPTY=` sets to empty string)
* Single/double quotes removed from evaluated values
* `$VAR_NAME` or `${VAR_NAME}` replaced with environment values
* Variables can reference earlier definitions: `OTHER_VAR = ${SOME_VAR}`
* Escape special characters with backslash: `MY_VAR = "\$SOME_VAR"`
* Inner quotes preserved: `JSON={"foo":"bar"}` evaluates correctly
* Variables not replaced in single-quoted values
* Template syntax can inject secrets in `VALUE` (not `KEY`)
* Leading/trailing whitespace ignored for unquoted values
* Quoted values preserve whitespace: `KEY=" some value "`
* UTF-8 character encoding required

**Differentiate Between Environments:**

Organize secrets in 1Password by vault (dev, prod) with identically structured items. Use externally set variables in secret references:

```shell
MYSQL_DATABASE = "op://$APP_ENV/mysql/database"
MYSQL_USERNAME = "op://$APP_ENV/mysql/username"
MYSQL_PASSWORD = "op://$APP_ENV/mysql/password"
```

Then set the variable when running:

```shell
APP_ENV=dev op run --env-file="./app.env" -- myapp deploy
```

#### Using Command Line

Export environment variables directly:

**Bash/Zsh/sh:**
```shell
export GITHUB_TOKEN=op://development/GitHub/credentials/personal_token
```

**fish:**
```shell
set -x GITHUB_TOKEN op://development/GitHub/credentials/personal_token
```

**PowerShell:**
```powershell
$Env:GITHUB_TOKEN = "op://development/GitHub/credentials/personal_token"
```

#### Running Applications

With environment file:
```shell
op run --env-file="./prod.env" -- aws
```

With command-line exports:
```shell
op run -- <command>
```

Example:
```shell
op run -- gh
```

**Variable Expansion Note:** When referencing variables in the same command as `op run`, shells expand variables before `op run` substitutes secrets. To ensure proper substitution, use a subshell:

```shell
MY_VAR=op://vault/item/field op run --no-masking -- sh -c 'echo "$MY_VAR"'
```

### Combining Methods

Load from both Environment and `.env` file:

```shell
op run --environment <ID> --env-file="./extra-secrets.env" -- <command>
```

## Production and CI/CD

* **1Password Service Account**: Automate access with service account tokens, supporting both secret references and 1Password Environments. Follows the principle of least privilege through vault and Environment scoping.
* **1Password Connect Server**: Best for self-hosted infrastructure. Supports secret references only (not currently Environments).

## Best Practices

"Authenticate with a 1Password Service Account to follow the principle of least privilege." Scope service account access to specific vaults and Environments so processes can only access required secrets.

**Security Note:** Assume processes on your computer can access the environment of other processes run by the same user. Exercise caution when supplying secrets through environment variables.
