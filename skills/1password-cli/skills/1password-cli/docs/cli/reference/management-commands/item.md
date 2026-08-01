> Source: https://www.1password.dev/cli/reference/management-commands/item/



> ## Documentation Index
>
> Fetch the complete documentation index at: <a href="/llms.txt" tabindex="-1">/llms.txt</a>
>
> Use this file to discover all available pages before exploring further.


<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


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
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_qlggsldd7av5tccsnisnpfiulb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_r5ggsldd7av5tccsnisnpfiulb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_rlggsldd7av5tccsnisnpfiulb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" role="presentation" data-id="base-ui-_R_pggsldd7av5tccsnisnpfiulb_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op item template get --out-file login.json "Login"
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>
2.  <span data-as="p">Edit the template.</span>
3.  <span data-as="p">Create a new item using the `-—template` flag to specify the path to the edited template:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_qlhgsldd7av5tccsnisnpfiulb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_r5hgsldd7av5tccsnisnpfiulb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_rlhgsldd7av5tccsnisnpfiulb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" role="presentation" data-id="base-ui-_R_phgsldd7av5tccsnisnpfiulb_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

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
4.  <span data-as="p">After 1Password CLI creates the item, delete the edited template.</span> <span data-as="p">You can also create an item from standard input using an item JSON template.</span> <span data-as="p">Pass the `-` character as the first argument, followed by any assignment statements.</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_1lb20sldd7av5tccsnisnpfiulb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_1mb20sldd7av5tccsnisnpfiulb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_1nb20sldd7av5tccsnisnpfiulb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" role="presentation" data-id="base-ui-_R_1j20sldd7av5tccsnisnpfiulb_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op item template get Login | op item create --vault personal -
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

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
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" numberoflines="2" language="text">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_qlgi5ldd7av5tccsnisnpfiulb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_r5gi5ldd7av5tccsnisnpfiulb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_rlgi5ldd7av5tccsnisnpfiulb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" role="presentation" data-id="base-ui-_R_pgi5ldd7av5tccsnisnpfiulb_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op item get oldLogin --format=json > updatedLogin.json
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>
2.  <span data-as="p">Edit the file.</span>
3.  <span data-as="p">Use the `--template` flag to specify the path to the edited file and edit the item:</span> <span data-as="p">op item edit oldLogin —template=updatedLogin.json</span>
4.  <span data-as="p">Delete the file.</span> <span data-as="p">You can also edit an item using piped input:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_qlq25ldd7av5tccsnisnpfiulb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_r5q25ldd7av5tccsnisnpfiulb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_rlq25ldd7av5tccsnisnpfiulb_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 overflow-y-hidden! base-ui-disable-scrollbar" role="presentation" data-id="base-ui-_R_pq25ldd7av5tccsnisnpfiulb_-viewport" tabindex="-1" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    cat updatedLogin.json | op item edit oldLogin
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

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


Related topics

<a href="/cli/item-create" class="flex items-center gap-2 rounded-lg py-1.5 text-gray-950 dark:text-gray-50 hover:text-primary dark:hover:text-primary-light"><span class="text-sm tracking-[-0.1px] line-clamp-1">Create items</span></a><a href="/cli/item-edit" class="flex items-center gap-2 rounded-lg py-1.5 text-gray-950 dark:text-gray-50 hover:text-primary dark:hover:text-primary-light"><span class="text-sm tracking-[-0.1px] line-clamp-1">Edit items</span></a><a href="/cli/item-fields" class="flex items-center gap-2 rounded-lg py-1.5 text-gray-950 dark:text-gray-50 hover:text-primary dark:hover:text-primary-light"><span class="text-sm tracking-[-0.1px] line-clamp-1">Item fields</span></a>


Was this page helpful?


<a href="/cli/reference/management-commands/group" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">group</span></a><a href="/cli/reference/management-commands/plugin" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">plugin</span></a>


Responses are generated using AI and may contain mistakes.


<a href="mailto:support@1password.com" class="group flex justify-between items-center gap-1 mt-2 py-1 transition-colors duration-200" data-component-part="contact-support-button"><span data-component-part="contact-support-icon"></span></a>

Contact support


