> Source: https://www.1password.dev/cli/reference/management-commands/provisioning/



Management commands


# provisioning


### <a href="#subcommands" class="anchor-link" aria-label="Navigate to header: Subcommands"></a><span id="_R_19deehkd74t9_" class="min-w-0 break-words cursor-pointer">Subcommands</span>

- <a href="#provisioning-google" class="link">provisioning google</a>: Manage Google Workspace provisioning for your 1Password account

## <a href="#provisioning-google" class="anchor-link" aria-label="Navigate to header: provisioning google"></a><span id="_R_59deehkd74t9_" class="cursor-pointer">provisioning google</span>

### <a href="#provisioning-google-subcommands" class="anchor-link" aria-label="Navigate to header: Subcommands"></a><span id="_R_79deehkd74t9_" class="min-w-0 break-words cursor-pointer">Subcommands</span>

- <a href="#provisioning-google-sync" class="link">provisioning google sync</a>: Sync selected Google Workspace groups with 1Password

## <a href="#provisioning-google-sync" class="anchor-link" aria-label="Navigate to header: provisioning google sync"></a><span id="_R_b9deehkd74t9_" class="cursor-pointer">provisioning google sync</span>


``` shiki
op provisioning google sync [flags]
```


### <a href="#provisioning-google-sync-flags" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_h9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--integration UUID   UUID of the Google Workspace integration
                     to sync. Required. Shown during Google
                     Workspace setup.
```


### <a href="#provisioning-google-sync-examples" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_t9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
op provisioning google sync --integration 6b7fghqewnfluffyuv5oj3anlq
```


Was this page helpful?


