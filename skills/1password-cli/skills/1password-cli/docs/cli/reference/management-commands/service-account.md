> Source: https://www.1password.dev/cli/reference/management-commands/service-account/



Management commands


# service-account


Copy page


Copy page


### 


<a href="#subcommands" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="#service-account-create" class="link">service-account create</a>: Create a service account
- <a href="#service-account-ratelimit" class="link">service-account ratelimit</a>: Retrieve rate limit usage for a service account

## 


<a href="#service-account-create" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op service-account create <serviceAccountName> [flags]
```


### 


<a href="#flags" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--can-create-vaults     Allow the service account to create new vaults.
--expires-in duration   Set how long the service account is valid for in (s)econds,
                        (m)inutes, (h)ours, (d)ays, or (w)eeks.
--raw                   Only return the service account token.
--vault stringArray     Give access to this vault with a set of permissions. Has
                        syntax <vault-name>:<permission>[,<permission>]
```


``` shiki
--vault <vault-name>:<permission>,<permission>
```


- `read_items`
- `write_items` (requires `read_items`)
- `share_items` (requires `read_items`)


### 


<a href="#examples" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op service-account create my-service-account --vault Dev:read_items --vault Test:read_items,write_items
```


``` shiki
op service-account create my-service-account --expires-in=24h
```


``` shiki
op service-account create my-service-account --can-create-vaults
```


## 


<a href="#service-account-ratelimit" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op service-account ratelimit [{ <serviceAccountName> | <serviceAccountID> }] [flags]
```


Was this page helpful?


<a href="/cli/reference/management-commands/plugin" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">plugin</span></a><a href="/cli/reference/management-commands/user" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">user</span></a>


