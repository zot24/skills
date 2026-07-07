> Source: https://www.1password.dev/service-accounts/use-with-1password-cli/



Service accounts


# Use service accounts with 1Password CLI


Copy page


Copy page


## 


<a href="#requirements" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">Sign up for 1Password.</a>
- Install <a href="/cli/get-started" class="link">1Password CLI</a>.\
- <a href="/service-accounts/get-started#create-a-service-account" class="link">Create a service account.</a>

## 


<a href="#get-started" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  <span data-as="p">Set the `OP_SERVICE_ACCOUNT_TOKEN` environment variable to the service account token:</span>
    <div id="bash%2C-sh%2C-zsh" class="tabs tabs tab-container">

    - <div id="bash%2C-sh%2C-zsh">

      <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" data-component-part="tab-button" data-active="true" data-testid="tab-bash, sh, zsh">

      bash, sh, zsh

      </div>

      </div>

    - <div id="fish">

      <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-fish">

      fish

      </div>

      </div>

    - <div id="powershell">

      <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-Powershell">

      Powershell

      </div>

      </div>

    <div>

    <div id="panel-bash%2C-sh%2C-zsh-0" class="prose dark:prose-invert overflow-x-auto [&_[data-table-wrapper]]:![--page-padding:0px] [&_[role="listitem"]]:pl-4 [&>:first-child:not(p)]:mt-0 [&>:first-child:not(p)_img]:mt-0 [&>:first-child[data-table-wrapper]]:!pt-0" role="tabpanel" aria-labelledby="bash%2C-sh%2C-zsh" data-component-part="tab-content">

    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" data-numberoflines="1" data-language="shellscript">

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
    export OP_SERVICE_ACCOUNT_TOKEN=<your-service-account-token>
    ```

    </div>

    </div>

    <div class="print:hidden" data-fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    </div>

    <div id="panel-fish-1" class="prose dark:prose-invert overflow-x-auto [&_[data-table-wrapper]]:![--page-padding:0px] [&_[role="listitem"]]:pl-4 [&>:first-child:not(p)]:mt-0 [&>:first-child:not(p)_img]:mt-0 [&>:first-child[data-table-wrapper]]:!pt-0 hidden" role="tabpanel" aria-labelledby="fish" data-component-part="tab-content">

    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" data-numberoflines="1" data-language="shellscript">

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
    set -x OP_SERVICE_ACCOUNT_TOKEN <your-service-account-token>
    ```

    </div>

    </div>

    <div class="print:hidden" data-fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    </div>

    <div id="panel-powershell-2" class="prose dark:prose-invert overflow-x-auto [&_[data-table-wrapper]]:![--page-padding:0px] [&_[role="listitem"]]:pl-4 [&>:first-child:not(p)]:mt-0 [&>:first-child:not(p)_img]:mt-0 [&>:first-child[data-table-wrapper]]:!pt-0 hidden" role="tabpanel" aria-labelledby="powershell" data-component-part="tab-content">

    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" data-numberoflines="1" data-language="shellscript">

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
    $Env:OP_SERVICE_ACCOUNT_TOKEN = "<your-service-account-token>"
    ```

    </div>

    </div>

    <div class="print:hidden" data-fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    </div>

    </div>

    </div>
2.  <span data-as="p">Run the following command to make sure the service account is configured:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" data-highlight="[9]" data-numberoflines="13" data-language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" data-floating-buttons="true">

    <div class="z-10 select-none" data-state="closed">

    </div>

    <div class="z-10 select-none" data-state="closed">

    </div>

    <div class="z-10 select-none" data-state="closed">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full py-3.5 px-4 h-full dark:bg-codeblock relative text-sm leading-6 children:!my-0 children:!shadow-none children:!bg-transparent transition-[height] duration-300 ease-in-out code-block-background [&_*]:ring-0 [&_*]:outline-0 [&_*]:focus:ring-0 [&_*]:focus:outline-0 rounded-2xl bg-white overflow-x-auto has-highlighted scrollbar-thin scrollbar-thumb-rounded scrollbar-thumb-black/15 hover:scrollbar-thumb-black/20 active:scrollbar-thumb-black/20 dark:scrollbar-thumb-white/20 dark:hover:scrollbar-thumb-white/25 dark:active:scrollbar-thumb-white/25" data-component-part="code-block-root" tabindex="0" style="font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E">

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


### 


<a href="#supported-commands" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/cli/reference/commands/read" class="link"><code>op read</code></a>
- <a href="/cli/reference/commands/inject" class="link"><code>op inject</code></a>
- <a href="/cli/reference/management-commands/service-account#service-account-ratelimit" class="link"><code>op service-account ratelimit</code></a>


- <a href="/cli/reference/commands/run" class="link"><code>op run</code></a>
- <a href="/cli/reference/management-commands/vault#vault-create" class="link"><code>op vault create</code></a>


- <a href="/cli/reference/management-commands/item" class="link"><code>op item</code></a>


- <a href="/cli/reference/management-commands/document" class="link"><code>op document</code></a>


- <a href="/cli/reference/management-commands/vault#vault-delete" class="link"><code>op vault delete</code></a>
- <a href="/cli/reference/management-commands/vault#vault-group-grant" class="link"><code>op vault group grant</code></a>
- <a href="/cli/reference/management-commands/vault#vault-user-grant" class="link"><code>op vault user grant</code></a>


- <a href="/cli/reference/management-commands/vault#vault-group-revoke" class="link"><code>op vault group revoke</code></a>
- <a href="/cli/reference/management-commands/vault#vault-user-revoke" class="link"><code>op vault user revoke</code></a>


Unsupported commands


- <a href="/cli/reference/management-commands/connect" class="link"><code>op connect</code></a>
- <a href="/cli/reference/management-commands/group" class="link"><code>op group</code></a>
- <a href="/cli/reference/management-commands/user#user-provision" class="link"><code>op user provision</code></a>
- <a href="/cli/reference/management-commands/user#user-confirm" class="link"><code>op user confirm</code></a>
- <a href="/cli/reference/management-commands/user#user-suspend" class="link"><code>op user suspend</code></a>
- <a href="/cli/reference/management-commands/user#user-delete" class="link"><code>op user delete</code></a>
- <a href="/cli/reference/management-commands/user#user-recovery" class="link"><code>op user recovery</code></a>


- <a href="/cli/reference/management-commands/events-api" class="link"><code>op events-api</code></a>
- <a href="/cli/reference/management-commands/vault#vault-edit" class="link"><code>op vault edit</code></a>


- <a href="/cli/reference/management-commands/user#user-get" class="link"><code>op user get</code></a>
- <a href="/cli/reference/management-commands/user#user-list" class="link"><code>op user list</code></a>


- <a href="/cli/reference/management-commands/group#group-get" class="link"><code>op group get</code></a>
- <a href="/cli/reference/management-commands/group#group-list" class="link"><code>op group list</code></a>


### 


<a href="#commands-that-make-multiple-requests" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


<a href="/service-accounts/manage-service-accounts" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Manage</span></a><a href="/service-accounts/setup-tutorial" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Use with 1Password SDKs</span></a>


