> Source: https://www.1password.dev/cli/get-started/


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


CLI


Get started with 1Password CLI


<a href="/get-started" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Get Started</a>


<a href="/tutorials" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Tutorials</a>


<a href="/security-for-ai" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Security for AI</a>


<a href="/environments" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Environments</a>


<a href="/ssh" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SSH &amp; Git</a>


<a href="/cli" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200 [text-shadow:-0.2px_0_0_currentColor,0.2px_0_0_currentColor]" data-active="true" aria-current="location">CLI</a>


<a href="/sdks" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SDKs</a>


More Tools


CLI


# Get started with 1Password CLI


## New to 1Password developer tools?


## 


<a href="#step-1-install-1password-cli" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Requirements


- <div id="mac">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Mac">

  Mac

  </div>

  </div>

- <div id="windows">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Windows">

  Windows

  </div>

  </div>

- <div id="linux">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Linux">

  Linux

  </div>

  </div>


- <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">1Password subscription</a>
- <a href="https://1password.com/downloads/mac" class="link" target="_blank" rel="noreferrer">1Password for Mac</a>\*
- macOS Big Sur 11.0.0 or later


- <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">1Password subscription</a>
- <a href="https://1password.com/downloads/windows" class="link" target="_blank" rel="noreferrer">1Password for Windows</a>


- <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">1Password subscription</a>
- <a href="https://1password.com/downloads/linux" class="link" target="_blank" rel="noreferrer">1Password for Linux</a>\*
- <a href="https://github.com/polkit-org/polkit" class="link" target="_blank" rel="noreferrer">PolKit</a>\*
- A PolKit authentication agent running\*


- <div id="mac-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Mac">

  Mac

  </div>

  </div>

- <div id="windows-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Windows">

  Windows

  </div>

  </div>

- <div id="linux-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Linux">

  Linux

  </div>

  </div>


- <div id="homebrew">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-homebrew">

  homebrew

  </div>

  </div>

- <div id="manual">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Manual">

  Manual

  </div>

  </div>


1.  <span data-as="p">Use <a href="https://brew.sh/" class="link" target="_blank" rel="noreferrer">Homebrew</a> to install 1Password CLI:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_3qm4mc95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_3sm4mc95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_3um4mc95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_364mc95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    brew install 1password-cli
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>
2.  <span data-as="p">Check that 1Password CLI installed successfully:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_3qm8mc95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_3sm8mc95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_3um8mc95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_368mc95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op --version
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>


1.  <span data-as="p">Download <a href="https://app-updates.agilebits.com/product_history/CLI2" class="link" target="_blank" rel="noreferrer">the latest release of 1Password CLI</a>.  
    <span class="small">Learn how to <a href="/cli/verify/" class="link">verify its authenticity</a>.</span></span>

2.  - **Package file**: Open `op.pkg` and install 1Password CLI in the default location (`usr/local/bin`).
    - **ZIP file**: Open `op.zip` and unzip the file, then move `op` to `usr/local/bin`.

3.  <span data-as="p">Check that 1Password CLI was installed successfully:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_3qmdac95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_3smdac95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_3umdac95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_36dac95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op --version
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>


- <div id="winget">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-winget">

  winget

  </div>

  </div>

- <div id="manual-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Manual">

  Manual

  </div>

  </div>


1.  <span data-as="p">To install 1Password CLI with winget:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="powershell">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_ulh6k95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_v5h6k95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_vlh6k95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_ph6k95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    winget install 1password-cli
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>
2.  <span data-as="p">Check that 1Password CLI installed successfully:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="powershell">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_uli6k95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_v5i6k95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_vli6k95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_pi6k95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op --version
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>


1.  <span data-as="p">Download <a href="https://app-updates.agilebits.com/product_history/CLI2" class="link" target="_blank" rel="noreferrer">the latest release of 1Password CLI</a> and extract `op.exe`.  
    <span class="small">Learn how to <a href="/cli/verify/" class="link">verify its authenticity</a>.</span></span>

2.  <span data-as="p">Open PowerShell **as an administrator**.</span>

3.  <span data-as="p">Create a folder to move `op.exe` into. For example, `C:\Program Files\1Password CLI`.</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="powershell">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_faopak95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_fiopak95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_fqopak95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_copak95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    mkdir "C:\Program Files\1Password CLI"
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

4.  <span data-as="p">Move the `op.exe` file to the new folder.</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="powershell">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_fap1ak95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_fip1ak95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_fqp1ak95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_cp1ak95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    mv ".\op.exe" "C:\Program Files\1Password CLI"
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

5.  <div id="add-the-folder-containing-the-op-exe-file-to-your-path" class="absolute top-[-8rem] [[data-banner-state=visible]_&]:top-[-10.5rem]">

    </div>

    <div class="flex size-4 shrink-0 items-center justify-center" component-part="accordion-caret-right">

    </div>

    <div class="leading-tight text-left w-full min-w-0" contenteditable="false" component-part="accordion-title-container">

    Add the folder containing the op.exe file to your PATH.

    </div>

    <div id="add-the-folder-containing-the-op-exe-file-to-your-path-accordion-children" class="px-5 pb-3.5 prose prose-gray dark:prose-invert overflow-x-auto cursor-default" role="region" aria-labelledby="add-the-folder-containing-the-op-exe-file-to-your-path-accordion-title" component-part="accordion-content">

    <span data-as="p">**Windows 10 and later**</span>
    1.  Search for **Advanced System Settings** in the Start menu.
    2.  Select **Environment Variables**.
    3.  In the System Variables section, select the **PATH** environment variable and select **Edit**.
    4.  In the prompt, select **New** and add the directory where `op.exe` is located.
    5.  Sign out and back in to Windows for the change to take effect.

    </div>

6.  <span data-as="p">Check that 1Password CLI installed successfully:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_faphak95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_fiphak95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_fqphak95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_cphak95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op --version
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>


``` shiki
$arch = if ($env:PROCESSOR_ARCHITEW6432) { $env:PROCESSOR_ARCHITEW6432 } else { $env:PROCESSOR_ARCHITECTURE }
switch ($arch) {
    'AMD64' { $opArch = 'amd64'; break }
    'x86' { $opArch = '386'; break }
    'ARM64' { Write-Error "On ARM devices, install 1Password CLI with winget instead: winget install 1password-cli" -ErrorAction Stop }
    Default { Write-Error "Sorry, your operating system architecture '$arch' is unsupported" -ErrorAction Stop }
}
$installDir = Join-Path -Path $env:ProgramFiles -ChildPath '1Password CLI'
$opVersion = "v" + (Invoke-RestMethod -Uri 'https://app-updates.agilebits.com/check/1/0/CLI2/en/2.0.0/N').version
if ($opVersion -notmatch '^v\d+\.\d+\.\d+$') { throw "Couldn't determine the latest 1Password CLI version" }
Invoke-WebRequest -Uri "https://cache.agilebits.com/dist/1P/op2/pkg/$opVersion/op_windows_$($opArch)_$opVersion.zip" -OutFile op.zip
Expand-Archive -Path op.zip -DestinationPath $installDir -Force
$envMachinePath = [System.Environment]::GetEnvironmentVariable('PATH','machine')
if ($envMachinePath -split ';' -notcontains $installDir){
    [Environment]::SetEnvironmentVariable('PATH', "$envMachinePath;$installDir", 'Machine')
}
Remove-Item -Path op.zip
```


- <div id="apt">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-APT">

  APT

  </div>

  </div>

- <div id="yum">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-YUM">

  YUM

  </div>

  </div>

- <div id="alpine">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Alpine">

  Alpine

  </div>

  </div>

- <div id="nixos">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-NixOS">

  NixOS

  </div>

  </div>

- <div id="manual-3">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Manual">

  Manual

  </div>

  </div>


1.  <span data-as="p">Run the following command:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="11" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_faoi6s95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_fioi6s95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_fqoi6s95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_coi6s95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
      sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg && \
      echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" | \
      sudo tee /etc/apt/sources.list.d/1password.list && \
      sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/ && \
      curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | \
      sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol && \
      sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22 && \
      curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
      sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg && \
      sudo apt update && sudo apt install 1password-cli
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    <div id="see-a-step-by-step-version-of-the-script" class="absolute top-[-8rem] [[data-banner-state=visible]_&]:top-[-10.5rem]">

    </div>

    <div class="flex size-4 shrink-0 items-center justify-center" component-part="accordion-caret-right">

    </div>

    <div class="leading-tight text-left w-full min-w-0" contenteditable="false" component-part="accordion-title-container">

    See a step-by-step version of the script

    </div>

    <div id="see-a-step-by-step-version-of-the-script-accordion-children" class="px-5 pb-3.5 prose prose-gray dark:prose-invert overflow-x-auto cursor-default" role="region" aria-labelledby="see-a-step-by-step-version-of-the-script-accordion-title" component-part="accordion-content">

    1.  <span data-as="p">Add the key for the 1Password `apt` repository:</span>
        <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="2" language="shellscript">

        <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

        <div id="base-ui-_R_faoasi6s95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

        </div>

        <div id="base-ui-_R_fioasi6s95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

        <span class="sr-only" role="status"></span>

        </div>

        <div id="base-ui-_R_fqoasi6s95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

        </div>

        </div>

        <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

        <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_coasi6s95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

        <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

        <div class="font-mono whitespace-pre leading-6">

        ``` shiki
        curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
          sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
        ```

        </div>

        </div>

        </div>

        </div>

        <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

        </div>

        </div>
    2.  <span data-as="p">Add the 1Password `apt` repository:</span>
        <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="2" language="shellscript">

        <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

        <div id="base-ui-_R_faoisi6s95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

        </div>

        <div id="base-ui-_R_fioisi6s95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

        <span class="sr-only" role="status"></span>

        </div>

        <div id="base-ui-_R_fqoisi6s95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

        </div>

        </div>

        <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

        <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_coisi6s95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

        <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

        <div class="font-mono whitespace-pre leading-6">

        ``` shiki
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/$(dpkg --print-architecture) stable main" |
          sudo tee /etc/apt/sources.list.d/1password.list
        ```

        </div>

        </div>

        </div>

        </div>

        <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

        </div>

        </div>
    3.  <span data-as="p">Add the debsig-verify policy:</span>
        <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="6" language="shellscript">

        <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

        <div id="base-ui-_R_faoqsi6s95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

        </div>

        <div id="base-ui-_R_fioqsi6s95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

        <span class="sr-only" role="status"></span>

        </div>

        <div id="base-ui-_R_fqoqsi6s95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

        </div>

        </div>

        <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

        <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_coqsi6s95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

        <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

        <div class="font-mono whitespace-pre leading-6">

        ``` shiki
        sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
          curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | \
          sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol && \
          sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22 && \
          curl -sS https://downloads.1password.com/linux/keys/1password.asc | \
          sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
        ```

        </div>

        </div>

        </div>

        </div>

        <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

        </div>

        </div>
    4.  <span data-as="p">Install 1Password CLI:</span>
        <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

        <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

        <div id="base-ui-_R_fap2si6s95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

        </div>

        <div id="base-ui-_R_fip2si6s95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

        <span class="sr-only" role="status"></span>

        </div>

        <div id="base-ui-_R_fqp2si6s95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

        </div>

        </div>

        <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

        <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_cp2si6s95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

        <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

        <div class="font-mono whitespace-pre leading-6">

        ``` shiki
        sudo apt update && sudo apt install 1password-cli
        ```

        </div>

        </div>

        </div>

        </div>

        <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

        </div>

        </div>

    </div>
2.  <span data-as="p">Check that 1Password CLI installed successfully:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_fap26s95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_fip26s95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_fqp26s95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_cp26s95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op --version
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>


- <a href="https://downloads.1password.com/linux/debian/amd64/stable/1password-cli-amd64-latest.deb" class="link" target="_blank" rel="noreferrer">amd64</a>
- <a href="https://downloads.1password.com/linux/debian/386/stable/1password-cli-386-latest.deb" class="link" target="_blank" rel="noreferrer">386</a>
- <a href="https://downloads.1password.com/linux/debian/arm/stable/1password-cli-arm-latest.deb" class="link" target="_blank" rel="noreferrer">arm</a>
- <a href="https://downloads.1password.com/linux/debian/arm64/stable/1password-cli-arm64-latest.deb" class="link" target="_blank" rel="noreferrer">arm64</a>


1.  <span data-as="p">Run the following commands:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="3" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_faoias95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_fioias95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_fqoias95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_coias95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
    sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
    sudo dnf check-update -y 1password-cli && sudo dnf install 1password-cli
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    <div id="the-above-script-is-comprised-of-the-following-steps" class="absolute top-[-8rem] [[data-banner-state=visible]_&]:top-[-10.5rem]">

    </div>

    <div class="flex size-4 shrink-0 items-center justify-center" component-part="accordion-caret-right">

    </div>

    <div class="leading-tight text-left w-full min-w-0" contenteditable="false" component-part="accordion-title-container">

    The above script is comprised of the following steps

    </div>

    <div id="the-above-script-is-comprised-of-the-following-steps-accordion-children" class="px-5 pb-3.5 prose prose-gray dark:prose-invert overflow-x-auto cursor-default" role="region" aria-labelledby="the-above-script-is-comprised-of-the-following-steps-accordion-title" component-part="accordion-content">

    1.  <span data-as="p">Import the public key:</span>
        <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

        <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

        <div id="base-ui-_R_7lcasias95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

        </div>

        <div id="base-ui-_R_7pcasias95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

        <span class="sr-only" role="status"></span>

        </div>

        <div id="base-ui-_R_7tcasias95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

        </div>

        </div>

        <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

        <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6casias95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

        <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

        <div class="font-mono whitespace-pre leading-6">

        ``` shiki
        sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc
        ```

        </div>

        </div>

        </div>

        </div>

        <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

        </div>

        </div>
    2.  <span data-as="p">Configure the repository information:</span>
        <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

        <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

        <div id="base-ui-_R_7lcisias95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

        </div>

        <div id="base-ui-_R_7pcisias95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

        <span class="sr-only" role="status"></span>

        </div>

        <div id="base-ui-_R_7tcisias95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

        </div>

        </div>

        <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

        <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6cisias95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

        <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

        <div class="font-mono whitespace-pre leading-6">

        ``` shiki
        sudo sh -c 'echo -e "[1password]\nname=1Password Stable Channel\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\$basearch\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=\"https://downloads.1password.com/linux/keys/1password.asc\"" > /etc/yum.repos.d/1password.repo'
        ```

        </div>

        </div>

        </div>

        </div>

        <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

        </div>

        </div>
    3.  <span data-as="p">Install 1Password CLI:</span>
        <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

        <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

        <div id="base-ui-_R_7lcqsias95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

        </div>

        <div id="base-ui-_R_7pcqsias95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

        <span class="sr-only" role="status"></span>

        </div>

        <div id="base-ui-_R_7tcqsias95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

        </div>

        </div>

        <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

        <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6cqsias95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

        <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

        <div class="font-mono whitespace-pre leading-6">

        ``` shiki
        sudo dnf check-update -y 1password-cli && sudo dnf install 1password-cli
        ```

        </div>

        </div>

        </div>

        </div>

        <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

        </div>

        </div>

    </div>
2.  <span data-as="p">Check that 1Password CLI installed successfully:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_fap2as95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_fip2as95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_fqp2as95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_cp2as95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op --version
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>


- <a href="https://downloads.1password.com/linux/rpm/stable/x86_64/1password-cli-latest.x86_64.rpm" class="link" target="_blank" rel="noreferrer">x86_64</a>
- <a href="https://downloads.1password.com/linux/rpm/stable/i386/1password-cli-latest.i386.rpm" class="link" target="_blank" rel="noreferrer">i386</a>
- <a href="https://downloads.1password.com/linux/rpm/stable/aarch64/1password-cli-latest.aarch64.rpm" class="link" target="_blank" rel="noreferrer">aarch64</a>
- <a href="https://downloads.1password.com/linux/rpm/stable/armv7l/1password-cli-latest.armv7l.rpm" class="link" target="_blank" rel="noreferrer">armv7l</a>


1.  <span data-as="p">Run the following commands:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="3" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_7lcaes95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pcaes95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7tcaes95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6caes95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    echo https://downloads.1password.com/linux/alpinelinux/stable/ >> /etc/apk/repositories
    wget https://downloads.1password.com/linux/keys/alpinelinux/support@1password.com-61ddfc31.rsa.pub -P /etc/apk/keys
    apk update && apk add 1password-cli
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    <div id="the-above-script-is-comprised-of-the-following-steps-1" class="absolute top-[-8rem] [[data-banner-state=visible]_&]:top-[-10.5rem]">

    </div>

    <div class="flex size-4 shrink-0 items-center justify-center" component-part="accordion-caret-right">

    </div>

    <div class="leading-tight text-left w-full min-w-0" contenteditable="false" component-part="accordion-title-container">

    The above script is comprised of the following steps

    </div>

    <div id="the-above-script-is-comprised-of-the-following-steps-1-accordion-children" class="px-5 pb-3.5 prose prose-gray dark:prose-invert overflow-x-auto cursor-default" role="region" aria-labelledby="the-above-script-is-comprised-of-the-following-steps-1-accordion-title" component-part="accordion-content">

    1.  <span data-as="p">Add Password CLI to your list of repositories:</span>
        <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

        <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

        <div id="base-ui-_R_3qm5eaes95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

        </div>

        <div id="base-ui-_R_3sm5eaes95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

        <span class="sr-only" role="status"></span>

        </div>

        <div id="base-ui-_R_3um5eaes95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

        </div>

        </div>

        <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

        <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_365eaes95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

        <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

        <div class="font-mono whitespace-pre leading-6">

        ``` shiki
        echo https://downloads.1password.com/linux/alpinelinux/stable/ >> /etc/apk/repositories
        ```

        </div>

        </div>

        </div>

        </div>

        <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

        </div>

        </div>
    2.  <span data-as="p">Add the public key to validate the APK to your keys directory:</span>
        <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

        <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

        <div id="base-ui-_R_3qm9eaes95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

        </div>

        <div id="base-ui-_R_3sm9eaes95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

        <span class="sr-only" role="status"></span>

        </div>

        <div id="base-ui-_R_3um9eaes95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

        </div>

        </div>

        <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

        <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_369eaes95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

        <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

        <div class="font-mono whitespace-pre leading-6">

        ``` shiki
        wget https://downloads.1password.com/linux/keys/alpinelinux/support@1password.com-61ddfc31.rsa.pub -P /etc/apk/keys
        ```

        </div>

        </div>

        </div>

        </div>

        <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

        </div>

        </div>
    3.  <span data-as="p">Install 1Password CLI:</span>
        <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

        <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

        <div id="base-ui-_R_3qmdeaes95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

        </div>

        <div id="base-ui-_R_3smdeaes95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

        <span class="sr-only" role="status"></span>

        </div>

        <div id="base-ui-_R_3umdeaes95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

        </div>

        </div>

        <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

        <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_36deaes95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

        <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

        <div class="font-mono whitespace-pre leading-6">

        ``` shiki
        apk update && apk add 1password-cli
        ```

        </div>

        </div>

        </div>

        </div>

        <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

        </div>

        </div>

    </div>
2.  <span data-as="p">Check that 1Password CLI installed successfully:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_7lcies95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pcies95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7tcies95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6cies95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op --version
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>


1.  <span data-as="p">Add 1Password to your `/etc/nixos/configuration.nix` file, or `flake.nix` if you’re using a flake. For example, the following snippet includes 1Password CLI and the 1Password app:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="14" language="nix">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_faojis95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_fiojis95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_fqojis95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_cojis95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    # NixOS has built-in modules to enable 1Password
    # along with some pre-packaged configuration to make
    # it work nicely. You can search what options exist
    # in NixOS at https://search.nixos.org/options

    # Enables the 1Password CLI
    programs._1password = { enable = true; };

    # Enables the 1Password desktop app
    programs._1password-gui = {
    enable = true;
    # this makes system auth etc. work properly
    polkitPolicyOwners = [ "<your-linux-username>" ];
    };
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>
2.  <span data-as="p">After you make changes to your configuration file, apply them:</span>
    - <span data-as="p">If you added 1Password to `/etc.nixos/configuration.nix`, run:</span>
      <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

      <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

      <div id="base-ui-_R_ulh93is95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

      </div>

      <div id="base-ui-_R_v5h93is95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

      <span class="sr-only" role="status"></span>

      </div>

      <div id="base-ui-_R_vlh93is95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

      </div>

      </div>

      <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

      <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_ph93is95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

      <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

      <div class="font-mono whitespace-pre leading-6">

      ``` shiki
      sudo nixos-rebuild switch
      ```

      </div>

      </div>

      </div>

      </div>

      <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

      </div>

      </div>
    - <span data-as="p">If you added 1Password to `flake.nix`, replace `<flake-directory-path>` with the directory your flake is in and `<output-name>` with the name of the flake output containing your system configuration, then run the command.</span>
      <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

      <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

      <div id="base-ui-_R_uli93is95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

      </div>

      <div id="base-ui-_R_v5i93is95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

      <span class="sr-only" role="status"></span>

      </div>

      <div id="base-ui-_R_vli93is95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

      </div>

      </div>

      <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

      <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_pi93is95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

      <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

      <div class="font-mono whitespace-pre leading-6">

      ``` shiki
      sudo nixos-rebuild switch --flake <flake-directory-path>.#<output-name>
      ```

      </div>

      </div>

      </div>

      </div>

      <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

      </div>

      </div>
3.  <span data-as="p">Check that 1Password CLI installed successfully:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_fapjis95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_fipjis95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_fqpjis95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_cpjis95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op --version
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>


| If `uname -m` returns | Replace `<your-architecture>` with |
|-----------------------|------------------------------------|
| `x86_64`              | `amd64`                            |
| `aarch64` or `arm64`  | `arm64`                            |
| `armv7l` or `armv6l`  | `arm`                              |
| `i386` or `i686`      | `386`                              |


``` shiki
# Replace <your-architecture> with amd64, arm64, arm, or 386
ARCH="<your-architecture>" && \
OP_VERSION="v$(wget -qO- https://app-updates.agilebits.com/check/1/0/CLI2/en/2.0.0/N | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+' | head -n1)" && \
[ "$OP_VERSION" != "v" ] || { echo "Couldn't determine the latest 1Password CLI version" >&2; exit 1; } && \
wget "https://cache.agilebits.com/dist/1P/op2/pkg/${OP_VERSION}/op_linux_${ARCH}_${OP_VERSION}.zip" -O op.zip && \
unzip -d op op.zip && \
sudo mv op/op /usr/local/bin/ && \
rm -r op.zip op && \
sudo groupadd -f onepassword-cli && \
sudo chgrp onepassword-cli /usr/local/bin/op && \
sudo chmod g+s /usr/local/bin/op
```


Or follow the extended guide


1.  <span data-as="p">Download the <a href="https://app-updates.agilebits.com/product_history/CLI2" class="link" target="_blank" rel="noreferrer">latest release of 1Password CLI</a> and extract it. To verify its authenticity:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="2" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_7lc5dms95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pc5dms95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7tc5dms95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6c5dms95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    gpg --keyserver keyserver.ubuntu.com --receive-keys 3FEF9748469ADBE15DA7CA80AC2D62742012EA22
    gpg --verify op.sig op
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>
2.  <span data-as="p">Move `op` to `/usr/local/bin`, or another directory in your `$PATH`.</span>
3.  <span data-as="p">Check that 1Password CLI installed successfully:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_7lcddms95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pcddms95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7tcddms95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6cddms95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op --version
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>
4.  <span data-as="p">Create the `onepassword-cli` group if it doesn’t yet exist:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_7lchdms95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pchdms95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7tchdms95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6chdms95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    sudo groupadd onepassword-cli
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>
5.  <span data-as="p">Set the correct permissions on the `op` binary:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="2" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_7lcldms95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pcldms95deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7tcldms95deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6cldms95deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    sudo chgrp onepassword-cli /usr/local/bin/op && \
    sudo chmod g+s /usr/local/bin/op
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>


## 


<a href="#step-2-turn-on-the-1password-desktop-app-integration" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <div id="mac-3">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Mac">

  Mac

  </div>

  </div>

- <div id="windows-3">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Windows">

  Windows

  </div>

  </div>

- <div id="linux-3">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Linux">

  Linux

  </div>

  </div>


1.  Open and unlock the <a href="https://1password.com/downloads/" class="link" target="_blank" rel="noreferrer">1Password app</a>.
2.  Select your account or collection at the top of the sidebar.
3.  Navigate to **Settings** \> **<a href="onepassword://settings/developers" class="link" target="_blank" rel="noreferrer">Developer</a>**.
4.  Select **Integrate with 1Password CLI**.
5.  If you want to authenticate 1Password CLI with your fingerprint, turn on **<a href="https://support.1password.com/touch-id-mac/" class="link" target="_blank" rel="noreferrer">Touch ID</a>** in the app.


1.  Open and unlock the <a href="https://1password.com/downloads/" class="link" target="_blank" rel="noreferrer">1Password app</a>.
2.  Select your account or collection at the top of the sidebar.
3.  Turn on **<a href="https://support.1password.com/windows-hello/" class="link" target="_blank" rel="noreferrer">Windows Hello</a>** in the app.
4.  Navigate to **Settings** \> **<a href="onepassword://settings/developers" class="link" target="_blank" rel="noreferrer">Developer</a>**.
5.  Select **Integrate with 1Password CLI**.


1.  Open and unlock the <a href="https://1password.com/downloads/" class="link" target="_blank" rel="noreferrer">1Password app</a>.
2.  Select your account or collection at the top of the sidebar.
3.  Navigate to **Settings** \> **<a href="onepassword://settings/security" class="link" target="_blank" rel="noreferrer">Security</a>**.
4.  Turn on **<a href="https://support.1password.com/system-authentication-linux/" class="link" target="_blank" rel="noreferrer">Unlock using system authentication</a>**.
5.  Navigate to **Settings** \> **<a href="onepassword://settings/developers" class="link" target="_blank" rel="noreferrer">Developer</a>**.
6.  Select **Integrate with 1Password CLI**.


## 


<a href="#step-3-enter-any-command-to-sign-in" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op vault list
```


#### 


<a href="#if-you-have-multiple-accounts" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#next-steps" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  <a href="/cli/reference/" class="link">Get started with basic 1Password CLI commands.</a>
2.  <a href="/cli/shell-plugins/" class="link">Set up 1Password Shell Plugins to handle authentication for your other command-line tools.</a>
3.  <a href="/cli/secret-references/" class="link">Learn how to securely load secrets from your 1Password account without putting any plaintext secrets in code.</a>

## 


<a href="#learn-more" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/cli/app-integration/#troubleshooting" class="link">1Password app integration troubleshooting</a>
- <a href="/cli/app-integration-security/" class="link">1Password app integration security</a>
- <a href="/cli/config-directories" class="link">How 1Password CLI detects configuration directories</a>
- <a href="/get-started/developer-quickstart" class="link">Developer quickstart</a>


Was this page helpful?


{"docsConfig":{"theme":"mint","\$schema":"https://mintlify.com/docs.json","name":"1Password Developer","colors":{"primary":"#104ebb","light":"#b8d7ff","dark":"#303136"},"logo":{"light":"https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max\u0026auto=format\u0026n=lHrfVfSCdefFz8U5\u0026q=85\u0026s=29d1c9358888a723dddd8a89a3b6f71d","dark":"https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-light.svg?fit=max\u0026auto=format\u0026n=lHrfVfSCdefFz8U5\u0026q=85\u0026s=119233092720e49043d6f42ff71125f1"},"favicon":"https://mintcdn.com/ab-634991b8/s4Wjy03jBRs6hcHb/favicon.ico?fit=max\u0026auto=format\u0026n=s4Wjy03jBRs6hcHb\u0026q=85\u0026s=dd03b4bc604b342373aa4d3e21be4310","api":{"playground":{"display":"interactive"},"examples":{"languages":\["curl","node","python","go","dotnet","java","php","powershell","ruby"\]}},"background":{"color":{"light":"#fbf8f4","dark":"#1a1b1e"}},"navbar":{"links":\[{"href":"/community","label":"Community"},{"href":"https://www.1password.academy/path/1password-developer-tools","label":"Academy"}\],"primary":{"type":"button","label":"GitHub","href":"https://github.com/1Password"}},"footer":{"socials":{"github":"https://github.com/1Password","x":"https://twitter.com/1Password","reddit":"https://www.reddit.com/r/1Password","linkedin":"https://www.linkedin.com/company/1password","youtube":"https://www.youtube.com/1PasswordVideos","facebook":"https://www.facebook.com/1Password","instagram":"https://www.instagram.com/1password"},"links":\[{"header":"Legal","items":\[{"label":"Terms of Service","href":"https://1password.com/legal/terms-of-service"},{"label":"Privacy Policy","href":"https://1password.com/legal/privacy"},{"label":"Cookie Policy","href":"https://1password.com/legal/cookies"},{"label":"Accessibility","href":"https://1password.com/legal/accessibility"}\]},{"header":"Community","items":\[{"label":"Developer community","href":"/community"},{"label":"Code of Conduct","href":"/code-of-conduct"},{"label":"Community projects disclaimer","href":"/community/disclaimer"}\]},{"header":"Resources","items":\[{"label":"1Password University","href":"https://www.1password.university/?utm_ref=website-footer"},{"label":"Blog RSS","href":"https://blog.1password.com/index.xml"},{"label":"Newsletter","href":"https://1password.com/developer-newsletter"}\]}\]},"seo":{"metatags":{"canonical":"https://www.1password.dev","google-site-verification":"YserOhXnJUjFfIZ4K3qgxkVSlQZQdXtIbBiKzZ35Nvs"}},"fonts":{"heading":{"family":"Public Sans"},"body":{"family":"Public Sans"}},"banner":{"content":"\*\*New!\*\* Use the \[1Password Credential Broker\](https://www.1password.dev/brokered-access) to give CI/CD and other machine workflows short-lived access to secrets, without managing service account tokens.","dismissible":true,"color":{"light":"#145fe4","dark":"#145fe4"}},"errors":{"404":{"redirect":false,"title":"This page can't be found","description":"Our docs have moved to \[www.1password.dev\](https://www.1password.dev). Try searching for what you need or selecting from the list of tools."}},"contextual":{"options":\["copy","view","mcp","cursor","vscode","chatgpt","claude","perplexity"\],"display":"header"},"styling":{"latex":false},"navigation":{"pages":\[\]}},"deployment":{"deploymentMetadataValue":{"subdomain":"ab-634991b8","hasAudioNarration":false,"actualSubdomain":"ab-634991b8","customDomains":\["www.1password.dev"\],"gitSource":{"type":"github","owner":"1password","repo":"1password.dev","deployBranch":"main","contentDirectory":"","isPrivate":true,"mountPath":"","label":""},"chroma":{"liveDeploymentHistoryId":"6ae4c9014c4a3f4f5e4b234c","collectionId":"2b0d16b8-c8c5-48fa-9c4d-f1ffef490467","schemaVersion":"v3","latestBuiltDeploymentHistoryId":"6ae4c9014c4a3f4f5e4b234c"},"feedback":{"thumbs":true,"contextualFeedback":{"allowEmail":false},"agentFeedback":true},"entitlements":{"AI_CHAT":{"status":"ENABLED"},"REMOVE_BRANDING":{"status":"ENABLED"},"CONTEXTUAL_FEEDBACK":{"status":"ENABLED"},"CODE_SNIPPET_FEEDBACK":{"status":"ENABLED"},"WEB_MCP":{"status":"ENABLED"},"NARRATION":{"status":"ENABLED"}},"buildId":"6ae4c9014c4a3f4f5e4b234c","clientVersion":"0.0.4044","searchFilterCounts":\[{"language":"default","tag":"More Tools","count":257},{"language":"default","tag":"Shell Plugins","count":184},{"language":"default","tag":"CLI","count":112},{"language":"default","tag":"Secrets Automation","count":94},{"language":"default","tag":"SaaS Manager API","count":88},{"language":"default","tag":"Plugins","count":85},{"language":"default","tag":"API Reference","count":64},{"language":"default","tag":"Reference","count":58},{"language":"default","tag":"SDKs","count":53},{"language":"default","tag":"Integrations","count":50}\]},"assistantConfig":{"enableStarterQuestions":true,"enableContextualStarterQuestions":true,"deflection":{"enabled":true,"email":"support@1password.com","showHelpButton":true}},"basePath":"","hasChatPermissions":true,"hasWebMcpPermissions":true,"toggles":\[\],"googleFontsInlined":true},"customCss":\[{"filePath":"styles.css","content":":root{--op-secure-blue:#104ebb;--op-secure-blue-hover:#0e46a8;--op-iron-ore:#303136;--op-page-bg-dark:#1a1b1e;--op-white:#ffffff;--op-icy-blue:#dcebff;--op-cornflower:#b8d7ff;--op-biscuit:#fbf8f4;--op-sunbeam:#fad785;--op-tangerine:#ff8f78;--op-enable-mint:#76e0bd;--op-gold:#cbb88e;--op-status-success:#10622f;--op-status-warning:#8a4006;--op-status-error:#a71c1c;--op-status-info:var(--op-secure-blue);--op-border-ui:#949494;--op-border-ui-dark:#6b7280;--op-border-subtle:rgb(3 7 18 / 0.12);--op-border-subtle-dark:rgb(251 248 244 / 0.25);--op-border-footer-dark:rgb(251 248 244 / 0.37);--op-border-navbar-light:rgb(107 114 128 / 0.05);--op-border-navbar-dark:rgb(209 213 219 / 0.06);--op-border-card-light:rgb(3 7 18 / 0.1);--op-border-card-dark:rgb(255 255 255 / 0.1);--op-border-hero-light:rgb(255 255 255 / 0.08);--op-border-hero-dark:rgb(255 255 255 / 0.12);--op-border-badge-light:rgb(16 78 187 / 0.2);--op-border-badge-dark:rgb(184 215 255 / 0.25);--op-border-workflow-dark:rgb(251 248 244 / 0.2);--op-text-body:var(--op-iron-ore);--op-text-body-dark:var(--op-biscuit);--op-surface-card-light:var(--op-white);--op-surface-card-dark:#25262a;--op-surface-callout-light:rgb(220 235 255 / 0.45);--op-surface-callout-dark:rgb(184 215 255 / 0.08)}#content.prose{--tw-prose-body:var(--op-text-body)}.dark \#content.prose{--tw-prose-body:var(--op-text-body-dark)}#content.prose :where(p, span\[data-as=\\p\\\], li, td, th, blockquote, figcaption):not(a.op-cta-primary span){color:var(--op-text-body)}.dark \#content.prose :where(p, span\[data-as=\\p\\\], li, td, th, blockquote, figcaption):not(a.op-cta-primary span){color:var(--op-text-body-dark)}#content :is(p, li, div, span, button, h1, h2, h3, h4, h5, h6).text-gray-600,#content :is(p, li, div, span, button, h1, h2, h3, h4, h5, h6).text-gray-700,#content :is(p, li, span, button, h1, h2, h3, h4, h5, h6).text-gray-500{color:var(--op-text-body)}.dark \#content :is(p, li, div, span, button, h1, h2, h3, h4, h5, h6).dark\\:text-gray-300,.dark \#content :is(p, li, div, span, button, h1, h2, h3, h4, h5, h6).dark\\:text-gray-400,.dark \#content :is(p, li, span, button, h1, h2, h3, h4, h5, h6).dark\\:text-gray-500{color:var(--op-text-body-dark)}#content .text-gray-400:not(:is(p, li, span, button, h1, h2, h3, h4, h5, h6)){color:var(--op-border-ui)}.dark \#content .text-gray-400:not(:is(p, li, span, button, h1, h2, h3, h4, h5, h6)),.dark \#content .text-gray-500:not(:is(p, li, span, button, h1, h2, h3, h4, h5, h6)){color:var(--op-border-ui-dark)}.dark .card-group{--background-dark:37 38 42}.dark .card-group .card{background-color:rgb(var(--background-dark))!important;border-color:var(--op-border-card-dark)!important}.card-group .card{border-color:var(--op-border-card-light)!important}.community-callout,.community-card,.op-card-surface{border:1px solid var(--op-border-card-light)}.dark .community-card,.dark .op-card-surface{border-color:var(--op-border-card-dark)}#content .hover\\:border-gray-300:hover{border-color:var(--op-iron-ore)}.dark \#content .hover\\:border-gray-600:hover{border-color:var(--op-biscuit)}.community-callout,.community-card{border-radius:.5rem;background-color:var(--op-surface-card-light)}.dark .community-card{background-color:var(--op-surface-card-dark)}.community-card .community-card-chevron{color:var(--op-border-ui)}.dark .community-card .community-card-chevron{color:var(--op-cornflower)}a.community-card:hover{border-color:var(--op-secure-blue)}.dark a.community-card:hover{border-color:var(--op-cornflower)}.community-callout{background-color:var(--op-surface-callout-light)}.dark .community-callout{border-color:var(--op-border-card-dark);background-color:var(--op-surface-callout-dark)}.community-link{color:var(--op-secure-blue);text-decoration:none}.community-link:hover{color:var(--op-secure-blue-hover);text-decoration:underline}.dark .community-link{color:var(--op-cornflower)}#footer a,#footer p.font-semibold,.dark \#content\>h5,.dark \#content\>h6,.dark .community-link:hover{color:var(--op-white)}:is(\n \#sidebar-content a:not(\[aria-current=\\page\\\]),\n \#table-of-contents,\n \#table-of-contents a,\n \#navbar .nav-tabs-item:not(\[data-active\]),\n \#navbar nav ul \> li:not(#topbar-cta-button) \> a,\n \#search-bar-entry,\n \#search-bar-entry-mobile,\n \#assistant-entry,\n \#assistant-entry-mobile,\n \[data-component-name=\\theme-toggle\\\]\n){color:var(--op-text-body)}.dark :is(\n \#sidebar-content a:not(\[aria-current=\\page\\\]),\n \#table-of-contents,\n \#table-of-contents a,\n \#navbar .nav-tabs-item:not(\[data-active\]),\n \#navbar nav ul \> li:not(#topbar-cta-button) \> a,\n \#search-bar-entry,\n \#search-bar-entry-mobile,\n \#assistant-entry,\n \#assistant-entry-mobile,\n \[data-component-name=\\theme-toggle\\\]\n){color:var(--op-text-body-dark)}:is(\n \#search-bar-entry,\n \#search-bar-entry-mobile,\n \#assistant-entry,\n \#assistant-entry-mobile,\n \[data-component-name=\\theme-toggle\\\]\n) svg{color:inherit}#footer a.h-fit svg{background-color:var(--op-biscuit)}#footer a.h-fit:hover svg{background-color:var(--op-white)}.hero-background{background-color:var(--op-iron-ore);background-image:radial-gradient(ellipse 75% 100% at 100% 50%,rgb(20 95 228/.55) 0,rgb(20 95 228/.2) 40%,transparent 70%)}.dark .hero-background{background-color:var(--op-page-bg-dark);background-image:radial-gradient(ellipse 80% 100% at 100% 50%,rgb(20 95 228/.7) 0,rgb(20 95 228/.3) 45%,transparent 75%)}.hero-section{border-bottom:1px solid var(--op-border-hero-light)}.dark .hero-section{border-bottom-color:var(--op-border-hero-dark)}.hero-cta{background-color:var(--op-secure-blue);color:var(--op-white);box-shadow:0 1px 3px rgb(0 0 0/.25)}.hero-cta svg,.hero-cta svg path{fill:currentColor!important;color:currentColor!important}.hero-cta:hover{background-color:var(--op-secure-blue-hover)}#content a.op-cta-primary,#content.prose a.op-cta-primary{background-color:var(--op-secure-blue);color:var(--op-white)!important;text-decoration:none}#content a.op-cta-primary span,#content a.op-cta-primary span\[data-as=p\],#content a.op-cta-primary:hover span,#content a.op-cta-primary:hover span\[data-as=p\],#content.prose a.op-cta-primary span,#content.prose a.op-cta-primary span\[data-as=p\],#content.prose a.op-cta-primary:hover span,#content.prose a.op-cta-primary:hover span\[data-as=p\]{color:var(--op-white)!important}#content a.op-cta-primary:hover,#content.prose a.op-cta-primary:hover{background-color:var(--op-secure-blue-hover);color:var(--op-white)!important}#topbar-cta-button a\>span.absolute,.highlight-card-link svg{background-color:var(--op-secure-blue)!important}#topbar-cta-button a:hover\>span.absolute{background-color:var(--op-secure-blue-hover)!important}#topbar-cta-button a span.z-10,#topbar-cta-button a svg,.dark .highlight-card-link:hover{color:var(--op-white)!important}.card-group{gap:1rem}#content .card-group img\[src\*=\\/homepage-icons/brand/\\\]{width:32px;height:32px;flex-shrink:0}.homepage-card-title{display:inline-flex;flex-wrap:wrap;align-items:center;gap:.25rem .5rem}.image-button-link img{margin:10px 0}.dark \#content a\>div\>span{color:var(--op-cornflower)!important}.docs-higlight-cards{display:grid;grid-template-columns:repeat(auto-fill,minmax(250px,1fr));gap:1rem;margin-bottom:1rem}.highlight-card-link{color:var(--op-secure-blue)!important}.highlight-card-link:hover{color:var(--op-secure-blue-hover)!important}.dark .highlight-card-link{color:var(--op-cornflower)!important}.dark .highlight-card-link svg{background-color:var(--op-cornflower)!important}.coloredCodeWrapper .code-block\>div:nth-child(3){--fade-color-light:transparent!important;--fade-color-dark:transparent!important}.badge{border-radius:.4rem;color:var(--op-white);font-weight:700;line-height:1;padding:3px 5px}.badge--primary{background-color:var(--op-secure-blue)}.badge--secondary{background-color:var(--op-biscuit);color:var(--op-iron-ore)}.op-status-badge,.op-workflow-guide-badge{display:inline-flex;flex-shrink:0;align-items:center;white-space:nowrap;border-radius:.25rem;color:var(--op-iron-ore);padding:.125rem .625rem;font-size:.75rem;line-height:1rem;font-weight:600}.op-status-badge{vertical-align:middle;border:1px solid var(--op-border-badge-light);background-color:var(--op-icy-blue)}.dark .op-status-badge{border-color:var(--op-border-badge-dark);background-color:rgb(184 215 255/.12);color:var(--op-icy-blue)}.op-workflow-guide-badge{margin-top:.75rem;border:1px solid transparent;background-color:var(--op-biscuit)}.dark .op-workflow-guide-badge{border-color:var(--op-border-workflow-dark);background-color:rgb(251 248 244/.1);color:var(--op-biscuit)}.op-beta-badge-inline{display:inline-flex;align-items:center;margin-left:.5rem;vertical-align:middle}.mdx-content a\[href^=http\]:not(\[href\*=\\://1password.com/\\\],\[href\$=\\://1password.com\\\],\[href\*=\\.1password.com/\\\],\[href\$=\\.1password.com\\\],\[href\*=\\://1password.dev/\\\],\[href\$=\\://1password.dev\\\],\[href\*=\\.1password.dev/\\\],\[href\$=\\.1password.dev\\\],\[href\*=\\://1password.ca/\\\],\[href\$=\\://1password.ca\\\],\[href\*=\\.1password.ca/\\\],\[href\$=\\.1password.ca\\\],\[href\*=\\://1password.eu/\\\],\[href\$=\\://1password.eu\\\],\[href\*=\\.1password.eu/\\\],\[href\$=\\.1password.eu\\\],\[href\*=\\://1password.io/\\\],\[href\$=\\://1password.io\\\],\[href\*=\\.1password.io/\\\],\[href\$=\\.1password.io\\\],\[href\*=\\://1password.university/\\\],\[href\$=\\://1password.university\\\],\[href\*=\\.1password.university/\\\],\[href\$=\\.1password.university\\\],\[href\*=\\://agilebits.com/\\\],\[href\$=\\://agilebits.com\\\],\[href\*=\\.agilebits.com/\\\],\[href\$=\\.agilebits.com\\\],\[href\*=\\://b5dev.com/\\\],\[href\$=\\://b5dev.com\\\],\[href\*=\\.b5dev.com/\\\],\[href\$=\\.b5dev.com\\\],\[href\*=\\://b5local.com/\\\],\[href\$=\\://b5local.com\\\],\[href\*=\\.b5local.com/\\\],\[href\$=\\.b5local.com\\\],\[href\*=\\://1infra.dev/\\\],\[href\$=\\://1infra.dev\\\],\[href\*=\\.1infra.dev/\\\],\[href\$=\\.1infra.dev\\\],\[href\*=\\://kolide.com/\\\],\[href\$=\\://kolide.com\\\],\[href\*=\\.kolide.com/\\\],\[href\$=\\.kolide.com\\\],\[href\*=\\://trelica.app/\\\],\[href\$=\\://trelica.app\\\],\[href\*=\\.trelica.app/\\\],\[href\$=\\.trelica.app\\\],\[href\*=\\://trelica.eu/\\\],\[href\$=\\://trelica.eu\\\],\[href\*=\\.trelica.eu/\\\],\[href\$=\\.trelica.eu\\\],\[href\*=\\://trelica.com/\\\],\[href\$=\\://trelica.com\\\],\[href\*=\\.trelica.com/\\\],\[href\$=\\.trelica.com\\\],\[href\*=\\://1password.community/\\\],\[href\$=\\://1password.community\\\],\[href\*=\\.1password.community/\\\],\[href\$=\\.1password.community\\\],\[href\*=\\://1pw.ca/\\\],\[href\$=\\://1pw.ca\\\],\[href\*=\\.1pw.ca/\\\],\[href\$=\\.1pw.ca\\\]):not(.card \*,.op-card-surface \*,.image-button-link,.community-card,.community-card \*,pre \*,:has(img))::after{content:\\\\;display:inline-block;width:1em;height:1em;margin-left:.25em;vertical-align:-.125em;background-color:currentColor;-webkit-mask:var(--op-link-icon, url(\\/static/img/icons/external-link.svg\\)) no-repeat center/contain;mask:var(--op-link-icon, url(\\/static/img/icons/external-link.svg\\)) no-repeat center/contain}.mdx-content a:is(\[href\*=\\://github.com/\\\], \[href\$=\\://github.com\\\], \[href\*=\\.github.com/\\\], \[href\$=\\.github.com\\\], \[href\*=\\://github.blog/\\\], \[href\$=\\://github.blog\\\]){--op-link-icon:url(\\/static/img/logos/github.svg\\)}#content\>h5,#content\>h6{font-weight:700}.accordion{background-color:var(--op-icy-blue)}.dark .accordion{background-color:var(--op-surface-card-dark)}.accordion .mint-bg-white{padding:1rem}.accordion .mint-bg-white \[class\*=-mx-\]{margin:0!important;padding:0!important;width:100%!important;--page-padding:0px}#footer img.nav-logo.dark\\:hidden,#footer\>div\>div.flex.flex-col.md\\:flex-row.gap-8.justify-between.min-h-\\\[76px\\\]\>div.flex.flex-col.sm\\:grid.max-md\\:\\!grid-cols-2.gap-8.flex-1\>div\>div\>p{display:none!important}footer#footer.advanced-footer{display:flex!important}footer#footer{align-items:unset;background-color:var(--op-iron-ore);color:var(--op-white)}#footer img.nav-logo.dark\\:block{display:block!important}#footer\>div.flex.w-full.flex-col.gap-12.justify-between.px-8.py-16.md\\:py-20.lg\\:py-28.z-20\>div.h-\\\[1px\\\].w-full.bg-gray-100.dark\\:bg-white\\/5{background-color:var(--op-border-footer-dark)}#footer\>div.flex.w-full.flex-col.gap-12.justify-between.px-8.py-16.md\\:py-20.lg\\:py-28.z-20{margin:0 auto}footer .email_form{max-width:650px;margin:auto}.codeblock_accordion{margin-top:10px}.codeblock_accordion .code-block{margin:0!important}.codeblock_accordion\>div\>.code-block,.codeblock_accordion\>div\>.code-block\>div:nth-child(2){border-bottom-left-radius:0;border-bottom-right-radius:0}.codeblock_accordion .see_results_container{border-bottom-left-radius:1rem;border-bottom-right-radius:1rem}.codeblock_accordion .see_results_container .code-block,.codeblock_accordion .see_results_container .code-block\>div:nth-child(2){border-top-left-radius:0;border-top-right-radius:0}.hide_bullets ul li{padding-left:0!important}.hide_bullets ul li::before{content:none!important}#navigation-items a\[href^=\\/\\\]:not(\[href^=\\//\\\])\>div\>div:nth-child(2){display:none}a\[href^=\\//\\\] .flex-shrink-0 svg,a\[href^=http\] .flex-shrink-0 svg{display:block}h1 code,h2 code,h3 code,h4 code,h5 code,h6 code{white-space:nowrap}h2.flex.whitespace-pre-wrap span.cursor-pointer svg.icon,h4.flex.whitespace-pre-wrap span.cursor-pointer svg.icon{margin:0;vertical-align:baseline}table thead tr th code{padding-left:0!important;padding-right:0!important}.tabs.tab-container{padding:0 .8rem 1rem;border:1px solid var(--op-border-subtle);border-radius:4px}.dark .tabs.tab-container{border-color:var(--op-border-subtle-dark)}.nav-tabs-item:nth-child(3),nav-tabs-item:nth-child(3){--tab-gap-before-divider:8px;--nav-tabs-item-gap:0.5rem;margin-left:var(--tab-gap-before-divider)!important;padding-left:calc(var(--tab-gap-before-divider) + var(--nav-tabs-item-gap))!important;border-left:1px solid var(--op-border-navbar-light)}.dark .nav-tabs-item:nth-child(3),.dark nav-tabs-item:nth-child(3){border-left-color:var(--op-border-navbar-dark)}.peer.is-center~div:has(.tutorial-explorer){max-width:84rem!important}@media (max-width:639px){.tutorial-filter-bar{display:grid!important;grid-template-columns:minmax(0,1fr)}.tutorial-filter-search,.tutorial-filter-tools,.tutorial-filter-topic{grid-column:1/-1;width:100%}.tutorial-filter-search input{width:100%!important}.tutorial-filter-dropdown\>button,.tutorial-filter-menu{width:100%}.tutorial-filter-dropdown\>button{justify-content:space-between}.tutorial-filter-menu{min-width:0!important}.tutorial-filter-sort{grid-column:1/-1;justify-self:end;margin-left:0!important}}#navbar.is-custom .nav-tabs-item\[data-active\]{color:var(--op-text-body);text-shadow:none}.dark \#navbar.is-custom .nav-tabs-item\[data-active\]{color:var(--op-text-body-dark)}#navbar.is-custom .nav-tabs-item\[data-active\]\>div{background-color:transparent!important}#navbar.is-custom .nav-tabs-item\[data-active\]:hover\>div{background-color:rgb(229 231 235)!important}.dark \#navbar.is-custom .nav-tabs-item\[data-active\]:hover\>div{background-color:rgb(55 65 81)!important}#footer .api-sdk-terms-notice{margin:0;padding:0 0 1.25rem;font-size:.875rem;font-style:italic;line-height:1.5;text-align:center;color:rgb(251 248 244/.8);pointer-events:auto}#footer .api-sdk-terms-notice a{position:relative;z-index:2;color:var(--op-cornflower);text-decoration:underline;text-underline-offset:2px;pointer-events:auto;cursor:pointer}"}\],"page":{"pagePath":"cli/get-started","slug":"/cli/get-started","pageMetadata":{"id":"get-started","title":"Get started with 1Password CLI","sidebarTitle":"Get started","og:description":"Learn how to install and sign in to 1Password CLI, then get started with commands and scripts to manage users, vaults, and items on the command line.","slug":"/cli/get-started","description":null,"href":"/cli/get-started"},"pageType":"default","mdx":{"mdxSource":{"compiledSource":"\\use strict\\;const{Fragment:\_Fragment,jsx:\_jsx,jsxs:\_jsxs}=arguments\[0\];const{useMDXComponents:\_provideComponents}=arguments\[0\];const Image=({src,darkSrc,alt,width,border,height,round})=\>{const classNames=\[\`mint-mx-4\`\];if(border){classNames.push(\`mint-rounded-sm\`)}if(round){classNames.push(\`mint-rounded-lg\`)}const style={};if(width)style.width=typeof width===\`number\`?\`\${width}px\`:width;if(height)style.height=typeof height===\`number\`?\`\${height}px\`:height;return darkSrc?\_jsxs(\_Fragment,{children:\[\_jsx(\`img\`,{src,alt,className:\[...classNames,\`dark:mint-hidden\`\].join(\` \`),style:Object.keys(style).length\>0?style:undefined}),\_jsx(\`img\`,{src:darkSrc,alt,className:\[...classNames,\`mint-hidden dark:mint-block\`\].join(\` \`),style:Object.keys(style).length\>0?style:undefined,onError:e=\>{e.target.src=src}})\]}):\_jsx(\`img\`,{src,alt,className:classNames.join(\` \`),style:Object.keys(style).length\>0?style:undefined})};const CodeResult=({children,resultLang,wrap,expandable})=\>{const{CodeBlock,Icon}=\_provideComponents()\|\|{};if(!CodeBlock)\_missingMdxReference(\`CodeBlock\`,true);if(!Icon)\_missingMdxReference(\`Icon\`,true);const parseChildren=()=\>{let language=\`text\`;let codeContent=\`\`;const extractText=node=\>{if(typeof node===\`string\`){return node}if(Array.isArray(node)){return node.map(extractText).join(\`\`)}if(node?.props?.children){return extractText(node.props.children)}return\`\`};const extractLanguage=node=\>{if(!node)return null;if(node.props?.className){const className=node.props.className;const langMatch=className.match(/language-(\\w+)/);if(langMatch){return langMatch\[1\]}}if(node.props?.\[\`data-language\`\]){return node.props\[\`data-language\`\]}if(node.props?.language){return node.props.language}return null};if(typeof children===\`string\`){codeContent=children}else if(Array.isArray(children)){codeContent=extractText(children);for(const child of children){const detectedLang=extractLanguage(child);if(detectedLang){language=detectedLang;break}}}else if(children?.props){const detectedLang=extractLanguage(children);if(detectedLang){language=detectedLang}codeContent=extractText(children)}const parts=codeContent.split(\`#code-result\`);if(parts.length\u003c2){return{command:codeContent.trim(),result:null,language,defaultOpen:false}}const resultText=parts\[1\].trim();const defaultOpen=resultText.startsWith(\`open\`);const cleanResult=defaultOpen?resultText.slice(4).trim():resultText;return{command:parts\[0\].trim(),result:cleanResult,language,defaultOpen}};const{command,result,language,defaultOpen}=parseChildren();const\[isOpen,setIsOpen\]=useState(defaultOpen);if(!result){return children}return \_jsxs(\`div\`,{className:\`codeblock_accordion not-prose mint-mb-4\`,children:\[\_jsx(\`div\`,{className:\`\[\u0026\>\*\]:!mint-mb-0 \[\u0026\>\*\]:!mint-rounded-b-none\`,children:\_jsx(CodeBlock,{language,children:command,wrap,expandable})}),\_jsxs(\`div\`,{className:\`see_results_container mint-border-t-0 mint-bg-gray-100/80 dark:mint-bg-gray-800/80 mint-overflow-hidden\`,style:{marginTop:\`-0.25rem\`},children:\[\_jsxs(\`button\`,{onClick:()=\>setIsOpen(!isOpen),className:\`mint-w-full mint-px-4 mint-py-2.5 mint-flex mint-items-center mint-gap-1 mint-text-left mint-text-\[14px\] mint-font-medium mint-text-gray-600 dark:mint-text-gray-400 hover:mint-text-gray-800 dark:hover:mint-text-gray-200 hover:mint-bg-gray-200/60 dark:hover:mint-bg-gray-700/60 mint-transition-all mint-duration-150\`,\\aria-expanded\\:isOpen,children:\[isOpen?\_jsx(Icon,{icon:\`caret-down\`,size:\`14\`,iconType:\`solid\`}):\_jsx(Icon,{icon:\`caret-right\`,size:\`14\`,iconType:\`solid\`}),\_jsx(\`span\`,{children:\`See result...\`})\]}),isOpen\u0026\u0026_jsx(\`div\`,{className:\`\[\u0026\>\*\]:!mint-mt-0 \[\u0026\>\*\]:!mint-rounded-t-none mint-border-t mint-border-\[var(--op-border-ui)\] dark:mint-border-\[var(--op-border-ui-dark)\]\`,children:\_jsx(CodeBlock,{language:resultLang\|\|language,children:result,wrap,expandable})})\]})\]})};const Small=({children})=\>{return \_jsx(\`small\`,{children})};function \_createMdxContent(props){const \_components={a:\`a\`,code:\`code\`,li:\`li\`,ol:\`ol\`,p:\`p\`,pre:\`pre\`,span:\`span\`,strong:\`strong\`,tbody:\`tbody\`,td:\`td\`,th:\`th\`,thead:\`thead\`,tr:\`tr\`,ul:\`ul\`,...\_provideComponents(),...props.components},{Accordion,Card,CardGroup,CodeBlock,Frame,Heading,Tab,Table,Tabs,Tip,Warning,\_MdxComponentBoundary}=\_components;if(!Accordion)\_missingMdxReference(\`Accordion\`,true);if(!Card)\_missingMdxReference(\`Card\`,true);if(!CardGroup)\_missingMdxReference(\`CardGroup\`,true);if(!CodeBlock)\_missingMdxReference(\`CodeBlock\`,true);if(!Frame)\_missingMdxReference(\`Frame\`,true);if(!Heading)\_missingMdxReference(\`Heading\`,true);if(!Tab)\_missingMdxReference(\`Tab\`,true);if(!Table)\_missingMdxReference(\`Table\`,true);if(!Tabs)\_missingMdxReference(\`Tabs\`,true);if(!Tip)\_missingMdxReference(\`Tip\`,true);if(!Warning)\_missingMdxReference(\`Warning\`,true);if(!\_MdxComponentBoundary)\_missingMdxReference(\`\_MdxComponentBoundary\`,true);return \_jsxs(\_Fragment,{children:\[\_jsx(\_components.p,{children:\`1Password CLI brings 1Password to your terminal. Learn how to install the CLI, then integrate it with your 1Password app and sign in with Touch ID, Windows Hello, or another system authentication option.\`}),\`\n\`,\_jsx(Card,{title:\`New to 1Password developer tools?\`,href:\`/get-started/developer-quickstart\`,icon:\`book-open\`,children:\_jsx(\_components.p,{children:\`Follow the developer quickstart to set up the CLI, secure your secrets, and add biometric SSH signing in one guide.\`})}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`step-1-install-1password-cli\`,children:\`Step 1: Install 1Password CLI\`}),\`\n\`,\_jsx(Accordion,{title:\`Requirements\`,id:\`requirements\`,children:\_jsxs(Tabs,{groupId:\`operating-systems\`,children:\[\_jsxs(Tab,{title:\`Mac\`,id:\`mac\`,children:\[\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`https://1password.com/pricing/password-manager\`,children:\`1Password subscription\`})}),\`\n\`,\_jsxs(\_components.li,{children:\[\_jsx(\_components.a,{href:\`https://1password.com/downloads/mac\`,children:\`1Password for Mac\`}),\`\*\`\]}),\`\n\`,\_jsx(\_components.li,{children:\`macOS Big Sur 11.0.0 or later\`}),\`\n\`\]}),\_jsx(\_components.p,{children:\`Supported shells: Bash, Zsh, sh, fish\`}),\_jsx(\_MdxComponentBoundary,{name:\`Small\`,children:\_jsx(Small,{children:\`\*Required to integrate 1Password CLI with the 1Password app.\`})})\]}),\_jsxs(Tab,{title:\`Windows\`,id:\`windows\`,children:\[\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`https://1password.com/pricing/password-manager\`,children:\`1Password subscription\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`https://1password.com/downloads/windows\`,children:\`1Password for Windows\`})}),\`\n\`\]}),\_jsx(\_components.p,{children:\`Supported shells: PowerShell\`})\]}),\_jsxs(Tab,{title:\`Linux\`,id:\`linux\`,children:\[\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`https://1password.com/pricing/password-manager\`,children:\`1Password subscription\`})}),\`\n\`,\_jsxs(\_components.li,{children:\[\_jsx(\_components.a,{href:\`https://1password.com/downloads/linux\`,children:\`1Password for Linux\`}),\`\*\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\_jsx(\_components.a,{href:\`https://github.com/polkit-org/polkit\`,children:\`PolKit\`}),\`\*\`\]}),\`\n\`,\_jsx(\_components.li,{children:\`A PolKit authentication agent running\*\`}),\`\n\`\]}),\_jsx(\_components.p,{children:\`Supported shells: Bash, Zsh, sh, fish\`}),\_jsx(\_MdxComponentBoundary,{name:\`Small\`,children:\_jsx(Small,{children:\`\*Required to integrate 1Password CLI with the 1Password app.\`})})\]})\]})}),\`\n\`,\_jsxs(Tabs,{groupId:\`operating-systems\`,children:\[\_jsx(Tab,{title:\`Mac\`,id:\`mac-2\`,\\data-child-tab-ids\\:\`\[\\homebrew\\,\\manual\\\]\`,children:\_jsxs(Tabs,{groupId:\`mac-distro\`,children:\[\_jsxs(Tab,{title:\`homebrew\`,id:\`homebrew\`,children:\[\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Use \`,\_jsx(\_components.a,{href:\`https://brew.sh/\`,children:\`Homebrew\`}),\` to install 1Password CLI:\`\]}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`brew\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` install\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` 1password-cli\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Check that 1Password CLI installed successfully:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --version\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`\]}),\_jsx(\_MdxComponentBoundary,{name:\`Small\`,children:\_jsxs(Small,{children:\[\`The \`,\_jsx(\`a\`,{href:\`https://formulae.brew.sh/cask/1password-cli\`,children:\`1Password Homebrew cask\`}),\` is maintained by both Homebrew and 1Password developers in the open-source \`,\_jsx(\_components.a,{href:\`https://github.com/Homebrew/homebrew-cask\`,children:\`Homebrew Cask repository.\`}),\` 1Password CLI downloads from our CDN on agilebits.net/.com domains. \`\]})})\]}),\_jsxs(Tab,{title:\`Manual\`,id:\`manual\`,children:\[\_jsx(\_components.p,{children:\`To manually install 1Password CLI on macOS:\`}),\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Download \`,\_jsx(\_components.a,{href:\`https://app-updates.agilebits.com/product_history/CLI2\`,children:\`the latest release of 1Password CLI\`}),\`.\`,\_jsx(\`br\`,{}),\` \`,\_jsx(\_MdxComponentBoundary,{name:\`Small\`,children:\_jsxs(Small,{children:\[\`Learn how to \`,\_jsx(\_components.a,{href:\`/cli/verify/\`,children:\`verify its authenticity\`}),\`.\`\]})})\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{\\data-no-bullet\\:\`\`,children:\[\`\n\`,\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\_jsx(\_components.strong,{children:\`Package file\`}),\`: Open \`,\_jsx(\_components.code,{children:\`op.pkg\`}),\` and install 1Password CLI in the default location (\`,\_jsx(\_components.code,{children:\`usr/local/bin\`}),\`).\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\_jsx(\_components.strong,{children:\`ZIP file\`}),\`: Open \`,\_jsx(\_components.code,{children:\`op.zip\`}),\` and unzip the file, then move \`,\_jsx(\_components.code,{children:\`op\`}),\` to \`,\_jsx(\_components.code,{children:\`usr/local/bin\`}),\`.\`\]}),\`\n\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Check that 1Password CLI was installed successfully:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --version\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`\]})\]})\]})}),\_jsx(Tab,{title:\`Windows\`,id:\`windows-2\`,\\data-child-tab-ids\\:\`\[\\winget\\,\\manual-2\\\]\`,children:\_jsxs(Tabs,{groupId:\`windows-distro\`,children:\[\_jsx(Tab,{title:\`winget\`,id:\`winget\`,children:\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`To install 1Password CLI with winget:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`powershell\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`powershell\`,children:\_jsxs(\_components.code,{language:\`powershell\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`winget install 1password\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`-\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`cli\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Check that 1Password CLI installed successfully:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`powershell\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`powershell\`,children:\_jsxs(\_components.code,{language:\`powershell\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`op \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`--\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`version\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`\]})}),\_jsxs(Tab,{title:\`Manual\`,id:\`manual-2\`,children:\[\_jsx(\_components.p,{children:\`To manually install 1Password CLI on Windows:\`}),\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Download \`,\_jsx(\_components.a,{href:\`https://app-updates.agilebits.com/product_history/CLI2\`,children:\`the latest release of 1Password CLI\`}),\` and extract \`,\_jsx(\_components.code,{children:\`op.exe\`}),\`.\`,\_jsx(\`br\`,{}),\` \`,\_jsx(\_MdxComponentBoundary,{name:\`Small\`,children:\_jsxs(Small,{children:\[\`Learn how to \`,\_jsx(\_components.a,{href:\`/cli/verify/\`,children:\`verify its authenticity\`}),\`.\`\]})})\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Open PowerShell \`,\_jsx(\_components.strong,{children:\`as an administrator\`}),\`.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Create a folder to move \`,\_jsx(\_components.code,{children:\`op.exe\`}),\` into. For example, \`,\_jsx(\_components.code,{children:\`C:\\\\Program Files\\\\1Password CLI\`}),\`.\`\]}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`powershell\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`powershell\`,children:\_jsxs(\_components.code,{language:\`powershell\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`mkdir \`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`\\C:\\\\Program Files\\\\1Password CLI\\\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Move the \`,\_jsx(\_components.code,{children:\`op.exe\`}),\` file to the new folder.\`\]}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`powershell\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`powershell\`,children:\_jsxs(\_components.code,{language:\`powershell\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`mv \`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`\\.\\\\op.exe\\\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\C:\\\\Program Files\\\\1Password CLI\\\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(Accordion,{title:\`Add the folder containing the op.exe file to your PATH.\`,id:\`add-the-folder-containing-the-op-exe-file-to-your-path\`,children:\[\_jsx(\_components.p,{children:\_jsx(\_components.strong,{children:\`Windows 10 and later\`})}),\_jsxs(\`ol\`,{style:{listStyleType:\`decimal\`},children:\[\_jsxs(\`li\`,{children:\[\`Search for \`,\_jsx(\`strong\`,{children:\`Advanced System Settings\`}),\` in the Start menu.\`\]}),\_jsxs(\`li\`,{children:\[\`Select \`,\_jsx(\`strong\`,{children:\`Environment Variables\`}),\`.\`\]}),\_jsxs(\`li\`,{children:\[\`In the System Variables section, select the \`,\_jsx(\`strong\`,{children:\`PATH\`}),\` environment variable and select \`,\_jsx(\`strong\`,{children:\`Edit\`}),\`.\`\]}),\_jsxs(\`li\`,{children:\[\`In the prompt, select \`,\_jsx(\`strong\`,{children:\`New\`}),\` and add the directory where \`,\_jsx(\`code\`,{children:\`op.exe\`}),\` \`,\` is located.\`\]}),\_jsx(\`li\`,{children:\`Sign out and back in to Windows for the change to take effect.\`})\]})\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Check that 1Password CLI installed successfully:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --version\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`\]}),\_jsx(\_components.p,{children:\`If you’d rather install 1Password CLI with a single block of commands, run the following in PowerShell as an administrator. On ARM devices, use winget to install 1Password CLI instead.\`}),\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`17\`,language:\`powershell\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`powershell\`,children:\_jsxs(\_components.code,{language:\`powershell\`,numberOfLines:\`17\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$arch\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#C586C0\`},children:\` if\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` (\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`env:\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`PROCESSOR_ARCHITEW6432\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`) { \`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`env:\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`PROCESSOR_ARCHITEW6432\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` } \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#C586C0\`},children:\`else\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` { \`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`env:\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`PROCESSOR_ARCHITECTURE\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` }\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#C586C0\`},children:\`switch\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` (\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$arch\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`) {\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` 'AMD64'\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` { \`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$opArch\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` 'amd64'\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`; \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#C586C0\`},children:\`break\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` }\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` 'x86'\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` { \`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$opArch\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` '386'\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`; \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#C586C0\`},children:\`break\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` }\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` 'ARM64'\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` { \`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`Write-Error\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\On ARM devices, install 1Password CLI with winget instead: winget install 1password-cli\\\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` -\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`ErrorAction Stop }\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#C586C0\`},children:\` Default\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` { \`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`Write-Error\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\Sorry, your operating system architecture '\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$arch\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`' is unsupported\\\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` -\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`ErrorAction Stop }\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`}\`})}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$installDir\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` Join-Path\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` -\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`Path \`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`env:\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`ProgramFiles\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` -\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`ChildPath \`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`'1Password CLI'\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$opVersion\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\v\\\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` +\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` (\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`Invoke-RestMethod\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` -\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`Uri \`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`'https://app-updates.agilebits.com/check/1/0/CLI2/en/2.0.0/N'\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`).version\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#C586C0\`},children:\`if\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` (\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$opVersion\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` -notmatch\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` '^v\\\\d+\\\\.\\\\d+\\\\.\\\\d+\$'\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`) { \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#C586C0\`},children:\`throw\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\Couldn't determine the latest 1Password CLI version\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` }\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`Invoke-WebRequest\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` -\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`Uri \`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`\\https://cache.agilebits.com/dist/1P/op2/pkg/\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$opVersion\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`/op_windows\_\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#569CD6\`},children:\`\$(\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$opArch\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#569CD6\`},children:\`)\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`\_\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$opVersion\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`.zip\\\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` -\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`OutFile op.zip\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`Expand-Archive\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` -\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`Path op.zip \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`-\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`DestinationPath \`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$installDir\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` -\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`Force\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$envMachinePath\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \[\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#569CD6\`},children:\`System.Environment\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\]::GetEnvironmentVariable(\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`'PATH'\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`,\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`'machine'\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`)\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#C586C0\`},children:\`if\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` (\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$envMachinePath\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` -split\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` ';'\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` -notcontains\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` \$installDir\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`){\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \[\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#569CD6\`},children:\`Environment\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\]::SetEnvironmentVariable(\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`'PATH'\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`,\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$envMachinePath\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`;\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$installDir\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`\\\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`,\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` 'Machine'\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`)\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`}\`})}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`Remove-Item\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` -\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`Path op.zip\`})\]}),\`\n\`\]})})})\]})\]})}),\_jsx(Tab,{title:\`Linux\`,id:\`linux-2\`,\\data-child-tab-ids\\:\`\[\\apt\\,\\yum\\,\\alpine\\,\\nixos\\,\\manual-3\\\]\`,children:\_jsxs(Tabs,{groupId:\`linux-distro\`,children:\[\_jsxs(Tab,{title:\`APT\`,id:\`apt\`,children:\[\_jsx(\_components.p,{children:\`To install 1Password CLI using APT on Debian- and Ubuntu-based distributions:\`}),\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Run the following command:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`11\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`11\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`curl\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -sS\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` https://downloads.1password.com/linux/keys/1password.asc\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \|\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\` \\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` gpg\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --dearmor\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --output\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` /usr/share/keyrings/1password-archive-keyring.gpg\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u0026\u0026 \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\`\\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` echo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\deb \[arch=\$(\`}),\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`dpkg\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --print-architecture\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg\] https://downloads.1password.com/linux/debian/\$(\`}),\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`dpkg\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --print-architecture\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`) stable main\\\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \|\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\` \\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` tee\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` /etc/apt/sources.list.d/1password.list\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u0026\u0026 \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\`\\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` mkdir\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -p\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` /etc/debsig/policies/AC2D62742012EA22/\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u0026\u0026 \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\`\\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` curl\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -sS\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` https://downloads.1password.com/linux/debian/debsig/1password.pol\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \|\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\` \\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` tee\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` /etc/debsig/policies/AC2D62742012EA22/1password.pol\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u0026\u0026 \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\`\\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` mkdir\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -p\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` /usr/share/debsig/keyrings/AC2D62742012EA22\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u0026\u0026 \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\`\\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` curl\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -sS\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` https://downloads.1password.com/linux/keys/1password.asc\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \|\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\` \\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` gpg\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --dearmor\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --output\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u0026\u0026 \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\`\\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` apt\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` update\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u0026\u0026 \`}),\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` apt\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` install\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` 1password-cli\`})\]}),\`\n\`\]})})}),\`\n\`,\_jsx(Accordion,{title:\`See a step-by-step version of the script\`,id:\`see-a-step-by-step-version-of-the-script\`,children:\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Add the key for the 1Password \`,\_jsx(\_components.code,{children:\`apt\`}),\` repository:\`\]}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`2\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`2\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`curl\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -sS\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` https://downloads.1password.com/linux/keys/1password.asc\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \|\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\` \\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` gpg\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --dearmor\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --output\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` /usr/share/keyrings/1password-archive-keyring.gpg\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Add the 1Password \`,\_jsx(\_components.code,{children:\`apt\`}),\` repository:\`\]}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`2\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`2\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`echo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\deb \[arch=\$(\`}),\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`dpkg\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --print-architecture\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`) signed-by=/usr/share/keyrings/1password-archive-keyring.gpg\] https://downloads.1password.com/linux/debian/\$(\`}),\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`dpkg\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --print-architecture\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`) stable main\\\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \|\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` tee\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` /etc/apt/sources.list.d/1password.list\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Add the debsig-verify policy:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`6\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`6\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` mkdir\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -p\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` /etc/debsig/policies/AC2D62742012EA22/\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` curl\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -sS\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` https://downloads.1password.com/linux/debian/debsig/1password.pol\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \|\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\` \\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` tee\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` /etc/debsig/policies/AC2D62742012EA22/1password.pol\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u0026\u0026 \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\`\\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` mkdir\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -p\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` /usr/share/debsig/keyrings/AC2D62742012EA22\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u0026\u0026 \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\`\\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` curl\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -sS\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` https://downloads.1password.com/linux/keys/1password.asc\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \|\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\` \\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` gpg\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --dearmor\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --output\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Install 1Password CLI:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` apt\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` update\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u0026\u0026 \`}),\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` apt\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` install\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` 1password-cli\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`\]})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Check that 1Password CLI installed successfully:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --version\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`\]}),\_jsxs(\_components.p,{children:\[\`Alternatively, download the latest 1Password CLI \`,\_jsx(\_components.code,{children:\`.deb\`}),\` package directly from one of the following links:\`\]}),\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`https://downloads.1password.com/linux/debian/amd64/stable/1password-cli-amd64-latest.deb\`,children:\`amd64\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`https://downloads.1password.com/linux/debian/386/stable/1password-cli-386-latest.deb\`,children:\`386\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`https://downloads.1password.com/linux/debian/arm/stable/1password-cli-arm-latest.deb\`,children:\`arm\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`https://downloads.1password.com/linux/debian/arm64/stable/1password-cli-arm64-latest.deb\`,children:\`arm64\`})}),\`\n\`\]})\]}),\_jsxs(Tab,{title:\`YUM\`,id:\`yum\`,children:\[\_jsx(\_components.p,{children:\`To install 1Password CLI using YUM on RPM-based distributions:\`}),\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Run the following commands:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`3\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`3\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` rpm\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --import\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` https://downloads.1password.com/linux/keys/1password.asc\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` sh\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` 'echo -e \\\[1password\]\\\\nname=1Password Stable Channel\\\\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\\\\\$basearch\\\\nenabled=1\\\\ngpgcheck=1\\\\nrepo_gpgcheck=1\\\\ngpgkey=\\\\\\https://downloads.1password.com/linux/keys/1password.asc\\\\\\\\ \> /etc/yum.repos.d/1password.repo'\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` dnf\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` check-update\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -y\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` 1password-cli\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u0026\u0026 \`}),\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` dnf\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` install\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` 1password-cli\`})\]}),\`\n\`\]})})}),\`\n\`,\_jsx(Accordion,{title:\`The above script is comprised of the following steps\`,id:\`the-above-script-is-comprised-of-the-following-steps\`,children:\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Import the public key:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` rpm\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --import\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` https://downloads.1password.com/linux/keys/1password.asc\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Configure the repository information:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` sh\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` 'echo -e \\\[1password\]\\\\nname=1Password Stable Channel\\\\nbaseurl=https://downloads.1password.com/linux/rpm/stable/\\\\\$basearch\\\\nenabled=1\\\\ngpgcheck=1\\\\nrepo_gpgcheck=1\\\\ngpgkey=\\\\\\https://downloads.1password.com/linux/keys/1password.asc\\\\\\\\ \> /etc/yum.repos.d/1password.repo'\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Install 1Password CLI:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` dnf\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` check-update\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -y\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` 1password-cli\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u0026\u0026 \`}),\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` dnf\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` install\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` 1password-cli\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`\]})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Check that 1Password CLI installed successfully:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --version\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`\]}),\_jsxs(\_components.p,{children:\[\`Alternatively, download the latest 1Password CLI \`,\_jsx(\_components.code,{children:\`.rpm\`}),\` package directly from one of the following links:\`\]}),\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`https://downloads.1password.com/linux/rpm/stable/x86_64/1password-cli-latest.x86_64.rpm\`,children:\`x86_64\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`https://downloads.1password.com/linux/rpm/stable/i386/1password-cli-latest.i386.rpm\`,children:\`i386\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`https://downloads.1password.com/linux/rpm/stable/aarch64/1password-cli-latest.aarch64.rpm\`,children:\`aarch64\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`https://downloads.1password.com/linux/rpm/stable/armv7l/1password-cli-latest.armv7l.rpm\`,children:\`armv7l\`})}),\`\n\`\]})\]}),\_jsxs(Tab,{title:\`Alpine\`,id:\`alpine\`,children:\[\_jsx(\_components.p,{children:\`To install 1Password CLI on Alpine x86_64 distributions:\`}),\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Run the following commands:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`3\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`3\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`echo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` https://downloads.1password.com/linux/alpinelinux/stable/\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \>\>\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` /etc/apk/repositories\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`wget\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` https://downloads.1password.com/linux/keys/alpinelinux/support@1password.com-61ddfc31.rsa.pub\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -P\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` /etc/apk/keys\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`apk\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` update\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u0026\u0026 \`}),\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`apk\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` add\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` 1password-cli\`})\]}),\`\n\`\]})})}),\`\n\`,\_jsx(Accordion,{title:\`The above script is comprised of the following steps\`,id:\`the-above-script-is-comprised-of-the-following-steps-1\`,children:\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Add Password CLI to your list of repositories:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`echo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` https://downloads.1password.com/linux/alpinelinux/stable/\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \>\>\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` /etc/apk/repositories\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Add the public key to validate the APK to your keys directory:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`wget\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` https://downloads.1password.com/linux/keys/alpinelinux/support@1password.com-61ddfc31.rsa.pub\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -P\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` /etc/apk/keys\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Install 1Password CLI:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`apk\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` update\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u0026\u0026 \`}),\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`apk\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` add\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` 1password-cli\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`\]})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Check that 1Password CLI installed successfully:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --version\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`\]})\]}),\_jsxs(Tab,{title:\`NixOS\`,id:\`nixos\`,children:\[\_jsx(Warning,{children:\_jsx(\_components.p,{children:\`The Nix package is available from the NixOS open source community.\`})}),\_jsx(\_components.p,{children:\`To install 1Password CLI on your NixOS system:\`}),\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Add 1Password to your \`,\_jsx(\_components.code,{children:\`/etc/nixos/configuration.nix\`}),\` file, or \`,\_jsx(\_components.code,{children:\`flake.nix\`}),\` if you’re using a flake. For example, the following snippet includes 1Password CLI and the 1Password app:\`\]}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`14\`,language:\`nix\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`nix\`,children:\_jsxs(\_components.code,{language:\`nix\`,numberOfLines:\`14\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#6E7781\`,\\--shiki-dark\\:\`#6A9955\`},children:\`# NixOS has built-in modules to enable 1Password\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#6E7781\`,\\--shiki-dark\\:\`#6A9955\`},children:\`# along with some pre-packaged configuration to make\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#6E7781\`,\\--shiki-dark\\:\`#6A9955\`},children:\`# it work nicely. You can search what options exist\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#6E7781\`,\\--shiki-dark\\:\`#6A9955\`},children:\`# in NixOS at https://search.nixos.org/options\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#6E7781\`,\\--shiki-dark\\:\`#6A9955\`},children:\`# Enables the 1Password CLI\`})}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`programs\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`.\`}),\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\_1password\`}),\_jsx(\_components.span,{style:{color:\`#82071E\`,\\--shiki-light-font-style\\:\`italic\`,\\--shiki-dark\\:\`#F44747\`,\\--shiki-dark-font-style\\:\`inherit\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` { \`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`enable\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` true\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`; }\`}),\_jsx(\_components.span,{style:{color:\`#82071E\`,\\--shiki-light-font-style\\:\`italic\`,\\--shiki-dark\\:\`#F44747\`,\\--shiki-dark-font-style\\:\`inherit\`},children:\`;\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#6E7781\`,\\--shiki-dark\\:\`#6A9955\`},children:\`# Enables the 1Password desktop app\`})}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`programs\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`.\`}),\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\_1password-gui\`}),\_jsx(\_components.span,{style:{color:\`#82071E\`,\\--shiki-light-font-style\\:\`italic\`,\\--shiki-dark\\:\`#F44747\`,\\--shiki-dark-font-style\\:\`inherit\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` {\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`enable\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` true\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`;\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#6E7781\`,\\--shiki-dark\\:\`#6A9955\`},children:\`# this makes system auth etc. work properly\`})}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`polkitPolicyOwners\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \[ \`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`\\\u003cyour-linux-username\>\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \];\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`}\`}),\_jsx(\_components.span,{style:{color:\`#82071E\`,\\--shiki-light-font-style\\:\`italic\`,\\--shiki-dark\\:\`#F44747\`,\\--shiki-dark-font-style\\:\`inherit\`},children:\`;\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`After you make changes to your configuration file, apply them:\`}),\`\n\`,\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`If you added 1Password to \`,\_jsx(\_components.code,{children:\`/etc.nixos/configuration.nix\`}),\`, run:\`\]}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` nixos-rebuild\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` switch\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`If you added 1Password to \`,\_jsx(\_components.code,{children:\`flake.nix\`}),\`, replace \`,\_jsx(\_components.code,{children:\`\u003cflake-directory-path\>\`}),\` with the directory your flake is in and \`,\_jsx(\_components.code,{children:\`\u003coutput-name\>\`}),\` with the name of the flake output containing your system configuration, then run the command.\`\]}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` nixos-rebuild\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` switch\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --flake\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u003c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`flake-directory-pat\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`h\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`.#\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\u003c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`output-nam\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`e\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Check that 1Password CLI installed successfully:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --version\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`\]}),\_jsxs(\_components.p,{children:\[\`Learn more about \`,\_jsx(\_components.a,{href:\`https://nixos.wiki/wiki/1Password\`,children:\`using 1Password on NixOS.\`})\]})\]}),\_jsxs(Tab,{title:\`Manual\`,id:\`manual-3\`,children:\[\_jsx(\_components.p,{children:\`You can run the following block of commands in your terminal to install 1Password CLI on Linux without a package manager.\`}),\_jsxs(\_components.p,{children:\[\`Before you run it, replace \`,\_jsx(\_components.code,{children:\`\u003cyour-architecture\>\`}),\` on the highlighted line. If you’re not sure which one you need, run \`,\_jsx(\_components.code,{children:\`uname -m\`}),\`, then use the table to find the matching 1Password CLI build.\`\]}),\_jsxs(Table,{children:\[\_jsx(\_components.thead,{children:\_jsxs(\_components.tr,{children:\[\_jsxs(\_components.th,{children:\[\`If \`,\_jsx(\_components.code,{children:\`uname -m\`}),\` returns\`\]}),\_jsxs(\_components.th,{children:\[\`Replace \`,\_jsx(\_components.code,{children:\`\u003cyour-architecture\>\`}),\` with\`\]})\]})}),\_jsxs(\_components.tbody,{children:\[\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`x86_64\`})}),\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`amd64\`})})\]}),\_jsxs(\_components.tr,{children:\[\_jsxs(\_components.td,{children:\[\_jsx(\_components.code,{children:\`aarch64\`}),\` or \`,\_jsx(\_components.code,{children:\`arm64\`})\]}),\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`arm64\`})})\]}),\_jsxs(\_components.tr,{children:\[\_jsxs(\_components.td,{children:\[\_jsx(\_components.code,{children:\`armv7l\`}),\` or \`,\_jsx(\_components.code,{children:\`armv6l\`})\]}),\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`arm\`})})\]}),\_jsxs(\_components.tr,{children:\[\_jsxs(\_components.td,{children:\[\_jsx(\_components.code,{children:\`i386\`}),\` or \`,\_jsx(\_components.code,{children:\`i686\`})\]}),\_jsx(\_components.td,{\\data-numeric\\:\`true\`,children:\_jsx(\_components.code,{children:\`386\`})})\]})\]})\]}),\_jsx(CodeBlock,{filename:\`\`,highlight:\`\[2\]\`,numberOfLines:\`11\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`11\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#6E7781\`,\\--shiki-dark\\:\`#6A9955\`},children:\`# Replace \u003cyour-architecture\> with amd64, arm64, arm, or 386\`})}),\`\n\`,\_jsxs(\_components.span,{className:\`line line-highlight\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`ARCH\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`=\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`\\\u003cyour-architecture\>\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u0026\u0026 \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\`\\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`OP_VERSION\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`=\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`\\v\$(\`}),\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`wget\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -qO-\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` https://app-updates.agilebits.com/check/1/0/CLI2/en/2.0.0/N \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\|\`}),\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` grep\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -Eo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` '\[0-9\]+\\\\.\[0-9\]+\\\\.\[0-9\]+' \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\|\`}),\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` head\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -n1\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`)\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u0026\u0026 \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\`\\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\[ \`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$OP_VERSION\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`\\\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` !=\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\v\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \] \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\|\|\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` { \`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`echo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\Couldn't determine the latest 1Password CLI version\\\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \>\u00262\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`; \`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`exit\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#B5CEA8\`},children:\` 1\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`; } \u0026\u0026 \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\`\\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`wget\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:' \\https://cache.agilebits.com/dist/1P/op2/pkg/\${'}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`OP_VERSION\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\\}/op_linux\_\${\\}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`ARCH\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\\}\_\${\\}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`OP_VERSION\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`}.zip\\\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -O\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` op.zip\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u0026\u0026 \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\`\\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`unzip\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -d\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` op.zip\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u0026\u0026 \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\`\\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` mv\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` op/op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` /usr/local/bin/\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u0026\u0026 \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\`\\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`rm\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -r\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` op.zip\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` op\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u0026\u0026 \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\`\\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` groupadd\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -f\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` onepassword-cli\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u0026\u0026 \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\`\\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` chgrp\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` onepassword-cli\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` /usr/local/bin/op\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u0026\u0026 \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\`\\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` chmod\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` g+s\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` /usr/local/bin/op\`})\]}),\`\n\`\]})})}),\_jsx(Accordion,{title:\`Or follow the extended guide\`,id:\`or-follow-the-extended-guide\`,children:\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Download the \`,\_jsx(\_components.a,{href:\`https://app-updates.agilebits.com/product_history/CLI2\`,children:\`latest release of 1Password CLI\`}),\` and extract it. To verify its authenticity:\`\]}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`2\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`2\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`gpg\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --keyserver\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` keyserver.ubuntu.com\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --receive-keys\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` 3FEF9748469ADBE15DA7CA80AC2D62742012EA22\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`gpg\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --verify\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` op.sig\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` op\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Move \`,\_jsx(\_components.code,{children:\`op\`}),\` to \`,\_jsx(\_components.code,{children:\`/usr/local/bin\`}),\`, or another directory in your \`,\_jsx(\_components.code,{children:\`\$PATH\`}),\`.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Check that 1Password CLI installed successfully:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --version\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Create the \`,\_jsx(\_components.code,{children:\`onepassword-cli\`}),\` group if it doesn’t yet exist:\`\]}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` groupadd\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` onepassword-cli\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Set the correct permissions on the \`,\_jsx(\_components.code,{children:\`op\`}),\` binary:\`\]}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`2\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`2\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` chgrp\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` onepassword-cli\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` /usr/local/bin/op\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u0026\u0026 \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\`\\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`sudo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` chmod\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` g+s\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` /usr/local/bin/op\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`\]})})\]})\]})})\]}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`step-2-turn-on-the-1password-desktop-app-integration\`,children:\`Step 2: Turn on the 1Password desktop app integration\`}),\`\n\`,\_jsxs(Tabs,{groupId:\`operating-systems\`,children:\[\_jsx(Tab,{title:\`Mac\`,id:\`mac-3\`,children:\_jsxs(CardGroup,{cols:2,children:\[\_jsx(\`div\`,{children:\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`Open and unlock the \`,\_jsx(\_components.a,{href:\`https://1password.com/downloads/\`,children:\`1Password app\`}),\`.\`\]}),\`\n\`,\_jsx(\_components.li,{children:\`Select your account or collection at the top of the sidebar.\`}),\`\n\`,\_jsxs(\_components.li,{children:\[\`Navigate to \`,\_jsx(\_components.strong,{children:\`Settings\`}),\` \> \`,\_jsx(\_components.strong,{children:\_jsx(\_components.a,{href:\`onepassword://settings/developers\`,children:\`Developer\`})}),\`.\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`Select \`,\_jsx(\_components.strong,{children:\`Integrate with 1Password CLI\`}),\`.\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`If you want to authenticate 1Password CLI with your fingerprint, turn on \`,\_jsx(\_components.strong,{children:\_jsx(\_components.a,{href:\`https://support.1password.com/touch-id-mac/\`,children:\`Touch ID\`})}),\` in the app.\`\]}),\`\n\`\]})}),\_jsx(\`div\`,{children:\_jsx(Frame,{children:\_jsx(\_MdxComponentBoundary,{name:\`Image\`,children:\_jsx(Image,{border:true,round:true,alt:\`The 1Password Developer settings pane with the Integrate with 1Password CLI option selected.\`,src:\`/static/img/developer-integrations-cli-light.png\`,darkSrc:\`/static/img/developer-integrations-cli-dark.png\`})})})})\]})}),\_jsx(Tab,{title:\`Windows\`,id:\`windows-3\`,children:\_jsxs(CardGroup,{cols:2,children:\[\_jsx(\`div\`,{children:\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`Open and unlock the \`,\_jsx(\_components.a,{href:\`https://1password.com/downloads/\`,children:\`1Password app\`}),\`.\`\]}),\`\n\`,\_jsx(\_components.li,{children:\`Select your account or collection at the top of the sidebar.\`}),\`\n\`,\_jsxs(\_components.li,{children:\[\`Turn on \`,\_jsx(\_components.strong,{children:\_jsx(\_components.a,{href:\`https://support.1password.com/windows-hello/\`,children:\`Windows Hello\`})}),\` in the app.\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`Navigate to \`,\_jsx(\_components.strong,{children:\`Settings\`}),\` \> \`,\_jsx(\_components.strong,{children:\_jsx(\_components.a,{href:\`onepassword://settings/developers\`,children:\`Developer\`})}),\`.\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`Select \`,\_jsx(\_components.strong,{children:\`Integrate with 1Password CLI\`}),\`.\`\]}),\`\n\`\]})}),\_jsx(\`div\`,{children:\_jsx(Frame,{children:\_jsx(\_MdxComponentBoundary,{name:\`Image\`,children:\_jsx(Image,{border:true,alt:\`The 1Password Developer settings pane with the Integrate with 1Password CLI option selected.\`,src:\`/static/img/developer-integrations-cli-light.png\`,darkSrc:\`/static/img/developer-integrations-cli-dark.png\`})})})})\]})}),\_jsx(Tab,{title:\`Linux\`,id:\`linux-3\`,children:\_jsxs(CardGroup,{cols:2,children:\[\_jsx(\`div\`,{children:\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`Open and unlock the \`,\_jsx(\_components.a,{href:\`https://1password.com/downloads/\`,children:\`1Password app\`}),\`.\`\]}),\`\n\`,\_jsx(\_components.li,{children:\`Select your account or collection at the top of the sidebar.\`}),\`\n\`,\_jsxs(\_components.li,{children:\[\`Navigate to \`,\_jsx(\_components.strong,{children:\`Settings\`}),\` \> \`,\_jsx(\_components.strong,{children:\_jsx(\_components.a,{href:\`onepassword://settings/security\`,children:\`Security\`})}),\`.\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`Turn on \`,\_jsx(\_components.strong,{children:\_jsx(\_components.a,{href:\`https://support.1password.com/system-authentication-linux/\`,children:\`Unlock using system authentication\`})}),\`.\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`Navigate to \`,\_jsx(\_components.strong,{children:\`Settings\`}),\` \> \`,\_jsx(\_components.strong,{children:\_jsx(\_components.a,{href:\`onepassword://settings/developers\`,children:\`Developer\`})}),\`.\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`Select \`,\_jsx(\_components.strong,{children:\`Integrate with 1Password CLI\`}),\`.\`\]}),\`\n\`\]})}),\_jsx(\`div\`,{children:\_jsx(Frame,{children:\_jsx(\_MdxComponentBoundary,{name:\`Image\`,children:\_jsx(Image,{border:true,alt:\`The 1Password Developer settings pane with the Integrate with 1Password CLI option selected.\`,src:\`/static/img/developer-integrations-cli-light.png\`,darkSrc:\`/static/img/developer-integrations-cli-dark.png\`})})})})\]})})\]}),\`\n\`,\_jsx(\_components.p,{children:\_jsx(\_components.a,{href:\`/cli/app-integration/\`,children:\`Learn more about the 1Password desktop app integration.\`})}),\`\n\`,\_jsx(Tip,{children:\_jsxs(\_components.p,{children:\[\`You can also authenticate 1Password CLI using a \`,\_jsx(\_components.a,{href:\`/service-accounts/get-started\`,children:\`service account token\`}),\` scoped to specific vaults or Environments. We recommend using service accounts for shared building, automated access, and headless server authentication.\`\]})}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`step-3-enter-any-command-to-sign-in\`,children:\`Step 3: Enter any command to sign in\`}),\`\n\`,\_jsx(Frame,{children:\_jsx(\`video\`,{loop:true,autoPlay:true,muted:true,playsInline:true,children:\_jsx(\`source\`,{type:\`video/mp4\`,src:\`https://mintcdn.com/ab-634991b8/MKy6sgNGqMk-yGDS/static/videos/auth-prompt.mp4?fit=max\u0026auto=format\u0026n=MKy6sgNGqMk-yGDS\u0026q=85\u0026s=8c2d961717ae9db95db4505dc0ea0832\`,width:\`600px\`,\\data-path\\:\`static/videos/auth-prompt.mp4\`})})}),\`\n\`,\_jsx(\_components.p,{children:\`After you’ve turned on the app integration, enter any command and you’ll be prompted to authenticate. For example, run this command to see all the vaults in your account:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` vault\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` list\`})\]}),\`\n\`\]})})}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`if-you-have-multiple-accounts\`,children:\`If you have multiple accounts\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`If you’ve added multiple 1Password accounts to your desktop app, you can use \`,\_jsx(\_components.a,{href:\`/cli/reference/commands/signin/\`,children:\_jsx(\_components.code,{children:\`op signin\`})}),\` to select an account to sign in to with 1Password CLI. Use the arrow keys to choose from the list of all accounts added to your 1Password app.\`\]}),\`\n\`,\_jsx(\_MdxComponentBoundary,{name:\`CodeResult\`,children:\_jsx(CodeResult,{children:\_jsx(CodeBlock,{filename:\`\`,highlight:\`\[2\]\`,numberOfLines:\`6\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`6\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` signin\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line line-highlight\`,children:\_jsx(\_components.span,{style:{color:\`#6E7781\`,\\--shiki-dark\\:\`#6A9955\`},children:\`#code-result\`})}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`Select\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` account\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \[Use \`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`arrows\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` to\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` move,\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` type\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` to\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` filter\]\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` ACME Corp (\`}),\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`acme.1password.com\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`)\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` AgileBits\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` (agilebits.1password.com)\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` Add\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` another\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` account\`})\]}),\`\n\`\]})})})})}),\`\n\`,\_jsx(\_components.p,{children:\_jsx(\_components.a,{href:\`/cli/use-multiple-accounts/\`,children:\`Learn more about using multiple accounts with 1Password CLI.\`})}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`next-steps\`,children:\`Next steps\`}),\`\n\`,\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/cli/reference/\`,children:\`Get started with basic 1Password CLI commands.\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/cli/shell-plugins/\`,children:\`Set up 1Password Shell Plugins to handle authentication for your other command-line tools.\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/cli/secret-references/\`,children:\`Learn how to securely load secrets from your 1Password account without putting any plaintext secrets in code.\`})}),\`\n\`\]}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`learn-more\`,children:\`Learn more\`}),\`\n\`,\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/cli/app-integration/#troubleshooting\`,children:\`1Password app integration troubleshooting\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/cli/app-integration-security/\`,children:\`1Password app integration security\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/cli/config-directories\`,children:\`How 1Password CLI detects configuration directories\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/get-started/developer-quickstart\`,children:\`Developer quickstart\`})}),\`\n\`\]})\]})}function MDXContent(props={}){const{wrapper:MDXLayout}={...\_provideComponents(),...props.components};return MDXLayout?\_jsx(MDXLayout,{...props,children:\_jsx(\_createMdxContent,{...props})}):\_createMdxContent(props)}return{Image,CodeResult,Small,default:MDXContent};function \_missingMdxReference(id,component){throw new Error(\`Expected \`+(component?\`component\`:\`object\`)+\\ \`\\+id+\\\` to be defined: you likely forgot to import, pass, or provide it.\\)}","frontmatter":{},"scope":{"config":{},"pageMetadata":{"id":"get-started","title":"Get started with 1Password CLI","sidebarTitle":"Get started","og:description":"Learn how to install and sign in to 1Password CLI, then get started with commands and scripts to manage users, vaults, and items on the command line.","slug":"/cli/get-started","description":null,"href":"/cli/get-started"}}},"mdxSourceWithNoJs":null,"noJsSplices":\[\[141,3819,")=\>null;const CodeResult=()=\>null;const "\]\]},"mdxExtracts":{"tableOfContents":\[{"title":"Step 1: Install 1Password CLI","slug":"step-1-install-1password-cli","depth":2,"children":\[\]},{"title":"Step 2: Turn on the 1Password desktop app integration","slug":"step-2-turn-on-the-1password-desktop-app-integration","depth":2,"children":\[\]},{"title":"Step 3: Enter any command to sign in","slug":"step-3-enter-any-command-to-sign-in","depth":2,"children":\[{"title":"If you have multiple accounts","slug":"if-you-have-multiple-accounts","depth":4,"children":\[\]}\]},{"title":"Next steps","slug":"next-steps","depth":2,"children":\[\]},{"title":"Learn more","slug":"learn-more","depth":2,"children":\[\]}\],"codeExamples":{}},"jsLinks":\["/\_mintlify/custom/ab-634991b8/5ebc0d10523e8210/static/js/analytics.js","/\_mintlify/custom/ab-634991b8/5bb7437b1c9dcb44/static/js/gtag-prod-sst.js","/\_mintlify/custom/ab-634991b8/ee8ea0eeb20ecd1e/static/js/gtag-sst.js","/\_mintlify/custom/ab-634991b8/f2b239f3d459dc67/api-sdk-terms-notice.js","/\_mintlify/custom/ab-634991b8/3604035e212f8294/homepage-card-icons.js"\],"dynamicCss":".mint-mx-4 {\n margin-left: 1rem;\n margin-right: 1rem\n}\n.mint-mb-4 {\n margin-bottom: 1rem\n}\n.mint-flex {\n display: flex\n}\n.mint-hidden {\n display: none\n}\n.mint-w-full {\n width: 100%\n}\n.mint-items-center {\n align-items: center\n}\n.mint-gap-1 {\n gap: 0.25rem\n}\n.mint-overflow-hidden {\n overflow: hidden\n}\n.mint-rounded-lg {\n border-radius: 0.5rem\n}\n.mint-rounded-sm {\n border-radius: 0.125rem\n}\n.mint-border-t {\n border-top-width: 1px\n}\n.mint-border-t-0 {\n border-top-width: 0px\n}\n.mint-border-\\\[var\\(--op-border-ui\\)\\\] {\n border-color: var(--op-border-ui)\n}\n.mint-bg-gray-100\\/80 {\n background-color: rgb(243 244 246 / 0.8)\n}\n.mint-px-4 {\n padding-left: 1rem;\n padding-right: 1rem\n}\n.mint-py-2\\.5 {\n padding-top: 0.625rem;\n padding-bottom: 0.625rem\n}\n.mint-text-left {\n text-align: left\n}\n.mint-text-\\\[14px\\\] {\n font-size: 14px\n}\n.mint-font-medium {\n font-weight: 500\n}\n.mint-text-gray-600 {\n --tw-text-opacity: 1;\n color: rgb(75 85 99 / var(--tw-text-opacity, 1))\n}\n.mint-transition-all {\n transition-property: all;\n transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);\n transition-duration: 150ms\n}\n.mint-duration-150 {\n transition-duration: 150ms\n}\n.hover\\:mint-bg-gray-200\\/60:hover {\n background-color: rgb(229 231 235 / 0.6)\n}\n.hover\\:mint-text-gray-800:hover {\n --tw-text-opacity: 1;\n color: rgb(31 41 55 / var(--tw-text-opacity, 1))\n}\n.dark\\:mint-block:is(.dark \*) {\n display: block\n}\n.dark\\:mint-hidden:is(.dark \*) {\n display: none\n}\n.dark\\:mint-border-\\\[var\\(--op-border-ui-dark\\)\\\]:is(.dark \*) {\n border-color: var(--op-border-ui-dark)\n}\n.dark\\:mint-bg-gray-800\\/80:is(.dark \*) {\n background-color: rgb(31 41 55 / 0.8)\n}\n.dark\\:mint-text-gray-400:is(.dark \*) {\n --tw-text-opacity: 1;\n color: rgb(156 163 175 / var(--tw-text-opacity, 1))\n}\n.dark\\:hover\\:mint-bg-gray-700\\/60:hover:is(.dark \*) {\n background-color: rgb(55 65 81 / 0.6)\n}\n.dark\\:hover\\:mint-text-gray-200:hover:is(.dark \*) {\n --tw-text-opacity: 1;\n color: rgb(229 231 235 / var(--tw-text-opacity, 1))\n}\n.\\\[\\\u0026\\\>\\\*\\\]\\:\\!mint-mb-0\>\* {\n margin-bottom: 0px !important\n}\n.\\\[\\\u0026\\\>\\\*\\\]\\:\\!mint-mt-0\>\* {\n margin-top: 0px !important\n}\n.\\\[\\\u0026\\\>\\\*\\\]\\:\\!mint-rounded-b-none\>\* {\n border-bottom-right-radius: 0px !important;\n border-bottom-left-radius: 0px !important\n}\n.\\\[\\\u0026\\\>\\\*\\\]\\:\\!mint-rounded-t-none\>\* {\n border-top-left-radius: 0px !important;\n border-top-right-radius: 0px !important\n}","subdomain":"ab-634991b8","siteName":"1Password Developer","title":"Get started with 1Password CLI - 1Password Developer","relatedPagesConfig":{"enabled":true,"limit":3,"mode":"automatic"},"contextualStarterQuestions":\[{"\_id":"6ae4c9432086b3fba440c880","deploymentId":"68a8af9a517ab813d3b84097","questionText":"How do I authenticate with CLI?","status":"active","generatedBy":"contextual","path":"cli/get-started","createdAt":"2026-10-30T16:43:47.180Z","updatedAt":"2026-10-30T16:43:47.180Z","\_\_v":0},{"\_id":"6ae4c9432086b3fba440c87e","deploymentId":"68a8af9a517ab813d3b84097","questionText":"How do I install 1Password CLI?","status":"active","generatedBy":"contextual","path":"cli/get-started","createdAt":"2026-10-30T16:43:47.180Z","updatedAt":"2026-10-30T16:43:47.180Z","\_\_v":0},{"\_id":"6ae4c9432086b3fba440c87f","deploymentId":"68a8af9a517ab813d3b84097","questionText":"What can I do with 1Password CLI?","status":"active","generatedBy":"contextual","path":"cli/get-started","createdAt":"2026-10-30T16:43:47.180Z","updatedAt":"2026-10-30T16:43:47.180Z","\_\_v":0}\],"navMaps":{"firstHrefInVersion":{},"firstHrefInLanguage":{}},"lastModified":"2026-10-30T16:43:21.190Z","originalFileLocation":"cli/get-started.mdx"},"headHtml":"\u003cscript data-mint-head\>(function(){var d=document.documentElement,p=null;if(!p){try{p=localStorage.getItem(\\isDarkMode\\)}catch(e){}if(p==='true')p='dark';else if(p==='false')p='light';if(p!=='light'\u0026\u0026p!=='dark'\u0026\u0026p!=='system')p=\\system\\}var r=p==='system'?(matchMedia(\\(prefers-color-scheme: dark)\\).matches?'dark':'light'):p;d.classList.remove(r==='dark'?'light':'dark');d.classList.add(r);d.setAttribute(\\data-theme-preference\\,p)})();\u003c/script\>\u003cmeta data-mint-head name=\\application-name\\ content=\\1Password Developer\\\>\u003cmeta data-mint-head name=\\generator\\ content=\\Mintlify\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\192x192\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/android-chrome-192x192.png\\ media=\\(prefers-color-scheme: light)\\\>\u003clink data-mint-head rel=\\apple-touch-icon\\ type=\\image/png\\ sizes=\\180x180\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/apple-touch-icon.png\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\16x16\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/favicon-16x16.png\\ media=\\(prefers-color-scheme: light)\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\32x32\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/favicon-32x32.png\\ media=\\(prefers-color-scheme: light)\\\>\u003clink data-mint-head rel=\\shortcut icon\\ type=\\image/x-icon\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/favicon.ico\\ media=\\(prefers-color-scheme: light)\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\192x192\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon-dark/android-chrome-192x192.png\\ media=\\(prefers-color-scheme: dark)\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\16x16\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon-dark/favicon-16x16.png\\ media=\\(prefers-color-scheme: dark)\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\32x32\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon-dark/favicon-32x32.png\\ media=\\(prefers-color-scheme: dark)\\\>\u003clink data-mint-head rel=\\shortcut icon\\ type=\\image/x-icon\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon-dark/favicon.ico\\ media=\\(prefers-color-scheme: dark)\\\>\u003cmeta data-mint-head property=\\og:title\\ content=\\Get started with 1Password CLI - 1Password Developer\\\>\u003cmeta data-mint-head property=\\og:description\\ content=\\Learn how to install and sign in to 1Password CLI, then get started with commands and scripts to manage users, vaults, and items on the command line.\\\>\u003cmeta data-mint-head property=\\og:site_name\\ content=\\1Password Developer\\\>\u003cmeta data-mint-head property=\\og:url\\ content=\\https://www.1password.dev/cli/get-started\\\>\u003cmeta data-mint-head property=\\og:type\\ content=\\website\\\>\u003cmeta data-mint-head property=\\og:image\\ content=\\https://ab-634991b8.mintlify.app/\_mintlify/api/og/v2?division=CLI\u0026amp;title=Get+started+with+1Password+CLI\u0026amp;theme=0e8ac3e29b6f66038c473d59\u0026amp;signature=99e956e810e69762f111299c7f6851fcc08252863fb87ab571b9f8a2bc0a047b\\\>\u003cmeta data-mint-head property=\\og:image:width\\ content=\\1200\\\>\u003cmeta data-mint-head property=\\og:image:height\\ content=\\630\\\>\u003cmeta data-mint-head name=\\twitter:card\\ content=\\summary_large_image\\\>\u003cmeta data-mint-head name=\\twitter:title\\ content=\\Get started with 1Password CLI - 1Password Developer\\\>\u003cmeta data-mint-head name=\\twitter:description\\ content=\\Learn how to install and sign in to 1Password CLI, then get started with commands and scripts to manage users, vaults, and items on the command line.\\\>\u003cmeta data-mint-head name=\\twitter:image\\ content=\\https://ab-634991b8.mintlify.app/\_mintlify/api/og/v2?division=CLI\u0026amp;title=Get+started+with+1Password+CLI\u0026amp;theme=0e8ac3e29b6f66038c473d59\u0026amp;signature=99e956e810e69762f111299c7f6851fcc08252863fb87ab571b9f8a2bc0a047b\\\>\u003cmeta data-mint-head name=\\twitter:image:width\\ content=\\1200\\\>\u003cmeta data-mint-head name=\\twitter:image:height\\ content=\\630\\\>\u003cmeta data-mint-head name=\\msapplication-config\\ content=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/browserconfig.xml\\\>\u003cmeta data-mint-head name=\\apple-mobile-web-app-title\\ content=\\1Password Developer\\\>\u003cmeta data-mint-head name=\\msapplication-TileColor\\ content=\\#104ebb\\\>\u003cmeta data-mint-head name=\\google-site-verification\\ content=\\YserOhXnJUjFfIZ4K3qgxkVSlQZQdXtIbBiKzZ35Nvs\\\>\u003clink data-mint-head rel=\\canonical\\ href=\\https://www.1password.dev/cli/get-started\\\>\u003clink data-mint-head rel=\\alternate\\ type=\\application/xml\\ href=\\/sitemap.xml\\\>\u003clink data-mint-head rel=\\alternate\\ type=\\text/markdown\\ href=\\/cli/get-started.md\\\>\u003cscript data-mint-head type=\\application/ld+json\\\>{\\@context\\:\\https://schema.org\\,\\@graph\\:\[{\\@type\\:\\Organization\\,\\@id\\:\\https://www.1password.dev/#organization\\,\\name\\:\\1Password Developer\\,\\url\\:\\https://www.1password.dev\\,\\logo\\:{\\@type\\:\\ImageObject\\,\\url\\:\\https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max\u0026auto=format\u0026n=lHrfVfSCdefFz8U5\u0026q=85\u0026s=29d1c9358888a723dddd8a89a3b6f71d\\}},{\\@type\\:\\WebSite\\,\\@id\\:\\https://www.1password.dev#website\\,\\name\\:\\1Password Developer\\,\\url\\:\\https://www.1password.dev\\,\\publisher\\:{\\@id\\:\\https://www.1password.dev/#organization\\}},{\\@type\\:\\WebPage\\,\\@id\\:\\https://www.1password.dev/cli/get-started#webpage\\,\\url\\:\\https://www.1password.dev/cli/get-started\\,\\name\\:\\Get started with 1Password CLI\\,\\dateModified\\:\\2026-10-30T16:43:21.190Z\\,\\isPartOf\\:{\\@id\\:\\https://www.1password.dev#website\\},\\breadcrumb\\:{\\@id\\:\\https://www.1password.dev/cli/get-started#breadcrumb\\}},{\\@type\\:\\BreadcrumbList\\,\\@id\\:\\https://www.1password.dev/cli/get-started#breadcrumb\\,\\itemListElement\\:\[{\\@type\\:\\ListItem\\,\\position\\:1,\\name\\:\\CLI\\,\\item\\:\\https://www.1password.dev/cli\\},{\\@type\\:\\ListItem\\,\\position\\:2,\\name\\:\\Get started with 1Password CLI\\,\\item\\:\\https://www.1password.dev/cli/get-started\\}\]},{\\@type\\:\[\\Article\\,\\TechArticle\\\],\\@id\\:\\https://www.1password.dev/cli/get-started#article\\,\\headline\\:\\Get started with 1Password CLI\\,\\name\\:\\Get started with 1Password CLI\\,\\url\\:\\https://www.1password.dev/cli/get-started\\,\\mainEntityOfPage\\:{\\@id\\:\\https://www.1password.dev/cli/get-started#webpage\\},\\dateModified\\:\\2026-10-30T16:43:21.190Z\\,\\publisher\\:{\\@id\\:\\https://www.1password.dev/#organization\\},\\isPartOf\\:{\\@id\\:\\https://www.1password.dev#website\\}}\]}\u003c/script\>","siteName":"1Password Developer","nav":{"global":null,"tabs":\[{"tab":"Get Started","pages":\[{"title":"Get Started","href":"/get-started"}\]},{"tab":"Tutorials","pages":\[{"title":"Tutorials","href":"/tutorials"}\]},{"tab":"Security for AI","pages":\[{"title":"Security for AI","href":"/security-for-ai"}\]},{"tab":"Environments","pages":\[{"title":"Environments","href":"/environments"}\]},{"tab":"SSH \u0026 Git","pages":\[{"title":"SSH \u0026 Git","href":"/ssh"}\]},{"tab":"CLI","groups":\[{"group":"CLI","pages":\[{"title":"1Password CLI","sidebarTitle":"Overview","href":"/cli"},{"title":"Use cases","sidebarTitle":"Use cases","description":null,"href":"/cli/use-cases"},{"title":"Get started with 1Password CLI","sidebarTitle":"Get started","href":"/cli/get-started"},{"group":"Guides","pages":\[{"group":"Load secrets","pages":\[{"title":"Load secrets into the environment","sidebarTitle":"Load secrets into the environment","description":null,"href":"/cli/secrets-environment-variables"},{"title":"Load secrets into config files","sidebarTitle":"Inject secrets into config files","href":"/cli/secrets-config-files"},{"title":"Load secrets into scripts","sidebarTitle":"Load secrets into scripts","href":"/cli/secrets-scripts"},{"title":"Use secret references with 1Password CLI","sidebarTitle":"Use secret references with 1Password CLI","href":"/cli/secret-references"}\]},{"group":"Manage items","pages":\[{"title":"Create items","sidebarTitle":"Create items","href":"/cli/item-create"},{"title":"Edit items","sidebarTitle":"Edit items","href":"/cli/item-edit"},{"title":"Manage SSH keys","sidebarTitle":"Manage SSH keys","href":"/cli/ssh-keys"}\]},{"group":"Manage team members","pages":\[{"title":"Add and remove team members","sidebarTitle":"Add and remove team members","href":"/cli/provision-users"},{"title":"Grant and revoke vault permissions","sidebarTitle":"Grant and revoke vault permissions","href":"/cli/grant-revoke-vault-permissions"},{"title":"Recover accounts using 1Password CLI","sidebarTitle":"Recover accounts","href":"/cli/recover-users"}\]}\]},{"group":"Reference","pages":\[{"title":"1Password CLI reference","sidebarTitle":"Overview","href":"/cli/reference"},{"title":"1Password CLI best practices","sidebarTitle":"Best practices","href":"/cli/best-practices"},{"group":"Commands","pages":\[{"group":"Management commands","pages":\[{"title":"account","sidebarTitle":"account","href":"/cli/reference/management-commands/account"},{"title":"connect","sidebarTitle":"connect","href":"/cli/reference/management-commands/connect"},{"title":"document","sidebarTitle":"document","href":"/cli/reference/management-commands/document"},{"title":"environment","href":"/cli/reference/management-commands/environment"},{"title":"events-api","sidebarTitle":"events-api","href":"/cli/reference/management-commands/events-api"},{"title":"group","sidebarTitle":"group","href":"/cli/reference/management-commands/group"},{"title":"item","sidebarTitle":"item","href":"/cli/reference/management-commands/item"},{"title":"plugin","sidebarTitle":"plugin","href":"/cli/reference/management-commands/plugin"},{"title":"service-account","sidebarTitle":"service-account","href":"/cli/reference/management-commands/service-account"},{"title":"user","sidebarTitle":"user","href":"/cli/reference/management-commands/user"},{"title":"vault","sidebarTitle":"vault","href":"/cli/reference/management-commands/vault"}\]},{"group":"General commands","pages":\[{"title":"completion","sidebarTitle":"completion","href":"/cli/reference/commands/completion"},{"title":"inject","sidebarTitle":"inject","href":"/cli/reference/commands/inject"},{"title":"read","sidebarTitle":"read","href":"/cli/reference/commands/read"},{"title":"run","sidebarTitle":"run","href":"/cli/reference/commands/run"},{"title":"signin","sidebarTitle":"signin","href":"/cli/reference/commands/signin"},{"title":"signout","sidebarTitle":"signout","href":"/cli/reference/commands/signout"},{"title":"update","sidebarTitle":"update","href":"/cli/reference/commands/update"},{"title":"whoami","sidebarTitle":"whoami","href":"/cli/reference/commands/whoami"}\]}\]},{"group":"Concepts","pages":\[{"title":"1Password CLI environment variables","sidebarTitle":"Environment variables","href":"/cli/environment-variables"},{"title":"Item fields","sidebarTitle":"Item fields","href":"/cli/item-fields"},{"title":"Item JSON template","sidebarTitle":"Item JSON template","href":"/cli/item-template-json"},{"title":"Secret reference syntax","sidebarTitle":"Secret reference syntax","href":"/cli/secret-reference-syntax"},{"title":"Template syntax","sidebarTitle":"Template syntax","href":"/cli/secrets-template-syntax"},{"title":"About vault permissions","sidebarTitle":"Vault permissions","href":"/cli/vault-permissions"},{"title":"User states","sidebarTitle":"User states","href":"/cli/user-states"}\]},{"title":"Use 1Password CLI with Connect","sidebarTitle":"Use with Connect","href":"/cli/connect"},{"title":"1Password app integration security","sidebarTitle":"1Password app integration security","description":null,"href":"/cli/app-integration-security"}\]},{"group":"Configuration","pages":\[{"group":"Install","pages":\[{"title":"Get started with 1Password CLI","sidebarTitle":"Get started","href":"/cli/get-started"},{"sidebarTitle":"Verify installer","title":"Verify the authenticity of 1Password CLI","description":null,"href":"/cli/verify"},{"title":"Install 1Password CLI on a server","sidebarTitle":"Install on a server","href":"/cli/install-server"},{"sidebarTitle":"Set configuration directories","title":"How 1Password CLI detects configuration directories","href":"/cli/config-directories"}\]},{"group":"Sign in","pages":\[{"title":"Use the 1Password desktop app to sign in to 1Password CLI","sidebarTitle":"Sign in using the app","href":"/cli/app-integration"},{"title":"Sign in to your 1Password account manually","sidebarTitle":"Sign in manually","href":"/cli/sign-in-manually"},{"title":"Unlock 1Password CLI with SSO","sidebarTitle":"Sign in with SSO","href":"/cli/sign-in-sso"},{"title":"Unlock 1Password CLI with Microsoft","sidebarTitle":"Sign in with Microsoft","href":"/cli/sign-in-sso-azure"},{"title":"Use multiple 1Password accounts with 1Password CLI","sidebarTitle":"Use multiple accounts","href":"/cli/use-multiple-accounts"}\]},{"title":"Update to the latest version of 1Password CLI","sidebarTitle":"Check for updates","href":"/cli/reference/update"},{"title":"Upgrade to 1Password CLI 2","sidebarTitle":"Upgrade from an earlier version","href":"/cli/upgrade"},{"sidebarTitle":"Uninstall","title":"Uninstall 1Password CLI","href":"/cli/uninstall"}\]},{"title":"Example scripts","sidebarTitle":"Example scripts","href":"/cli/scripts"},{"title":"Release notes","url":"https://app-updates.agilebits.com/product_history/CLI2","href":"/cli/release-notes"}\]}\]},{"tab":"SDKs","pages":\[{"title":"SDKs","href":"/sdks"}\]},{"tab":"More Tools","menu":\[{"item":"VS Code","icon":"laptop","pages":\[{"title":"VS Code","href":"/vscode"}\]},{"item":"Shell Plugins","icon":"puzzle-piece","pages":\[{"title":"Shell Plugins","href":"/cli/shell-plugins"}\]},{"item":"Integrations","icon":"puzzle","pages":\[{"title":"Integrations","href":"/integrations"}\]},{"item":"Secrets Automation","icon":"tablet-screen","pages":\[{"title":"Secrets Automation","href":"/secrets-automation"}\]},{"item":"Events API","icon":"sensor-triangle-exclamation","pages":\[{"title":"Events API","href":"/events-api"}\]},{"item":"Users API","icon":"id-badge","pages":\[{"title":"Users API","href":"/users-api"}\]},{"item":"SaaS Manager API","icon":"chart-line","pages":\[{"title":"SaaS Manager API","href":"/saas-manager-api"}\]},{"item":"Partnership API","icon":"users","pages":\[{"title":"Partnership API","href":"/partnership-api/reference"}\]},{"item":"Accounts API","icon":"user-gear","pages":\[{"title":"Accounts API","href":"/accounts-api"}\]},{"item":"Web Development","icon":"code","pages":\[{"title":"Web Development","href":"/web/add-1password-button-website"}\]},{"item":"Developer Watchtower","icon":"tower-control","pages":\[{"title":"Developer Watchtower","href":"/watchtower"}\]}\],"pages":\[{"title":"More Tools","href":"/vscode"}\]},{"tab":"Agentic Autofill partner guide","hidden":true,"pages":\[{"title":"Agentic Autofill partner guide","href":"/agentic-autofill/partners"}\]}\]},"basePath":"","title":"Get started with 1Password CLI - 1Password Developer","buildId":"dpl_DeHjVRGfFnhYQwHnfC2pjeXXv8h9","deploymentId":"dpl_DeHjVRGfFnhYQwHnfC2pjeXXv8h9","dynamics":\["10e4515597","07c022d89b"\],"chunks":\["BannerMarkdown-CX_qQQOL.js","dist-BTZUMDnx.js","lib-DuNMoZ05.js","lib-B8HbPgcC.js","clsx-xpJZXxdP.js","html-void-elements-mCSPHezU.js","katex-YMM-FMeD.js","marked.esm-CZWythHk.js","Frame-DXXFP6nH.js","DynamicMarkdown-B54_zNBF.js"\]}
