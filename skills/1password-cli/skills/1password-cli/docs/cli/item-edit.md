<!-- Source: https://www.1password.dev/cli/item-edit/ -->

# Edit Items in 1Password CLI

## Overview

The `op item edit` command allows you to modify existing items in your 1Password account. You can update basic information using flags, edit fields with assignment statements, or use JSON templates for sensitive values.

**Note:** SSH keys cannot be edited with this command; refer to the SSH key management documentation instead.

## Prerequisites

- Active 1Password account
- 1Password CLI installed
- Example items created (optional, for following along with guides)

## Editing Basic Item Information

Use `op item edit` to modify an item's basic details by name, ID, or sharing link. Supported modifications include title and vault location, tags, website URL, and password generation.

### Example: Comprehensive Edit

**Bash/Zsh/sh/fish:**
```shell
op item edit "Netflix" \
    --title "Edited Netflix" \
    --vault Private \
    --tags tutorial \
    --url https://www.netflix.com \
    --generate-password='letters,digits,symbols,32'
```

**PowerShell:**
```powershell
op item edit "Netflix" `
    --title "Edited Netflix" `
    --vault Private `
    --tags tutorial `
    --url https://www.netflix.com `
    --generate-password='letters,digits,symbols,32'
```

### Reverting Changes

```shell
op item edit "Edited Netflix" \
    --title "Netflix" \
    --vault Tutorial
```

## Editing Built-in and Custom Fields

> **Security Warning:** Command arguments may be visible to other processes. Use JSON templates for sensitive data instead.

### Assignment Statement Syntax

```
[<section>.]<field>[[<fieldType>]]=<value>
```

**Parameters:**
- `section` (optional): Section containing the field
- `field`: Field name (required)
- `fieldType`: Field type; omit to preserve existing type
- `value`: Data to save; omit to leave unchanged

### Example: Update Subscription Date

```shell
op item edit "HBO Max" \
    'Renewal Date=2023-5-15'
```

## Deleting Custom Fields

Use `[delete]` as the fieldType to remove a field. Removing all fields from a section deletes the section as well. You cannot delete empty fields, but you can set them to empty strings.

### Example: Delete Field

```shell
op item edit "HBO Max" \
    'Renewal Date[delete]'
```

## Editing via JSON Template

For sensitive values, use JSON templates.

> **Important:** JSON templates don't support passkeys; using them will overwrite any passkeys on the item.

### Process

1. Export the item as JSON:
   ```shell
   op item get <item> --format json > newItem.json
   ```

   Alternatively, start with a blank template:
   ```shell
   op item template get <category>
   ```
2. Edit the JSON file as needed.
3. Apply changes using the `--template` flag:
   ```shell
   op item edit <item> --template=newItem.json
   ```
4. Delete the temporary file.

### Alternative: Piped Input

```shell
cat newItem.json | op item edit <item>
```

**Note:** Don't combine piped input and the `--template` flag in one command.

## Related Resources

- [`op item` command reference](/cli/reference/management-commands/item)
- [Built-in and custom item fields](/cli/item-fields)
