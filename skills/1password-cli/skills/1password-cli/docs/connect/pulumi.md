> Source: https://www.1password.dev/connect/pulumi/



Infrastructure tools


# Use the 1Password provider for Pulumi


## <a href="#requirements" class="anchor-link" aria-label="Navigate to header: Requirements"></a><span id="_R_39deehkd74t9_" class="min-w-0 break-words cursor-pointer">Requirements</span>


- <div id="service-account">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Service account">

  Service account

  </div>

  </div>

- <div id="connect-server">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Connect server">

  Connect server

  </div>

  </div>

- <div id="account-details">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Account details">

  Account details

  </div>

  </div>


- <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">1Password subscription</a>
- <a href="/cli/get-started" class="link">1Password CLI</a>
- <a href="/service-accounts/get-started" class="link">1Password service account</a>


- <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">1Password subscription</a>
- <a href="/connect/get-started/#step-1" class="link">1Password Connect server</a>


- <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">1Password subscription</a>
- <a href="/cli/get-started" class="link">1Password CLI</a>
- <a href="https://1password.com/downloads/" class="link" target="_blank" rel="noreferrer">1Password desktop app*</a>
- <a href="/cli/get-started#step-2-turn-on-the-1password-desktop-app-integration" class="link">1Password app integration*</a>


## <a href="#step-1-install-the-1password-provider-for-pulumi" class="anchor-link" aria-label="Navigate to header: Step 1: Install the 1Password provider for Pulumi"></a><span id="_R_99deehkd74t9_" class="cursor-pointer">Step 1: Install the 1Password provider for Pulumi</span>

### <a href="#with-a-package-manager" class="anchor-link" aria-label="Navigate to header: With a package manager"></a><span id="_R_b9deehkd74t9_" class="cursor-pointer">With a package manager</span>


- <div id="node-js">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Node.js">

  Node.js

  </div>

  </div>

- <div id="python">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Python">

  Python

  </div>

  </div>

- <div id="go">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Go">

  Go

  </div>

  </div>


npm


yarn


``` shiki
npm install @1password/pulumi-onepassword
```


yarn add @1password/pulumi-onepassword


``` shiki
pip install pulumi_onepassword
```


``` shiki
go get github.com/1Password/pulumi-onepassword/sdk/go/...
```


### <a href="#with-the-provider-binary" class="anchor-link" aria-label="Navigate to header: With the provider binary"></a><span id="_R_f9deehkd74t9_" class="cursor-pointer">With the provider binary</span>


``` shiki
pulumi plugin install resource onepassword <version> --server github://api.github.com/1Password/pulumi-onepassword
```


## <a href="#step-2-configure-the-provider-with-your-credentials" class="anchor-link" aria-label="Navigate to header: Step 2: Configure the provider with your credentials"></a><span id="_R_l9deehkd74t9_" class="cursor-pointer">Step 2: Configure the provider with your credentials</span>


- <div id="service-account-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Service account">

  Service account

  </div>

  </div>

- <div id="connect-server-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Connect server">

  Connect server

  </div>

  </div>

- <div id="account-details-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Account details">

  Account details

  </div>

  </div>


1.  <span data-as="p"><a href="https://start.1password.com/developer-tools/infrastructure-secrets/serviceaccount/" class="link" target="_blank" rel="noreferrer">Create a service account</a> or find the token for an existing service account. Make sure the service account has access to the appropriate vaults and adequate permissions in those vaults.</span>

2.  <span data-as="p">Provide the token to Pulumi using either an environment variable or your Pulumi configuration.</span>

    #### <a href="#environment-variable" class="anchor-link" aria-label="Navigate to header: Environment variable"></a><span id="_R_14cp9deehkd74t9_" class="cursor-pointer">Environment variable</span>

    <div class="code-group p-0.5 mt-5 mb-8 flex flex-col not-prose relative rounded-2xl border border-gray-950/10 dark:border-white/10 min-w-0 bg-gray-50 dark:bg-white/5 dark:codeblock-dark text-gray-950 dark:text-gray-50 codeblock-light" orientation="horizontal" activation-direction="none">

    <div class="flex items-center justify-between gap-2 relative pr-2.5" component-part="code-group-tab-bar">

    <div class="min-w-0 flex-1 w-0 rounded-tl-xl" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px" component-part="scroll-area">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_2lkcp9deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="text-xs leading-6 gap-1 flex" orientation="horizontal" activation-direction="none" role="tablist" aria-label="Code examples">

    <div class="peer/title flex items-center gap-1.5 px-1.5 rounded-lg z-10 group-focus-visible:outline-1 group-focus-visible:outline-primary dark:group-focus-visible:outline-primary-light group-hover:bg-gray-200/50 dark:group-hover:bg-gray-700/70 group-hover:text-primary dark:group-hover:text-primary-light">

    Bash, Zsh, sh

    </div>

    <div class="absolute -bottom-1.5 left-0 right-0 h-0.5 rounded-full bg-primary dark:bg-primary-light peer-empty/title:hidden">

    </div>

    <div class="peer/title flex items-center gap-1.5 px-1.5 rounded-lg z-10 group-focus-visible:outline-1 group-focus-visible:outline-primary dark:group-focus-visible:outline-primary-light group-hover:bg-gray-200/50 dark:group-hover:bg-gray-700/70 group-hover:text-primary dark:group-hover:text-primary-light">

    fish

    </div>

    <div class="peer/title flex items-center gap-1.5 px-1.5 rounded-lg z-10 group-focus-visible:outline-1 group-focus-visible:outline-primary dark:group-focus-visible:outline-primary-light group-hover:bg-gray-200/50 dark:group-hover:bg-gray-700/70 group-hover:text-primary dark:group-hover:text-primary-light">

    PowerShell

    </div>

    </div>

    </div>

    </div>

    </div>

    <div class="flex items-center justify-end shrink-0 gap-1.5">

    <div id="base-ui-_R_uklkcp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_uslkcp9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_v4lkcp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    </div>

    <div class="flex flex-1 overflow-hidden">

    <div id="base-ui-_R_35kcp9deehkd74t9_" class="w-full min-w-full max-w-full h-full max-h-full relative focus-visible:outline-hidden before:content-[''] before:absolute before:inset-0 before:z-10 before:pointer-events-none before:rounded-xt focus-visible:before:outline focus-visible:before:outline-1 focus-visible:before:-outline-offset-2 focus-visible:before:outline-primary dark:focus-visible:before:outline-primary-light data-hidden:hidden [&_[data-component-part=code-block-root]]:rounded-xt!" orientation="horizontal" activation-direction="none" role="tabpanel" tabindex="0" index="-1">

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-xt bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:100%;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light base-ui-disable-scrollbar" data-id="base-ui-_R_r5kcp9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre flex-none text-sm h-full leading-6" component-part="code-group-tab-content">

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

    <div id="base-ui-_R_55kcp9deehkd74t9_" class="w-full min-w-full max-w-full h-full max-h-full relative focus-visible:outline-hidden before:content-[''] before:absolute before:inset-0 before:z-10 before:pointer-events-none before:rounded-xt focus-visible:before:outline focus-visible:before:outline-1 focus-visible:before:-outline-offset-2 focus-visible:before:outline-primary dark:focus-visible:before:outline-primary-light data-hidden:hidden [&_[data-component-part=code-block-root]]:rounded-xt!" data-hidden="" orientation="horizontal" activation-direction="none" hidden="" role="tabpanel" tabindex="0" inert="" index="-1">

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-xt bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:100%;background-color:#FFFFFF;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light base-ui-disable-scrollbar" data-id="base-ui-_R_t5kcp9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre flex-none text-sm h-full leading-6" component-part="code-group-tab-content">

    set -x OP_SERVICE_ACCOUNT_TOKEN=\<your-service-account-token\>

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#FFFFFF;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    <div id="base-ui-_R_75kcp9deehkd74t9_" class="w-full min-w-full max-w-full h-full max-h-full relative focus-visible:outline-hidden before:content-[''] before:absolute before:inset-0 before:z-10 before:pointer-events-none before:rounded-xt focus-visible:before:outline focus-visible:before:outline-1 focus-visible:before:-outline-offset-2 focus-visible:before:outline-primary dark:focus-visible:before:outline-primary-light data-hidden:hidden [&_[data-component-part=code-block-root]]:rounded-xt!" data-hidden="" orientation="horizontal" activation-direction="none" hidden="" role="tabpanel" tabindex="0" inert="" index="-1">

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-xt bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:100%;background-color:#FFFFFF;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light base-ui-disable-scrollbar" data-id="base-ui-_R_v5kcp9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre flex-none text-sm h-full leading-6" component-part="code-group-tab-content">

    \$Env:OP_SERVICE_ACCOUNT_TOKEN=\<your-service-account-token\>

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#FFFFFF;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    </div>

    </div>

    #### <a href="#pulumi-configuration" class="anchor-link" aria-label="Navigate to header: Pulumi configuration"></a><span id="_R_24cp9deehkd74t9_" class="cursor-pointer">Pulumi configuration</span>

    <span data-as="p">Make sure to pass `--secret` when setting sensitive data.</span>

3.  <span data-as="p">Install <a href="/cli/get-started" class="link">1Password CLI</a> in your PATH. If you install the CLI outside of your PATH, specify the path to your 1Password CLI binary using either an environment variable or your Pulumi configuration.</span>

    #### <a href="#environment-variable-2" class="anchor-link" aria-label="Navigate to header: Environment variable"></a><span id="_R_16cp9deehkd74t9_" class="cursor-pointer">Environment variable</span>

    <div class="code-group p-0.5 mt-5 mb-8 flex flex-col not-prose relative rounded-2xl border border-gray-950/10 dark:border-white/10 min-w-0 bg-gray-50 dark:bg-white/5 dark:codeblock-dark text-gray-950 dark:text-gray-50 codeblock-light" orientation="horizontal" activation-direction="none">

    <div class="flex items-center justify-between gap-2 relative pr-2.5" component-part="code-group-tab-bar">

    <div class="min-w-0 flex-1 w-0 rounded-tl-xl" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px" component-part="scroll-area">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_2lmcp9deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="text-xs leading-6 gap-1 flex" orientation="horizontal" activation-direction="none" role="tablist" aria-label="Code examples">

    <div class="peer/title flex items-center gap-1.5 px-1.5 rounded-lg z-10 group-focus-visible:outline-1 group-focus-visible:outline-primary dark:group-focus-visible:outline-primary-light group-hover:bg-gray-200/50 dark:group-hover:bg-gray-700/70 group-hover:text-primary dark:group-hover:text-primary-light">

    Bash, Zsh, sh

    </div>

    <div class="absolute -bottom-1.5 left-0 right-0 h-0.5 rounded-full bg-primary dark:bg-primary-light peer-empty/title:hidden">

    </div>

    <div class="peer/title flex items-center gap-1.5 px-1.5 rounded-lg z-10 group-focus-visible:outline-1 group-focus-visible:outline-primary dark:group-focus-visible:outline-primary-light group-hover:bg-gray-200/50 dark:group-hover:bg-gray-700/70 group-hover:text-primary dark:group-hover:text-primary-light">

    fish

    </div>

    <div class="peer/title flex items-center gap-1.5 px-1.5 rounded-lg z-10 group-focus-visible:outline-1 group-focus-visible:outline-primary dark:group-focus-visible:outline-primary-light group-hover:bg-gray-200/50 dark:group-hover:bg-gray-700/70 group-hover:text-primary dark:group-hover:text-primary-light">

    PowerShell

    </div>

    </div>

    </div>

    </div>

    </div>

    <div class="flex items-center justify-end shrink-0 gap-1.5">

    <div id="base-ui-_R_uklmcp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_uslmcp9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_v4lmcp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    </div>

    <div class="flex flex-1 overflow-hidden">

    <div id="base-ui-_R_35mcp9deehkd74t9_" class="w-full min-w-full max-w-full h-full max-h-full relative focus-visible:outline-hidden before:content-[''] before:absolute before:inset-0 before:z-10 before:pointer-events-none before:rounded-xt focus-visible:before:outline focus-visible:before:outline-1 focus-visible:before:-outline-offset-2 focus-visible:before:outline-primary dark:focus-visible:before:outline-primary-light data-hidden:hidden [&_[data-component-part=code-block-root]]:rounded-xt!" orientation="horizontal" activation-direction="none" role="tabpanel" tabindex="0" index="-1">

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-xt bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:100%;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light base-ui-disable-scrollbar" data-id="base-ui-_R_r5mcp9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre flex-none text-sm h-full leading-6" component-part="code-group-tab-content">

    ``` shiki
    export OP_CLI_PATH=<path-to-your-cli-binary>
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    <div id="base-ui-_R_55mcp9deehkd74t9_" class="w-full min-w-full max-w-full h-full max-h-full relative focus-visible:outline-hidden before:content-[''] before:absolute before:inset-0 before:z-10 before:pointer-events-none before:rounded-xt focus-visible:before:outline focus-visible:before:outline-1 focus-visible:before:-outline-offset-2 focus-visible:before:outline-primary dark:focus-visible:before:outline-primary-light data-hidden:hidden [&_[data-component-part=code-block-root]]:rounded-xt!" data-hidden="" orientation="horizontal" activation-direction="none" hidden="" role="tabpanel" tabindex="0" inert="" index="-1">

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-xt bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:100%;background-color:#FFFFFF;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light base-ui-disable-scrollbar" data-id="base-ui-_R_t5mcp9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre flex-none text-sm h-full leading-6" component-part="code-group-tab-content">

    set -x OP_CLI_PATH=\<path-to-your-cli-binary\>

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#FFFFFF;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    <div id="base-ui-_R_75mcp9deehkd74t9_" class="w-full min-w-full max-w-full h-full max-h-full relative focus-visible:outline-hidden before:content-[''] before:absolute before:inset-0 before:z-10 before:pointer-events-none before:rounded-xt focus-visible:before:outline focus-visible:before:outline-1 focus-visible:before:-outline-offset-2 focus-visible:before:outline-primary dark:focus-visible:before:outline-primary-light data-hidden:hidden [&_[data-component-part=code-block-root]]:rounded-xt!" data-hidden="" orientation="horizontal" activation-direction="none" hidden="" role="tabpanel" tabindex="0" inert="" index="-1">

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-xt bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:100%;background-color:#FFFFFF;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light base-ui-disable-scrollbar" data-id="base-ui-_R_v5mcp9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre flex-none text-sm h-full leading-6" component-part="code-group-tab-content">

    \$Env:OP_CLI_PATH=\<path-to-your-cli-binary\>

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#FFFFFF;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    </div>

    </div>

    #### <a href="#pulumi-configuration-2" class="anchor-link" aria-label="Navigate to header: Pulumi configuration"></a><span id="_R_26cp9deehkd74t9_" class="cursor-pointer">Pulumi configuration</span>


1.  <span data-as="p"><a href="/connect/get-started/#step-1" class="link">Create a Connect server</a> or find the host URL and token for an existing Connect server.</span>

2.  <span data-as="p">Provide the host URL and token to Pulumi using either environment variables or your Pulumi configuration.</span>

    #### <a href="#environment-variables" class="anchor-link" aria-label="Navigate to header: Environment variables"></a><span id="_R_14kp9deehkd74t9_" class="cursor-pointer">Environment variables</span>

    <div class="tabs tabs tab-container">

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

    - <div id="powershell">

      <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-PowerShell">

      PowerShell

      </div>

      </div>

    <div>

    <div id="panel-bash%2C-zsh%2C-sh-0" class="prose dark:prose-invert overflow-x-auto [&_[data-table-wrapper]]:![--page-padding:0px] [&_[role="listitem"]]:pl-4 -ml-4 pl-4 [&>:first-child:not(p)]:mt-0 [&>:first-child:not(p)_img]:mt-0 [&>:first-child[data-table-wrapper]]:pt-0!" role="tabpanel" aria-labelledby="bash%2C-zsh%2C-sh" tabindex="0" component-part="tab-content">

    <span data-as="p">**Host URL**</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_ul9hkkp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_v59hkkp9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_vl9hkkp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_p9hkkp9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    export OP_CONNECT_HOST=<your-connect-server-host-url>
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    <span data-as="p">**Token**</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_ulhhkkp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_v5hhkkp9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_vlhhkkp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_phhkkp9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    export OP_CONNECT_TOKEN=<your-connect-server-token>
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

    <span data-as="p">**Host URL**</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_ulahkkp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_v5ahkkp9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_vlahkkp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_pahkkp9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    set -x OP_CONNECT_HOST=<your-connect-server-host-url>
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    <span data-as="p">**Token**</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_ulihkkp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_v5ihkkp9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_vlihkkp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_pihkkp9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    set -x OP_CONNECT_TOKEN=<your-connect-server-token>
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

    <span data-as="p">**Host URL**</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_ulbhkkp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_v5bhkkp9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_vlbhkkp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_pbhkkp9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    $Env:OP_CONNECT_HOST=<your-connect-server-host-url>
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    <span data-as="p">**Token**</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_uljhkkp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_v5jhkkp9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_vljhkkp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_pjhkkp9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    $Env:OP_CONNECT_TOKEN=<your-connect-server-token>
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

    #### <a href="#pulumi-configuration-3" class="anchor-link" aria-label="Navigate to header: Pulumi configuration"></a><span id="_R_24kp9deehkd74t9_" class="cursor-pointer">Pulumi configuration</span>

    <span data-as="p">**Host URL**</span> <span data-as="p">**Token**</span> <span data-as="p">Make sure to pass `--secret` when setting sensitive data.</span>


1.  <span data-as="p">Find the <a href="https://support.1password.com/1password-glossary/#sign-in-address" class="link" target="_blank" rel="noreferrer">sign-in address</a> or <a href="/cli/reference/#unique-identifiers-ids" class="link">unique identifier</a> for your 1Password account.</span>

2.  <span data-as="p">Provide your account sign-in address or identifier to Pulumi using an environment variable or your Pulumi configuration.</span>

    #### <a href="#environment-variable-3" class="anchor-link" aria-label="Navigate to header: Environment variable"></a><span id="_R_24sp9deehkd74t9_" class="cursor-pointer">Environment variable</span>

    <div class="tabs tabs tab-container">

    - <div id="bash%2C-zsh%2C-sh-2">

      <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Bash, Zsh, sh">

      Bash, Zsh, sh

      </div>

      </div>

    - <div id="fish-2">

      <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-fish">

      fish

      </div>

      </div>

    - <div id="powershell-2">

      <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-PowerShell">

      PowerShell

      </div>

      </div>

    <div>

    <div id="panel-bash%2C-zsh%2C-sh-2-0" class="prose dark:prose-invert overflow-x-auto [&_[data-table-wrapper]]:![--page-padding:0px] [&_[role="listitem"]]:pl-4 -ml-4 pl-4 [&>:first-child:not(p)]:mt-0 [&>:first-child:not(p)_img]:mt-0 [&>:first-child[data-table-wrapper]]:pt-0!" role="tabpanel" aria-labelledby="bash%2C-zsh%2C-sh-2" tabindex="0" component-part="tab-content">

    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_3qlj4sp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_3slj4sp9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_3ulj4sp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_35j4sp9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    export OP_ACCOUNT=<your-account-details>
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    </div>

    <div id="panel-fish-2-1" class="prose dark:prose-invert overflow-x-auto [&_[data-table-wrapper]]:![--page-padding:0px] [&_[role="listitem"]]:pl-4 -ml-4 pl-4 [&>:first-child:not(p)]:mt-0 [&>:first-child:not(p)_img]:mt-0 [&>:first-child[data-table-wrapper]]:pt-0! hidden" role="tabpanel" aria-labelledby="fish-2" tabindex="0" component-part="tab-content">

    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_3qmj4sp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_3smj4sp9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_3umj4sp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_36j4sp9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    set -x OP_ACCOUNT=<your-account-details>
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    </div>

    <div id="panel-powershell-2-2" class="prose dark:prose-invert overflow-x-auto [&_[data-table-wrapper]]:![--page-padding:0px] [&_[role="listitem"]]:pl-4 -ml-4 pl-4 [&>:first-child:not(p)]:mt-0 [&>:first-child:not(p)_img]:mt-0 [&>:first-child[data-table-wrapper]]:pt-0! hidden" role="tabpanel" aria-labelledby="powershell-2" tabindex="0" component-part="tab-content">

    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="powershell">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_3qnj4sp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_3snj4sp9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_3unj4sp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_37j4sp9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    $Env:OP_ACCOUNT=<your-account-details>
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

    #### <a href="#pulumi-configuration-4" class="anchor-link" aria-label="Navigate to header: Pulumi configuration"></a><span id="_R_44sp9deehkd74t9_" class="cursor-pointer">Pulumi configuration</span>

    <span data-as="p">Make sure to pass `--secret` when setting sensitive data.</span>

3.  <span data-as="p">Install <a href="/cli/get-started" class="link">1Password CLI</a> in your PATH. If you install the CLI outside of your PATH, specify the path to your 1Password CLI binary using either an environment variable or your Pulumi configuration.</span>

    #### <a href="#environment-variable-4" class="anchor-link" aria-label="Navigate to header: Environment variable"></a><span id="_R_26sp9deehkd74t9_" class="cursor-pointer">Environment variable</span>

    <div class="tabs tabs tab-container">

    - <div id="bash%2C-zsh%2C-sh-3">

      <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Bash, Zsh, sh">

      Bash, Zsh, sh

      </div>

      </div>

    - <div id="fish-3">

      <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-fish">

      fish

      </div>

      </div>

    - <div id="powershell-3">

      <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-PowerShell">

      PowerShell

      </div>

      </div>

    <div>

    <div id="panel-bash%2C-zsh%2C-sh-3-0" class="prose dark:prose-invert overflow-x-auto [&_[data-table-wrapper]]:![--page-padding:0px] [&_[role="listitem"]]:pl-4 -ml-4 pl-4 [&>:first-child:not(p)]:mt-0 [&>:first-child:not(p)_img]:mt-0 [&>:first-child[data-table-wrapper]]:pt-0!" role="tabpanel" aria-labelledby="bash%2C-zsh%2C-sh-3" tabindex="0" component-part="tab-content">

    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_3qlj6sp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_3slj6sp9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_3ulj6sp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_35j6sp9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    export OP_CLI_PATH=<path-to-your-cli-binary>
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    </div>

    <div id="panel-fish-3-1" class="prose dark:prose-invert overflow-x-auto [&_[data-table-wrapper]]:![--page-padding:0px] [&_[role="listitem"]]:pl-4 -ml-4 pl-4 [&>:first-child:not(p)]:mt-0 [&>:first-child:not(p)_img]:mt-0 [&>:first-child[data-table-wrapper]]:pt-0! hidden" role="tabpanel" aria-labelledby="fish-3" tabindex="0" component-part="tab-content">

    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_3qmj6sp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_3smj6sp9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_3umj6sp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_36j6sp9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    set -x OP_CLI_PATH=<path-to-your-cli-binary>
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    </div>

    <div id="panel-powershell-3-2" class="prose dark:prose-invert overflow-x-auto [&_[data-table-wrapper]]:![--page-padding:0px] [&_[role="listitem"]]:pl-4 -ml-4 pl-4 [&>:first-child:not(p)]:mt-0 [&>:first-child:not(p)_img]:mt-0 [&>:first-child[data-table-wrapper]]:pt-0! hidden" role="tabpanel" aria-labelledby="powershell-3" tabindex="0" component-part="tab-content">

    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="powershell">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_3qnj6sp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_3snj6sp9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_3unj6sp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_37j6sp9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    $Env:OP_CLI_PATH=<path-to-your-cli-binary>
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

    #### <a href="#pulumi-configuration-5" class="anchor-link" aria-label="Navigate to header: Pulumi configuration"></a><span id="_R_46sp9deehkd74t9_" class="cursor-pointer">Pulumi configuration</span>

4.  <span data-as="p">To use Touch ID, Windows Hello, or another system authentication option with the provider, <a href="/cli/get-started#step-2-turn-on-the-1password-desktop-app-integration" class="link">turn on the 1Password CLI app integration</a>.</span>


## <a href="#step-3-use-the-provider" class="anchor-link" aria-label="Navigate to header: Step 3: Use the provider"></a><span id="_R_r9deehkd74t9_" class="cursor-pointer">Step 3: Use the provider</span>


## <a href="#reference" class="anchor-link" aria-label="Navigate to header: Reference"></a><span id="_R_v9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Reference</span>


<table class="m-0 min-w-full w-full max-w-none table [&amp;_th]:text-left [&amp;_td[data-numeric]]:tabular-nums [&amp;_td]:min-w-[150px]">
<colgroup>
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
</colgroup>
<thead>
<tr>
<th>Configuration key</th>
<th>Environment variable</th>
<th>Description</th>
<th>Authentication method</th>
</tr>
</thead>
<tbody>
<tr>
<td><code>pulumi-onepassword:service_account_token</code></td>
<td><code>OP_SERVICE_ACCOUNT_TOKEN</code></td>
<td>The string value of your <a href="/service-accounts/get-started" class="link">1Password Service Account</a> token.</td>
<td>Service account</td>
</tr>
<tr>
<td><code>pulumi-onepassword:url</code></td>
<td><code>OP_CONNECT_HOST</code></td>
<td>The URL where your <a href="/connect/" class="link">1Password Connect Server</a> can be found. For example: <code>http://localhost:8080</code>.</td>
<td>Connect server</td>
</tr>
<tr>
<td><code>pulumi-onepassword:token</code></td>
<td><code>OP_CONNECT_TOKEN</code></td>
<td>The string value of your <a href="/connect/concepts#connect-server-access-token" class="link">Connect server token</a>.</td>
<td>Connect server</td>
</tr>
<tr>
<td><code>pulumi-onepassword:account</code></td>
<td><code>OP_ACCOUNT</code></td>
<td>A 1Password account <a href="https://support.1password.com/1password-glossary/#sign-in-address" class="link" target="_blank" rel="noreferrer">sign-in address</a> or <a href="/cli/reference/#unique-identifiers-ids" class="link">unique identifier</a>.</td>
<td>Account details</td>
</tr>
<tr>
<td><code>pulumi-onepassword:op_cli_path</code></td>
<td><code>OP_CLI_PATH</code></td>
<td>The <a href="/cli/config-directories" class="link">path to your 1Password CLI binary</a>. Only required if 1Password CLI binary is located outside of your PATH.</td>
<td><ul>
<li>Service account</li>
<li>Account details</li>
</ul></td>
</tr>
</tbody>
</table>


Was this page helpful?


