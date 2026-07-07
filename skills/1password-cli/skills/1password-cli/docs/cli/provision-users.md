> Source: https://www.1password.dev/cli/provision-users/



Manage team members


# Add and remove team members


Copy page


Copy page


## 


<a href="#requirements" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">Sign up for 1Password Business</a>.
2.  <a href="/cli/get-started#step-1-install-1password-cli" class="link">Install 1Password CLI</a>.


## 


<a href="#set-up-provisioning" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#with-automated-provisioning" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Support for automated provisioning hosted by 1Password is available in <a href="https://app-updates.agilebits.com/product_history/CLI2#beta" class="link" target="_blank" rel="noreferrer">the latest beta build of 1Password CLI</a>, version `2.36.0-beta-02` or later.


``` shiki
op provisioning configure --token <token> --url <url>
```


After you create users with the CLI with automated provisioning enabled, automated provisioning must remain enabled on the account. Users created this way are placed in provisioning-specific states. If automated provisioning is removed from the account, the CLI will return an error when attempting to suspend or reactivate those users.


### 


<a href="#with-1password-cli" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#manage-who-can-provision-team-members" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op group user grant --group "Provision Managers" --user "wendy.appleseed@agilebits.com"
```


``` shiki
op group user list "Provision Managers"
```


## 


<a href="#add-team-members" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op user provision --name "Wendy Appleseed" --email "wendy.appleseed@agilebits.com"
```


## 


<a href="#confirm-team-members" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


If your account uses automated provisioning, users are confirmed automatically. You can skip this section.


### 


<a href="#with-op-user-confirm" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op user confirm "wendy.appleseed@agilebits.com"
```


``` shiki
op user confirm --all
```


### 


<a href="#on-1password-com" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  <a href="https://start.1password.com/signin" class="link" target="_blank" rel="noreferrer">Sign in</a> to your account on 1Password.com.
2.  Select **<a href="https://start.1password.com/people" class="link" target="_blank" rel="noreferrer">People</a>** in the sidebar.
3.  Select the name of any team member with the Pending Provision status.
4.  Select **Confirm** or **Reject**.


## 


<a href="#remove-team-members" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#suspend-an-account-temporarily" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


If your account uses automated provisioning, the `--deauthorize-devices-after` flag is ignored. The provisioning service always deauthorizes devices after 10 minutes.


``` shiki
op user suspend "wendy.appleseed@agilebits.com --deauthorize-devices-after 10m"
```


### 


<a href="#remove-an-account-permanently" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op user delete "wendy.appleseed@agilebits.com"
```


## 


<a href="#learn-more" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="https://support.1password.com/add-remove-team-members/" class="link" target="_blank" rel="noreferrer">Add and remove team members on 1Password.com</a>
- <a href="https://support.1password.com/provisioning/" class="link" target="_blank" rel="noreferrer">Set up automated provisioning</a>
- <a href="/get-started/manage-organization" class="link">Workflow: Programmatically manage your organization</a>
- <a href="/get-started/administrator-quickstart" class="link">Administrator quickstart</a>


Was this page helpful?


<a href="/cli/ssh-keys" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Manage SSH keys</span></a><a href="/cli/grant-revoke-vault-permissions" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Grant and revoke vault permissions</span></a>


