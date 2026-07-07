> Source: https://www.1password.dev/cli/reference/



Reference


# 1Password CLI reference


Copy page


Copy page


## 


<a href="#command-structure" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op [command] <flags>
```


``` shiki
op item list --vault Private
```


``` shiki
op --help
```


## 


<a href="#command-reference" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/cli/reference/management-commands/account" class="link">account</a>: Manage your locally configured 1Password accounts
- <a href="/cli/reference/commands/completion" class="link">completion</a>: Generate shell completion information
- <a href="/cli/reference/management-commands/connect" class="link">connect</a>: Manage Connect server instances and tokens in your 1Password account
- <a href="/cli/reference/management-commands/document" class="link">document</a>: Perform CRUD operations on Document items in your vaults
- <a href="/cli/reference/management-commands/environment" class="link">environment</a>: Manage your 1Password Environments and their variables (Beta)
- <a href="/cli/reference/management-commands/events-api" class="link">events-api</a>: Manage Events API integrations in your 1Password account
- <a href="/cli/reference/management-commands/group" class="link">group</a>: Manage the groups in your 1Password account
- <a href="/cli/reference/commands/inject" class="link">inject</a>: Inject secrets into a config file
- <a href="/cli/reference/management-commands/item" class="link">item</a>: Perform CRUD operations on the 1Password items in your vaults
- <a href="/cli/reference/management-commands/plugin" class="link">plugin</a>: Manage the shell plugins you use to authenticate third-party CLIs
- <a href="/cli/reference/commands/read" class="link">read</a>: Read a secret reference
- <a href="/cli/reference/commands/run" class="link">run</a>: Pass secrets as environment variables to a process
- <a href="/cli/reference/management-commands/service-account" class="link">service-account</a>: Manage service accounts
- <a href="/cli/reference/commands/signin" class="link">signin</a>: Sign in to a 1Password account
- <a href="/cli/reference/commands/signout" class="link">signout</a>: Sign out of a 1Password account
- <a href="/cli/reference/commands/update" class="link">update</a>: Check for and download updates
- <a href="/cli/reference/management-commands/user" class="link">user</a>: Manage users within this 1Password account
- <a href="/cli/reference/management-commands/vault" class="link">vault</a>: Manage permissions and perform CRUD operations on your 1Password vaults
- <a href="/cli/reference/commands/whoami" class="link">whoami</a>: Get information about a signed-in account

## 


<a href="#global-flags" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
      --account string     Select the account to execute the command by account shorthand, sign-in address, account ID, or user ID. For a list of available accounts, run 'op account list'. Can be set as the OP_ACCOUNT environment variable.
      --cache              Store and use cached information. Caching is enabled by default on UNIX-like systems. Caching is not available on Windows. Options: true, false. Can also be set with the OP_CACHE environment variable. (default true)
      --config directory   Use this configuration directory.
      --debug              Enable debug mode. Can also be enabled by setting the OP_DEBUG environment variable to true.
      --encoding type      Use this character encoding type. Default: UTF-8. Supported: SHIFT_JIS, gbk.
      --format string      Use this output format. Can be 'human-readable' or 'json'. Can be set as the OP_FORMAT environment variable. (default "human-readable")
  -h, --help               Get help for op.
      --iso-timestamps     Format timestamps according to ISO 8601 / RFC 3339. Can be set as the OP_ISO_TIMESTAMPS environment variable.
      --no-color           Print output without color.
      --session token      Authenticate with this session token. 1Password CLI outputs session tokens for successful `op signin` commands when 1Password app integration is not enabled.
```


## 


<a href="#unique-identifiers-ids" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#shell-completion" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <div id="bash">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" data-component-part="tab-button" data-active="true" data-testid="tab-Bash">

  Bash

  </div>

  </div>

- <div id="zsh">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-Zsh">

  Zsh

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


1.  <span data-as="p">Install the bash-completion package</span>
2.  <span data-as="p">Add this line to your `.bashrc` file:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" data-numberoflines="2" data-language="text">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" data-floating-buttons="true">

    <div class="z-10 select-none" data-state="closed">

    </div>

    <div class="z-10 select-none" data-state="closed">

    </div>

    <div class="z-10 select-none" data-state="closed">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full py-3.5 px-4 h-full dark:bg-codeblock relative text-sm leading-6 children:!my-0 children:!shadow-none children:!bg-transparent transition-[height] duration-300 ease-in-out code-block-background [&_*]:ring-0 [&_*]:outline-0 [&_*]:focus:ring-0 [&_*]:focus:outline-0 rounded-2xl bg-white overflow-x-auto scrollbar-thin scrollbar-thumb-rounded scrollbar-thumb-black/15 hover:scrollbar-thumb-black/20 active:scrollbar-thumb-black/20 dark:scrollbar-thumb-white/20 dark:hover:scrollbar-thumb-white/25 dark:active:scrollbar-thumb-white/25" data-component-part="code-block-root" tabindex="0" style="font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    source <(op completion bash)
    ```

    </div>

    </div>

    <div class="print:hidden" data-fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>


``` shiki
eval "$(op completion zsh)"; compdef _op op
```


``` shiki
op completion fish | source
```


``` shiki
op completion powershell | Out-String | Invoke-Expression
```


``` shiki
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
```


## 


<a href="#cache-item-and-vault-information" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#alternative-character-encoding" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- `gbk`
- `shift-jis`

## 


<a href="#parse-json-output-with-jq" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#beta-builds" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#example-commands" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#items" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op item get <item name>
```


### 


<a href="#users-and-groups" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#vaults" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op vault create Test
```


### 


<a href="#secrets" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op://vault-name/item-name/[section-name/]field-name
```


## 


<a href="#get-help" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op <command> [subcommand] --help
```


Was this page helpful?


<a href="/cli/recover-users" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Recover accounts</span></a><a href="/cli/best-practices" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Best practices</span></a>


