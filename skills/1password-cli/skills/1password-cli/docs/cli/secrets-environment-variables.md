> Source: https://www.1password.dev/cli/secrets-environment-variables/



Load secrets


# Load secrets into the environment


Copy page


Copy page


## 


<a href="#choose-your-configuration" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <span data-as="p">**<a href="/environments" class="link">1Password Environments (beta)</a>** allow you to create Environments in 1Password that contain all your environment variables for a specific workflow. You can share Environments with your team and create separate Environments for each project, application, or development context (like staging or production).</span>
- <span data-as="p">**<a href="/cli/secret-references" class="link">Secret references</a>** are URIs that point to where a secret is stored in your 1Password account. A secret reference uses the names or unique identifiers of the vault, item, section, and field where the secret is stored in 1Password. You can set environment variables to secret references on the command line or use secret references in your `.env` files. Secret references require more manual setup than 1Password Environments to switch between different sets of environment variables for different contexts, or create shared team workflows.</span>
- <span data-as="p">**Hybrid approach**: You can use `op run` to load variables from a 1Password Environment alongside secret references from `.env` files or exported environment variables.</span>


## 


<a href="#requirements" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <div id="1password-environment-beta">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" data-component-part="tab-button" data-active="true" data-testid="tab-1Password Environment (beta)">

  1Password Environment (beta)

  </div>

  </div>

- <div id="secret-references">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-Secret references">

  Secret references

  </div>

  </div>


1.  <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">Sign up for 1Password.</a>
2.  <a href="https://app-updates.agilebits.com/product_history/CLI2#beta" class="link" target="_blank" rel="noreferrer">Install the latest beta build of 1Password CLI</a>, version `2.33.0-beta.02` or later.


1.  <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">Sign up for 1Password.</a>
2.  <a href="/cli/get-started#step-1-install-1password-cli" class="link">Install 1Password CLI.</a>


## 


<a href="#step-1-store-your-project-secrets-in-1password" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <div id="1password-environment-beta-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" data-component-part="tab-button" data-active="true" data-testid="tab-1Password Environment (beta)">

  1Password Environment (beta)

  </div>

  </div>

- <div id="secret-references-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-Secret references">

  Secret references

  </div>

  </div>


- <a href="/cli/secret-reference-syntax#with-the-1password-desktop-app" class="link">With the 1Password desktop app</a>: Copy secret references from the app.
- <a href="/vscode#get-values" class="link">With 1Password for VSCode</a>: Insert secret references from 1Password as you edit code.
- <a href="/cli/secret-reference-syntax#with-1password-cli" class="link">With 1Password CLI</a>: Get secret references for one or multiple fields with `op item get`.
- Use the <a href="/cli/secret-reference-syntax#syntax-rules" class="link">secret reference syntax rules</a> to write secret references manually.


## 


<a href="#step-2-pass-the-secrets-to-the-application" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <div id="1password-environment-beta-3">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" data-component-part="tab-button" data-active="true" data-testid="tab-1Password Environment (beta)">

  1Password Environment (beta)

  </div>

  </div>

- <div id="secret-references-3">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-Secret references">

  Secret references

  </div>

  </div>


1.  <span data-as="p">Open the 1Password app and navigate to **Developer** \> **Environments**.</span>
2.  <span data-as="p">Select the Environment where your project secrets are stored, then select **Manage environment** \> **Copy environment ID**.</span>
3.  <span data-as="p">Use `op run --` with the command for starting the application or script. 1Password will run the provided command in a subprocess with the secrets made available as environment variables for the duration of the process.</span>
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
    op run --environment <environmentID> -- <command>
    ```

    </div>

    </div>

    <div class="print:hidden" data-fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    <span data-as="p">For example:</span>
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
    op run --environment blgexucrwfr2dtsxe2q4uu7dp4 -- ./my-script.sh
    ```

    </div>

    </div>

    <div class="print:hidden" data-fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>


### 


<a href="#step-1-map-secret-references-to-environment-variables" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <div id="environment-file">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" data-component-part="tab-button" data-active="true" data-testid="tab-Environment file">

  Environment file

  </div>

  </div>

- <div id="command-line">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-Command line">

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
  <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" data-numberoflines="3" data-language="text">

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
  MY_VAR = "this is on the first line
  and this is on the second line"
  ```

  </div>

  </div>

  <div class="print:hidden" data-fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

  </div>

  </div>
- <span data-as="p">Empty lines are skipped.</span>
- <span data-as="p">Lines beginning with `#` are treated as comments. Comments can also be placed inline after `KEY=VALUE` statements.</span>
- <span data-as="p">Empty values become empty strings. For example, `EMPTY=` will set the environment variable `EMPTY` to the empty string.</span>
- <span data-as="p">If a value is surrounded by single or double quotes, these quotes do not end up in the evaluated value. So `KEY="VALUE"` and `KEY='VALUE'` both evaluate to `KEY` and `VALUE`.</span>
- <span data-as="p">Occurrences of `$VAR_NAME` or `${VAR_NAME}` are replaced with their respective value from the environment.</span>
- <span data-as="p">A variable defined in a .env file can be referred to later in the same file:</span>
  <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" data-numberoflines="3" data-language="text">

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
  SOME_VAR = value
  OTHER_VAR = ${SOME_VAR}
  ```

  </div>

  </div>

  <div class="print:hidden" data-fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

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

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" data-component-part="tab-button" data-active="true" data-testid="tab-Environment file">

  Environment file

  </div>

  </div>

- <div id="command-line-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-Command line">

  Command line

  </div>

  </div>


``` shiki
op run --env-file="./prod.env" -- aws
```


- <div id="bash%2C-zsh%2C-sh%2C-fish">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" data-component-part="tab-button" data-active="true" data-testid="tab-Bash, Zsh, sh, fish">

  Bash, Zsh, sh, fish

  </div>

  </div>

- <div id="powershell-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-PowerShell">

  PowerShell

  </div>

  </div>


``` shiki
APP_ENV=dev op run --env-file="./app.env" -- myapp deploy
```


1.  <span data-as="p">Set the `$APP_ENV` variable:</span>
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
    $ENV:APP_ENV = "dev"
    ```

    </div>

    </div>

    <div class="print:hidden" data-fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>
2.  <span data-as="p">Run `op run` with the environment file:</span>
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
    op run --env-file="./app.env" -- myapp deploy
    ```

    </div>

    </div>

    <div class="print:hidden" data-fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

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
- **<a href="/connect/cli" class="link">1Password Connect Server</a>**: Best for self-hosting within your own infrastructure. Connect only supports secret references and does not currently support 1Password Environments.

## 


<a href="#learn-more" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/service-accounts/use-with-1password-cli" class="link">Use 1Password Service Accounts with 1Password CLI</a>
- <a href="/connect/cli#continuous-integration-ci-environments" class="link">Use 1Password Connect Server with 1Password CLI</a>
- <a href="/cli/secrets-config-files" class="link">Load secrets into config files</a>
- <a href="/cli/secret-reference-syntax" class="link">Secret reference syntax</a>
- <a href="/cli/secrets-template-syntax" class="link">Template syntax</a>
- <a href="/get-started/secure-deployment" class="link">Workflow: Secure your deployments</a>


Was this page helpful?


<a href="/cli/get-started" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Get started</span></a><a href="/cli/secrets-config-files" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Inject secrets into config files</span></a>


