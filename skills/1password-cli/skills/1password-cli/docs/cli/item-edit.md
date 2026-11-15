> Source: https://www.1password.dev/cli/item-edit/



Manage items


# Edit items


## <a href="#requirements" class="anchor-link" aria-label="Navigate to header: Requirements"></a><span id="_R_79deehkd74t9_" class="min-w-0 break-words cursor-pointer">Requirements</span>


- <a href="https://1password.com/pricing/password-manager" class="link" target="_blank" rel="noreferrer">Sign up for 1Password</a>
- <a href="/cli/get-started#step-1-install-1password-cli" class="link">Install 1Password CLI</a>


## <a href="#edit-an-item’s-basic-information" class="anchor-link" aria-label="Navigate to header: Edit an item’s basic information"></a><span id="_R_f9deehkd74t9_" class="cursor-pointer">Edit an item’s basic information</span>


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
op item edit "Netflix" \
    --title "Edited Netflix" \
    --vault Private \
    --tags tutorial \
    --url https://www.netflix.com \
    --generate-password='letters,digits,symbols,32'
```


``` shiki
op item edit "Netflix" `
    --title "Edited Netflix" `
    --vault Private `
    --tags tutorial `
    --url https://www.netflix.com `
    --generate-password='letters,digits,symbols,32'
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
op item edit "Edited Netflix" \
    --title "Netflix" \
    --vault Tutorial
```


``` shiki
op item edit "Edited Netflix" `
    --title "Netflix" `
    --vault Tutorial
```


## <a href="#edit-built-in-and-custom-fields" class="anchor-link" aria-label="Navigate to header: Edit built-in and custom fields"></a><span id="_R_t9deehkd74t9_" class="cursor-pointer">Edit built-in and custom fields</span>


``` shiki
[<section>.]<field>[[<fieldType>]]=<value>
```


- `section` (Optional) The name of the section where the field is saved.
- `field` The name of the field.
- `fieldType` The type of field. If unspecified, the fieldType stays the same.
- `value` The information you want to save in the field. If unspecified, the value stays the same.


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
op item edit "HBO Max" \
    'Renewal Date=2023-5-15'
```


``` shiki
op item edit "HBO Max" `
    'Renewal Date=2023-5-15'
```


### <a href="#delete-a-custom-field" class="anchor-link" aria-label="Navigate to header: Delete a custom field"></a><span id="_R_1b9deehkd74t9_" class="cursor-pointer">Delete a custom field</span>


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
op item edit "HBO Max" \
    'Renewal Date[delete]=2023-5-15'
```


``` shiki
op item edit "HBO Max" `
    'Renewal Date[delete]=2023-5-15'
```


## <a href="#edit-an-item-using-a-json-template" class="anchor-link" aria-label="Navigate to header: Edit an item using a JSON template"></a><span id="_R_1j9deehkd74t9_" class="cursor-pointer">Edit an item using a JSON template</span>


1.  <span data-as="p">Get the JSON output for the item you want to edit and save it to a file.</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_fao9p9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_fio9p9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_fqo9p9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_co9p9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op item get <item> --format json > newItem.json
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    <span class="small">If you prefer to start over, you can get a blank template for the item’s category with <a href="/cli/reference/management-commands/item#item-template-get" class="link"><code>op item template get</code></a>.</span>
2.  <span data-as="p">Edit the file.</span>
3.  <span data-as="p">Use the `--template` flag to specify the path to the edited file and apply the changes to the item:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_faopp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_fiopp9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_fqopp9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_copp9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op item edit <item> --template=newItem.json
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>
4.  <span data-as="p">Delete the file.</span>


``` shiki
    cat newItem.json | op item edit <item>
```


## <a href="#next-steps" class="anchor-link" aria-label="Navigate to header: Next steps"></a><span id="_R_219deehkd74t9_" class="cursor-pointer">Next steps</span>


``` shiki
op vault delete "Tutorial"
```


## <a href="#learn-more" class="anchor-link" aria-label="Navigate to header: Learn more"></a><span id="_R_279deehkd74t9_" class="cursor-pointer">Learn more</span>

- <a href="/cli/reference/management-commands/item" class="link"><code>op item</code> reference documentation</a>
- <a href="/cli/item-fields" class="link">Built-in and custom item fields</a>
- <a href="/cli/item-template-json" class="link">Item JSON template</a>
- <a href="/get-started/build-integrations" class="link">Workflow: Build integrations with 1Password</a>


Was this page helpful?


