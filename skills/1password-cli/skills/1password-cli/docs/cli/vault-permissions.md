<!-- Source: https://www.1password.dev/cli/vault-permissions/ -->

# About Vault Permissions

When using scripts to grant or revoke vault permissions, you must include any dependent permissions in the command.

The vault permissions available depend on your 1Password account type.

## Managing Vaults

Common vault commands:

```shell
op vault create <vault-name>
op vault list
op vault get <vault-name>
op vault edit <vault-name> --name <new-name>
op vault delete <vault-name>
```

Grant and revoke access:

```shell
op vault user grant --vault <vault> --user <user> --permissions view_items,create_items
op vault user revoke --vault <vault> --user <user> --permissions create_items
op vault group grant --vault <vault> --group <group> --permissions allow_viewing
op vault group revoke --vault <vault> --group <group> --permissions allow_editing
```

## 1Password Business

1Password Business includes granular permissions:

* **view_items**: view items in a vault
* **create_items**: create items in a vault
* **edit_items**: edit items in a vault
* **archive_items**: archive items in a vault
* **delete_items**: delete items in a vault
* **view_and_copy_passwords**: view concealed passwords and copy them to clipboard
* **view_item_history**: view and restore previous versions of items
* **import_items**: move or copy items into the vault
* **export_items**: save items to an unencrypted file
* **copy_and_share_items**: copy items between vaults or share outside 1Password
* **print_items**: print the contents of items in the vault
* **manage_vault**: grant and revoke access, change permissions, and delete vaults

It also includes broader permissions:

* **allow_viewing**: view items and passwords (includes `view_items`, `view_and_copy_passwords`, `view_item_history`)
* **allow_editing**: create, edit, move, print, copy, archive, and delete items
* **allow_managing**: grant and revoke access and delete vaults

The `move_items` permission is automatically added when all these permissions are granted: `view_items`, `edit_items`, `archive_items`, `view_and_copy_passwords`, `view_item_history`, `copy_and_share_items`.

### Permission Dependencies

| Permission | Requirements |
|---|---|
| `create_items` | `view_items` |
| `view_and_copy_passwords` | `view_items` |
| `edit_items` | `view_and_copy_passwords`, `view_items` |
| `archive_items` | `edit_items`, `view_and_copy_passwords`, `view_items` |
| `delete_items` | `edit_items`, `view_and_copy_passwords`, `view_items` |
| `view_item_history` | `view_and_copy_passwords`, `view_items` |
| `import_items` | `create_items`, `view_items` |
| `export_items` | `view_item_history`, `view_and_copy_passwords`, `view_items` |
| `copy_and_share_items` | `view_item_history`, `view_and_copy_passwords`, `view_items` |
| `print_items` | `view_item_history`, `view_and_copy_passwords`, `view_items` |

## 1Password Teams & Families

Both include three permissions:

* **allow_viewing**: view items and concealed passwords
* **allow_editing**: create, edit, move, print, copy, archive, and delete items
* **allow_managing**: grant and revoke access and delete vaults

### Permission Dependencies

| Permission | Requirements |
|---|---|
| `allow_editing` | `allow_viewing` |
| `allow_managing` | (none) |
