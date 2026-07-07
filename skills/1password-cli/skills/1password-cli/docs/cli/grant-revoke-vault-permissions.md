> Source: https://www.1password.dev/cli/grant-revoke-vault-permissions/



Manage team members


# Grant and revoke vault permissions


Copy page


Copy page


## 


<a href="#requirements" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Before you can use 1Password CLI to , you’ll need to:

- [Sign up for 1Password](https://1password.com/pricing/password-manager)
- [Install 1Password CLI](/cli/get-started/#step-1-install-1password-cli)


## 


<a href="#grant-permissions-in-vaults" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#users" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op vault user grant --user wendy.appleseed@agilebits.com --vault Prod --permissions allow_editing,allow_managing
```


``` shiki
In order to grant [allow_editing,allow_managing], the permission(s) [allow_viewing] are also required.
Would you like to grant them as well? [Y/n]
```


``` shiki
op vault user list <vault>
```


### 


<a href="#groups" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op vault group grant --group "IT" --vault Prod --permissions allow_editing,allow_managing
```


``` shiki
In order to grant [allow_editing,allow_managing], the permission(s) [allow_viewing] are also required.
Would you like to grant them as well? [Y/n]
```


``` shiki
op vault group list <vault>
```


## 


<a href="#revoke-permissions-in-vaults" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#users-2" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op vault user revoke --user wendy.appleseed@agilebits.com --vault Prod --permissions allow_viewing
```


``` shiki
In order to revoke [allow_viewing], the permission(s) [allow_editing,allow_managing] are also required.
Would you like to revoke them as well? [Y/n]
```


``` shiki
op vault user list <vault>
```


### 


<a href="#groups-2" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op vault group revoke --group "IT" --vault Prod --permissions allow_viewing
```


``` shiki
In order to revoke [allow_viewing], the permission(s) [allow_editing,allow_managing] are also required.
Would you like to revoke them as well? [Y/n]
```


``` shiki
op vault group list <vault>
```


## 


<a href="#scripting" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op vault user grant --no-input --user wendy.appleseed@agilebits.com --vault Prod --permissions allow_managing,allow_editing,allow_viewing
```


``` shiki

op vault group revoke --no-input --group "IT" --vault Prod --permissions allow_managing,allow_editing
```


## 


<a href="#learn-more" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/cli/vault-permissions" class="link">Vault permission dependencies</a>
- <a href="/get-started/manage-organization" class="link">Workflow: Programmatically manage your organization</a>
- <a href="/get-started/administrator-quickstart" class="link">Administrator quickstart</a>


Was this page helpful?


<a href="/cli/provision-users" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Add and remove team members</span></a><a href="/cli/recover-users" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Recover accounts</span></a>


