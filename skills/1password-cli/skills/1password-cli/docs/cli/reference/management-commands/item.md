> Source: https://www.1password.dev/cli/reference/management-commands/item/


> ## Documentation Index
>
> Fetch the complete documentation index at: <a href="/llms.txt" tabindex="-1">/llms.txt</a>
>
> Use this file to discover all available pages before exploring further.


<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


Responses are generated using AI and may contain mistakes.


<a href="mailto:support@1password.com" class="group flex justify-between items-center gap-1 mt-2 py-1 transition-colors duration-200" data-component-part="contact-support-button"><span data-component-part="contact-support-icon"></span></a>

Contact support


<a href="/" class="select-none" style="-webkit-touch-callout:none"><span class="sr-only">1Password Developer home page</span><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=29d1c9358888a723dddd8a89a3b6f71d" class="nav-logo w-auto h-7 relative object-contain shrink-0 block dark:hidden" alt="light logo" /><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-light.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=119233092720e49043d6f42ff71125f1" class="nav-logo w-auto h-7 relative object-contain shrink-0 hidden dark:block" alt="dark logo" /></a>


Search...


Management commands


item


<a href="/get-started" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Get Started</a>


<a href="/tutorials" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Tutorials</a>


<a href="/security-for-ai" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Security for AI</a>


<a href="/environments" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Environments</a>


<a href="/ssh" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SSH &amp; Git</a>


<a href="/cli" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200 [text-shadow:-0.2px_0_0_currentColor,0.2px_0_0_currentColor]" data-active="true" aria-current="location">CLI</a>


<a href="/sdks" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SDKs</a>


More Tools


Management commands


# item


### 


<a href="#subcommands" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="#item-create" class="link">item create</a>: Create an item
- <a href="#item-delete" class="link">item delete</a>: Delete or archive an item
- <a href="#item-edit" class="link">item edit</a>: Edit an item’s details
- <a href="#item-get" class="link">item get</a>: Get an item’s details
- <a href="#item-list" class="link">item list</a>: List items
- <a href="#item-move" class="link">item move</a>: Move an item between vaults
- <a href="#item-share" class="link">item share</a>: Share an item
- <a href="#item-template" class="link">item template</a>: Manage templates

## 


<a href="#item-create" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op item create [ - ] [ <assignment>... ] [flags]
```


### 


<a href="#flags" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--category category            Set the item's category.
--dry-run                      Test the command and output a preview of the resulting item.
--favorite                     Add item to favorites.
--generate-password[=recipe]   Add a randomly-generated password to a Login or Password item.
--reveal                       Don't conceal sensitive fields.
--ssh-generate-key             The type of SSH key to create: Ed25519 or RSA. For RSA,
                               specify 2048, 3072, or 4096 (default) bits. Possible values:
                               ed25519, rsa, rsa2048, rsa3072, rsa4096. (default Ed25519)
--tags tags                    Set the tags to the specified (comma-separated)
                               values.
--template string              Specify the filepath to read an item template from.
--title title                  Set the item's title.
--url URL                      Set the website where 1Password suggests and fills a Login, Password, or API Credential item.
--vault vault                  Save the item in this vault. Default: Private.
```


``` shiki
op item template list
```


#### 


<a href="#generate-a-password" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
   --generate-password='letters,digits,symbols,32'
```


#### 


<a href="#set-additional-fields-with-assignment-statements" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
[<section>.]<field>[[<fieldType>]]=<value>
```


``` shiki
DatabaseCredentials.host[text]=33.166.240.221
```


#### 


<a href="#create-an-item-using-a-json-template" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  <span data-as="p">Save the appropriate item category template to a file:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_1tb11p5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_1ub11p5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_1vb11p5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_1j11p5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op item template get --out-file login.json "Login"
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>
2.  <span data-as="p">Edit the template.</span>
3.  <span data-as="p">Create a new item using the `-—template` flag to specify the path to the edited template:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_1tb31p5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_1ub31p5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_1vb31p5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_1j31p5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

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
4.  <span data-as="p">After 1Password CLI creates the item, delete the edited template.</span> <span data-as="p">You can also create an item from standard input using an item JSON template.</span> <span data-as="p">Pass the `-` character as the first argument, followed by any assignment statements.</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_3qm41p5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_3sm41p5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_3um41p5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_3641p5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op item template get Login | op item create --vault personal -
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>

    <span data-as="p">You can’t use both piping and the `--template` flag in the same command, to avoid collisions.</span>

### 


<a href="#examples" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op item create --category=login --title='My Example Item' --vault='Test' \
    --url https://www.acme.com/login \
    --generate-password=20,letters,digits \
    username=jane@acme.com \
    'Test Section 1.Test Field3[otp]=otpauth://totp/<website>:<user>?secret=<secret>&issuer=<issuer>' \
    'FileName[file]=/path/to/your/file'
```


``` shiki
op item get "My Item" --format json | op item create --vault prod - \
    username="My Username" password="My Password"
```


``` shiki
op item list --vault test-vault --format json --account agilebits | \
op item get --format json --account agilebits - | \
op item create --account work -
```


## 


<a href="#item-delete" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op item delete [{ <itemName> | <itemID> | <shareLink> | - }] [flags]
```


### 


<a href="#flags-2" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--archive        Move the item to the Archive.
--vault string   Look for the item in this vault.
```


#### 


<a href="#specify-items-on-standard-input" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#examples-2" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op item delete "Defunct Login"
```


``` shiki
op item delete "Defunct Login" --archive
```


## 


<a href="#item-edit" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op item edit { <itemName> | <itemID> | <shareLink> } [ <assignment> ... ] [flags]
```


### 


<a href="#flags-3" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--dry-run                      Perform a dry run of the command and output a preview
                               of the resulting item.
--favorite                     Whether this item is a favorite item. Options: true, false.
--generate-password[=recipe]   Give the item a randomly generated password.
--reveal                       Don't conceal sensitive fields.
--tags tags                    Set the tags to the specified (comma-separated)
                               values. An empty value will remove all tags.
--template string              Specify the filepath to read an item template from.
--title title                  Set the item's title.
--url URL                      Set the website where 1Password suggests and fills a Login, Password, or API Credential item.
--vault vault                  Edit the item in this vault.
```


#### 


<a href="#edit-an-item-using-assignment-statements" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
[<section>.]<field>[[<fieldType>]]=<value>
```


#### 


<a href="#edit-an-item-using-a-template" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  <span data-as="p">Get the item you want to edit in JSON format and save it to a file:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="2" language="text">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_1tb14b5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_1ub14b5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_1vb14b5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_1j14b5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op item get oldLogin --format=json > updatedLogin.json
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>
2.  <span data-as="p">Edit the file.</span>
3.  <span data-as="p">Use the `--template` flag to specify the path to the edited file and edit the item:</span> <span data-as="p">op item edit oldLogin —template=updatedLogin.json</span>
4.  <span data-as="p">Delete the file.</span> <span data-as="p">You can also edit an item using piped input:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_1tbk4b5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_1ubk4b5deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_1vbk4b5deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_1jk4b5deehkd74t9_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    cat updatedLogin.json | op item edit oldLogin
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>


### 


<a href="#examples-3" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op item edit 'My Example Item' --generate-password='letters,digits,symbols,32'
```


``` shiki
op item edit 'My Example Item' 'field1=new value'
```


``` shiki
op item edit 'My Example Item' 'field1[password]'
```


``` shiki
op item edit 'My Example Item' 'field1[monthyear]=2021/09'
```


``` shiki
op item edit 'My Example Item' 'section2.field5[phone]=1-234-567-8910'
```


``` shiki
op item edit 'My Example Item' 'section2.field5[delete]'
```


``` shiki
op item edit 'My Example Item' 'username='
```


``` shiki
op item edit oldLogin --vault Private 'username=Lucky' --template=updatedLogin.json
```


## 


<a href="#item-get" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op item get [{ <itemName> | <itemID> | <shareLink> | - }] [flags]
```


### 


<a href="#flags-4" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--fields strings    Return data from specific fields. Use `label=` to get the field by name or `type=` to filter fields by type. Specify multiple in a comma-separated list.
--include-archive   Include items in the Archive. Can also be set using
                    OP_INCLUDE_ARCHIVE environment variable.
--otp               Output the primary one-time password for this item.
--reveal            Don't conceal sensitive fields.
--share-link        Get a shareable link for the item.
--vault vault       Look for the item in this vault.
```


#### 


<a href="#specify-items-on-standard-input-2" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


#### 


<a href="#items-in-the-archive" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#examples-4" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op item list --tags documentation --format json | op item get -
```


``` shiki
op item list --categories Login --vault Staging --format json | op item get - --fields label=username,label=password
```


``` shiki
op item get Netflix --fields label=username,label=password --format json
```


``` shiki
op item get Netflix --fields type=concealed
```


``` shiki
op item get Google --otp
```


``` shiki
op item get kiramv6tpjijkuci7fig4lndta --vault "Ops Secrets" --share-link
```


## 


<a href="#item-list" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op item list [flags]
```


### 


<a href="#flags-5" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--categories categories   Only list items in these categories (comma-separated).
--favorite                Only list favorite items.
--include-archive         Include items in the Archive. Can also be set using
                          OP_INCLUDE_ARCHIVE environment variable.
--long                    Output a more detailed item list.
--tags tags               Only list items with these tags (comma-separated).
--vault vault             Only list items in this vault.
```


- API Credential
- Bank Account
- Credit Card
- Database
- Document
- Driver License
- Email Account
- Identity
- Login
- Membership
- Outdoor License
- Passport
- Password
- Reward Program
- Secure Note
- Server
- Social Security Number
- Software License
- Wireless Router

### 


<a href="#examples-5" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op item list --tags documentation --format=json | op item get -
```


``` shiki
op item list --categories Login --vault Staging --format=json | op item get - --fields username,password
```


## 


<a href="#item-move" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op item move [{ <itemName> | <itemID> | <shareLink> | - }] [flags]
```


### 


<a href="#flags-6" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--current-vault string       Vault where the item is currently saved.
--destination-vault string   The vault you want to move the item to.
--reveal                     Don't conceal sensitive fields.
```


### 


<a href="#examples-6" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op item move "My Example Item" --current-vault Private --destination-vault Shared
```


## 


<a href="#item-share" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op item share { <itemName> | <itemID> } [flags]
```


### 


<a href="#flags-7" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--emails strings        Email addresses to share with.
--expires-in duration   Expire link after the duration specified in (s)econds,
                        (m)inutes, (h)ours, (d)ays, and/or (w)eeks. (default 7d)
--vault string          Look for the item in this vault.
--view-once             Expire link after a single view.
```


## 


<a href="#item-template" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#subcommands-2" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="#item-template-get" class="link">item template get</a>: Get an item template
- <a href="#item-template-list" class="link">item template list</a>: Get a list of templates

## 


<a href="#item-template-get" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op item template get [{ <category> | - }] [flags]
```


### 


<a href="#flags-8" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
    --file-mode filemode  Set filemode for the output file. It is ignored without the --out-file flag. (default 0600)
-f, --force               Do not prompt for confirmation.
-o, --out-file string     Write the template to a file instead of stdout.
```


- API Credential
- Bank Account
- Credit Card
- Database
- Document
- Driver License
- Email Account
- Identity
- Login
- Membership
- Outdoor License
- Passport
- Password
- Reward Program
- Secure Note
- Server
- Social Security Number
- Software License
- Wireless Router

## 


<a href="#item-template-list" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op item template list [flags]
```


Was this page helpful?


{"docsConfig":{"theme":"mint","\$schema":"https://mintlify.com/docs.json","name":"1Password Developer","colors":{"primary":"#104ebb","light":"#b8d7ff","dark":"#303136"},"logo":{"light":"https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max\u0026auto=format\u0026n=lHrfVfSCdefFz8U5\u0026q=85\u0026s=29d1c9358888a723dddd8a89a3b6f71d","dark":"https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-light.svg?fit=max\u0026auto=format\u0026n=lHrfVfSCdefFz8U5\u0026q=85\u0026s=119233092720e49043d6f42ff71125f1"},"favicon":"https://mintcdn.com/ab-634991b8/s4Wjy03jBRs6hcHb/favicon.ico?fit=max\u0026auto=format\u0026n=s4Wjy03jBRs6hcHb\u0026q=85\u0026s=dd03b4bc604b342373aa4d3e21be4310","api":{"playground":{"display":"interactive"},"examples":{"languages":\["curl","node","python","go","dotnet","java","php","powershell","ruby"\]}},"background":{"color":{"light":"#fbf8f4","dark":"#1a1b1e"}},"navbar":{"links":\[{"href":"/community","label":"Community"},{"href":"https://www.1password.academy/path/1password-developer-tools","label":"Academy"}\],"primary":{"type":"button","label":"GitHub","href":"https://github.com/1Password"}},"footer":{"socials":{"github":"https://github.com/1Password","x":"https://twitter.com/1Password","reddit":"https://www.reddit.com/r/1Password","linkedin":"https://www.linkedin.com/company/1password","youtube":"https://www.youtube.com/1PasswordVideos","facebook":"https://www.facebook.com/1Password","instagram":"https://www.instagram.com/1password"},"links":\[{"header":"Legal","items":\[{"label":"Terms of Service","href":"https://1password.com/legal/terms-of-service"},{"label":"Privacy Policy","href":"https://1password.com/legal/privacy"},{"label":"Cookie Policy","href":"https://1password.com/legal/cookies"},{"label":"Accessibility","href":"https://1password.com/legal/accessibility"}\]},{"header":"Community","items":\[{"label":"Developer community","href":"/community"},{"label":"Code of Conduct","href":"/code-of-conduct"},{"label":"Community projects disclaimer","href":"/community/disclaimer"}\]},{"header":"Resources","items":\[{"label":"1Password University","href":"https://www.1password.university/?utm_ref=website-footer"},{"label":"Blog RSS","href":"https://blog.1password.com/index.xml"},{"label":"Newsletter","href":"https://1password.com/developer-newsletter"}\]}\]},"seo":{"metatags":{"canonical":"https://www.1password.dev","google-site-verification":"YserOhXnJUjFfIZ4K3qgxkVSlQZQdXtIbBiKzZ35Nvs"}},"fonts":{"heading":{"family":"Public Sans"},"body":{"family":"Public Sans"}},"banner":{"content":"\*\*New!\*\* Use the \[1Password Credential Broker\](https://www.1password.dev/brokered-access) to give CI/CD and other machine workflows short-lived access to secrets, without managing service account tokens.","dismissible":true,"color":{"light":"#145fe4","dark":"#145fe4"}},"errors":{"404":{"redirect":false,"title":"This page can't be found","description":"Our docs have moved to \[www.1password.dev\](https://www.1password.dev). Try searching for what you need or selecting from the list of tools."}},"contextual":{"options":\["copy","view","mcp","cursor","vscode","chatgpt","claude","perplexity"\],"display":"header"},"styling":{"latex":false},"navigation":{"pages":\[\]}},"deployment":{"deploymentMetadataValue":{"subdomain":"ab-634991b8","hasAudioNarration":false,"actualSubdomain":"ab-634991b8","customDomains":\["www.1password.dev"\],"gitSource":{"type":"github","owner":"1password","repo":"1password.dev","deployBranch":"main","contentDirectory":"","isPrivate":true,"mountPath":"","label":""},"chroma":{"liveDeploymentHistoryId":"6ae4c9014c4a3f4f5e4b234c","collectionId":"2b0d16b8-c8c5-48fa-9c4d-f1ffef490467","schemaVersion":"v3","latestBuiltDeploymentHistoryId":"6ae4c9014c4a3f4f5e4b234c"},"feedback":{"thumbs":true,"contextualFeedback":{"allowEmail":false},"agentFeedback":true},"entitlements":{"AI_CHAT":{"status":"ENABLED"},"REMOVE_BRANDING":{"status":"ENABLED"},"CONTEXTUAL_FEEDBACK":{"status":"ENABLED"},"CODE_SNIPPET_FEEDBACK":{"status":"ENABLED"},"WEB_MCP":{"status":"ENABLED"},"NARRATION":{"status":"ENABLED"}},"buildId":"6ae4c9014c4a3f4f5e4b234c","clientVersion":"0.0.4044","searchFilterCounts":\[{"language":"default","tag":"More Tools","count":257},{"language":"default","tag":"Shell Plugins","count":184},{"language":"default","tag":"CLI","count":112},{"language":"default","tag":"Secrets Automation","count":94},{"language":"default","tag":"SaaS Manager API","count":88},{"language":"default","tag":"Plugins","count":85},{"language":"default","tag":"API Reference","count":64},{"language":"default","tag":"Reference","count":58},{"language":"default","tag":"SDKs","count":53},{"language":"default","tag":"Integrations","count":50}\]},"assistantConfig":{"enableStarterQuestions":true,"enableContextualStarterQuestions":true,"deflection":{"enabled":true,"email":"support@1password.com","showHelpButton":true}},"basePath":"","hasChatPermissions":true,"hasWebMcpPermissions":true,"toggles":\[{"name":"kill-isr","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"agent-mintlify-slack","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"agent-integrations-settings","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"automations-pr-grouping","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"custom-prefix","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"analytics-v7","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"user-flows-analytics","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"no-publish-flow","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"workos-onboarding","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"llms-txt-v2","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"snapshot-serving-live","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"stripTemperatureMiddleware","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"support-platform-pylon-zendesk","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"snapshot-serving","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"instant-rollback","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"granular-notifications-server","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"granular-notifications","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"automations-fable","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"fixed-ai-action-pricing","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"automation-resolve-merge-conflict","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"scoped-publishing","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"mintql","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"page-level-analytics","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"editor-version-history-v2","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"billing-page-v2","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"full-page-search","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"workspace-projects","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"assistant-v5","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"byok-sep-25","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"fork-pr-previews","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"revalidation-jwt","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"vite-origin","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"billing-updated-9-15","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"workos-sso-scim","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"hobby-abuse-scan","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"dashboard-inbox","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"workos-signup","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"turbopuffer-dual-write","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"workos-enabled","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"approve-review-flow","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"sso-setup-deadline-banner","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false}\],"googleFontsInlined":true},"customCss":\[{"filePath":"styles.css","content":":root{--op-secure-blue:#104ebb;--op-secure-blue-hover:#0e46a8;--op-iron-ore:#303136;--op-page-bg-dark:#1a1b1e;--op-white:#ffffff;--op-icy-blue:#dcebff;--op-cornflower:#b8d7ff;--op-biscuit:#fbf8f4;--op-sunbeam:#fad785;--op-tangerine:#ff8f78;--op-enable-mint:#76e0bd;--op-gold:#cbb88e;--op-status-success:#10622f;--op-status-warning:#8a4006;--op-status-error:#a71c1c;--op-status-info:var(--op-secure-blue);--op-border-ui:#949494;--op-border-ui-dark:#6b7280;--op-border-subtle:rgb(3 7 18 / 0.12);--op-border-subtle-dark:rgb(251 248 244 / 0.25);--op-border-footer-dark:rgb(251 248 244 / 0.37);--op-border-navbar-light:rgb(107 114 128 / 0.05);--op-border-navbar-dark:rgb(209 213 219 / 0.06);--op-border-card-light:rgb(3 7 18 / 0.1);--op-border-card-dark:rgb(255 255 255 / 0.1);--op-border-hero-light:rgb(255 255 255 / 0.08);--op-border-hero-dark:rgb(255 255 255 / 0.12);--op-border-badge-light:rgb(16 78 187 / 0.2);--op-border-badge-dark:rgb(184 215 255 / 0.25);--op-border-workflow-dark:rgb(251 248 244 / 0.2);--op-text-body:var(--op-iron-ore);--op-text-body-dark:var(--op-biscuit);--op-surface-card-light:var(--op-white);--op-surface-card-dark:#25262a;--op-surface-callout-light:rgb(220 235 255 / 0.45);--op-surface-callout-dark:rgb(184 215 255 / 0.08)}#content.prose{--tw-prose-body:var(--op-text-body)}.dark \#content.prose{--tw-prose-body:var(--op-text-body-dark)}#content.prose :where(p, span\[data-as=\\p\\\], li, td, th, blockquote, figcaption):not(a.op-cta-primary span){color:var(--op-text-body)}.dark \#content.prose :where(p, span\[data-as=\\p\\\], li, td, th, blockquote, figcaption):not(a.op-cta-primary span){color:var(--op-text-body-dark)}#content :is(p, li, div, span, button, h1, h2, h3, h4, h5, h6).text-gray-600,#content :is(p, li, div, span, button, h1, h2, h3, h4, h5, h6).text-gray-700,#content :is(p, li, span, button, h1, h2, h3, h4, h5, h6).text-gray-500{color:var(--op-text-body)}.dark \#content :is(p, li, div, span, button, h1, h2, h3, h4, h5, h6).dark\\:text-gray-300,.dark \#content :is(p, li, div, span, button, h1, h2, h3, h4, h5, h6).dark\\:text-gray-400,.dark \#content :is(p, li, span, button, h1, h2, h3, h4, h5, h6).dark\\:text-gray-500{color:var(--op-text-body-dark)}#content .text-gray-400:not(:is(p, li, span, button, h1, h2, h3, h4, h5, h6)){color:var(--op-border-ui)}.dark \#content .text-gray-400:not(:is(p, li, span, button, h1, h2, h3, h4, h5, h6)),.dark \#content .text-gray-500:not(:is(p, li, span, button, h1, h2, h3, h4, h5, h6)){color:var(--op-border-ui-dark)}.dark .card-group{--background-dark:37 38 42}.dark .card-group .card{background-color:rgb(var(--background-dark))!important;border-color:var(--op-border-card-dark)!important}.card-group .card{border-color:var(--op-border-card-light)!important}.community-callout,.community-card,.op-card-surface{border:1px solid var(--op-border-card-light)}.dark .community-card,.dark .op-card-surface{border-color:var(--op-border-card-dark)}#content .hover\\:border-gray-300:hover{border-color:var(--op-iron-ore)}.dark \#content .hover\\:border-gray-600:hover{border-color:var(--op-biscuit)}.community-callout,.community-card{border-radius:.5rem;background-color:var(--op-surface-card-light)}.dark .community-card{background-color:var(--op-surface-card-dark)}.community-card .community-card-chevron{color:var(--op-border-ui)}.dark .community-card .community-card-chevron{color:var(--op-cornflower)}a.community-card:hover{border-color:var(--op-secure-blue)}.dark a.community-card:hover{border-color:var(--op-cornflower)}.community-callout{background-color:var(--op-surface-callout-light)}.dark .community-callout{border-color:var(--op-border-card-dark);background-color:var(--op-surface-callout-dark)}.community-link{color:var(--op-secure-blue);text-decoration:none}.community-link:hover{color:var(--op-secure-blue-hover);text-decoration:underline}.dark .community-link{color:var(--op-cornflower)}#footer a,#footer p.font-semibold,.dark \#content\>h5,.dark \#content\>h6,.dark .community-link:hover{color:var(--op-white)}:is(\n \#sidebar-content a:not(\[aria-current=\\page\\\]),\n \#table-of-contents,\n \#table-of-contents a,\n \#navbar .nav-tabs-item:not(\[data-active\]),\n \#navbar nav ul \> li:not(#topbar-cta-button) \> a,\n \#search-bar-entry,\n \#search-bar-entry-mobile,\n \#assistant-entry,\n \#assistant-entry-mobile,\n \[data-component-name=\\theme-toggle\\\]\n){color:var(--op-text-body)}.dark :is(\n \#sidebar-content a:not(\[aria-current=\\page\\\]),\n \#table-of-contents,\n \#table-of-contents a,\n \#navbar .nav-tabs-item:not(\[data-active\]),\n \#navbar nav ul \> li:not(#topbar-cta-button) \> a,\n \#search-bar-entry,\n \#search-bar-entry-mobile,\n \#assistant-entry,\n \#assistant-entry-mobile,\n \[data-component-name=\\theme-toggle\\\]\n){color:var(--op-text-body-dark)}:is(\n \#search-bar-entry,\n \#search-bar-entry-mobile,\n \#assistant-entry,\n \#assistant-entry-mobile,\n \[data-component-name=\\theme-toggle\\\]\n) svg{color:inherit}#footer a.h-fit svg{background-color:var(--op-biscuit)}#footer a.h-fit:hover svg{background-color:var(--op-white)}.hero-background{background-color:var(--op-iron-ore);background-image:radial-gradient(ellipse 75% 100% at 100% 50%,rgb(20 95 228/.55) 0,rgb(20 95 228/.2) 40%,transparent 70%)}.dark .hero-background{background-color:var(--op-page-bg-dark);background-image:radial-gradient(ellipse 80% 100% at 100% 50%,rgb(20 95 228/.7) 0,rgb(20 95 228/.3) 45%,transparent 75%)}.hero-section{border-bottom:1px solid var(--op-border-hero-light)}.dark .hero-section{border-bottom-color:var(--op-border-hero-dark)}.hero-cta{background-color:var(--op-secure-blue);color:var(--op-white);box-shadow:0 1px 3px rgb(0 0 0/.25)}.hero-cta svg,.hero-cta svg path{fill:currentColor!important;color:currentColor!important}.hero-cta:hover{background-color:var(--op-secure-blue-hover)}#content a.op-cta-primary,#content.prose a.op-cta-primary{background-color:var(--op-secure-blue);color:var(--op-white)!important;text-decoration:none}#content a.op-cta-primary span,#content a.op-cta-primary span\[data-as=p\],#content a.op-cta-primary:hover span,#content a.op-cta-primary:hover span\[data-as=p\],#content.prose a.op-cta-primary span,#content.prose a.op-cta-primary span\[data-as=p\],#content.prose a.op-cta-primary:hover span,#content.prose a.op-cta-primary:hover span\[data-as=p\]{color:var(--op-white)!important}#content a.op-cta-primary:hover,#content.prose a.op-cta-primary:hover{background-color:var(--op-secure-blue-hover);color:var(--op-white)!important}#topbar-cta-button a\>span.absolute,.highlight-card-link svg{background-color:var(--op-secure-blue)!important}#topbar-cta-button a:hover\>span.absolute{background-color:var(--op-secure-blue-hover)!important}#topbar-cta-button a span.z-10,#topbar-cta-button a svg,.dark .highlight-card-link:hover{color:var(--op-white)!important}.card-group{gap:1rem}#content .card-group img\[src\*=\\/homepage-icons/brand/\\\]{width:32px;height:32px;flex-shrink:0}.homepage-card-title{display:inline-flex;flex-wrap:wrap;align-items:center;gap:.25rem .5rem}.image-button-link img{margin:10px 0}.dark \#content a\>div\>span{color:var(--op-cornflower)!important}.docs-higlight-cards{display:grid;grid-template-columns:repeat(auto-fill,minmax(250px,1fr));gap:1rem;margin-bottom:1rem}.highlight-card-link{color:var(--op-secure-blue)!important}.highlight-card-link:hover{color:var(--op-secure-blue-hover)!important}.dark .highlight-card-link{color:var(--op-cornflower)!important}.dark .highlight-card-link svg{background-color:var(--op-cornflower)!important}.coloredCodeWrapper .code-block\>div:nth-child(3){--fade-color-light:transparent!important;--fade-color-dark:transparent!important}.badge{border-radius:.4rem;color:var(--op-white);font-weight:700;line-height:1;padding:3px 5px}.badge--primary{background-color:var(--op-secure-blue)}.badge--secondary{background-color:var(--op-biscuit);color:var(--op-iron-ore)}.op-status-badge,.op-workflow-guide-badge{display:inline-flex;flex-shrink:0;align-items:center;white-space:nowrap;border-radius:.25rem;color:var(--op-iron-ore);padding:.125rem .625rem;font-size:.75rem;line-height:1rem;font-weight:600}.op-status-badge{vertical-align:middle;border:1px solid var(--op-border-badge-light);background-color:var(--op-icy-blue)}.dark .op-status-badge{border-color:var(--op-border-badge-dark);background-color:rgb(184 215 255/.12);color:var(--op-icy-blue)}.op-workflow-guide-badge{margin-top:.75rem;border:1px solid transparent;background-color:var(--op-biscuit)}.dark .op-workflow-guide-badge{border-color:var(--op-border-workflow-dark);background-color:rgb(251 248 244/.1);color:var(--op-biscuit)}.op-beta-badge-inline{display:inline-flex;align-items:center;margin-left:.5rem;vertical-align:middle}.mdx-content a\[href^=http\]:not(\[href\*=\\://1password.com/\\\],\[href\$=\\://1password.com\\\],\[href\*=\\.1password.com/\\\],\[href\$=\\.1password.com\\\],\[href\*=\\://1password.dev/\\\],\[href\$=\\://1password.dev\\\],\[href\*=\\.1password.dev/\\\],\[href\$=\\.1password.dev\\\],\[href\*=\\://1password.ca/\\\],\[href\$=\\://1password.ca\\\],\[href\*=\\.1password.ca/\\\],\[href\$=\\.1password.ca\\\],\[href\*=\\://1password.eu/\\\],\[href\$=\\://1password.eu\\\],\[href\*=\\.1password.eu/\\\],\[href\$=\\.1password.eu\\\],\[href\*=\\://1password.io/\\\],\[href\$=\\://1password.io\\\],\[href\*=\\.1password.io/\\\],\[href\$=\\.1password.io\\\],\[href\*=\\://1password.university/\\\],\[href\$=\\://1password.university\\\],\[href\*=\\.1password.university/\\\],\[href\$=\\.1password.university\\\],\[href\*=\\://agilebits.com/\\\],\[href\$=\\://agilebits.com\\\],\[href\*=\\.agilebits.com/\\\],\[href\$=\\.agilebits.com\\\],\[href\*=\\://b5dev.com/\\\],\[href\$=\\://b5dev.com\\\],\[href\*=\\.b5dev.com/\\\],\[href\$=\\.b5dev.com\\\],\[href\*=\\://b5local.com/\\\],\[href\$=\\://b5local.com\\\],\[href\*=\\.b5local.com/\\\],\[href\$=\\.b5local.com\\\],\[href\*=\\://1infra.dev/\\\],\[href\$=\\://1infra.dev\\\],\[href\*=\\.1infra.dev/\\\],\[href\$=\\.1infra.dev\\\],\[href\*=\\://kolide.com/\\\],\[href\$=\\://kolide.com\\\],\[href\*=\\.kolide.com/\\\],\[href\$=\\.kolide.com\\\],\[href\*=\\://trelica.app/\\\],\[href\$=\\://trelica.app\\\],\[href\*=\\.trelica.app/\\\],\[href\$=\\.trelica.app\\\],\[href\*=\\://trelica.eu/\\\],\[href\$=\\://trelica.eu\\\],\[href\*=\\.trelica.eu/\\\],\[href\$=\\.trelica.eu\\\],\[href\*=\\://trelica.com/\\\],\[href\$=\\://trelica.com\\\],\[href\*=\\.trelica.com/\\\],\[href\$=\\.trelica.com\\\],\[href\*=\\://1password.community/\\\],\[href\$=\\://1password.community\\\],\[href\*=\\.1password.community/\\\],\[href\$=\\.1password.community\\\],\[href\*=\\://1pw.ca/\\\],\[href\$=\\://1pw.ca\\\],\[href\*=\\.1pw.ca/\\\],\[href\$=\\.1pw.ca\\\]):not(.card \*,.op-card-surface \*,.image-button-link,.community-card,.community-card \*,pre \*,:has(img))::after{content:\\\\;display:inline-block;width:1em;height:1em;margin-left:.25em;vertical-align:-.125em;background-color:currentColor;-webkit-mask:var(--op-link-icon, url(\\/static/img/icons/external-link.svg\\)) no-repeat center/contain;mask:var(--op-link-icon, url(\\/static/img/icons/external-link.svg\\)) no-repeat center/contain}.mdx-content a:is(\[href\*=\\://github.com/\\\], \[href\$=\\://github.com\\\], \[href\*=\\.github.com/\\\], \[href\$=\\.github.com\\\], \[href\*=\\://github.blog/\\\], \[href\$=\\://github.blog\\\]){--op-link-icon:url(\\/static/img/logos/github.svg\\)}#content\>h5,#content\>h6{font-weight:700}.accordion{background-color:var(--op-icy-blue)}.dark .accordion{background-color:var(--op-surface-card-dark)}.accordion .mint-bg-white{padding:1rem}.accordion .mint-bg-white \[class\*=-mx-\]{margin:0!important;padding:0!important;width:100%!important;--page-padding:0px}#footer img.nav-logo.dark\\:hidden,#footer\>div\>div.flex.flex-col.md\\:flex-row.gap-8.justify-between.min-h-\\\[76px\\\]\>div.flex.flex-col.sm\\:grid.max-md\\:\\!grid-cols-2.gap-8.flex-1\>div\>div\>p{display:none!important}footer#footer.advanced-footer{display:flex!important}footer#footer{align-items:unset;background-color:var(--op-iron-ore);color:var(--op-white)}#footer img.nav-logo.dark\\:block{display:block!important}#footer\>div.flex.w-full.flex-col.gap-12.justify-between.px-8.py-16.md\\:py-20.lg\\:py-28.z-20\>div.h-\\\[1px\\\].w-full.bg-gray-100.dark\\:bg-white\\/5{background-color:var(--op-border-footer-dark)}#footer\>div.flex.w-full.flex-col.gap-12.justify-between.px-8.py-16.md\\:py-20.lg\\:py-28.z-20{margin:0 auto}footer .email_form{max-width:650px;margin:auto}.codeblock_accordion{margin-top:10px}.codeblock_accordion .code-block{margin:0!important}.codeblock_accordion\>div\>.code-block,.codeblock_accordion\>div\>.code-block\>div:nth-child(2){border-bottom-left-radius:0;border-bottom-right-radius:0}.codeblock_accordion .see_results_container{border-bottom-left-radius:1rem;border-bottom-right-radius:1rem}.codeblock_accordion .see_results_container .code-block,.codeblock_accordion .see_results_container .code-block\>div:nth-child(2){border-top-left-radius:0;border-top-right-radius:0}.hide_bullets ul li{padding-left:0!important}.hide_bullets ul li::before{content:none!important}#navigation-items a\[href^=\\/\\\]:not(\[href^=\\//\\\])\>div\>div:nth-child(2){display:none}a\[href^=\\//\\\] .flex-shrink-0 svg,a\[href^=http\] .flex-shrink-0 svg{display:block}h1 code,h2 code,h3 code,h4 code,h5 code,h6 code{white-space:nowrap}h2.flex.whitespace-pre-wrap span.cursor-pointer svg.icon,h4.flex.whitespace-pre-wrap span.cursor-pointer svg.icon{margin:0;vertical-align:baseline}table thead tr th code{padding-left:0!important;padding-right:0!important}.tabs.tab-container{padding:0 .8rem 1rem;border:1px solid var(--op-border-subtle);border-radius:4px}.dark .tabs.tab-container{border-color:var(--op-border-subtle-dark)}.nav-tabs-item:nth-child(3),nav-tabs-item:nth-child(3){--tab-gap-before-divider:8px;--nav-tabs-item-gap:0.5rem;margin-left:var(--tab-gap-before-divider)!important;padding-left:calc(var(--tab-gap-before-divider) + var(--nav-tabs-item-gap))!important;border-left:1px solid var(--op-border-navbar-light)}.dark .nav-tabs-item:nth-child(3),.dark nav-tabs-item:nth-child(3){border-left-color:var(--op-border-navbar-dark)}.peer.is-center~div:has(.tutorial-explorer){max-width:84rem!important}@media (max-width:639px){.tutorial-filter-bar{display:grid!important;grid-template-columns:minmax(0,1fr)}.tutorial-filter-search,.tutorial-filter-tools,.tutorial-filter-topic{grid-column:1/-1;width:100%}.tutorial-filter-search input{width:100%!important}.tutorial-filter-dropdown\>button,.tutorial-filter-menu{width:100%}.tutorial-filter-dropdown\>button{justify-content:space-between}.tutorial-filter-menu{min-width:0!important}.tutorial-filter-sort{grid-column:1/-1;justify-self:end;margin-left:0!important}}#navbar.is-custom .nav-tabs-item\[data-active\]{color:var(--op-text-body);text-shadow:none}.dark \#navbar.is-custom .nav-tabs-item\[data-active\]{color:var(--op-text-body-dark)}#navbar.is-custom .nav-tabs-item\[data-active\]\>div{background-color:transparent!important}#navbar.is-custom .nav-tabs-item\[data-active\]:hover\>div{background-color:rgb(229 231 235)!important}.dark \#navbar.is-custom .nav-tabs-item\[data-active\]:hover\>div{background-color:rgb(55 65 81)!important}#footer .api-sdk-terms-notice{margin:0;padding:0 0 1.25rem;font-size:.875rem;font-style:italic;line-height:1.5;text-align:center;color:rgb(251 248 244/.8);pointer-events:auto}#footer .api-sdk-terms-notice a{position:relative;z-index:2;color:var(--op-cornflower);text-decoration:underline;text-underline-offset:2px;pointer-events:auto;cursor:pointer}"}\],"page":{"pagePath":"cli/reference/management-commands/item","slug":"/cli/reference/management-commands/item","pageMetadata":{"id":"item","title":"item","old_title":"item \| 1Password CLI","sidebarTitle":"item","og:description":"Learn about the 1Password CLI 'item' command and its subcommands.","slug":"/cli/reference/management-commands/item","description":null,"href":"/cli/reference/management-commands/item"},"pageType":"default","mdx":{"mdxSource":{"compiledSource":"\\use strict\\;const{Fragment:\_Fragment,jsx:\_jsx,jsxs:\_jsxs}=arguments\[0\];const{useMDXComponents:\_provideComponents}=arguments\[0\];function \_createMdxContent(props){const \_components={a:\`a\`,code:\`code\`,li:\`li\`,ol:\`ol\`,p:\`p\`,pre:\`pre\`,span:\`span\`,ul:\`ul\`,...\_provideComponents(),...props.components},{CodeBlock,Danger,Heading}=\_components;if(!CodeBlock)\_missingMdxReference(\`CodeBlock\`,true);if(!Danger)\_missingMdxReference(\`Danger\`,true);if(!Heading)\_missingMdxReference(\`Heading\`,true);return \_jsxs(\_Fragment,{children:\[\_jsx(\_components.p,{children:\`Perform CRUD operations on the 1Password items in your vaults.\`}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`subcommands\`,children:\`Subcommands\`}),\`\n\`,\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\_jsx(\_components.a,{href:\`#item-create\`,children:\`item create\`}),\`: Create an item\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\_jsx(\_components.a,{href:\`#item-delete\`,children:\`item delete\`}),\`: Delete or archive an item\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\_jsx(\_components.a,{href:\`#item-edit\`,children:\`item edit\`}),\`: Edit an item’s details\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\_jsx(\_components.a,{href:\`#item-get\`,children:\`item get\`}),\`: Get an item’s details\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\_jsx(\_components.a,{href:\`#item-list\`,children:\`item list\`}),\`: List items\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\_jsx(\_components.a,{href:\`#item-move\`,children:\`item move\`}),\`: Move an item between vaults\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\_jsx(\_components.a,{href:\`#item-share\`,children:\`item share\`}),\`: Share an item\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\_jsx(\_components.a,{href:\`#item-template\`,children:\`item template\`}),\`: Manage templates\`\]}),\`\n\`\]}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`item-create\`,children:\`item create\`}),\`\n\`,\_jsx(\_components.p,{children:\`Create a new item.\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item create \[ - \] \[ \u003cassignment\>... \] \[flags\]\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`flags\`,children:\`Flags\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`15\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`15\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--category category Set the item's category.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--dry-run Test the command and output a preview of the resulting item.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--favorite Add item to favorites.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--generate-password\[=recipe\] Add a randomly-generated password to a Login or Password item.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--reveal Don't conceal sensitive fields.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--ssh-generate-key The type of SSH key to create: Ed25519 or RSA. For RSA,\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\` specify 2048, 3072, or 4096 (default) bits. Possible values:\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\` ed25519, rsa, rsa2048, rsa3072, rsa4096. (default Ed25519)\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--tags tags Set the tags to the specified (comma-separated)\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\` values.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--template string Specify the filepath to read an item template from.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--title title Set the item's title.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--url URL Set the website where 1Password suggests and fills a Login, Password, or API Credential item.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--vault vault Save the item in this vault. Default: Private.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`Get a list of all item categories:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` item\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` template\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` list\`})\]}),\`\n\`\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`Use assignment statements or an item category JSON template to save details in\nbuilt-in or custom fields.\`}),\`\n\`,\_jsx(\_components.p,{children:\_jsx(\_components.a,{href:\`/cli/item-create/\`,children:\`Learn more about creating items.\`})}),\`\n\`,\_jsx(\_components.p,{children:\_jsx(\_components.a,{href:\`/cli/item-fields/\`,children:\`Learn more about item fields and fieldTypes.\`})}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`generate-a-password\`,children:\`Generate a password\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`Use the \`,\_jsx(\_components.code,{children:\`--generate-password\`}),\` option to set a random password for a Login\nor Password item. The default is 32-characters, and includes upper and\nlowercase letters, numbers, and symbols (\`,\_jsx(\_components.code,{children:\`!@.-\_\*\`}),\`).\`\]}),\`\n\`,\_jsx(\_components.p,{children:\`You can specify the password length (between 1 and 64 characters) and the\ncharacter types to use:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`\t--generate-password\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`=\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`'letters,digits,symbols,32'\`})\]}),\`\n\`\]})})}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`set-additional-fields-with-assignment-statements\`,children:\`Set additional fields with assignment statements\`}),\`\n\`,\_jsx(\_components.p,{children:\`You can use assignment statements as command arguments to set built-in and\ncustom fields.\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`\[\u003csection\>.\]\u003cfield\>\[\[\u003cfieldType\>\]\]=\u003cvalue\>\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`Command arguments get logged in your command history, and\ncan be visible to other processes on your machine. If you’re assigning\nsensitive values, use a JSON template instead.\`}),\`\n\`,\_jsx(\_components.p,{children:\`For example, to create a text field named “host” within a section named\n“Database Credentials”, with the value set to 33.166.240.221:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`DatabaseCredentials.host\[text\]\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`=33.166.240.221\`})\]}),\`\n\`\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`The section name is optional unless multiple sections contain fields with\nthe same name.\`}),\`\n\`,\_jsx(\_components.p,{children:\`Use a backslash to escape periods, equal signs, or backslashes in section\nor field names. Don’t use backslashes to escape the value.\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`You can omit spaces in the section or field name, or refer to the field by\nits JSON short name (\`,\_jsx(\_components.code,{children:\`name\`}),\` or \`,\_jsx(\_components.code,{children:\`n\`}),\`).\`\]}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`create-an-item-using-a-json-template\`,children:\`Create an item using a json template\`}),\`\n\`,\_jsx(\_components.p,{children:\`Use an item JSON template to assign sensitive values to an item. If you\ncombine a template with assignment statements, assignment statements\ntake precedence.\`}),\`\n\`,\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Save the appropriate item category template to a file:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` item\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` template\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` get\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --out-file\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` login.json\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\Login\\\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Edit the template.\`}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Create a new item using the \`,\_jsx(\_components.code,{children:\`-—template\`}),\` flag to specify the path to the edited template:\`\]}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` item\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` create\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --template=login.json\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`After 1Password CLI creates the item, delete the edited template.\`}),\`\n\`,\_jsx(\_components.p,{children:\`You can also create an item from standard input using an item JSON template.\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`Pass the \`,\_jsx(\_components.code,{children:\`-\`}),\` character as the first argument, followed by any assignment\nstatements.\`\]}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` item\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` template\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` get\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` Login\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \|\`}),\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` item\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` create\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --vault\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` personal\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` -\`})\]}),\`\n\`\]})})}),\`\n\`,\_jsxs(\_components.p,{children:\[\`You can’t use both piping and the \`,\_jsx(\_components.code,{children:\`--template\`}),\` flag in the same command, to\navoid collisions.\`\]}),\`\n\`\]}),\`\n\`\]}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`examples\`,children:\`Examples\`}),\`\n\`,\_jsx(\_components.p,{children:\`Create a Login item with a random password and website set using flags\nand custom and built-in fields set with assignment statements, including\na one-time password field and a file attachment:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`6\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`6\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` item\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` create\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --category=login\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --title=\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`'My Example Item'\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --vault=\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`'Test'\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\` \\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --url\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` https://www.acme.com/login\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\` \\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --generate-password=20,letters,digits\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\` \\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` username=jane@acme.com\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\` \\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` 'Test Section 1.Test Field3\[otp\]=otpauth://totp/\u003cwebsite\>:\u003cuser\>?secret=\u003csecret\>\u0026issuer=\u003cissuer\>'\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\` \\\\\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` 'FileName\[file\]=/path/to/your/file'\`})}),\`\n\`\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`Create an item by duplicating an existing item from another vault and modifying\nit with assignment statements:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`2\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`2\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` item\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` get\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\My Item\\\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --format\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` json\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \|\`}),\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` item\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` create\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --vault\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` prod\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` -\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\` \\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` username=\\My Username\\\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` password=\\My Password\\\`})\]}),\`\n\`\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`Duplicate all items in a vault in one account to a vault in another account:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`3\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`3\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` item\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` list\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --vault\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` test-vault\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --format\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` json\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --account\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` agilebits\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \|\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\` \\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` item\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` get\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --format\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` json\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --account\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` agilebits\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` -\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \|\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D7BA7D\`},children:\` \\\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` item\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` create\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --account\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` work\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` -\`})\]}),\`\n\`\]})})}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`item-delete\`,children:\`item delete\`}),\`\n\`,\_jsx(\_components.p,{children:\`Delete or archive items you no longer need.\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item delete \[{ \u003citemName\> \| \u003citemID\> \| \u003cshareLink\> \| - }\] \[flags\]\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`flags-2\`,children:\`Flags\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`3\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`3\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--archive Move the item to the Archive.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--vault string Look for the item in this vault.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`Deleted items remain available for 30 days in Recently Deleted. You can restore or permanently delete items from Recently Deleted in the 1Password apps.\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`Use the \`,\_jsx(\_components.code,{children:\`--archive\`}),\` option to move an item to the Archive instead.\`\]}),\`\n\`,\_jsx(\_components.p,{children:\`Specify an item to delete or archive by its name, ID, or sharing link.\`}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`specify-items-on-standard-input\`,children:\`Specify items on standard input\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`The command treats each line of information on standard input (stdin) as\nan object specifier. Run \`,\_jsx(\_components.code,{children:\`op help\`}),\` to learn more about how to specify\nobjects.\`\]}),\`\n\`,\_jsxs(\_components.p,{children:\[\`The input can also be a list or array of JSON objects. The command will\nget an item for any object that has an ID. This is useful for\npassing information from one \`,\_jsx(\_components.code,{children:\`op\`}),\` command to another.\`\]}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`examples-2\`,children:\`Examples\`}),\`\n\`,\_jsx(\_components.p,{children:\`Delete an item:\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item delete \\Defunct Login\\\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`Move an item to the Archive:\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item delete \\Defunct Login\\ --archive\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`item-edit\`,children:\`item edit\`}),\`\n\`,\_jsx(\_components.p,{children:\`Edit an item’s details.\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item edit { \u003citemName\> \| \u003citemID\> \| \u003cshareLink\> } \[ \u003cassignment\> ... \] \[flags\]\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`flags-3\`,children:\`Flags\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`12\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`12\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--dry-run Perform a dry run of the command and output a preview\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\` of the resulting item.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--favorite Whether this item is a favorite item. Options: true, false.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--generate-password\[=recipe\] Give the item a randomly generated password.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--reveal Don't conceal sensitive fields.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--tags tags Set the tags to the specified (comma-separated)\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\` values. An empty value will remove all tags.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--template string Specify the filepath to read an item template from.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--title title Set the item's title.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--url URL Set the website where 1Password suggests and fills a Login, Password, or API Credential item.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--vault vault Edit the item in this vault.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`Specify the item by its name, ID, or sharing link. Use flags to update the\ntitle, tags, or generate a new random password.\`}),\`\n\`,\_jsx(\_components.p,{children:\`You can use assignment statements as command arguments to update built-in\nor custom fields. For sensitive values, use a template instead.\`}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`edit-an-item-using-assignment-statements\`,children:\`Edit an item using assignment statements\`}),\`\n\`,\_jsx(\_components.p,{children:\`Caution: Command arguments can be visible to other processes on your machine.\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\[\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\u003c\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`section\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`.\]\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\u003c\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`field\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\[\[\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\u003c\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`fieldType\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\]\]=\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\u003c\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`value\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`})\]}),\`\n\`\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`To create a new field or section, specify a field or section name that doesn’t\nalready exist on the item.\`}),\`\n\`,\_jsx(\_components.p,{children:\`To edit an existing field, specify the current section and field name, then make\nchanges to the fieldType or value. If you don’t specify a fieldType or value,\nit will stay the same.\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`To delete a custom field, specify \`,\_jsx(\_components.code,{children:\`\[delete\]\`}),\` in place of the fieldType. If a\nsection no longer has any fields, the section will also be deleted. You can’t\ndelete built-in fields, but you can set them to empty strings.\nLearn more about assignment statements: \`,\_jsx(\_components.code,{children:\`op item create –-help\`}),\`.\`\]}),\`\n\`,\_jsx(\_components.p,{children:\_jsx(\_components.a,{href:\`/cli/item-fields\`,children:\`Learn more about available fields and fieldTypes.\`})}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`edit-an-item-using-a-template\`,children:\`Edit an item using a template\`}),\`\n\`,\_jsx(Danger,{children:\_jsxs(\_components.p,{children:\[\`JSON item templates do not support passkeys. If you use a JSON template to update an item that contains a passkey, the passkey will be overwritten. To fix this, you can \`,\_jsx(\_components.a,{href:\`https://support.1password.com/item-history/\`,children:\`restore a previous version of the item\`}),\`.\`\]})}),\`\n\`,\_jsx(\_components.p,{children:\`You can use a JSON template to edit an item, alone or in combination with\ncommand arguments. Field assignment statements overwrite values in the\ntemplate.\`}),\`\n\`,\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Get the item you want to edit in JSON format and save it to a file:\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item get oldLogin --format=json \> updatedLogin.json\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Edit the file.\`}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsxs(\_components.p,{children:\[\`Use the \`,\_jsx(\_components.code,{children:\`--template\`}),\` flag to specify the path to the edited file and edit\nthe item:\`\]}),\`\n\`,\_jsx(\_components.p,{children:\`op item edit oldLogin —template=updatedLogin.json\`}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Delete the file.\`}),\`\n\`,\_jsx(\_components.p,{children:\`You can also edit an item using piped input:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`cat\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` updatedLogin.json\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` \|\`}),\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\` op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` item\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` edit\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` oldLogin\`})\]}),\`\n\`\]})})}),\`\n\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.p,{children:\[\`To avoid collisions, you can’t combine piped input and the \`,\_jsx(\_components.code,{children:\`--template\`}),\`\nflag in the same command.\`\]}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`examples-3\`,children:\`Examples\`}),\`\n\`,\_jsx(\_components.p,{children:\`Add a 32-character random password that includes upper- and lower-case letters,\nnumbers, and symbols to an item:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` item\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` edit\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` 'My Example Item'\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --generate-password=\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`'letters,digits,symbols,32'\`})\]}),\`\n\`\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`Edit a custom field’s value without changing the fieldType:\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item edit 'My Example Item' 'field1=new value'\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`Edit a custom field’s fieldType without changing the value:\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item edit 'My Example Item' 'field1\[password\]'\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`Edit a custom field’s type and value:\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item edit 'My Example Item' 'field1\[monthyear\]=2021/09'\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`Add a new custom field to an item:\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item edit 'My Example Item' 'section2.field5\[phone\]=1-234-567-8910'\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`Remove an existing custom field:\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item edit 'My Example Item' 'section2.field5\[delete\]'\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`Set the built-in username field to an empty value:\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item edit 'My Example Item' 'username='\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`Edit an item using a template alongside command arguments and assignment\nstatements:\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`op\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` item\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` edit\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` oldLogin\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --vault\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` Private\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` 'username=Lucky'\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` --template=updatedLogin.json\`})\]}),\`\n\`\]})})}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`item-get\`,children:\`item get\`}),\`\n\`,\_jsx(\_components.p,{children:\`Get details about an item. Specify the item by its name, ID, or sharing link.\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item get \[{ \u003citemName\> \| \u003citemID\> \| \u003cshareLink\> \| - }\] \[flags\]\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`flags-4\`,children:\`Flags\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`8\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`8\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\\--fields strings Return data from specific fields. Use \`label=\` to get the field by name or \`type=\` to filter fields by type. Specify multiple in a comma-separated list.\\})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--include-archive Include items in the Archive. Can also be set using\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\` OP_INCLUDE_ARCHIVE environment variable.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--otp Output the primary one-time password for this item.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--reveal Don't conceal sensitive fields.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--share-link Get a shareable link for the item.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--vault vault Look for the item in this vault.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsxs(\_components.p,{children:\[\`If you have multiple items with the same name, or if you’re concerned about\nAPI rate limits, specify the item by its ID or limit the scope of the search\nwith the \`,\_jsx(\_components.code,{children:\`--vault\`}),\` flag.\`\]}),\`\n\`,\_jsx(\_components.p,{children:\_jsx(\_components.a,{href:\`/cli/reference\`,children:\`Learn more about IDs and caching.\`})}),\`\n\`,\_jsxs(\_components.p,{children:\[\`To retrieve the contents of a specific field, use \`,\_jsx(\_components.code,{children:\`op read\`}),\` instead.\nWhen using service accounts, you must specify a vault with the \`,\_jsx(\_components.code,{children:\`--vault\`}),\` flag\nor through piped input.\`\]}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`specify-items-on-standard-input-2\`,children:\`Specify items on standard input\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\_jsx(\_components.code,{children:\`op item get\`}),\` treats each line of information on standard input (stdin) as an\nobject specifier.\`\]}),\`\n\`,\_jsx(\_components.p,{children:\`You can also input a list or array of JSON objects, and the command will get an\nitem for any object that has an ID key. This is useful for passing information\nfrom one command to another.\`}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`items-in-the-archive\`,children:\`Items in the archive\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`Items in the Archive are ignored by default. To get details for an\nitem in the Archive, specify the item by ID or use the\n\`,\_jsx(\_components.code,{children:\`--include-archive\`}),\` option.\`\]}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`examples-4\`,children:\`Examples\`}),\`\n\`,\_jsx(\_components.p,{children:\`Get details for all items with a specified tag:\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item list --tags documentation --format json \| op item get -\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`Get a CSV list of the username, and password for all logins in a vault:\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item list --categories Login --vault Staging --format json \| op item get - --fields label=username,label=password\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`Get a JSON object of an item’s username and password fields:\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item get Netflix --fields label=username,label=password --format json\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`Get a list of fields by type:\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item get Netflix --fields type=concealed\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`Get an item’s one-time password:\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item get Google --otp\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`Retrieve a shareable link for the item referenced by ID:\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item get kiramv6tpjijkuci7fig4lndta --vault \\Ops Secrets\\ --share-link\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`item-list\`,children:\`item list\`}),\`\n\`,\_jsx(\_components.p,{children:\`List items.\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item list \[flags\]\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`flags-5\`,children:\`Flags\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`8\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`8\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--categories categories Only list items in these categories (comma-separated).\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--favorite Only list favorite items.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--include-archive Include items in the Archive. Can also be set using\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\` OP_INCLUDE_ARCHIVE environment variable.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--long Output a more detailed item list.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--tags tags Only list items with these tags (comma-separated).\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--vault vault Only list items in this vault.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`Returns a list of all items the account has read access to by default. Use flags to filter results.\nExcludes items in the Archive by default.\`}),\`\n\`,\_jsx(\_components.p,{children:\`Categories are:\`}),\`\n\`,\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsx(\_components.li,{children:\`API Credential\`}),\`\n\`,\_jsx(\_components.li,{children:\`Bank Account\`}),\`\n\`,\_jsx(\_components.li,{children:\`Credit Card\`}),\`\n\`,\_jsx(\_components.li,{children:\`Database\`}),\`\n\`,\_jsx(\_components.li,{children:\`Document\`}),\`\n\`,\_jsx(\_components.li,{children:\`Driver License\`}),\`\n\`,\_jsx(\_components.li,{children:\`Email Account\`}),\`\n\`,\_jsx(\_components.li,{children:\`Identity\`}),\`\n\`,\_jsx(\_components.li,{children:\`Login\`}),\`\n\`,\_jsx(\_components.li,{children:\`Membership\`}),\`\n\`,\_jsx(\_components.li,{children:\`Outdoor License\`}),\`\n\`,\_jsx(\_components.li,{children:\`Passport\`}),\`\n\`,\_jsx(\_components.li,{children:\`Password\`}),\`\n\`,\_jsx(\_components.li,{children:\`Reward Program\`}),\`\n\`,\_jsx(\_components.li,{children:\`Secure Note\`}),\`\n\`,\_jsx(\_components.li,{children:\`Server\`}),\`\n\`,\_jsx(\_components.li,{children:\`Social Security Number\`}),\`\n\`,\_jsx(\_components.li,{children:\`Software License\`}),\`\n\`,\_jsx(\_components.li,{children:\`Wireless Router\`}),\`\n\`\]}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`examples-5\`,children:\`Examples\`}),\`\n\`,\_jsx(\_components.p,{children:\`Get details for all items with a specified tag:\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item list --tags documentation --format=json \| op item get -\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`Get a CSV list of the username, and password for all logins in a vault:\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item list --categories Login --vault Staging --format=json \| op item get - --fields username,password\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsxs(\_components.p,{children:\[\`Selecting a tag \`,\_jsx(\_components.code,{children:\`\u003ctag\>\`}),\` will also return items with tags sub-nested to \`,\_jsx(\_components.code,{children:\`\u003ctag\>\`}),\`. For example: \`,\_jsx(\_components.code,{children:\`\u003ctag/subtag\>\`}),\`.\`\]}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`item-move\`,children:\`item move\`}),\`\n\`,\_jsx(\_components.p,{children:\`Move an item between vaults.\`}),\`\n\`,\_jsx(\_components.p,{children:\`Moving an item creates a copy of the item in the destination vault and\ndeletes the item from the current vault. As a result, the item gets a new ID.\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item move \[{ \u003citemName\> \| \u003citemID\> \| \u003cshareLink\> \| - }\] \[flags\]\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`flags-6\`,children:\`Flags\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`4\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`4\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--current-vault string Vault where the item is currently saved.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--destination-vault string The vault you want to move the item to.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--reveal Don't conceal sensitive fields.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`To restore or permanently delete the original item, find the item in Recently Deleted\nin your 1Password app or on 1Password.com.\`}),\`\n\`,\_jsx(\_components.p,{children:\`Moving an item between vaults may change who has access to the item.\`}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`examples-6\`,children:\`Examples\`}),\`\n\`,\_jsx(\_components.p,{children:\`Move an item from the Private vault to the Shared vault:\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item move \\My Example Item\\ --current-vault Private --destination-vault Shared\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`item-share\`,children:\`item share\`}),\`\n\`,\_jsx(\_components.p,{children:\`Share an item.\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item share { \u003citemName\> \| \u003citemID\> } \[flags\]\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`flags-7\`,children:\`Flags\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`6\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`6\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--emails strings Email addresses to share with.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--expires-in duration Expire link after the duration specified in (s)econds,\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\` (m)inutes, (h)ours, (d)ays, and/or (w)eeks. (default 7d)\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--vault string Look for the item in this vault.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`--view-once Expire link after a single view.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(\_components.p,{children:\`You can securely share copies of passwords and other items you’ve saved in 1Password with anyone, even if they don’t use 1Password.\`}),\`\n\`,\_jsx(\_components.p,{children:\`When you share an item, you’ll get a unique link that you can send to others.\`}),\`\n\`,\_jsx(\_components.p,{children:\`Copy the URL, then send the link to the person or people you want to share the item copy with, like in an email or text message. Anyone with the link can view the item copy unless you specify addresses with the emails flag.\`}),\`\n\`,\_jsx(\_components.p,{children:\`If you edit an item, your changes won’t be shared until you share the item\nagain. Note that file attachments and Document items cannot be shared.\`}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`item-template\`,children:\`item template\`}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`subcommands-2\`,children:\`Subcommands\`}),\`\n\`,\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\_jsx(\_components.a,{href:\`#item-template-get\`,children:\`item template get\`}),\`: Get an item template\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\_jsx(\_components.a,{href:\`#item-template-list\`,children:\`item template list\`}),\`: Get a list of templates\`\]}),\`\n\`\]}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`item-template-get\`,children:\`item template get\`}),\`\n\`,\_jsx(\_components.p,{children:\`Return a template for an item type.\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item template get \[{ \u003ccategory\> \| - }\] \[flags\]\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`flags-8\`,children:\`Flags\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`4\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`4\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\` --file-mode filemode Set filemode for the output file. It is ignored without the --out-file flag. (default 0600)\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`-f, --force Do not prompt for confirmation.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`-o, --out-file string Write the template to a file instead of stdout.\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsxs(\_components.p,{children:\[\`You can create a new item with a template.\nRun \`,\_jsx(\_components.code,{children:\`op item create --help\`}),\` for more information.\`\]}),\`\n\`,\_jsx(\_components.p,{children:\`Categories are:\`}),\`\n\`,\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsx(\_components.li,{children:\`API Credential\`}),\`\n\`,\_jsx(\_components.li,{children:\`Bank Account\`}),\`\n\`,\_jsx(\_components.li,{children:\`Credit Card\`}),\`\n\`,\_jsx(\_components.li,{children:\`Database\`}),\`\n\`,\_jsx(\_components.li,{children:\`Document\`}),\`\n\`,\_jsx(\_components.li,{children:\`Driver License\`}),\`\n\`,\_jsx(\_components.li,{children:\`Email Account\`}),\`\n\`,\_jsx(\_components.li,{children:\`Identity\`}),\`\n\`,\_jsx(\_components.li,{children:\`Login\`}),\`\n\`,\_jsx(\_components.li,{children:\`Membership\`}),\`\n\`,\_jsx(\_components.li,{children:\`Outdoor License\`}),\`\n\`,\_jsx(\_components.li,{children:\`Passport\`}),\`\n\`,\_jsx(\_components.li,{children:\`Password\`}),\`\n\`,\_jsx(\_components.li,{children:\`Reward Program\`}),\`\n\`,\_jsx(\_components.li,{children:\`Secure Note\`}),\`\n\`,\_jsx(\_components.li,{children:\`Server\`}),\`\n\`,\_jsx(\_components.li,{children:\`Social Security Number\`}),\`\n\`,\_jsx(\_components.li,{children:\`Software License\`}),\`\n\`,\_jsx(\_components.li,{children:\`Wireless Router\`}),\`\n\`\]}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`item-template-list\`,children:\`item template list\`}),\`\n\`,\_jsx(\_components.p,{children:\`Lists available item type templates.\`}),\`\n\`,\_jsx(CodeBlock,{numberOfLines:\`2\`,language:\`text\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`text\`,children:\_jsxs(\_components.code,{language:\`text\`,numberOfLines:\`2\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{children:\`op item template list \[flags\]\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{})})\]})})}),\`\n\`,\_jsxs(\_components.p,{children:\[\`Use \`,\_jsx(\_components.code,{children:\`op item template get \u003ccategory\>\`}),\` to get a template.\`\]})\]})}function MDXContent(props={}){const{wrapper:MDXLayout}={...\_provideComponents(),...props.components};return MDXLayout?\_jsx(MDXLayout,{...props,children:\_jsx(\_createMdxContent,{...props})}):\_createMdxContent(props)}return{default:MDXContent};function \_missingMdxReference(id,component){throw new Error(\`Expected \`+(component?\`component\`:\`object\`)+\\ \`\\+id+\\\` to be defined: you likely forgot to import, pass, or provide it.\\)}","frontmatter":{},"scope":{"config":{},"pageMetadata":{"id":"item","title":"item","old_title":"item \| 1Password CLI","sidebarTitle":"item","og:description":"Learn about the 1Password CLI 'item' command and its subcommands.","slug":"/cli/reference/management-commands/item","description":null,"href":"/cli/reference/management-commands/item"}}},"mdxSourceWithNoJs":null},"mdxExtracts":{"tableOfContents":\[{"title":"Subcommands","slug":"subcommands","depth":3,"children":\[\]},{"title":"item create","slug":"item-create","depth":2,"children":\[{"title":"Flags","slug":"flags","depth":3,"children":\[\]},{"title":"Generate a password","slug":"generate-a-password","depth":4,"children":\[\]},{"title":"Set additional fields with assignment statements","slug":"set-additional-fields-with-assignment-statements","depth":4,"children":\[\]},{"title":"Create an item using a json template","slug":"create-an-item-using-a-json-template","depth":4,"children":\[\]},{"title":"Examples","slug":"examples","depth":3,"children":\[\]}\]},{"title":"item delete","slug":"item-delete","depth":2,"children":\[{"title":"Flags","slug":"flags-2","depth":3,"children":\[\]},{"title":"Specify items on standard input","slug":"specify-items-on-standard-input","depth":4,"children":\[\]},{"title":"Examples","slug":"examples-2","depth":3,"children":\[\]}\]},{"title":"item edit","slug":"item-edit","depth":2,"children":\[{"title":"Flags","slug":"flags-3","depth":3,"children":\[\]},{"title":"Edit an item using assignment statements","slug":"edit-an-item-using-assignment-statements","depth":4,"children":\[\]},{"title":"Edit an item using a template","slug":"edit-an-item-using-a-template","depth":4,"children":\[\]},{"title":"Examples","slug":"examples-3","depth":3,"children":\[\]}\]},{"title":"item get","slug":"item-get","depth":2,"children":\[{"title":"Flags","slug":"flags-4","depth":3,"children":\[\]},{"title":"Specify items on standard input","slug":"specify-items-on-standard-input-2","depth":4,"children":\[\]},{"title":"Items in the archive","slug":"items-in-the-archive","depth":4,"children":\[\]},{"title":"Examples","slug":"examples-4","depth":3,"children":\[\]}\]},{"title":"item list","slug":"item-list","depth":2,"children":\[{"title":"Flags","slug":"flags-5","depth":3,"children":\[\]},{"title":"Examples","slug":"examples-5","depth":3,"children":\[\]}\]},{"title":"item move","slug":"item-move","depth":2,"children":\[{"title":"Flags","slug":"flags-6","depth":3,"children":\[\]},{"title":"Examples","slug":"examples-6","depth":3,"children":\[\]}\]},{"title":"item share","slug":"item-share","depth":2,"children":\[{"title":"Flags","slug":"flags-7","depth":3,"children":\[\]}\]},{"title":"item template","slug":"item-template","depth":2,"children":\[{"title":"Subcommands","slug":"subcommands-2","depth":3,"children":\[\]}\]},{"title":"item template get","slug":"item-template-get","depth":2,"children":\[{"title":"Flags","slug":"flags-8","depth":3,"children":\[\]}\]},{"title":"item template list","slug":"item-template-list","depth":2,"children":\[\]}\],"codeExamples":{}},"jsLinks":\["/\_mintlify/custom/ab-634991b8/5ebc0d10523e8210/static/js/analytics.js","/\_mintlify/custom/ab-634991b8/5bb7437b1c9dcb44/static/js/gtag-prod-sst.js","/\_mintlify/custom/ab-634991b8/ee8ea0eeb20ecd1e/static/js/gtag-sst.js","/\_mintlify/custom/ab-634991b8/f2b239f3d459dc67/api-sdk-terms-notice.js","/\_mintlify/custom/ab-634991b8/3604035e212f8294/homepage-card-icons.js"\],"subdomain":"ab-634991b8","siteName":"1Password Developer","title":"item - 1Password Developer","relatedPagesConfig":{"enabled":true,"limit":3,"mode":"automatic"},"contextualStarterQuestions":\[{"\_id":"6ae4c9412086b3fba440c7a6","deploymentId":"68a8af9a517ab813d3b84097","questionText":"How do I create a new item?","status":"active","generatedBy":"contextual","path":"cli/reference/management-commands/item","createdAt":"2026-10-30T16:43:45.121Z","updatedAt":"2026-10-30T16:43:45.121Z","\_\_v":0},{"\_id":"6ae4c9412086b3fba440c7a7","deploymentId":"68a8af9a517ab813d3b84097","questionText":"What flags can I use with item create?","status":"active","generatedBy":"contextual","path":"cli/reference/management-commands/item","createdAt":"2026-10-30T16:43:45.121Z","updatedAt":"2026-10-30T16:43:45.121Z","\_\_v":0},{"\_id":"6ae4c9412086b3fba440c7a8","deploymentId":"68a8af9a517ab813d3b84097","questionText":"How do I generate a password?","status":"active","generatedBy":"contextual","path":"cli/reference/management-commands/item","createdAt":"2026-10-30T16:43:45.121Z","updatedAt":"2026-10-30T16:43:45.121Z","\_\_v":0}\],"navMaps":{"firstHrefInVersion":{},"firstHrefInLanguage":{}},"lastModified":"2026-10-30T16:43:21.128Z","originalFileLocation":"cli/reference/management-commands/item.mdx"},"headHtml":"\u003cscript data-mint-head\>(function(){var d=document.documentElement,p=null;if(!p){try{p=localStorage.getItem(\\isDarkMode\\)}catch(e){}if(p==='true')p='dark';else if(p==='false')p='light';if(p!=='light'\u0026\u0026p!=='dark'\u0026\u0026p!=='system')p=\\system\\}var r=p==='system'?(matchMedia(\\(prefers-color-scheme: dark)\\).matches?'dark':'light'):p;d.classList.remove(r==='dark'?'light':'dark');d.classList.add(r);d.setAttribute(\\data-theme-preference\\,p)})();\u003c/script\>\u003cmeta data-mint-head name=\\application-name\\ content=\\1Password Developer\\\>\u003cmeta data-mint-head name=\\generator\\ content=\\Mintlify\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\192x192\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/android-chrome-192x192.png\\ media=\\(prefers-color-scheme: light)\\\>\u003clink data-mint-head rel=\\apple-touch-icon\\ type=\\image/png\\ sizes=\\180x180\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/apple-touch-icon.png\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\16x16\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/favicon-16x16.png\\ media=\\(prefers-color-scheme: light)\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\32x32\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/favicon-32x32.png\\ media=\\(prefers-color-scheme: light)\\\>\u003clink data-mint-head rel=\\shortcut icon\\ type=\\image/x-icon\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/favicon.ico\\ media=\\(prefers-color-scheme: light)\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\192x192\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon-dark/android-chrome-192x192.png\\ media=\\(prefers-color-scheme: dark)\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\16x16\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon-dark/favicon-16x16.png\\ media=\\(prefers-color-scheme: dark)\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\32x32\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon-dark/favicon-32x32.png\\ media=\\(prefers-color-scheme: dark)\\\>\u003clink data-mint-head rel=\\shortcut icon\\ type=\\image/x-icon\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon-dark/favicon.ico\\ media=\\(prefers-color-scheme: dark)\\\>\u003cmeta data-mint-head property=\\og:title\\ content=\\item - 1Password Developer\\\>\u003cmeta data-mint-head property=\\og:description\\ content=\\Learn about the 1Password CLI \u0026#x27;item\u0026#x27; command and its subcommands.\\\>\u003cmeta data-mint-head property=\\og:site_name\\ content=\\1Password Developer\\\>\u003cmeta data-mint-head property=\\og:url\\ content=\\https://www.1password.dev/cli/reference/management-commands/item\\\>\u003cmeta data-mint-head property=\\og:type\\ content=\\website\\\>\u003cmeta data-mint-head property=\\og:image\\ content=\\https://ab-634991b8.mintlify.app/\_mintlify/api/og/v2?division=Management+commands\u0026amp;title=item\u0026amp;theme=0e8ac3e29b6f66038c473d59\u0026amp;signature=e84a967ac60f71dc252739fb69dcf9f8460bf190f3ee2fc8b26dd3b4427adcfd\\\>\u003cmeta data-mint-head property=\\og:image:width\\ content=\\1200\\\>\u003cmeta data-mint-head property=\\og:image:height\\ content=\\630\\\>\u003cmeta data-mint-head name=\\twitter:card\\ content=\\summary_large_image\\\>\u003cmeta data-mint-head name=\\twitter:title\\ content=\\item - 1Password Developer\\\>\u003cmeta data-mint-head name=\\twitter:description\\ content=\\Learn about the 1Password CLI \u0026#x27;item\u0026#x27; command and its subcommands.\\\>\u003cmeta data-mint-head name=\\twitter:image\\ content=\\https://ab-634991b8.mintlify.app/\_mintlify/api/og/v2?division=Management+commands\u0026amp;title=item\u0026amp;theme=0e8ac3e29b6f66038c473d59\u0026amp;signature=e84a967ac60f71dc252739fb69dcf9f8460bf190f3ee2fc8b26dd3b4427adcfd\\\>\u003cmeta data-mint-head name=\\twitter:image:width\\ content=\\1200\\\>\u003cmeta data-mint-head name=\\twitter:image:height\\ content=\\630\\\>\u003cmeta data-mint-head name=\\msapplication-config\\ content=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/browserconfig.xml\\\>\u003cmeta data-mint-head name=\\apple-mobile-web-app-title\\ content=\\1Password Developer\\\>\u003cmeta data-mint-head name=\\msapplication-TileColor\\ content=\\#104ebb\\\>\u003cmeta data-mint-head name=\\google-site-verification\\ content=\\YserOhXnJUjFfIZ4K3qgxkVSlQZQdXtIbBiKzZ35Nvs\\\>\u003clink data-mint-head rel=\\canonical\\ href=\\https://www.1password.dev/cli/reference/management-commands/item\\\>\u003clink data-mint-head rel=\\alternate\\ type=\\application/xml\\ href=\\/sitemap.xml\\\>\u003clink data-mint-head rel=\\alternate\\ type=\\text/markdown\\ href=\\/cli/reference/management-commands/item.md\\\>\u003cscript data-mint-head type=\\application/ld+json\\\>{\\@context\\:\\https://schema.org\\,\\@graph\\:\[{\\@type\\:\\Organization\\,\\@id\\:\\https://www.1password.dev/#organization\\,\\name\\:\\1Password Developer\\,\\url\\:\\https://www.1password.dev\\,\\logo\\:{\\@type\\:\\ImageObject\\,\\url\\:\\https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max\u0026auto=format\u0026n=lHrfVfSCdefFz8U5\u0026q=85\u0026s=29d1c9358888a723dddd8a89a3b6f71d\\}},{\\@type\\:\\WebSite\\,\\@id\\:\\https://www.1password.dev#website\\,\\name\\:\\1Password Developer\\,\\url\\:\\https://www.1password.dev\\,\\publisher\\:{\\@id\\:\\https://www.1password.dev/#organization\\}},{\\@type\\:\\WebPage\\,\\@id\\:\\https://www.1password.dev/cli/reference/management-commands/item#webpage\\,\\url\\:\\https://www.1password.dev/cli/reference/management-commands/item\\,\\name\\:\\item\\,\\dateModified\\:\\2026-10-30T16:43:21.128Z\\,\\isPartOf\\:{\\@id\\:\\https://www.1password.dev#website\\},\\breadcrumb\\:{\\@id\\:\\https://www.1password.dev/cli/reference/management-commands/item#breadcrumb\\}},{\\@type\\:\\BreadcrumbList\\,\\@id\\:\\https://www.1password.dev/cli/reference/management-commands/item#breadcrumb\\,\\itemListElement\\:\[{\\@type\\:\\ListItem\\,\\position\\:1,\\name\\:\\CLI\\,\\item\\:\\https://www.1password.dev/cli\\},{\\@type\\:\\ListItem\\,\\position\\:2,\\name\\:\\Reference\\,\\item\\:\\https://www.1password.dev/cli/reference\\},{\\@type\\:\\ListItem\\,\\position\\:3,\\name\\:\\Commands\\,\\item\\:\\https://www.1password.dev/cli/reference/management-commands/account\\},{\\@type\\:\\ListItem\\,\\position\\:4,\\name\\:\\Management commands\\,\\item\\:\\https://www.1password.dev/cli/reference/management-commands/account\\},{\\@type\\:\\ListItem\\,\\position\\:5,\\name\\:\\item\\,\\item\\:\\https://www.1password.dev/cli/reference/management-commands/item\\}\]},{\\@type\\:\[\\Article\\,\\TechArticle\\\],\\@id\\:\\https://www.1password.dev/cli/reference/management-commands/item#article\\,\\headline\\:\\item\\,\\name\\:\\item\\,\\url\\:\\https://www.1password.dev/cli/reference/management-commands/item\\,\\mainEntityOfPage\\:{\\@id\\:\\https://www.1password.dev/cli/reference/management-commands/item#webpage\\},\\dateModified\\:\\2026-10-30T16:43:21.128Z\\,\\publisher\\:{\\@id\\:\\https://www.1password.dev/#organization\\},\\isPartOf\\:{\\@id\\:\\https://www.1password.dev#website\\}}\]}\u003c/script\>","siteName":"1Password Developer","nav":{"global":null,"tabs":\[{"tab":"Get Started","pages":\[{"title":"Get Started","href":"/get-started"}\]},{"tab":"Tutorials","pages":\[{"title":"Tutorials","href":"/tutorials"}\]},{"tab":"Security for AI","pages":\[{"title":"Security for AI","href":"/security-for-ai"}\]},{"tab":"Environments","pages":\[{"title":"Environments","href":"/environments"}\]},{"tab":"SSH \u0026 Git","pages":\[{"title":"SSH \u0026 Git","href":"/ssh"}\]},{"tab":"CLI","groups":\[{"group":"CLI","pages":\[{"title":"1Password CLI","sidebarTitle":"Overview","href":"/cli"},{"title":"Use cases","sidebarTitle":"Use cases","href":"/cli/use-cases"},{"title":"Get started with 1Password CLI","sidebarTitle":"Get started","href":"/cli/get-started"},{"group":"Guides","pages":\[{"group":"Load secrets","pages":\[{"title":"Load secrets into the environment","sidebarTitle":"Load secrets into the environment","href":"/cli/secrets-environment-variables"},{"title":"Load secrets into config files","sidebarTitle":"Inject secrets into config files","href":"/cli/secrets-config-files"},{"title":"Load secrets into scripts","sidebarTitle":"Load secrets into scripts","href":"/cli/secrets-scripts"},{"title":"Use secret references with 1Password CLI","sidebarTitle":"Use secret references with 1Password CLI","href":"/cli/secret-references"}\]},{"group":"Manage items","pages":\[{"title":"Create items","sidebarTitle":"Create items","href":"/cli/item-create"},{"title":"Edit items","sidebarTitle":"Edit items","href":"/cli/item-edit"},{"title":"Manage SSH keys","sidebarTitle":"Manage SSH keys","href":"/cli/ssh-keys"}\]},{"group":"Manage team members","pages":\[{"title":"Add and remove team members","sidebarTitle":"Add and remove team members","href":"/cli/provision-users"},{"title":"Grant and revoke vault permissions","sidebarTitle":"Grant and revoke vault permissions","href":"/cli/grant-revoke-vault-permissions"},{"title":"Recover accounts using 1Password CLI","sidebarTitle":"Recover accounts","href":"/cli/recover-users"}\]}\]},{"group":"Reference","pages":\[{"title":"1Password CLI reference","sidebarTitle":"Overview","href":"/cli/reference"},{"title":"1Password CLI best practices","sidebarTitle":"Best practices","href":"/cli/best-practices"},{"group":"Commands","pages":\[{"group":"Management commands","pages":\[{"title":"account","sidebarTitle":"account","href":"/cli/reference/management-commands/account"},{"title":"connect","sidebarTitle":"connect","href":"/cli/reference/management-commands/connect"},{"title":"document","sidebarTitle":"document","href":"/cli/reference/management-commands/document"},{"title":"environment","href":"/cli/reference/management-commands/environment"},{"title":"events-api","sidebarTitle":"events-api","href":"/cli/reference/management-commands/events-api"},{"title":"group","sidebarTitle":"group","description":null,"href":"/cli/reference/management-commands/group"},{"title":"item","sidebarTitle":"item","href":"/cli/reference/management-commands/item"},{"title":"plugin","sidebarTitle":"plugin","description":null,"href":"/cli/reference/management-commands/plugin"},{"title":"service-account","sidebarTitle":"service-account","href":"/cli/reference/management-commands/service-account"},{"title":"user","sidebarTitle":"user","href":"/cli/reference/management-commands/user"},{"title":"vault","sidebarTitle":"vault","href":"/cli/reference/management-commands/vault"}\]},{"group":"General commands","pages":\[{"title":"completion","sidebarTitle":"completion","href":"/cli/reference/commands/completion"},{"title":"inject","sidebarTitle":"inject","href":"/cli/reference/commands/inject"},{"title":"read","sidebarTitle":"read","href":"/cli/reference/commands/read"},{"title":"run","sidebarTitle":"run","href":"/cli/reference/commands/run"},{"title":"signin","sidebarTitle":"signin","href":"/cli/reference/commands/signin"},{"title":"signout","sidebarTitle":"signout","href":"/cli/reference/commands/signout"},{"title":"update","sidebarTitle":"update","href":"/cli/reference/commands/update"},{"title":"whoami","sidebarTitle":"whoami","href":"/cli/reference/commands/whoami"}\]}\]},{"group":"Concepts","pages":\[{"title":"1Password CLI environment variables","sidebarTitle":"Environment variables","href":"/cli/environment-variables"},{"title":"Item fields","sidebarTitle":"Item fields","href":"/cli/item-fields"},{"title":"Item JSON template","sidebarTitle":"Item JSON template","href":"/cli/item-template-json"},{"title":"Secret reference syntax","sidebarTitle":"Secret reference syntax","href":"/cli/secret-reference-syntax"},{"title":"Template syntax","sidebarTitle":"Template syntax","href":"/cli/secrets-template-syntax"},{"title":"About vault permissions","sidebarTitle":"Vault permissions","href":"/cli/vault-permissions"},{"title":"User states","sidebarTitle":"User states","href":"/cli/user-states"}\]},{"title":"Use 1Password CLI with Connect","sidebarTitle":"Use with Connect","href":"/cli/connect"},{"title":"1Password app integration security","sidebarTitle":"1Password app integration security","href":"/cli/app-integration-security"}\]},{"group":"Configuration","pages":\[{"group":"Install","pages":\[{"title":"Get started with 1Password CLI","sidebarTitle":"Get started","href":"/cli/get-started"},{"sidebarTitle":"Verify installer","title":"Verify the authenticity of 1Password CLI","href":"/cli/verify"},{"title":"Install 1Password CLI on a server","sidebarTitle":"Install on a server","href":"/cli/install-server"},{"sidebarTitle":"Set configuration directories","title":"How 1Password CLI detects configuration directories","href":"/cli/config-directories"}\]},{"group":"Sign in","pages":\[{"title":"Use the 1Password desktop app to sign in to 1Password CLI","sidebarTitle":"Sign in using the app","href":"/cli/app-integration"},{"title":"Sign in to your 1Password account manually","sidebarTitle":"Sign in manually","href":"/cli/sign-in-manually"},{"title":"Unlock 1Password CLI with SSO","sidebarTitle":"Sign in with SSO","href":"/cli/sign-in-sso"},{"title":"Unlock 1Password CLI with Microsoft","sidebarTitle":"Sign in with Microsoft","href":"/cli/sign-in-sso-azure"},{"title":"Use multiple 1Password accounts with 1Password CLI","sidebarTitle":"Use multiple accounts","href":"/cli/use-multiple-accounts"}\]},{"title":"Update to the latest version of 1Password CLI","sidebarTitle":"Check for updates","href":"/cli/reference/update"},{"title":"Upgrade to 1Password CLI 2","sidebarTitle":"Upgrade from an earlier version","href":"/cli/upgrade"},{"sidebarTitle":"Uninstall","title":"Uninstall 1Password CLI","href":"/cli/uninstall"}\]},{"title":"Example scripts","sidebarTitle":"Example scripts","href":"/cli/scripts"},{"title":"Release notes","url":"https://app-updates.agilebits.com/product_history/CLI2","href":"/cli/release-notes"}\]}\]},{"tab":"SDKs","pages":\[{"title":"SDKs","href":"/sdks"}\]},{"tab":"More Tools","menu":\[{"item":"VS Code","icon":"laptop","pages":\[{"title":"VS Code","href":"/vscode"}\]},{"item":"Shell Plugins","icon":"puzzle-piece","pages":\[{"title":"Shell Plugins","href":"/cli/shell-plugins"}\]},{"item":"Integrations","icon":"puzzle","pages":\[{"title":"Integrations","href":"/integrations"}\]},{"item":"Secrets Automation","icon":"tablet-screen","pages":\[{"title":"Secrets Automation","href":"/secrets-automation"}\]},{"item":"Events API","icon":"sensor-triangle-exclamation","pages":\[{"title":"Events API","href":"/events-api"}\]},{"item":"Users API","icon":"id-badge","pages":\[{"title":"Users API","href":"/users-api"}\]},{"item":"SaaS Manager API","icon":"chart-line","pages":\[{"title":"SaaS Manager API","href":"/saas-manager-api"}\]},{"item":"Partnership API","icon":"users","pages":\[{"title":"Partnership API","href":"/partnership-api/reference"}\]},{"item":"Accounts API","icon":"user-gear","pages":\[{"title":"Accounts API","href":"/accounts-api"}\]},{"item":"Web Development","icon":"code","pages":\[{"title":"Web Development","href":"/web/add-1password-button-website"}\]},{"item":"Developer Watchtower","icon":"tower-control","pages":\[{"title":"Developer Watchtower","href":"/watchtower"}\]}\],"pages":\[{"title":"More Tools","href":"/vscode"}\]},{"tab":"Agentic Autofill partner guide","hidden":true,"pages":\[{"title":"Agentic Autofill partner guide","href":"/agentic-autofill/partners"}\]}\]},"basePath":"","title":"item - 1Password Developer","buildId":"dpl_DeHjVRGfFnhYQwHnfC2pjeXXv8h9","deploymentId":"dpl_DeHjVRGfFnhYQwHnfC2pjeXXv8h9","dynamics":\["10e4515597"\],"chunks":\["BannerMarkdown-CX_qQQOL.js","dist-BTZUMDnx.js","lib-DuNMoZ05.js","lib-B8HbPgcC.js","clsx-xpJZXxdP.js","html-void-elements-mCSPHezU.js","katex-YMM-FMeD.js","marked.esm-CZWythHk.js"\]}
