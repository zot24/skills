> Source: https://www.1password.dev/cli/secret-references/



Load secrets


# Use secret references with 1Password CLI


Use secret references to point to secrets stored in 1Password instead of putting plaintext values in your code, config files, and scripts.


``` shiki
op://<vault-name>/<item-name>/[section-name/]<field-name>
```


## <a href="#requirements" class="anchor-link" aria-label="Navigate to header: Requirements"></a><span id="_R_d9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Requirements</span>


1.  <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">Sign up for 1Password.</a>
2.  <a href="/cli/get-started/#step-1-install-1password-cli" class="link">Install 1Password CLI.</a>
3.  Save the secrets you want to reference in your 1Password account.

## <a href="#step-1-get-secret-references" class="anchor-link" aria-label="Navigate to header: Step 1: Get secret references"></a><span id="_R_j9deehkd74t9_" class="cursor-pointer">Step 1: Get secret references</span>


- <a href="/cli/secret-reference-syntax/#with-the-1password-desktop-app" class="link">With the 1Password desktop app</a>: Copy secret references from the app.
- <a href="/vscode/#get-values" class="link">With 1Password for VS Code</a>: Insert secret references from 1Password as you edit code.
- <a href="/cli/secret-reference-syntax/#with-1password-cli" class="link">With 1Password CLI</a>: Get secret references for one or multiple fields with `op item get`.
- <a href="/cli/secret-reference-syntax/#syntax-rules" class="link">With the secret reference syntax</a>: Write secret references manually.

## <a href="#step-2-replace-plaintext-secrets-with-secret-references" class="anchor-link" aria-label="Navigate to header: Step 2: Replace plaintext secrets with secret references"></a><span id="_R_p9deehkd74t9_" class="cursor-pointer">Step 2: Replace plaintext secrets with secret references</span>


## <a href="#step-3-resolve-secret-references" class="anchor-link" aria-label="Navigate to header: Step 3: Resolve secret references"></a><span id="_R_119deehkd74t9_" class="cursor-pointer">Step 3: Resolve secret references</span>


- <a href="#with-op-read" class="link">Use <code>op read</code> to write secrets to <code>stdout</code> or to a file.</a>
- <a href="#with-op-run" class="link">Use <code>op run</code> to pass secrets as environment variables to a process.</a>
- <a href="#with-op-inject" class="link">Use <code>op inject</code> to inject secrets into configuration files or scripts.</a>

### <a href="#with-op-read" class="anchor-link" aria-label="Navigate to header: With op read"></a><span id="_R_179deehkd74t9_" class="cursor-pointer">With `op read`</span>


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


#### <a href="#query-parameters" class="anchor-link" aria-label="Navigate to header: Query parameters"></a><span id="_R_1n9deehkd74t9_" class="cursor-pointer">Query parameters</span>


``` shiki
op://<vault>/<item>[/<section>]/<field>?attribute=<attribute-value>
```


### <a href="#with-op-run" class="anchor-link" aria-label="Navigate to header: With op run"></a><span id="_R_2d9deehkd74t9_" class="cursor-pointer">With `op run`</span>


- <span data-as="p">**Export the variable** as a secret reference before calling `op run`, or</span>
- <span data-as="p">Set the variable in the same command as `op run`, then **run the command to expand the variable in a subshell**. For example:</span>
  <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

  <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

  <div id="base-ui-_R_7lciij9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

  </div>

  <div id="base-ui-_R_7pciij9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

  <span class="sr-only" role="status"></span>

  </div>

  <div id="base-ui-_R_7tciij9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

  </div>

  </div>

  <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

  <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6ciij9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

  <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

  <div class="font-mono whitespace-pre leading-6">

  ``` shiki
  MY_VAR=op://vault/item/field op run --no-masking -- sh -c 'echo "$MY_VAR"'
  ```

  </div>

  </div>

  </div>

  </div>

  <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

  </div>

  </div>


#### <a href="#pass-the-secrets-to-an-application-or-script" class="anchor-link" aria-label="Navigate to header: Pass the secrets to an application or script"></a><span id="_R_2l9deehkd74t9_" class="cursor-pointer">Pass the secrets to an application or script</span>


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


#### <a href="#use-with-environment-files" class="anchor-link" aria-label="Navigate to header: Use with environment files"></a><span id="_R_359deehkd74t9_" class="cursor-pointer">Use with environment files</span>


``` shiki
DB_USER="op://app-dev/db/user"
DB_PASSWORD="op://app-dev/db/password"
```


``` shiki
op run --env-file="./node.env" -- node app.js
```


#### <a href="#print-a-secret-with-or-without-masking" class="anchor-link" aria-label="Navigate to header: Print a secret with or without masking"></a><span id="_R_3f9deehkd74t9_" class="cursor-pointer">Print a secret with or without masking</span>


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


### <a href="#with-op-inject" class="anchor-link" aria-label="Navigate to header: With op inject"></a><span id="_R_3n9deehkd74t9_" class="cursor-pointer">With `op inject`</span>


``` shiki
echo "here is my GitHub token: op://development/GitHub/credentials/personal_token" >> token.txt | op inject --out-file token.txt
```


``` shiki
here is my GitHub token: ghp_WzgPAEutsFRZH9uxWYtw
```


#### <a href="#use-with-configuration-files" class="anchor-link" aria-label="Navigate to header: Use with configuration files"></a><span id="_R_479deehkd74t9_" class="cursor-pointer">Use with configuration files</span>


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


## <a href="#learn-more" class="anchor-link" aria-label="Navigate to header: Learn more"></a><span id="_R_4h9deehkd74t9_" class="cursor-pointer">Learn more</span>

- <a href="/cli/secret-reference-syntax/" class="link">Secret reference syntax</a>
- <a href="/cli/secrets-environment-variables/" class="link">Load secrets into the environment</a>
- <a href="/cli/secrets-config-files/" class="link">Load secrets into config files</a>
- <a href="/cli/secrets-scripts/" class="link">Load secrets into scripts</a>
- <a href="/service-accounts/use-with-1password-cli" class="link">Use service accounts with 1Password CLI</a>
- <a href="/get-started/secure-developer-secrets" class="link">Workflow: Secure local development</a>


Was this page helpful?


