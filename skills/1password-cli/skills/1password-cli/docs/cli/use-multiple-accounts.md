> Source: https://www.1password.dev/cli/use-multiple-accounts/



Sign in


# Use multiple 1Password accounts with 1Password CLI


## <a href="#choose-an-account-to-sign-in-to-with-op-signin" class="anchor-link" aria-label="Navigate to header: Choose an account to sign in to with op signin"></a><span id="_R_59deehkd74t9_" class="cursor-pointer">Choose an account to sign in to with `op signin`</span>


## <a href="#specify-an-account-per-command-with-the-account-flag" class="anchor-link" aria-label="Navigate to header: Specify an account per command with the --account flag"></a><span id="_R_d9deehkd74t9_" class="cursor-pointer">Specify an account per command with the `--account` flag</span>


``` shiki
op vault ls --account my.1password.com
```


``` shiki
PASSWORD_1="$(op read --account agilebits-inc.1password.com op://my-vault/some-item/password)"
PASSWORD_2="$(op read --account acme.1password.com op://other-vault/other-item/password)"
```


## <a href="#set-an-account-with-the-op_account-environment-variable" class="anchor-link" aria-label="Navigate to header: Set an account with the OP_ACCOUNT environment variable"></a><span id="_R_p9deehkd74t9_" class="cursor-pointer">Set an account with the `OP_ACCOUNT` environment variable</span>


- <div id="bash%2C-zsh%2C-sh">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Bash, Zsh, sh">

  Bash, Zsh, sh

  </div>

  </div>

- <div id="fish">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-fish">

  fish

  </div>

  </div>

- <div id="powershell">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-PowerShell">

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


## <a href="#find-an-account-sign-in-address-or-id" class="anchor-link" aria-label="Navigate to header: Find an account sign-in address or ID"></a><span id="_R_v9deehkd74t9_" class="cursor-pointer">Find an account sign-in address or ID</span>


``` shiki
op account list
#code-result
$ op account list
URL                            EMAIL                              USER ID
my.1password.com               wendy.c.appleseed@gmail.com        JDFU...
agilebits-inc.1password.com    wendy_appleseed@agilebits.com      ASDU...
```


## <a href="#learn-more" class="anchor-link" aria-label="Navigate to header: Learn more"></a><span id="_R_179deehkd74t9_" class="cursor-pointer">Learn more</span>

- <a href="/cli/app-integration/" class="link">Use the 1Password desktop app to sign in to 1Password CLI</a>


Was this page helpful?


