> Source: https://www.1password.dev/cli/upgrade/



Install and sign in


# Upgrade to 1Password CLI 2


### <a href="#about-1password-cli-2" class="anchor-link" aria-label="Navigate to header: About 1Password CLI 2"></a><span id="_R_59deehkd74t9_" class="cursor-pointer">About 1Password CLI 2</span>


#### <a href="#new-schema" class="anchor-link" aria-label="Navigate to header: New schema"></a><span id="_R_b9deehkd74t9_" class="cursor-pointer">New schema</span>


- <a href="/cli/reference/management-commands/vault/" class="link">vault</a>
- <a href="/cli/reference/management-commands/item/" class="link">item</a>
- <a href="/cli/reference/management-commands/document/" class="link">document</a>
- <a href="/cli/reference/management-commands/user/" class="link">user</a>
- <a href="/cli/reference/management-commands/group/" class="link">group</a>
- <a href="/cli/reference/management-commands/account/" class="link">account</a>
- <a href="/cli/reference/management-commands/connect/" class="link">connect</a>
- <a href="/cli/reference/management-commands/events-api/" class="link">events-api</a>


- The default output is now a human-friendly, tabular schema.  
  <span class="small">[Learn how to change the default output to JSON.](#json-default)</span>
- The JSON output schema now contains more useful information.
- Improved stdin processing allows you to chain more commands together.
- The new schema uses flags instead of positional arguments.

#### <a href="#secrets-provisioning" class="anchor-link" aria-label="Navigate to header: Secrets provisioning"></a><span id="_R_l9deehkd74t9_" class="cursor-pointer">Secrets provisioning</span>


#### <a href="#integrate-1password-cli-with-the-1password-desktop-app" class="anchor-link" aria-label="Navigate to header: Integrate 1Password CLI with the 1Password desktop app"></a><span id="_R_p9deehkd74t9_" class="cursor-pointer">Integrate 1Password CLI with the 1Password desktop app</span>


#### <a href="#shell-plugins" class="anchor-link" aria-label="Navigate to header: Shell plugins"></a><span id="_R_t9deehkd74t9_" class="cursor-pointer">Shell plugins</span>


#### <a href="#package-manager-installation" class="anchor-link" aria-label="Navigate to header: Package manager installation"></a><span id="_R_119deehkd74t9_" class="cursor-pointer">Package manager installation</span>


## <a href="#step-1-choose-an-upgrade-strategy" class="anchor-link" aria-label="Navigate to header: Step 1: Choose an upgrade strategy"></a><span id="_R_199deehkd74t9_" class="cursor-pointer">Step 1: Choose an upgrade strategy</span>


### <a href="#upgrade-immediately" class="anchor-link" aria-label="Navigate to header: Upgrade immediately"></a><span id="_R_1d9deehkd74t9_" class="cursor-pointer">Upgrade immediately</span>


1.  <span data-as="p">Use `which op` (or `(Get-Command op).Path` on Windows) to get the directory of the current installation.</span>
2.  <span data-as="p"><a href="https://app-updates.agilebits.com/product_history/CLI2" class="link" target="_blank" rel="noreferrer">Download 1Password CLI 2</a> and move `op` to the same directory, overwriting the existing copy.</span>
3.  <span data-as="p">To verify the installation, check the version number:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="1" language="shellscript">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_faoph9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_fioph9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_fqoph9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_coph9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    op --version
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>
4.  <span data-as="p"><a href="#step-2-update-your-scripts" class="link">Update your scripts to use the 1Password CLI 2 syntax.</a></span>


### <a href="#upgrade-gradually" class="anchor-link" aria-label="Navigate to header: Upgrade gradually"></a><span id="_R_1l9deehkd74t9_" class="cursor-pointer">Upgrade gradually</span>


#### <a href="#use-docker-to-upgrade-individual-projects" class="anchor-link" aria-label="Navigate to header: Use Docker to upgrade individual projects"></a><span id="_R_1p9deehkd74t9_" class="cursor-pointer">Use Docker to upgrade individual projects</span>


1.  <span data-as="p"><a href="https://hub.docker.com/r/1password/op" class="link" target="_blank" rel="noreferrer">Use the 1Password CLI Docker image</a> or use your own image and <a href="/cli/get-started/" class="link">add the CLI</a>. Your Dockerfile should look like this:</span>
    <div class="code-block mt-5 mb-8 not-prose rounded-2xl relative group min-w-0 print:print-color-exact text-gray-950 dark:text-gray-50 codeblock-light border border-gray-950/10 dark:border-white/10 dark:twoslash-dark bg-transparent dark:bg-transparent" has-floating-buttons="" numberoflines="4" language="text">

    <div class="absolute top-3 right-4 flex items-center gap-1.5 print:hidden" floating-buttons="true">

    <div id="base-ui-_R_7lc9t9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    <div id="base-ui-_R_7pc9t9deehkd74t9_" class="code-block-copy-button z-10 select-none" base-ui-tooltip-trigger="">

    <span class="sr-only" role="status"></span>

    </div>

    <div id="base-ui-_R_7tc9t9deehkd74t9_" class="z-10 select-none" base-ui-tooltip-trigger="">

    </div>

    </div>

    <div class="w-0 min-w-full max-w-full h-full dark:bg-codeblock text-sm leading-6 transition-[height] duration-300 ease-in-out code-block-background **:ring-0 **:outline-0 **:focus:ring-0 **:focus:outline-0 rounded-2xl bg-white" role="presentation" style="position:relative;--scroll-area-corner-height:0px;--scroll-area-corner-width:0px;font-variant-ligatures:none;height:auto;background-color:#ffffff;--shiki-dark-bg:#0B0C0E" component-part="code-block-root">

    <div class="size-full rounded-[inherit] [--scroll-area-fade-size:32px] py-3.5 px-4 focus-visible:outline-1! focus-visible:-outline-offset-2 focus-visible:outline-primary dark:focus-visible:outline-primary-light overflow-y-hidden! base-ui-disable-scrollbar" data-id="base-ui-_R_6c9t9deehkd74t9_-viewport" tabindex="0" style="overflow:scroll" component-part="scroll-area-viewport">

    <div class="min-w-full! h-full children:my-0! children:shadow-none! children:bg-transparent!" role="presentation" style="min-width:fit-content" component-part="scroll-area-content">

    <div class="font-mono whitespace-pre leading-6">

    ``` shiki
    FROM 1password/op:2
    COPY ./your-script.sh /your-script.sh
    CMD ["/your-script.sh"]
    ```

    </div>

    </div>

    </div>

    </div>

    <div class="code-block-fade-overlay print:hidden" fade-overlay="true" aria-hidden="true" style="--fade-color-light:#ffffff;--fade-color-dark:#0B0C0E">

    </div>

    </div>
2.  <span data-as="p">After upgrading to 1Password CLI 2, <a href="#step-2-update-your-scripts" class="link">update your scripts</a> to use the new command syntax.</span>


#### <a href="#use-both-versions-of-1password-cli" class="anchor-link" aria-label="Navigate to header: Use both versions of 1Password CLI"></a><span id="_R_219deehkd74t9_" class="cursor-pointer">Use both versions of 1Password CLI</span>


1.  Rename the earlier version of 1Password CLI `op1`.
2.  Find and replace all occurences of `op` with `op1`.
3.  Install <a href="https://app-updates.agilebits.com/product_history/CLI2" class="link" target="_blank" rel="noreferrer">1Password CLI 2</a> inside your `$PATH`.


For Linux, it is recommended to be moved to `/usr/local/bin/op`.</span>


4.  <a href="#step-2-update-your-scripts" class="link">Update your scripts</a> one-by-one to use the new `op`. You can continue to use your current scripts with the earlier version of 1Password CLI installed as `op1`.
5.  When you’ve updated all your scripts and are ready to upgrade, uninstall the earlier version of 1Password CLI.
6.  Find and replace all occurrences of `op1` in your scripts to `op`.

## <a href="#step-2-update-your-scripts" class="anchor-link" aria-label="Navigate to header: Step 2: Update your scripts"></a><span id="_R_2d9deehkd74t9_" class="cursor-pointer">Step 2: Update your scripts</span>


<table class="m-0 min-w-full w-full max-w-none table [&amp;_th]:text-left [&amp;_td[data-numeric]]:tabular-nums [&amp;_td]:min-w-[150px]">
<colgroup>
<col style="width: 33%" />
<col style="width: 33%" />
<col style="width: 33%" />
</colgroup>
<thead>
<tr>
<th>Old command</th>
<th>CLI 2 command</th>
<th>Notes</th>
</tr>
</thead>
<tbody>
<tr>
<td><a href="/cli/v1/reference/#create-vault" class="link">create vault</a></td>
<td><a href="/cli/reference/management-commands/vault/#vault-create" class="link">vault create</a></td>
<td></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#get-vault" class="link">get vault</a></td>
<td><a href="/cli/reference/management-commands/vault/#vault-get" class="link">vault get</a></td>
<td></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#edit-vault" class="link">edit vault</a></td>
<td><a href="/cli/reference/management-commands/vault/#vault-edit" class="link">vault edit</a></td>
<td><code>--travel-mode=on/off</code> flag introduced</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#delete-vault" class="link">delete vault</a></td>
<td><a href="/cli/reference/management-commands/vault/#vault-delete" class="link">vault delete</a></td>
<td>allows piped input when the <code>-</code> argument is provided</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#list-vaults" class="link">list vaults</a></td>
<td><a href="/cli/reference/management-commands/vault/#vault-list" class="link">vault list</a></td>
<td><ul>
<li>by default, lists vaults you have read access to</li>
<li>to see all the vaults you can manage, include <code>--permission manage</code></li>
</ul></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#list-users" class="link">list users —vault</a></td>
<td><a href="/cli/reference/management-commands/vault/#vault-user-list" class="link">vault user list</a></td>
<td></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#add-group" class="link">add group</a></td>
<td><a href="/cli/reference/management-commands/vault/#vault-group-grant" class="link">vault group grant</a></td>
<td><ul>
<li><code>--permission</code> flag must be used to specify the permissions to grant</li>
<li>granting allow_viewing, allow_editing and allow_managing is equivalent to granting all permissions</li>
<li><code>group</code> and <code>vault</code> arguments changed to <code>--group</code> and <code>--vault</code> flags</li>
</ul></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#remove-group" class="link">remove group</a></td>
<td><a href="/cli/reference/management-commands/vault/#vault-group-revoke" class="link">vault group revoke</a></td>
<td><ul>
<li><code>--permission</code> flag must be used to specify the permissions to revoke</li>
<li>revoking allow_viewing, allow_editing, and allow_managing is equivalent to revoking all permissions</li>
<li><code>group</code> and <code>vault</code> arguments changed to <code>--group</code> and <code>--vault</code> flags</li>
</ul></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#add-user" class="link">add user</a> &lt;user&gt; &lt;vault&gt;</td>
<td><a href="/cli/reference/management-commands/vault/#vault-user-grant" class="link">vault user grant</a></td>
<td><ul>
<li><code>--permission</code> flag must be used to specify the permissions to grant</li>
<li>granting allow_viewing, allow_editing and allow_managing is equivalent to granting all permissions</li>
<li><code>user</code> and <code>vault</code> arguments changed to <code>--user</code> and <code>--vault</code> flags</li>
</ul></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#remove-user" class="link">remove user</a> &lt;user&gt; &lt;vault&gt;</td>
<td><a href="/cli/reference/management-commands/vault/#vault-user-revoke" class="link">vault user revoke</a></td>
<td><ul>
<li><code>--permission</code> flag must be used to specify the permissions to revoke</li>
<li>revoking allow_viewing, allow_editing and allow_managing is equivalent to revoking all permissions</li>
<li><code>user</code> and <code>vault</code> arguments changed to <code>--user</code> and <code>--vault</code> flags</li>
</ul></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#signin" class="link">signin</a> &lt;url&gt;</td>
<td><a href="/cli/reference/management-commands/account/#account-add" class="link">account add</a></td>
<td><ul>
<li>for new accounts/urls</li>
<li>the password can be piped in if email, address, and secret key are provided via flag</li>
</ul></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#signin" class="link">signin</a> —list</td>
<td><a href="/cli/reference/management-commands/account/#account-list" class="link">account list</a></td>
<td>account list will format its output based on output format selection (JSON vs human readable)</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#forget" class="link">forget account</a></td>
<td><a href="/cli/reference/management-commands/account/#account-forget" class="link">account forget</a></td>
<td>new <code>-—all</code> flag for forgetting all accounts</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#get-account" class="link">get account</a></td>
<td><a href="/cli/reference/management-commands/account/#account-get" class="link">account get</a></td>
<td></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#confirm" class="link">confirm user</a></td>
<td><a href="/cli/reference/management-commands/user/#user-confirm" class="link">user confirm</a></td>
<td>allows piped input when the <code>-</code> argument is provided</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#create-user" class="link">create user</a></td>
<td><a href="/cli/reference/management-commands/user/#user-provision" class="link">user provision</a></td>
<td><code>email</code> and <code>name</code> arguments changed to <code>--email</code> and <code>--name</code> flags</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#delete-user" class="link">delete user</a></td>
<td><a href="/cli/reference/management-commands/user/#user-delete" class="link">user delete</a></td>
<td>allows piped input when the <code>-</code> argument is provided</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#edit-user" class="link">edit user</a></td>
<td><a href="/cli/reference/management-commands/user#user-edit" class="link">user edit</a></td>
<td>allows piped input when the <code>-</code> argument is provided</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#reactivate" class="link">reactivate user</a></td>
<td><a href="/cli/reference/management-commands/user/#user-reactivate" class="link">user reactivate</a></td>
<td>allows piped input when the <code>-</code> argument is provided</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#suspend" class="link">suspend user</a></td>
<td><a href="/cli/reference/management-commands/user/#user-suspend" class="link">user suspend</a></td>
<td><code>--deauthorize-devices-after</code> flag accepts any duration unit, not just seconds</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#list-users" class="link">list users</a></td>
<td><a href="/cli/reference/management-commands/user#user-list" class="link">user list</a></td>
<td></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#get-user" class="link">get user</a></td>
<td><a href="/cli/reference/management-commands/user/#user-get" class="link">user get</a></td>
<td><ul>
<li>added <code>-—me</code> flag to get the currently authenticated user</li>
<li><code>—publickey</code> changed to <code>—public-key</code></li>
</ul></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#create-connect-server" class="link">create connect server</a></td>
<td><a href="/cli/reference/management-commands/connect/#connect-server-create" class="link">connect server create</a></td>
<td>add <code>—-server</code> flag instead of using an argument for specifying the related server</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#delete-connect-server" class="link">delete connect server</a></td>
<td><a href="/cli/reference/management-commands/connect/#connect-server-delete" class="link">connect server delete</a></td>
<td>allows piped input when the <code>-</code> argument is provided</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#edit-connect-server" class="link">edit connect server</a></td>
<td><a href="/cli/reference/management-commands/connect/#connect-server-edit" class="link">connect server edit</a></td>
<td></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#list-connect-servers" class="link">list connect servers</a></td>
<td><a href="/cli/reference/management-commands/connect/#connect-server-list" class="link">connect server list</a></td>
<td></td>
</tr>
<tr>
<td data-numeric="true">-</td>
<td><a href="/cli/reference/management-commands/connect/#connect-server-get" class="link">connect server get</a></td>
<td></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#create-connect-token" class="link">create connect token</a></td>
<td><a href="/cli/reference/management-commands/connect/#connect-token-create" class="link">connect token create</a></td>
<td></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#delete-connect-token" class="link">delete connect token</a></td>
<td><a href="/cli/reference/management-commands/connect/#connect-token-delete" class="link">connect token delete</a></td>
<td></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#edit-connect-token" class="link">edit connect token</a></td>
<td><a href="/cli/reference/management-commands/connect/#connect-token-edit" class="link">connect token edit</a></td>
<td>argument name changed from <code>jti</code> to <code>token</code></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#list-connect-tokens" class="link">list connect tokens</a></td>
<td><a href="/cli/reference/management-commands/connect/#connect-token-list" class="link">connect token list</a></td>
<td>ConnectVault.ACL is now displayed in lowercase_with_underscores</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#add-connect-server" class="link">add connect server</a></td>
<td><a href="/cli/reference/management-commands/connect/#connect-vault-grant" class="link">connect vault grant</a></td>
<td><code>server</code> and <code>vault</code> arguments changed to <code>--server</code> and <code>--vault</code> flags</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#remove-connect-server" class="link">remove connect server</a></td>
<td><a href="/cli/reference/management-commands/connect/#connect-vault-revoke" class="link">connect vault revoke</a></td>
<td><code>server</code> and <code>vault</code> arguments changed to <code>--server</code> and <code>--vault</code> flags</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#manage-connect-add" class="link">manage connect add group</a></td>
<td><a href="/cli/reference/management-commands/connect/#connect-group-grant" class="link">connect group grant</a></td>
<td><code>server</code> and <code>group</code> arguments changed to <code>--server</code> and <code>--group</code> flags</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#manage-connect-remove" class="link">manage connect remove group</a></td>
<td><a href="/cli/reference/management-commands/connect/#connect-group-revoke" class="link">connect group revoke</a></td>
<td><code>server</code> and <code>group</code> arguments changed to <code>--server</code> and <code>--group</code> flags</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#create-item" class="link">create item</a></td>
<td><a href="/cli/reference/management-commands/item/#item-create" class="link">item create</a></td>
<td><ul>
<li><code>--template</code> flag to specify item template file replaces encode item as an argument</li>
<li><code>category</code> argument changed to <code>--category</code> flag</li>
<li>Template JSON format has changed. <a href="#appendix-json" class="link">Learn more about the new format.</a></li>
</ul></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#delete-item" class="link">delete item</a></td>
<td><a href="/cli/reference/management-commands/item/#item-delete" class="link">item delete</a></td>
<td>allows piped input when the <code>-</code> argument is provided</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#edit-item" class="link">edit item</a></td>
<td><a href="/cli/reference/management-commands/item/#item-edit" class="link">item edit</a></td>
<td>new <code>--tags</code>, <code>--title</code>, <code>--url</code> flags</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#get-item" class="link">get item</a></td>
<td><a href="/cli/reference/management-commands/item/#item-get" class="link">item get</a></td>
<td></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#list-items" class="link">list items</a></td>
<td><a href="/cli/reference/management-commands/item/#item-list" class="link">item list</a></td>
<td></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#list-templates" class="link">list templates</a></td>
<td><a href="/cli/reference/management-commands/item/#item-template-list" class="link">item template list</a></td>
<td></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#get-template" class="link">get template</a></td>
<td><a href="/cli/reference/management-commands/item/#item-template-get" class="link">item template get</a></td>
<td></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#create-group" class="link">create group</a></td>
<td><a href="/cli/reference/management-commands/group/#group-create" class="link">group create</a></td>
<td></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#delete-group" class="link">delete group</a></td>
<td><a href="/cli/reference/management-commands/group/#group-delete" class="link">group delete</a></td>
<td>allows piped input when the <code>-</code> argument is provided</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#edit-group" class="link">edit group</a></td>
<td><a href="/cli/reference/management-commands/group/#group-edit" class="link">group edit</a></td>
<td>allows piped input when the <code>-</code> argument is provided</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#list-groups" class="link">list groups</a></td>
<td><a href="/cli/reference/management-commands/group/#group-list" class="link">group list</a></td>
<td></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#get-group" class="link">get group</a></td>
<td><a href="/cli/reference/management-commands/group/#group-get" class="link">group get</a></td>
<td></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#add-user" class="link">add user</a> &lt;user&gt; &lt;group&gt;</td>
<td><a href="/cli/reference/management-commands/group/#group-user-grant" class="link">group user grant</a></td>
<td><code>user</code> and <code>group</code> arguments changed to <code>--user</code> and <code>--group</code> flags</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#remove-user" class="link">remove user</a> &lt;user&gt; &lt;group&gt;</td>
<td><a href="/cli/reference/management-commands/group/#group-user-revoke" class="link">group user revoke</a></td>
<td><code>user</code> and <code>group</code> args changed to <code>--user</code> and <code>--group</code> flags</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#list-users" class="link">op list users —group &lt;group&gt;</a></td>
<td><a href="/cli/reference/management-commands/group/#group-user-list" class="link">group user list</a></td>
<td>op list users <code>--group GROUP</code> still works</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#delete-trash" class="link">delete trash</a></td>
<td data-numeric="true">-</td>
<td>deprecated</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#create-document" class="link">create document</a></td>
<td><a href="/cli/reference/management-commands/document/#document-create" class="link">document create</a></td>
<td><code>--filename</code> flag changed to <code>--file-name</code> flag</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#edit-document" class="link">edit document</a></td>
<td><a href="/cli/reference/management-commands/document/#document-edit" class="link">document edit</a></td>
<td><code>--filename</code> flag changed to <code>--file-name</code> flag</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#list-documents" class="link">list documents</a></td>
<td><a href="/cli/reference/management-commands/document/#document-list" class="link">document list</a></td>
<td></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#get-document" class="link">get document</a></td>
<td><a href="/cli/reference/management-commands/document/#document-get" class="link">document get</a></td>
<td></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#delete-document" class="link">delete document</a></td>
<td><a href="/cli/reference/management-commands/document/#document-delete" class="link">document delete</a></td>
<td></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#create-integration-events-api" class="link">create integration events-api</a></td>
<td><a href="/cli/reference/management-commands/events-api/#events-api-create" class="link">events-api create</a></td>
<td></td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#list-events" class="link">list events</a></td>
<td data-numeric="true">-</td>
<td>Use <a href="/events-api/" class="link">1Password Events API</a> instead.</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#encode" class="link">encode</a></td>
<td data-numeric="true">-</td>
<td>deprecated, use <code>create item --template=file.json</code> instead</td>
</tr>
<tr>
<td><a href="/cli/v1/reference/#get-totp" class="link">get totp</a></td>
<td><a href="/cli/reference/management-commands/item/#item-get" class="link">item get —otp</a></td>
<td></td>
</tr>
</tbody>
</table>


## <a href="#appendix-change-default-output-to-json" class="anchor-link" aria-label="Navigate to header: Appendix: Change default output to JSON"></a><span id="_R_2l9deehkd74t9_" class="cursor-pointer">Appendix: Change default output to JSON</span>


- For a single command, include the `--format json` flag with your command. For example, `op item get <name> --format json`.
- To always default to JSON, set the `$OP_FORMAT` environment variable to `json`.

## <a href="#appendix-json" class="anchor-link" aria-label="Navigate to header: Appendix: Item JSON template"></a><span id="_R_2r9deehkd74t9_" class="cursor-pointer">Appendix: Item JSON template</span>


``` shiki
{
  "fields": [
    {
      "designation": "username",
      "name": "username",
      "type": "T",
      "value": ""
    },
    {
      "designation": "password",
      "name": "password",
      "type": "P",
      "value": ""
    }
  ],
  "notesPlain": "",
  "passwordHistory": [],
  "sections": []
}
```


``` shiki
{
  "title": "",
  "category": "LOGIN",
  "fields": [
    {
      "id": "username",
      "type": "STRING",
      "purpose": "USERNAME",
      "label": "username",
      "value": ""
    },
    {
      "id": "password",
      "type": "CONCEALED",
      "purpose": "PASSWORD",
      "label": "password",
      "value": ""
    },
    {
      "id": "notesPlain",
      "type": "STRING",
      "purpose": "NOTES",
      "label": "notesPlain",
      "value": ""
    }
  ]
}
```


| 1Password CLI 1 | 1Password CLI 2 | Notes                               |
|-----------------|-----------------|-------------------------------------|
| `uuid`          |                 |                                     |
| `templateUuid`  | `category`      |                                     |
| `details`       | \-              | replaced by `sections` and `fields` |


| 1Password CLI 1 | 1Password CLI 2 | Notes            |
|-----------------|-----------------|------------------|
| `name`          | `id`            |                  |
| `title`         | `label`         |                  |
| `fields`        | \-              | moved separately |


| 1Password CLI 1 | 1Password CLI 2 |
|-----------------|-----------------|
| `n`             | `id`            |
| `k`             | `type`          |
| `t`             | `label`         |
| `v`             | `value`         |
| \-              | `section`       |


## <a href="#get-help" class="anchor-link" aria-label="Navigate to header: Get help"></a><span id="_R_3f9deehkd74t9_" class="cursor-pointer">Get help</span>


## <a href="#learn-more" class="anchor-link" aria-label="Navigate to header: Learn more"></a><span id="_R_3j9deehkd74t9_" class="cursor-pointer">Learn more</span>

- <a href="/cli/get-started/" class="link">Get started with 1Password CLI 2</a>
- <a href="https://releases.1password.com/developers/cli/" class="link" target="_blank" rel="noreferrer">1Password CLI 2 release notes</a>


Was this page helpful?


