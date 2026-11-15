> Source: https://www.1password.dev/cli/reference/management-commands/vault/



Management commands


# vault


### <a href="#subcommands" class="anchor-link" aria-label="Navigate to header: Subcommands"></a><span id="_R_39deehkd74t9_" class="min-w-0 break-words cursor-pointer">Subcommands</span>

- <a href="#vault-create" class="link">vault create</a>: Create a new vault
- <a href="#vault-delete" class="link">vault delete</a>: Remove a vault
- <a href="#vault-edit" class="link">vault edit</a>: Edit a vault’s name, description, icon, or Travel Mode status
- <a href="#vault-get" class="link">vault get</a>: Get details about a vault
- <a href="#vault-group" class="link">vault group</a>: Manage group vault access
- <a href="#vault-list" class="link">vault list</a>: List all vaults in the account
- <a href="#vault-user" class="link">vault user</a>: Manage user vault access

## <a href="#vault-create" class="anchor-link" aria-label="Navigate to header: vault create"></a><span id="_R_79deehkd74t9_" class="cursor-pointer">vault create</span>


``` shiki
op vault create <name> [flags]
```


### <a href="#flags" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_d9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--allow-admins-to-manage true|false   Set whether administrators can manage the vault.
                                      If not provided, the default policy for the account applies.
--description description             Set the vault's description.
--icon string                         Set the vault icon.
```


## <a href="#vault-delete" class="anchor-link" aria-label="Navigate to header: vault delete"></a><span id="_R_j9deehkd74t9_" class="cursor-pointer">vault delete</span>


``` shiki
op vault delete [{ <vaultName> | <vaultID> | - }] [flags]
```


## <a href="#vault-edit" class="anchor-link" aria-label="Navigate to header: vault edit"></a><span id="_R_r9deehkd74t9_" class="cursor-pointer">vault edit</span>


``` shiki
op vault edit [{ <vaultName> | <vaultID> | - }] [flags]
```


### <a href="#flags-2" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_119deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--description description   Change the vault's description.
--icon icon                 Change the vault's icon.
--name name                 Change the vault's name.
--travel-mode on|off        Turn Travel Mode on or off for the vault. (default off)
```


## <a href="#vault-get" class="anchor-link" aria-label="Navigate to header: vault get"></a><span id="_R_1b9deehkd74t9_" class="cursor-pointer">vault get</span>


``` shiki
op vault get [{ <vaultName> | <vaultID> | - }] [flags]
```


#### <a href="#use-standard-input-to-specify-objects" class="anchor-link" aria-label="Navigate to header: Use standard input to specify objects"></a><span id="_R_1j9deehkd74t9_" class="cursor-pointer">Use standard input to specify objects</span>


### <a href="#examples" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_1p9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
op vault list --format=json | op vault get -
```


``` shiki
op vault list --group security --format=json | op vault get -
```


## <a href="#vault-group" class="anchor-link" aria-label="Navigate to header: vault group"></a><span id="_R_239deehkd74t9_" class="cursor-pointer">vault group</span>

### <a href="#subcommands-2" class="anchor-link" aria-label="Navigate to header: Subcommands"></a><span id="_R_259deehkd74t9_" class="min-w-0 break-words cursor-pointer">Subcommands</span>

- <a href="#vault-group-grant" class="link">vault group grant</a>: Grant a group permissions to a vault
- <a href="#vault-group-list" class="link">vault group list</a>: List all the groups that have access to the given vault
- <a href="#vault-group-revoke" class="link">vault group revoke</a>: Revoke a portion or the entire access of a group to a vault

## <a href="#vault-group-grant" class="anchor-link" aria-label="Navigate to header: vault group grant"></a><span id="_R_299deehkd74t9_" class="cursor-pointer">vault group grant</span>


``` shiki
op vault group grant [flags]
```


### <a href="#flags-3" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_2f9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--group group               The group to receive access.
--no-input input            Do not prompt for input on interactive terminal.
--permissions permissions   The permissions to grant to the group.
--vault vault               The vault to grant group permissions to.
```


``` shiki
view_items,view_and_copy_passwords,edit_items
```


``` shiki
allow_viewing, allow_editing, allow_managing
```


``` shiki
view_items, view_and_copy_passwords, view_item_history
```


``` shiki
create_items, edit_items, archive_items, delete_items, import_items,
export_items, copy_and_share_items, print_items
```


``` shiki
manage_vault
```


### <a href="#examples-2" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_3d9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
op vault group grant --vault VAULT --group GROUP \
   --permissions view_items,create_items,allow_viewing
```


``` shiki
op vault group grant --vault VAULT --group GROUP \
   --permissions allow_viewing,export_items
```


``` shiki
op vault group grant --vault VAULT --group GROUP \
   --permissions allow_viewing,allow_editing
```


## <a href="#vault-group-list" class="anchor-link" aria-label="Navigate to header: vault group list"></a><span id="_R_3p9deehkd74t9_" class="cursor-pointer">vault group list</span>


``` shiki
op vault group list [{ <vault> | - }] [flags]
```


## <a href="#vault-group-revoke" class="anchor-link" aria-label="Navigate to header: vault group revoke"></a><span id="_R_3v9deehkd74t9_" class="cursor-pointer">vault group revoke</span>


``` shiki
op vault group revoke [flags]
```


### <a href="#flags-4" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_459deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--group group               The group to revoke access from.
--no-input input            Do not prompt for input on interactive terminal.
--permissions permissions   The permissions to revoke from the group.
--vault vault               The vault to revoke access to.
```


``` shiki
view_items,view_and_copy_passwords,edit_items
```


``` shiki
allow_viewing, allow_editing, allow_managing
```


``` shiki
view_items, view_and_copy_passwords, view_item_history
```


``` shiki
create_items, edit_items, archive_items, delete_items, import_items,
export_items, copy_and_share_items, print_items
```


``` shiki
manage_vault
```


### <a href="#examples-3" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_579deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
op vault group revoke --vault VAULT --group GROUP
```


``` shiki
op vault group revoke --vault VAULT --group GROUP \
   --permissions view_items,create_items,allow_editing
```


``` shiki
op vault group revoke --vault VAULT --group GROUP \
   --permissions allow_viewing,allow_editing
```


## <a href="#vault-list" class="anchor-link" aria-label="Navigate to header: vault list"></a><span id="_R_5l9deehkd74t9_" class="cursor-pointer">vault list</span>


``` shiki
op vault list [flags]
```


### <a href="#flags-5" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_5r9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--group string            List vaults a group has access to.
--permission permissions  List only vaults that the specified user/group has this permission for.
--user string             List vaults that a given user has access to.
```


### <a href="#examples-4" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_619deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
op vault list --format=json | op vault get -
```


``` shiki
op vault list --group Security --format=json | op vault get -
```


``` shiki
op vault list --user wendy_appleseed@1password.com --format=json | op vault get -
```


``` shiki
op vault list --user wendy_appleseed@1password.com --permission manage_vault
```


## <a href="#vault-user" class="anchor-link" aria-label="Navigate to header: vault user"></a><span id="_R_6j9deehkd74t9_" class="cursor-pointer">vault user</span>

### <a href="#subcommands-3" class="anchor-link" aria-label="Navigate to header: Subcommands"></a><span id="_R_6l9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Subcommands</span>

- <a href="#vault-user-grant" class="link">vault user grant</a>: Grant a user access to a vault
- <a href="#vault-user-list" class="link">vault user list</a>: List all users with access to the vault and their permissions
- <a href="#vault-user-revoke" class="link">vault user revoke</a>: Revoke a portion or the entire access of a user to a vault

## <a href="#vault-user-grant" class="anchor-link" aria-label="Navigate to header: vault user grant"></a><span id="_R_6p9deehkd74t9_" class="cursor-pointer">vault user grant</span>


``` shiki
op vault user grant [flags]
```


### <a href="#flags-6" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_6v9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--no-input input            Do not prompt for input on interactive terminal.
--permissions permissions   The permissions to grant to the user.
--user user                 The user to receive access.
--vault vault               The vault to grant access to.
```


``` shiki
view_items,view_and_copy_passwords,edit_items
```


``` shiki
allow_viewing, allow_editing, allow_managing
```


``` shiki
view_items, view_and_copy_passwords, view_item_history
```


``` shiki
create_items, edit_items, archive_items, delete_items, import_items,
export_items, copy_and_share_items, print_items
```


``` shiki
manage_vault
```


### <a href="#examples-5" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_7t9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
op vault user grant --vault VAULT --user USER \
   --permissions view_items,create_items,allow_viewing
```


``` shiki
op vault user grant --vault VAULT --user USER \
   --permissions allow_viewing,export_items
```


``` shiki
op vault user grant --vault VAULT --user USER \
   --permissions allow_viewing,allow_editing
```


## <a href="#vault-user-list" class="anchor-link" aria-label="Navigate to header: vault user list"></a><span id="_R_899deehkd74t9_" class="cursor-pointer">vault user list</span>


``` shiki
op vault user list <vault> [flags]
```


## <a href="#vault-user-revoke" class="anchor-link" aria-label="Navigate to header: vault user revoke"></a><span id="_R_8f9deehkd74t9_" class="cursor-pointer">vault user revoke</span>


``` shiki
op vault user revoke [flags]
```


### <a href="#flags-7" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_8l9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--no-input input            Do not prompt for input on interactive terminal.
--permissions permissions   The permissions to revoke from the user.
--user user                 The user to revoke access from.
--vault vault               The vault to revoke access to.
```


``` shiki
view_items,view_and_copy_passwords,edit_items
```


``` shiki
allow_viewing, allow_editing, allow_managing
```


``` shiki
view_items, view_and_copy_passwords, view_item_history
```


``` shiki
create_items, edit_items, archive_items, delete_items, import_items,
export_items, copy_and_share_items, print_items
```


``` shiki
manage_vault
```


### <a href="#examples-6" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_9n9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
op vault user revoke --vault VAULT --user USER
```


``` shiki
op vault user revoke --vault VAULT --user USER \
   --permissions view_items,create_items,allow_editing
```


``` shiki
op vault user revoke --vault VAULT --user USER \
   --permissions allow_viewing,allow_editing
```


Was this page helpful?


