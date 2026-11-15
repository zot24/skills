> Source: https://www.1password.dev/cli/reference/management-commands/group/



Management commands


# group


### <a href="#subcommands" class="anchor-link" aria-label="Navigate to header: Subcommands"></a><span id="_R_59deehkd74t9_" class="min-w-0 break-words cursor-pointer">Subcommands</span>

- <a href="#group-create" class="link">group create</a>: Create a group
- <a href="#group-delete" class="link">group delete</a>: Remove a group
- <a href="#group-edit" class="link">group edit</a>: Edit a group’s name or description
- <a href="#group-get" class="link">group get</a>: Get details about a group
- <a href="#group-list" class="link">group list</a>: List groups
- <a href="#group-user" class="link">group user</a>: Manage group membership

## <a href="#group-create" class="anchor-link" aria-label="Navigate to header: group create"></a><span id="_R_99deehkd74t9_" class="cursor-pointer">group create</span>


``` shiki
op group create <name> [flags]
```


### <a href="#flags" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_f9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--description string   Set the group's description.
```


## <a href="#group-delete" class="anchor-link" aria-label="Navigate to header: group delete"></a><span id="_R_j9deehkd74t9_" class="cursor-pointer">group delete</span>


``` shiki
op group delete [{ <groupName> | <groupID> | - }] [flags]
```


## <a href="#group-edit" class="anchor-link" aria-label="Navigate to header: group edit"></a><span id="_R_p9deehkd74t9_" class="cursor-pointer">group edit</span>


``` shiki
op group edit [{ <groupName> | <groupID> | - }] [flags]
```


### <a href="#flags-2" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_v9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--description description   Change the group's description.
--name name                 Change the group's name.
```


## <a href="#group-get" class="anchor-link" aria-label="Navigate to header: group get"></a><span id="_R_139deehkd74t9_" class="cursor-pointer">group get</span>


``` shiki
op group get [{ <groupName> | <groupID> | - }] [flags]
```


#### <a href="#use-standard-input-to-specify-objects" class="anchor-link" aria-label="Navigate to header: Use standard input to specify objects"></a><span id="_R_199deehkd74t9_" class="cursor-pointer">Use standard input to specify objects</span>


### <a href="#examples" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_1f9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
op group list --format=json | op group get -
```


``` shiki
op group list --vault "Production keys" --format=json | op group get -
```


## <a href="#group-list" class="anchor-link" aria-label="Navigate to header: group list"></a><span id="_R_1p9deehkd74t9_" class="cursor-pointer">group list</span>


``` shiki
op group list [flags]
```


### <a href="#flags-3" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_1v9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--user user     List groups that a user belongs to.
--vault vault   List groups that have direct access to a vault.
```


### <a href="#examples-2" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_259deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
op group list | op group get -
```


``` shiki
op group list --vault Staging --format=json | op group get -
```


``` shiki
op group list --user wendy_appleseed@1password.com --format=json | op group get -
```


## <a href="#group-user" class="anchor-link" aria-label="Navigate to header: group user"></a><span id="_R_2j9deehkd74t9_" class="cursor-pointer">group user</span>

### <a href="#subcommands-2" class="anchor-link" aria-label="Navigate to header: Subcommands"></a><span id="_R_2l9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Subcommands</span>

- <a href="#group-user-grant" class="link">group user grant</a>: Add a user to a group
- <a href="#group-user-list" class="link">group user list</a>: Retrieve users that belong to a group
- <a href="#group-user-revoke" class="link">group user revoke</a>: Remove a user from a group

## <a href="#group-user-grant" class="anchor-link" aria-label="Navigate to header: group user grant"></a><span id="_R_2p9deehkd74t9_" class="cursor-pointer">group user grant</span>


``` shiki
op group user grant [flags]
```


### <a href="#flags-4" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_2v9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--group string   Specify the group to grant the user access to.
--role string    Specify the user's role as a member or manager. Default: member.
--user string    Specify the user to grant group access to.
```


## <a href="#group-user-list" class="anchor-link" aria-label="Navigate to header: group user list"></a><span id="_R_339deehkd74t9_" class="cursor-pointer">group user list</span>


``` shiki
op group user list <group> [flags]
```


## <a href="#group-user-revoke" class="anchor-link" aria-label="Navigate to header: group user revoke"></a><span id="_R_399deehkd74t9_" class="cursor-pointer">group user revoke</span>


``` shiki
op group user revoke [flags]
```


### <a href="#flags-5" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_3f9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--group string   Specify the group to remove the user from.
--help           Get help with group user revoke.
--user string    Specify the user to remove from the group.
```


Was this page helpful?


