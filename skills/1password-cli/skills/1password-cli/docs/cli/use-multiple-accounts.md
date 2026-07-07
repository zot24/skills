> Source: https://www.1password.dev/cli/use-multiple-accounts/



Sign in


# Use multiple 1Password accounts with 1Password CLI


Copy page


Copy page


## 


<a href="#choose-an-account-to-sign-in-to-with-op-signin" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#specify-an-account-per-command-with-the-account-flag" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op vault ls --account my.1password.com
```


``` shiki
PASSWORD_1="$(op read --account agilebits-inc.1password.com op://my-vault/some-item/password)"
PASSWORD_2="$(op read --account acme.1password.com op://other-vault/other-item/password)"
```


## 


<a href="#set-an-account-with-the-op_account-environment-variable" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <div id="bash%2C-zsh%2C-sh">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" data-component-part="tab-button" data-active="true" data-testid="tab-Bash, Zsh, sh">

  Bash, Zsh, sh

  </div>

  </div>

- <div id="fish">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-fish">

  fish

  </div>

  </div>

- <div id="powershell">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-PowerShell">

  PowerShell

  </div>

  </div>


``` shiki
export OP_ACCOUNT=my.1password.com
```


``` shiki
set -x OP_ACCOUNT my.1password.com
```


``` shiki
$Env:OP_ACCOUNT = "my.1password.com"
```


## 


<a href="#find-an-account-sign-in-address-or-id" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op account list
#code-result
$ op account list
URL                            EMAIL                              USER ID
my.1password.com               wendy.c.appleseed@gmail.com        JDFU...
agilebits-inc.1password.com    wendy_appleseed@agilebits.com      ASDU...
```


## 


<a href="#learn-more" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/cli/app-integration" class="link">Use the 1Password desktop app to sign in to 1Password CLI</a>
- <a href="/get-started/developer-quickstart" class="link">Developer quickstart</a>


Was this page helpful?


<a href="/cli/sign-in-sso-azure" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Sign in with Microsoft</span></a><a href="/cli/reference/update" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Check for updates</span></a>


