> Source: https://www.1password.dev/cli/reference/management-commands/vault/



> ## Documentation Index
>
> Fetch the complete documentation index at: [/llms.txt](/llms.txt)
>
> Use this file to discover all available pages before exploring further.


<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


<a href="/" class="select-none" data-state="closed" data-slot="context-menu-trigger" style="-webkit-touch-callout:none"><span class="sr-only">1Password Developer home page</span><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=29d1c9358888a723dddd8a89a3b6f71d" class="nav-logo w-auto h-7 relative object-contain shrink-0 block dark:hidden" alt="light logo" /><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-light.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=119233092720e49043d6f42ff71125f1" class="nav-logo w-auto h-7 relative object-contain shrink-0 hidden dark:block" alt="dark logo" /></a>


Search...


Management commands


vault


<a href="/get-started" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Get Started</a>


<a href="/security-for-ai" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Security for AI</a>


<a href="/environments" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Environments</a>


<a href="/ssh" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SSH &amp; Git</a>


<a href="/cli" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200 [text-shadow:-0.2px_0_0_currentColor,0.2px_0_0_currentColor]" data-active="true" aria-current="location">CLI</a>


<a href="/sdks" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SDKs</a>


More Tools


Management commands


# vault


Copy page


Copy page


### 


<a href="#subcommands" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="#vault-create" class="link">vault create</a>: Create a new vault
- <a href="#vault-delete" class="link">vault delete</a>: Remove a vault
- <a href="#vault-edit" class="link">vault edit</a>: Edit a vault’s name, description, icon, or Travel Mode status
- <a href="#vault-get" class="link">vault get</a>: Get details about a vault
- <a href="#vault-group" class="link">vault group</a>: Manage group vault access
- <a href="#vault-list" class="link">vault list</a>: List all vaults in the account
- <a href="#vault-user" class="link">vault user</a>: Manage user vault access

## 


<a href="#vault-create" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op vault create <name> [flags]
```


### 


<a href="#flags" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--allow-admins-to-manage true|false   Set whether administrators can manage the vault.
                                      If not provided, the default policy for the account applies.
--description description             Set the vault's description.
--icon string                         Set the vault icon.
```


## 


<a href="#vault-delete" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op vault delete [{ <vaultName> | <vaultID> | - }] [flags]
```


## 


<a href="#vault-edit" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op vault edit [{ <vaultName> | <vaultID> | - }] [flags]
```


### 


<a href="#flags-2" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--description description   Change the vault's description.
--icon icon                 Change the vault's icon.
--name name                 Change the vault's name.
--travel-mode on|off        Turn Travel Mode on or off for the vault. (default off)
```


## 


<a href="#vault-get" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op vault get [{ <vaultName> | <vaultID> | - }] [flags]
```


#### 


<a href="#use-standard-input-to-specify-objects" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#examples" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op vault list --format=json | op vault get -
```


``` shiki
op vault list --group security --format=json | op vault get -
```


## 


<a href="#vault-group" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#subcommands-2" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="#vault-group-grant" class="link">vault group grant</a>: Grant a group permissions to a vault
- <a href="#vault-group-list" class="link">vault group list</a>: List all the groups that have access to the given vault
- <a href="#vault-group-revoke" class="link">vault group revoke</a>: Revoke a portion or the entire access of a group to a vault

## 


<a href="#vault-group-grant" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op vault group grant [flags]
```


### 


<a href="#flags-3" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


### 


<a href="#examples-2" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


## 


<a href="#vault-group-list" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op vault group list [{ <vault> | - }] [flags]
```


## 


<a href="#vault-group-revoke" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op vault group revoke [flags]
```


### 


<a href="#flags-4" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


### 


<a href="#examples-3" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


## 


<a href="#vault-list" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op vault list [flags]
```


### 


<a href="#flags-5" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--group string            List vaults a group has access to.
--permission permissions  List only vaults that the specified user/group has this permission for.
--user string             List vaults that a given user has access to.
```


### 


<a href="#examples-4" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


## 


<a href="#vault-user" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#subcommands-3" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="#vault-user-grant" class="link">vault user grant</a>: Grant a user access to a vault
- <a href="#vault-user-list" class="link">vault user list</a>: List all users with access to the vault and their permissions
- <a href="#vault-user-revoke" class="link">vault user revoke</a>: Revoke a portion or the entire access of a user to a vault

## 


<a href="#vault-user-grant" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op vault user grant [flags]
```


### 


<a href="#flags-6" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


### 


<a href="#examples-5" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


## 


<a href="#vault-user-list" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op vault user list <vault> [flags]
```


## 


<a href="#vault-user-revoke" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op vault user revoke [flags]
```


### 


<a href="#flags-7" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


### 


<a href="#examples-6" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


<a href="/cli/reference/management-commands/user" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">user</span></a><a href="/cli/reference/commands/completion" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">completion</span></a>


Responses are generated using AI and may contain mistakes.


<a href="mailto:support@1password.com" class="group flex justify-between items-center gap-1 mt-2 py-1 transition-colors duration-200" data-component-part="contact-support-button"><span data-component-part="contact-support-icon"></span></a>

Contact support


