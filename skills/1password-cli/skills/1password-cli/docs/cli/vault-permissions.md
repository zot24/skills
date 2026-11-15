> Source: https://www.1password.dev/cli/vault-permissions/



Concepts


# About vault permissions


- <div id="1password-business">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-1Password Business">

  1Password Business

  </div>

  </div>

- <div id="1password-teams">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-1Password Teams">

  1Password Teams

  </div>

  </div>

- <div id="1password-families">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-1Password Families">

  1Password Families

  </div>

  </div>


- **view_items**: view items in a vault.
- **create_items**: create items in a vault.
- **edit_items**: edit items in a vault.
- **archive_items**: archive items in a vault.
- **delete_items**: delete items in a vault.
- **view_and_copy_passwords**: view concealed passwords and copy them to the clipboard.
- **view_item_history**: view and restore previous versions of items in the vault.
- **import_items**: move or copy items into the vault.
- **export_items**: save items in the vault to an unencrypted file that other apps can read.
- **copy_and_share_items**: copy items between vaults, or share them outside of 1Password.
- **print_items**: print the contents of items in the vault
- **manage_vault**: allows a team member to grant and revoke access to the vault, change permissions for others, and delete the vault. Owners will always have permission to manage vaults.


- **allow_viewing**: view items in a vault, view concealed passwords and copy them to the clipboard.
  - Includes the granular permissions: `view_items`, `view_and_copy_passwords`, `view_item_history`.
- **allow_editing**: create, edit, move, print, copy, archive, and delete items in the vault.
  - Includes the granular permissions: `create_items`, `edit_items`, `archive_items`, `delete_items`, `import_items`, `export_items`, `copy_and_share_items`, `print_items`.
- **allow_managing**: grant and revoke access to the vault, change permissions for others, and delete the vault. Owners will always have permission to manage vaults.
  - Includes the granular permission: `manage_vault`.


``` shiki
view_items, edit_items, archive_items, view_and_copy_passwords,
view_item_history, copy_and_share_items
```


In 1Password Business, all vault permissions have a hierarchical relationship in which narrower permissions require broader permissions to be granted alongside them. Permission dependencies are cumulative, so if a narrower permission is several levels down, it requires all of the broader permissions above it.

For example, to grant the narrower permission `delete_items` you must also grant the permissions `edit_items`, `view_and_copy_passwords`, and `view_items`.

Similarly, to revoke a broader permission like `view_items`, any narrower dependent permissions that have already been granted must be revoked alongside it.


| permission | requirements |
|----|----|
| `create_items` | `view_items` |
| `view_and_copy_passwords` | `view_items` |
| `edit_items` | `view_and_copy_passwords` , `view_items` |
| `archive_items` | `edit_items`, `view_and_copy_passwords`, `view_items` |
| `delete_items` | `edit_items`, `view_and_copy_passwords`, `view_items` |
| `view_item_history` | `view_and_copy_passwords`, `view_items` |
| `import_items` | `create_items`, `view_items` |
| `export_items` | `view_item_history`, `view_and_copy_passwords`, `view_items` |
| `copy_and_share_items` | `view_item_history`, `view_and_copy_passwords`, `view_items` |
| `print_items` | `view_item_history`, `view_and_copy_passwords`, `view_items` |


- **allow_viewing**: view items in a vault, view concealed passwords and copy them to the clipboard.
  - Includes the granular permissions: `view_items`, `view_and_copy_passwords`, `view_item_history`.
- **allow_editing**: create, edit, move, print, copy, archive, and delete items in the vault.
  - Includes the granular permissions: `create_items`, `edit_items`, `archive_items`, `delete_items`, `import_items`, `export_items`, `copy_and_share_items`, `print_items`.
- **allow_managing**: grant and revoke access to the vault, change permissions for others, and delete the vault. Owners will always have permission to manage vaults.
  - Includes the granular permission: `manage_vault`.


| permission       | requirements    |
|------------------|-----------------|
| `allow_editing`  | `allow_viewing` |
| `allow_managing` |                 |


- **allow_viewing**: view items in a vault, view concealed passwords and copy them to the clipboard.
  - Includes the granular permissions: `view_items`, `view_and_copy_passwords`, `view_item_history`.
- **allow_editing**: create, edit, move, print, copy, archive, and delete items in the vault.
  - Includes the granular permissions: `create_items`, `edit_items`, `archive_items`, `delete_items`, `import_items`, `export_items`, `copy_and_share_items`, `print_items`.
- **allow_managing**: grant and revoke access to the vault, change permissions for others, and delete the vault. Owners will always have permission to manage vaults.
  - Includes the granular permission: `manage_vault`.


| permission       | requirements    |
|------------------|-----------------|
| `allow_editing`  | `allow_viewing` |
| `allow_managing` |                 |


## <a href="#learn-more" class="anchor-link" aria-label="Navigate to header: Learn more"></a><span id="_R_79deehkd74t9_" class="cursor-pointer">Learn more</span>

- <a href="/cli/grant-revoke-vault-permissions/" class="link">Grant and revoke vault permissions</a>
- <a href="/cli/reference/management-commands/vault/" class="link">Work with vaults</a>
- <a href="/get-started/manage-organization" class="link">Workflow: Programmatically manage your organization</a>


Was this page helpful?


