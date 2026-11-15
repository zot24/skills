> Source: https://www.1password.dev/cli/item-create/



Manage items


# Create items


## <a href="#requirements" class="anchor-link" aria-label="Navigate to header: Requirements"></a><span id="_R_59deehkd74t9_" class="min-w-0 break-words cursor-pointer">Requirements</span>


- <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">Sign up for 1Password</a>
- <a href="/cli/get-started/#step-1-install-1password-cli" class="link">Install 1Password CLI</a>


``` shiki
op vault create Tutorial
```


## <a href="#create-an-item" class="anchor-link" aria-label="Navigate to header: Create an item"></a><span id="_R_d9deehkd74t9_" class="cursor-pointer">Create an item</span>


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
op item create \
    --category login \
    --title "Netflix" \
    --vault Tutorial \
    --url 'https://www.netflix.com/login' \
    --generate-password='letters,digits,symbols,32' \
    --tags tutorial,entertainment
```


``` shiki
op item create `
    --category login `
    --title "Netflix" `
    --vault Tutorial `
    --url 'https://www.netflix.com/login' `
    --generate-password='letters,digits,symbols,32' `
    --tags tutorial,entertainment
```


`--category` Sets the [item category](https://support.1password.com/item-categories/), in this case a Login item. Use `op item template list` to get a list of available categories. The category value is case-insensitive and ignores whitespace characters. For example, the `Social Security Number` category can also be specified as `socialsecuritynumber`.

`--title` Gives the item a name so that you can easily identify it. If unspecified, 1Password CLI selects a default name. For example, `Untitled Login item`.

`--vault` Specifies which [vault](https://support.1password.com/create-share-vaults/) the item should be created in. If unspecified, the item will be created in your built-in [Personal](https://support.1password.com/1password-glossary/#personal-vault), [Private](https://support.1password.com/1password-glossary/#private-vault), or [Employee](https://support.1password.com/1password-glossary/#employee-vault) vault. The name of this vault varies depending on your account type.

`--url` Sets the website where 1Password suggests and fills a Login, Password, or API Credential item.

`--generate-password` Generates a strong password for Login and Password category items. You can specify a password recipe, as shown in the example. If left unspecified, a default recipe will be used to generate a 32-character password consisting of letters, digits, and symbols.

`--tags` Adds [tags](https://support.1password.com/favorites-tags/) to the item using a comma-separated list.

## <a href="#create-a-customized-item" class="anchor-link" aria-label="Navigate to header: Create a customized item"></a><span id="_R_139deehkd74t9_" class="cursor-pointer">Create a customized item</span>


- <a href="#with-assignment-statements" class="link">With assignment statements</a>
- <a href="#with-an-item-json-template" class="link">With an item JSON template</a>

### <a href="#with-assignment-statements" class="anchor-link" aria-label="Navigate to header: With assignment statements"></a><span id="_R_1d9deehkd74t9_" class="cursor-pointer">With assignment statements</span>


``` shiki
[<section>.]<field>[[<fieldType>]]=<value>
```


- `section` (Optional) The name of the section where you want to create the field.
- `field` The name of the field you want to create.
- `fieldType` The type of field you want to create. If unspecified, `fieldType` will default to `password`.
- `value` The information you want to save in the field.


``` shiki
'username=john.doe@acme.org'
```


``` shiki
'Subscription Info.Renewal Date[date]=2022-12-31'
```


- <div id="bash%2C-zsh%2C-sh%2C-fish-2">

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
op item create \
    --category login \
    --title "HBO Max" \
    --vault Tutorial \
    --url 'https://www.hbomax.com' \
    --generate-password='letters,digits,symbols,32' \
    --tags tutorial,entertainment \
    'username=john.doe@acme.org' \
    'Subscription Info.Renewal Date[date]=2022-12-31'
```


``` shiki
op item create `
    --category login `
    --title "HBO Max" `
    --vault Tutorial `
    --url 'https://www.hbomax.com' `
    --generate-password='letters,digits,symbols,32' `
    --tags tutorial,entertainment `
    'username=john.doe@acme.org' `
    'Subscription Info.Renewal Date[date]=2022-12-31'
```


### <a href="#with-an-item-json-template" class="anchor-link" aria-label="Navigate to header: With an item JSON template"></a><span id="_R_2b9deehkd74t9_" class="cursor-pointer">With an item JSON template</span>


1.  <span data-as="p">Get the template for a Login item and save it in your current directory:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_ulgij9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_v5gij9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_vlgij9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_pgij9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op item template get --out-file=login.json "Login"
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>
2.  <span data-as="p">Edit <a href="/cli/item-template-json/" class="link">the template file</a> to add your information.</span>
3.  <span data-as="p">Create the item using the `--template` flag to specify the path to the template file:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_1tahij9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_1uahij9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_1vahij9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_1ihij9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op item create --template=login.json
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    <span data-as="p">This example template file creates a Login item named `Hulu` in a vault <a href="/cli/reference/#unique-identifiers-ids" class="link">specified by its ID</a>. It specifies values for built-in `username`, `password`, and `notesPlain` fields. It also adds a custom `date` field.</span>
    <div id="example-login-template" class="absolute top-[-8rem] [[data-banner-state=visible]_&]:top-[-10.5rem]">

    </div>

    <div class="flex size-4 shrink-0 items-center justify-center" component-part="accordion-caret-right">

    </div>

    <div class="leading-tight text-left w-full min-w-0" contenteditable="false" component-part="accordion-title-container">

    Example Login template

    </div>

    <div id="example-login-template-accordion-children" class="px-5 pb-3.5 prose prose-gray dark:prose-invert overflow-x-auto cursor-default" role="region" aria-labelledby="example-login-template-accordion-title" component-part="accordion-content">

    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 bg-gray-50 dark:bg-white/5 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark p-0.5" has-header="" numberoflines="39" language="json">

    <div class="flex text-gray-400 text-xs rounded-t-[14px] leading-6 font-medium pl-4 pr-2.5 py-1" component-part="code-block-header">

    <div class="grow-0 flex items-center gap-1.5 text-gray-700 dark:text-gray-300 min-w-0" component-part="code-block-header-filename">

    <span class="truncate min-w-0" title="login.json">login.json</span>

    </div>

    <div class="flex-1 flex items-center justify-end gap-1.5 print:hidden">

    <div id="base-ui-_R_1tir1ij9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_1uir1ij9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_1vir1ij9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-xt bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_cr1ij9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    {
      "title": "Hulu",
      "vault": {
        "id": "sor33rgjjcg2xykftymcmqm5am"
      },
      "category": "LOGIN",
      "fields": [
        {
          "id": "username",
          "type": "STRING",
          "purpose": "USERNAME",
          "label": "username",
          "value": "wendy.appleseed@gmail.com"
        },
        {
          "id": "password",
          "type": "CONCEALED",
          "purpose": "PASSWORD",
          "label": "password",
          "password_details": {
            "strength": ""
          },
          "value": "Dp2WxXfwN7VFJojENfEHLEBJmAGAxup@"
        },
        {
          "id": "notesPlain",
          "type": "STRING",
          "purpose": "NOTES",
          "label": "notesPlain",
          "value": "This is Wendy's Hulu account."
        },
        {
          "id": "date",
          "type": "date",
          "label": "Subscription renewal date",
          "value": "2023-04-05"
        }
      ]
    }
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    </div>
4.  <span data-as="p">Delete the edited template file from your computer.</span>


``` shiki
op item template get Login | op item create --vault Tutorial -
```


## <a href="#create-an-item-from-an-existing-item" class="anchor-link" aria-label="Navigate to header: Create an item from an existing item"></a><span id="_R_2p9deehkd74t9_" class="cursor-pointer">Create an item from an existing item</span>


``` shiki
op item get "HBO Max" --format json | op item create --vault Tutorial --title "Wendy's HBO Max" - 'username=wendy.appleseed@acme.org' 'password=Dp2WxXfwN7VFJojENfEHLEBJmAGAxup@'
```


## <a href="#add-a-one-time-password-to-an-item" class="anchor-link" aria-label="Navigate to header: Add a one-time password to an item"></a><span id="_R_319deehkd74t9_" class="cursor-pointer">Add a one-time password to an item</span>


- <div id="bash%2C-zsh%2C-sh%2C-fish-3">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Bash, Zsh, sh, fish">

  Bash, Zsh, sh, fish

  </div>

  </div>

- <div id="powershell-3">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-PowerShell">

  PowerShell

  </div>

  </div>


``` shiki
op item create \
    --category login \
    --title='My OTP Example' \
    --vault Tutorial \
    --url 'https://www.acme.com/login' \
    --generate-password='letters,digits,symbols,32' \
    --tags tutorial,entertainment \
    'Test Section 1.Test Field3[otp]=otpauth://totp/<website>:<user>?secret=<secret>&issuer=<issuer>'
```


``` shiki
op item create `
    --category login `
    --title='My OTP Example' `
    --vault Tutorial `
    --url 'https://www.acme.com/login' `
    --generate-password='letters,digits,symbols,32' `
    --tags tutorial,entertainment `
    'Test Section 1.Test Field3[otp]=otpauth://totp/<website>:<user>?secret=<secret>&issuer=<issuer>'
```


## <a href="#attach-a-file-to-an-item" class="anchor-link" aria-label="Navigate to header: Attach a file to an item"></a><span id="_R_379deehkd74t9_" class="cursor-pointer">Attach a file to an item</span>


``` shiki
JanuaryReceipt\.png[file]=/path/to/your/receipt.png
```


``` shiki
[file]=/path/to/your/file
```


- <div id="bash%2C-zsh%2C-sh%2C-fish-4">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Bash, Zsh, sh, fish">

  Bash, Zsh, sh, fish

  </div>

  </div>

- <div id="powershell-4">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-PowerShell">

  PowerShell

  </div>

  </div>


``` shiki
op item create \
    --category login \
    --title "PlayStation Store" \
    --vault Tutorial \
    --url 'https://store.playstation.com/' \
    --generate-password='letters,digits,symbols,32' \
    --tags tutorial,entertainment \
    'JanuaryReceipt\.png[file]=/wendyappleseed/documents/receipt.png'
```


``` shiki
op item create `
    --category login `
    --title "PlayStation Store" `
    --vault Tutorial `
    --url 'https://store.playstation.com/' `
    --generate-password='letters,digits,symbols,32' `
    --tags tutorial,entertainment `
    'JanuaryReceipt\.png[file]=/wendyappleseed/documents/receipt.png'
```


## <a href="#next-steps" class="anchor-link" aria-label="Navigate to header: Next steps"></a><span id="_R_3n9deehkd74t9_" class="cursor-pointer">Next steps</span>


``` shiki
op vault delete "Tutorial"
```


## <a href="#learn-more" class="anchor-link" aria-label="Navigate to header: Learn more"></a><span id="_R_3v9deehkd74t9_" class="cursor-pointer">Learn more</span>

- <a href="/cli/reference/management-commands/item#item-create" class="link"><code>op item create</code> reference documentation</a>
- <a href="/cli/item-fields" class="link">Built-in and custom item fields</a>
- <a href="/cli/item-template-json" class="link">Item JSON template</a>
- <a href="/get-started/build-integrations" class="link">Workflow: Build integrations with 1Password</a>


Was this page helpful?


