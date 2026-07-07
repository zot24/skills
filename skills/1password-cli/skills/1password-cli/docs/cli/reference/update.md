> Source: https://www.1password.dev/cli/reference/update/



Configuration


# Update to the latest version of 1Password CLI


Copy page


Copy page


## 


<a href="#download-the-latest-version" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <span data-as="p">Visit our <a href="https://app-updates.agilebits.com/product_history/CLI2" class="link" target="_blank" rel="noreferrer">release page</a> and download the latest version of 1Password CLI.</span>
- <span data-as="p">Use `op update` to download the latest version from the command line. Set the `--directory` flag to choose where to download the installer (defaults to `~/Downloads`) and confirm the download.</span>


## 


<a href="#update-with-a-package-manager" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <div id="mac">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" data-component-part="tab-button" data-active="true" data-testid="tab-Mac">

  Mac

  </div>

  </div>

- <div id="linux">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-Linux">

  Linux

  </div>

  </div>


``` shiki
brew upgrade --cask 1password-cli
```


Apt


Yum


Alpine


``` shiki
sudo apt update && sudo apt install 1password-cli
```


Was this page helpful?


<a href="/cli/use-multiple-accounts" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Use multiple accounts</span></a><a href="/cli/upgrade" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Upgrade from an earlier version</span></a>


