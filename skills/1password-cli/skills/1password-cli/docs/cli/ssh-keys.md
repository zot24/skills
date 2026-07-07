> Source: https://www.1password.dev/cli/ssh-keys/



Manage items


# Manage SSH keys


Copy page


Copy page


## 


<a href="#requirements" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">Sign up for 1Password</a>.
- <a href="/cli/get-started#step-1-install-1password-cli" class="link">Install 1Password CLI</a> (`2.20.0` or later).

## 


<a href="#generate-an-ssh-key" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op item create --category ssh --title "My SSH Key"
```


``` shiki
op item create --category ssh --title "RSA SSH Key" --ssh-generate-key RSA,2048
```


## 


<a href="#get-a-private-key" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#learn-more" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/ssh/manage-keys#supported-ssh-key-types" class="link">Supported SSH key types</a>
- <a href="/ssh" class="link">Use 1Password for SSH &amp; Git</a>
- <a href="/ssh/manage-keys" class="link">Manage your SSH keys in the 1Password app</a>
- <a href="/ssh/git-commit-signing" class="link">Sign your Git commits with SSH</a>
- <a href="/get-started/secure-ssh-git-workflows" class="link">Workflow: Secure your SSH &amp; Git workflows</a>


Was this page helpful?


<a href="/cli/item-edit" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Edit items</span></a><a href="/cli/provision-users" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Add and remove team members</span></a>


