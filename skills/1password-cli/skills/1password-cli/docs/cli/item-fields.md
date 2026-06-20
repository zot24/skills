<!-- Source: https://www.1password.dev/cli/item-fields/ -->

# Item Fields in 1Password CLI

## Overview

The 1Password CLI allows customization of items through built-in and custom fields when creating items.

## Built-in Fields

Each item category includes default fields specific to that type. To discover available built-in fields for any category, run:

```shell
op item template get <category>
```

**Available Categories:** API Credential, Bank Account, Credit Card, Crypto Wallet, Database, Document, Driver License, Email Account, Identity, Login, Medical Record, Membership, Outdoor License, Passport, Password, Reward Program, Secure Note, Server, Social Security Number, Software License, SSH Key, Wireless Router

**Example - Login Item Built-in Fields:**
- `username` (STRING)
- `password` (CONCEALED)
- `notesPlain` (STRING for notes)

When using assignment statements, reference the field `id` from the JSON template without specifying a fieldType:

```shell
'notesPlain=This is a note.'
```

## Custom Fields

Custom fields work across any item category. Available types include:

| Assignment Type | JSON Type | Purpose |
|---|---|---|
| `password` | `CONCEALED` | Concealed password field |
| `text` | `STRING` | Text string |
| `email` | `EMAIL` | Email address |
| `url` | `URL` | Web address (not for autofill) |
| `date` | `DATE` | Format: YYYY-MM-DD |
| `monthYear` | `MONTH_YEAR` | Format: YYYYMM or YYYY/MM |
| `phone` | `PHONE` | Phone number |
| `otp` | `OTP` | One-time password (otpauth:// URI) |
| `file` | N/A | File attachment (assignment statements only) |

## Reading Fields

Use `op item get` with `--fields` to extract specific fields:

```shell
op item get Netflix --fields label=username,label=password
op item get Netflix --fields type=concealed
```
