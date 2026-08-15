> Source: https://www.1password.dev/cli/reference/



> ## Documentation Index
>
> Fetch the complete documentation index at: <a href="/llms.txt" tabindex="-1">/llms.txt</a>
>
> Use this file to discover all available pages before exploring further.


<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


<a href="/" class="select-none" style="-webkit-touch-callout:none"><span class="sr-only">1Password Developer home page</span><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=29d1c9358888a723dddd8a89a3b6f71d" class="nav-logo w-auto h-7 relative object-contain shrink-0 block dark:hidden" alt="light logo" /><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-light.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=119233092720e49043d6f42ff71125f1" class="nav-logo w-auto h-7 relative object-contain shrink-0 hidden dark:block" alt="dark logo" /></a>


Search...


Reference


1Password CLI reference


<a href="/get-started" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Get Started</a>


<a href="/security-for-ai" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Security for AI</a>


<a href="/environments" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Environments</a>


<a href="/ssh" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SSH &amp; Git</a>


<a href="/cli" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200 [text-shadow:-0.2px_0_0_currentColor,0.2px_0_0_currentColor]" data-active="true" aria-current="location">CLI</a>


<a href="/sdks" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SDKs</a>


More Tools


Reference


# 1Password CLI reference


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

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Bash">

  Bash

  </div>

  </div>

- <div id="zsh">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Zsh">

  Zsh

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


1.  <span data-as="p">Install the bash-completion package</span>
2.  <span data-as="p">Add this line to your `.bashrc` file:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" numberoflines="2" language="text">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_3am933allktbsnlhjiuasnpfiutb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_3cm933allktbsnlhjiuasnpfiutb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_3em933allktbsnlhjiuasnpfiutb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" role="presentation" data-id="base-ui-_R_36933allktbsnlhjiuasnpfiutb_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    source <(op completion bash)
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

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


Related topics

<a href="/cli/secret-references" class="flex items-center gap-2 rounded-lg py-1.5 text-gray-950 dark:text-gray-50 hover:text-primary dark:hover:text-primary-light"><span class="text-sm tracking-[-0.1px] line-clamp-1">Use secret references with 1Password CLI</span></a><a href="/cli" class="flex items-center gap-2 rounded-lg py-1.5 text-gray-950 dark:text-gray-50 hover:text-primary dark:hover:text-primary-light"><span class="text-sm tracking-[-0.1px] line-clamp-1">1Password CLI</span></a><a href="/cli/secret-reference-syntax" class="flex items-center gap-2 rounded-lg py-1.5 text-gray-950 dark:text-gray-50 hover:text-primary dark:hover:text-primary-light"><span class="text-sm tracking-[-0.1px] line-clamp-1">Secret reference syntax</span></a>


Was this page helpful?


Responses are generated using AI and may contain mistakes.


<a href="mailto:support@1password.com" class="group flex justify-between items-center gap-1 mt-2 py-1 transition-colors duration-200" data-component-part="contact-support-button"><span data-component-part="contact-support-icon"></span></a>

Contact support


