> Source: https://www.1password.dev/cli/reference/management-commands/connect/



Management commands


# connect


### <a href="#subcommands" class="anchor-link" aria-label="Navigate to header: Subcommands"></a><span id="_R_59deehkd74t9_" class="min-w-0 break-words cursor-pointer">Subcommands</span>

- <a href="#connect-group" class="link">connect group</a>: Manage group access to Secrets Automation
- <a href="#connect-server" class="link">connect server</a>: Manage Connect servers
- <a href="#connect-token" class="link">connect token</a>: Manage Connect server tokens
- <a href="#connect-vault" class="link">connect vault</a>: Manage Connect server vault access

## <a href="#connect-group" class="anchor-link" aria-label="Navigate to header: connect group"></a><span id="_R_99deehkd74t9_" class="cursor-pointer">connect group</span>

### <a href="#subcommands-2" class="anchor-link" aria-label="Navigate to header: Subcommands"></a><span id="_R_b9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Subcommands</span>

- <a href="#connect-group-grant" class="link">connect group grant</a>: Grant a group access to manage Secrets Automation
- <a href="#connect-group-revoke" class="link">connect group revoke</a>: Revoke a group’s access to manage Secrets Automation

## <a href="#connect-group-grant" class="anchor-link" aria-label="Navigate to header: connect group grant"></a><span id="_R_f9deehkd74t9_" class="cursor-pointer">connect group grant</span>


``` shiki
op connect group grant [flags]
```


### <a href="#flags" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_l9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--all-servers     Grant access to all current and future servers in the authenticated
                  account.
--group group     The group to receive access.
--server server   The server to grant access to.
```


## <a href="#connect-group-revoke" class="anchor-link" aria-label="Navigate to header: connect group revoke"></a><span id="_R_r9deehkd74t9_" class="cursor-pointer">connect group revoke</span>


``` shiki
op connect group revoke [flags]
```


### <a href="#flags-2" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_119deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--all-servers     Revoke access to all current and future servers in the
                  authenticated account.
--group group     The group to revoke access from.
--server server   The server to revoke access to.
```


## <a href="#connect-server" class="anchor-link" aria-label="Navigate to header: connect server"></a><span id="_R_159deehkd74t9_" class="cursor-pointer">connect server</span>

### <a href="#subcommands-3" class="anchor-link" aria-label="Navigate to header: Subcommands"></a><span id="_R_179deehkd74t9_" class="min-w-0 break-words cursor-pointer">Subcommands</span>

- <a href="#connect-server-create" class="link">connect server create</a>: Set up a Connect server
- <a href="#connect-server-delete" class="link">connect server delete</a>: Remove a Connect server
- <a href="#connect-server-edit" class="link">connect server edit</a>: Rename a Connect server
- <a href="#connect-server-get" class="link">connect server get</a>: Get a Connect server
- <a href="#connect-server-list" class="link">connect server list</a>: List Connect servers

## <a href="#connect-server-create" class="anchor-link" aria-label="Navigate to header: connect server create"></a><span id="_R_1b9deehkd74t9_" class="cursor-pointer">connect server create</span>


``` shiki
op connect server create <name> [flags]
```


### <a href="#flags-3" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_1j9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
-f, --force            Do not prompt for confirmation when overwriting credential files.
    --vaults strings   Grant the Connect server access to these vaults.
```


## <a href="#connect-server-delete" class="anchor-link" aria-label="Navigate to header: connect server delete"></a><span id="_R_1p9deehkd74t9_" class="cursor-pointer">connect server delete</span>


``` shiki
op connect server delete [{ <serverName> | <serverID> | - }] [flags]
```


## <a href="#connect-server-edit" class="anchor-link" aria-label="Navigate to header: connect server edit"></a><span id="_R_219deehkd74t9_" class="cursor-pointer">connect server edit</span>


``` shiki
op connect server edit { <serverName> | <serverID> } [flags]
```


### <a href="#flags-4" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_279deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--name name   Change the server's name.
```


## <a href="#connect-server-get" class="anchor-link" aria-label="Navigate to header: connect server get"></a><span id="_R_2b9deehkd74t9_" class="cursor-pointer">connect server get</span>


``` shiki
op connect server get [{ <serverName> | <serverID> | - }] [flags]
```


## <a href="#connect-server-list" class="anchor-link" aria-label="Navigate to header: connect server list"></a><span id="_R_2h9deehkd74t9_" class="cursor-pointer">connect server list</span>


``` shiki
op connect server list [flags]
```


## <a href="#connect-token" class="anchor-link" aria-label="Navigate to header: connect token"></a><span id="_R_2n9deehkd74t9_" class="cursor-pointer">connect token</span>

### <a href="#subcommands-4" class="anchor-link" aria-label="Navigate to header: Subcommands"></a><span id="_R_2p9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Subcommands</span>

- <a href="#connect-token-create" class="link">connect token create</a>: Issue a token for a 1Password Connect server
- <a href="#connect-token-delete" class="link">connect token delete</a>: Revoke a token for a Connect server
- <a href="#connect-token-edit" class="link">connect token edit</a>: Rename a Connect server token
- <a href="#connect-token-list" class="link">connect token list</a>: Get a list of tokens

## <a href="#connect-token-create" class="anchor-link" aria-label="Navigate to header: connect token create"></a><span id="_R_2t9deehkd74t9_" class="cursor-pointer">connect token create</span>


``` shiki
op connect token create <tokenName> [flags]
```


### <a href="#flags-5" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_339deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


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


## <a href="#connect-token-delete" class="anchor-link" aria-label="Navigate to header: connect token delete"></a><span id="_R_3j9deehkd74t9_" class="cursor-pointer">connect token delete</span>


``` shiki
op connect token delete [ <token> ] [flags]
```


### <a href="#flags-6" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_3p9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--server string   Only look for tokens for this 1Password Connect server.
```


## <a href="#connect-token-edit" class="anchor-link" aria-label="Navigate to header: connect token edit"></a><span id="_R_3t9deehkd74t9_" class="cursor-pointer">connect token edit</span>


``` shiki
op connect token edit <token> [flags]
```


### <a href="#flags-7" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_439deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--name string     Change the token's name.
--server string   Only look for tokens for this 1Password Connect server.
```


## <a href="#connect-token-list" class="anchor-link" aria-label="Navigate to header: connect token list"></a><span id="_R_479deehkd74t9_" class="cursor-pointer">connect token list</span>


``` shiki
op connect token list [flags]
```


### <a href="#flags-8" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_4d9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--server server   Only list tokens for this Connect server.
```


## <a href="#connect-vault" class="anchor-link" aria-label="Navigate to header: connect vault"></a><span id="_R_4l9deehkd74t9_" class="cursor-pointer">connect vault</span>

### <a href="#subcommands-5" class="anchor-link" aria-label="Navigate to header: Subcommands"></a><span id="_R_4n9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Subcommands</span>

- <a href="#connect-vault-grant" class="link">connect vault grant</a>: Grant a Connect server access to a vault
- <a href="#connect-vault-revoke" class="link">connect vault revoke</a>: Revoke a Connect server’s access to a vault

## <a href="#connect-vault-grant" class="anchor-link" aria-label="Navigate to header: connect vault grant"></a><span id="_R_4r9deehkd74t9_" class="cursor-pointer">connect vault grant</span>


``` shiki
op connect vault grant [flags]
```


### <a href="#flags-9" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_539deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--server string   The server to be granted access.
--vault string    The vault to grant access to.
```


## <a href="#connect-vault-revoke" class="anchor-link" aria-label="Navigate to header: connect vault revoke"></a><span id="_R_579deehkd74t9_" class="cursor-pointer">connect vault revoke</span>


``` shiki
op connect vault revoke [flags]
```


### <a href="#flags-10" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_5d9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--server server   The server to revoke access from.
--vault vault     The vault to revoke a server's access to.
```


Was this page helpful?


