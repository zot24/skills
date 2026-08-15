> Source: https://www.1password.dev/cli/secret-references/



> ## Documentation Index
>
> Fetch the complete documentation index at: <a href="/llms.txt" tabindex="-1">/llms.txt</a>
>
> Use this file to discover all available pages before exploring further.


<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


<a href="/" class="select-none" style="-webkit-touch-callout:none"><span class="sr-only">1Password Developer home page</span><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=29d1c9358888a723dddd8a89a3b6f71d" class="nav-logo w-auto h-7 relative object-contain shrink-0 block dark:hidden" alt="light logo" /><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-light.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=119233092720e49043d6f42ff71125f1" class="nav-logo w-auto h-7 relative object-contain shrink-0 hidden dark:block" alt="dark logo" /></a>


Search...


Load secrets


Use secret references with 1Password CLI


<a href="/get-started" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Get Started</a>


<a href="/security-for-ai" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Security for AI</a>


<a href="/environments" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Environments</a>


<a href="/ssh" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SSH &amp; Git</a>


<a href="/cli" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200 [text-shadow:-0.2px_0_0_currentColor,0.2px_0_0_currentColor]" data-active="true" aria-current="location">CLI</a>


<a href="/sdks" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SDKs</a>


More Tools


Load secrets


# Use secret references with 1Password CLI


``` shiki
op://<vault-name>/<item-name>/[section-name/]<field-name>
```


## 


<a href="#requirements" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">Sign up for 1Password.</a>
2.  <a href="/cli/get-started#step-1-install-1password-cli" class="link">Install 1Password CLI.</a>
3.  Save the secrets you want to reference in your 1Password account.

## 


<a href="#step-1-get-secret-references" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/cli/secret-reference-syntax#with-the-1password-desktop-app" class="link">With the 1Password desktop app</a>: Copy secret references from the app.
- <a href="/vscode#get-values" class="link">With 1Password for VS Code</a>: Insert secret references from 1Password as you edit code.
- <a href="/cli/secret-reference-syntax#with-1password-cli" class="link">With 1Password CLI</a>: Get secret references for one or multiple fields with `op item get`.
- <a href="/cli/secret-reference-syntax#syntax-rules" class="link">With the secret reference syntax</a>: Write secret references manually.

## 


<a href="#step-2-replace-plaintext-secrets-with-secret-references" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#step-3-resolve-secret-references" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="#with-op-read" class="link">Use <code>op read</code> to write secrets to <code>stdout</code> or to a file.</a>
- <a href="#with-op-run" class="link">Use <code>op run</code> to pass secrets as environment variables to a process.</a>
- <a href="#with-op-inject" class="link">Use <code>op inject</code> to inject secrets into configuration files or scripts.</a>

### 


<a href="#with-op-read" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op read --out-file token.txt op://development/GitHub/credentials/personal_token
```


``` shiki
ghp_WzgPAEutsFRZH9uxWYtw
```


``` shiki
#!/bin/bash

docker login -u "$(op read op://prod/docker/username)" -p "$(op read op://prod/docker/password)"
```


#### 


<a href="#query-parameters" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op://<vault>/<item>[/<section>]/<field>?attribute=<attribute-value>
```


### 


<a href="#with-op-run" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <span data-as="p">**Export the variable** as a secret reference before calling `op run`, or</span>
- <span data-as="p">Set the variable in the same command as `op run`, then **run the command to expand the variable in a subshell**. For example:</span>
  <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" numberoflines="1" language="shellscript">

  <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

  <div id="base-ui-_R_dap556llktbsnlhjiuasnpfiutb_" class="z-10 select-none" base-ui-tooltip-trigger="">

  </div>

  <div id="base-ui-_R_dip556llktbsnlhjiuasnpfiutb_" class="z-10 select-none" base-ui-tooltip-trigger="">

  <span class="sr-only" role="status"></span>

  </div>

  <div id="base-ui-_R_dqp556llktbsnlhjiuasnpfiutb_" class="z-10 select-none" base-ui-tooltip-trigger="">

  </div>

  </div>

  <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

  <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" role="presentation" data-id="base-ui-_R_cp556llktbsnlhjiuasnpfiutb_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

  <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

  <div class="font-mono whitespace-pre leading-6">

  ``` shiki
  MY_VAR=op://vault/item/field op run --no-masking -- sh -c 'echo "$MY_VAR"'
  ```

  </div>

  </div>

  </div>

  </div>

  <div class="print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

  </div>

  </div>


#### 


<a href="#pass-the-secrets-to-an-application-or-script" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
$ node app.js
[INFO] Launching Node.js app...
[ERROR] Missing credentials DB_USER and DB_PASSWORD
[INFO] Exiting with code 1
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
export DB_USER="op://app-dev/db/user"
export DB_PASSWORD="op://app-dev/db/password"
```


``` shiki
set -x DB_USER="op://app-dev/db/user"
set -x DB_PASSWORD="op://app-dev/db/password"
```


``` shiki
$Env:DB_USER = "DB_USER=op://app-dev/db/user"
$Env:DB_PASSWORD = "DB_PASSWORD=op://app-dev/db/password"
```


``` shiki
op run -- node app.js
[INFO] Launching Node.js app...
[DEBUG] ✔ Connected to db as user 'mydbuser' with password '<concealed by 1Password>'
```


#### 


<a href="#use-with-environment-files" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
DB_USER="op://app-dev/db/user"
DB_PASSWORD="op://app-dev/db/password"
```


``` shiki
op run --env-file="./node.env" -- node app.js
```


#### 


<a href="#print-a-secret-with-or-without-masking" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


``` shiki
export DB_PASSWORD=op://app-prod/db/password
```


``` shiki
set -x DB_PASSWORD=op://app-prod/db/password
```


``` shiki
$Env:DB_PASSWORD = "DB_PASSWORD=op://app-prod/db/password"
```


### 


<a href="#with-op-inject" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
echo "here is my GitHub token: op://development/GitHub/credentials/personal_token" >> token.txt | op inject --out-file token.txt
```


``` shiki
here is my GitHub token: ghp_WzgPAEutsFRZH9uxWYtw
```


#### 


<a href="#use-with-configuration-files" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
database:
    host: http://localhost
    port: 5432
    username: op://prod/mysql/username
    password: op://prod/mysql/password
```


``` shiki
op inject --in-file config.yml.tpl --out-file config.yml
```


## 


<a href="#learn-more" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/cli/secret-reference-syntax" class="link">Secret reference syntax</a>
- <a href="/cli/secrets-environment-variables" class="link">Load secrets into the environment</a>
- <a href="/cli/secrets-config-files" class="link">Load secrets into config files</a>
- <a href="/cli/secrets-scripts" class="link">Load secrets into scripts</a>
- <a href="/service-accounts/use-with-1password-cli" class="link">Use service accounts with 1Password CLI</a>
- <a href="/get-started/secure-developer-secrets" class="link">Workflow: Secure local development</a>


Related topics

<a href="/cli/secret-reference-syntax" class="flex items-center gap-2 rounded-lg py-1.5 text-gray-950 dark:text-gray-50 hover:text-primary dark:hover:text-primary-light"><span class="text-sm tracking-[-0.1px] line-clamp-1">Secret reference syntax</span></a><a href="/cli/reference" class="flex items-center gap-2 rounded-lg py-1.5 text-gray-950 dark:text-gray-50 hover:text-primary dark:hover:text-primary-light"><span class="text-sm tracking-[-0.1px] line-clamp-1">1Password CLI reference</span></a><a href="/cli/connect" class="flex items-center gap-2 rounded-lg py-1.5 text-gray-950 dark:text-gray-50 hover:text-primary dark:hover:text-primary-light"><span class="text-sm tracking-[-0.1px] line-clamp-1">Use 1Password CLI with Connect</span></a>


Was this page helpful?


Responses are generated using AI and may contain mistakes.


<a href="mailto:support@1password.com" class="group flex justify-between items-center gap-1 mt-2 py-1 transition-colors duration-200" data-component-part="contact-support-button"><span data-component-part="contact-support-icon"></span></a>

Contact support


