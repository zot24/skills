> Source: https://www.1password.dev/service-accounts/use-with-1password-cli/



Service Accounts


# Use service accounts with 1Password CLI


## <a href="#requirements" class="anchor-link" aria-label="Navigate to header: Requirements"></a><span id="_R_39deehkd74t9_" class="min-w-0 break-words cursor-pointer">Requirements</span>


- <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">Sign up for 1Password.</a>
- Install <a href="/cli/get-started/" class="link">1Password CLI</a>.  
  <span class="small">Service Accounts require 1Password CLI version 2.18.0 or later.</span>
- <a href="/service-accounts/get-started/#create-a-service-account" class="link">Create a service account.</a>

## <a href="#get-started" class="anchor-link" aria-label="Navigate to header: Get started"></a><span id="_R_99deehkd74t9_" class="cursor-pointer">Get started</span>


1.  <span data-as="p">Set the `OP_SERVICE_ACCOUNT_TOKEN` environment variable to the service account token:</span>
    <div class="tabs tabs tab-container">

    - <div id="bash%2C-sh%2C-zsh">

      <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-bash, sh, zsh">

      bash, sh, zsh

      </div>

      </div>

    - <div id="fish">

      <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-fish">

      fish

      </div>

      </div>

    - <div id="powershell">

      <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Powershell">

      Powershell

      </div>

      </div>

    <div>

    <div id="panel-bash%2C-sh%2C-zsh-0" class="prose dark:prose-invert overflow-x-auto [&_[data-table-wrapper]]:![--page-padding:0px] [&_[role="listitem"]]:pl-4 -ml-4 pl-4 [&>:first-child:not(p)]:mt-0 [&>:first-child:not(p)_img]:mt-0 [&>:first-child[data-table-wrapper]]:pt-0!" role="tabpanel" aria-labelledby="bash%2C-sh%2C-zsh" tabindex="0" component-part="tab-content">

    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_1taq4d9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_1uaq4d9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_1vaq4d9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_1iq4d9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    export OP_SERVICE_ACCOUNT_TOKEN=<your-service-account-token>
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    </div>

    <div id="panel-fish-1" class="prose dark:prose-invert overflow-x-auto [&_[data-table-wrapper]]:![--page-padding:0px] [&_[role="listitem"]]:pl-4 -ml-4 pl-4 [&>:first-child:not(p)]:mt-0 [&>:first-child:not(p)_img]:mt-0 [&>:first-child[data-table-wrapper]]:pt-0! hidden" role="tabpanel" aria-labelledby="fish" tabindex="0" component-part="tab-content">

    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_1tba4d9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_1uba4d9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_1vba4d9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_1ja4d9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    set -x OP_SERVICE_ACCOUNT_TOKEN <your-service-account-token>
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    </div>

    <div id="panel-powershell-2" class="prose dark:prose-invert overflow-x-auto [&_[data-table-wrapper]]:![--page-padding:0px] [&_[role="listitem"]]:pl-4 -ml-4 pl-4 [&>:first-child:not(p)]:mt-0 [&>:first-child:not(p)_img]:mt-0 [&>:first-child[data-table-wrapper]]:pt-0! hidden" role="tabpanel" aria-labelledby="powershell" tabindex="0" component-part="tab-content">

    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_1tbq4d9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_1ubq4d9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_1vbq4d9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_1jq4d9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    $Env:OP_SERVICE_ACCOUNT_TOKEN = "<your-service-account-token>"
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    </div>

    </div>

    </div>
2.  <span data-as="p">Run the following command to make sure the service account is configured:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" highlight="[9]" numberoflines="13" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_3qm8d9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_3sm8d9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_3um8d9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white has-highlighted" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_368d9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op user get --me

    # code-result

    ID:                     <service-account-id>
    Name:                   <service-account-name>
    Email:                  <service-account-email>
    State:                  ACTIVE
    Type:                   SERVICE_ACCOUNT
    Created:                2 minutes ago
    Updated:                2 minutes ago
    Last Authentication:    now
    ```

    </div>

    </div>

    </div>

    </div>

    </div>


### <a href="#supported-commands" class="anchor-link" aria-label="Navigate to header: Supported commands"></a><span id="_R_h9deehkd74t9_" class="cursor-pointer">Supported commands</span>


- <a href="/cli/reference/commands/read/" class="link"><code>op read</code></a>
- <a href="/cli/reference/commands/inject/" class="link"><code>op inject</code></a>
- <a href="/cli/reference/management-commands/service-account/#service-account-ratelimit" class="link"><code>op service-account ratelimit</code></a>


- <a href="/cli/reference/commands/run/" class="link"><code>op run</code></a>
- <a href="/cli/reference/management-commands/vault/#vault-create" class="link"><code>op vault create</code></a>


- <a href="/cli/reference/management-commands/item/" class="link"><code>op item</code></a>


- <a href="/cli/reference/management-commands/document/" class="link"><code>op document</code></a>


- <a href="/cli/reference/management-commands/vault/#vault-delete" class="link"><code>op vault delete</code></a>
- <a href="/cli/reference/management-commands/vault/#vault-group-grant" class="link"><code>op vault group grant</code></a>
- <a href="/cli/reference/management-commands/vault/#vault-user-grant" class="link"><code>op vault user grant</code></a>


- <a href="/cli/reference/management-commands/vault/#vault-group-revoke" class="link"><code>op vault group revoke</code></a>
- <a href="/cli/reference/management-commands/vault/#vault-user-revoke" class="link"><code>op vault user revoke</code></a>


Unsupported commands


- <a href="/cli/reference/management-commands/connect" class="link"><code>op connect</code></a>
- <a href="/cli/reference/management-commands/group/" class="link"><code>op group</code></a>
- <a href="/cli/reference/management-commands/user/#user-provision" class="link"><code>op user provision</code></a>
- <a href="/cli/reference/management-commands/user/#user-confirm" class="link"><code>op user confirm</code></a>
- <a href="/cli/reference/management-commands/user/#user-suspend" class="link"><code>op user suspend</code></a>
- <a href="/cli/reference/management-commands/user/#user-delete" class="link"><code>op user delete</code></a>
- <a href="/cli/reference/management-commands/user/#user-recovery" class="link"><code>op user recovery</code></a>


- <a href="/cli/reference/management-commands/events-api/" class="link"><code>op events-api</code></a>
- <a href="/cli/reference/management-commands/vault/#vault-edit" class="link"><code>op vault edit</code></a>


- <a href="/cli/reference/management-commands/user/#user-get" class="link"><code>op user get</code></a>
- <a href="/cli/reference/management-commands/user/#user-list" class="link"><code>op user list</code></a>


- <a href="/cli/reference/management-commands/group/#group-get" class="link"><code>op group get</code></a>
- <a href="/cli/reference/management-commands/group/#group-list" class="link"><code>op group list</code></a>


### <a href="#commands-that-make-multiple-requests" class="anchor-link" aria-label="Navigate to header: Commands that make multiple requests"></a><span id="_R_119deehkd74t9_" class="cursor-pointer">Commands that make multiple requests</span>


| Command | Total requests | Notes |
|----|----|----|
| `op item list` | 1 + 1 per vault the service account has access to | To limit total requests to 3, list items in a specific vault using the `--vault` flag. Pass the vault’s ID to further limit requests to 2. |
| `op item get` | 3 reads | To reduce to 1 request, pass the item and vault IDs. |
| `op item create` | 1 read and 1 write | To reduce to 1 request, pass the vault ID. |
| `op item delete` | 5 reads and 1 write | To reduce the read requests by 1, pass the vault ID. |
| `op item edit` | 5 reads and 1 write | To reduce the read requests by 1, pass the vault ID. |
| `op read` | 3 reads | To reduce to 1 request, pass the item and vault IDs. |
| `op vault delete` | 2 reads + 1 write | To reduce the read requests by 1, pass the vault ID. |
| `op vault edit` | up to 3 writes | The number of requests may vary depending on how many changes are made with a single command. |
| `op vault get` | 2 reads | To reduce the read requests by 1, pass the vault ID. |


Was this page helpful?


