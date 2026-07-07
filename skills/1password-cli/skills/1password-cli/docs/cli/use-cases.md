> Source: https://www.1password.dev/cli/use-cases/



CLI


# Use cases


Copy page


Copy page


## 


<a href="#secrets" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#learn-more" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/cli/secrets-environment-variables" class="link">Load secrets into the environment</a>
- <a href="/environments" class="link">Get started with 1Password Environments</a>
- <a href="/get-started/secure-developer-secrets" class="link">Workflow: Secure your developer secrets</a>


## 


<a href="#automate" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- the vault name
- the number of items in the vault
- the last time the vault’s contents were updated
- the users and groups that have access to the vault along with their permissions


``` shiki
#!/usr/bin/env bash
for vault in $(op vault list --format=json | jq --raw-output '.[] .id')
do
        echo ""
        echo "Vault Details"
        op vault get $vault --format=json | jq -r '.|{name, items, updated_at}'
        sleep 1
        echo ""
        echo "Users"
        op vault user list $vault
        sleep 1
        echo ""
        echo "Groups"
        op vault group list $vault
        sleep 1
        echo ""
        echo "End of Vault Details"
        sleep 2
        clear
        echo ""
        echo ""
done
```


### 


<a href="#learn-more-2" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="https://github.com/1Password/solutions/tree/main/1password/scripted-provisioning/" class="link" target="_blank" rel="noreferrer">Provision new users from a CSV</a>
- <a href="https://github.com/1Password/solutions/tree/main/1password/user-management/" class="link" target="_blank" rel="noreferrer">Audit or manage existing users</a>


- <a href="https://github.com/1Password/solutions/tree/main/1password/account-management/" class="link" target="_blank" rel="noreferrer">Manage your vaults and groups</a>
- <a href="https://github.com/1Password/solutions/tree/main/1password/item-management/" class="link" target="_blank" rel="noreferrer">Create, update, and share items</a>


- <a href="/cli/item-create" class="link">Create items</a>
- <a href="/cli/provision-users" class="link">Add and remove team members</a>
- <a href="/cli/grant-revoke-vault-permissions" class="link">Grant and revoke vault permissions</a>

## 


<a href="#sign-in-to-any-cli-with-your-fingerprint" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#learn-more-3" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/cli/shell-plugins/test" class="link">Test shell plugins</a>
- <a href="/cli/shell-plugins/environments" class="link">Use shell plugins to switch between environments</a>
- <a href="/cli/shell-plugins/multiple-accounts" class="link">Use shell plugins with multiple accounts</a>


Was this page helpful?


<a href="/cli" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Overview</span></a><a href="/cli/get-started" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Get started</span></a>


