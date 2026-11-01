> Source: https://www.1password.dev/connect/pulumi/


> ## Documentation Index
>
> Fetch the complete documentation index at: <a href="/llms.txt" tabindex="-1">/llms.txt</a>
>
> Use this file to discover all available pages before exploring further.


<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


Responses are generated using AI and may contain mistakes.


<a href="mailto:support@1password.com" class="group flex justify-between items-center gap-1 mt-2 py-1 transition-colors duration-200" data-component-part="contact-support-button"><span data-component-part="contact-support-icon"></span></a>

Contact support


<a href="/" class="select-none" style="-webkit-touch-callout:none"><span class="sr-only">1Password Developer home page</span><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=29d1c9358888a723dddd8a89a3b6f71d" class="nav-logo w-auto h-7 relative object-contain shrink-0 block dark:hidden" alt="light logo" /><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-light.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=119233092720e49043d6f42ff71125f1" class="nav-logo w-auto h-7 relative object-contain shrink-0 hidden dark:block" alt="dark logo" /></a>


Search...


Integrations


Use the 1Password provider for Pulumi with Connect


<a href="/get-started" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Get Started</a>


<a href="/tutorials" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Tutorials</a>


<a href="/security-for-ai" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Security for AI</a>


<a href="/environments" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Environments</a>


<a href="/ssh" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SSH &amp; Git</a>


<a href="/cli" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">CLI</a>


<a href="/sdks" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SDKs</a>


More Tools


Integrations


# Use the 1Password provider for Pulumi with Connect


## 


<a href="#requirements" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


## 


<a href="#step-1-install-the-1password-provider-for-pulumi" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#with-a-package-manager" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


### 


<a href="#with-the-provider-binary" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
pulumi plugin install resource onepassword <version> --server github://api.github.com/1Password/pulumi-onepassword
```


## 


<a href="#step-2-configure-the-provider-with-your-credentials" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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

    #### 

    <div class="absolute" tabindex="-1">

    <a href="#environment-variable" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>
    <div class="size-6 rounded-md flex items-center justify-center shadow-xs text-gray-400 dark:text-white/50 dark:bg-background-dark dark:brightness-[1.35] dark:ring-1 dark:hover:brightness-150 bg-white ring-1 ring-gray-400/30 dark:ring-gray-700/25 hover:ring-gray-400/60 dark:hover:ring-white/20 group-focus/link:border-2 group-focus/link:border-primary dark:group-focus/link:border-primary-light">

    </div>

    </div>

    <span class="cursor-pointer">Environment variable</span>

    <div class="code-group p-0.5 mt-5 mb-8 flex flex-col not-prose relative rounded-2xl border border-gray-950/10 dark:border-white/10 min-w-0 bg-gray-50 dark:bg-white/5 dark:codeblock-dark text-gray-950 dark:text-gray-50 codeblock-light" orientation="horizontal" activation-direction="none">

    <div class="flex items-center justify-between gap-2 relative pr-2.5" component-part="code-group-tab-bar">

    <div class="min-w-0 flex-1 w-0 rounded-tl-xl" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px" component-part="scroll-area">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_2lkcp5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_uklkcp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_uslkcp5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_v4lkcp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    </div>

    <div class="flex flex-1 overflow-hidden">

    <div id="base-ui-_R_35kcp5deehkd74t9_" class="w-full min-w-full max-w-full h-full max-h-full relative focus-visible:outline-hidden before:content-[''] before:absolute before:inset-0 before:z-10 before:pointer-events-none before:rounded-xt focus-visible:before:outline focus-visible:before:outline-1 focus-visible:before:-outline-offset-2 focus-visible:before:outline-primary dark:focus-visible:before:outline-primary-light data-hidden:hidden [&_[data-component-part=code-block-root]]:rounded-xt!" orientation="horizontal" activation-direction="none" role="tabpanel" tabindex="0" index="-1">

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-xt bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:100%;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 base-ui-disable-scrollbar" data-id="base-ui-_R_r5kcp5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_55kcp5deehkd74t9_" class="w-full min-w-full max-w-full h-full max-h-full relative focus-visible:outline-hidden before:content-[''] before:absolute before:inset-0 before:z-10 before:pointer-events-none before:rounded-xt focus-visible:before:outline focus-visible:before:outline-1 focus-visible:before:-outline-offset-2 focus-visible:before:outline-primary dark:focus-visible:before:outline-primary-light data-hidden:hidden [&_[data-component-part=code-block-root]]:rounded-xt!" data-hidden="" orientation="horizontal" activation-direction="none" hidden="" role="tabpanel" tabindex="0" inert="" index="-1">

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-xt bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:100%;background-color:#FFFFFF;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 base-ui-disable-scrollbar" data-id="base-ui-_R_t5kcp5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_75kcp5deehkd74t9_" class="w-full min-w-full max-w-full h-full max-h-full relative focus-visible:outline-hidden before:content-[''] before:absolute before:inset-0 before:z-10 before:pointer-events-none before:rounded-xt focus-visible:before:outline focus-visible:before:outline-1 focus-visible:before:-outline-offset-2 focus-visible:before:outline-primary dark:focus-visible:before:outline-primary-light data-hidden:hidden [&_[data-component-part=code-block-root]]:rounded-xt!" data-hidden="" orientation="horizontal" activation-direction="none" hidden="" role="tabpanel" tabindex="0" inert="" index="-1">

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-xt bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:100%;background-color:#FFFFFF;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 base-ui-disable-scrollbar" data-id="base-ui-_R_v5kcp5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

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

    #### 

    <div class="absolute" tabindex="-1">

    <a href="#pulumi-configuration" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>
    <div class="size-6 rounded-md flex items-center justify-center shadow-xs text-gray-400 dark:text-white/50 dark:bg-background-dark dark:brightness-[1.35] dark:ring-1 dark:hover:brightness-150 bg-white ring-1 ring-gray-400/30 dark:ring-gray-700/25 hover:ring-gray-400/60 dark:hover:ring-white/20 group-focus/link:border-2 group-focus/link:border-primary dark:group-focus/link:border-primary-light">

    </div>

    </div>

    <span class="cursor-pointer">Pulumi configuration</span>

    <span data-as="p">Make sure to pass `--secret` when setting sensitive data.</span>

3.  <span data-as="p">Install <a href="/cli/get-started" class="link">1Password CLI</a> in your PATH. If you install the CLI outside of your PATH, specify the path to your 1Password CLI binary using either an environment variable or your Pulumi configuration.</span>

    #### 

    <div class="absolute" tabindex="-1">

    <a href="#environment-variable-2" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>
    <div class="size-6 rounded-md flex items-center justify-center shadow-xs text-gray-400 dark:text-white/50 dark:bg-background-dark dark:brightness-[1.35] dark:ring-1 dark:hover:brightness-150 bg-white ring-1 ring-gray-400/30 dark:ring-gray-700/25 hover:ring-gray-400/60 dark:hover:ring-white/20 group-focus/link:border-2 group-focus/link:border-primary dark:group-focus/link:border-primary-light">

    </div>

    </div>

    <span class="cursor-pointer">Environment variable</span>

    <div class="code-group p-0.5 mt-5 mb-8 flex flex-col not-prose relative rounded-2xl border border-gray-950/10 dark:border-white/10 min-w-0 bg-gray-50 dark:bg-white/5 dark:codeblock-dark text-gray-950 dark:text-gray-50 codeblock-light" orientation="horizontal" activation-direction="none">

    <div class="flex items-center justify-between gap-2 relative pr-2.5" component-part="code-group-tab-bar">

    <div class="min-w-0 flex-1 w-0 rounded-tl-xl" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px" component-part="scroll-area">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_2lmcp5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_uklmcp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_uslmcp5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_v4lmcp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    </div>

    <div class="flex flex-1 overflow-hidden">

    <div id="base-ui-_R_35mcp5deehkd74t9_" class="w-full min-w-full max-w-full h-full max-h-full relative focus-visible:outline-hidden before:content-[''] before:absolute before:inset-0 before:z-10 before:pointer-events-none before:rounded-xt focus-visible:before:outline focus-visible:before:outline-1 focus-visible:before:-outline-offset-2 focus-visible:before:outline-primary dark:focus-visible:before:outline-primary-light data-hidden:hidden [&_[data-component-part=code-block-root]]:rounded-xt!" orientation="horizontal" activation-direction="none" role="tabpanel" tabindex="0" index="-1">

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-xt bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:100%;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 base-ui-disable-scrollbar" data-id="base-ui-_R_r5mcp5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_55mcp5deehkd74t9_" class="w-full min-w-full max-w-full h-full max-h-full relative focus-visible:outline-hidden before:content-[''] before:absolute before:inset-0 before:z-10 before:pointer-events-none before:rounded-xt focus-visible:before:outline focus-visible:before:outline-1 focus-visible:before:-outline-offset-2 focus-visible:before:outline-primary dark:focus-visible:before:outline-primary-light data-hidden:hidden [&_[data-component-part=code-block-root]]:rounded-xt!" data-hidden="" orientation="horizontal" activation-direction="none" hidden="" role="tabpanel" tabindex="0" inert="" index="-1">

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-xt bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:100%;background-color:#FFFFFF;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 base-ui-disable-scrollbar" data-id="base-ui-_R_t5mcp5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_75mcp5deehkd74t9_" class="w-full min-w-full max-w-full h-full max-h-full relative focus-visible:outline-hidden before:content-[''] before:absolute before:inset-0 before:z-10 before:pointer-events-none before:rounded-xt focus-visible:before:outline focus-visible:before:outline-1 focus-visible:before:-outline-offset-2 focus-visible:before:outline-primary dark:focus-visible:before:outline-primary-light data-hidden:hidden [&_[data-component-part=code-block-root]]:rounded-xt!" data-hidden="" orientation="horizontal" activation-direction="none" hidden="" role="tabpanel" tabindex="0" inert="" index="-1">

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-xt bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:100%;background-color:#FFFFFF;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 base-ui-disable-scrollbar" data-id="base-ui-_R_v5mcp5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

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

    #### 

    <div class="absolute" tabindex="-1">

    <a href="#pulumi-configuration-2" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>
    <div class="size-6 rounded-md flex items-center justify-center shadow-xs text-gray-400 dark:text-white/50 dark:bg-background-dark dark:brightness-[1.35] dark:ring-1 dark:hover:brightness-150 bg-white ring-1 ring-gray-400/30 dark:ring-gray-700/25 hover:ring-gray-400/60 dark:hover:ring-white/20 group-focus/link:border-2 group-focus/link:border-primary dark:group-focus/link:border-primary-light">

    </div>

    </div>

    <span class="cursor-pointer">Pulumi configuration</span>


1.  <span data-as="p"><a href="/connect/get-started/#step-1" class="link">Create a Connect server</a> or find the host URL and token for an existing Connect server.</span>

2.  <span data-as="p">Provide the host URL and token to Pulumi using either environment variables or your Pulumi configuration.</span>

    #### 

    <div class="absolute" tabindex="-1">

    <a href="#environment-variables" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>
    <div class="size-6 rounded-md flex items-center justify-center shadow-xs text-gray-400 dark:text-white/50 dark:bg-background-dark dark:brightness-[1.35] dark:ring-1 dark:hover:brightness-150 bg-white ring-1 ring-gray-400/30 dark:ring-gray-700/25 hover:ring-gray-400/60 dark:hover:ring-white/20 group-focus/link:border-2 group-focus/link:border-primary dark:group-focus/link:border-primary-light">

    </div>

    </div>

    <span class="cursor-pointer">Environment variables</span>

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

    <div id="base-ui-_R_ul9hkkp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_v59hkkp5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_vl9hkkp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_p9hkkp5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_ulhhkkp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_v5hhkkp5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_vlhhkkp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_phhkkp5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_ulahkkp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_v5ahkkp5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_vlahkkp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_pahkkp5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_ulihkkp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_v5ihkkp5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_vlihkkp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_pihkkp5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_ulbhkkp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_v5bhkkp5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_vlbhkkp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_pbhkkp5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_uljhkkp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_v5jhkkp5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_vljhkkp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_pjhkkp5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

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

    #### 

    <div class="absolute" tabindex="-1">

    <a href="#pulumi-configuration-3" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>
    <div class="size-6 rounded-md flex items-center justify-center shadow-xs text-gray-400 dark:text-white/50 dark:bg-background-dark dark:brightness-[1.35] dark:ring-1 dark:hover:brightness-150 bg-white ring-1 ring-gray-400/30 dark:ring-gray-700/25 hover:ring-gray-400/60 dark:hover:ring-white/20 group-focus/link:border-2 group-focus/link:border-primary dark:group-focus/link:border-primary-light">

    </div>

    </div>

    <span class="cursor-pointer">Pulumi configuration</span>

    <span data-as="p">**Host URL**</span> <span data-as="p">**Token**</span> <span data-as="p">Make sure to pass `--secret` when setting sensitive data.</span>


1.  <span data-as="p">Find the <a href="https://support.1password.com/1password-glossary/#sign-in-address" class="link" target="_blank" rel="noreferrer">sign-in address</a> or <a href="/cli/reference/#unique-identifiers-ids" class="link">unique identifier</a> for your 1Password account.</span>

2.  <span data-as="p">Provide your account sign-in address or identifier to Pulumi using an environment variable or your Pulumi configuration.</span>

    #### 

    <div class="absolute" tabindex="-1">

    <a href="#environment-variable-3" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>
    <div class="size-6 rounded-md flex items-center justify-center shadow-xs text-gray-400 dark:text-white/50 dark:bg-background-dark dark:brightness-[1.35] dark:ring-1 dark:hover:brightness-150 bg-white ring-1 ring-gray-400/30 dark:ring-gray-700/25 hover:ring-gray-400/60 dark:hover:ring-white/20 group-focus/link:border-2 group-focus/link:border-primary dark:group-focus/link:border-primary-light">

    </div>

    </div>

    <span class="cursor-pointer">Environment variable</span>

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

    <div id="base-ui-_R_3qlj4sp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_3slj4sp5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_3ulj4sp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_35j4sp5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_3qmj4sp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_3smj4sp5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_3umj4sp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_36j4sp5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_3qnj4sp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_3snj4sp5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_3unj4sp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_37j4sp5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

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

    #### 

    <div class="absolute" tabindex="-1">

    <a href="#pulumi-configuration-4" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>
    <div class="size-6 rounded-md flex items-center justify-center shadow-xs text-gray-400 dark:text-white/50 dark:bg-background-dark dark:brightness-[1.35] dark:ring-1 dark:hover:brightness-150 bg-white ring-1 ring-gray-400/30 dark:ring-gray-700/25 hover:ring-gray-400/60 dark:hover:ring-white/20 group-focus/link:border-2 group-focus/link:border-primary dark:group-focus/link:border-primary-light">

    </div>

    </div>

    <span class="cursor-pointer">Pulumi configuration</span>

    <span data-as="p">Make sure to pass `--secret` when setting sensitive data.</span>

3.  <span data-as="p">Install <a href="/cli/get-started" class="link">1Password CLI</a> in your PATH. If you install the CLI outside of your PATH, specify the path to your 1Password CLI binary using either an environment variable or your Pulumi configuration.</span>

    #### 

    <div class="absolute" tabindex="-1">

    <a href="#environment-variable-4" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>
    <div class="size-6 rounded-md flex items-center justify-center shadow-xs text-gray-400 dark:text-white/50 dark:bg-background-dark dark:brightness-[1.35] dark:ring-1 dark:hover:brightness-150 bg-white ring-1 ring-gray-400/30 dark:ring-gray-700/25 hover:ring-gray-400/60 dark:hover:ring-white/20 group-focus/link:border-2 group-focus/link:border-primary dark:group-focus/link:border-primary-light">

    </div>

    </div>

    <span class="cursor-pointer">Environment variable</span>

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

    <div id="base-ui-_R_3qlj6sp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_3slj6sp5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_3ulj6sp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_35j6sp5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_3qmj6sp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_3smj6sp5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_3umj6sp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_36j6sp5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_3qnj6sp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_3snj6sp5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_3unj6sp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_37j6sp5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

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

    #### 

    <div class="absolute" tabindex="-1">

    <a href="#pulumi-configuration-5" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>
    <div class="size-6 rounded-md flex items-center justify-center shadow-xs text-gray-400 dark:text-white/50 dark:bg-background-dark dark:brightness-[1.35] dark:ring-1 dark:hover:brightness-150 bg-white ring-1 ring-gray-400/30 dark:ring-gray-700/25 hover:ring-gray-400/60 dark:hover:ring-white/20 group-focus/link:border-2 group-focus/link:border-primary dark:group-focus/link:border-primary-light">

    </div>

    </div>

    <span class="cursor-pointer">Pulumi configuration</span>

4.  <span data-as="p">To use Touch ID, Windows Hello, or another system authentication option with the provider, <a href="/cli/get-started#step-2-turn-on-the-1password-desktop-app-integration" class="link">turn on the 1Password CLI app integration</a>.</span>


## 


<a href="#step-3-use-the-provider" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#reference" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


<table class="m-0 min-w-full w-full max-w-none table [&amp;_th]:text-left [&amp;_td[data-numeric]]:tabular-nums [&amp;_td]:min-w-[150px]">
<colgroup>
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
<col style="width: 25%" />
</colgroup>
<thead>
<tr class="header">
<th>Configuration key</th>
<th>Environment variable</th>
<th>Description</th>
<th>Authentication method</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>pulumi-onepassword:service_account_token</code></td>
<td><code>OP_SERVICE_ACCOUNT_TOKEN</code></td>
<td>The string value of your <a href="/service-accounts/get-started" class="link">1Password Service Account</a> token.</td>
<td>Service account</td>
</tr>
<tr class="even">
<td><code>pulumi-onepassword:url</code></td>
<td><code>OP_CONNECT_HOST</code></td>
<td>The URL where your <a href="/connect/" class="link">1Password Connect Server</a> can be found. For example: <code>http://localhost:8080</code>.</td>
<td>Connect server</td>
</tr>
<tr class="odd">
<td><code>pulumi-onepassword:token</code></td>
<td><code>OP_CONNECT_TOKEN</code></td>
<td>The string value of your <a href="/connect/concepts#connect-server-access-token" class="link">Connect server token</a>.</td>
<td>Connect server</td>
</tr>
<tr class="even">
<td><code>pulumi-onepassword:account</code></td>
<td><code>OP_ACCOUNT</code></td>
<td>A 1Password account <a href="https://support.1password.com/1password-glossary/#sign-in-address" class="link" target="_blank" rel="noreferrer">sign-in address</a> or <a href="/cli/reference/#unique-identifiers-ids" class="link">unique identifier</a>.</td>
<td>Account details</td>
</tr>
<tr class="odd">
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


{"docsConfig":{"theme":"mint","\$schema":"https://mintlify.com/docs.json","name":"1Password Developer","colors":{"primary":"#104ebb","light":"#b8d7ff","dark":"#303136"},"logo":{"light":"https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max\u0026auto=format\u0026n=lHrfVfSCdefFz8U5\u0026q=85\u0026s=29d1c9358888a723dddd8a89a3b6f71d","dark":"https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-light.svg?fit=max\u0026auto=format\u0026n=lHrfVfSCdefFz8U5\u0026q=85\u0026s=119233092720e49043d6f42ff71125f1"},"favicon":"https://mintcdn.com/ab-634991b8/s4Wjy03jBRs6hcHb/favicon.ico?fit=max\u0026auto=format\u0026n=s4Wjy03jBRs6hcHb\u0026q=85\u0026s=dd03b4bc604b342373aa4d3e21be4310","api":{"playground":{"display":"interactive"},"examples":{"languages":\["curl","node","python","go","dotnet","java","php","powershell","ruby"\]}},"background":{"color":{"light":"#fbf8f4","dark":"#1a1b1e"}},"navbar":{"links":\[{"href":"/community","label":"Community"},{"href":"https://www.1password.academy/path/1password-developer-tools","label":"Academy"}\],"primary":{"type":"button","label":"GitHub","href":"https://github.com/1Password"}},"footer":{"socials":{"github":"https://github.com/1Password","x":"https://twitter.com/1Password","reddit":"https://www.reddit.com/r/1Password","linkedin":"https://www.linkedin.com/company/1password","youtube":"https://www.youtube.com/1PasswordVideos","facebook":"https://www.facebook.com/1Password","instagram":"https://www.instagram.com/1password"},"links":\[{"header":"Legal","items":\[{"label":"Terms of Service","href":"https://1password.com/legal/terms-of-service"},{"label":"Privacy Policy","href":"https://1password.com/legal/privacy"},{"label":"Cookie Policy","href":"https://1password.com/legal/cookies"},{"label":"Accessibility","href":"https://1password.com/legal/accessibility"}\]},{"header":"Community","items":\[{"label":"Developer community","href":"/community"},{"label":"Code of Conduct","href":"/code-of-conduct"},{"label":"Community projects disclaimer","href":"/community/disclaimer"}\]},{"header":"Resources","items":\[{"label":"1Password University","href":"https://www.1password.university/?utm_ref=website-footer"},{"label":"Blog RSS","href":"https://blog.1password.com/index.xml"},{"label":"Newsletter","href":"https://1password.com/developer-newsletter"}\]}\]},"seo":{"metatags":{"canonical":"https://www.1password.dev","google-site-verification":"YserOhXnJUjFfIZ4K3qgxkVSlQZQdXtIbBiKzZ35Nvs"}},"fonts":{"heading":{"family":"Public Sans"},"body":{"family":"Public Sans"}},"banner":{"content":"\*\*New!\*\* Use the \[1Password Credential Broker\](https://www.1password.dev/brokered-access) to give CI/CD and other machine workflows short-lived access to secrets, without managing service account tokens.","dismissible":true,"color":{"light":"#145fe4","dark":"#145fe4"}},"errors":{"404":{"redirect":false,"title":"This page can't be found","description":"Our docs have moved to \[www.1password.dev\](https://www.1password.dev). Try searching for what you need or selecting from the list of tools."}},"contextual":{"options":\["copy","view","mcp","cursor","vscode","chatgpt","claude","perplexity"\],"display":"header"},"styling":{"latex":false},"navigation":{"pages":\[\]}},"deployment":{"deploymentMetadataValue":{"subdomain":"ab-634991b8","hasAudioNarration":false,"actualSubdomain":"ab-634991b8","customDomains":\["www.1password.dev"\],"gitSource":{"type":"github","owner":"1password","repo":"1password.dev","deployBranch":"main","contentDirectory":"","isPrivate":true,"mountPath":"","label":""},"chroma":{"liveDeploymentHistoryId":"6ae4c9014c4a3f4f5e4b234c","collectionId":"2b0d16b8-c8c5-48fa-9c4d-f1ffef490467","schemaVersion":"v3","latestBuiltDeploymentHistoryId":"6ae4c9014c4a3f4f5e4b234c"},"feedback":{"thumbs":true,"contextualFeedback":{"allowEmail":false},"agentFeedback":true},"entitlements":{"AI_CHAT":{"status":"ENABLED"},"REMOVE_BRANDING":{"status":"ENABLED"},"CONTEXTUAL_FEEDBACK":{"status":"ENABLED"},"CODE_SNIPPET_FEEDBACK":{"status":"ENABLED"},"WEB_MCP":{"status":"ENABLED"},"NARRATION":{"status":"ENABLED"}},"buildId":"6ae4c9014c4a3f4f5e4b234c","clientVersion":"0.0.4044","searchFilterCounts":\[{"language":"default","tag":"More Tools","count":257},{"language":"default","tag":"Shell Plugins","count":184},{"language":"default","tag":"CLI","count":112},{"language":"default","tag":"Secrets Automation","count":94},{"language":"default","tag":"SaaS Manager API","count":88},{"language":"default","tag":"Plugins","count":85},{"language":"default","tag":"API Reference","count":64},{"language":"default","tag":"Reference","count":58},{"language":"default","tag":"SDKs","count":53},{"language":"default","tag":"Integrations","count":50}\]},"assistantConfig":{"enableStarterQuestions":true,"enableContextualStarterQuestions":true,"deflection":{"enabled":true,"email":"support@1password.com","showHelpButton":true}},"basePath":"","hasChatPermissions":true,"hasWebMcpPermissions":true,"toggles":\[{"name":"kill-isr","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"agent-mintlify-slack","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"agent-integrations-settings","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"automations-pr-grouping","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"custom-prefix","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"analytics-v7","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"user-flows-analytics","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"no-publish-flow","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"workos-onboarding","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"llms-txt-v2","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"snapshot-serving-live","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"stripTemperatureMiddleware","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"support-platform-pylon-zendesk","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"snapshot-serving","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"instant-rollback","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"granular-notifications-server","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"granular-notifications","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"automations-fable","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"fixed-ai-action-pricing","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"automation-resolve-merge-conflict","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"scoped-publishing","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"mintql","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"page-level-analytics","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"editor-version-history-v2","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"billing-page-v2","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"full-page-search","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"workspace-projects","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"assistant-v5","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"byok-sep-25","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"fork-pr-previews","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"revalidation-jwt","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"vite-origin","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"billing-updated-9-15","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"workos-sso-scim","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"hobby-abuse-scan","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"dashboard-inbox","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"workos-signup","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"turbopuffer-dual-write","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"workos-enabled","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"approve-review-flow","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"sso-setup-deadline-banner","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false}\],"googleFontsInlined":true},"customCss":\[{"filePath":"styles.css","content":":root{--op-secure-blue:#104ebb;--op-secure-blue-hover:#0e46a8;--op-iron-ore:#303136;--op-page-bg-dark:#1a1b1e;--op-white:#ffffff;--op-icy-blue:#dcebff;--op-cornflower:#b8d7ff;--op-biscuit:#fbf8f4;--op-sunbeam:#fad785;--op-tangerine:#ff8f78;--op-enable-mint:#76e0bd;--op-gold:#cbb88e;--op-status-success:#10622f;--op-status-warning:#8a4006;--op-status-error:#a71c1c;--op-status-info:var(--op-secure-blue);--op-border-ui:#949494;--op-border-ui-dark:#6b7280;--op-border-subtle:rgb(3 7 18 / 0.12);--op-border-subtle-dark:rgb(251 248 244 / 0.25);--op-border-footer-dark:rgb(251 248 244 / 0.37);--op-border-navbar-light:rgb(107 114 128 / 0.05);--op-border-navbar-dark:rgb(209 213 219 / 0.06);--op-border-card-light:rgb(3 7 18 / 0.1);--op-border-card-dark:rgb(255 255 255 / 0.1);--op-border-hero-light:rgb(255 255 255 / 0.08);--op-border-hero-dark:rgb(255 255 255 / 0.12);--op-border-badge-light:rgb(16 78 187 / 0.2);--op-border-badge-dark:rgb(184 215 255 / 0.25);--op-border-workflow-dark:rgb(251 248 244 / 0.2);--op-text-body:var(--op-iron-ore);--op-text-body-dark:var(--op-biscuit);--op-surface-card-light:var(--op-white);--op-surface-card-dark:#25262a;--op-surface-callout-light:rgb(220 235 255 / 0.45);--op-surface-callout-dark:rgb(184 215 255 / 0.08)}#content.prose{--tw-prose-body:var(--op-text-body)}.dark \#content.prose{--tw-prose-body:var(--op-text-body-dark)}#content.prose :where(p, span\[data-as=\\p\\\], li, td, th, blockquote, figcaption):not(a.op-cta-primary span){color:var(--op-text-body)}.dark \#content.prose :where(p, span\[data-as=\\p\\\], li, td, th, blockquote, figcaption):not(a.op-cta-primary span){color:var(--op-text-body-dark)}#content :is(p, li, div, span, button, h1, h2, h3, h4, h5, h6).text-gray-600,#content :is(p, li, div, span, button, h1, h2, h3, h4, h5, h6).text-gray-700,#content :is(p, li, span, button, h1, h2, h3, h4, h5, h6).text-gray-500{color:var(--op-text-body)}.dark \#content :is(p, li, div, span, button, h1, h2, h3, h4, h5, h6).dark\\:text-gray-300,.dark \#content :is(p, li, div, span, button, h1, h2, h3, h4, h5, h6).dark\\:text-gray-400,.dark \#content :is(p, li, span, button, h1, h2, h3, h4, h5, h6).dark\\:text-gray-500{color:var(--op-text-body-dark)}#content .text-gray-400:not(:is(p, li, span, button, h1, h2, h3, h4, h5, h6)){color:var(--op-border-ui)}.dark \#content .text-gray-400:not(:is(p, li, span, button, h1, h2, h3, h4, h5, h6)),.dark \#content .text-gray-500:not(:is(p, li, span, button, h1, h2, h3, h4, h5, h6)){color:var(--op-border-ui-dark)}.dark .card-group{--background-dark:37 38 42}.dark .card-group .card{background-color:rgb(var(--background-dark))!important;border-color:var(--op-border-card-dark)!important}.card-group .card{border-color:var(--op-border-card-light)!important}.community-callout,.community-card,.op-card-surface{border:1px solid var(--op-border-card-light)}.dark .community-card,.dark .op-card-surface{border-color:var(--op-border-card-dark)}#content .hover\\:border-gray-300:hover{border-color:var(--op-iron-ore)}.dark \#content .hover\\:border-gray-600:hover{border-color:var(--op-biscuit)}.community-callout,.community-card{border-radius:.5rem;background-color:var(--op-surface-card-light)}.dark .community-card{background-color:var(--op-surface-card-dark)}.community-card .community-card-chevron{color:var(--op-border-ui)}.dark .community-card .community-card-chevron{color:var(--op-cornflower)}a.community-card:hover{border-color:var(--op-secure-blue)}.dark a.community-card:hover{border-color:var(--op-cornflower)}.community-callout{background-color:var(--op-surface-callout-light)}.dark .community-callout{border-color:var(--op-border-card-dark);background-color:var(--op-surface-callout-dark)}.community-link{color:var(--op-secure-blue);text-decoration:none}.community-link:hover{color:var(--op-secure-blue-hover);text-decoration:underline}.dark .community-link{color:var(--op-cornflower)}#footer a,#footer p.font-semibold,.dark \#content\>h5,.dark \#content\>h6,.dark .community-link:hover{color:var(--op-white)}:is(\n \#sidebar-content a:not(\[aria-current=\\page\\\]),\n \#table-of-contents,\n \#table-of-contents a,\n \#navbar .nav-tabs-item:not(\[data-active\]),\n \#navbar nav ul \> li:not(#topbar-cta-button) \> a,\n \#search-bar-entry,\n \#search-bar-entry-mobile,\n \#assistant-entry,\n \#assistant-entry-mobile,\n \[data-component-name=\\theme-toggle\\\]\n){color:var(--op-text-body)}.dark :is(\n \#sidebar-content a:not(\[aria-current=\\page\\\]),\n \#table-of-contents,\n \#table-of-contents a,\n \#navbar .nav-tabs-item:not(\[data-active\]),\n \#navbar nav ul \> li:not(#topbar-cta-button) \> a,\n \#search-bar-entry,\n \#search-bar-entry-mobile,\n \#assistant-entry,\n \#assistant-entry-mobile,\n \[data-component-name=\\theme-toggle\\\]\n){color:var(--op-text-body-dark)}:is(\n \#search-bar-entry,\n \#search-bar-entry-mobile,\n \#assistant-entry,\n \#assistant-entry-mobile,\n \[data-component-name=\\theme-toggle\\\]\n) svg{color:inherit}#footer a.h-fit svg{background-color:var(--op-biscuit)}#footer a.h-fit:hover svg{background-color:var(--op-white)}.hero-background{background-color:var(--op-iron-ore);background-image:radial-gradient(ellipse 75% 100% at 100% 50%,rgb(20 95 228/.55) 0,rgb(20 95 228/.2) 40%,transparent 70%)}.dark .hero-background{background-color:var(--op-page-bg-dark);background-image:radial-gradient(ellipse 80% 100% at 100% 50%,rgb(20 95 228/.7) 0,rgb(20 95 228/.3) 45%,transparent 75%)}.hero-section{border-bottom:1px solid var(--op-border-hero-light)}.dark .hero-section{border-bottom-color:var(--op-border-hero-dark)}.hero-cta{background-color:var(--op-secure-blue);color:var(--op-white);box-shadow:0 1px 3px rgb(0 0 0/.25)}.hero-cta svg,.hero-cta svg path{fill:currentColor!important;color:currentColor!important}.hero-cta:hover{background-color:var(--op-secure-blue-hover)}#content a.op-cta-primary,#content.prose a.op-cta-primary{background-color:var(--op-secure-blue);color:var(--op-white)!important;text-decoration:none}#content a.op-cta-primary span,#content a.op-cta-primary span\[data-as=p\],#content a.op-cta-primary:hover span,#content a.op-cta-primary:hover span\[data-as=p\],#content.prose a.op-cta-primary span,#content.prose a.op-cta-primary span\[data-as=p\],#content.prose a.op-cta-primary:hover span,#content.prose a.op-cta-primary:hover span\[data-as=p\]{color:var(--op-white)!important}#content a.op-cta-primary:hover,#content.prose a.op-cta-primary:hover{background-color:var(--op-secure-blue-hover);color:var(--op-white)!important}#topbar-cta-button a\>span.absolute,.highlight-card-link svg{background-color:var(--op-secure-blue)!important}#topbar-cta-button a:hover\>span.absolute{background-color:var(--op-secure-blue-hover)!important}#topbar-cta-button a span.z-10,#topbar-cta-button a svg,.dark .highlight-card-link:hover{color:var(--op-white)!important}.card-group{gap:1rem}#content .card-group img\[src\*=\\/homepage-icons/brand/\\\]{width:32px;height:32px;flex-shrink:0}.homepage-card-title{display:inline-flex;flex-wrap:wrap;align-items:center;gap:.25rem .5rem}.image-button-link img{margin:10px 0}.dark \#content a\>div\>span{color:var(--op-cornflower)!important}.docs-higlight-cards{display:grid;grid-template-columns:repeat(auto-fill,minmax(250px,1fr));gap:1rem;margin-bottom:1rem}.highlight-card-link{color:var(--op-secure-blue)!important}.highlight-card-link:hover{color:var(--op-secure-blue-hover)!important}.dark .highlight-card-link{color:var(--op-cornflower)!important}.dark .highlight-card-link svg{background-color:var(--op-cornflower)!important}.coloredCodeWrapper .code-block\>div:nth-child(3){--fade-color-light:transparent!important;--fade-color-dark:transparent!important}.badge{border-radius:.4rem;color:var(--op-white);font-weight:700;line-height:1;padding:3px 5px}.badge--primary{background-color:var(--op-secure-blue)}.badge--secondary{background-color:var(--op-biscuit);color:var(--op-iron-ore)}.op-status-badge,.op-workflow-guide-badge{display:inline-flex;flex-shrink:0;align-items:center;white-space:nowrap;border-radius:.25rem;color:var(--op-iron-ore);padding:.125rem .625rem;font-size:.75rem;line-height:1rem;font-weight:600}.op-status-badge{vertical-align:middle;border:1px solid var(--op-border-badge-light);background-color:var(--op-icy-blue)}.dark .op-status-badge{border-color:var(--op-border-badge-dark);background-color:rgb(184 215 255/.12);color:var(--op-icy-blue)}.op-workflow-guide-badge{margin-top:.75rem;border:1px solid transparent;background-color:var(--op-biscuit)}.dark .op-workflow-guide-badge{border-color:var(--op-border-workflow-dark);background-color:rgb(251 248 244/.1);color:var(--op-biscuit)}.op-beta-badge-inline{display:inline-flex;align-items:center;margin-left:.5rem;vertical-align:middle}.mdx-content a\[href^=http\]:not(\[href\*=\\://1password.com/\\\],\[href\$=\\://1password.com\\\],\[href\*=\\.1password.com/\\\],\[href\$=\\.1password.com\\\],\[href\*=\\://1password.dev/\\\],\[href\$=\\://1password.dev\\\],\[href\*=\\.1password.dev/\\\],\[href\$=\\.1password.dev\\\],\[href\*=\\://1password.ca/\\\],\[href\$=\\://1password.ca\\\],\[href\*=\\.1password.ca/\\\],\[href\$=\\.1password.ca\\\],\[href\*=\\://1password.eu/\\\],\[href\$=\\://1password.eu\\\],\[href\*=\\.1password.eu/\\\],\[href\$=\\.1password.eu\\\],\[href\*=\\://1password.io/\\\],\[href\$=\\://1password.io\\\],\[href\*=\\.1password.io/\\\],\[href\$=\\.1password.io\\\],\[href\*=\\://1password.university/\\\],\[href\$=\\://1password.university\\\],\[href\*=\\.1password.university/\\\],\[href\$=\\.1password.university\\\],\[href\*=\\://agilebits.com/\\\],\[href\$=\\://agilebits.com\\\],\[href\*=\\.agilebits.com/\\\],\[href\$=\\.agilebits.com\\\],\[href\*=\\://b5dev.com/\\\],\[href\$=\\://b5dev.com\\\],\[href\*=\\.b5dev.com/\\\],\[href\$=\\.b5dev.com\\\],\[href\*=\\://b5local.com/\\\],\[href\$=\\://b5local.com\\\],\[href\*=\\.b5local.com/\\\],\[href\$=\\.b5local.com\\\],\[href\*=\\://1infra.dev/\\\],\[href\$=\\://1infra.dev\\\],\[href\*=\\.1infra.dev/\\\],\[href\$=\\.1infra.dev\\\],\[href\*=\\://kolide.com/\\\],\[href\$=\\://kolide.com\\\],\[href\*=\\.kolide.com/\\\],\[href\$=\\.kolide.com\\\],\[href\*=\\://trelica.app/\\\],\[href\$=\\://trelica.app\\\],\[href\*=\\.trelica.app/\\\],\[href\$=\\.trelica.app\\\],\[href\*=\\://trelica.eu/\\\],\[href\$=\\://trelica.eu\\\],\[href\*=\\.trelica.eu/\\\],\[href\$=\\.trelica.eu\\\],\[href\*=\\://trelica.com/\\\],\[href\$=\\://trelica.com\\\],\[href\*=\\.trelica.com/\\\],\[href\$=\\.trelica.com\\\],\[href\*=\\://1password.community/\\\],\[href\$=\\://1password.community\\\],\[href\*=\\.1password.community/\\\],\[href\$=\\.1password.community\\\],\[href\*=\\://1pw.ca/\\\],\[href\$=\\://1pw.ca\\\],\[href\*=\\.1pw.ca/\\\],\[href\$=\\.1pw.ca\\\]):not(.card \*,.op-card-surface \*,.image-button-link,.community-card,.community-card \*,pre \*,:has(img))::after{content:\\\\;display:inline-block;width:1em;height:1em;margin-left:.25em;vertical-align:-.125em;background-color:currentColor;-webkit-mask:var(--op-link-icon, url(\\/static/img/icons/external-link.svg\\)) no-repeat center/contain;mask:var(--op-link-icon, url(\\/static/img/icons/external-link.svg\\)) no-repeat center/contain}.mdx-content a:is(\[href\*=\\://github.com/\\\], \[href\$=\\://github.com\\\], \[href\*=\\.github.com/\\\], \[href\$=\\.github.com\\\], \[href\*=\\://github.blog/\\\], \[href\$=\\://github.blog\\\]){--op-link-icon:url(\\/static/img/logos/github.svg\\)}#content\>h5,#content\>h6{font-weight:700}.accordion{background-color:var(--op-icy-blue)}.dark .accordion{background-color:var(--op-surface-card-dark)}.accordion .mint-bg-white{padding:1rem}.accordion .mint-bg-white \[class\*=-mx-\]{margin:0!important;padding:0!important;width:100%!important;--page-padding:0px}#footer img.nav-logo.dark\\:hidden,#footer\>div\>div.flex.flex-col.md\\:flex-row.gap-8.justify-between.min-h-\\\[76px\\\]\>div.flex.flex-col.sm\\:grid.max-md\\:\\!grid-cols-2.gap-8.flex-1\>div\>div\>p{display:none!important}footer#footer.advanced-footer{display:flex!important}footer#footer{align-items:unset;background-color:var(--op-iron-ore);color:var(--op-white)}#footer img.nav-logo.dark\\:block{display:block!important}#footer\>div.flex.w-full.flex-col.gap-12.justify-between.px-8.py-16.md\\:py-20.lg\\:py-28.z-20\>div.h-\\\[1px\\\].w-full.bg-gray-100.dark\\:bg-white\\/5{background-color:var(--op-border-footer-dark)}#footer\>div.flex.w-full.flex-col.gap-12.justify-between.px-8.py-16.md\\:py-20.lg\\:py-28.z-20{margin:0 auto}footer .email_form{max-width:650px;margin:auto}.codeblock_accordion{margin-top:10px}.codeblock_accordion .code-block{margin:0!important}.codeblock_accordion\>div\>.code-block,.codeblock_accordion\>div\>.code-block\>div:nth-child(2){border-bottom-left-radius:0;border-bottom-right-radius:0}.codeblock_accordion .see_results_container{border-bottom-left-radius:1rem;border-bottom-right-radius:1rem}.codeblock_accordion .see_results_container .code-block,.codeblock_accordion .see_results_container .code-block\>div:nth-child(2){border-top-left-radius:0;border-top-right-radius:0}.hide_bullets ul li{padding-left:0!important}.hide_bullets ul li::before{content:none!important}#navigation-items a\[href^=\\/\\\]:not(\[href^=\\//\\\])\>div\>div:nth-child(2){display:none}a\[href^=\\//\\\] .flex-shrink-0 svg,a\[href^=http\] .flex-shrink-0 svg{display:block}h1 code,h2 code,h3 code,h4 code,h5 code,h6 code{white-space:nowrap}h2.flex.whitespace-pre-wrap span.cursor-pointer svg.icon,h4.flex.whitespace-pre-wrap span.cursor-pointer svg.icon{margin:0;vertical-align:baseline}table thead tr th code{padding-left:0!important;padding-right:0!important}.tabs.tab-container{padding:0 .8rem 1rem;border:1px solid var(--op-border-subtle);border-radius:4px}.dark .tabs.tab-container{border-color:var(--op-border-subtle-dark)}.nav-tabs-item:nth-child(3),nav-tabs-item:nth-child(3){--tab-gap-before-divider:8px;--nav-tabs-item-gap:0.5rem;margin-left:var(--tab-gap-before-divider)!important;padding-left:calc(var(--tab-gap-before-divider) + var(--nav-tabs-item-gap))!important;border-left:1px solid var(--op-border-navbar-light)}.dark .nav-tabs-item:nth-child(3),.dark nav-tabs-item:nth-child(3){border-left-color:var(--op-border-navbar-dark)}.peer.is-center~div:has(.tutorial-explorer){max-width:84rem!important}@media (max-width:639px){.tutorial-filter-bar{display:grid!important;grid-template-columns:minmax(0,1fr)}.tutorial-filter-search,.tutorial-filter-tools,.tutorial-filter-topic{grid-column:1/-1;width:100%}.tutorial-filter-search input{width:100%!important}.tutorial-filter-dropdown\>button,.tutorial-filter-menu{width:100%}.tutorial-filter-dropdown\>button{justify-content:space-between}.tutorial-filter-menu{min-width:0!important}.tutorial-filter-sort{grid-column:1/-1;justify-self:end;margin-left:0!important}}#navbar.is-custom .nav-tabs-item\[data-active\]{color:var(--op-text-body);text-shadow:none}.dark \#navbar.is-custom .nav-tabs-item\[data-active\]{color:var(--op-text-body-dark)}#navbar.is-custom .nav-tabs-item\[data-active\]\>div{background-color:transparent!important}#navbar.is-custom .nav-tabs-item\[data-active\]:hover\>div{background-color:rgb(229 231 235)!important}.dark \#navbar.is-custom .nav-tabs-item\[data-active\]:hover\>div{background-color:rgb(55 65 81)!important}#footer .api-sdk-terms-notice{margin:0;padding:0 0 1.25rem;font-size:.875rem;font-style:italic;line-height:1.5;text-align:center;color:rgb(251 248 244/.8);pointer-events:auto}#footer .api-sdk-terms-notice a{position:relative;z-index:2;color:var(--op-cornflower);text-decoration:underline;text-underline-offset:2px;pointer-events:auto;cursor:pointer}"}\],"page":{"pagePath":"connect/pulumi","slug":"/connect/pulumi","pageMetadata":{"title":"Use the 1Password provider for Pulumi with Connect","sidebarTitle":"Pulumi","og:description":"Use a 1Password Connect server to access and manage items in your vaults with the 1Password provider for Pulumi.","description":null,"href":"/connect/pulumi"},"pageType":"default","mdx":{"mdxSource":{"compiledSource":"\\use strict\\;const{Fragment:\_Fragment,jsx:\_jsx,jsxs:\_jsxs}=arguments\[0\];const{useMDXComponents:\_provideComponents}=arguments\[0\];const CodeResult=({children,resultLang,wrap,expandable})=\>{const{CodeBlock,Icon}=\_provideComponents()\|\|{};if(!CodeBlock)\_missingMdxReference(\`CodeBlock\`,true);if(!Icon)\_missingMdxReference(\`Icon\`,true);const parseChildren=()=\>{let language=\`text\`;let codeContent=\`\`;const extractText=node=\>{if(typeof node===\`string\`){return node}if(Array.isArray(node)){return node.map(extractText).join(\`\`)}if(node?.props?.children){return extractText(node.props.children)}return\`\`};const extractLanguage=node=\>{if(!node)return null;if(node.props?.className){const className=node.props.className;const langMatch=className.match(/language-(\\w+)/);if(langMatch){return langMatch\[1\]}}if(node.props?.\[\`data-language\`\]){return node.props\[\`data-language\`\]}if(node.props?.language){return node.props.language}return null};if(typeof children===\`string\`){codeContent=children}else if(Array.isArray(children)){codeContent=extractText(children);for(const child of children){const detectedLang=extractLanguage(child);if(detectedLang){language=detectedLang;break}}}else if(children?.props){const detectedLang=extractLanguage(children);if(detectedLang){language=detectedLang}codeContent=extractText(children)}const parts=codeContent.split(\`#code-result\`);if(parts.length\u003c2){return{command:codeContent.trim(),result:null,language,defaultOpen:false}}const resultText=parts\[1\].trim();const defaultOpen=resultText.startsWith(\`open\`);const cleanResult=defaultOpen?resultText.slice(4).trim():resultText;return{command:parts\[0\].trim(),result:cleanResult,language,defaultOpen}};const{command,result,language,defaultOpen}=parseChildren();const\[isOpen,setIsOpen\]=useState(defaultOpen);if(!result){return children}return \_jsxs(\`div\`,{className:\`codeblock_accordion not-prose mint-mb-4\`,children:\[\_jsx(\`div\`,{className:\`\[\u0026\>\*\]:!mint-mb-0 \[\u0026\>\*\]:!mint-rounded-b-none\`,children:\_jsx(CodeBlock,{language,children:command,wrap,expandable})}),\_jsxs(\`div\`,{className:\`see_results_container mint-border-t-0 mint-bg-gray-100/80 dark:mint-bg-gray-800/80 mint-overflow-hidden\`,style:{marginTop:\`-0.25rem\`},children:\[\_jsxs(\`button\`,{onClick:()=\>setIsOpen(!isOpen),className:\`mint-w-full mint-px-4 mint-py-2.5 mint-flex mint-items-center mint-gap-1 mint-text-left mint-text-\[14px\] mint-font-medium mint-text-gray-600 dark:mint-text-gray-400 hover:mint-text-gray-800 dark:hover:mint-text-gray-200 hover:mint-bg-gray-200/60 dark:hover:mint-bg-gray-700/60 mint-transition-all mint-duration-150\`,\\aria-expanded\\:isOpen,children:\[isOpen?\_jsx(Icon,{icon:\`caret-down\`,size:\`14\`,iconType:\`solid\`}):\_jsx(Icon,{icon:\`caret-right\`,size:\`14\`,iconType:\`solid\`}),\_jsx(\`span\`,{children:\`See result...\`})\]}),isOpen\u0026\u0026_jsx(\`div\`,{className:\`\[\u0026\>\*\]:!mint-mt-0 \[\u0026\>\*\]:!mint-rounded-t-none mint-border-t mint-border-\[var(--op-border-ui)\] dark:mint-border-\[var(--op-border-ui-dark)\]\`,children:\_jsx(CodeBlock,{language:resultLang\|\|language,children:result,wrap,expandable})})\]})\]})};const Small=({children})=\>{return \_jsx(\`small\`,{children})};function \_createMdxContent(props){const \_components={a:\`a\`,code:\`code\`,li:\`li\`,ol:\`ol\`,p:\`p\`,pre:\`pre\`,span:\`span\`,strong:\`strong\`,tbody:\`tbody\`,td:\`td\`,th:\`th\`,thead:\`thead\`,tr:\`tr\`,ul:\`ul\`,...\_provideComponents(),...props.components},{CodeBlock,CodeGroup,Heading,Tab,Table,Tabs,\_MdxComponentBoundary}=\_components;if(!CodeBlock)\_missingMdxReference(\`CodeBlock\`,true);if(!CodeGroup)\_missingMdxReference(\`CodeGroup\`,true);if(!Heading)\_missingMdxReference(\`Heading\`,true);if(!Tab)\_missingMdxReference(\`Tab\`,true);if(!Table)\_missingMdxReference(\`Table\`,true);if(!Tabs)\_missingMdxReference(\`Tabs\`,true);if(!\_MdxComponentBoundary)\_missingMdxReference(\`\_MdxComponentBoundary\`,true);return \_jsxs(\_Fragment,{children:\[\_jsxs(\_components.p,{children:\[\`You can use the \`,\_jsx(\_components.a,{href:\`https://www.pulumi.com/registry/packages/onepassword/\`,children:\`1Password provider for Pulumi\`}),\` to access and manage items in your 1Password vaults.\`\]}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`requirements\`,children:\`Requirements\`}),\`\n\`,\_jsx(\_components.p,{children:\`The provider can be configured to authenticate with a service account, a Connect server, or with your 1Password account details.\`}),\`\n\`,\_jsxs(Tabs,{groupId:\`authentication-method\`,children:\[\_jsxs(Tab,{title:\`Service account\`,id:\`service-account\`,children:\[\_jsxs(\_components.p,{children:\[\_jsx(\_components.a,{href:\`/service-accounts/\`,children:\`1Password Service Accounts\`}),\` allow you to restrict the provider’s access to specific vaults in your 1Password account, so you can follow the principle of least privilege in your project.\`\]}),\_jsx(\_components.p,{children:\`To use a service account with the 1Password provider for Pulumi, you’ll need:\`}),\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`https://1password.com/pricing/password-manager\`,children:\`1Password subscription\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/cli/get-started\`,children:\`1Password CLI\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/service-accounts/get-started\`,children:\`1Password service account\`})}),\`\n\`\]})\]}),\_jsxs(Tab,{title:\`Connect server\`,id:\`connect-server\`,children:\[\_jsxs(\_components.p,{children:\[\_jsx(\_components.a,{href:\`/connect/\`,children:\`1Password Connect Servers\`}),\` are a good authentication option when you need unlimited requests and use self-hosted infrastructure.\`\]}),\_jsx(\_components.p,{children:\`Connect servers allow you to restrict the provider’s access to specific vaults in your 1Password account, so you can follow the principle of least privilege in your project.\`}),\_jsx(\_components.p,{children:\`To use a Connect server with the 1Password provider for Pulumi, you’ll need:\`}),\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`https://1password.com/pricing/password-manager\`,children:\`1Password subscription\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/connect/get-started/#step-1\`,children:\`1Password Connect server\`})}),\`\n\`\]})\]}),\_jsxs(Tab,{title:\`Account details\`,id:\`account-details\`,children:\[\_jsx(\_components.p,{children:\`When you configure the provider with your 1Password account details, the provider can access any vault in your account, and you can use Touch ID, Windows Hello, or another system authentication option with the provider.\`}),\_jsx(\_components.p,{children:\`To use your account details with the 1Password provider for Pulumi, you’ll need:\`}),\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`https://1password.com/pricing/password-manager\`,children:\`1Password subscription\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/cli/get-started\`,children:\`1Password CLI\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`https://1password.com/downloads/\`,children:\`1Password desktop app\*\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/cli/get-started#step-2-turn-on-the-1password-desktop-app-integration\`,children:\`1Password app integration\*\`})}),\`\n\`\]}),\_jsx(\_MdxComponentBoundary,{name:\`Small\`,children:\_jsx(Small,{children:\`\* To authenticate with Touch ID, Windows Hello, or another system authentication option.\`})})\]})\]}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`step-1-install-the-1password-provider-for-pulumi\`,children:\`Step 1: Install the 1Password provider for Pulumi\`}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`with-a-package-manager\`,children:\`With a package manager\`}),\`\n\`,\_jsxs(Tabs,{groupId:\`get-started\`,children:\[\_jsxs(Tab,{title:\`Node.js\`,id:\`node-js\`,children:\[\_jsxs(\_components.p,{children:\[\`To use the provider with JavaScript or TypeScript in Node.js, install using either \`,\_jsx(\_components.code,{children:\`npm\`}),\` or \`,\_jsx(\_components.code,{children:\`yarn\`}),\`:\`\]}),\_jsxs(CodeGroup,{children:\[\_jsx(CodeBlock,{filename:\`npm\`,language:\`shell\`,children:\`npm install @1password/pulumi-onepassword\`}),\_jsx(CodeBlock,{filename:\`yarn\`,language:\`shell\`,children:\`yarn add @1password/pulumi-onepassword\`})\]})\]}),\_jsxs(Tab,{title:\`Python\`,id:\`python\`,children:\[\_jsxs(\_components.p,{children:\[\`To use the provider with Python, install using \`,\_jsx(\_components.code,{children:\`pip\`}),\`:\`\]}),\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`pip\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` install\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` pulumi_onepassword\`})\]}),\`\n\`\]})})})\]}),\_jsxs(Tab,{title:\`Go\`,id:\`go\`,children:\[\_jsxs(\_components.p,{children:\[\`To use the provider with Go, use \`,\_jsx(\_components.code,{children:\`go get\`}),\` to download the latest version:\`\]}),\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`go\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` get\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` github.com/1Password/pulumi-onepassword/sdk/go/...\`})\]}),\`\n\`\]})})})\]})\]}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`with-the-provider-binary\`,children:\`With the provider binary\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`To install the 1Password provider binary, use the \`,\_jsx(\_components.a,{href:\`https://www.pulumi.com/docs/cli/commands/pulumi_plugin/\`,children:\_jsx(\_components.code,{children:\`pulumi plugin\`})}),\` command:\`\]}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`pulumi\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` plugin\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` install\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` resource\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` onepassword\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u003c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`versio\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`n\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --server\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` github://api.github.com/1Password/pulumi-onepassword\`})\]}),\`\n\`\]})})}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`step-2-configure-the-provider-with-your-credentials\`,children:\`Step 2: Configure the provider with your credentials\`}),\`\n\`,\_jsx(\_components.p,{children:\`You can provide your 1Password credentials to Pulumi in the environment or in your Pulumi configuration. Your Pulumi configuration is a good option if you want to store your credentials alongside your Pulumi stack for multi-user access.\`}),\`\n\`,\_jsxs(Tabs,{groupId:\`authentication-method\`,children:\[\_jsx(Tab,{title:\`Service account\`,id:\`service-account-2\`,children:\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\_jsx(\_components.a,{href:\`https://start.1password.com/developer-tools/infrastructure-secrets/serviceaccount/\`,children:\`Create a service account\`}),\` or find the token for an existing service account. Make sure the service account has access to the appropriate vaults and adequate permissions in those vaults.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Provide the token to Pulumi using either an environment variable or your Pulumi configuration.\`}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`environment-variable\`,children:\`Environment variable\`}),\`\n\`,\_jsxs(CodeGroup,{children:\[\_jsx(CodeBlock,{filename:\`Bash, Zsh, sh\`,language:\`shell\`,children:\`export OP_SERVICE_ACCOUNT_TOKEN=\u003cyour-service-account-token\>\`}),\_jsx(CodeBlock,{filename:\`fish\`,language:\`shell\`,children:\`set -x OP_SERVICE_ACCOUNT_TOKEN=\u003cyour-service-account-token\>\`}),\_jsx(CodeBlock,{filename:\`PowerShell\`,language:\`powershell\`,children:\`\$Env:OP_SERVICE_ACCOUNT_TOKEN=\u003cyour-service-account-token\>\`})\]}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`pulumi-configuration\`,children:\`Pulumi configuration\`}),\`\n\`,\_jsx(\_MdxComponentBoundary,{name:\`CodeResult\`,children:\_jsx(CodeResult,{children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`3\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`3\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`pulumi\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` config\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` set\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` pulumi-onepassword:service_account_token\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --secret\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#6E7781\`,\\--shiki-dark\\:\`#6A9955\`},children:\`#code-result\`})}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`Value:\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u003c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`paste\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` token\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` her\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`e\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`})\]}),\`\n\`\]})})})})}),\`\n\`,\_jsxs(\_components.p,{children:\[\`Make sure to pass \`,\_jsx(\_components.code,{children:\`--secret\`}),\` when setting sensitive data.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Install \`,\_jsx(\_components.a,{href:\`/cli/get-started\`,children:\`1Password CLI\`}),\` in your PATH. If you install the CLI outside of your PATH, specify the path to your 1Password CLI binary using either an environment variable or your Pulumi configuration.\`\]}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`environment-variable-2\`,children:\`Environment variable\`}),\`\n\`,\_jsxs(CodeGroup,{children:\[\_jsx(CodeBlock,{filename:\`Bash, Zsh, sh\`,language:\`shell\`,children:\`export OP_CLI_PATH=\u003cpath-to-your-cli-binary\>\`}),\_jsx(CodeBlock,{filename:\`fish\`,language:\`shell\`,children:\`set -x OP_CLI_PATH=\u003cpath-to-your-cli-binary\>\`}),\_jsx(CodeBlock,{filename:\`PowerShell\`,language:\`powershell\`,children:\`\$Env:OP_CLI_PATH=\u003cpath-to-your-cli-binary\>\`})\]}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`pulumi-configuration-2\`,children:\`Pulumi configuration\`}),\`\n\`,\_jsx(\_MdxComponentBoundary,{name:\`CodeResult\`,children:\_jsx(CodeResult,{children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`3\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`3\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`pulumi\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` config\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` set\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` pulumi-onepassword:op_cli_path\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --secret\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#6E7781\`,\\--shiki-dark\\:\`#6A9955\`},children:\`#code-result\`})}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`Value:\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u003c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`paste\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` path\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` to\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` your\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` binary\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` her\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`e\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`})\]}),\`\n\`\]})})})})}),\`\n\`\]}),\`\n\`\]})}),\_jsx(Tab,{title:\`Connect server\`,id:\`connect-server-2\`,\\data-child-tab-ids\\:\`\[\\bash%2C-zsh%2C-sh\\,\\fish\\,\\powershell\\\]\`,children:\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\_jsx(\_components.a,{href:\`/connect/get-started/#step-1\`,children:\`Create a Connect server\`}),\` or find the host URL and token for an existing Connect server.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Provide the host URL and token to Pulumi using either environment variables or your Pulumi configuration.\`}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`environment-variables\`,children:\`Environment variables\`}),\`\n\`,\_jsxs(Tabs,{groupId:\`shells\`,children:\[\_jsxs(Tab,{title:\`Bash, Zsh, sh\`,id:\`bash%2C-zsh%2C-sh\`,children:\[\_jsx(\_components.p,{children:\_jsx(\_components.strong,{children:\`Host URL\`})}),\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#569CD6\`},children:\`export\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` OP_CONNECT_HOST\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`=\u003c\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`your-connect-server-host-url\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`})\]}),\`\n\`\]})})}),\_jsx(\_components.p,{children:\_jsx(\_components.strong,{children:\`Token\`})}),\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#569CD6\`},children:\`export\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` OP_CONNECT_TOKEN\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`=\u003c\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`your-connect-server-token\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`})\]}),\`\n\`\]})})})\]}),\_jsxs(Tab,{title:\`fish\`,id:\`fish\`,children:\[\_jsx(\_components.p,{children:\_jsx(\_components.strong,{children:\`Host URL\`})}),\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`set\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -x\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` OP_CONNECT_HOST=\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\u003c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`your-connect-server-host-ur\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`l\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`})\]}),\`\n\`\]})})}),\_jsx(\_components.p,{children:\_jsx(\_components.strong,{children:\`Token\`})}),\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`set\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -x\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` OP_CONNECT_TOKEN=\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\u003c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`your-connect-server-toke\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`n\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`})\]}),\`\n\`\]})})})\]}),\_jsxs(Tab,{title:\`PowerShell\`,id:\`powershell\`,children:\[\_jsx(\_components.p,{children:\_jsx(\_components.strong,{children:\`Host URL\`})}),\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$Env\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`:\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`OP_CONNECT_HOST\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`=\u003c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`your-connect-server-host-url\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`})\]}),\`\n\`\]})})}),\_jsx(\_components.p,{children:\_jsx(\_components.strong,{children:\`Token\`})}),\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$Env\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`:\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`OP_CONNECT_TOKEN\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`=\u003c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`your-connect-server-token\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`})\]}),\`\n\`\]})})})\]})\]}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`pulumi-configuration-3\`,children:\`Pulumi configuration\`}),\`\n\`,\_jsx(\_components.p,{children:\_jsx(\_components.strong,{children:\`Host URL\`})}),\`\n\`,\_jsx(\_MdxComponentBoundary,{name:\`CodeResult\`,children:\_jsx(CodeResult,{children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`3\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`3\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`pulumi\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` config\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` set\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` pulumi-onepassword:url\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --secret\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#6E7781\`,\\--shiki-dark\\:\`#6A9955\`},children:\`#code-result\`})}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`Value:\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u003c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`paste\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` Connect\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` server\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` host\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` URL\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` her\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`e\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`})\]}),\`\n\`\]})})})})}),\`\n\`,\_jsx(\_components.p,{children:\_jsx(\_components.strong,{children:\`Token\`})}),\`\n\`,\_jsx(\_MdxComponentBoundary,{name:\`CodeResult\`,children:\_jsx(CodeResult,{children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`3\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`3\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`pulumi\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` config\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` set\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` pulumi-onepassword:token\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --secret\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#6E7781\`,\\--shiki-dark\\:\`#6A9955\`},children:\`#code-result\`})}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`Value:\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u003c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`paste\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` Connect\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` server\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` token\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` her\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`e\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`})\]}),\`\n\`\]})})})})}),\`\n\`,\_jsxs(\_components.p,{children:\[\`Make sure to pass \`,\_jsx(\_components.code,{children:\`--secret\`}),\` when setting sensitive data.\`\]}),\`\n\`\]}),\`\n\`\]})}),\_jsx(Tab,{title:\`Account details\`,id:\`account-details-2\`,\\data-child-tab-ids\\:\`\[\\bash%2C-zsh%2C-sh-2\\,\\fish-2\\,\\powershell-2\\,\\bash%2C-zsh%2C-sh-3\\,\\fish-3\\,\\powershell-3\\\]\`,children:\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Find the \`,\_jsx(\_components.a,{href:\`https://support.1password.com/1password-glossary/#sign-in-address\`,children:\`sign-in address\`}),\` or \`,\_jsx(\_components.a,{href:\`/cli/reference/#unique-identifiers-ids\`,children:\`unique identifier\`}),\` for your 1Password account.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Provide your account sign-in address or identifier to Pulumi using an environment variable or your Pulumi configuration.\`}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`environment-variable-3\`,children:\`Environment variable\`}),\`\n\`,\_jsxs(Tabs,{groupId:\`shells\`,children:\[\_jsx(Tab,{title:\`Bash, Zsh, sh\`,id:\`bash%2C-zsh%2C-sh-2\`,children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#569CD6\`},children:\`export\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` OP_ACCOUNT\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`=\u003c\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`your-account-details\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`})\]}),\`\n\`\]})})})}),\_jsx(Tab,{title:\`fish\`,id:\`fish-2\`,children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`set\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -x\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` OP_ACCOUNT=\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\u003c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`your-account-detail\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`s\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`})\]}),\`\n\`\]})})})}),\_jsx(Tab,{title:\`PowerShell\`,id:\`powershell-2\`,children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`powershell\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`powershell\`,children:\_jsxs(\_components.code,{language:\`powershell\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`Env:\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`OP_ACCOUNT\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`=\u003c\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`your\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`-\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`account\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`-\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`details\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`})\]}),\`\n\`\]})})})})\]}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`pulumi-configuration-4\`,children:\`Pulumi configuration\`}),\`\n\`,\_jsx(\_MdxComponentBoundary,{name:\`CodeResult\`,children:\_jsx(CodeResult,{children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`3\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`3\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`pulumi\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` config\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` set\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` pulumi-onepassword:account\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --secret\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#6E7781\`,\\--shiki-dark\\:\`#6A9955\`},children:\`#code-result\`})}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`Value:\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u003c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`paste\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` your\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` account\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` sign-in\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` address\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` or\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` unique\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` identifier\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` her\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`e\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`})\]}),\`\n\`\]})})})})}),\`\n\`,\_jsxs(\_components.p,{children:\[\`Make sure to pass \`,\_jsx(\_components.code,{children:\`--secret\`}),\` when setting sensitive data.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Install \`,\_jsx(\_components.a,{href:\`/cli/get-started\`,children:\`1Password CLI\`}),\` in your PATH. If you install the CLI outside of your PATH, specify the path to your 1Password CLI binary using either an environment variable or your Pulumi configuration.\`\]}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`environment-variable-4\`,children:\`Environment variable\`}),\`\n\`,\_jsxs(Tabs,{groupId:\`shells\`,children:\[\_jsx(Tab,{title:\`Bash, Zsh, sh\`,id:\`bash%2C-zsh%2C-sh-3\`,children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#569CD6\`},children:\`export\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` OP_CLI_PATH\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`=\u003c\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`path-to-your-cli-binary\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`})\]}),\`\n\`\]})})})}),\_jsx(Tab,{title:\`fish\`,id:\`fish-3\`,children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`set\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -x\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` OP_CLI_PATH=\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\u003c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`path-to-your-cli-binar\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`y\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`})\]}),\`\n\`\]})})})}),\_jsx(Tab,{title:\`PowerShell\`,id:\`powershell-3\`,children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`powershell\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`powershell\`,children:\_jsxs(\_components.code,{language:\`powershell\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`Env:\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`OP_CLI_PATH\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`=\u003c\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`path\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`-\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`to\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`-\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`your\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`-\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`cli\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`-\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`binary\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`})\]}),\`\n\`\]})})})})\]}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`pulumi-configuration-5\`,children:\`Pulumi configuration\`}),\`\n\`,\_jsx(\_MdxComponentBoundary,{name:\`CodeResult\`,children:\_jsx(CodeResult,{children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`3\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`3\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`pulumi\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` config\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` set\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` pulumi-onepassword:op_cli_path\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --secret\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#6E7781\`,\\--shiki-dark\\:\`#6A9955\`},children:\`#code-result\`})}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`Value:\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u003c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`paste\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` path\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` to\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` your\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` binary\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` her\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`e\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`})\]}),\`\n\`\]})})})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`To use Touch ID, Windows Hello, or another system authentication option with the provider, \`,\_jsx(\_components.a,{href:\`/cli/get-started#step-2-turn-on-the-1password-desktop-app-integration\`,children:\`turn on the 1Password CLI app integration\`}),\`.\`\]}),\`\n\`\]}),\`\n\`\]})})\]}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`step-3-use-the-provider\`,children:\`Step 3: Use the provider\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`See \`,\_jsx(\_components.a,{href:\`https://www.pulumi.com/registry/packages/onepassword/\`,children:\`Pulumi’s documentation\`}),\` to learn how to access and manage your items using the 1Password provider.\`\]}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`reference\`,children:\`Reference\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`You can use either \`,\_jsx(\_components.a,{href:\`https://www.pulumi.com/docs/concepts/config/\`,children:\`Pulumi configuration keys\`}),\` or environment variables to provide your 1Password credentials to Pulumi.\`\]}),\`\n\`,\_jsxs(Table,{children:\[\_jsx(\_components.thead,{children:\_jsxs(\_components.tr,{children:\[\_jsx(\_components.th,{children:\`Configuration key\`}),\_jsx(\_components.th,{children:\`Environment variable\`}),\_jsx(\_components.th,{children:\`Description\`}),\_jsx(\_components.th,{children:\`Authentication method\`})\]})}),\_jsxs(\_components.tbody,{children:\[\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`pulumi-onepassword:service_account_token\`})}),\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`OP_SERVICE_ACCOUNT_TOKEN\`})}),\_jsxs(\_components.td,{children:\[\`The string value of your \`,\_jsx(\_components.a,{href:\`/service-accounts/get-started\`,children:\`1Password Service Account\`}),\` token.\`\]}),\_jsx(\_components.td,{children:\`Service account\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`pulumi-onepassword:url\`})}),\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`OP_CONNECT_HOST\`})}),\_jsxs(\_components.td,{children:\[\`The URL where your \`,\_jsx(\_components.a,{href:\`/connect/\`,children:\`1Password Connect Server\`}),\` can be found. For example: \`,\_jsx(\_components.code,{children:\`http://localhost:8080\`}),\`.\`\]}),\_jsx(\_components.td,{children:\`Connect server\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`pulumi-onepassword:token\`})}),\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`OP_CONNECT_TOKEN\`})}),\_jsxs(\_components.td,{children:\[\`The string value of your \`,\_jsx(\_components.a,{href:\`/connect/concepts#connect-server-access-token\`,children:\`Connect server token\`}),\`.\`\]}),\_jsx(\_components.td,{children:\`Connect server\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`pulumi-onepassword:account\`})}),\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`OP_ACCOUNT\`})}),\_jsxs(\_components.td,{children:\[\`A 1Password account \`,\_jsx(\_components.a,{href:\`https://support.1password.com/1password-glossary/#sign-in-address\`,children:\`sign-in address\`}),\` or \`,\_jsx(\_components.a,{href:\`/cli/reference/#unique-identifiers-ids\`,children:\`unique identifier\`}),\`.\`\]}),\_jsx(\_components.td,{children:\`Account details\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`pulumi-onepassword:op_cli_path\`})}),\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`OP_CLI_PATH\`})}),\_jsxs(\_components.td,{children:\[\`The \`,\_jsx(\_components.a,{href:\`/cli/config-directories\`,children:\`path to your 1Password CLI binary\`}),\`. Only required if 1Password CLI binary is located outside of your PATH.\`\]}),\_jsx(\_components.td,{children:\_jsxs(\`ul\`,{children:\[\_jsx(\`li\`,{children:\`Service account\`}),\_jsx(\`li\`,{children:\`Account details\`})\]})})\]})\]})\]})\]})}function MDXContent(props={}){const{wrapper:MDXLayout}={...\_provideComponents(),...props.components};return MDXLayout?\_jsx(MDXLayout,{...props,children:\_jsx(\_createMdxContent,{...props})}):\_createMdxContent(props)}return{CodeResult,Small,default:MDXContent};function \_missingMdxReference(id,component){throw new Error(\`Expected \`+(component?\`component\`:\`object\`)+\\ \`\\+id+\\\` to be defined: you likely forgot to import, pass, or provide it.\\)}","frontmatter":{},"scope":{"config":{},"pageMetadata":{"title":"Use the 1Password provider for Pulumi with Connect","sidebarTitle":"Pulumi","og:description":"Use a 1Password Connect server to access and manage items in your vaults with the 1Password provider for Pulumi.","description":null,"href":"/connect/pulumi"}}},"mdxSourceWithNoJs":null,"noJsSplices":\[\[146,3043,")=\>null;const Small="\]\]},"mdxExtracts":{"tableOfContents":\[{"title":"Requirements","slug":"requirements","depth":2,"children":\[\]},{"title":"Step 1: Install the 1Password provider for Pulumi","slug":"step-1-install-the-1password-provider-for-pulumi","depth":2,"children":\[{"title":"With a package manager","slug":"with-a-package-manager","depth":3,"children":\[\]},{"title":"With the provider binary","slug":"with-the-provider-binary","depth":3,"children":\[\]}\]},{"title":"Step 2: Configure the provider with your credentials","slug":"step-2-configure-the-provider-with-your-credentials","depth":2,"children":\[{"title":"Environment variable","slug":"environment-variable","depth":4,"children":\[\],"tabId":"service-account-2"},{"title":"Pulumi configuration","slug":"pulumi-configuration","depth":4,"children":\[\],"tabId":"service-account-2"},{"title":"Environment variable","slug":"environment-variable-2","depth":4,"children":\[\],"tabId":"service-account-2"},{"title":"Pulumi configuration","slug":"pulumi-configuration-2","depth":4,"children":\[\],"tabId":"service-account-2"},{"title":"Environment variables","slug":"environment-variables","depth":4,"children":\[\],"tabId":"connect-server-2"},{"title":"Pulumi configuration","slug":"pulumi-configuration-3","depth":4,"children":\[\],"tabId":"connect-server-2"},{"title":"Environment variable","slug":"environment-variable-3","depth":4,"children":\[\],"tabId":"account-details-2"},{"title":"Pulumi configuration","slug":"pulumi-configuration-4","depth":4,"children":\[\],"tabId":"account-details-2"},{"title":"Environment variable","slug":"environment-variable-4","depth":4,"children":\[\],"tabId":"account-details-2"},{"title":"Pulumi configuration","slug":"pulumi-configuration-5","depth":4,"children":\[\],"tabId":"account-details-2"}\]},{"title":"Step 3: Use the provider","slug":"step-3-use-the-provider","depth":2,"children":\[\]},{"title":"Reference","slug":"reference","depth":2,"children":\[\]}\],"codeExamples":{}},"jsLinks":\["/\_mintlify/custom/ab-634991b8/5ebc0d10523e8210/static/js/analytics.js","/\_mintlify/custom/ab-634991b8/5bb7437b1c9dcb44/static/js/gtag-prod-sst.js","/\_mintlify/custom/ab-634991b8/ee8ea0eeb20ecd1e/static/js/gtag-sst.js","/\_mintlify/custom/ab-634991b8/f2b239f3d459dc67/api-sdk-terms-notice.js","/\_mintlify/custom/ab-634991b8/3604035e212f8294/homepage-card-icons.js"\],"dynamicCss":".mint-mb-4 {\n margin-bottom: 1rem\n}\n.mint-flex {\n display: flex\n}\n.mint-w-full {\n width: 100%\n}\n.mint-items-center {\n align-items: center\n}\n.mint-gap-1 {\n gap: 0.25rem\n}\n.mint-overflow-hidden {\n overflow: hidden\n}\n.mint-border-t {\n border-top-width: 1px\n}\n.mint-border-t-0 {\n border-top-width: 0px\n}\n.mint-border-\\\[var\\(--op-border-ui\\)\\\] {\n border-color: var(--op-border-ui)\n}\n.mint-bg-gray-100\\/80 {\n background-color: rgb(243 244 246 / 0.8)\n}\n.mint-px-4 {\n padding-left: 1rem;\n padding-right: 1rem\n}\n.mint-py-2\\.5 {\n padding-top: 0.625rem;\n padding-bottom: 0.625rem\n}\n.mint-text-left {\n text-align: left\n}\n.mint-text-\\\[14px\\\] {\n font-size: 14px\n}\n.mint-font-medium {\n font-weight: 500\n}\n.mint-text-gray-600 {\n --tw-text-opacity: 1;\n color: rgb(75 85 99 / var(--tw-text-opacity, 1))\n}\n.mint-transition-all {\n transition-property: all;\n transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);\n transition-duration: 150ms\n}\n.mint-duration-150 {\n transition-duration: 150ms\n}\n.hover\\:mint-bg-gray-200\\/60:hover {\n background-color: rgb(229 231 235 / 0.6)\n}\n.hover\\:mint-text-gray-800:hover {\n --tw-text-opacity: 1;\n color: rgb(31 41 55 / var(--tw-text-opacity, 1))\n}\n.dark\\:mint-border-\\\[var\\(--op-border-ui-dark\\)\\\]:is(.dark \*) {\n border-color: var(--op-border-ui-dark)\n}\n.dark\\:mint-bg-gray-800\\/80:is(.dark \*) {\n background-color: rgb(31 41 55 / 0.8)\n}\n.dark\\:mint-text-gray-400:is(.dark \*) {\n --tw-text-opacity: 1;\n color: rgb(156 163 175 / var(--tw-text-opacity, 1))\n}\n.dark\\:hover\\:mint-bg-gray-700\\/60:hover:is(.dark \*) {\n background-color: rgb(55 65 81 / 0.6)\n}\n.dark\\:hover\\:mint-text-gray-200:hover:is(.dark \*) {\n --tw-text-opacity: 1;\n color: rgb(229 231 235 / var(--tw-text-opacity, 1))\n}\n.\\\[\\\u0026\\\>\\\*\\\]\\:\\!mint-mb-0\>\* {\n margin-bottom: 0px !important\n}\n.\\\[\\\u0026\\\>\\\*\\\]\\:\\!mint-mt-0\>\* {\n margin-top: 0px !important\n}\n.\\\[\\\u0026\\\>\\\*\\\]\\:\\!mint-rounded-b-none\>\* {\n border-bottom-right-radius: 0px !important;\n border-bottom-left-radius: 0px !important\n}\n.\\\[\\\u0026\\\>\\\*\\\]\\:\\!mint-rounded-t-none\>\* {\n border-top-left-radius: 0px !important;\n border-top-right-radius: 0px !important\n}","subdomain":"ab-634991b8","siteName":"1Password Developer","title":"Use the 1Password provider for Pulumi with Connect - 1Password Developer","relatedPagesConfig":{"enabled":true,"limit":3,"mode":"automatic"},"contextualStarterQuestions":\[{"\_id":"6ae4c9372086b3fba440c47d","deploymentId":"68a8af9a517ab813d3b84097","questionText":"How do I authenticate with 1Password?","status":"active","generatedBy":"contextual","path":"connect/pulumi","createdAt":"2026-10-30T16:43:35.785Z","updatedAt":"2026-10-30T16:43:35.785Z","\_\_v":0},{"\_id":"6ae4c9372086b3fba440c47b","deploymentId":"68a8af9a517ab813d3b84097","questionText":"How do I set up 1Password with Pulumi?","status":"active","generatedBy":"contextual","path":"connect/pulumi","createdAt":"2026-10-30T16:43:35.785Z","updatedAt":"2026-10-30T16:43:35.785Z","\_\_v":0},{"\_id":"6ae4c9372086b3fba440c47c","deploymentId":"68a8af9a517ab813d3b84097","questionText":"What is the Connect provider?","status":"active","generatedBy":"contextual","path":"connect/pulumi","createdAt":"2026-10-30T16:43:35.785Z","updatedAt":"2026-10-30T16:43:35.785Z","\_\_v":0}\],"navMaps":{"firstHrefInVersion":{},"firstHrefInLanguage":{}},"lastModified":"2026-10-30T16:43:20.903Z","originalFileLocation":"connect/pulumi.mdx"},"headHtml":"\u003cscript data-mint-head\>(function(){var d=document.documentElement,p=null;if(!p){try{p=localStorage.getItem(\\isDarkMode\\)}catch(e){}if(p==='true')p='dark';else if(p==='false')p='light';if(p!=='light'\u0026\u0026p!=='dark'\u0026\u0026p!=='system')p=\\system\\}var r=p==='system'?(matchMedia(\\(prefers-color-scheme: dark)\\).matches?'dark':'light'):p;d.classList.remove(r==='dark'?'light':'dark');d.classList.add(r);d.setAttribute(\\data-theme-preference\\,p)})();\u003c/script\>\u003cmeta data-mint-head name=\\application-name\\ content=\\1Password Developer\\\>\u003cmeta data-mint-head name=\\generator\\ content=\\Mintlify\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\192x192\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/android-chrome-192x192.png\\ media=\\(prefers-color-scheme: light)\\\>\u003clink data-mint-head rel=\\apple-touch-icon\\ type=\\image/png\\ sizes=\\180x180\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/apple-touch-icon.png\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\16x16\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/favicon-16x16.png\\ media=\\(prefers-color-scheme: light)\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\32x32\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/favicon-32x32.png\\ media=\\(prefers-color-scheme: light)\\\>\u003clink data-mint-head rel=\\shortcut icon\\ type=\\image/x-icon\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/favicon.ico\\ media=\\(prefers-color-scheme: light)\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\192x192\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon-dark/android-chrome-192x192.png\\ media=\\(prefers-color-scheme: dark)\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\16x16\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon-dark/favicon-16x16.png\\ media=\\(prefers-color-scheme: dark)\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\32x32\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon-dark/favicon-32x32.png\\ media=\\(prefers-color-scheme: dark)\\\>\u003clink data-mint-head rel=\\shortcut icon\\ type=\\image/x-icon\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon-dark/favicon.ico\\ media=\\(prefers-color-scheme: dark)\\\>\u003cmeta data-mint-head property=\\og:title\\ content=\\Use the 1Password provider for Pulumi with Connect - 1Password Developer\\\>\u003cmeta data-mint-head property=\\og:description\\ content=\\Use a 1Password Connect server to access and manage items in your vaults with the 1Password provider for Pulumi.\\\>\u003cmeta data-mint-head property=\\og:site_name\\ content=\\1Password Developer\\\>\u003cmeta data-mint-head property=\\og:url\\ content=\\https://www.1password.dev/connect/pulumi\\\>\u003cmeta data-mint-head property=\\og:type\\ content=\\website\\\>\u003cmeta data-mint-head property=\\og:image\\ content=\\https://ab-634991b8.mintlify.app/\_mintlify/api/og/v2?division=Integrations\u0026amp;title=Use+the+1Password+provider+for+Pulumi+with+Connect\u0026amp;theme=0e8ac3e29b6f66038c473d59\u0026amp;signature=97e3ac69127ed6aaa10f72709649dc98cd898593a34b7d12582a8cbdc1fdf1e1\\\>\u003cmeta data-mint-head property=\\og:image:width\\ content=\\1200\\\>\u003cmeta data-mint-head property=\\og:image:height\\ content=\\630\\\>\u003cmeta data-mint-head name=\\twitter:card\\ content=\\summary_large_image\\\>\u003cmeta data-mint-head name=\\twitter:title\\ content=\\Use the 1Password provider for Pulumi with Connect - 1Password Developer\\\>\u003cmeta data-mint-head name=\\twitter:description\\ content=\\Use a 1Password Connect server to access and manage items in your vaults with the 1Password provider for Pulumi.\\\>\u003cmeta data-mint-head name=\\twitter:image\\ content=\\https://ab-634991b8.mintlify.app/\_mintlify/api/og/v2?division=Integrations\u0026amp;title=Use+the+1Password+provider+for+Pulumi+with+Connect\u0026amp;theme=0e8ac3e29b6f66038c473d59\u0026amp;signature=97e3ac69127ed6aaa10f72709649dc98cd898593a34b7d12582a8cbdc1fdf1e1\\\>\u003cmeta data-mint-head name=\\twitter:image:width\\ content=\\1200\\\>\u003cmeta data-mint-head name=\\twitter:image:height\\ content=\\630\\\>\u003cmeta data-mint-head name=\\msapplication-config\\ content=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/browserconfig.xml\\\>\u003cmeta data-mint-head name=\\apple-mobile-web-app-title\\ content=\\1Password Developer\\\>\u003cmeta data-mint-head name=\\msapplication-TileColor\\ content=\\#104ebb\\\>\u003cmeta data-mint-head name=\\google-site-verification\\ content=\\YserOhXnJUjFfIZ4K3qgxkVSlQZQdXtIbBiKzZ35Nvs\\\>\u003clink data-mint-head rel=\\canonical\\ href=\\https://www.1password.dev/connect/pulumi\\\>\u003clink data-mint-head rel=\\alternate\\ type=\\application/xml\\ href=\\/sitemap.xml\\\>\u003clink data-mint-head rel=\\alternate\\ type=\\text/markdown\\ href=\\/connect/pulumi.md\\\>\u003cscript data-mint-head type=\\application/ld+json\\\>{\\@context\\:\\https://schema.org\\,\\@graph\\:\[{\\@type\\:\\Organization\\,\\@id\\:\\https://www.1password.dev/#organization\\,\\name\\:\\1Password Developer\\,\\url\\:\\https://www.1password.dev\\,\\logo\\:{\\@type\\:\\ImageObject\\,\\url\\:\\https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max\u0026auto=format\u0026n=lHrfVfSCdefFz8U5\u0026q=85\u0026s=29d1c9358888a723dddd8a89a3b6f71d\\}},{\\@type\\:\\WebSite\\,\\@id\\:\\https://www.1password.dev#website\\,\\name\\:\\1Password Developer\\,\\url\\:\\https://www.1password.dev\\,\\publisher\\:{\\@id\\:\\https://www.1password.dev/#organization\\}},{\\@type\\:\\WebPage\\,\\@id\\:\\https://www.1password.dev/connect/pulumi#webpage\\,\\url\\:\\https://www.1password.dev/connect/pulumi\\,\\name\\:\\Use the 1Password provider for Pulumi with Connect\\,\\dateModified\\:\\2026-10-30T16:43:20.903Z\\,\\isPartOf\\:{\\@id\\:\\https://www.1password.dev#website\\},\\breadcrumb\\:{\\@id\\:\\https://www.1password.dev/connect/pulumi#breadcrumb\\}},{\\@type\\:\\BreadcrumbList\\,\\@id\\:\\https://www.1password.dev/connect/pulumi#breadcrumb\\,\\itemListElement\\:\[{\\@type\\:\\ListItem\\,\\position\\:1,\\name\\:\\Secrets Automation\\,\\item\\:\\https://www.1password.dev/secrets-automation\\},{\\@type\\:\\ListItem\\,\\position\\:2,\\name\\:\\Connect server\\,\\item\\:\\https://www.1password.dev/connect\\},{\\@type\\:\\ListItem\\,\\position\\:3,\\name\\:\\Integrations\\,\\item\\:\\https://www.1password.dev/connect/ansible\\},{\\@type\\:\\ListItem\\,\\position\\:4,\\name\\:\\Use the 1Password provider for Pulumi with Connect\\,\\item\\:\\https://www.1password.dev/connect/pulumi\\}\]},{\\@type\\:\[\\Article\\,\\TechArticle\\\],\\@id\\:\\https://www.1password.dev/connect/pulumi#article\\,\\headline\\:\\Use the 1Password provider for Pulumi with Connect\\,\\name\\:\\Use the 1Password provider for Pulumi with Connect\\,\\url\\:\\https://www.1password.dev/connect/pulumi\\,\\mainEntityOfPage\\:{\\@id\\:\\https://www.1password.dev/connect/pulumi#webpage\\},\\dateModified\\:\\2026-10-30T16:43:20.903Z\\,\\publisher\\:{\\@id\\:\\https://www.1password.dev/#organization\\},\\isPartOf\\:{\\@id\\:\\https://www.1password.dev#website\\}}\]}\u003c/script\>","siteName":"1Password Developer","nav":{"global":null,"tabs":\[{"tab":"Get Started","pages":\[{"title":"Get Started","href":"/get-started"}\]},{"tab":"Tutorials","pages":\[{"title":"Tutorials","href":"/tutorials"}\]},{"tab":"Security for AI","pages":\[{"title":"Security for AI","href":"/security-for-ai"}\]},{"tab":"Environments","pages":\[{"title":"Environments","href":"/environments"}\]},{"tab":"SSH \u0026 Git","pages":\[{"title":"SSH \u0026 Git","href":"/ssh"}\]},{"tab":"CLI","pages":\[{"title":"CLI","href":"/cli"}\]},{"tab":"SDKs","pages":\[{"title":"SDKs","href":"/sdks"}\]},{"tab":"More Tools","menu":\[{"item":"VS Code","icon":"laptop","pages":\[{"title":"VS Code","href":"/vscode"}\]},{"item":"Shell Plugins","icon":"puzzle-piece","pages":\[{"title":"Shell Plugins","href":"/cli/shell-plugins"}\]},{"item":"Integrations","icon":"puzzle","pages":\[{"title":"Integrations","href":"/integrations"}\]},{"item":"Secrets Automation","icon":"tablet-screen","groups":\[{"group":"Secrets Automation","pages":\[{"title":"1Password Secrets Automation","sidebarTitle":"Overview","href":"/secrets-automation"},{"group":"Service accounts","pages":\[{"title":"1Password Service Accounts","sidebarTitle":"Overview","href":"/service-accounts"},{"title":"Get started with 1Password Service Accounts","sidebarTitle":"Get started","href":"/service-accounts/get-started"},{"title":"Manage service accounts","sidebarTitle":"Manage","href":"/service-accounts/manage-service-accounts"},{"title":"Use service accounts with 1Password CLI","sidebarTitle":"Use with 1Password CLI","href":"/service-accounts/use-with-1password-cli"},{"title":"Use service accounts with 1Password SDKs","sidebarTitle":"Use with 1Password SDKs","href":"/service-accounts/setup-tutorial"},{"group":"Integrations","pages":\[{"title":"Use CI/CD integrations with 1Password service accounts","sidebarTitle":"CI/CD integrations","href":"/secrets-automation/ci-cd"},{"title":"Use Kubernetes integrations with 1Password service accounts","sidebarTitle":"Kubernetes integrations","href":"/secrets-automation/k8s"},{"title":"Postman","url":"https://learning.postman.com/docs/sending-requests/postman-vault/1password/","href":"/service-accounts/postman"},{"title":"Use the 1Password provider for Pulumi with service accounts","sidebarTitle":"Pulumi","href":"/service-accounts/pulumi"},{"title":"Pulumi ESC","url":"https://www.pulumi.com/docs/esc/integrations/dynamic-secrets/1password-secrets/","href":"/service-accounts/pulumi-esc"},{"title":"Use the 1Password Terraform provider with service accounts","sidebarTitle":"Terraform","href":"/service-accounts/terraform"}\]},{"title":"Service account rate limits","sidebarTitle":"Rate limits","href":"/service-accounts/rate-limits"},{"sidebarTitle":"Security","title":"1Password Service Account security","href":"/service-accounts/security"}\]},{"group":"Connect server","pages":\[{"title":"1Password Connect","sidebarTitle":"Overview","href":"/connect"},{"title":"Get started with a 1Password Connect server","sidebarTitle":"Get started","href":"/connect/get-started"},{"title":"Manage Connect servers","sidebarTitle":"Manage","href":"/connect/manage-connect"},{"title":"Configure your Connect server","sidebarTitle":"Configuration","href":"/connect/server-configuration"},{"title":"Use 1Password CLI with a Connect server","sidebarTitle":"Use with 1Password CLI","href":"/connect/cli"},{"group":"SDKs","expanded":true,"pages":\[{"title":"Go","url":"https://github.com/1Password/connect-sdk-go","href":"/connect/sdks/languages/golang"},{"title":"Node.js","url":"https://github.com/1Password/connect-sdk-js","href":"/connect/sdks/languages/javascript"},{"title":"Python","url":"https://github.com/1Password/connect-sdk-python","href":"/connect/sdks/languages/python"}\]},{"group":"Integrations","pages":\[{"title":"Ansible","href":"/connect/ansible"},{"title":"Deploy 1Password Connect Server on AWS ECS Fargate","sidebarTitle":"AWS ECS Fargate","href":"/connect/aws"},{"title":"Use CI/CD integrations with a 1Password Connect server","sidebarTitle":"CI/CD integrations","href":"/connect/ci-cd"},{"title":"Hashicorp Vault backend","url":"https://github.com/1Password/vault-plugin-secrets-onepassword","href":"/connect/hashicorp"},{"title":"Use Kubernetes integrations with a 1Password Connect server","sidebarTitle":"Kubernetes integrations","description":null,"href":"/connect/k8s"},{"title":"Use the 1Password provider for Pulumi with Connect","sidebarTitle":"Pulumi","href":"/connect/pulumi"},{"title":"Use the 1Password Terraform provider with Connect","sidebarTitle":"Terraform","description":null,"href":"/connect/terraform"}\]},{"group":"Reference","pages":\[{"group":"API Reference","pages":\[{"title":"1Password Connect Server API reference","sidebarTitle":"Overview","href":"/connect/api-reference"},{"title":"Get all Vaults","deprecated":null,"version":null,"sidebarTitle":"Get vaults","openapi":"/openapi/connect_server_api.yaml get /vaults","href":"/connect/api-reference/get-vaults"},{"title":"Get Vault details and metadata","deprecated":null,"version":null,"sidebarTitle":"Get vault by id","openapi":"/openapi/connect_server_api.yaml get /vaults/{vaultUuid}","href":"/connect/api-reference/get-vault-by-id"},{"title":"Get all items for inside a Vault","deprecated":null,"version":null,"sidebarTitle":"Get vault items","openapi":"/openapi/connect_server_api.yaml get /vaults/{vaultUuid}/items","href":"/connect/api-reference/get-vault-items"},{"title":"Create a new Item","deprecated":null,"version":null,"sidebarTitle":"Create vault item","openapi":"/openapi/connect_server_api.yaml post /vaults/{vaultUuid}/items","href":"/connect/api-reference/create-vault-item"},{"title":"Get the details of an Item","deprecated":null,"version":null,"sidebarTitle":"Get vault item by id","openapi":"/openapi/connect_server_api.yaml get /vaults/{vaultUuid}/items/{itemUuid}","href":"/connect/api-reference/get-vault-item-by-id"},{"title":"Update an Item","deprecated":null,"version":null,"sidebarTitle":"Update vault item","openapi":"/openapi/connect_server_api.yaml put /vaults/{vaultUuid}/items/{itemUuid}","href":"/connect/api-reference/update-vault-item"},{"title":"Delete an Item","deprecated":null,"version":null,"sidebarTitle":"Delete vault item","openapi":"/openapi/connect_server_api.yaml delete /vaults/{vaultUuid}/items/{itemUuid}","href":"/connect/api-reference/delete-vault-item"},{"title":"Update a subset of Item attributes","deprecated":null,"version":null,"sidebarTitle":"Patch vault item","openapi":"/openapi/connect_server_api.yaml patch /vaults/{vaultUuid}/items/{itemUuid}","href":"/connect/api-reference/patch-vault-item"},{"title":"Get all the files inside an Item","deprecated":null,"version":null,"sidebarTitle":"Get item files","openapi":"/openapi/connect_server_api.yaml get /vaults/{vaultUuid}/items/{itemUuid}/files","href":"/connect/api-reference/get-item-files"},{"title":"Get the details of a File","deprecated":null,"version":null,"sidebarTitle":"Get item file by id","openapi":"/openapi/connect_server_api.yaml get /vaults/{vaultUuid}/items/{itemUuid}/files/{fileUuid}","href":"/connect/api-reference/get-item-file-by-id"},{"title":"Get the content of a File","deprecated":null,"version":null,"sidebarTitle":"Download item file by id","openapi":"/openapi/connect_server_api.yaml get /vaults/{vaultUuid}/items/{itemUuid}/files/{fileUuid}/content","href":"/connect/api-reference/download-item-file-by-id"},{"title":"Retrieve a list of API Requests that have been made.","deprecated":null,"version":null,"sidebarTitle":"Get api activity","openapi":"/openapi/connect_server_api.yaml get /activity","href":"/connect/api-reference/get-api-activity"},{"title":"Ping the server for liveness","deprecated":null,"version":null,"sidebarTitle":"Get heartbeat","openapi":"/openapi/connect_server_api.yaml get /heartbeat","href":"/connect/api-reference/get-heartbeat"},{"title":"Get state of the server and its dependencies.","deprecated":null,"version":null,"sidebarTitle":"Get server health","openapi":"/openapi/connect_server_api.yaml get /health","href":"/connect/api-reference/get-server-health"},{"title":"Query server for exposed Prometheus metrics","deprecated":null,"version":null,"sidebarTitle":"Get prometheus metrics","openapi":"/openapi/connect_server_api.yaml get /metrics","href":"/connect/api-reference/get-prometheus-metrics"}\]},{"title":"Connect concepts","sidebarTitle":"Concepts","href":"/connect/concepts"},{"title":"About 1Password Connect Server security","sidebarTitle":"Security","href":"/connect/security"}\]}\]}\]}\]},{"item":"Events API","icon":"sensor-triangle-exclamation","pages":\[{"title":"Events API","href":"/events-api"}\]},{"item":"Users API","icon":"id-badge","pages":\[{"title":"Users API","href":"/users-api"}\]},{"item":"SaaS Manager API","icon":"chart-line","pages":\[{"title":"SaaS Manager API","href":"/saas-manager-api"}\]},{"item":"Partnership API","icon":"users","pages":\[{"title":"Partnership API","href":"/partnership-api/reference"}\]},{"item":"Accounts API","icon":"user-gear","pages":\[{"title":"Accounts API","href":"/accounts-api"}\]},{"item":"Web Development","icon":"code","pages":\[{"title":"Web Development","href":"/web/add-1password-button-website"}\]},{"item":"Developer Watchtower","icon":"tower-control","pages":\[{"title":"Developer Watchtower","href":"/watchtower"}\]}\]},{"tab":"Agentic Autofill partner guide","hidden":true,"pages":\[{"title":"Agentic Autofill partner guide","href":"/agentic-autofill/partners"}\]}\]},"basePath":"","title":"Use the 1Password provider for Pulumi with Connect - 1Password Developer","buildId":"dpl_DeHjVRGfFnhYQwHnfC2pjeXXv8h9","deploymentId":"dpl_DeHjVRGfFnhYQwHnfC2pjeXXv8h9","dynamics":\["10e4515597"\],"chunks":\["BannerMarkdown-CX_qQQOL.js","dist-BTZUMDnx.js","lib-DuNMoZ05.js","lib-B8HbPgcC.js","clsx-xpJZXxdP.js","html-void-elements-mCSPHezU.js","katex-YMM-FMeD.js","marked.esm-CZWythHk.js"\]}
