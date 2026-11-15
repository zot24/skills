> Source: https://www.1password.dev/cli/secrets-environment-variables/



Load secrets


# Load secrets into the environment


Load secrets from 1Password into environment variables with op run, so your apps and scripts get the values they need without plaintext .env files.


## <a href="#choose-your-configuration" class="anchor-link" aria-label="Navigate to header: Choose your configuration"></a><span id="_R_79deehkd74t9_" class="cursor-pointer">Choose your configuration</span>


- <span data-as="p">**<a href="/environments" class="link">1Password Environments</a>** allow you to create Environments in 1Password that contain all your secrets for a specific workflow. You can share Environments with your team and create separate Environments for each project, application, or development context (like staging or production).</span>
- <span data-as="p">**<a href="/cli/secret-references" class="link">Secret references</a>** are URIs that point to where a secret is stored in your 1Password account. A secret reference uses the names or unique identifiers of the vault, item, section, and field where the secret is stored in 1Password. You can set environment variables to secret references on the command line or use secret references in your `.env` files. Secret references require more manual setup than 1Password Environments to switch between different sets of variables for different contexts, or create shared team workflows.</span>
- <span data-as="p">**Hybrid approach**: You can use `op run` to load secrets from a 1Password Environment alongside secret references from `.env` files or exported environment variables.</span>


## <a href="#requirements" class="anchor-link" aria-label="Navigate to header: Requirements"></a><span id="_R_h9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Requirements</span>


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


## <a href="#step-1-store-your-project-secrets-in-1password" class="anchor-link" aria-label="Navigate to header: Step 1: Store your project secrets in 1Password"></a><span id="_R_l9deehkd74t9_" class="cursor-pointer">Step 1: Store your project secrets in 1Password</span>


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


## <a href="#step-2-pass-the-secrets-to-the-application" class="anchor-link" aria-label="Navigate to header: Step 2: Pass the secrets to the application"></a><span id="_R_p9deehkd74t9_" class="cursor-pointer">Step 2: Pass the secrets to the application</span>


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

    <div id="base-ui-_R_fakqcr9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_fikqcr9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_fqkqcr9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_ckqcr9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_faoqcr9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_fioqcr9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_fqoqcr9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_coqcr9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

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


### <a href="#step-1-map-secret-references-to-environment-variables" class="anchor-link" aria-label="Navigate to header: Step 1: Map secret references to environment variables"></a><span id="_R_1kr9deehkd74t9_" class="cursor-pointer">Step 1: Map secret references to environment variables</span>


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

  <div id="base-ui-_R_ulg9ahjkr9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

  </div>

  <div id="base-ui-_R_v5g9ahjkr9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

  <span class="sr-only" role="status"></span>

  </div>

  <div id="base-ui-_R_vlg9ahjkr9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

  </div>

  </div>

  <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

  <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_pg9ahjkr9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

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

  <div id="base-ui-_R_ulh1ahjkr9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

  </div>

  <div id="base-ui-_R_v5h1ahjkr9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

  <span class="sr-only" role="status"></span>

  </div>

  <div id="base-ui-_R_vlh1ahjkr9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

  </div>

  </div>

  <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

  <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_ph1ahjkr9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

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


### <a href="#optional-differentiate-between-environments" class="anchor-link" aria-label="Navigate to header: Optional: Differentiate between environments"></a><span id="_R_ljkr9deehkd74t9_" class="cursor-pointer">Optional: Differentiate between environments</span>


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


### <a href="#step-2-pass-the-resolved-secret-references-to-the-application" class="anchor-link" aria-label="Navigate to header: Step 2: Pass the resolved secret references to the application"></a><span id="_R_4kr9deehkd74t9_" class="cursor-pointer">Step 2: Pass the resolved secret references to the application</span>


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

    <div id="base-ui-_R_ulhallkr9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_v5hallkr9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_vlhallkr9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_phallkr9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_uliallkr9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_v5iallkr9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_vliallkr9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_piallkr9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

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


## <a href="#next-step-run-in-production" class="anchor-link" aria-label="Navigate to header: Next step: Run in production"></a><span id="_R_v9deehkd74t9_" class="cursor-pointer">Next step: Run in production</span>


- **<a href="/service-accounts/use-with-1password-cli" class="link">1Password Service Account</a>**: Automate access with a service account token. Service accounts support both secret references and 1Password Environments.
- **<a href="/connect/cli/" class="link">1Password Connect Server</a>**: Best for self-hosting within your own infrastructure. Connect only supports secret references and does not currently support 1Password Environments.

## <a href="#learn-more" class="anchor-link" aria-label="Navigate to header: Learn more"></a><span id="_R_159deehkd74t9_" class="cursor-pointer">Learn more</span>

- <a href="/service-accounts/use-with-1password-cli" class="link">Use 1Password Service Accounts with 1Password CLI</a>
- <a href="/connect/cli#continuous-integration-ci-environments" class="link">Use 1Password Connect Server with 1Password CLI</a>
- <a href="/cli/secrets-config-files/" class="link">Load secrets into config files</a>
- <a href="/cli/secret-reference-syntax/" class="link">Secret reference syntax</a>
- <a href="/cli/secrets-template-syntax/" class="link">Template syntax</a>
- <a href="/get-started/secure-deployment" class="link">Workflow: Secure your deployments</a>


Was this page helpful?


