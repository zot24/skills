> Source: https://www.1password.dev/cli/reference/management-commands/service-account/



Management commands


# service-account


### <a href="#subcommands" class="anchor-link" aria-label="Navigate to header: Subcommands"></a><span id="_R_39deehkd74t9_" class="min-w-0 break-words cursor-pointer">Subcommands</span>

- <a href="#service-account-create" class="link">service-account create</a>: Create a service account
- <a href="#service-account-ratelimit" class="link">service-account ratelimit</a>: Retrieve rate limit usage for a service account

## <a href="#service-account-create" class="anchor-link" aria-label="Navigate to header: service-account create"></a><span id="_R_79deehkd74t9_" class="cursor-pointer">service-account create</span>


``` shiki
op service-account create <serviceAccountName> [flags]
```


### <a href="#flags" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_d9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


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


### <a href="#examples" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_119deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
op service-account create my-service-account --vault Dev:read_items --vault Test:read_items,write_items
```


``` shiki
op service-account create my-service-account --expires-in=24h
```


``` shiki
op service-account create my-service-account --can-create-vaults
```


## <a href="#service-account-ratelimit" class="anchor-link" aria-label="Navigate to header: service-account ratelimit"></a><span id="_R_1f9deehkd74t9_" class="cursor-pointer">service-account ratelimit</span>


``` shiki
op service-account ratelimit [{ <serviceAccountName> | <serviceAccountID> }] [flags]
```


Was this page helpful?


