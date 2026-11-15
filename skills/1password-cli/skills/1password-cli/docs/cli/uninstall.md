> Source: https://www.1password.dev/cli/uninstall/



Install and sign in


# Uninstall 1Password CLI


## <a href="#step-1-remove-your-1password-account-information" class="anchor-link" aria-label="Navigate to header: Step 1: Remove your 1Password account information"></a><span id="_R_39deehkd74t9_" class="cursor-pointer">Step 1: Remove your 1Password account information</span>


``` shiki
op account forget --all
```


## <a href="#step-2-uninstall-1password-cli" class="anchor-link" aria-label="Navigate to header: Step 2: Uninstall 1Password CLI"></a><span id="_R_d9deehkd74t9_" class="cursor-pointer">Step 2: Uninstall 1Password CLI</span>


- <div id="mac">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Mac">

  Mac

  </div>

  </div>

- <div id="windows">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Windows">

  Windows

  </div>

  </div>

- <div id="linux">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Linux">

  Linux

  </div>

  </div>


- <div id="homebrew">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-homebrew">

  homebrew

  </div>

  </div>

- <div id="manual">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Manual">

  Manual

  </div>

  </div>


``` shiki
brew uninstall 1password-cli
```


``` shiki
rm /usr/local/bin/op
```


- <div id="scoop">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Scoop">

  Scoop

  </div>

  </div>

- <div id="winget">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-winget">

  winget

  </div>

  </div>

- <div id="manual-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Manual">

  Manual

  </div>

  </div>


``` shiki
scoop uninstall 1password-cli
```


``` shiki
winget uninstall 1password-cli
```


1.  Open Powershell **as an administrator**.
2.  Run the following command:


``` shiki
Remove-Item -Recurse -Force "C:\Program Files\1Password CLI"
```


``` shiki
rm /usr/local/bin/op
```


Was this page helpful?


