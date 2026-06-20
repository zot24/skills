<!-- Source: https://www.1password.dev/cli/reference/management-commands/item/ -->

# 1Password CLI: Item Command Reference

The `item` command enables complete CRUD operations on items stored in 1Password vaults. Below is the full reference for all subcommands, flags, and usage examples.

## Overview

Manage items across vaults with these operations: creation, retrieval, modification, deletion, movement between vaults, and secure sharing.

---

## item create

Generate new items in your vaults.

**Syntax:**
```
op item create [ - ] [ <assignment>... ] [flags]
```

**Flags:**
- `--category category` — Specify the item's category
- `--dry-run` — Preview the resulting item without saving
- `--favorite` — Mark the item as a favorite
- `--generate-password[=recipe]` — Add a randomly-generated password to Login or Password items
- `--reveal` — Display sensitive fields without concealment
- `--ssh-generate-key` — Create SSH keys (ed25519, rsa, rsa2048, rsa3072, rsa4096)
- `--tags tags` — Assign comma-separated tags
- `--template string` — Load item template from file path
- `--title title` — Set the item's name
- `--url URL` — Define the associated website
- `--vault vault` — Save to specified vault (default: Private)

**Password Generation:**

The default generates 32 characters containing uppercase, lowercase, digits, and symbols (`!@.-_*`). Customize length (1–64 characters) and character types:

```shell
--generate-password='letters,digits,symbols,32'
```

**Field Assignment Syntax:**
```
[<section>.]<field>[[<fieldType>]]=<value>
```

Example creating a custom field:
```shell
DatabaseCredentials.host[text]=33.166.240.221
```

**Template-Based Creation:**

```shell
op item template get --out-file login.json "Login"
# edit login.json
op item create --template=login.json
```

**Pipe Template Input:**
```shell
op item template get Login | op item create --vault personal -
```

**Examples:**

Create a Login with random password, custom fields, and file attachment:
```shell
op item create --category=login --title='My Example Item' --vault='Test' \
    --url https://www.acme.com/login \
    --generate-password=20,letters,digits \
    username=jane@acme.com \
    'Test Section 1.Test Field3[otp]=otpauth://totp/<website>:<user>?secret=<secret>&issuer=<issuer>' \
    'FileName[file]=/path/to/your/file'
```

Duplicate and modify an existing item:
```shell
op item get "My Item" --format json | op item create --vault prod - \
    username="My Username" password="My Password"
```

Bulk duplicate items across accounts:
```shell
op item list --vault test-vault --format json --account agilebits | \
op item get --format json --account agilebits - | \
op item create --account work -
```

---

## item delete

Remove or archive items.

**Syntax:**
```
op item delete [{ <itemName> | <itemID> | <shareLink> | - }] [flags]
```

**Flags:**
- `--archive` — Move to Archive instead of deletion
- `--vault string` — Specify vault containing the item

Deleted items remain recoverable from "Recently Deleted" for 30 days. Specify items by name, ID, or sharing link, or pipe item identifiers via stdin.

**Examples:**
```shell
op item delete "Defunct Login"
op item delete "Defunct Login" --archive
```

---

## item edit

Modify item details.

**Syntax:**
```
op item edit { <itemName> | <itemID> | <shareLink> } [ <assignment> ... ] [flags]
```

**Flags:**
- `--dry-run` — Preview changes without applying
- `--favorite` — Set favorite status (true/false)
- `--generate-password[=recipe]` — Generate new random password
- `--reveal` — Show sensitive fields unmasked
- `--tags tags` — Update tags (empty value removes all)
- `--template string` — Load template from file path
- `--title title` — Update the item's name
- `--url URL` — Change associated website
- `--vault vault` — Specify vault containing the item

**Assignment Statement Syntax:**
```
[<section>.]<field>[[<fieldType>]]=<value>
```

Create new fields by referencing non-existent names. Delete custom fields with `[delete]`.

> **Template Warning:** "JSON item templates do not support passkeys. If you use a JSON template to update an item that contains a passkey, the passkey will be overwritten."

**Template Workflow:**
```shell
op item get oldLogin --format=json > updatedLogin.json
# edit the JSON file
op item edit oldLogin --template=updatedLogin.json
# delete the temporary file
```

**Pipe Template Input:**
```shell
cat updatedLogin.json | op item edit oldLogin
```

**Examples:**
```shell
op item edit 'My Example Item' --generate-password='letters,digits,symbols,32'
op item edit 'My Example Item' 'field1=new value'
op item edit 'My Example Item' 'field1[password]'
op item edit 'My Example Item' 'field1[monthyear]=2021/09'
op item edit 'My Example Item' 'section2.field5[phone]=1-234-567-8910'
op item edit 'My Example Item' 'section2.field5[delete]'
op item edit 'My Example Item' 'username='
```

---

## item get

Retrieve item details.

**Syntax:**
```
op item get [{ <itemName> | <itemID> | <shareLink> | - }] [flags]
```

**Flags:**
- `--fields strings` — Extract specific fields using `label=<fieldName>` or `type=<fieldType>` filters
- `--include-archive` — Include archived items (also `OP_INCLUDE_ARCHIVE`)
- `--otp` — Output the primary one-time password
- `--reveal` — Display sensitive fields unmasked
- `--share-link` — Generate a shareable link for the item
- `--vault vault` — Limit search to specified vault

When multiple items share the same name, use IDs or `--vault` to narrow results. Service accounts must specify a vault with `--vault` or piped input.

**Examples:**
```shell
op item list --tags documentation --format json | op item get -
op item list --categories Login --vault Staging --format json | op item get - --fields label=username,label=password
op item get Netflix --fields label=username,label=password --format json
op item get Netflix --fields type=concealed
op item get Google --otp
op item get kiramv6tpjijkuci7fig4lndta --vault "Ops Secrets" --share-link
```

---

## item list

Display all accessible items.

**Syntax:**
```
op item list [flags]
```

**Flags:**
- `--categories categories` — Filter by item type (comma-separated)
- `--favorite` — Show only favorite items
- `--include-archive` — Include archived items (also `OP_INCLUDE_ARCHIVE`)
- `--long` — Display detailed list format
- `--tags tags` — Filter by tags (comma-separated)
- `--vault vault` — Limit to specified vault

Archives are excluded by default. Subtags are included — specifying `<tag>` also returns items tagged `<tag/subtag>`.

**Examples:**
```shell
op item list --tags documentation --format=json | op item get -
op item list --categories Login --vault Staging --format=json | op item get - --fields username,password
```

---

## item move

Transfer items between vaults.

**Syntax:**
```
op item move [{ <itemName> | <itemID> | <shareLink> | - }] [flags]
```

**Flags:**
- `--current-vault string` — Vault containing the item
- `--destination-vault string` — Target vault for the item
- `--reveal` — Display sensitive fields unmasked

Moving creates a copy in the destination vault and removes the original, generating a new item ID.

**Example:**
```shell
op item move "My Example Item" --current-vault Private --destination-vault Shared
```

---

## item share

Securely share item copies.

**Syntax:**
```
op item share { <itemName> | <itemID> } [flags]
```

**Flags:**
- `--emails strings` — Email addresses with access permission
- `--expires-in duration` — Link expiration time in (s)econds, (m)inutes, (h)ours, (d)ays, (w)eeks (default: 7d)
- `--vault string` — Vault containing the item
- `--view-once` — Link expires after single view

Create shareable links for items accessible to anyone, regardless of 1Password membership. File attachments and Document items cannot be shared.

---

## item template

Manage item type templates.

### item template get

```
op item template get [{ <category> | - }] [flags]
```

**Flags:**
- `--file-mode filemode` — Set output file permissions (default: 0600)
- `-f, --force` — Skip confirmation prompts
- `-o, --out-file string` — Write template to file instead of stdout

### item template list

```
op item template list [flags]
```

Use `op item template get <category>` to retrieve individual templates.

---

## Available Item Categories

API Credential, Bank Account, Credit Card, Crypto Wallet, Database, Document, Driver License, Email Account, Identity, Login, Medical Record, Membership, Outdoor License, Passport, Password, Reward Program, Secure Note, Server, Social Security Number, Software License, SSH Key, Wireless Router.
