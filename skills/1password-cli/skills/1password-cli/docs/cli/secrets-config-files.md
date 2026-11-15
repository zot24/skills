> Source: https://www.1password.dev/cli/secrets-config-files/



Load secrets


# Load secrets into config files


## <a href="#requirements" class="anchor-link" aria-label="Navigate to header: Requirements"></a><span id="_R_59deehkd74t9_" class="min-w-0 break-words cursor-pointer">Requirements</span>


1.  <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">Sign up for 1Password.</a>
2.  <a href="/cli/get-started/#step-1-install-1password-cli" class="link">Install 1Password CLI.</a>
3.  Store the secrets you want to provision in your 1Password account.

## <a href="#step-1-get-secret-references" class="anchor-link" aria-label="Navigate to header: Step 1: Get secret references"></a><span id="_R_b9deehkd74t9_" class="cursor-pointer">Step 1: Get secret references</span>


- <a href="/cli/secret-reference-syntax/#with-the-1password-desktop-app" class="link">With the 1Password desktop app</a>: Copy secret references from the app.
- <a href="/vscode/#get-values" class="link">With 1Password for VSCode</a>: Insert secret references from 1Password as you edit code.
- <a href="/cli/secret-reference-syntax/#with-1password-cli" class="link">With 1Password CLI</a>: Get secret references for one or multiple fields with `op item get`.
- Use the <a href="/cli/secret-reference-syntax/#syntax-rules" class="link">secret reference syntax rules</a> to write secret references manually.

## <a href="#step-2-use-secret-references-in-your-config-file" class="anchor-link" aria-label="Navigate to header: Step 2: Use secret references in your config file"></a><span id="_R_h9deehkd74t9_" class="cursor-pointer">Step 2: Use secret references in your config file</span>


``` shiki
database:
    host: http://localhost
    port: 5432
    username: mysql-user
    password: piG1rX5P1QMF6J5k7u7sNb
```


``` shiki
database:
    host: http://localhost
    port: 5432
    username: op://prod/mysql/username
    password: op://prod/mysql/password
```


## <a href="#step-2-inject-the-secrets" class="anchor-link" aria-label="Navigate to header: Step 2: Inject the secrets"></a><span id="_R_t9deehkd74t9_" class="cursor-pointer">Step 2: Inject the secrets</span>


``` shiki
op inject -i config.yml.tpl -o config.yml
```


## <a href="#step-3-differentiate-between-environments" class="anchor-link" aria-label="Navigate to header: Step 3: Differentiate between environments"></a><span id="_R_199deehkd74t9_" class="cursor-pointer">Step 3: Differentiate between environments</span>


``` shiki
database:
    host: http://localhost
    port: 5432
    username: op://$APP_ENV/mysql/username
    password: op://$APP_ENV/mysql/password
```


- <div id="bash%2C-zsh%2C-sh%2C-fish">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Bash, Zsh, sh, fish">

  Bash, Zsh, sh, fish

  </div>

  </div>

- <div id="powershell">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-PowerShell">

  PowerShell

  </div>

  </div>


``` shiki
APP_ENV=prod op inject -i config.yml.tpl -o config.yml
```


1.  <span data-as="p">Set `APP_ENV` to `prod`:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="powershell">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_3qm59j9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_3sm59j9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_3um59j9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_3659j9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    $Env:APP_ENV = "prod"
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>
2.  <span data-as="p">Inject the secrets:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="powershell">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_3qm99j9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_3sm99j9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_3um99j9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_3699j9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op inject -i config.yml.tpl -o config.yml
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>


## <a href="#optional-use-op-inject-in-production" class="anchor-link" aria-label="Navigate to header: Optional: Use op inject in production"></a><span id="_R_1n9deehkd74t9_" class="cursor-pointer">Optional: Use `op inject` in production</span>


1.  <a href="/cli/install-server/" class="link">Install 1Password CLI 2 in your production environment.</a>
2.  <a href="/connect/" class="link">Set up a Secrets Automation workflow</a>.
3.  <a href="/connect/get-started/#step-2-deploy-1password-connect-server" class="link">Deploy 1Password Connect Server</a> and make it accessible to your production environment.


- `op run`
- `op inject`
- `op read`
- `op item get`

## <a href="#learn-more" class="anchor-link" aria-label="Navigate to header: Learn more"></a><span id="_R_279deehkd74t9_" class="cursor-pointer">Learn more</span>

- <a href="/cli/secrets-environment-variables/" class="link">Load secrets into the environment</a>
- <a href="/cli/secret-reference-syntax/" class="link">Secret reference syntax</a>
- <a href="/cli/secrets-template-syntax/" class="link">Template syntax</a>
- <a href="/get-started/secure-developer-secrets" class="link">Workflow: Secure local development</a>


Was this page helpful?


