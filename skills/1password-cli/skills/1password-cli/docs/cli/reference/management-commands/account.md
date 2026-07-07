> Source: https://www.1password.dev/cli/reference/management-commands/account/



Management commands


# account


Copy page


Copy page


### 


<a href="#subcommands" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="#account-add" class="link">account add</a>: Add an account to sign in to for the first time
- <a href="#account-forget" class="link">account forget</a>: Remove a 1Password account from this device
- <a href="#account-get" class="link">account get</a>: Get details about your account
- <a href="#account-list" class="link">account list</a>: List users and accounts set up on this device

## 


<a href="#account-add" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op account add [flags]
```


### 


<a href="#flags" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--address string     The sign-in address for your account.
--email string       The email address associated with your account.
--raw                Only return the session token.
--shorthand string   Set a custom account shorthand for your account.
--signin             Immediately sign in to the added account.
```


- <div id="bash%2C-zsh%2C-sh%2C-fish">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" data-component-part="tab-button" data-active="true" data-testid="tab-Bash, Zsh, sh, fish">

  Bash, Zsh, sh, fish

  </div>

  </div>

- <div id="powershell">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-PowerShell">

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

### 


<a href="#examples" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op account add --address my.1password.com --email user@example.org
```


- <div id="bash%2C-zsh%2C-sh%2C-fish-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" data-component-part="tab-button" data-active="true" data-testid="tab-Bash, Zsh, sh, fish">

  Bash, Zsh, sh, fish

  </div>

  </div>

- <div id="powershell-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-PowerShell">

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

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" data-component-part="tab-button" data-active="true" data-testid="tab-Bash, Zsh, sh, fish">

  Bash, Zsh, sh, fish

  </div>

  </div>

- <div id="powershell-3">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-PowerShell">

  PowerShell

  </div>

  </div>


``` shiki
eval $(op signin --account my)
```


``` shiki
Invoke-Expression $(op signin --account my)
```


## 


<a href="#account-forget" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op account forget [ <account> ] [flags]
```


### 


<a href="#flags-2" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--all    Forget all authenticated accounts.
```


## 


<a href="#account-get" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op account get [flags]
```


## 


<a href="#account-list" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op account list [flags]
```


Was this page helpful?


<a href="/cli/best-practices" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Best practices</span></a><a href="/cli/reference/management-commands/connect" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">connect</span></a>


