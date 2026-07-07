> Source: https://www.1password.dev/cli/reference/management-commands/connect/



> ## Documentation Index
>
> Fetch the complete documentation index at: [/llms.txt](/llms.txt)
>
> Use this file to discover all available pages before exploring further.


<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


<a href="/" class="select-none" data-state="closed" data-slot="context-menu-trigger" style="-webkit-touch-callout:none"><span class="sr-only">1Password Developer home page</span><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=29d1c9358888a723dddd8a89a3b6f71d" class="nav-logo w-auto h-7 relative object-contain shrink-0 block dark:hidden" alt="light logo" /><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-light.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=119233092720e49043d6f42ff71125f1" class="nav-logo w-auto h-7 relative object-contain shrink-0 hidden dark:block" alt="dark logo" /></a>


Search...


Management commands


connect


<a href="/get-started" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Get Started</a>


<a href="/security-for-ai" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Security for AI</a>


<a href="/environments" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Environments</a>


<a href="/ssh" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SSH &amp; Git</a>


<a href="/cli" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200 [text-shadow:-0.2px_0_0_currentColor,0.2px_0_0_currentColor]" data-active="true" aria-current="location">CLI</a>


<a href="/sdks" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SDKs</a>


More Tools


Management commands


# connect


Copy page


Copy page


### 


<a href="#subcommands" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="#connect-group" class="link">connect group</a>: Manage group access to Secrets Automation
- <a href="#connect-server" class="link">connect server</a>: Manage Connect servers
- <a href="#connect-token" class="link">connect token</a>: Manage Connect server tokens
- <a href="#connect-vault" class="link">connect vault</a>: Manage Connect server vault access

## 


<a href="#connect-group" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#subcommands-2" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="#connect-group-grant" class="link">connect group grant</a>: Grant a group access to manage Secrets Automation
- <a href="#connect-group-revoke" class="link">connect group revoke</a>: Revoke a group’s access to manage Secrets Automation

## 


<a href="#connect-group-grant" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op connect group grant [flags]
```


### 


<a href="#flags" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--all-servers     Grant access to all current and future servers in the authenticated
                  account.
--group group     The group to receive access.
--server server   The server to grant access to.
```


## 


<a href="#connect-group-revoke" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op connect group revoke [flags]
```


### 


<a href="#flags-2" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--all-servers     Revoke access to all current and future servers in the
                  authenticated account.
--group group     The group to revoke access from.
--server server   The server to revoke access to.
```


## 


<a href="#connect-server" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#subcommands-3" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="#connect-server-create" class="link">connect server create</a>: Set up a Connect server
- <a href="#connect-server-delete" class="link">connect server delete</a>: Remove a Connect server
- <a href="#connect-server-edit" class="link">connect server edit</a>: Rename a Connect server
- <a href="#connect-server-get" class="link">connect server get</a>: Get a Connect server
- <a href="#connect-server-list" class="link">connect server list</a>: List Connect servers

## 


<a href="#connect-server-create" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op connect server create <name> [flags]
```


### 


<a href="#flags-3" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
-f, --force            Do not prompt for confirmation when overwriting credential files.
    --vaults strings   Grant the Connect server access to these vaults.
```


## 


<a href="#connect-server-delete" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op connect server delete [{ <serverName> | <serverID> | - }] [flags]
```


## 


<a href="#connect-server-edit" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op connect server edit { <serverName> | <serverID> } [flags]
```


### 


<a href="#flags-4" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--name name   Change the server's name.
```


## 


<a href="#connect-server-get" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op connect server get [{ <serverName> | <serverID> | - }] [flags]
```


## 


<a href="#connect-server-list" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op connect server list [flags]
```


## 


<a href="#connect-token" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#subcommands-4" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="#connect-token-create" class="link">connect token create</a>: Issue a token for a 1Password Connect server
- <a href="#connect-token-delete" class="link">connect token delete</a>: Revoke a token for a Connect server
- <a href="#connect-token-edit" class="link">connect token edit</a>: Rename a Connect server token
- <a href="#connect-token-list" class="link">connect token list</a>: Get a list of tokens

## 


<a href="#connect-token-create" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op connect token create <tokenName> [flags]
```


### 


<a href="#flags-5" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--expires-in duration   Set how long the Connect token is valid for in (s)econds,
                        (m)inutes, (h)ours, (d)ays, and/or (w)eeks.
--server string         Issue a token for this server.
--vault  stringArray    Issue a token on these vaults.
```


``` shiki
op connect token create "Dev k8s token" --server Dev --vaults Kubernetes,r \
   --expires-in=30d
```


``` shiki
op connect token create "Prod: Customer details" --server Prod --vault "Customers,w" \
    --vault "Vendors,r"
```


## 


<a href="#connect-token-delete" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op connect token delete [ <token> ] [flags]
```


### 


<a href="#flags-6" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--server string   Only look for tokens for this 1Password Connect server.
```


## 


<a href="#connect-token-edit" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op connect token edit <token> [flags]
```


### 


<a href="#flags-7" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--name string     Change the token's name.
--server string   Only look for tokens for this 1Password Connect server.
```


## 


<a href="#connect-token-list" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op connect token list [flags]
```


### 


<a href="#flags-8" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--server server   Only list tokens for this Connect server.
```


## 


<a href="#connect-vault" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#subcommands-5" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="#connect-vault-grant" class="link">connect vault grant</a>: Grant a Connect server access to a vault
- <a href="#connect-vault-revoke" class="link">connect vault revoke</a>: Revoke a Connect server’s access to a vault

## 


<a href="#connect-vault-grant" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op connect vault grant [flags]
```


### 


<a href="#flags-9" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--server string   The server to be granted access.
--vault string    The vault to grant access to.
```


## 


<a href="#connect-vault-revoke" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op connect vault revoke [flags]
```


### 


<a href="#flags-10" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--server server   The server to revoke access from.
--vault vault     The vault to revoke a server's access to.
```


Was this page helpful?


<a href="/cli/reference/management-commands/account" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">account</span></a><a href="/cli/reference/management-commands/document" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">document</span></a>


Responses are generated using AI and may contain mistakes.


<a href="mailto:support@1password.com" class="group flex justify-between items-center gap-1 mt-2 py-1 transition-colors duration-200" data-component-part="contact-support-button"><span data-component-part="contact-support-icon"></span></a>

Contact support


