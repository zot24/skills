> Source: https://www.1password.dev/cli/reference/management-commands/account/



Management commands


# account


### <a href="#subcommands" class="anchor-link" aria-label="Navigate to header: Subcommands"></a><span id="_R_39deehkd74t9_" class="min-w-0 break-words cursor-pointer">Subcommands</span>

- <a href="#account-add" class="link">account add</a>: Add an account to sign in to for the first time
- <a href="#account-forget" class="link">account forget</a>: Remove a 1Password account from this device
- <a href="#account-get" class="link">account get</a>: Get details about your account
- <a href="#account-list" class="link">account list</a>: List users and accounts set up on this device

## <a href="#account-add" class="anchor-link" aria-label="Navigate to header: account add"></a><span id="_R_79deehkd74t9_" class="cursor-pointer">account add</span>


``` shiki
op account add [flags]
```


### <a href="#flags" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_d9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--address string     The sign-in address for your account.
--email string       The email address associated with your account.
--raw                Only return the session token.
--shorthand string   Set a custom account shorthand for your account.
--signin             Immediately sign in to the added account.
```


- <div id="bash%2C-zsh%2C-sh%2C-fish">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Bash, Zsh, sh, fish">

  Bash, Zsh, sh, fish

  </div>

  </div>

- <div id="powershell">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-PowerShell">

  PowerShell

  </div>

  </div>


``` shiki
eval $(op signin)
```


``` shiki
Invoke-Expression $(op signin)
```


1.  An account specified with the `--account` flag.
2.  An account specified with the `OP_ACCOUNT` environment variable.
3.  The account most recently signed in to with `op signin` in the current terminal window.

### <a href="#examples" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_r9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
op account add --address my.1password.com --email user@example.org
```


- <div id="bash%2C-zsh%2C-sh%2C-fish-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Bash, Zsh, sh, fish">

  Bash, Zsh, sh, fish

  </div>

  </div>

- <div id="powershell-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-PowerShell">

  PowerShell

  </div>

  </div>


``` shiki
eval $(op account add --signin)
```


``` shiki
Invoke-Expression $(op account add --signin)
```


- <div id="bash%2C-zsh%2C-sh%2C-fish-3">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Bash, Zsh, sh, fish">

  Bash, Zsh, sh, fish

  </div>

  </div>

- <div id="powershell-3">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-PowerShell">

  PowerShell

  </div>

  </div>


``` shiki
eval $(op signin --account my)
```


``` shiki
Invoke-Expression $(op signin --account my)
```


## <a href="#account-forget" class="anchor-link" aria-label="Navigate to header: account forget"></a><span id="_R_199deehkd74t9_" class="cursor-pointer">account forget</span>


``` shiki
op account forget [ <account> ] [flags]
```


### <a href="#flags-2" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_1f9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--all    Forget all authenticated accounts.
```


## <a href="#account-get" class="anchor-link" aria-label="Navigate to header: account get"></a><span id="_R_1j9deehkd74t9_" class="cursor-pointer">account get</span>


``` shiki
op account get [flags]
```


## <a href="#account-list" class="anchor-link" aria-label="Navigate to header: account list"></a><span id="_R_1p9deehkd74t9_" class="cursor-pointer">account list</span>


``` shiki
op account list [flags]
```


Was this page helpful?


