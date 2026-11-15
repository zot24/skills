> Source: https://www.1password.dev/cli/sign-in-manually/



Sign in


# Sign in to your 1Password account manually


## <a href="#sign-in-manually" class="anchor-link" aria-label="Navigate to header: Sign in manually"></a><span id="_R_99deehkd74t9_" class="cursor-pointer">Sign in manually</span>

### <a href="#step-1-add-an-account" class="anchor-link" aria-label="Navigate to header: Step 1: Add an account"></a><span id="_R_b9deehkd74t9_" class="cursor-pointer">Step 1: Add an account</span>


``` shiki
op account add
```


#### <a href="#set-a-custom-account-shorthand" class="anchor-link" aria-label="Navigate to header: Set a custom account shorthand"></a><span id="_R_l9deehkd74t9_" class="cursor-pointer">Set a custom account shorthand</span>


``` shiki
op account add --shorthand personal
```


### <a href="#step-2-sign-in" class="anchor-link" aria-label="Navigate to header: Step 2: Sign in"></a><span id="_R_t9deehkd74t9_" class="cursor-pointer">Step 2: Sign in</span>


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
eval "$(op signin)"
```


``` shiki
Invoke-Expression "$(op signin)"
```


### <a href="#optional-switch-between-accounts-with-the-account-flag" class="anchor-link" aria-label="Navigate to header: Optional: Switch between accounts with the --account flag"></a><span id="_R_1b9deehkd74t9_" class="cursor-pointer">Optional: Switch between accounts with the `--account` flag</span>


- <div id="bash%2C-zsh%2C-sh%2C-fish-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Bash, Zsh, sh, fish">

  Bash, Zsh, sh, fish

  </div>

  </div>


``` shiki
eval "$(op signin --account personal)"
```


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

- <div id="powershell-2">

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
eval "$(op signin --account personal)" && eval "$(op signin --account agilebits)"
```


``` shiki
Invoke-Expression "$(op signin --account personal)"; Invoke-Expression "$(op signin --account agilebits)"
```


``` shiki
op vault list --account personal
```


``` shiki
op vault list --account agilebits
```


## <a href="#troubleshooting" class="anchor-link" aria-label="Navigate to header: Troubleshooting"></a><span id="_R_279deehkd74t9_" class="min-w-0 break-words cursor-pointer">Troubleshooting</span>


## <a href="#learn-more" class="anchor-link" aria-label="Navigate to header: Learn more"></a><span id="_R_2b9deehkd74t9_" class="cursor-pointer">Learn more</span>

- <a href="/cli/app-integration/" class="link">Integrate 1Password CLI with the 1Password desktop app</a>
- <a href="/cli/app-integration-security/" class="link">About the security of the 1Password desktop app integration</a>

## <a href="#appendix-find-an-account-shorthand-or-id" class="anchor-link" aria-label="Navigate to header: Appendix: Find an account shorthand or ID"></a><span id="_R_2f9deehkd74t9_" class="cursor-pointer">Appendix: Find an account shorthand or ID</span>


Was this page helpful?


