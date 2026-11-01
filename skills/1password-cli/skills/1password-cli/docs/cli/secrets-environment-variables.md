> Source: https://www.1password.dev/cli/secrets-environment-variables/


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


Load secrets


Load secrets into the environment


<a href="/get-started" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Get Started</a>


<a href="/tutorials" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Tutorials</a>


<a href="/security-for-ai" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Security for AI</a>


<a href="/environments" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Environments</a>


<a href="/ssh" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SSH &amp; Git</a>


<a href="/cli" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200 [text-shadow:-0.2px_0_0_currentColor,0.2px_0_0_currentColor]" data-active="true" aria-current="location">CLI</a>


<a href="/sdks" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SDKs</a>


More Tools


Load secrets


# Load secrets into the environment


## 


<a href="#choose-your-configuration" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <span data-as="p">**<a href="/environments" class="link">1Password Environments</a>** allow you to create Environments in 1Password that contain all your environment variables for a specific workflow. You can share Environments with your team and create separate Environments for each project, application, or development context (like staging or production).</span>
- <span data-as="p">**<a href="/cli/secret-references" class="link">Secret references</a>** are URIs that point to where a secret is stored in your 1Password account. A secret reference uses the names or unique identifiers of the vault, item, section, and field where the secret is stored in 1Password. You can set environment variables to secret references on the command line or use secret references in your `.env` files. Secret references require more manual setup than 1Password Environments to switch between different sets of environment variables for different contexts, or create shared team workflows.</span>
- <span data-as="p">**Hybrid approach**: You can use `op run` to load variables from a 1Password Environment alongside secret references from `.env` files or exported environment variables.</span>


## 


<a href="#requirements" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <div id="1password-environment">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-1Password Environment">

  1Password Environment

  </div>

  </div>

- <div id="secret-references">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Secret references">

  Secret references

  </div>

  </div>


1.  <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">Sign up for 1Password.</a>
2.  <a href="/cli/get-started#step-1-install-1password-cli" class="link">Install 1Password CLI.</a>


1.  <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">Sign up for 1Password.</a>
2.  <a href="/cli/get-started#step-1-install-1password-cli" class="link">Install 1Password CLI.</a>


## 


<a href="#step-1-store-your-project-secrets-in-1password" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <div id="1password-environment-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-1Password Environment">

  1Password Environment

  </div>

  </div>

- <div id="secret-references-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Secret references">

  Secret references

  </div>

  </div>


- <a href="/cli/secret-reference-syntax#with-the-1password-desktop-app" class="link">With the 1Password desktop app</a>: Copy secret references from the app.
- <a href="/vscode#get-values" class="link">With 1Password for VSCode</a>: Insert secret references from 1Password as you edit code.
- <a href="/cli/secret-reference-syntax#with-1password-cli" class="link">With 1Password CLI</a>: Get secret references for one or multiple fields with `op item get`.
- Use the <a href="/cli/secret-reference-syntax#syntax-rules" class="link">secret reference syntax rules</a> to write secret references manually.


## 


<a href="#step-2-pass-the-secrets-to-the-application" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <div id="1password-environment-3">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-1Password Environment">

  1Password Environment

  </div>

  </div>

- <div id="secret-references-3">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Secret references">

  Secret references

  </div>

  </div>


1.  <span data-as="p">Open the 1Password app and navigate to **Developer** \> **Environments**.</span>
2.  <span data-as="p">Select the Environment where your project secrets are stored, then select **Manage environment** \> **Copy environment ID**.</span>
3.  <span data-as="p">Use `op run --` with the command for starting the application or script. 1Password will run the provided command in a subprocess with the secrets made available as environment variables for the duration of the process.</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_fakqcp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_fikqcp5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_fqkqcp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_ckqcp5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op run --environment <environmentID> -- <command>
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    <span data-as="p">For example:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_faoqcp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_fioqcp5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_fqoqcp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_coqcp5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op run --environment blgexucrwfr2dtsxe2q4uu7dp4 -- ./my-script.sh
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>


### 


<a href="#step-1-map-secret-references-to-environment-variables" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <div id="environment-file">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Environment file">

  Environment file

  </div>

  </div>

- <div id="command-line">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Command line">

  Command line

  </div>

  </div>


``` shiki
AWS_ACCESS_KEY_ID="op://development/aws/Access Keys/access_key_id"
AWS_SECRET_ACCESS_KEY="op://development/aws/Access Keys/secret_access_key"
```


Environment file syntax rules


- <span data-as="p">Environment variables are defined as `KEY=VALUE` statements separated by a newline.</span>
- <span data-as="p">Variables can span multiple lines if they are enclosed in either `'` or `"`:</span>
  <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="3" language="text">

  <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

  <div id="base-ui-_R_ulg9ahjkp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

  </div>

  <div id="base-ui-_R_v5g9ahjkp5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

  <span class="sr-only" role="status"></span>

  </div>

  <div id="base-ui-_R_vlg9ahjkp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

  </div>

  </div>

  <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

  <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_pg9ahjkp5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

  <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

  <div class="font-mono whitespace-pre leading-6">

  ``` shiki
  MY_VAR = "this is on the first line
  and this is on the second line"
  ```

  </div>

  </div>

  </div>

  </div>

  <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

  </div>

  </div>
- <span data-as="p">Empty lines are skipped.</span>
- <span data-as="p">Lines beginning with `#` are treated as comments. Comments can also be placed inline after `KEY=VALUE` statements.</span>
- <span data-as="p">Empty values become empty strings. For example, `EMPTY=` will set the environment variable `EMPTY` to the empty string.</span>
- <span data-as="p">If a value is surrounded by single or double quotes, these quotes do not end up in the evaluated value. So `KEY="VALUE"` and `KEY='VALUE'` both evaluate to `KEY` and `VALUE`.</span>
- <span data-as="p">Occurrences of `$VAR_NAME` or `${VAR_NAME}` are replaced with their respective value from the environment.</span>
- <span data-as="p">A variable defined in a .env file can be referred to later in the same file:</span>
  <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="3" language="text">

  <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

  <div id="base-ui-_R_ulh1ahjkp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

  </div>

  <div id="base-ui-_R_v5h1ahjkp5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

  <span class="sr-only" role="status"></span>

  </div>

  <div id="base-ui-_R_vlh1ahjkp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

  </div>

  </div>

  <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

  <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_ph1ahjkp5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

  <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

  <div class="font-mono whitespace-pre leading-6">

  ``` shiki
  SOME_VAR = value
  OTHER_VAR = ${SOME_VAR}
  ```

  </div>

  </div>

  </div>

  </div>

  <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

  </div>

  </div>
- <span data-as="p">Special characters can be escaped with `\`. For example, `MY_VAR = "\$SOME_VAR that is not actually replaced."` results in the following value for MY_VAR: `$SOME_VAR that is not actually replaced.`.</span>
- <span data-as="p">Inner quotes are maintained, so `JSON={"foo":"bar"}` evaluates to `JSON` and `{"foo":"bar"}`.</span>
- <span data-as="p">Variables do not get replaced in values that are enclosed in single quotes. So `KEY='$SOME_VAR'` evaluates to `KEY` and `$SOME_VAR`.</span>
- <span data-as="p">Template syntax can be used in the `VALUE` to inject secrets. The `KEY` can only contain template variables.</span>
- <span data-as="p">Template parsing is performed after `.env` file parsing, so you cannot use the former to construct the latter.</span>
- <span data-as="p">Leading and trailing whitespace of both `KEY` and `VALUE` segments are ignored, so `KEY = VALUE` is parsed the same as `KEY=VALUE`.</span>
- <span data-as="p">Single and double quoted values maintain both leading and trailing whitespace, so `KEY=" some value "` evaluates to `KEY` and ` some value `.</span>
- <span data-as="p">These files should use UTF-8 character encoding.</span>


### 


<a href="#optional-differentiate-between-environments" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
MYSQL_DATABASE = "op://$APP_ENV/mysql/database"
MYSQL_USERNAME = "op://$APP_ENV/mysql/username"
MYSQL_PASSWORD = "op://$APP_ENV/mysql/password"
```


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


``` shiki
export GITHUB_TOKEN=op://development/GitHub/credentials/personal_token
```


``` shiki
set -x GITHUB_TOKEN op://development/GitHub/credentials/personal_token
```


``` shiki
$Env:GITHUB_TOKEN = "op://development/GitHub/credentials/personal_token"
```


### 


<a href="#step-2-pass-the-resolved-secret-references-to-the-application" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <div id="environment-file-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Environment file">

  Environment file

  </div>

  </div>

- <div id="command-line-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Command line">

  Command line

  </div>

  </div>


``` shiki
op run --env-file="./prod.env" -- aws
```


- <div id="bash%2C-zsh%2C-sh%2C-fish">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Bash, Zsh, sh, fish">

  Bash, Zsh, sh, fish

  </div>

  </div>

- <div id="powershell-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-PowerShell">

  PowerShell

  </div>

  </div>


``` shiki
APP_ENV=dev op run --env-file="./app.env" -- myapp deploy
```


1.  <span data-as="p">Set the `$APP_ENV` variable:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="powershell">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_ulhallkp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_v5hallkp5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_vlhallkp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_phallkp5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    $ENV:APP_ENV = "dev"
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>
2.  <span data-as="p">Run `op run` with the environment file:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="powershell">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_uliallkp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_v5iallkp5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_vliallkp5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_piallkp5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op run --env-file="./app.env" -- myapp deploy
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>


``` shiki
op run -- <command>
```


``` shiki
op run -- gh
```


``` shiki
MY_VAR=op://vault/item/field op run --no-masking -- echo "$MY_VAR"
```


``` shiki
op run --environment <ID> --env-file="./extra-secrets.env" -- <command>
```


## 


<a href="#next-step-run-in-production" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- **<a href="/service-accounts/use-with-1password-cli" class="link">1Password Service Account</a>**: Automate access with a service account token. Service accounts support both secret references and 1Password Environments.
- **<a href="/connect/cli/" class="link">1Password Connect Server</a>**: Best for self-hosting within your own infrastructure. Connect only supports secret references and does not currently support 1Password Environments.

## 


<a href="#learn-more" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/service-accounts/use-with-1password-cli" class="link">Use 1Password Service Accounts with 1Password CLI</a>
- <a href="/connect/cli#continuous-integration-ci-environments" class="link">Use 1Password Connect Server with 1Password CLI</a>
- <a href="/cli/secrets-config-files/" class="link">Load secrets into config files</a>
- <a href="/cli/secret-reference-syntax/" class="link">Secret reference syntax</a>
- <a href="/cli/secrets-template-syntax/" class="link">Template syntax</a>
- <a href="/get-started/secure-deployment" class="link">Workflow: Secure your deployments</a>


Was this page helpful?


{"docsConfig":{"theme":"mint","\$schema":"https://mintlify.com/docs.json","name":"1Password Developer","colors":{"primary":"#104ebb","light":"#b8d7ff","dark":"#303136"},"logo":{"light":"https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max\u0026auto=format\u0026n=lHrfVfSCdefFz8U5\u0026q=85\u0026s=29d1c9358888a723dddd8a89a3b6f71d","dark":"https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-light.svg?fit=max\u0026auto=format\u0026n=lHrfVfSCdefFz8U5\u0026q=85\u0026s=119233092720e49043d6f42ff71125f1"},"favicon":"https://mintcdn.com/ab-634991b8/s4Wjy03jBRs6hcHb/favicon.ico?fit=max\u0026auto=format\u0026n=s4Wjy03jBRs6hcHb\u0026q=85\u0026s=dd03b4bc604b342373aa4d3e21be4310","api":{"playground":{"display":"interactive"},"examples":{"languages":\["curl","node","python","go","dotnet","java","php","powershell","ruby"\]}},"background":{"color":{"light":"#fbf8f4","dark":"#1a1b1e"}},"navbar":{"links":\[{"href":"/community","label":"Community"},{"href":"https://www.1password.academy/path/1password-developer-tools","label":"Academy"}\],"primary":{"type":"button","label":"GitHub","href":"https://github.com/1Password"}},"footer":{"socials":{"github":"https://github.com/1Password","x":"https://twitter.com/1Password","reddit":"https://www.reddit.com/r/1Password","linkedin":"https://www.linkedin.com/company/1password","youtube":"https://www.youtube.com/1PasswordVideos","facebook":"https://www.facebook.com/1Password","instagram":"https://www.instagram.com/1password"},"links":\[{"header":"Legal","items":\[{"label":"Terms of Service","href":"https://1password.com/legal/terms-of-service"},{"label":"Privacy Policy","href":"https://1password.com/legal/privacy"},{"label":"Cookie Policy","href":"https://1password.com/legal/cookies"},{"label":"Accessibility","href":"https://1password.com/legal/accessibility"}\]},{"header":"Community","items":\[{"label":"Developer community","href":"/community"},{"label":"Code of Conduct","href":"/code-of-conduct"},{"label":"Community projects disclaimer","href":"/community/disclaimer"}\]},{"header":"Resources","items":\[{"label":"1Password University","href":"https://www.1password.university/?utm_ref=website-footer"},{"label":"Blog RSS","href":"https://blog.1password.com/index.xml"},{"label":"Newsletter","href":"https://1password.com/developer-newsletter"}\]}\]},"seo":{"metatags":{"canonical":"https://www.1password.dev","google-site-verification":"YserOhXnJUjFfIZ4K3qgxkVSlQZQdXtIbBiKzZ35Nvs"}},"fonts":{"heading":{"family":"Public Sans"},"body":{"family":"Public Sans"}},"banner":{"content":"\*\*New!\*\* Use the \[1Password Credential Broker\](https://www.1password.dev/brokered-access) to give CI/CD and other machine workflows short-lived access to secrets, without managing service account tokens.","dismissible":true,"color":{"light":"#145fe4","dark":"#145fe4"}},"errors":{"404":{"redirect":false,"title":"This page can't be found","description":"Our docs have moved to \[www.1password.dev\](https://www.1password.dev). Try searching for what you need or selecting from the list of tools."}},"contextual":{"options":\["copy","view","mcp","cursor","vscode","chatgpt","claude","perplexity"\],"display":"header"},"styling":{"latex":false},"navigation":{"pages":\[\]}},"deployment":{"deploymentMetadataValue":{"subdomain":"ab-634991b8","hasAudioNarration":false,"actualSubdomain":"ab-634991b8","customDomains":\["www.1password.dev"\],"gitSource":{"type":"github","owner":"1password","repo":"1password.dev","deployBranch":"main","contentDirectory":"","isPrivate":true,"mountPath":"","label":""},"chroma":{"liveDeploymentHistoryId":"6ae4c9014c4a3f4f5e4b234c","collectionId":"2b0d16b8-c8c5-48fa-9c4d-f1ffef490467","schemaVersion":"v3","latestBuiltDeploymentHistoryId":"6ae4c9014c4a3f4f5e4b234c"},"feedback":{"thumbs":true,"contextualFeedback":{"allowEmail":false},"agentFeedback":true},"entitlements":{"AI_CHAT":{"status":"ENABLED"},"REMOVE_BRANDING":{"status":"ENABLED"},"CONTEXTUAL_FEEDBACK":{"status":"ENABLED"},"CODE_SNIPPET_FEEDBACK":{"status":"ENABLED"},"WEB_MCP":{"status":"ENABLED"},"NARRATION":{"status":"ENABLED"}},"buildId":"6ae4c9014c4a3f4f5e4b234c","clientVersion":"0.0.4044","searchFilterCounts":\[{"language":"default","tag":"More Tools","count":257},{"language":"default","tag":"Shell Plugins","count":184},{"language":"default","tag":"CLI","count":112},{"language":"default","tag":"Secrets Automation","count":94},{"language":"default","tag":"SaaS Manager API","count":88},{"language":"default","tag":"Plugins","count":85},{"language":"default","tag":"API Reference","count":64},{"language":"default","tag":"Reference","count":58},{"language":"default","tag":"SDKs","count":53},{"language":"default","tag":"Integrations","count":50}\]},"assistantConfig":{"enableStarterQuestions":true,"enableContextualStarterQuestions":true,"deflection":{"enabled":true,"email":"support@1password.com","showHelpButton":true}},"basePath":"","hasChatPermissions":true,"hasWebMcpPermissions":true,"toggles":\[{"name":"kill-isr","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"agent-mintlify-slack","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"agent-integrations-settings","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"automations-pr-grouping","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"custom-prefix","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"analytics-v7","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"user-flows-analytics","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"no-publish-flow","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"workos-onboarding","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"llms-txt-v2","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"snapshot-serving-live","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"stripTemperatureMiddleware","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"support-platform-pylon-zendesk","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"snapshot-serving","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"instant-rollback","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"granular-notifications-server","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"granular-notifications","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"automations-fable","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"fixed-ai-action-pricing","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"automation-resolve-merge-conflict","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"scoped-publishing","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"mintql","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"page-level-analytics","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"editor-version-history-v2","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"billing-page-v2","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"full-page-search","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"workspace-projects","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"assistant-v5","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"byok-sep-25","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"fork-pr-previews","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"revalidation-jwt","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"vite-origin","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"billing-updated-9-15","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"workos-sso-scim","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"hobby-abuse-scan","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"dashboard-inbox","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"workos-signup","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"turbopuffer-dual-write","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"workos-enabled","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"approve-review-flow","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"sso-setup-deadline-banner","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false}\],"googleFontsInlined":true},"customCss":\[{"filePath":"styles.css","content":":root{--op-secure-blue:#104ebb;--op-secure-blue-hover:#0e46a8;--op-iron-ore:#303136;--op-page-bg-dark:#1a1b1e;--op-white:#ffffff;--op-icy-blue:#dcebff;--op-cornflower:#b8d7ff;--op-biscuit:#fbf8f4;--op-sunbeam:#fad785;--op-tangerine:#ff8f78;--op-enable-mint:#76e0bd;--op-gold:#cbb88e;--op-status-success:#10622f;--op-status-warning:#8a4006;--op-status-error:#a71c1c;--op-status-info:var(--op-secure-blue);--op-border-ui:#949494;--op-border-ui-dark:#6b7280;--op-border-subtle:rgb(3 7 18 / 0.12);--op-border-subtle-dark:rgb(251 248 244 / 0.25);--op-border-footer-dark:rgb(251 248 244 / 0.37);--op-border-navbar-light:rgb(107 114 128 / 0.05);--op-border-navbar-dark:rgb(209 213 219 / 0.06);--op-border-card-light:rgb(3 7 18 / 0.1);--op-border-card-dark:rgb(255 255 255 / 0.1);--op-border-hero-light:rgb(255 255 255 / 0.08);--op-border-hero-dark:rgb(255 255 255 / 0.12);--op-border-badge-light:rgb(16 78 187 / 0.2);--op-border-badge-dark:rgb(184 215 255 / 0.25);--op-border-workflow-dark:rgb(251 248 244 / 0.2);--op-text-body:var(--op-iron-ore);--op-text-body-dark:var(--op-biscuit);--op-surface-card-light:var(--op-white);--op-surface-card-dark:#25262a;--op-surface-callout-light:rgb(220 235 255 / 0.45);--op-surface-callout-dark:rgb(184 215 255 / 0.08)}#content.prose{--tw-prose-body:var(--op-text-body)}.dark \#content.prose{--tw-prose-body:var(--op-text-body-dark)}#content.prose :where(p, span\[data-as=\\p\\\], li, td, th, blockquote, figcaption):not(a.op-cta-primary span){color:var(--op-text-body)}.dark \#content.prose :where(p, span\[data-as=\\p\\\], li, td, th, blockquote, figcaption):not(a.op-cta-primary span){color:var(--op-text-body-dark)}#content :is(p, li, div, span, button, h1, h2, h3, h4, h5, h6).text-gray-600,#content :is(p, li, div, span, button, h1, h2, h3, h4, h5, h6).text-gray-700,#content :is(p, li, span, button, h1, h2, h3, h4, h5, h6).text-gray-500{color:var(--op-text-body)}.dark \#content :is(p, li, div, span, button, h1, h2, h3, h4, h5, h6).dark\\:text-gray-300,.dark \#content :is(p, li, div, span, button, h1, h2, h3, h4, h5, h6).dark\\:text-gray-400,.dark \#content :is(p, li, span, button, h1, h2, h3, h4, h5, h6).dark\\:text-gray-500{color:var(--op-text-body-dark)}#content .text-gray-400:not(:is(p, li, span, button, h1, h2, h3, h4, h5, h6)){color:var(--op-border-ui)}.dark \#content .text-gray-400:not(:is(p, li, span, button, h1, h2, h3, h4, h5, h6)),.dark \#content .text-gray-500:not(:is(p, li, span, button, h1, h2, h3, h4, h5, h6)){color:var(--op-border-ui-dark)}.dark .card-group{--background-dark:37 38 42}.dark .card-group .card{background-color:rgb(var(--background-dark))!important;border-color:var(--op-border-card-dark)!important}.card-group .card{border-color:var(--op-border-card-light)!important}.community-callout,.community-card,.op-card-surface{border:1px solid var(--op-border-card-light)}.dark .community-card,.dark .op-card-surface{border-color:var(--op-border-card-dark)}#content .hover\\:border-gray-300:hover{border-color:var(--op-iron-ore)}.dark \#content .hover\\:border-gray-600:hover{border-color:var(--op-biscuit)}.community-callout,.community-card{border-radius:.5rem;background-color:var(--op-surface-card-light)}.dark .community-card{background-color:var(--op-surface-card-dark)}.community-card .community-card-chevron{color:var(--op-border-ui)}.dark .community-card .community-card-chevron{color:var(--op-cornflower)}a.community-card:hover{border-color:var(--op-secure-blue)}.dark a.community-card:hover{border-color:var(--op-cornflower)}.community-callout{background-color:var(--op-surface-callout-light)}.dark .community-callout{border-color:var(--op-border-card-dark);background-color:var(--op-surface-callout-dark)}.community-link{color:var(--op-secure-blue);text-decoration:none}.community-link:hover{color:var(--op-secure-blue-hover);text-decoration:underline}.dark .community-link{color:var(--op-cornflower)}#footer a,#footer p.font-semibold,.dark \#content\>h5,.dark \#content\>h6,.dark .community-link:hover{color:var(--op-white)}:is(\n \#sidebar-content a:not(\[aria-current=\\page\\\]),\n \#table-of-contents,\n \#table-of-contents a,\n \#navbar .nav-tabs-item:not(\[data-active\]),\n \#navbar nav ul \> li:not(#topbar-cta-button) \> a,\n \#search-bar-entry,\n \#search-bar-entry-mobile,\n \#assistant-entry,\n \#assistant-entry-mobile,\n \[data-component-name=\\theme-toggle\\\]\n){color:var(--op-text-body)}.dark :is(\n \#sidebar-content a:not(\[aria-current=\\page\\\]),\n \#table-of-contents,\n \#table-of-contents a,\n \#navbar .nav-tabs-item:not(\[data-active\]),\n \#navbar nav ul \> li:not(#topbar-cta-button) \> a,\n \#search-bar-entry,\n \#search-bar-entry-mobile,\n \#assistant-entry,\n \#assistant-entry-mobile,\n \[data-component-name=\\theme-toggle\\\]\n){color:var(--op-text-body-dark)}:is(\n \#search-bar-entry,\n \#search-bar-entry-mobile,\n \#assistant-entry,\n \#assistant-entry-mobile,\n \[data-component-name=\\theme-toggle\\\]\n) svg{color:inherit}#footer a.h-fit svg{background-color:var(--op-biscuit)}#footer a.h-fit:hover svg{background-color:var(--op-white)}.hero-background{background-color:var(--op-iron-ore);background-image:radial-gradient(ellipse 75% 100% at 100% 50%,rgb(20 95 228/.55) 0,rgb(20 95 228/.2) 40%,transparent 70%)}.dark .hero-background{background-color:var(--op-page-bg-dark);background-image:radial-gradient(ellipse 80% 100% at 100% 50%,rgb(20 95 228/.7) 0,rgb(20 95 228/.3) 45%,transparent 75%)}.hero-section{border-bottom:1px solid var(--op-border-hero-light)}.dark .hero-section{border-bottom-color:var(--op-border-hero-dark)}.hero-cta{background-color:var(--op-secure-blue);color:var(--op-white);box-shadow:0 1px 3px rgb(0 0 0/.25)}.hero-cta svg,.hero-cta svg path{fill:currentColor!important;color:currentColor!important}.hero-cta:hover{background-color:var(--op-secure-blue-hover)}#content a.op-cta-primary,#content.prose a.op-cta-primary{background-color:var(--op-secure-blue);color:var(--op-white)!important;text-decoration:none}#content a.op-cta-primary span,#content a.op-cta-primary span\[data-as=p\],#content a.op-cta-primary:hover span,#content a.op-cta-primary:hover span\[data-as=p\],#content.prose a.op-cta-primary span,#content.prose a.op-cta-primary span\[data-as=p\],#content.prose a.op-cta-primary:hover span,#content.prose a.op-cta-primary:hover span\[data-as=p\]{color:var(--op-white)!important}#content a.op-cta-primary:hover,#content.prose a.op-cta-primary:hover{background-color:var(--op-secure-blue-hover);color:var(--op-white)!important}#topbar-cta-button a\>span.absolute,.highlight-card-link svg{background-color:var(--op-secure-blue)!important}#topbar-cta-button a:hover\>span.absolute{background-color:var(--op-secure-blue-hover)!important}#topbar-cta-button a span.z-10,#topbar-cta-button a svg,.dark .highlight-card-link:hover{color:var(--op-white)!important}.card-group{gap:1rem}#content .card-group img\[src\*=\\/homepage-icons/brand/\\\]{width:32px;height:32px;flex-shrink:0}.homepage-card-title{display:inline-flex;flex-wrap:wrap;align-items:center;gap:.25rem .5rem}.image-button-link img{margin:10px 0}.dark \#content a\>div\>span{color:var(--op-cornflower)!important}.docs-higlight-cards{display:grid;grid-template-columns:repeat(auto-fill,minmax(250px,1fr));gap:1rem;margin-bottom:1rem}.highlight-card-link{color:var(--op-secure-blue)!important}.highlight-card-link:hover{color:var(--op-secure-blue-hover)!important}.dark .highlight-card-link{color:var(--op-cornflower)!important}.dark .highlight-card-link svg{background-color:var(--op-cornflower)!important}.coloredCodeWrapper .code-block\>div:nth-child(3){--fade-color-light:transparent!important;--fade-color-dark:transparent!important}.badge{border-radius:.4rem;color:var(--op-white);font-weight:700;line-height:1;padding:3px 5px}.badge--primary{background-color:var(--op-secure-blue)}.badge--secondary{background-color:var(--op-biscuit);color:var(--op-iron-ore)}.op-status-badge,.op-workflow-guide-badge{display:inline-flex;flex-shrink:0;align-items:center;white-space:nowrap;border-radius:.25rem;color:var(--op-iron-ore);padding:.125rem .625rem;font-size:.75rem;line-height:1rem;font-weight:600}.op-status-badge{vertical-align:middle;border:1px solid var(--op-border-badge-light);background-color:var(--op-icy-blue)}.dark .op-status-badge{border-color:var(--op-border-badge-dark);background-color:rgb(184 215 255/.12);color:var(--op-icy-blue)}.op-workflow-guide-badge{margin-top:.75rem;border:1px solid transparent;background-color:var(--op-biscuit)}.dark .op-workflow-guide-badge{border-color:var(--op-border-workflow-dark);background-color:rgb(251 248 244/.1);color:var(--op-biscuit)}.op-beta-badge-inline{display:inline-flex;align-items:center;margin-left:.5rem;vertical-align:middle}.mdx-content a\[href^=http\]:not(\[href\*=\\://1password.com/\\\],\[href\$=\\://1password.com\\\],\[href\*=\\.1password.com/\\\],\[href\$=\\.1password.com\\\],\[href\*=\\://1password.dev/\\\],\[href\$=\\://1password.dev\\\],\[href\*=\\.1password.dev/\\\],\[href\$=\\.1password.dev\\\],\[href\*=\\://1password.ca/\\\],\[href\$=\\://1password.ca\\\],\[href\*=\\.1password.ca/\\\],\[href\$=\\.1password.ca\\\],\[href\*=\\://1password.eu/\\\],\[href\$=\\://1password.eu\\\],\[href\*=\\.1password.eu/\\\],\[href\$=\\.1password.eu\\\],\[href\*=\\://1password.io/\\\],\[href\$=\\://1password.io\\\],\[href\*=\\.1password.io/\\\],\[href\$=\\.1password.io\\\],\[href\*=\\://1password.university/\\\],\[href\$=\\://1password.university\\\],\[href\*=\\.1password.university/\\\],\[href\$=\\.1password.university\\\],\[href\*=\\://agilebits.com/\\\],\[href\$=\\://agilebits.com\\\],\[href\*=\\.agilebits.com/\\\],\[href\$=\\.agilebits.com\\\],\[href\*=\\://b5dev.com/\\\],\[href\$=\\://b5dev.com\\\],\[href\*=\\.b5dev.com/\\\],\[href\$=\\.b5dev.com\\\],\[href\*=\\://b5local.com/\\\],\[href\$=\\://b5local.com\\\],\[href\*=\\.b5local.com/\\\],\[href\$=\\.b5local.com\\\],\[href\*=\\://1infra.dev/\\\],\[href\$=\\://1infra.dev\\\],\[href\*=\\.1infra.dev/\\\],\[href\$=\\.1infra.dev\\\],\[href\*=\\://kolide.com/\\\],\[href\$=\\://kolide.com\\\],\[href\*=\\.kolide.com/\\\],\[href\$=\\.kolide.com\\\],\[href\*=\\://trelica.app/\\\],\[href\$=\\://trelica.app\\\],\[href\*=\\.trelica.app/\\\],\[href\$=\\.trelica.app\\\],\[href\*=\\://trelica.eu/\\\],\[href\$=\\://trelica.eu\\\],\[href\*=\\.trelica.eu/\\\],\[href\$=\\.trelica.eu\\\],\[href\*=\\://trelica.com/\\\],\[href\$=\\://trelica.com\\\],\[href\*=\\.trelica.com/\\\],\[href\$=\\.trelica.com\\\],\[href\*=\\://1password.community/\\\],\[href\$=\\://1password.community\\\],\[href\*=\\.1password.community/\\\],\[href\$=\\.1password.community\\\],\[href\*=\\://1pw.ca/\\\],\[href\$=\\://1pw.ca\\\],\[href\*=\\.1pw.ca/\\\],\[href\$=\\.1pw.ca\\\]):not(.card \*,.op-card-surface \*,.image-button-link,.community-card,.community-card \*,pre \*,:has(img))::after{content:\\\\;display:inline-block;width:1em;height:1em;margin-left:.25em;vertical-align:-.125em;background-color:currentColor;-webkit-mask:var(--op-link-icon, url(\\/static/img/icons/external-link.svg\\)) no-repeat center/contain;mask:var(--op-link-icon, url(\\/static/img/icons/external-link.svg\\)) no-repeat center/contain}.mdx-content a:is(\[href\*=\\://github.com/\\\], \[href\$=\\://github.com\\\], \[href\*=\\.github.com/\\\], \[href\$=\\.github.com\\\], \[href\*=\\://github.blog/\\\], \[href\$=\\://github.blog\\\]){--op-link-icon:url(\\/static/img/logos/github.svg\\)}#content\>h5,#content\>h6{font-weight:700}.accordion{background-color:var(--op-icy-blue)}.dark .accordion{background-color:var(--op-surface-card-dark)}.accordion .mint-bg-white{padding:1rem}.accordion .mint-bg-white \[class\*=-mx-\]{margin:0!important;padding:0!important;width:100%!important;--page-padding:0px}#footer img.nav-logo.dark\\:hidden,#footer\>div\>div.flex.flex-col.md\\:flex-row.gap-8.justify-between.min-h-\\\[76px\\\]\>div.flex.flex-col.sm\\:grid.max-md\\:\\!grid-cols-2.gap-8.flex-1\>div\>div\>p{display:none!important}footer#footer.advanced-footer{display:flex!important}footer#footer{align-items:unset;background-color:var(--op-iron-ore);color:var(--op-white)}#footer img.nav-logo.dark\\:block{display:block!important}#footer\>div.flex.w-full.flex-col.gap-12.justify-between.px-8.py-16.md\\:py-20.lg\\:py-28.z-20\>div.h-\\\[1px\\\].w-full.bg-gray-100.dark\\:bg-white\\/5{background-color:var(--op-border-footer-dark)}#footer\>div.flex.w-full.flex-col.gap-12.justify-between.px-8.py-16.md\\:py-20.lg\\:py-28.z-20{margin:0 auto}footer .email_form{max-width:650px;margin:auto}.codeblock_accordion{margin-top:10px}.codeblock_accordion .code-block{margin:0!important}.codeblock_accordion\>div\>.code-block,.codeblock_accordion\>div\>.code-block\>div:nth-child(2){border-bottom-left-radius:0;border-bottom-right-radius:0}.codeblock_accordion .see_results_container{border-bottom-left-radius:1rem;border-bottom-right-radius:1rem}.codeblock_accordion .see_results_container .code-block,.codeblock_accordion .see_results_container .code-block\>div:nth-child(2){border-top-left-radius:0;border-top-right-radius:0}.hide_bullets ul li{padding-left:0!important}.hide_bullets ul li::before{content:none!important}#navigation-items a\[href^=\\/\\\]:not(\[href^=\\//\\\])\>div\>div:nth-child(2){display:none}a\[href^=\\//\\\] .flex-shrink-0 svg,a\[href^=http\] .flex-shrink-0 svg{display:block}h1 code,h2 code,h3 code,h4 code,h5 code,h6 code{white-space:nowrap}h2.flex.whitespace-pre-wrap span.cursor-pointer svg.icon,h4.flex.whitespace-pre-wrap span.cursor-pointer svg.icon{margin:0;vertical-align:baseline}table thead tr th code{padding-left:0!important;padding-right:0!important}.tabs.tab-container{padding:0 .8rem 1rem;border:1px solid var(--op-border-subtle);border-radius:4px}.dark .tabs.tab-container{border-color:var(--op-border-subtle-dark)}.nav-tabs-item:nth-child(3),nav-tabs-item:nth-child(3){--tab-gap-before-divider:8px;--nav-tabs-item-gap:0.5rem;margin-left:var(--tab-gap-before-divider)!important;padding-left:calc(var(--tab-gap-before-divider) + var(--nav-tabs-item-gap))!important;border-left:1px solid var(--op-border-navbar-light)}.dark .nav-tabs-item:nth-child(3),.dark nav-tabs-item:nth-child(3){border-left-color:var(--op-border-navbar-dark)}.peer.is-center~div:has(.tutorial-explorer){max-width:84rem!important}@media (max-width:639px){.tutorial-filter-bar{display:grid!important;grid-template-columns:minmax(0,1fr)}.tutorial-filter-search,.tutorial-filter-tools,.tutorial-filter-topic{grid-column:1/-1;width:100%}.tutorial-filter-search input{width:100%!important}.tutorial-filter-dropdown\>button,.tutorial-filter-menu{width:100%}.tutorial-filter-dropdown\>button{justify-content:space-between}.tutorial-filter-menu{min-width:0!important}.tutorial-filter-sort{grid-column:1/-1;justify-self:end;margin-left:0!important}}#navbar.is-custom .nav-tabs-item\[data-active\]{color:var(--op-text-body);text-shadow:none}.dark \#navbar.is-custom .nav-tabs-item\[data-active\]{color:var(--op-text-body-dark)}#navbar.is-custom .nav-tabs-item\[data-active\]\>div{background-color:transparent!important}#navbar.is-custom .nav-tabs-item\[data-active\]:hover\>div{background-color:rgb(229 231 235)!important}.dark \#navbar.is-custom .nav-tabs-item\[data-active\]:hover\>div{background-color:rgb(55 65 81)!important}#footer .api-sdk-terms-notice{margin:0;padding:0 0 1.25rem;font-size:.875rem;font-style:italic;line-height:1.5;text-align:center;color:rgb(251 248 244/.8);pointer-events:auto}#footer .api-sdk-terms-notice a{position:relative;z-index:2;color:var(--op-cornflower);text-decoration:underline;text-underline-offset:2px;pointer-events:auto;cursor:pointer}"}\],"page":{"pagePath":"cli/secrets-environment-variables","slug":"/cli/secrets-environment-variables","pageMetadata":{"id":"secrets-environment-variables","title":"Load secrets into the environment","sidebarTitle":"Load secrets into the environment","og:description":"Learn how to pass secrets as environment variables to an application or script using 1Password Environments or secret references.","slug":"/cli/secrets-environment-variables","pagination_next":"cli/secrets-config-files","description":null,"href":"/cli/secrets-environment-variables"},"pageType":"default","mdx":{"mdxSource":{"compiledSource":"\\use strict\\;const{Fragment:\_Fragment,jsx:\_jsx,jsxs:\_jsxs}=arguments\[0\];const{useMDXComponents:\_provideComponents}=arguments\[0\];const CodeResult=({children,resultLang,wrap,expandable})=\>{const{CodeBlock,Icon}=\_provideComponents()\|\|{};if(!CodeBlock)\_missingMdxReference(\`CodeBlock\`,true);if(!Icon)\_missingMdxReference(\`Icon\`,true);const parseChildren=()=\>{let language=\`text\`;let codeContent=\`\`;const extractText=node=\>{if(typeof node===\`string\`){return node}if(Array.isArray(node)){return node.map(extractText).join(\`\`)}if(node?.props?.children){return extractText(node.props.children)}return\`\`};const extractLanguage=node=\>{if(!node)return null;if(node.props?.className){const className=node.props.className;const langMatch=className.match(/language-(\\w+)/);if(langMatch){return langMatch\[1\]}}if(node.props?.\[\`data-language\`\]){return node.props\[\`data-language\`\]}if(node.props?.language){return node.props.language}return null};if(typeof children===\`string\`){codeContent=children}else if(Array.isArray(children)){codeContent=extractText(children);for(const child of children){const detectedLang=extractLanguage(child);if(detectedLang){language=detectedLang;break}}}else if(children?.props){const detectedLang=extractLanguage(children);if(detectedLang){language=detectedLang}codeContent=extractText(children)}const parts=codeContent.split(\`#code-result\`);if(parts.length\u003c2){return{command:codeContent.trim(),result:null,language,defaultOpen:false}}const resultText=parts\[1\].trim();const defaultOpen=resultText.startsWith(\`open\`);const cleanResult=defaultOpen?resultText.slice(4).trim():resultText;return{command:parts\[0\].trim(),result:cleanResult,language,defaultOpen}};const{command,result,language,defaultOpen}=parseChildren();const\[isOpen,setIsOpen\]=useState(defaultOpen);if(!result){return children}return \_jsxs(\`div\`,{className:\`codeblock_accordion not-prose mint-mb-4\`,children:\[\_jsx(\`div\`,{className:\`\[\u0026\>\*\]:!mint-mb-0 \[\u0026\>\*\]:!mint-rounded-b-none\`,children:\_jsx(CodeBlock,{language,children:command,wrap,expandable})}),\_jsxs(\`div\`,{className:\`see_results_container mint-border-t-0 mint-bg-gray-100/80 dark:mint-bg-gray-800/80 mint-overflow-hidden\`,style:{marginTop:\`-0.25rem\`},children:\[\_jsxs(\`button\`,{onClick:()=\>setIsOpen(!isOpen),className:\`mint-w-full mint-px-4 mint-py-2.5 mint-flex mint-items-center mint-gap-1 mint-text-left mint-text-\[14px\] mint-font-medium mint-text-gray-600 dark:mint-text-gray-400 hover:mint-text-gray-800 dark:hover:mint-text-gray-200 hover:mint-bg-gray-200/60 dark:hover:mint-bg-gray-700/60 mint-transition-all mint-duration-150\`,\\aria-expanded\\:isOpen,children:\[isOpen?\_jsx(Icon,{icon:\`caret-down\`,size:\`14\`,iconType:\`solid\`}):\_jsx(Icon,{icon:\`caret-right\`,size:\`14\`,iconType:\`solid\`}),\_jsx(\`span\`,{children:\`See result...\`})\]}),isOpen\u0026\u0026_jsx(\`div\`,{className:\`\[\u0026\>\*\]:!mint-mt-0 \[\u0026\>\*\]:!mint-rounded-t-none mint-border-t mint-border-\[var(--op-border-ui)\] dark:mint-border-\[var(--op-border-ui-dark)\]\`,children:\_jsx(CodeBlock,{language:resultLang\|\|language,children:result,wrap,expandable})})\]})\]})};function \_createMdxContent(props){const \_components={a:\`a\`,code:\`code\`,li:\`li\`,ol:\`ol\`,p:\`p\`,pre:\`pre\`,span:\`span\`,strong:\`strong\`,ul:\`ul\`,...\_provideComponents(),...props.components},{Accordion,CodeBlock,Heading,Tab,Tabs,Tip,Warning,\_MdxComponentBoundary}=\_components;if(!Accordion)\_missingMdxReference(\`Accordion\`,true);if(!CodeBlock)\_missingMdxReference(\`CodeBlock\`,true);if(!Heading)\_missingMdxReference(\`Heading\`,true);if(!Tab)\_missingMdxReference(\`Tab\`,true);if(!Tabs)\_missingMdxReference(\`Tabs\`,true);if(!Tip)\_missingMdxReference(\`Tip\`,true);if(!Warning)\_missingMdxReference(\`Warning\`,true);if(!\_MdxComponentBoundary)\_missingMdxReference(\`\_MdxComponentBoundary\`,true);return \_jsxs(\_Fragment,{children:\[\_jsxs(\_components.p,{children:\[\`With \`,\_jsx(\_components.a,{href:\`/cli/reference/commands/run/\`,children:\_jsx(\_components.code,{children:\`op run\`})}),\`, you can provide your project secrets directly from 1Password to an application or script as environment variables at runtime. You can use \`,\_jsx(\_components.code,{children:\`op run\`}),\` with \`,\_jsx(\_components.a,{href:\`/environments\`,children:\`1Password Environments\`}),\`, environment variables set to \`,\_jsx(\_components.a,{href:\`/cli/secret-references\`,children:\`secret references\`}),\`, or a combination of both.\`\]}),\`\n\`,\_jsx(\_components.p,{children:\`1Password CLI loads the specified secrets, then runs the provided command in a subprocess with the secrets made available as environment variables only for the duration of the process. This allows you to avoid hardcoding any plaintext secrets and quickly switch between different sets of secrets for different development contexts.\`}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`choose-your-configuration\`,children:\`Choose your configuration\`}),\`\n\`,\_jsx(\_components.p,{children:\`1Password CLI provides multiple methods to load your project secrets:\`}),\`\n\`,\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\_jsx(\_components.strong,{children:\_jsx(\_components.a,{href:\`/environments\`,children:\`1Password Environments\`})}),\` allow you to create Environments in 1Password that contain all your environment variables for a specific workflow. You can share Environments with your team and create separate Environments for each project, application, or development context (like staging or production).\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\_jsx(\_components.strong,{children:\_jsx(\_components.a,{href:\`/cli/secret-references\`,children:\`Secret references\`})}),\` are URIs that point to where a secret is stored in your 1Password account. A secret reference uses the names or unique identifiers of the vault, item, section, and field where the secret is stored in 1Password. You can set environment variables to secret references on the command line or use secret references in your \`,\_jsx(\_components.code,{children:\`.env\`}),\` files. Secret references require more manual setup than 1Password Environments to switch between different sets of environment variables for different contexts, or create shared team workflows.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\_jsx(\_components.strong,{children:\`Hybrid approach\`}),\`: You can use \`,\_jsx(\_components.code,{children:\`op run\`}),\` to load variables from a 1Password Environment alongside secret references from \`,\_jsx(\_components.code,{children:\`.env\`}),\` files or exported environment variables.\`\]}),\`\n\`\]}),\`\n\`\]}),\`\n\`,\_jsx(Tip,{children:\_jsxs(\_components.p,{children:\[\`Authenticate with a \`,\_jsx(\_components.a,{href:\`/service-accounts/\`,children:\`1Password Service Account\`}),\` to follow the \`,\_jsx(\_components.a,{href:\`/cli/best-practices/\`,children:\`principle of least privilege\`}),\`. You can scope service account access to specific vaults and 1Password Environments so that processes in your authorized terminal session can only access secrets required for a given purpose.\`\]})}),\`\n\`,\_jsx(Warning,{children:\_jsx(\_components.p,{children:\`You should assume that processes on your computer can access the environment of other processes run by the same user. Be aware of this when supplying secrets through environment variables.\`})}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`requirements\`,children:\`Requirements\`}),\`\n\`,\_jsxs(Tabs,{queryString:\`workflow-type\`,groupId:\`workflow\`,children:\[\_jsx(Tab,{value:\`environment\`,title:\`1Password Environment\`,id:\`1password-environment\`,children:\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`https://1password.com/pricing/password-manager\`,children:\`Sign up for 1Password.\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/cli/get-started#step-1-install-1password-cli\`,children:\`Install 1Password CLI.\`})}),\`\n\`\]})}),\_jsxs(Tab,{value:\`secret-references\`,title:\`Secret references\`,id:\`secret-references\`,children:\[\_jsx(\_components.p,{children:\`Before you can load secrets into the environment, you’ll need to:\`}),\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`https://1password.com/pricing/password-manager\`,children:\`Sign up for 1Password.\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/cli/get-started#step-1-install-1password-cli\`,children:\`Install 1Password CLI.\`})}),\`\n\`\]})\]})\]}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`step-1-store-your-project-secrets-in-1password\`,children:\`Step 1: Store your project secrets in 1Password\`}),\`\n\`,\_jsxs(Tabs,{queryString:\`workflow-type\`,groupId:\`workflow\`,children:\[\_jsx(Tab,{value:\`environment\`,title:\`1Password Environment\`,id:\`1password-environment-2\`,children:\_jsxs(\_components.p,{children:\[\`To store your project secrets in a 1Password Environment, \`,\_jsx(\_components.a,{href:\`/environments\`,children:\`follow the steps to create an Environment\`}),\`, then import a \`,\_jsx(\_components.code,{children:\`.env\`}),\` file or manually add your environment variables.\`\]})}),\_jsxs(Tab,{value:\`secret-references\`,title:\`Secret references\`,id:\`secret-references-2\`,children:\[\_jsx(\_components.p,{children:\`To use secret references, save your project secrets as items in a vault in your 1Password account.\`}),\_jsx(\_components.p,{children:\`Then follow the instructions to create secret references for each item using your preferred method:\`}),\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\_jsx(\_components.a,{href:\`/cli/secret-reference-syntax#with-the-1password-desktop-app\`,children:\`With the 1Password desktop app\`}),\`: Copy secret references from the app.\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\_jsx(\_components.a,{href:\`/vscode#get-values\`,children:\`With 1Password for VSCode\`}),\`: Insert secret references from 1Password as you edit code.\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\_jsx(\_components.a,{href:\`/cli/secret-reference-syntax#with-1password-cli\`,children:\`With 1Password CLI\`}),\`: Get secret references for one or multiple fields with \`,\_jsx(\_components.code,{children:\`op item get\`}),\`.\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`Use the \`,\_jsx(\_components.a,{href:\`/cli/secret-reference-syntax#syntax-rules\`,children:\`secret reference syntax rules\`}),\` to write secret references manually.\`\]}),\`\n\`\]})\]})\]}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`step-2-pass-the-secrets-to-the-application\`,children:\`Step 2: Pass the secrets to the application\`}),\`\n\`,\_jsxs(Tabs,{queryString:\`workflow-type\`,groupId:\`workflow\`,children:\[\_jsxs(Tab,{value:\`environment\`,title:\`1Password Environment\`,id:\`1password-environment-3\`,children:\[\_jsx(\_components.p,{children:\`To pass your environment variables from 1Password to an application or script:\`}),\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Open the 1Password app and navigate to \`,\_jsx(\_components.strong,{children:\`Developer\`}),\` \> \`,\_jsx(\_components.strong,{children:\`Environments\`}),\`.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Select the Environment where your project secrets are stored, then select \`,\_jsx(\_components.strong,{children:\`Manage environment\`}),\` \> \`,\_jsx(\_components.strong,{children:\`Copy environment ID\`}),\`.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Use \`,\_jsx(\_components.code,{children:\`op run --\`}),\` with the command for starting the application or script. 1Password will run the provided command in a subprocess with the secrets made available as environment variables for the duration of the process.\`\]}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` run\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --environment\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u003c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`environmentI\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`D\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u003c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`comman\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`d\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`})\]}),\`\n\`\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`For example:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` run\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --environment\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` blgexucrwfr2dtsxe2q4uu7dp4\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` ./my-script.sh\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`\]})\]}),\_jsxs(Tab,{value:\`secret-references\`,title:\`Secret references\`,id:\`secret-references-3\`,\\data-child-tab-ids\\:\`\[\\environment-file\\,\\command-line\\,\\environment-file-2\\,\\command-line-2\\\]\`,\\data-child-heading-ids\\:\`\[\\optional%3A-differentiate-between-environments\\\]\`,children:\[\_jsx(Heading,{level:\`3\`,id:\`step-1%3A-map-secret-references-to-environment-variables\`,children:\`Step 1: Map secret references to environment variables\`}),\_jsxs(\_components.p,{children:\[\`To pass secrets to an application or script using \`,\_jsx(\_components.code,{children:\`op run\`}),\` and \`,\_jsx(\_components.a,{href:\`/cli/secret-references\`,children:\`secret references\`}),\`, you must first map the secret references to the appropriate environment variables. To do this, you can set environment variables to secret references using an environment file or export them on the command line.\`\]}),\_jsxs(Tabs,{queryString:\`secret-reference-options\`,groupId:\`secret-reference-options\`,children:\[\_jsxs(Tab,{value:\`env-files\`,title:\`Environment file\`,id:\`environment-file\`,\\data-child-heading-ids\\:\`\[\\optional%3A-differentiate-between-environments\\\]\`,children:\[\_jsxs(\_components.p,{children:\[\`Environment (\`,\_jsx(\_components.code,{children:\`.env\`}),\`) files allow you to define multiple environment variables as secret references with \`,\_jsx(\_components.code,{children:\`KEY=VALUE\`}),\` statements separated by a newline.\`\]}),\_jsxs(\_components.p,{children:\[\`To use an environment file with \`,\_jsx(\_components.code,{children:\`op run\`}),\`, add key-value pairs for each of your project secrets with the value set to a \`,\_jsx(\_components.a,{href:\`/cli/secret-references\`,children:\`secret reference\`}),\`. For example:\`\]}),\_jsx(CodeBlock,{filename:\`prod.env\`,numberOfLines:\`2\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`2\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`AWS_ACCESS_KEY_ID\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`=\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`\\op://development/aws/Access Keys/access_key_id\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`AWS_SECRET_ACCESS_KEY\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`=\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`\\op://development/aws/Access Keys/secret_access_key\\\`})\]}),\`\n\`\]})})}),\_jsxs(Accordion,{title:\`Environment file syntax rules\`,id:\`environment-file-syntax-rules\`,children:\[\_jsxs(\_components.p,{children:\[\`The \`,\_jsx(\_components.code,{children:\`.env\`}),\` file parsing engine follows the following rules:\`\]}),\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Environment variables are defined as \`,\_jsx(\_components.code,{children:\`KEY=VALUE\`}),\` statements separated by a newline.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Variables can span multiple lines if they are enclosed in either \`,\_jsx(\_components.code,{children:\`'\`}),\` or \`,\_jsx(\_components.code,{children:\`\\\`}),\`:\`\]}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`3\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`3\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`MY_VAR = \\this is on the first line\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`and this is on the second line\\\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Empty lines are skipped.\`}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Lines beginning with \`,\_jsx(\_components.code,{children:\`#\`}),\` are treated as comments. Comments can also be placed inline after \`,\_jsx(\_components.code,{children:\`KEY=VALUE\`}),\` statements.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Empty values become empty strings. For example, \`,\_jsx(\_components.code,{children:\`EMPTY=\`}),\` will set the environment variable \`,\_jsx(\_components.code,{children:\`EMPTY\`}),\` to the empty string.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`If a value is surrounded by single or double quotes, these quotes do not end up in the evaluated value. So \`,\_jsx(\_components.code,{children:\`KEY=\\VALUE\\\`}),\` and \`,\_jsx(\_components.code,{children:\`KEY='VALUE'\`}),\` both evaluate to \`,\_jsx(\_components.code,{children:\`KEY\`}),\` and \`,\_jsx(\_components.code,{children:\`VALUE\`}),\`.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Occurrences of \`,\_jsx(\_components.code,{children:\`\$VAR_NAME\`}),\` or \`,\_jsx(\_components.code,{children:\\\${VAR_NAME}\\}),\` are replaced with their respective value from the environment.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`A variable defined in a .env file can be referred to later in the same file:\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`3\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`3\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`SOME_VAR = value\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\\OTHER_VAR = \${SOME_VAR}\\})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Special characters can be escaped with \`,\_jsx(\_components.code,{children:\`\\\\\`}),\`. For example, \`,\_jsx(\_components.code,{children:\`MY_VAR = \\\\\\\$SOME_VAR that is not actually replaced.\\\`}),\` results in the following value for MY_VAR: \`,\_jsx(\_components.code,{children:\`\$SOME_VAR that is not actually replaced.\`}),\`.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Inner quotes are maintained, so \`,\_jsx(\_components.code,{children:\`JSON={\\foo\\:\\bar\\}\`}),\` evaluates to \`,\_jsx(\_components.code,{children:\`JSON\`}),\` and \`,\_jsx(\_components.code,{children:\`{\\foo\\:\\bar\\}\`}),\`.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Variables do not get replaced in values that are enclosed in single quotes. So \`,\_jsx(\_components.code,{children:\`KEY='\$SOME_VAR'\`}),\` evaluates to \`,\_jsx(\_components.code,{children:\`KEY\`}),\` and \`,\_jsx(\_components.code,{children:\`\$SOME_VAR\`}),\`.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Template syntax can be used in the \`,\_jsx(\_components.code,{children:\`VALUE\`}),\` to inject secrets. The \`,\_jsx(\_components.code,{children:\`KEY\`}),\` can only contain template variables.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Template parsing is performed after \`,\_jsx(\_components.code,{children:\`.env\`}),\` file parsing, so you cannot use the former to construct the latter.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Leading and trailing whitespace of both \`,\_jsx(\_components.code,{children:\`KEY\`}),\` and \`,\_jsx(\_components.code,{children:\`VALUE\`}),\` segments are ignored, so \`,\_jsx(\_components.code,{children:\`KEY = VALUE\`}),\` is parsed the same as \`,\_jsx(\_components.code,{children:\`KEY=VALUE\`}),\`.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Single and double quoted values maintain both leading and trailing whitespace, so \`,\_jsx(\_components.code,{children:\`KEY=\\ some value \\\`}),\` evaluates to \`,\_jsx(\_components.code,{children:\`KEY\`}),\` and \`,\_jsx(\`code\`,{children:\`\\xA0some value\\xA0\`}),\`.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`These files should use UTF-8 character encoding.\`}),\`\n\`\]}),\`\n\`\]})\]}),\_jsx(Heading,{level:\`3\`,id:\`optional-differentiate-between-environments\`,children:\`Optional: Differentiate between environments\`}),\_jsx(Tip,{children:\_jsx(\_components.p,{children:\`If you need to pass secrets for multiple environments, we recommend using 1Password Environments instead of secret references. 1Password Environments allow you to more easily organize, share, and pass environment variables for multiple contexts.\`})}),\_jsxs(\_components.p,{children:\[\`If you have different sets of secrets for different environments, like staging and production, you can check a single environment file into source control and include a variable within the secret references to represent the context. You can then set the variable to the appropriate context when you pass the file to \`,\_jsx(\_components.code,{children:\`op run\`}),\`.\`\]}),\_jsxs(\_components.p,{children:\[\`To use this approach, you must organize your project secrets in 1Password into different vaults for each environment, with each item’s fields structured in the same way. For example: \`,\_jsx(\_components.code,{children:\`dev/mysql/password\`}),\` and \`,\_jsx(\_components.code,{children:\`prod/mysql/password\`}),\`.\`\]}),\_jsxs(\_components.p,{children:\[\`Then, include an externally set variable (\`,\_jsx(\_components.code,{children:\`\$VARIABLE_NAME\`}),\`) in place of the vault name for each secret reference in your environment file.\`\]}),\_jsxs(\_components.p,{children:\[\`For example, in the following environment file, \`,\_jsx(\_components.code,{children:\`\$APP_ENV\`}),\` is the externally set environment variable. It can be set to \`,\_jsx(\_components.code,{children:\`dev\`}),\` or \`,\_jsx(\_components.code,{children:\`prod\`}),\` to load secrets from either the \`,\_jsx(\_components.code,{children:\`dev\`}),\` vault or the \`,\_jsx(\_components.code,{children:\`prod\`}),\` vault in 1Password.\`\]}),\_jsx(CodeBlock,{filename:\`app.env\`,numberOfLines:\`3\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`3\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`MYSQL_DATABASE\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\op://\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$APP_ENV\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`/mysql/database\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`MYSQL_USERNAME\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\op://\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$APP_ENV\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`/mysql/username\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`MYSQL_PASSWORD\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\op://\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$APP_ENV\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`/mysql/password\\\`})\]}),\`\n\`\]})})})\]}),\_jsxs(Tab,{value:\`export\`,title:\`Command line\`,id:\`command-line\`,\\data-child-tab-ids\\:\`\[\\bash%2C-zsh%2C-sh\\,\\fish\\,\\powershell\\\]\`,children:\[\_jsxs(\_components.p,{children:\[\`You can individually export environment variables as \`,\_jsx(\_components.a,{href:\`/cli/secret-reference-syntax/\`,children:\`secret references\`}),\` from the command line.\`\]}),\_jsxs(\_components.p,{children:\[\`For example, to set the variable \`,\_jsx(\_components.code,{children:\`GITHUB_TOKEN\`}),\` to a secret reference URI that points to the \`,\_jsx(\_components.code,{children:\`personal_token\`}),\` field within a \`,\_jsx(\_components.code,{children:\`credentials\`}),\` section in a \`,\_jsx(\_components.code,{children:\`GitHub\`}),\` item:\`\]}),\_jsxs(Tabs,{groupId:\`shells\`,children:\[\_jsx(Tab,{value:\`bash-zsh-sh\`,title:\`Bash, Zsh, sh\`,default:true,id:\`bash%2C-zsh%2C-sh\`,children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#569CD6\`},children:\`export\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` GITHUB_TOKEN\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`=\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`://\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`development\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`/\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`GitHub\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`/\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`credentials\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`/\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`personal_token\`})\]}),\`\n\`\]})})})}),\_jsx(Tab,{value:\`fish\`,title:\`fish\`,default:true,id:\`fish\`,children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`set\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -x\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` GITHUB_TOKEN\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` op://development/GitHub/credentials/personal_token\`})\]}),\`\n\`\]})})})}),\_jsx(Tab,{value:\`powershell\`,title:\`PowerShell\`,default:true,id:\`powershell\`,children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`powershell\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`powershell\`,children:\_jsxs(\_components.code,{language:\`powershell\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`Env:\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`GITHUB_TOKEN\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\op://development/GitHub/credentials/personal_token\\\`})\]}),\`\n\`\]})})})})\]})\]})\]}),\_jsx(Heading,{level:\`3\`,id:\`step-2%3A-pass-the-resolved-secret-references-to-the-application\`,children:\`Step 2: Pass the resolved secret references to the application\`}),\_jsxs(Tabs,{queryString:\`secret-reference-options\`,groupId:\`secret-reference-options\`,children:\[\_jsxs(Tab,{value:\`env-files\`,title:\`Environment file\`,id:\`environment-file-2\`,\\data-child-tab-ids\\:\`\[\\bash%2C-zsh%2C-sh%2C-fish\\,\\powershell-2\\\]\`,children:\[\_jsxs(\_components.p,{children:\[\`To use an environment file with \`,\_jsx(\_components.code,{children:\`op run\`}),\`, specify the path to the environment file using the \`,\_jsx(\_components.code,{children:\`--env-file\`}),\` flag:\`\]}),\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` run\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --env-file=\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`\\./prod.env\\\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` aws\`})\]}),\`\n\`\]})})}),\_jsxs(\_components.p,{children:\[\`If you structured your environment file to load secrets for multiple environments, make sure to also set the variable for the vault (in the example below, \`,\_jsx(\_components.code,{children:\`APP_ENV\`}),\`).\`\]}),\_jsxs(\_components.p,{children:\[\`For example, to pass secrets from the \`,\_jsx(\_components.code,{children:\`dev\`}),\` vault to an application running in the development environment:\`\]}),\_jsxs(Tabs,{groupId:\`shells\`,children:\[\_jsx(Tab,{value:\`bash-zsh-sh-fish\`,title:\`Bash, Zsh, sh, fish\`,default:true,id:\`bash%2C-zsh%2C-sh%2C-fish\`,children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`APP_ENV\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`=\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`dev\`}),\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` run\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --env-file=\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`\\./app.env\\\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` myapp\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` deploy\`})\]}),\`\n\`\]})})})}),\_jsx(Tab,{value:\`powershell\`,title:\`PowerShell\`,id:\`powershell-2\`,children:\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Set the \`,\_jsx(\_components.code,{children:\`\$APP_ENV\`}),\` variable:\`\]}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`powershell\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`powershell\`,children:\_jsxs(\_components.code,{language:\`powershell\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`ENV:\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`APP_ENV\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\dev\\\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Run \`,\_jsx(\_components.code,{children:\`op run\`}),\` with the environment file:\`\]}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`powershell\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`powershell\`,children:\_jsxs(\_components.code,{language:\`powershell\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`op run \`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`--\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`env\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`-\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`file\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`=\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`\\./app.env\\\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` --\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` myapp deploy\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`\]})})\]})\]}),\_jsxs(Tab,{value:\`export\`,title:\`Command line\`,id:\`command-line-2\`,children:\[\_jsxs(\_components.p,{children:\[\`If you exported environment variables as secret references on the command line, use \`,\_jsx(\_components.code,{children:\`op run --\`}),\` with the command to start the application or script. 1Password will run the provided command in a subprocess with the secrets made available as environment variables for the duration of the process.\`\]}),\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` run\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u003c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`comman\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`d\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`})\]}),\`\n\`\]})})}),\_jsx(\_components.p,{children:\`For example:\`}),\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` run\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` gh\`})\]}),\`\n\`\]})})}),\_jsxs(Tip,{children:\[\_jsx(\_components.p,{children:\_jsx(\_components.strong,{children:\`Expand variables in a subshell\`})}),\_jsxs(\_components.p,{children:\[\`When you reference a variable like \`,\_jsx(\_components.code,{children:\`\$MY_VAR\`}),\` in the same command where you call \`,\_jsx(\_components.code,{children:\`op run\`}),\`, your shell expands \`,\_jsx(\_components.code,{children:\`\$MY_VAR\`}),\` before \`,\_jsx(\_components.code,{children:\`op run\`}),\` can substitute the secret reference. For example, a command like the following will pass the secret reference URI instead of the secret value from 1Password:\`\]}),\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`MY_VAR\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`=\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`op://vault/item/field\`}),\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` run\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --no-masking\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` echo\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\$MY_VAR\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`\\\`})\]}),\`\n\`\]})})}),\_jsxs(\_components.p,{children:\[\`To make sure \`,\_jsx(\_components.code,{children:\`op run\`}),\` substitutes the secret before the variable expands, run the command to expand the variable in a subshell:\`\]}),\_jsx(\_MdxComponentBoundary,{name:\`CodeResult\`,children:\_jsx(CodeResult,{children:\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`3\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`3\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`MY_VAR\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`=\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`op://vault/item/field\`}),\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` run\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --no-masking\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` sh\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` -c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` 'echo \\\$MY_VAR\\'\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#6E7781\`,\\--shiki-dark\\:\`#6A9955\`},children:\`#code-result open\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`skdjfs7dyrwhk4jhref\`})}),\`\n\`\]})})})})})\]})\]})\]})\]})\]}),\`\n\`,\_jsxs(Tip,{children:\[\_jsx(\_components.p,{children:\_jsx(\_components.strong,{children:\`Use both methods together\`})}),\_jsxs(\_components.p,{children:\[\`You can load environment variables from an Environment in combination with secret references from a \`,\_jsx(\_components.code,{children:\`.env\`}),\` file or flag. For example:\`\]}),\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` run\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --environment\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u003c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`I\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`D\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --env-file=\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`\\./extra-secrets.env\\\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \u003c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`comman\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`d\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`})\]}),\`\n\`\]})})})\]}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`next-step-run-in-production\`,children:\`Next step: Run in production\`}),\`\n\`,\_jsx(\_components.p,{children:\`Now that the application works locally, choose how to load your secrets in production or CI/CD:\`}),\`\n\`,\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\_jsx(\_components.strong,{children:\_jsx(\_components.a,{href:\`/service-accounts/use-with-1password-cli\`,children:\`1Password Service Account\`})}),\`: Automate access with a service account token. Service accounts support both secret references and 1Password Environments.\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\_jsx(\_components.strong,{children:\_jsx(\_components.a,{href:\`/connect/cli/\`,children:\`1Password Connect Server\`})}),\`: Best for self-hosting within your own infrastructure. Connect only supports secret references and does not currently support 1Password Environments.\`\]}),\`\n\`\]}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`learn-more\`,children:\`Learn more\`}),\`\n\`,\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/service-accounts/use-with-1password-cli\`,children:\`Use 1Password Service Accounts with 1Password CLI\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/connect/cli#continuous-integration-ci-environments\`,children:\`Use 1Password Connect Server with 1Password CLI\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/cli/secrets-config-files/\`,children:\`Load secrets into config files\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/cli/secret-reference-syntax/\`,children:\`Secret reference syntax\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/cli/secrets-template-syntax/\`,children:\`Template syntax\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/get-started/secure-deployment\`,children:\`Workflow: Secure your deployments\`})}),\`\n\`\]})\]})}function MDXContent(props={}){const{wrapper:MDXLayout}={...\_provideComponents(),...props.components};return MDXLayout?\_jsx(MDXLayout,{...props,children:\_jsx(\_createMdxContent,{...props})}):\_createMdxContent(props)}return{CodeResult,default:MDXContent};function \_missingMdxReference(id,component){throw new Error(\`Expected \`+(component?\`component\`:\`object\`)+\\ \`\\+id+\\\` to be defined: you likely forgot to import, pass, or provide it.\\)}","frontmatter":{},"scope":{"config":{},"pageMetadata":{"id":"secrets-environment-variables","title":"Load secrets into the environment","sidebarTitle":"Load secrets into the environment","og:description":"Learn how to pass secrets as environment variables to an application or script using 1Password Environments or secret references.","slug":"/cli/secrets-environment-variables","pagination_next":"cli/secrets-config-files","description":null,"href":"/cli/secrets-environment-variables"}}},"mdxSourceWithNoJs":null,"noJsSplices":\[\[146,3043,")=\>null;function \_cr"\]\]},"mdxExtracts":{"tableOfContents":\[{"title":"Choose your configuration","slug":"choose-your-configuration","depth":2,"children":\[\]},{"title":"Requirements","slug":"requirements","depth":2,"children":\[\]},{"title":"Step 1: Store your project secrets in 1Password","slug":"step-1-store-your-project-secrets-in-1password","depth":2,"children":\[\]},{"title":"Step 2: Pass the secrets to the application","slug":"step-2-pass-the-secrets-to-the-application","depth":2,"children":\[{"title":"Step 1: Map secret references to environment variables","slug":"step-1%3A-map-secret-references-to-environment-variables","depth":3,"children":\[\],"tabId":"secret-references-3"},{"title":"Optional: Differentiate between environments","slug":"optional-differentiate-between-environments","depth":3,"children":\[\],"tabId":"environment-file"},{"title":"Step 2: Pass the resolved secret references to the application","slug":"step-2%3A-pass-the-resolved-secret-references-to-the-application","depth":3,"children":\[\],"tabId":"secret-references-3"}\]},{"title":"Next step: Run in production","slug":"next-step-run-in-production","depth":2,"children":\[\]},{"title":"Learn more","slug":"learn-more","depth":2,"children":\[\]}\],"codeExamples":{}},"jsLinks":\["/\_mintlify/custom/ab-634991b8/5ebc0d10523e8210/static/js/analytics.js","/\_mintlify/custom/ab-634991b8/5bb7437b1c9dcb44/static/js/gtag-prod-sst.js","/\_mintlify/custom/ab-634991b8/ee8ea0eeb20ecd1e/static/js/gtag-sst.js","/\_mintlify/custom/ab-634991b8/f2b239f3d459dc67/api-sdk-terms-notice.js","/\_mintlify/custom/ab-634991b8/3604035e212f8294/homepage-card-icons.js"\],"dynamicCss":".mint-mb-4 {\n margin-bottom: 1rem\n}\n.mint-flex {\n display: flex\n}\n.mint-w-full {\n width: 100%\n}\n.mint-items-center {\n align-items: center\n}\n.mint-gap-1 {\n gap: 0.25rem\n}\n.mint-overflow-hidden {\n overflow: hidden\n}\n.mint-border-t {\n border-top-width: 1px\n}\n.mint-border-t-0 {\n border-top-width: 0px\n}\n.mint-border-\\\[var\\(--op-border-ui\\)\\\] {\n border-color: var(--op-border-ui)\n}\n.mint-bg-gray-100\\/80 {\n background-color: rgb(243 244 246 / 0.8)\n}\n.mint-px-4 {\n padding-left: 1rem;\n padding-right: 1rem\n}\n.mint-py-2\\.5 {\n padding-top: 0.625rem;\n padding-bottom: 0.625rem\n}\n.mint-text-left {\n text-align: left\n}\n.mint-text-\\\[14px\\\] {\n font-size: 14px\n}\n.mint-font-medium {\n font-weight: 500\n}\n.mint-text-gray-600 {\n --tw-text-opacity: 1;\n color: rgb(75 85 99 / var(--tw-text-opacity, 1))\n}\n.mint-transition-all {\n transition-property: all;\n transition-timing-function: cubic-bezier(0.4, 0, 0.2, 1);\n transition-duration: 150ms\n}\n.mint-duration-150 {\n transition-duration: 150ms\n}\n.hover\\:mint-bg-gray-200\\/60:hover {\n background-color: rgb(229 231 235 / 0.6)\n}\n.hover\\:mint-text-gray-800:hover {\n --tw-text-opacity: 1;\n color: rgb(31 41 55 / var(--tw-text-opacity, 1))\n}\n.dark\\:mint-border-\\\[var\\(--op-border-ui-dark\\)\\\]:is(.dark \*) {\n border-color: var(--op-border-ui-dark)\n}\n.dark\\:mint-bg-gray-800\\/80:is(.dark \*) {\n background-color: rgb(31 41 55 / 0.8)\n}\n.dark\\:mint-text-gray-400:is(.dark \*) {\n --tw-text-opacity: 1;\n color: rgb(156 163 175 / var(--tw-text-opacity, 1))\n}\n.dark\\:hover\\:mint-bg-gray-700\\/60:hover:is(.dark \*) {\n background-color: rgb(55 65 81 / 0.6)\n}\n.dark\\:hover\\:mint-text-gray-200:hover:is(.dark \*) {\n --tw-text-opacity: 1;\n color: rgb(229 231 235 / var(--tw-text-opacity, 1))\n}\n.\\\[\\\u0026\\\>\\\*\\\]\\:\\!mint-mb-0\>\* {\n margin-bottom: 0px !important\n}\n.\\\[\\\u0026\\\>\\\*\\\]\\:\\!mint-mt-0\>\* {\n margin-top: 0px !important\n}\n.\\\[\\\u0026\\\>\\\*\\\]\\:\\!mint-rounded-b-none\>\* {\n border-bottom-right-radius: 0px !important;\n border-bottom-left-radius: 0px !important\n}\n.\\\[\\\u0026\\\>\\\*\\\]\\:\\!mint-rounded-t-none\>\* {\n border-top-left-radius: 0px !important;\n border-top-right-radius: 0px !important\n}","subdomain":"ab-634991b8","siteName":"1Password Developer","title":"Load secrets into the environment - 1Password Developer","relatedPagesConfig":{"enabled":true,"limit":3,"mode":"automatic"},"contextualStarterQuestions":\[{"\_id":"6ae4c9412086b3fba440c7ce","deploymentId":"68a8af9a517ab813d3b84097","questionText":"How do I load secrets?","status":"active","generatedBy":"contextual","path":"cli/secrets-environment-variables","createdAt":"2026-10-30T16:43:45.366Z","updatedAt":"2026-10-30T16:43:45.366Z","\_\_v":0},{"\_id":"6ae4c9412086b3fba440c7cf","deploymentId":"68a8af9a517ab813d3b84097","questionText":"What's the setup process?","status":"active","generatedBy":"contextual","path":"cli/secrets-environment-variables","createdAt":"2026-10-30T16:43:45.366Z","updatedAt":"2026-10-30T16:43:45.366Z","\_\_v":0},{"\_id":"6ae4c9412086b3fba440c7d0","deploymentId":"68a8af9a517ab813d3b84097","questionText":"Can I use environment variables?","status":"active","generatedBy":"contextual","path":"cli/secrets-environment-variables","createdAt":"2026-10-30T16:43:45.366Z","updatedAt":"2026-10-30T16:43:45.366Z","\_\_v":0}\],"navMaps":{"firstHrefInVersion":{},"firstHrefInLanguage":{}},"lastModified":"2026-10-30T16:43:21.127Z","originalFileLocation":"cli/secrets-environment-variables.mdx"},"headHtml":"\u003cscript data-mint-head\>(function(){var d=document.documentElement,p=null;if(!p){try{p=localStorage.getItem(\\isDarkMode\\)}catch(e){}if(p==='true')p='dark';else if(p==='false')p='light';if(p!=='light'\u0026\u0026p!=='dark'\u0026\u0026p!=='system')p=\\system\\}var r=p==='system'?(matchMedia(\\(prefers-color-scheme: dark)\\).matches?'dark':'light'):p;d.classList.remove(r==='dark'?'light':'dark');d.classList.add(r);d.setAttribute(\\data-theme-preference\\,p)})();\u003c/script\>\u003cmeta data-mint-head name=\\application-name\\ content=\\1Password Developer\\\>\u003cmeta data-mint-head name=\\generator\\ content=\\Mintlify\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\192x192\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/android-chrome-192x192.png\\ media=\\(prefers-color-scheme: light)\\\>\u003clink data-mint-head rel=\\apple-touch-icon\\ type=\\image/png\\ sizes=\\180x180\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/apple-touch-icon.png\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\16x16\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/favicon-16x16.png\\ media=\\(prefers-color-scheme: light)\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\32x32\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/favicon-32x32.png\\ media=\\(prefers-color-scheme: light)\\\>\u003clink data-mint-head rel=\\shortcut icon\\ type=\\image/x-icon\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/favicon.ico\\ media=\\(prefers-color-scheme: light)\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\192x192\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon-dark/android-chrome-192x192.png\\ media=\\(prefers-color-scheme: dark)\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\16x16\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon-dark/favicon-16x16.png\\ media=\\(prefers-color-scheme: dark)\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\32x32\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon-dark/favicon-32x32.png\\ media=\\(prefers-color-scheme: dark)\\\>\u003clink data-mint-head rel=\\shortcut icon\\ type=\\image/x-icon\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon-dark/favicon.ico\\ media=\\(prefers-color-scheme: dark)\\\>\u003cmeta data-mint-head property=\\og:title\\ content=\\Load secrets into the environment - 1Password Developer\\\>\u003cmeta data-mint-head property=\\og:description\\ content=\\Learn how to pass secrets as environment variables to an application or script using 1Password Environments or secret references.\\\>\u003cmeta data-mint-head property=\\og:site_name\\ content=\\1Password Developer\\\>\u003cmeta data-mint-head property=\\og:url\\ content=\\https://www.1password.dev/cli/secrets-environment-variables\\\>\u003cmeta data-mint-head property=\\og:type\\ content=\\website\\\>\u003cmeta data-mint-head property=\\og:image\\ content=\\https://ab-634991b8.mintlify.app/\_mintlify/api/og/v2?division=Load+secrets\u0026amp;title=Load+secrets+into+the+environment\u0026amp;theme=0e8ac3e29b6f66038c473d59\u0026amp;signature=821b237d9a44c15e517f45519b3e1e36aeadbdbdaebdf3463f0ef912c549c2fd\\\>\u003cmeta data-mint-head property=\\og:image:width\\ content=\\1200\\\>\u003cmeta data-mint-head property=\\og:image:height\\ content=\\630\\\>\u003cmeta data-mint-head name=\\twitter:card\\ content=\\summary_large_image\\\>\u003cmeta data-mint-head name=\\twitter:title\\ content=\\Load secrets into the environment - 1Password Developer\\\>\u003cmeta data-mint-head name=\\twitter:description\\ content=\\Learn how to pass secrets as environment variables to an application or script using 1Password Environments or secret references.\\\>\u003cmeta data-mint-head name=\\twitter:image\\ content=\\https://ab-634991b8.mintlify.app/\_mintlify/api/og/v2?division=Load+secrets\u0026amp;title=Load+secrets+into+the+environment\u0026amp;theme=0e8ac3e29b6f66038c473d59\u0026amp;signature=821b237d9a44c15e517f45519b3e1e36aeadbdbdaebdf3463f0ef912c549c2fd\\\>\u003cmeta data-mint-head name=\\twitter:image:width\\ content=\\1200\\\>\u003cmeta data-mint-head name=\\twitter:image:height\\ content=\\630\\\>\u003cmeta data-mint-head name=\\msapplication-config\\ content=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/browserconfig.xml\\\>\u003cmeta data-mint-head name=\\apple-mobile-web-app-title\\ content=\\1Password Developer\\\>\u003cmeta data-mint-head name=\\msapplication-TileColor\\ content=\\#104ebb\\\>\u003cmeta data-mint-head name=\\google-site-verification\\ content=\\YserOhXnJUjFfIZ4K3qgxkVSlQZQdXtIbBiKzZ35Nvs\\\>\u003clink data-mint-head rel=\\canonical\\ href=\\https://www.1password.dev/cli/secrets-environment-variables\\\>\u003clink data-mint-head rel=\\alternate\\ type=\\application/xml\\ href=\\/sitemap.xml\\\>\u003clink data-mint-head rel=\\alternate\\ type=\\text/markdown\\ href=\\/cli/secrets-environment-variables.md\\\>\u003cscript data-mint-head type=\\application/ld+json\\\>{\\@context\\:\\https://schema.org\\,\\@graph\\:\[{\\@type\\:\\Organization\\,\\@id\\:\\https://www.1password.dev/#organization\\,\\name\\:\\1Password Developer\\,\\url\\:\\https://www.1password.dev\\,\\logo\\:{\\@type\\:\\ImageObject\\,\\url\\:\\https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max\u0026auto=format\u0026n=lHrfVfSCdefFz8U5\u0026q=85\u0026s=29d1c9358888a723dddd8a89a3b6f71d\\}},{\\@type\\:\\WebSite\\,\\@id\\:\\https://www.1password.dev#website\\,\\name\\:\\1Password Developer\\,\\url\\:\\https://www.1password.dev\\,\\publisher\\:{\\@id\\:\\https://www.1password.dev/#organization\\}},{\\@type\\:\\WebPage\\,\\@id\\:\\https://www.1password.dev/cli/secrets-environment-variables#webpage\\,\\url\\:\\https://www.1password.dev/cli/secrets-environment-variables\\,\\name\\:\\Load secrets into the environment\\,\\dateModified\\:\\2026-10-30T16:43:21.127Z\\,\\isPartOf\\:{\\@id\\:\\https://www.1password.dev#website\\},\\breadcrumb\\:{\\@id\\:\\https://www.1password.dev/cli/secrets-environment-variables#breadcrumb\\}},{\\@type\\:\\BreadcrumbList\\,\\@id\\:\\https://www.1password.dev/cli/secrets-environment-variables#breadcrumb\\,\\itemListElement\\:\[{\\@type\\:\\ListItem\\,\\position\\:1,\\name\\:\\CLI\\,\\item\\:\\https://www.1password.dev/cli\\},{\\@type\\:\\ListItem\\,\\position\\:2,\\name\\:\\Load secrets into the environment\\,\\item\\:\\https://www.1password.dev/cli/secrets-environment-variables\\}\]},{\\@type\\:\[\\Article\\,\\TechArticle\\\],\\@id\\:\\https://www.1password.dev/cli/secrets-environment-variables#article\\,\\headline\\:\\Load secrets into the environment\\,\\name\\:\\Load secrets into the environment\\,\\url\\:\\https://www.1password.dev/cli/secrets-environment-variables\\,\\mainEntityOfPage\\:{\\@id\\:\\https://www.1password.dev/cli/secrets-environment-variables#webpage\\},\\dateModified\\:\\2026-10-30T16:43:21.127Z\\,\\publisher\\:{\\@id\\:\\https://www.1password.dev/#organization\\},\\isPartOf\\:{\\@id\\:\\https://www.1password.dev#website\\}}\]}\u003c/script\>","siteName":"1Password Developer","nav":{"global":null,"tabs":\[{"tab":"Get Started","pages":\[{"title":"Get Started","href":"/get-started"}\]},{"tab":"Tutorials","pages":\[{"title":"Tutorials","href":"/tutorials"}\]},{"tab":"Security for AI","pages":\[{"title":"Security for AI","href":"/security-for-ai"}\]},{"tab":"Environments","pages":\[{"title":"Environments","href":"/environments"}\]},{"tab":"SSH \u0026 Git","pages":\[{"title":"SSH \u0026 Git","href":"/ssh"}\]},{"tab":"CLI","groups":\[{"group":"CLI","pages":\[{"title":"1Password CLI","sidebarTitle":"Overview","href":"/cli"},{"title":"Use cases","sidebarTitle":"Use cases","href":"/cli/use-cases"},{"title":"Get started with 1Password CLI","sidebarTitle":"Get started","description":null,"href":"/cli/get-started"},{"group":"Guides","pages":\[{"group":"Load secrets","pages":\[{"title":"Load secrets into the environment","sidebarTitle":"Load secrets into the environment","href":"/cli/secrets-environment-variables"},{"title":"Load secrets into config files","sidebarTitle":"Inject secrets into config files","description":null,"href":"/cli/secrets-config-files"},{"title":"Load secrets into scripts","sidebarTitle":"Load secrets into scripts","href":"/cli/secrets-scripts"},{"title":"Use secret references with 1Password CLI","sidebarTitle":"Use secret references with 1Password CLI","href":"/cli/secret-references"}\]},{"group":"Manage items","pages":\[{"title":"Create items","sidebarTitle":"Create items","href":"/cli/item-create"},{"title":"Edit items","sidebarTitle":"Edit items","href":"/cli/item-edit"},{"title":"Manage SSH keys","sidebarTitle":"Manage SSH keys","href":"/cli/ssh-keys"}\]},{"group":"Manage team members","pages":\[{"title":"Add and remove team members","sidebarTitle":"Add and remove team members","href":"/cli/provision-users"},{"title":"Grant and revoke vault permissions","sidebarTitle":"Grant and revoke vault permissions","href":"/cli/grant-revoke-vault-permissions"},{"title":"Recover accounts using 1Password CLI","sidebarTitle":"Recover accounts","href":"/cli/recover-users"}\]}\]},{"group":"Reference","pages":\[{"title":"1Password CLI reference","sidebarTitle":"Overview","href":"/cli/reference"},{"title":"1Password CLI best practices","sidebarTitle":"Best practices","href":"/cli/best-practices"},{"group":"Commands","pages":\[{"group":"Management commands","pages":\[{"title":"account","sidebarTitle":"account","href":"/cli/reference/management-commands/account"},{"title":"connect","sidebarTitle":"connect","href":"/cli/reference/management-commands/connect"},{"title":"document","sidebarTitle":"document","href":"/cli/reference/management-commands/document"},{"title":"environment","href":"/cli/reference/management-commands/environment"},{"title":"events-api","sidebarTitle":"events-api","href":"/cli/reference/management-commands/events-api"},{"title":"group","sidebarTitle":"group","href":"/cli/reference/management-commands/group"},{"title":"item","sidebarTitle":"item","href":"/cli/reference/management-commands/item"},{"title":"plugin","sidebarTitle":"plugin","href":"/cli/reference/management-commands/plugin"},{"title":"service-account","sidebarTitle":"service-account","href":"/cli/reference/management-commands/service-account"},{"title":"user","sidebarTitle":"user","href":"/cli/reference/management-commands/user"},{"title":"vault","sidebarTitle":"vault","href":"/cli/reference/management-commands/vault"}\]},{"group":"General commands","pages":\[{"title":"completion","sidebarTitle":"completion","href":"/cli/reference/commands/completion"},{"title":"inject","sidebarTitle":"inject","href":"/cli/reference/commands/inject"},{"title":"read","sidebarTitle":"read","href":"/cli/reference/commands/read"},{"title":"run","sidebarTitle":"run","href":"/cli/reference/commands/run"},{"title":"signin","sidebarTitle":"signin","href":"/cli/reference/commands/signin"},{"title":"signout","sidebarTitle":"signout","href":"/cli/reference/commands/signout"},{"title":"update","sidebarTitle":"update","href":"/cli/reference/commands/update"},{"title":"whoami","sidebarTitle":"whoami","href":"/cli/reference/commands/whoami"}\]}\]},{"group":"Concepts","pages":\[{"title":"1Password CLI environment variables","sidebarTitle":"Environment variables","href":"/cli/environment-variables"},{"title":"Item fields","sidebarTitle":"Item fields","href":"/cli/item-fields"},{"title":"Item JSON template","sidebarTitle":"Item JSON template","href":"/cli/item-template-json"},{"title":"Secret reference syntax","sidebarTitle":"Secret reference syntax","href":"/cli/secret-reference-syntax"},{"title":"Template syntax","sidebarTitle":"Template syntax","href":"/cli/secrets-template-syntax"},{"title":"About vault permissions","sidebarTitle":"Vault permissions","href":"/cli/vault-permissions"},{"title":"User states","sidebarTitle":"User states","href":"/cli/user-states"}\]},{"title":"Use 1Password CLI with Connect","sidebarTitle":"Use with Connect","href":"/cli/connect"},{"title":"1Password app integration security","sidebarTitle":"1Password app integration security","href":"/cli/app-integration-security"}\]},{"group":"Configuration","pages":\[{"group":"Install","pages":\[{"title":"Get started with 1Password CLI","sidebarTitle":"Get started","href":"/cli/get-started"},{"sidebarTitle":"Verify installer","title":"Verify the authenticity of 1Password CLI","href":"/cli/verify"},{"title":"Install 1Password CLI on a server","sidebarTitle":"Install on a server","href":"/cli/install-server"},{"sidebarTitle":"Set configuration directories","title":"How 1Password CLI detects configuration directories","href":"/cli/config-directories"}\]},{"group":"Sign in","pages":\[{"title":"Use the 1Password desktop app to sign in to 1Password CLI","sidebarTitle":"Sign in using the app","href":"/cli/app-integration"},{"title":"Sign in to your 1Password account manually","sidebarTitle":"Sign in manually","href":"/cli/sign-in-manually"},{"title":"Unlock 1Password CLI with SSO","sidebarTitle":"Sign in with SSO","href":"/cli/sign-in-sso"},{"title":"Unlock 1Password CLI with Microsoft","sidebarTitle":"Sign in with Microsoft","href":"/cli/sign-in-sso-azure"},{"title":"Use multiple 1Password accounts with 1Password CLI","sidebarTitle":"Use multiple accounts","href":"/cli/use-multiple-accounts"}\]},{"title":"Update to the latest version of 1Password CLI","sidebarTitle":"Check for updates","href":"/cli/reference/update"},{"title":"Upgrade to 1Password CLI 2","sidebarTitle":"Upgrade from an earlier version","href":"/cli/upgrade"},{"sidebarTitle":"Uninstall","title":"Uninstall 1Password CLI","href":"/cli/uninstall"}\]},{"title":"Example scripts","sidebarTitle":"Example scripts","href":"/cli/scripts"},{"title":"Release notes","url":"https://app-updates.agilebits.com/product_history/CLI2","href":"/cli/release-notes"}\]}\]},{"tab":"SDKs","pages":\[{"title":"SDKs","href":"/sdks"}\]},{"tab":"More Tools","menu":\[{"item":"VS Code","icon":"laptop","pages":\[{"title":"VS Code","href":"/vscode"}\]},{"item":"Shell Plugins","icon":"puzzle-piece","pages":\[{"title":"Shell Plugins","href":"/cli/shell-plugins"}\]},{"item":"Integrations","icon":"puzzle","pages":\[{"title":"Integrations","href":"/integrations"}\]},{"item":"Secrets Automation","icon":"tablet-screen","pages":\[{"title":"Secrets Automation","href":"/secrets-automation"}\]},{"item":"Events API","icon":"sensor-triangle-exclamation","pages":\[{"title":"Events API","href":"/events-api"}\]},{"item":"Users API","icon":"id-badge","pages":\[{"title":"Users API","href":"/users-api"}\]},{"item":"SaaS Manager API","icon":"chart-line","pages":\[{"title":"SaaS Manager API","href":"/saas-manager-api"}\]},{"item":"Partnership API","icon":"users","pages":\[{"title":"Partnership API","href":"/partnership-api/reference"}\]},{"item":"Accounts API","icon":"user-gear","pages":\[{"title":"Accounts API","href":"/accounts-api"}\]},{"item":"Web Development","icon":"code","pages":\[{"title":"Web Development","href":"/web/add-1password-button-website"}\]},{"item":"Developer Watchtower","icon":"tower-control","pages":\[{"title":"Developer Watchtower","href":"/watchtower"}\]}\],"pages":\[{"title":"More Tools","href":"/vscode"}\]},{"tab":"Agentic Autofill partner guide","hidden":true,"pages":\[{"title":"Agentic Autofill partner guide","href":"/agentic-autofill/partners"}\]}\]},"basePath":"","title":"Load secrets into the environment - 1Password Developer","buildId":"dpl_DeHjVRGfFnhYQwHnfC2pjeXXv8h9","deploymentId":"dpl_DeHjVRGfFnhYQwHnfC2pjeXXv8h9","dynamics":\["10e4515597"\],"chunks":\["BannerMarkdown-CX_qQQOL.js","dist-BTZUMDnx.js","lib-DuNMoZ05.js","lib-B8HbPgcC.js","clsx-xpJZXxdP.js","html-void-elements-mCSPHezU.js","katex-YMM-FMeD.js","marked.esm-CZWythHk.js"\]}
