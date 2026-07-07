> Source: https://www.1password.dev/cli/grant-revoke-vault-permissions/



> ## Documentation Index
>
> Fetch the complete documentation index at: [/llms.txt](/llms.txt)
>
> Use this file to discover all available pages before exploring further.


<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


<a href="/" class="select-none" data-state="closed" data-slot="context-menu-trigger" style="-webkit-touch-callout:none"><span class="sr-only">1Password Developer home page</span><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=29d1c9358888a723dddd8a89a3b6f71d" class="nav-logo w-auto h-7 relative object-contain shrink-0 block dark:hidden" alt="light logo" /><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-light.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=119233092720e49043d6f42ff71125f1" class="nav-logo w-auto h-7 relative object-contain shrink-0 hidden dark:block" alt="dark logo" /></a>


Search...


Manage team members


Grant and revoke vault permissions


<a href="/get-started" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Get Started</a>


<a href="/security-for-ai" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Security for AI</a>


<a href="/environments" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Environments</a>


<a href="/ssh" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SSH &amp; Git</a>


<a href="/cli" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200 [text-shadow:-0.2px_0_0_currentColor,0.2px_0_0_currentColor]" data-active="true" aria-current="location">CLI</a>


<a href="/sdks" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SDKs</a>


More Tools


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


Responses are generated using AI and may contain mistakes.


<a href="mailto:support@1password.com" class="group flex justify-between items-center gap-1 mt-2 py-1 transition-colors duration-200" data-component-part="contact-support-button"><span data-component-part="contact-support-icon"></span></a>

Contact support


