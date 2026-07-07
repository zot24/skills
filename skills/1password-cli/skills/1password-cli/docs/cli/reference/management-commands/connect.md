> Source: https://www.1password.dev/cli/reference/management-commands/connect/



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


