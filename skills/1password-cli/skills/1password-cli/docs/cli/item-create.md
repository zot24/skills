> Source: https://www.1password.dev/cli/item-create/



> ## Documentation Index
>
> Fetch the complete documentation index at: <a href="/llms.txt" tabindex="-1">/llms.txt</a>
>
> Use this file to discover all available pages before exploring further.


<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


<a href="/" class="select-none" style="-webkit-touch-callout:none"><span class="sr-only">1Password Developer home page</span><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=29d1c9358888a723dddd8a89a3b6f71d" class="nav-logo w-auto h-7 relative object-contain shrink-0 block dark:hidden" alt="light logo" /><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-light.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=119233092720e49043d6f42ff71125f1" class="nav-logo w-auto h-7 relative object-contain shrink-0 hidden dark:block" alt="dark logo" /></a>


Search...


Manage items


Create items


<a href="/get-started" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Get Started</a>


<a href="/security-for-ai" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Security for AI</a>


<a href="/environments" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Environments</a>


<a href="/ssh" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SSH &amp; Git</a>


<a href="/cli" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200 [text-shadow:-0.2px_0_0_currentColor,0.2px_0_0_currentColor]" data-active="true" aria-current="location">CLI</a>


<a href="/sdks" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SDKs</a>


More Tools


Manage items


# Create items


## 


<a href="#requirements" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">Sign up for 1Password</a>
- <a href="/cli/get-started#step-1-install-1password-cli" class="link">Install 1Password CLI</a>


``` shiki
op vault create Tutorial
```


## 


<a href="#create-an-item" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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

## 


<a href="#create-a-customized-item" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="#with-assignment-statements" class="link">With assignment statements</a>
- <a href="#with-an-item-json-template" class="link">With an item JSON template</a>

### 


<a href="#with-assignment-statements" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


### 


<a href="#with-an-item-json-template" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  <span data-as="p">Get the template for a Login item and save it in your current directory:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_1lb156llktbsnlhjiuasnpfiutb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_1mb156llktbsnlhjiuasnpfiutb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_1nb156llktbsnlhjiuasnpfiutb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" role="presentation" data-id="base-ui-_R_1j156llktbsnlhjiuasnpfiutb_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op item template get --out-file=login.json "Login"
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>
2.  <span data-as="p">Edit <a href="/cli/item-template-json" class="link">the template file</a> to add your information.</span>
3.  <span data-as="p">Create the item using the `--template` flag to specify the path to the template file:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_3al356llktbsnlhjiuasnpfiutb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_3cl356llktbsnlhjiuasnpfiutb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_3el356llktbsnlhjiuasnpfiutb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" role="presentation" data-id="base-ui-_R_35356llktbsnlhjiuasnpfiutb_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op item create --template=login.json
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    <span data-as="p">This example template file creates a Login item named `Hulu` in a vault <a href="/cli/reference#unique-identifiers-ids" class="link">specified by its ID</a>. It specifies values for built-in `username`, `password`, and `notesPlain` fields. It also adds a custom `date` field.</span>
    <div id="example-login-template" class="absolute top-[-10.5rem]">

    </div>

    <div class="mr-0.5" component-part="accordion-caret-right">

    </div>

    <div class="leading-tight text-left w-full" contenteditable="false" component-part="accordion-title-container">

    Example Login template

    </div>

    <div id="example-login-template-accordion-children" class="mt-2 mb-4 mx-6 prose prose-gray dark:prose-invert overflow-x-auto cursor-default" role="region" aria-labelledby="example-login-template-accordion-title" component-part="accordion-content">

    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 bg-gray-50 dark:bg-white/5 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark p-0.5" numberoflines="39" language="json">

    <div class="flex text-gray-400 text-xs rounded-t-[14px] leading-6 font-medium pl-4 pr-2.5 py-1" component-part="code-block-header">

    <div class="grow-0 flex items-center gap-1.5 text-gray-700 dark:text-gray-300 min-w-0" component-part="code-block-header-filename">

    <span class="truncate min-w-0" title="login.json">login.json</span>

    </div>

    <div class="flex-1 flex items-center justify-end gap-1.5 print:hidden">

    <div id="base-ui-_R_3b5m356llktbsnlhjiuasnpfiutb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_3d5m356llktbsnlhjiuasnpfiutb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_3f5m356llktbsnlhjiuasnpfiutb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-xt bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" role="presentation" data-id="base-ui-_R_pm356llktbsnlhjiuasnpfiutb_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div class="print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    </div>
4.  <span data-as="p">Delete the edited template file from your computer.</span>


``` shiki
op item template get Login | op item create --vault Tutorial -
```


## 


<a href="#create-an-item-from-an-existing-item" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op item get "HBO Max" --format json | op item create --vault Tutorial --title "Wendy's HBO Max" - 'username=wendy.appleseed@acme.org' 'password=Dp2WxXfwN7VFJojENfEHLEBJmAGAxup@'
```


## 


<a href="#add-a-one-time-password-to-an-item" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


## 


<a href="#attach-a-file-to-an-item" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


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


## 


<a href="#next-steps" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op vault delete "Tutorial"
```


## 


<a href="#learn-more" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/cli/reference/management-commands/item#item-create" class="link"><code>op item create</code> reference documentation</a>
- <a href="/cli/item-fields" class="link">Built-in and custom item fields</a>
- <a href="/cli/item-template-json" class="link">Item JSON template</a>
- <a href="/get-started/build-integrations" class="link">Workflow: Build integrations with 1Password</a>


Related topics

<a href="/cli/reference/management-commands/item" class="flex items-center gap-2 rounded-lg py-1.5 text-gray-950 dark:text-gray-50 hover:text-primary dark:hover:text-primary-light"><span class="text-sm tracking-[-0.1px] line-clamp-1">item</span></a><a href="/sdks/manage-items" class="flex items-center gap-2 rounded-lg py-1.5 text-gray-950 dark:text-gray-50 hover:text-primary dark:hover:text-primary-light"><span class="text-sm tracking-[-0.1px] line-clamp-1">Manage items using 1Password SDKs</span></a><a href="/connect/api-reference/create-vault-item" class="flex items-center gap-2 rounded-lg py-1.5 text-gray-950 dark:text-gray-50 hover:text-primary dark:hover:text-primary-light"><span class="text-sm tracking-[-0.1px] line-clamp-1">Create a new Item</span></a>


Was this page helpful?


Responses are generated using AI and may contain mistakes.


<a href="mailto:support@1password.com" class="group flex justify-between items-center gap-1 mt-2 py-1 transition-colors duration-200" data-component-part="contact-support-button"><span data-component-part="contact-support-icon"></span></a>

Contact support


