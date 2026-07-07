> Source: https://www.1password.dev/service-accounts/get-started/



Service accounts


# Get started with 1Password Service Accounts


Copy page


Copy page


- Create, fetch, edit, delete, and share items.
- Read environment variables from <a href="/environments" class="link">1Password Environments</a>.
- Create vaults.
- Delete vaults.\
  .
- Retrieve information about users and groups.


Limitations


- Service accounts have <a href="/service-accounts/rate-limits" class="link">rate limits and request quotes</a>.
- You can’t grant a service account access to your built-in <a href="https://support.1password.com/1password-glossary/#personal-vault" class="link" target="_blank" rel="noreferrer">Personal</a>, <a href="https://support.1password.com/1password-glossary/#private-vault" class="link" target="_blank" rel="noreferrer">Private</a>, or <a href="https://support.1password.com/1password-glossary/#employee-vault" class="link" target="_blank" rel="noreferrer">Employee</a> vault, or your default <a href="https://support.1password.com/1password-glossary/#shared-vault" class="link" target="_blank" rel="noreferrer">Shared</a> vault.
- Service accounts can only be granted read access to Environments.
- Service accounts only work with 1Password CLI version 2.18.0 or later. See <a href="/service-accounts/use-with-1password-cli" class="link">Use service accounts with 1Password CLI</a>.
- You can’t use service accounts with the <a href="/k8s/operator" class="link">Kubernetes Operator</a> (only the <a href="/k8s/injector" class="link">Kubernetes Secrets Injector</a>).


## 


<a href="#requirements" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">Sign up for 1Password.</a>
- Have adequate account permissions to create service accounts.


## New to 1Password developer tools?


## 


<a href="#create-a-service-account" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <div id="1password-com">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" data-component-part="tab-button" data-active="true" data-testid="tab-1Password.com">

  1Password.com

  </div>

  </div>

- <div id="1password-cli">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-1Password CLI">

  1Password CLI

  </div>

  </div>


1.  <a href="https://start.1password.com/signin" class="link" target="_blank" rel="noreferrer">Sign in</a> to your account on 1Password.com.
2.  Open the <a href="https://start.1password.com/developer-tools/infrastructure-secrets/serviceaccount/?source=dev-portal" class="link" target="_blank" rel="noreferrer">service account creation wizard</a>.\
3.  Follow the onscreen instructions:
    1.  Choose a name for the service account.
    2.  Choose whether the service account can create vaults.
    3.  Choose the vaults the service account can access.\
    4.  Select the settings icon next to each vault to choose the permissions the service account has in the vault. This can’t be changed later.
    5.  Choose which <a href="/environments" class="link">1Password Environments</a> the service account can access. This can’t be changed later.
    6.  Select **Create Account** to create the service account.
    7.  Select **Save in 1Password** to save the service account token in your 1Password account. In the next window, enter a name for the item and choose the vault where you want to save it.

    <div class="callout my-4 px-5 py-4 overflow-hidden rounded-2xl flex gap-3 border border-red-200 bg-red-50 dark:border-red-900 dark:bg-red-600/20" data-callout-type="danger">

    <div class="mt-0.5 w-4" data-component-part="callout-icon">

    </div>

    <div class="text-sm prose dark:prose-invert min-w-0 w-full [&_kbd]:bg-background-light dark:[&_kbd]:bg-background-dark [&_code]:!text-current [&_kbd]:!text-current [&_a]:!text-current [&_a]:border-current [&_strong]:!text-current text-red-800 dark:text-red-300" data-component-part="callout-content">

    <span data-as="p">The service account creation wizard only shows the service account token once. **Save the token in 1Password** immediately to avoid losing it. Treat this token like a password, and don’t store it in plaintext.</span>

    </div>

    </div>


1.  <span data-as="p">Make sure you have the latest version of <a href="/cli/get-started" class="link">1Password CLI</a> on your machine.</span>
2.  <span data-as="p">Create a new service account using the <a href="/cli/reference/management-commands/service-account#service-account-create" class="link"><code>op service-account create</code> command</a>:</span>
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
    op service-account create <serviceAccountName> --expires-in <duration> --vault <vault-name:<permission>,<permission>
    ```

    </div>

    </div>

    <div class="print:hidden" data-fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    <span data-as="p">Available permissions: `read_items`, `write_items` (requires `read_items`), `share_items` (requires `read_items`)</span> <span data-as="p">Include the `--can-create-vaults` flag to allow the service account to create new vaults.</span> <span data-as="p">If the service account or vault name contains one or more spaces, enclose the name in quotation marks (for example, “My Service Account”). You don’t need to enclose strings in quotation marks if they don’t contain spaces (for example, myServerName).</span> <span data-as="p">Service accounts can’t be modified after they’re created. If you need to make changes, revoke the service account and create a new one.</span>
3.  <span data-as="p">Save the service account token in your 1Password account.</span>
4.  <span data-as="p">If you want to start using the service account with 1Password CLI, <a href="/service-accounts/use-with-1password-cli#get-started" class="link">export the token to the <code>OP_SERVICE_ACCOUNT_TOKEN</code> environment variable</a>.</span>


``` shiki
op service-account create "My Service Account" --can-create-vaults --expires-in 24h --vault Production:read_items,write_items
```


## 


<a href="#next-steps" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/service-accounts/use-with-1password-cli" class="link">Use a service account with 1Password CLI.</a>
- <a href="/service-accounts/manage-service-accounts" class="link">Manage a service account.</a>
- <a href="/ci-cd" class="link">Integrate a service account with a CI/CD pipeline.</a>
- <a href="/k8s/integrations" class="link">Integrate a service account with Kubernetes.</a>


Was this page helpful?


<a href="/service-accounts" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Overview</span></a><a href="/service-accounts/manage-service-accounts" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Manage</span></a>


