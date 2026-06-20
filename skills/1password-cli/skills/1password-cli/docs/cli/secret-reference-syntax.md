<!-- Source: https://www.1password.dev/cli/secret-reference-syntax/ -->

# Secret Reference Syntax

## Overview

Secret reference URIs point to secrets stored in your 1Password account using vault, item, section, and field names (or unique identifiers).

**Basic syntax:**
```
op://<vault-name>/<item-name>/[section-name/]<field-name>
```

Secret references eliminate plaintext secret exposure and automatically reflect updates made in your 1Password account.

## Supported Platforms

You can use secret references with:

- **1Password CLI** – Load secrets into environment variables, configuration files, and scripts
- **1Password SDKs** – Programmatically access secrets via Go, JavaScript, and Python
- **Secrets Automation** – Secure your secrets management workflows
- **VS Code** – Create, preview, and read secret references while coding
- **1Password Integrations** – Access secrets in Kubernetes, CircleCI, GitHub Actions, Jenkins, Terraform, Pulumi, Postman, and more

## Getting Secret References

### Desktop App Method

After enabling CLI integration:
1. Open the item containing your secret
2. Select the dropdown next to the field
3. Click **Copy Secret Reference**

### VS Code Method

1. Open the Command Palette
2. Enter `1Password: Get from 1Password`
3. Specify the item name or ID
4. Select your desired field

### CLI Method

```shell
op item get GitHub --format json --fields username | jq .reference
```

This returns: `"op://development/GitHub/username"`

To retrieve all field references:
```shell
op item get GitHub --format json
```

## Syntax Rules

### Supported Characters

Secret references are case-insensitive and support:
- Alphanumeric characters (a-z, A-Z, 0-9)
- Hyphens, underscores, periods, and whitespace

**Note:** Whitespace-containing references require quotation marks:
```shell
op read "op://development/aws/Access Keys/access_key_id"
```

Unsupported characters require using the field's unique identifier instead of its name.

### File Attachments

Reference files using the file name as the field:
```
op://vault-name/item-name/[section-name/]file-name
```

### Environment Variables

Use variables within secret references to switch between secret sets:

```
MYSQL_DATABASE = "op://$APP_ENV/mysql/database"
MYSQL_USERNAME = "op://$APP_ENV/mysql/username"
MYSQL_PASSWORD = "op://$APP_ENV/mysql/password"
```

Set `APP_ENV` to `dev` or `prod` to load the appropriate secrets.

## Query Parameters

### Attribute Parameter

Retrieve metadata about fields and file attachments:

```
op://<vault>/<item>[/<section>]/<field-name>?attribute=<attribute-value>
```

**Field attributes:**
- `type` – The field's type
- `value` – The field's content
- `id` – The field's unique identifier
- `purpose` – Built-in field designation (username, password, or notes)
- `otp` – Generate one-time password codes

**File attachment attributes:**
- `type` – The file's type
- `content` – The file's content
- `size` – File attachment size
- `id` – The file's unique identifier
- `name` – The file's name

**Examples:**

Generate an OTP code:
```shell
op read "op://development/GitHub/Security/one-time password?attribute=otp"
```
Returns: `359836`

Retrieve field type:
```shell
op read "op://Personal/aws/access credentials/username?attribute=type"
```
Returns: `string`

Get file name:
```shell
op read "op://app-infra/ssh/key.pem?attribute=name"
```
Returns: `key.pem`

### SSH Format Parameter

Retrieve SSH private keys in OpenSSH format:

```shell
op read "op://Private/ssh keys/ssh key/private key?ssh-format=openssh"
```

## Examples

### Field Inside a Section

```
op://Management/PagerDuty/Admin/email
```

Breakdown:
- `Management` = vault
- `PagerDuty` = item
- `Admin` = section
- `email` = field

### Field Without a Section

```
op://dev/Stripe/publishable-key
```

Breakdown:
- `dev` = vault
- `Stripe` = item
- `publishable-key` = field
