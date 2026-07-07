> Source: https://www.1password.dev/cli/recover-users/



Manage team members


# Recover accounts using 1Password CLI


Copy page


Copy page


- They’ll receive a new Secret Key and create a new 1Password account password.\
- They’ll be able to access all the data they had before.
- They’ll need to sign in again on all their devices once recovery is complete.
- Their two-factor authentication will be reset.

## 


<a href="#requirements" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">Sign up for 1Password</a>.
- <a href="/cli/get-started#step-1-install-1password-cli" class="link">Install 1Password CLI</a> version `2.32.0` or later.


- You’re a team <a href="https://support.1password.com/groups/#administrators" class="link" target="_blank" rel="noreferrer">administrator</a> or <a href="https://support.1password.com/groups/#owners" class="link" target="_blank" rel="noreferrer">owner</a>.
- You belong to a <a href="https://support.1password.com/custom-groups/" class="link" target="_blank" rel="noreferrer">custom group</a> that has the “Recover Accounts” permission.
- You’re a <a href="https://support.1password.com/family-organizer/" class="link" target="_blank" rel="noreferrer">family organizer</a>.

## 


<a href="#begin-recovery" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op user recovery begin { <email> | <name> | <userID> }
```


``` shiki
op user recovery begin ZMAE4RTRONHN7LGELNYYO373KM WHPOFIMMYFFITBVTOTZUR3R324 FGH76DFS89FYCU6342CSDWIFJU
```


## 


<a href="#complete-recovery" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#learn-more" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/cli/provision-users" class="link">Add and remove team members</a>
- <a href="/cli/grant-revoke-vault-permissions" class="link">Grant and revoke vault permissions</a>
- <a href="https://support.1password.com/after-recovery/" class="link" target="_blank" rel="noreferrer">Sign back in to 1Password after your account has been recovered</a>
- <a href="/get-started/manage-organization" class="link">Workflow: Programmatically manage your organization</a>
- <a href="/get-started/administrator-quickstart" class="link">Administrator quickstart</a>


Was this page helpful?


<a href="/cli/grant-revoke-vault-permissions" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Grant and revoke vault permissions</span></a><a href="/cli/reference" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Overview</span></a>


