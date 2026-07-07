> Source: https://www.1password.dev/cli/secret-references/



Load secrets


# Use secret references with 1Password CLI


Copy page


Copy page


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
  MY_VAR=op://vault/item/field op run --no-masking -- sh -c 'echo "$MY_VAR"'
  ```

  </div>

  </div>

  <div class="print:hidden" data-fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

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

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" data-component-part="tab-button" data-active="true" data-testid="tab-Bash, Zsh, sh">

  Bash, Zsh, sh

  </div>

  </div>

- <div id="fish">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-fish">

  fish

  </div>

  </div>

- <div id="powershell">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-PowerShell">

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

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" data-component-part="tab-button" data-active="true" data-testid="tab-Bash, Zsh, sh">

  Bash, Zsh, sh

  </div>

  </div>

- <div id="fish-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-fish">

  fish

  </div>

  </div>

- <div id="powershell-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-PowerShell">

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
- <a href="/get-started/secure-developer-secrets" class="link">Workflow: Secure your developer secrets</a>


Was this page helpful?


<a href="/cli/secrets-scripts" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Load secrets into scripts</span></a><a href="/cli/item-create" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Create items</span></a>


