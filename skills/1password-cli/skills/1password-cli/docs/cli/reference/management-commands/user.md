> Source: https://www.1password.dev/cli/reference/management-commands/user/



Management commands


# user


### <a href="#subcommands" class="anchor-link" aria-label="Navigate to header: Subcommands"></a><span id="_R_19deehkd74t9_" class="min-w-0 break-words cursor-pointer">Subcommands</span>

- <a href="#user-confirm" class="link">user confirm</a>: Confirm a user
- <a href="#user-delete" class="link">user delete</a>: Remove a user and all their data from the account
- <a href="#user-edit" class="link">user edit</a>: Edit a user’s name or Travel Mode status
- <a href="#user-get" class="link">user get</a>: Get details about a user
- <a href="#user-list" class="link">user list</a>: List users
- <a href="#user-provision" class="link">user provision</a>: Provision a user in the authenticated account
- <a href="#user-reactivate" class="link">user reactivate</a>: Reactivate a suspended user
- <a href="#user-recovery" class="link">user recovery</a>: Manage user recovery in your 1Password account
- <a href="#user-suspend" class="link">user suspend</a>: Suspend a user

## <a href="#user-confirm" class="anchor-link" aria-label="Navigate to header: user confirm"></a><span id="_R_59deehkd74t9_" class="cursor-pointer">user confirm</span>


``` shiki
op user confirm [{ <email> | <name> | <userID> | - }] [flags]
```


### <a href="#flags" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_b9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--all    Confirm all unconfirmed users.
```


### <a href="#examples" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_h9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
op user confirm "Wendy Appleseed"
```


``` shiki
op user confirm "wendy.appleseed@example.com"
```


## <a href="#user-delete" class="anchor-link" aria-label="Navigate to header: user delete"></a><span id="_R_r9deehkd74t9_" class="cursor-pointer">user delete</span>


``` shiki
op user delete [{ <email> | <name> | <userID> | - }] [flags]
```


## <a href="#user-edit" class="anchor-link" aria-label="Navigate to header: user edit"></a><span id="_R_139deehkd74t9_" class="cursor-pointer">user edit</span>


``` shiki
op user edit [{ <email> | <name> | <userID> | - }] [flags]
```


### <a href="#flags-2" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_199deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--name string          Set the user's name.
--travel-mode on|off   Turn Travel Mode on or off for the user. (default off)
```


## <a href="#user-get" class="anchor-link" aria-label="Navigate to header: user get"></a><span id="_R_1f9deehkd74t9_" class="cursor-pointer">user get</span>


``` shiki
op user get [{ <email> | <name> | <userID> | --me | - }] [flags]
```


### <a href="#flags-3" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_1l9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--fingerprint   Get the user's public key fingerprint.
--me            Get the authenticated user's details.
--public-key    Get the user's public key.
```


#### <a href="#use-standard-input-to-specify-objects" class="anchor-link" aria-label="Navigate to header: Use standard input to specify objects"></a><span id="_R_1r9deehkd74t9_" class="cursor-pointer">Use standard input to specify objects</span>


### <a href="#examples-2" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_219deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
op user get "Wendy Appleseed"
```


``` shiki
op user get wendy.appleseed@example.com
```


``` shiki
op user list --format=json | op user get -
```


``` shiki
op user list --group "Frontend Developers" --format=json | op user get - --publickey
```


``` shiki
op user list --vault Staging --format=json | op user get -
```


## <a href="#user-list" class="anchor-link" aria-label="Navigate to header: user list"></a><span id="_R_2n9deehkd74t9_" class="cursor-pointer">user list</span>


``` shiki
op user list [flags]
```


### <a href="#flags-4" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_2t9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--group group   List users who belong to a group.
--vault vault   List users who have direct access to vault.
```


### <a href="#examples-3" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_359deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
op user list --format=json | op user get -
```


``` shiki
op user list --group "Frontend Developers" --format=json | op user get - --publickey
```


``` shiki
op user list --vault Staging --format=json | op user get -
```


## <a href="#user-provision" class="anchor-link" aria-label="Navigate to header: user provision"></a><span id="_R_3j9deehkd74t9_" class="cursor-pointer">user provision</span>


Before you can use `op user provision`, you’ll need to set up provisioning. If your account uses automated provisioning, <a href="/cli/provision-users#with-automated-provisioning" class="link">complete the one-time setup</a>. If your account doesn’t use automated provisioning, an owner or administrator needs to <a href="/cli/provision-users#with-1password-cli" class="link">turn on CLI provisioning</a>.


``` shiki
op user provision [flags]
```


### <a href="#flags-5" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_3r9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--email string      Provide the user's email address.
--language string   Provide the user's account language. (default "en")
--name string       Provide the user's name.
```


### <a href="#examples-4" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_459deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
op user provision --name "Wendy Appleseed" --email "wendy.appleseed@example.com"
```


## <a href="#user-reactivate" class="anchor-link" aria-label="Navigate to header: user reactivate"></a><span id="_R_4b9deehkd74t9_" class="cursor-pointer">user reactivate</span>


``` shiki
op user reactivate [{ <email> | <name> | <userID> | - }] [flags]
```


## <a href="#user-recovery" class="anchor-link" aria-label="Navigate to header: user recovery"></a><span id="_R_4j9deehkd74t9_" class="cursor-pointer">user recovery</span>

### <a href="#subcommands-2" class="anchor-link" aria-label="Navigate to header: Subcommands"></a><span id="_R_4l9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Subcommands</span>

- <a href="#user-recovery-begin" class="link">user recovery begin</a>: Begin recovery for users in your 1Password account

## <a href="#user-recovery-begin" class="anchor-link" aria-label="Navigate to header: user recovery begin"></a><span id="_R_4p9deehkd74t9_" class="cursor-pointer">user recovery begin</span>


``` shiki
op user recovery begin [ { <email> | <name> | <userID> } ] [flags]
```


### <a href="#examples-5" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_4v9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
op user recovery begin ZMAE4RTRONHN7LGELNYYO373KM WHPOFIMMYFFITBVTOTZUR3R324
```


## <a href="#user-suspend" class="anchor-link" aria-label="Navigate to header: user suspend"></a><span id="_R_559deehkd74t9_" class="cursor-pointer">user suspend</span>


``` shiki
op user suspend [{ <email> | <name> | <userID> | - }] [flags]
```


### <a href="#flags-6" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_5b9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--deauthorize-devices-after duration   Deauthorize the user's devices after a time
                                        (rounded down to seconds).
```


Was this page helpful?


