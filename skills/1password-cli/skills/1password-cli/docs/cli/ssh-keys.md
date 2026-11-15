> Source: https://www.1password.dev/cli/ssh-keys/



Manage items


# Manage SSH keys


## <a href="#requirements" class="anchor-link" aria-label="Navigate to header: Requirements"></a><span id="_R_19deehkd74t9_" class="min-w-0 break-words cursor-pointer">Requirements</span>


- <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">Sign up for 1Password</a>.
- <a href="/cli/get-started#step-1-install-1password-cli" class="link">Install 1Password CLI</a> (`2.20.0` or later).

## <a href="#generate-an-ssh-key" class="anchor-link" aria-label="Navigate to header: Generate an SSH key"></a><span id="_R_79deehkd74t9_" class="cursor-pointer">Generate an SSH key</span>


``` shiki
op item create --category ssh --title "My SSH Key"
```


``` shiki
op item create --category ssh --title "RSA SSH Key" --ssh-generate-key RSA,2048
```


## <a href="#get-a-private-key" class="anchor-link" aria-label="Navigate to header: Get a private key"></a><span id="_R_l9deehkd74t9_" class="cursor-pointer">Get a private key</span>


## <a href="#learn-more" class="anchor-link" aria-label="Navigate to header: Learn more"></a><span id="_R_r9deehkd74t9_" class="cursor-pointer">Learn more</span>

- <a href="/ssh/manage-keys#supported-ssh-key-types" class="link">Supported SSH key types</a>
- <a href="/ssh/" class="link">Use 1Password for SSH &amp; Git</a>
- <a href="/ssh/manage-keys/" class="link">Manage your SSH keys in the 1Password app</a>
- <a href="/ssh/git-commit-signing/" class="link">Sign your Git commits with SSH</a>
- <a href="/get-started/secure-ssh-git-workflows" class="link">Workflow: Secure your SSH &amp; Git workflows</a>


Was this page helpful?


