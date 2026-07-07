> Source: https://www.1password.dev/cli/vault-permissions/



> ## Documentation Index
>
> Fetch the complete documentation index at: [/llms.txt](/llms.txt)
>
> Use this file to discover all available pages before exploring further.


<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


<a href="/" class="select-none" data-state="closed" data-slot="context-menu-trigger" style="-webkit-touch-callout:none"><span class="sr-only">1Password Developer home page</span><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=29d1c9358888a723dddd8a89a3b6f71d" class="nav-logo w-auto h-7 relative object-contain shrink-0 block dark:hidden" alt="light logo" /><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-light.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=119233092720e49043d6f42ff71125f1" class="nav-logo w-auto h-7 relative object-contain shrink-0 hidden dark:block" alt="dark logo" /></a>


Search...


Concepts


About vault permissions


<a href="/get-started" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Get Started</a>


<a href="/security-for-ai" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Security for AI</a>


<a href="/environments" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Environments</a>


<a href="/ssh" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SSH &amp; Git</a>


<a href="/cli" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200 [text-shadow:-0.2px_0_0_currentColor,0.2px_0_0_currentColor]" data-active="true" aria-current="location">CLI</a>


<a href="/sdks" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SDKs</a>


More Tools


Concepts


# About vault permissions


Copy page


Copy page


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


| permission                | requirements                                                 |
|---------------------------|--------------------------------------------------------------|
| `create_items`            | `view_items`                                                 |
| `view_and_copy_passwords` | `view_items`                                                 |
| `edit_items`              | `view_and_copy_passwords` , `view_items`                     |
| `archive_items`           | `edit_items`, `view_and_copy_passwords`, `view_items`        |
| `delete_items`            | `edit_items`, `view_and_copy_passwords`, `view_items`        |
| `view_item_history`       | `view_and_copy_passwords`, `view_items`                      |
| `import_items`            | `create_items`, `view_items`                                 |
| `export_items`            | `view_item_history`, `view_and_copy_passwords`, `view_items` |
| `copy_and_share_items`    | `view_item_history`, `view_and_copy_passwords`, `view_items` |
| `print_items`             | `view_item_history`, `view_and_copy_passwords`, `view_items` |


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


## 


<a href="#learn-more" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/cli/grant-revoke-vault-permissions" class="link">Grant and revoke vault permissions</a>
- <a href="/cli/reference/management-commands/vault" class="link">Work with vaults</a>
- <a href="/get-started/manage-organization" class="link">Workflow: Programmatically manage your organization</a>
- <a href="/get-started/administrator-quickstart" class="link">Administrator quickstart</a>


Was this page helpful?


<a href="/cli/secrets-template-syntax" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Template syntax</span></a><a href="/cli/user-states" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">User states</span></a>


Responses are generated using AI and may contain mistakes.


<a href="mailto:support@1password.com" class="group flex justify-between items-center gap-1 mt-2 py-1 transition-colors duration-200" data-component-part="contact-support-button"><span data-component-part="contact-support-icon"></span></a>

Contact support


