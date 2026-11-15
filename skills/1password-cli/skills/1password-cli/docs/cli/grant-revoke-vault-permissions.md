> Source: https://www.1password.dev/cli/grant-revoke-vault-permissions/



Manage team members


# Grant and revoke vault permissions


## <a href="#requirements" class="anchor-link" aria-label="Navigate to header: Requirements"></a><span id="_R_79deehkd74t9_" class="min-w-0 break-words cursor-pointer">Requirements</span>

Before you can use 1Password CLI to manage vault permissions, you’ll need to:

- [Sign up for 1Password](https://1password.com/pricing/password-manager)
- <a href="/cli/get-started/#step-1-install-1password-cli" class="link">Install 1Password CLI</a>


## <a href="#grant-permissions-in-vaults" class="anchor-link" aria-label="Navigate to header: Grant permissions in vaults"></a><span id="_R_f9deehkd74t9_" class="cursor-pointer">Grant permissions in vaults</span>

### <a href="#users" class="anchor-link" aria-label="Navigate to header: Users"></a><span id="_R_h9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Users</span>


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


### <a href="#groups" class="anchor-link" aria-label="Navigate to header: Groups"></a><span id="_R_119deehkd74t9_" class="min-w-0 break-words cursor-pointer">Groups</span>


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


## <a href="#revoke-permissions-in-vaults" class="anchor-link" aria-label="Navigate to header: Revoke permissions in vaults"></a><span id="_R_1h9deehkd74t9_" class="cursor-pointer">Revoke permissions in vaults</span>

### <a href="#users-2" class="anchor-link" aria-label="Navigate to header: Users"></a><span id="_R_1j9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Users</span>


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


### <a href="#groups-2" class="anchor-link" aria-label="Navigate to header: Groups"></a><span id="_R_239deehkd74t9_" class="min-w-0 break-words cursor-pointer">Groups</span>


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


## <a href="#scripting" class="anchor-link" aria-label="Navigate to header: Scripting"></a><span id="_R_2j9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Scripting</span>


``` shiki
op vault user grant --no-input --user wendy.appleseed@agilebits.com --vault Prod --permissions allow_managing,allow_editing,allow_viewing
```


``` shiki
op vault group revoke --no-input --group "IT" --vault Prod --permissions allow_managing,allow_editing
```


## <a href="#learn-more" class="anchor-link" aria-label="Navigate to header: Learn more"></a><span id="_R_2v9deehkd74t9_" class="cursor-pointer">Learn more</span>

- <a href="/cli/vault-permissions/" class="link">Vault permission dependencies</a>
- <a href="/get-started/manage-organization" class="link">Workflow: Programmatically manage your organization</a>


Was this page helpful?


