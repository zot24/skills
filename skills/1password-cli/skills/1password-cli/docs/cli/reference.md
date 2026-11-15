> Source: https://www.1password.dev/cli/reference/



Reference


# 1Password CLI reference


## <a href="#command-structure" class="anchor-link" aria-label="Navigate to header: Command structure"></a><span id="_R_39deehkd74t9_" class="cursor-pointer">Command structure</span>


``` shiki
op [command] <flags>
```


``` shiki
op item list --vault Private
```


``` shiki
op --help
```


## <a href="#command-reference" class="anchor-link" aria-label="Navigate to header: Command reference"></a><span id="_R_j9deehkd74t9_" class="cursor-pointer">Command reference</span>

- <a href="/cli/reference/management-commands/account" class="link">account</a>: Manage your locally configured 1Password accounts
- <a href="/cli/reference/commands/completion" class="link">completion</a>: Generate shell completion information
- <a href="/cli/reference/management-commands/connect" class="link">connect</a>: Manage Connect server instances and tokens in your 1Password account
- <a href="/cli/reference/management-commands/document" class="link">document</a>: Perform CRUD operations on Document items in your vaults
- <a href="/cli/reference/management-commands/environment" class="link">environment</a>: Manage your 1Password Environments and their secrets
- <a href="/cli/reference/management-commands/events-api" class="link">events-api</a>: Manage Events API integrations in your 1Password account
- <a href="/cli/reference/management-commands/group" class="link">group</a>: Manage the groups in your 1Password account
- <a href="/cli/reference/commands/inject" class="link">inject</a>: Inject secrets into a config file
- <a href="/cli/reference/management-commands/item" class="link">item</a>: Perform CRUD operations on the 1Password items in your vaults
- <a href="/cli/reference/management-commands/plugin" class="link">plugin</a>: Manage the shell plugins you use to authenticate third-party CLIs
- <a href="/cli/reference/management-commands/provisioning" class="link">provisioning</a>: Manage provisioning integration settings
- <a href="/cli/reference/commands/read" class="link">read</a>: Read a secret reference
- <a href="/cli/reference/commands/run" class="link">run</a>: Pass secrets as environment variables to a process
- <a href="/cli/reference/management-commands/service-account" class="link">service-account</a>: Manage service accounts
- <a href="/cli/reference/commands/signin" class="link">signin</a>: Sign in to a 1Password account
- <a href="/cli/reference/commands/signout" class="link">signout</a>: Sign out of a 1Password account
- <a href="/cli/reference/commands/update" class="link">update</a>: Check for and download updates
- <a href="/cli/reference/management-commands/user" class="link">user</a>: Manage users within this 1Password account
- <a href="/cli/reference/management-commands/vault" class="link">vault</a>: Manage permissions and perform CRUD operations on your 1Password vaults
- <a href="/cli/reference/commands/whoami" class="link">whoami</a>: Get information about a signed-in account

## <a href="#global-flags" class="anchor-link" aria-label="Navigate to header: Global flags"></a><span id="_R_n9deehkd74t9_" class="cursor-pointer">Global flags</span>


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


## <a href="#unique-identifiers-ids" class="anchor-link" aria-label="Navigate to header: Unique identifiers (IDs)"></a><span id="_R_r9deehkd74t9_" class="cursor-pointer">Unique identifiers (IDs)</span>


## <a href="#shell-completion" class="anchor-link" aria-label="Navigate to header: Shell completion"></a><span id="_R_1f9deehkd74t9_" class="cursor-pointer">Shell completion</span>


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
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="2" language="text">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_1tb4hhl9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_1ub4hhl9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_1vb4hhl9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_1j4hhl9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    source <(op completion bash)
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

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


## <a href="#cache-item-and-vault-information" class="anchor-link" aria-label="Navigate to header: Cache item and vault information"></a><span id="_R_1n9deehkd74t9_" class="cursor-pointer">Cache item and vault information</span>


## <a href="#alternative-character-encoding" class="anchor-link" aria-label="Navigate to header: Alternative character encoding"></a><span id="_R_239deehkd74t9_" class="cursor-pointer">Alternative character encoding</span>


- `gbk`
- `shift-jis`

## <a href="#parse-json-output-with-jq" class="anchor-link" aria-label="Navigate to header: Parse JSON output with jq"></a><span id="_R_2b9deehkd74t9_" class="cursor-pointer">Parse JSON output with jq</span>


## <a href="#beta-builds" class="anchor-link" aria-label="Navigate to header: Beta builds"></a><span id="_R_2l9deehkd74t9_" class="cursor-pointer">Beta builds</span>


## <a href="#example-commands" class="anchor-link" aria-label="Navigate to header: Example commands"></a><span id="_R_2p9deehkd74t9_" class="cursor-pointer">Example commands</span>

### <a href="#items" class="anchor-link" aria-label="Navigate to header: Items"></a><span id="_R_2r9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Items</span>


``` shiki
op item get <item name>
```


### <a href="#users-and-groups" class="anchor-link" aria-label="Navigate to header: Users and groups"></a><span id="_R_3d9deehkd74t9_" class="cursor-pointer">Users and groups</span>


### <a href="#vaults" class="anchor-link" aria-label="Navigate to header: Vaults"></a><span id="_R_3p9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Vaults</span>


``` shiki
op vault create Test
```


### <a href="#secrets" class="anchor-link" aria-label="Navigate to header: Secrets"></a><span id="_R_499deehkd74t9_" class="min-w-0 break-words cursor-pointer">Secrets</span>


``` shiki
op://vault-name/item-name/[section-name/]field-name
```


## <a href="#get-help" class="anchor-link" aria-label="Navigate to header: Get help"></a><span id="_R_4n9deehkd74t9_" class="cursor-pointer">Get help</span>


``` shiki
op <command> [subcommand] --help
```


Was this page helpful?


