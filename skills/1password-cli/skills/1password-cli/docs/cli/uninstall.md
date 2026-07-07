> Source: https://www.1password.dev/cli/uninstall/



Configuration


# Uninstall 1Password CLI


Copy page


Copy page


## 


<a href="#step-1-remove-your-1password-account-information" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op account forget --all
```


## 


<a href="#step-2-uninstall-1password-cli" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <div id="mac">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" data-component-part="tab-button" data-active="true" data-testid="tab-Mac">

  Mac

  </div>

  </div>

- <div id="windows">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-Windows">

  Windows

  </div>

  </div>

- <div id="linux">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-Linux">

  Linux

  </div>

  </div>


- <div id="homebrew">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" data-component-part="tab-button" data-active="true" data-testid="tab-homebrew">

  homebrew

  </div>

  </div>

- <div id="manual">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-Manual">

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

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" data-component-part="tab-button" data-active="true" data-testid="tab-Scoop">

  Scoop

  </div>

  </div>

- <div id="winget">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-winget">

  winget

  </div>

  </div>

- <div id="manual-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-Manual">

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


<a href="/cli/upgrade" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Upgrade from an earlier version</span></a><a href="/cli/scripts" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Example scripts</span></a>


