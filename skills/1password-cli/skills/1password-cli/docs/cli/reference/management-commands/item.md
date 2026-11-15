> Source: https://www.1password.dev/cli/reference/management-commands/item/



Management commands


# item


### <a href="#subcommands" class="anchor-link" aria-label="Navigate to header: Subcommands"></a><span id="_R_39deehkd74t9_" class="min-w-0 break-words cursor-pointer">Subcommands</span>

- <a href="#item-create" class="link">item create</a>: Create an item
- <a href="#item-delete" class="link">item delete</a>: Delete or archive an item
- <a href="#item-edit" class="link">item edit</a>: Edit an item’s details
- <a href="#item-get" class="link">item get</a>: Get an item’s details
- <a href="#item-list" class="link">item list</a>: List items
- <a href="#item-move" class="link">item move</a>: Move an item between vaults
- <a href="#item-share" class="link">item share</a>: Share an item
- <a href="#item-template" class="link">item template</a>: Manage templates

## <a href="#item-create" class="anchor-link" aria-label="Navigate to header: item create"></a><span id="_R_79deehkd74t9_" class="cursor-pointer">item create</span>


``` shiki
op item create [ - ] [ <assignment>... ] [flags]
```


### <a href="#flags" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_d9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


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


#### <a href="#generate-a-password" class="anchor-link" aria-label="Navigate to header: Generate a password"></a><span id="_R_r9deehkd74t9_" class="cursor-pointer">Generate a password</span>


``` shiki
    --generate-password='letters,digits,symbols,32'
```


#### <a href="#set-additional-fields-with-assignment-statements" class="anchor-link" aria-label="Navigate to header: Set additional fields with assignment statements"></a><span id="_R_139deehkd74t9_" class="cursor-pointer">Set additional fields with assignment statements</span>


``` shiki
[<section>.]<field>[[<fieldType>]]=<value>
```


``` shiki
DatabaseCredentials.host[text]=33.166.240.221
```


#### <a href="#create-an-item-using-a-json-template" class="anchor-link" aria-label="Navigate to header: Create an item using a json template"></a><span id="_R_1l9deehkd74t9_" class="cursor-pointer">Create an item using a json template</span>


1.  <span data-as="p">Save the appropriate item category template to a file:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_1tb11p9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_1ub11p9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_1vb11p9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_1j11p9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_1tb31p9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_1ub31p9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_1vb31p9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_1j31p9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_3qm41p9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_3sm41p9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_3um41p9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_3641p9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

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

### <a href="#examples" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_1r9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


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


## <a href="#item-delete" class="anchor-link" aria-label="Navigate to header: item delete"></a><span id="_R_299deehkd74t9_" class="cursor-pointer">item delete</span>


``` shiki
op item delete [{ <itemName> | <itemID> | <shareLink> | - }] [flags]
```


### <a href="#flags-2" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_2f9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--archive        Move the item to the Archive.
--vault string   Look for the item in this vault.
```


#### <a href="#specify-items-on-standard-input" class="anchor-link" aria-label="Navigate to header: Specify items on standard input"></a><span id="_R_2p9deehkd74t9_" class="cursor-pointer">Specify items on standard input</span>


### <a href="#examples-2" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_2v9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
op item delete "Defunct Login"
```


``` shiki
op item delete "Defunct Login" --archive
```


## <a href="#item-edit" class="anchor-link" aria-label="Navigate to header: item edit"></a><span id="_R_399deehkd74t9_" class="cursor-pointer">item edit</span>


``` shiki
op item edit { <itemName> | <itemID> | <shareLink> } [ <assignment> ... ] [flags]
```


### <a href="#flags-3" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_3f9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


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


#### <a href="#edit-an-item-using-assignment-statements" class="anchor-link" aria-label="Navigate to header: Edit an item using assignment statements"></a><span id="_R_3n9deehkd74t9_" class="cursor-pointer">Edit an item using assignment statements</span>


``` shiki
[<section>.]<field>[[<fieldType>]]=<value>
```


#### <a href="#edit-an-item-using-a-template" class="anchor-link" aria-label="Navigate to header: Edit an item using a template"></a><span id="_R_459deehkd74t9_" class="cursor-pointer">Edit an item using a template</span>


1.  <span data-as="p">Get the item you want to edit in JSON format and save it to a file:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="2" language="text">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_1tb14b9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_1ub14b9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_1vb14b9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_1j14b9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

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

    <div id="base-ui-_R_1tbk4b9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_1ubk4b9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_1vbk4b9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_1jk4b9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

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


### <a href="#examples-3" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_4f9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


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


## <a href="#item-get" class="anchor-link" aria-label="Navigate to header: item get"></a><span id="_R_5h9deehkd74t9_" class="cursor-pointer">item get</span>


``` shiki
op item get [{ <itemName> | <itemID> | <shareLink> | - }] [flags]
```


### <a href="#flags-4" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_5n9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--fields strings    Return data from specific fields. Use `label=` to get the field by name or `type=` to filter fields by type. Specify multiple in a comma-separated list.
--include-archive   Include items in the Archive. Can also be set using
                    OP_INCLUDE_ARCHIVE environment variable.
--otp               Output the primary one-time password for this item.
--reveal            Don't conceal sensitive fields.
--share-link        Get a shareable link for the item.
--vault vault       Look for the item in this vault.
```


#### <a href="#specify-items-on-standard-input-2" class="anchor-link" aria-label="Navigate to header: Specify items on standard input"></a><span id="_R_619deehkd74t9_" class="cursor-pointer">Specify items on standard input</span>


#### <a href="#items-in-the-archive" class="anchor-link" aria-label="Navigate to header: Items in the archive"></a><span id="_R_679deehkd74t9_" class="cursor-pointer">Items in the archive</span>


### <a href="#examples-4" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_6b9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


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


## <a href="#item-list" class="anchor-link" aria-label="Navigate to header: item list"></a><span id="_R_759deehkd74t9_" class="cursor-pointer">item list</span>


``` shiki
op item list [flags]
```


### <a href="#flags-5" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_7b9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


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

### <a href="#examples-5" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_7l9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
op item list --tags documentation --format=json | op item get -
```


``` shiki
op item list --categories Login --vault Staging --format=json | op item get - --fields username,password
```


## <a href="#item-move" class="anchor-link" aria-label="Navigate to header: item move"></a><span id="_R_819deehkd74t9_" class="cursor-pointer">item move</span>


``` shiki
op item move [{ <itemName> | <itemID> | <shareLink> | - }] [flags]
```


### <a href="#flags-6" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_899deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--current-vault string       Vault where the item is currently saved.
--destination-vault string   The vault you want to move the item to.
--reveal                     Don't conceal sensitive fields.
```


### <a href="#examples-6" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_8h9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
op item move "My Example Item" --current-vault Private --destination-vault Shared
```


## <a href="#item-share" class="anchor-link" aria-label="Navigate to header: item share"></a><span id="_R_8n9deehkd74t9_" class="cursor-pointer">item share</span>


``` shiki
op item share { <itemName> | <itemID> } [flags]
```


### <a href="#flags-7" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_8t9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--emails strings        Email addresses to share with.
--expires-in duration   Expire link after the duration specified in (s)econds,
                        (m)inutes, (h)ours, (d)ays, and/or (w)eeks. (default 7d)
--vault string          Look for the item in this vault.
--view-once             Expire link after a single view.
```


## <a href="#item-template" class="anchor-link" aria-label="Navigate to header: item template"></a><span id="_R_999deehkd74t9_" class="cursor-pointer">item template</span>

### <a href="#subcommands-2" class="anchor-link" aria-label="Navigate to header: Subcommands"></a><span id="_R_9b9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Subcommands</span>

- <a href="#item-template-get" class="link">item template get</a>: Get an item template
- <a href="#item-template-list" class="link">item template list</a>: Get a list of templates

## <a href="#item-template-get" class="anchor-link" aria-label="Navigate to header: item template get"></a><span id="_R_9f9deehkd74t9_" class="cursor-pointer">item template get</span>


``` shiki
op item template get [{ <category> | - }] [flags]
```


### <a href="#flags-8" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_9l9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


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

## <a href="#item-template-list" class="anchor-link" aria-label="Navigate to header: item template list"></a><span id="_R_9v9deehkd74t9_" class="cursor-pointer">item template list</span>


``` shiki
op item template list [flags]
```


Was this page helpful?


