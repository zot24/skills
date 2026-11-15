> Source: https://www.1password.dev/cli/provision-users/



Manage team members


# Add and remove team members


## <a href="#requirements" class="anchor-link" aria-label="Navigate to header: Requirements"></a><span id="_R_19deehkd74t9_" class="min-w-0 break-words cursor-pointer">Requirements</span>


1.  <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">Sign up for 1Password Business</a>.
2.  <a href="/cli/get-started/#step-1-install-1password-cli" class="link">Install 1Password CLI</a>.


## <a href="#set-up-provisioning" class="anchor-link" aria-label="Navigate to header: Set up provisioning"></a><span id="_R_99deehkd74t9_" class="cursor-pointer">Set up provisioning</span>

### <a href="#with-automated-provisioning" class="anchor-link" aria-label="Navigate to header: With automated provisioning"></a><span id="_R_b9deehkd74t9_" class="cursor-pointer">With automated provisioning</span>


Support for automated provisioning hosted by 1Password is available in <a href="https://app-updates.agilebits.com/product_history/CLI2#beta" class="link" target="_blank" rel="noreferrer">the latest beta build of 1Password CLI</a>, version `2.36.0-beta-02` or later.


``` shiki
op provisioning configure --token <token> --url <url>
```


After you create users with the CLI with automated provisioning enabled, automated provisioning must remain enabled on the account. Users created this way are placed in provisioning-specific states. If automated provisioning is removed from the account, the CLI will return an error when attempting to suspend or reactivate those users.


### <a href="#with-1password-cli" class="anchor-link" aria-label="Navigate to header: With 1Password CLI"></a><span id="_R_n9deehkd74t9_" class="cursor-pointer">With 1Password CLI</span>


## <a href="#manage-who-can-provision-team-members" class="anchor-link" aria-label="Navigate to header: Manage who can provision team members"></a><span id="_R_r9deehkd74t9_" class="cursor-pointer">Manage who can provision team members</span>


``` shiki
op group user grant --group "Provision Managers" --user "wendy.appleseed@agilebits.com"
```


``` shiki
op group user list "Provision Managers"
```


## <a href="#add-team-members" class="anchor-link" aria-label="Navigate to header: Add team members"></a><span id="_R_179deehkd74t9_" class="cursor-pointer">Add team members</span>


``` shiki
op user provision --name "Wendy Appleseed" --email "wendy.appleseed@agilebits.com"
```


## <a href="#confirm-team-members" class="anchor-link" aria-label="Navigate to header: Confirm team members"></a><span id="_R_1h9deehkd74t9_" class="cursor-pointer">Confirm team members</span>


If your account uses automated provisioning, users are confirmed automatically. You can skip this section.


### <a href="#with-op-user-confirm" class="anchor-link" aria-label="Navigate to header: With op user confirm"></a><span id="_R_1n9deehkd74t9_" class="cursor-pointer">With `op user confirm`</span>


``` shiki
op user confirm "wendy.appleseed@agilebits.com"
```


``` shiki
op user confirm --all
```


### <a href="#on-1password-com" class="anchor-link" aria-label="Navigate to header: On 1Password.com"></a><span id="_R_239deehkd74t9_" class="cursor-pointer">On 1Password.com</span>


1.  <a href="https://start.1password.com/signin" class="link" target="_blank" rel="noreferrer">Sign in</a> to your account on 1Password.com.
2.  Select **<a href="https://start.1password.com/people" class="link" target="_blank" rel="noreferrer">People</a>** in the sidebar.
3.  Select the name of any team member with the Pending Provision status.
4.  Select **Confirm** or **Reject**.


## <a href="#remove-team-members" class="anchor-link" aria-label="Navigate to header: Remove team members"></a><span id="_R_2b9deehkd74t9_" class="cursor-pointer">Remove team members</span>


### <a href="#suspend-an-account-temporarily" class="anchor-link" aria-label="Navigate to header: Suspend an account temporarily"></a><span id="_R_2f9deehkd74t9_" class="cursor-pointer">Suspend an account temporarily</span>


If your account uses automated provisioning, the `--deauthorize-devices-after` flag is ignored. The provisioning service always deauthorizes devices after 10 minutes.


``` shiki
op user suspend "wendy.appleseed@agilebits.com --deauthorize-devices-after 10m"
```


### <a href="#remove-an-account-permanently" class="anchor-link" aria-label="Navigate to header: Remove an account permanently"></a><span id="_R_2t9deehkd74t9_" class="cursor-pointer">Remove an account permanently</span>


``` shiki
op user delete "wendy.appleseed@agilebits.com"
```


## <a href="#learn-more" class="anchor-link" aria-label="Navigate to header: Learn more"></a><span id="_R_359deehkd74t9_" class="cursor-pointer">Learn more</span>

- <a href="https://support.1password.com/add-remove-team-members/" class="link" target="_blank" rel="noreferrer">Add and remove team members on 1Password.com</a>
- <a href="https://support.1password.com/provisioning/" class="link" target="_blank" rel="noreferrer">Set up automated provisioning</a>
- <a href="/get-started/manage-organization" class="link">Workflow: Programmatically manage your organization</a>


Was this page helpful?


