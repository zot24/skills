<!-- Source: https://www.1password.dev/cli/item-create/ -->

# Create Items

To create a new item in your 1Password account and assign information to it, use the `op item create` command.

You can specify basic information with flags and use assignment statements to assign built-in and custom fields. To assign sensitive values, use a JSON template.

## Requirements

Before using 1Password CLI to create items, you'll need to sign up for 1Password, install 1Password CLI, and sign in to your account.

> **Follow along:** Create a new vault named `Tutorial` where example items will be saved:
> ```shell
> op vault create Tutorial
> ```

## Create an item

To create a new item, use `op item create` and specify basic information with flags.

For example, to create a Login item named `Netflix` in the `Tutorial` vault:

```shell
op item create \
    --category login \
    --title "Netflix" \
    --vault Tutorial \
    --url 'https://www.netflix.com/login' \
    --generate-password='letters,digits,symbols,32' \
    --tags tutorial,entertainment
```

PowerShell:
```powershell
op item create `
    --category login `
    --title "Netflix" `
    --vault Tutorial `
    --url 'https://www.netflix.com/login' `
    --generate-password='letters,digits,symbols,32' `
    --tags tutorial,entertainment
```

## Flag Reference

| Flag | Purpose |
|------|---------|
| `--category` | Sets the item category (e.g., login). Use `op item template list` for available categories. Case-insensitive, ignores whitespace. |
| `--title` | Names the item. Defaults to "Untitled [Category] item" if unspecified. |
| `--vault` | Specifies which vault to create the item in. If unspecified, creates in Personal, Private, or Employee vault. |
| `--url` | Sets the website where 1Password suggests and fills Login, Password, or API Credential items. |
| `--generate-password` | Generates a strong password for Login and Password items. Specify a recipe or use default 32-character password. |
| `--tags` | Adds tags using comma-separated list format. |

## Create a customized item

Each item category has built-in fields. You can also create custom fields to save additional details.

### With assignment statements

The `op item create` command accepts assignment statements as arguments to create fields on an item.

Assignment statements use this format:

```shell
[<section>.]<field>[[<fieldType>]]=<value>
```

* `section` (Optional) — The section where the field will be created
* `field` — The field name
* `fieldType` — The field type. Defaults to `password` if unspecified
* `value` — The information to save

For built-in fields, the `field` name should match the built-in field `id` in the item template. Don't include a `fieldType` for built-in fields.

For custom fields, the `fieldType` should match the custom field `type`. The `field` name can be anything.

If using periods, equal signs, or backslashes in section or field names, escape them with backslash. Don't escape the `value`.

Example for built-in `username` field on a Login item:

```shell
'username=john.doe@acme.org'
```

Example for custom `date` field in a section:

```shell
'Subscription Info.Renewal Date[date]=2022-12-31'
```

To add both assignment statements to a new `HBO Max` item:

```shell
op item create \
    --category login \
    --title "HBO Max" \
    --vault Tutorial \
    --url 'https://www.hbomax.com' \
    --generate-password='letters,digits,symbols,32' \
    --tags tutorial,entertainment \
    'username=john.doe@acme.org' \
    'Subscription Info.Renewal Date[date]=2022-12-31'
```

> **Danger:** Command arguments can be visible to other processes on your machine. If assigning sensitive values, use an item JSON template instead.

### With an item JSON template

To assign sensitive values, fill out an item JSON template for your item category. If combining field assignment statements with a template, the assignment statements overwrite template values.

To see available templates, run `op item template list`. To get a specific template, run `op item template get <category>`.

For example, to create a new Login item using a template:

1. Get the template for a Login item and save it:
   ```shell
   op item template get --out-file=login.json "Login"
   ```
2. Edit the template file to add your information.
3. Create the item using the `--template` flag:
   ```shell
   op item create --template=login.json
   ```

Example Login template that creates a Login item named `Hulu`:

```json
{
  "title": "Hulu",
  "vault": {
    "id": "sor33rgjjcg2xykftymcmqm5am"
  },
  "category": "LOGIN",
  "fields": [
    {
      "id": "username",
      "type": "STRING",
      "purpose": "USERNAME",
      "label": "username",
      "value": "wendy.appleseed@gmail.com"
    },
    {
      "id": "password",
      "type": "CONCEALED",
      "purpose": "PASSWORD",
      "label": "password",
      "password_details": {
        "strength": ""
      },
      "value": "Dp2WxXfwN7VFJojENfEHLEBJmAGAxup@"
    },
    {
      "id": "notesPlain",
      "type": "STRING",
      "purpose": "NOTES",
      "label": "notesPlain",
      "value": "This is Wendy's Hulu account."
    },
    {
      "id": "date",
      "type": "date",
      "label": "Subscription renewal date",
      "value": "2023-04-05"
    }
  ]
}
```

You can also create an item from standard input using a template:

```shell
op item template get Login | op item create --vault Tutorial -
```

## Create an item from an existing item

Create a new item from an existing item by piping the item JSON from standard input.

For example, to create a new item based on the `HBO Max` item with a new title, username, and password:

```shell
op item get "HBO Max" --format json | op item create --vault Tutorial --title "Wendy's HBO Max" - 'username=wendy.appleseed@acme.org' 'password=Dp2WxXfwN7VFJojENfEHLEBJmAGAxup@'
```

## Add a one-time password to an item

Attach a one-time password to an item using a custom field assignment statement. The `fieldType` should be `otp` and the `value` should be the `otpauth://` URI.

```shell
op item create \
    --category login \
    --title='My OTP Example' \
    --vault Tutorial \
    --url 'https://www.acme.com/login' \
    --generate-password='letters,digits,symbols,32' \
    --tags tutorial,entertainment \
    'Test Section 1.Test Field3[otp]=otpauth://totp/<website>:<user>?secret=<secret>&issuer=<issuer>'
```

## Attach a file to an item

Attach a file to an item using a custom field assignment statement. The `field` should be the file name in 1Password, the `fieldType` should be `file`, and the `value` should be the file path.

```shell
myFileName[file]=/path/to/your/file
```

To preserve the original file name, omit the `field`:

```shell
[file]=/path/to/your/file
```

## Learn more

* [Built-in and custom item fields](/cli/item-fields)
* [Edit items](/cli/item-edit)
* [`op item` command reference](/cli/reference/management-commands/item)
