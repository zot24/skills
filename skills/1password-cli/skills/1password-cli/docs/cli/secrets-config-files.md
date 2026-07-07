> Source: https://www.1password.dev/cli/secrets-config-files/



Load secrets


# Load secrets into config files


Copy page


Copy page


## 


<a href="#requirements" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">Sign up for 1Password.</a>
2.  <a href="/cli/get-started#step-1-install-1password-cli" class="link">Install 1Password CLI.</a>
3.  Store the secrets you want to provision in your 1Password account.

## 


<a href="#step-1-get-secret-references" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/cli/secret-reference-syntax#with-the-1password-desktop-app" class="link">With the 1Password desktop app</a>: Copy secret references from the app.
- <a href="/vscode#get-values" class="link">With 1Password for VSCode</a>: Insert secret references from 1Password as you edit code.
- <a href="/cli/secret-reference-syntax#with-1password-cli" class="link">With 1Password CLI</a>: Get secret references for one or multiple fields with `op item get`.
- Use the <a href="/cli/secret-reference-syntax#syntax-rules" class="link">secret reference syntax rules</a> to write secret references manually.

## 


<a href="#step-2-use-secret-references-in-your-config-file" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


## 


<a href="#step-2-inject-the-secrets" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op inject -i config.yml.tpl -o config.yml
```


## 


<a href="#step-3-differentiate-between-environments" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
database:
    host: http://localhost
    port: 5432
    username: op://$APP_ENV/mysql/username
    password: op://$APP_ENV/mysql/password
```


- <div id="bash%2C-zsh%2C-sh%2C-fish">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" data-component-part="tab-button" data-active="true" data-testid="tab-Bash, Zsh, sh, fish">

  Bash, Zsh, sh, fish

  </div>

  </div>

- <div id="powershell">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-PowerShell">

  PowerShell

  </div>

  </div>


``` shiki
APP_ENV=prod op inject -i config.yml.tpl -o config.yml
```


1.  <span data-as="p">Set `APP_ENV` to `prod`:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" data-numberoflines="1" data-language="powershell">

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
    $Env:APP_ENV = "prod"
    ```

    </div>

    </div>

    <div class="print:hidden" data-fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>
2.  <span data-as="p">Inject the secrets:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" data-numberoflines="1" data-language="powershell">

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
    op inject -i config.yml.tpl -o config.yml
    ```

    </div>

    </div>

    <div class="print:hidden" data-fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>


## 


<a href="#optional-use-op-inject-in-production" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  <a href="/cli/install-server" class="link">Install 1Password CLI 2 in your production environment.</a>
2.  <a href="/connect" class="link">Set up a Secrets Automation workflow</a>.
3.  <a href="/connect/get-started#step-2-deploy-1password-connect-server" class="link">Deploy 1Password Connect Server</a> and make it accessible to your production environment.


- `op run`
- `op inject`
- `op read`
- `op item get`

## 


<a href="#learn-more" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/cli/secrets-environment-variables" class="link">Load secrets into the environment</a>
- <a href="/cli/secret-reference-syntax" class="link">Secret reference syntax</a>
- <a href="/cli/secrets-template-syntax" class="link">Template syntax</a>
- <a href="/get-started/secure-developer-secrets" class="link">Workflow: Secure your developer secrets</a>
- <a href="/get-started/developer-quickstart" class="link">Developer quickstart</a>


Was this page helpful?


<a href="/cli/secrets-environment-variables" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Load secrets into the environment</span></a><a href="/cli/secrets-scripts" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Load secrets into scripts</span></a>


