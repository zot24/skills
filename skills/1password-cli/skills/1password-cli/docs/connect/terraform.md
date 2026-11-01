> Source: https://www.1password.dev/connect/terraform/


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


Integrations


Use the 1Password Terraform provider with Connect


<a href="/get-started" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Get Started</a>


<a href="/tutorials" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Tutorials</a>


<a href="/security-for-ai" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Security for AI</a>


<a href="/environments" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Environments</a>


<a href="/ssh" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SSH &amp; Git</a>


<a href="/cli" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">CLI</a>


<a href="/sdks" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SDKs</a>


More Tools


Integrations


# Use the 1Password Terraform provider with Connect


## 


<a href="#requirements" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <div id="connect-server">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Connect server">

  Connect server

  </div>

  </div>

- <div id="service-account">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Service account">

  Service account

  </div>

  </div>

- <div id="1password-app">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-1Password app">

  1Password app

  </div>

  </div>


- <a href="/connect/get-started/#step-1" class="link">Create a Connect server.</a>


- <a href="/service-accounts/get-started#create-a-service-account" class="link">Create a service account</a>


- Install the latest <a href="https://support.1password.com/betas#install-a-prerelease-version-of-the-1password-app" class="link" target="_blank" rel="noreferrer">beta release</a> of the 1Password desktop app.


If you don’t see the option to update to the latest beta in the app, you can download it directly for <a href="https://releases.1password.com/mac/beta/" class="link" target="_blank" rel="noreferrer">Mac</a>, <a href="https://releases.1password.com/windows/beta/" class="link" target="_blank" rel="noreferrer">Windows</a>, or <a href="https://releases.1password.com/linux/beta/" class="link" target="_blank" rel="noreferrer">Linux</a>.


## 


<a href="#get-started" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <div id="connect-server-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Connect server">

  Connect server

  </div>

  </div>

- <div id="service-account-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Service account">

  Service account

  </div>

  </div>

- <div id="1password-app-2">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-1Password app">

  1Password app

  </div>

  </div>


1.  <span data-as="p">Specify the Connect server token.</span> <span data-as="p">You can set this value with the `OP_CONNECT_TOKEN` environment variable or with the `connect_token` field in the provider configuration.</span>
2.  <span data-as="p">Specify the Connect server hostname, URL, or IP address.</span> <span data-as="p">You can set this value with the `OP_CONNECT_HOST` environment variable or with the `connect_url` field in the provider configuration.</span>


- <div id="mac">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Mac">

  Mac

  </div>

  </div>

- <div id="windows">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Windows">

  Windows

  </div>

  </div>

- <div id="linux">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Linux">

  Linux

  </div>

  </div>


1.  Open and unlock the <a href="https://1password.com/downloads/" class="link" target="_blank" rel="noreferrer">1Password app</a>.
2.  Select your account or collection at the top of the sidebar.
3.  Navigate to **Settings** \> **<a href="onepassword://settings/developers" class="link" target="_blank" rel="noreferrer">Developer</a>**.
4.  Under Developer Integrations, select **Integrate with 1Password SDKs**.
5.  If you want to authenticate with Touch ID, navigate to **Settings** \> **<a href="onepassword://settings/security" class="link" target="_blank" rel="noreferrer">Security</a>**, then turn on **<a href="https://support.1password.com/touch-id-mac/" class="link" target="_blank" rel="noreferrer">Unlock using Touch ID</a>**.


1.  Open and unlock the <a href="https://1password.com/downloads/" class="link" target="_blank" rel="noreferrer">1Password app</a>.
2.  Select your account or collection at the top of the sidebar.
3.  Navigate to **Settings** \> **<a href="onepassword://settings/developers" class="link" target="_blank" rel="noreferrer">Developer</a>**.
4.  Under Developer Integrations, select **Integrate with 1Password SDKs**.
5.  If you want to authenticate with Windows Hello, navigate to **Settings** \> **<a href="onepassword://settings/security" class="link" target="_blank" rel="noreferrer">Security</a>**, then turn on **<a href="https://support.1password.com/windows-hello/" class="link" target="_blank" rel="noreferrer">Unlock using Windows Hello</a>**.


1.  Open and unlock the <a href="https://1password.com/downloads/" class="link" target="_blank" rel="noreferrer">1Password app</a>.
2.  Select your account or collection at the top of the sidebar.
3.  Navigate to **Settings** \> **<a href="onepassword://settings/developers" class="link" target="_blank" rel="noreferrer">Developer</a>**.
4.  Under Developer Integrations, select **Integrate with 1Password SDKs**.
5.  If you want to authenticate the same way you sign in to your Linux account, navigate to **Settings** \> **<a href="onepassword://settings/security" class="link" target="_blank" rel="noreferrer">Security</a>**, then turn on **<a href="https://support.1password.com/system-authentication-linux/" class="link" target="_blank" rel="noreferrer">Unlock using system authentication</a>**.


1.  Get the name of your 1Password account as it appears at the top of the left sidebar in the 1Password desktop app. Alternatively, you can use <a href="/cli/get-started" class="link">1Password CLI</a> to run `op account get` to find your account ID.
2.  Set the `OP_ACCOUNT` environment variable or `account` in the provider configuration to your account name or ID.


## 


<a href="#reference" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="#configuration" class="link">Configuration</a>
- <a href="#resources" class="link">Resources</a>
- <a href="#data-sources" class="link">Data sources</a>

### 


<a href="#configuration" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


| Field                   | Type   | Description                                                                                                                                                                                                           | Required                                                 |
|-------------------------|--------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------|
| `connect_token`         | String | A valid token for the 1Password Connect server. You can also source the value from the `OP_CONNECT_TOKEN` environment variable.                                                                                       | Required if using a Connect server.                      |
| `connect_url`           | String | The HTTP(s) URL of the 1Password Connect server. You can also source the value from the `OP_CONNECT_HOST` environment variable.                                                                                       | Required if using a Connect server.                      |
| `service_account_token` | String | A valid token for the 1Password Service Account. You can also source the value from the `OP_SERVICE_ACCOUNT_TOKEN` environment variable.                                                                              | Required if using a service account.                     |
| `account`               | String | The 1Password account name as it appears at the top left of the sidebar in the 1Password desktop app. Alternatively, the 1Password account ID. You can also source the value from the `ACCOUNT` environment variable. | Required if using the 1Password desktop app integration. |


| Environment variable       | Description                                                                                                                                    | Configuration field     |
|----------------------------|------------------------------------------------------------------------------------------------------------------------------------------------|-------------------------|
| `OP_CONNECT_TOKEN`         | A valid token for the 1Password Connect server.                                                                                                | `connect_token`         |
| `OP_CONNECT_HOST`          | The hostname, IP address, or URL of the 1Password Connect server.                                                                              | `connect_url`           |
| `OP_SERVICE_ACCOUNT_TOKEN` | A valid token for the 1Password Service Account.                                                                                               | `service_account_token` |
| `OP_ACCOUNT`               | The 1Password account name as it appears at the top left of the sidebar in the 1Password desktop app. Alternatively, the 1Password account ID. | `account`               |


#### 


<a href="#configuration-examples" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


The following examples use environment variables. Make sure to set the environment variables beforehand or use plain text.


- <div id="connect-server-3">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-Connect server">

  Connect server

  </div>

  </div>

- <div id="service-account-3">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-Service account">

  Service account

  </div>

  </div>

- <div id="1password-app-3">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-1Password app">

  1Password app

  </div>

  </div>


``` shiki
provider "onepassword" {
  connect_url                   = "OP_CONNECT_HOST"
  connect_token                 = "OP_CONNECT_TOKEN"
}
```


``` shiki
provider "onepassword" {
  service_account_token = "OP_SERVICE_ACCOUNT_TOKEN"
}
```


``` shiki
provider "onepassword" {
  account               = "OP_ACCOUNT"
}
```


### 


<a href="#resources" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="#item-resource" class="link"><code>onepassword_item</code> resource</a>

#### 


<a href="#item-resource" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
terraform import onepassword_item.<item_name> vaults/<vault_uuid>/items/<item_uuid>
```


##### Schema


<table class="m-0 min-w-full w-full max-w-none table [&amp;_th]:text-left [&amp;_td[data-numeric]]:tabular-nums [&amp;_td]:min-w-[150px]">
<colgroup>
<col style="width: 20%" />
<col style="width: 20%" />
<col style="width: 20%" />
<col style="width: 20%" />
<col style="width: 20%" />
</colgroup>
<thead>
<tr class="header">
<th>Field</th>
<th>Type</th>
<th>Description</th>
<th>Required</th>
<th>Access</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>vault</code></td>
<td>String</td>
<td>The UUID of the vault the item is in.</td>
<td>Yes</td>
<td>Read-Write</td>
</tr>
<tr class="even">
<td><code>category</code></td>
<td>String</td>
<td>The category of the item.<br />
<br />
<strong>Acceptable values</strong>: <code>login</code>, <code>password</code>, or <code>database</code>.</td>
<td>No</td>
<td>Read-Write</td>
</tr>
<tr class="odd">
<td><code>database</code></td>
<td>String</td>
<td>The name of the database. Only applies to the database category.</td>
<td>No</td>
<td>Read-Write</td>
</tr>
<tr class="even">
<td><code>hostname</code></td>
<td>String</td>
<td>The address where the database can be found. Only applies to the database category.</td>
<td>No</td>
<td>Read-Write</td>
</tr>
<tr class="odd">
<td><code>note_value</code></td>
<td>String, Sensitive</td>
<td>Secure note value.</td>
<td>No</td>
<td>Read-Write</td>
</tr>
<tr class="even">
<td><code>note_value_wo</code></td>
<td>String, Sensitive</td>
<td>A write-only secure note value. This value is not stored in the state and is intended for use with ephemeral values. Requires Terraform 1.11 or later.</td>
<td>No</td>
<td><a href="https://developer.hashicorp.com/terraform/language/resources/ephemeral#write-only-arguments" class="link" target="_blank" rel="noreferrer">Write-only</a></td>
</tr>
<tr class="odd">
<td><code>note_value_wo_version</code></td>
<td>Number</td>
<td>An integer that must be incremented to trigger an update to the <code>note_value_wo</code> field.</td>
<td>No</td>
<td><a href="https://developer.hashicorp.com/terraform/language/resources/ephemeral#write-only-arguments" class="link" target="_blank" rel="noreferrer">Write-only</a></td>
</tr>
<tr class="even">
<td><code>password</code></td>
<td>String, Sensitive</td>
<td>The password for the item.</td>
<td>No</td>
<td>Read-Write</td>
</tr>
<tr class="odd">
<td><code>password_wo</code></td>
<td>String, Sensitive</td>
<td>A write-only password. This value is not stored in the state and is intended for use with ephemeral values. Requires Terraform 1.11 or later.</td>
<td>No</td>
<td><a href="https://developer.hashicorp.com/terraform/language/resources/ephemeral#write-only-arguments" class="link" target="_blank" rel="noreferrer">Write-only</a></td>
</tr>
<tr class="even">
<td><code>password_wo_version</code></td>
<td>Number</td>
<td>An integer that must be incremented to trigger an update to the <code>password_wo</code> field.</td>
<td>No</td>
<td><a href="https://developer.hashicorp.com/terraform/language/resources/ephemeral#write-only-arguments" class="link" target="_blank" rel="noreferrer">Write-only</a></td>
</tr>
<tr class="odd">
<td><code>password_recipe</code></td>
<td>Block List, Max: 1</td>
<td>The password recipe for the item. Only applies to Login and Password items. See <a href="#password_recipe" class="link"><code>password_recipe</code></a>.</td>
<td>No</td>
<td>Read-Write</td>
</tr>
<tr class="even">
<td><code>password_wo</code></td>
<td>String, Sensitive</td>
<td>A write-only password. This value is not stored in the state and is intended for use with ephemeral values. Requires Terraform 1.11 or later.</td>
<td>No</td>
<td><a href="https://developer.hashicorp.com/terraform/language/resources/ephemeral#write-only-arguments" class="link" target="_blank" rel="noreferrer">Write-only</a></td>
</tr>
<tr class="odd">
<td><code>password_wo_version</code></td>
<td>Number</td>
<td>An integer that must be incremented to trigger an update to the <code>password_wo</code> field.</td>
<td>No</td>
<td><a href="https://developer.hashicorp.com/terraform/language/resources/ephemeral#write-only-arguments" class="link" target="_blank" rel="noreferrer">Write-only</a></td>
</tr>
<tr class="even">
<td><code>port</code></td>
<td>String</td>
<td>The port the database is listening on. Only applies to the database category.</td>
<td>No</td>
<td>Read-Write</td>
</tr>
<tr class="odd">
<td><code>section</code></td>
<td>Block List</td>
<td>A list of custom sections in the item. See <a href="#section" class="link"><code>section</code></a>.</td>
<td>No</td>
<td>Read-Write</td>
</tr>
<tr class="even">
<td><code>section_map</code></td>
<td>Map of Object</td>
<td>A map of custom sections for the item, where <code>label</code> is the map key. See <a href="#section_map" class="link"><code>section_map</code></a>.</td>
<td>No</td>
<td>Read-Write</td>
</tr>
<tr class="odd">
<td><code>tags</code></td>
<td>List of String</td>
<td>An array of strings representing the tags assigned to the item.</td>
<td>No</td>
<td>Read-Write</td>
</tr>
<tr class="even">
<td><code>title</code></td>
<td>String</td>
<td>The title of the item.</td>
<td>No</td>
<td>Read-Write</td>
</tr>
<tr class="odd">
<td><code>type</code></td>
<td>String</td>
<td>The type of database. Only applies to the database category.<br />
<br />
<strong>Acceptable values</strong>: <code>db2</code>, <code>filemaker</code>, <code>msaccess</code>, <code>mssql</code>, <code>mysql</code>, <code>oracle</code>, <code>postgresql</code>, <code>sqlite</code> or <code>other</code>.</td>
<td>No</td>
<td>Read-Write</td>
</tr>
<tr class="even">
<td><code>url</code></td>
<td>String</td>
<td>The primary URL for the item.</td>
<td>No</td>
<td>Read-Write</td>
</tr>
<tr class="odd">
<td><code>username</code></td>
<td>String</td>
<td>The username for the item.</td>
<td>No</td>
<td>Read-Write</td>
</tr>
<tr class="even">
<td><code>id</code></td>
<td>String</td>
<td>The Terraform resource identifier for the item in the format <code>vaults/&lt;vault_id&gt;/items/&lt;item_id&gt;</code>.</td>
<td>N/A</td>
<td>Read-Only</td>
</tr>
<tr class="odd">
<td><code>uuid</code></td>
<td>String</td>
<td>The UUID of the item. Item identifiers are unique within a specific vault.</td>
<td>N/A</td>
<td>Read-Only</td>
</tr>
</tbody>
</table>


#### 


<a href="#password_recipe" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Password recipes can only be added to Login and Password items.


| Field     | Type    | Description                                          | Required | Access     |
|-----------|---------|------------------------------------------------------|----------|------------|
| `digits`  | Boolean | Use digits `[0-9]` when generating the password.     | No       | Read-Write |
| `length`  | Number  | The length of the password to be generated.          | No       | Read-Write |
| `symbols` | Boolean | Use symbols `[!@.-_*]` when generating the password. | No       | Read-Write |


#### 


<a href="#section" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


| Field   | Type       | Description                                                                                                                     | Required | Access     |
|---------|------------|---------------------------------------------------------------------------------------------------------------------------------|----------|------------|
| `label` | String     | The label for the section.                                                                                                      | Yes      | Read-Write |
| `field` | Block List | A list of custom fields in the section. See <a href="#item-resource-section-field" class="link"><code>section.field</code></a>. | No       | Read-Write |
| `id`    | String     | A unique identifier for the section.                                                                                            | N/A      | Read-Only  |


#### 


<a href="#section_map" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


| Field       | Type          | Description                                                                                                                            | Required | Access     |
|-------------|---------------|----------------------------------------------------------------------------------------------------------------------------------------|----------|------------|
| `field_map` | Map of Object | A map of custom fields in the section, where `label` is the map key. See <a href="#field_map" class="link"><code>field_map</code></a>. | No       | Read-Write |
| `id`        | String        | A unique identifier for the section.                                                                                                   | N/A      | Read-Only  |


#### 


<a href="#item-resource-section-field" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


<table class="m-0 min-w-full w-full max-w-none table [&amp;_th]:text-left [&amp;_td[data-numeric]]:tabular-nums [&amp;_td]:min-w-[150px]">
<colgroup>
<col style="width: 20%" />
<col style="width: 20%" />
<col style="width: 20%" />
<col style="width: 20%" />
<col style="width: 20%" />
</colgroup>
<thead>
<tr class="header">
<th>Field</th>
<th>Type</th>
<th>Description</th>
<th>Required</th>
<th>Access</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>label</code></td>
<td>String</td>
<td>The label for the field.</td>
<td>Yes</td>
<td>Read-Write</td>
</tr>
<tr class="even">
<td><code>id</code></td>
<td>String</td>
<td>A unique identifier for the field.</td>
<td>No</td>
<td>Read-Write</td>
</tr>
<tr class="odd">
<td><code>password_recipe</code></td>
<td>String</td>
<td>The password for the item. Only applies to Login and Password items. See <a href="#item-resource-section-field-password-recipe" class="link"><code>section.field.password_recipe</code></a>.</td>
<td>No</td>
<td>Read-Write</td>
</tr>
<tr class="even">
<td><code>type</code></td>
<td>String</td>
<td>The type of value stored in the field.<br />
<br />
<strong>Acceptable values</strong>: <code>STRING</code>, <code>EMAIL</code>, <code>CONCEALED</code>, <code>URL</code>, <code>OTP</code>, <code>DATE</code>, <code>MONTH_YEAR</code>, or <code>MENU</code>.</td>
<td>No</td>
<td>Read-Write</td>
</tr>
<tr class="odd">
<td><code>value</code></td>
<td>String, Sensitive</td>
<td>The value of the field.</td>
<td>No</td>
<td>Read-Write</td>
</tr>
</tbody>
</table>


#### 


<a href="#field_map" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


| Field             | Type                               | Description                            | Required   | Access     |
|-------------------|------------------------------------|----------------------------------------|------------|------------|
| `id`              | String                             | A unique identifier for the field.     | N/A        | Read-Only  |
| `password_recipe` | The password recipe for the field. | No                                     | Read-Write |            |
| `type`            | String                             | The type of value stored in the field. | No         | Read-Write |
| `value`           | String, Sensitive                  | The value of the field.                | No         | Read-Write |


#### 


<a href="#item-resource-section-field-password-recipe" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Password recipes can only be added to Login and Password items.


| Field     | Type    | Description                                          | Required | Access     |
|-----------|---------|------------------------------------------------------|----------|------------|
| `digits`  | Boolean | Use digits `[0-9]` when generating the password.     | No       | Read-Write |
| `length`  | Number  | The length of the password to be generated.          | No       | Read-Write |
| `symbols` | Boolean | Use symbols `[!@.-_*]` when generating the password. | No       | Read-Write |


##### Example


``` shiki
resource "onepassword_item" "demo_password" {
  vault = var.demo_vault

  title    = "Demo Password Recipe"
  category = "password"

  password_recipe {
    length  = 40
    symbols = false
  }
}

resource "onepassword_item" "demo_login" {
  vault = var.demo_vault

  title    = "Demo Terraform Login"
  category = "login"
  username = "test@example.com"
}

resource "onepassword_item" "demo_db" {
  vault    = var.demo_vault
  category = "database"
  type     = "mysql"

  title    = "Demo TF Database"
  username = "root"

  database = "Example MySQL Instance"
  hostname = "localhost"
  port     = 3306
}
```


### 


<a href="#data-sources" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="#item-data-source" class="link"><code>onepassword_item</code> data source</a>
- <a href="#vault-data-source" class="link"><code>onepassword_vault</code> data source</a>
- <a href="#environment-data-source" class="link"><code>onepassword_environment</code> data source</a>

#### 


<a href="#item-data-source" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


##### Schema


<table class="m-0 min-w-full w-full max-w-none table [&amp;_th]:text-left [&amp;_td[data-numeric]]:tabular-nums [&amp;_td]:min-w-[150px]">
<colgroup>
<col style="width: 20%" />
<col style="width: 20%" />
<col style="width: 20%" />
<col style="width: 20%" />
<col style="width: 20%" />
</colgroup>
<thead>
<tr class="header">
<th>Field</th>
<th>Type</th>
<th>Description</th>
<th>Required</th>
<th>Access</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>vault</code></td>
<td>String</td>
<td>The UUID of the vault the item is in.</td>
<td>Yes</td>
<td>Read-Write</td>
</tr>
<tr class="even">
<td><code>note_value</code></td>
<td>String, Sensitive</td>
<td>The Secure Note value.</td>
<td>No</td>
<td>Read-Write</td>
</tr>
<tr class="odd">
<td><code>title</code></td>
<td>String</td>
<td>The title of the item to retrieve. This field populates with the title of the item if the item is looked up by its UUID.</td>
<td>No</td>
<td>Read-Write</td>
</tr>
<tr class="even">
<td><code>uuid</code></td>
<td>String</td>
<td>The UUID of the item to retrieve. This field populates with the UUID of the item if the item is looked up by its title.</td>
<td>No</td>
<td>Read-Write</td>
</tr>
<tr class="odd">
<td><code>category</code></td>
<td>String</td>
<td>The category of the item.<br />
<br />
<strong>Acceptable values</strong>: <code>login</code>, <code>password</code>, or <code>database</code>.</td>
<td>No</td>
<td>Read-Only</td>
</tr>
<tr class="even">
<td><code>database</code></td>
<td>String</td>
<td>The name of the database. Only applies to the database category.</td>
<td>No</td>
<td>Read-Only</td>
</tr>
<tr class="odd">
<td><code>hostname</code></td>
<td>String</td>
<td>The address where the database can be found. Only applies to the database category.</td>
<td>No</td>
<td>Read-Only</td>
</tr>
<tr class="even">
<td><code>id</code></td>
<td>String</td>
<td>The Terraform resource identifier for the item in the format <code>vaults/&lt;vault_id&gt;/items/&lt;item_id&gt;</code>.</td>
<td>No</td>
<td>Read-Only</td>
</tr>
<tr class="odd">
<td><code>password</code></td>
<td>String, Sensitive</td>
<td>The password for the item.</td>
<td>No</td>
<td>Read-Only</td>
</tr>
<tr class="even">
<td><code>port</code></td>
<td>String</td>
<td>The port the database is listening on. Only applies to the database category.</td>
<td>No</td>
<td>Read-Only</td>
</tr>
<tr class="odd">
<td><code>section</code></td>
<td>List of Object</td>
<td>A list of custom sections in an item.</td>
<td>No</td>
<td>Read-Only</td>
</tr>
<tr class="even">
<td><code>tags</code></td>
<td>List of String</td>
<td>An array of strings of the tags assigned to the item.</td>
<td>No</td>
<td>Read-Only</td>
</tr>
<tr class="odd">
<td><code>type</code></td>
<td>String</td>
<td>The type of database. Only applies to the database category.<br />
<br />
<strong>Acceptable values</strong>: <code>db2</code>, <code>filemaker</code>, <code>msaccess</code>, <code>mssql</code>, <code>mysql</code>, <code>oracle</code>, <code>postgresql</code>, <code>sqlite</code>, or <code>other</code>.</td>
<td>No</td>
<td>Read-Only</td>
</tr>
<tr class="even">
<td><code>url</code></td>
<td>String</td>
<td>The primary URL for the item.</td>
<td>No</td>
<td>Read-Only</td>
</tr>
<tr class="odd">
<td><code>username</code></td>
<td>String</td>
<td>The username for the item.</td>
<td>No</td>
<td>Read-Only</td>
</tr>
</tbody>
</table>


#### 


<a href="#item-data-source-section" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


| Field   | Type           | Description                                                                                                                        | Required | Access    |
|---------|----------------|------------------------------------------------------------------------------------------------------------------------------------|----------|-----------|
| `field` | List of Object | A list of custom fields in the section. See <a href="#item-data-source-section-field" class="link"><code>section.field</code></a>. | N/A      | Read-Only |
| `id`    | String         | A unique identifier for the section.                                                                                               | N/A      | Read-Only |
| `label` | String         | The label for the section.                                                                                                         | N/A      | Read-Only |


#### 


<a href="#item-data-source-section-field" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


<table class="m-0 min-w-full w-full max-w-none table [&amp;_th]:text-left [&amp;_td[data-numeric]]:tabular-nums [&amp;_td]:min-w-[150px]">
<colgroup>
<col style="width: 20%" />
<col style="width: 20%" />
<col style="width: 20%" />
<col style="width: 20%" />
<col style="width: 20%" />
</colgroup>
<thead>
<tr class="header">
<th>Field</th>
<th>Type</th>
<th>Description</th>
<th>Required</th>
<th>Access</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><code>id</code></td>
<td>String</td>
<td>A unique identifier for the field.</td>
<td>N/A</td>
<td>Read-Only</td>
</tr>
<tr class="even">
<td><code>label</code></td>
<td>String</td>
<td>The label for the field.</td>
<td>N/A</td>
<td>Read-Only</td>
</tr>
<tr class="odd">
<td><code>type</code></td>
<td>String</td>
<td>The type of value stored in the field.<br />
<br />
<strong>Acceptable values</strong>: <code>STRING</code>, <code>EMAIL</code>, <code>CONCEALED</code>, <code>URL</code>, <code>OTP</code>, <code>DATE</code>, <code>MONTH_YEAR</code>, or <code>MENU</code>.</td>
<td>N/A</td>
<td>Read-Only</td>
</tr>
<tr class="even">
<td><code>value</code></td>
<td>String, Sensitive</td>
<td>The value of the field.</td>
<td>N/A</td>
<td>Read-Only</td>
</tr>
</tbody>
</table>


##### Example


``` shiki
data "onepassword_item" "example" {
  vault = var.demo_vault
  uuid  = onepassword_item.demo_sections.uuid
}
```


#### 


<a href="#vault-data-source" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


##### Schema


| Field         | Type   | Description                                                                                                               | Required | Access     |
|---------------|--------|---------------------------------------------------------------------------------------------------------------------------|----------|------------|
| `name`        | String | The name of the vault to retrieve. This field populates with the name of the vault if the vault is looked up by its UUID. | No       | Read-Write |
| `uuid`        | String | The UUID of the vault to retrieve. This field populates with the UUID of the vault if the vault is looked up by its name. | No       | Read-Write |
| `description` | String | The description of the vault.                                                                                             | No       | Read-Only  |
| `id`          | String | The Terraform resource identifier for this item in the format `vaults/<vault_id>`.                                        | No       | Read-Only  |


#### 


<a href="#environment-data-source" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


This data source is only supported with service account or desktop app authentication. It isn’t available with 1Password Connect.


##### Schema


| Field            | Type                     | Description                                                                                                                                                                                 | Required | Access     |
|------------------|--------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|------------|
| `environment_id` | String                   | The unique identifier of the 1Password Environment. Learn how to <a href="/environments/read-environment-variables#get-an-environments-id" class="link">get an Environment’s ID</a>.        | Yes      | Read-Write |
| `id`             | String                   | The Terraform resource identifier for the environment in the format `environments/<environment_id>`.                                                                                        | No       | Read-Only  |
| `variables`      | Map of String, Sensitive | A map of environment variable names to their values. Use this for passing secrets into Terraform resources or for use in `environment` blocks.                                              | No       | Read-Only  |
| `metadata`       | List of Object           | Metadata for each environment variable. Use this when you need the full structure of each variable. See <a href="#environment-data-source-metadata" class="link"><code>metadata</code></a>. | No       | Read-Only  |


#### 


<a href="#environment-data-source-metadata" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


| Field    | Type              | Description                                                  | Required | Access    |
|----------|-------------------|--------------------------------------------------------------|----------|-----------|
| `name`   | String            | The environment variable name.                               | N/A      | Read-Only |
| `value`  | String, Sensitive | The environment variable value.                              | N/A      | Read-Only |
| `masked` | Boolean           | Whether the value is hidden by default in the 1Password app. | N/A      | Read-Only |


##### Example


``` shiki
data "onepassword_environment" "example" {
  environment_id = "your-environment-id"
}

output "env_variables" {
  value     = data.onepassword_environment.example.variables
  sensitive = true
}
```


### 


<a href="#ephemeral-resources" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="#item-ephemeral-resource" class="link"><code>onepassword_item</code> ephemeral resource</a>

#### 


<a href="#item-ephemeral-resource" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


##### Schema


| Field                 | Type              | Description                                                                                                                      | Required | Access     |
|-----------------------|-------------------|----------------------------------------------------------------------------------------------------------------------------------|----------|------------|
| `vault`               | String            | The UUID of the vault the item is in.                                                                                            | Yes      | Read-Write |
| `title`               | String            | The title of the item to retrieve. This field will be populated with the title of the item if the item it looked up by its UUID. | No       | Read-Write |
| `uuid`                | String            | The UUID of the item to retrieve. This field will be populated with the UUID of the item if the item it looked up by its title.  | No       | Read-Write |
| `credential`          | String, Sensitive | API credential for this item. Only applies to the API credential category.                                                       | No       | Read-Only  |
| `database`            | String            | The name of the database. Only applies to the database category.                                                                 | No       | Read-Only  |
| `hostname`            | String            | The address where the database can be found. Only applies to the database category.                                              | No       | Read-Only  |
| `id`                  | String            | The Terraform resource identifier for the item in the format `vaults/<vault_id>/items/<item_id>`.                                | No       | Read-Only  |
| `note_value`          | String, Sensitive | Secure Note value.                                                                                                               | No       | Read-Only  |
| `password`            | String, Sensitive | Password for this item.                                                                                                          | No       | Read-Only  |
| `port`                | String            | The port the database is listening on. Only applies to the database category.                                                    | No       | Read-Only  |
| `private_key`         | String, Sensitive | SSH Private Key in PKCS#8 for this item.                                                                                         | No       | Read-Only  |
| `private_key_openssh` | String, Sensitive | SSH Private key in OpenSSH format.                                                                                               | No       | Read-Only  |
| `public_key`          | String            | SSH Public Key for this item.                                                                                                    | No       | Read-Only  |
| `type`                | String            | The type of database or API Credential. Only applies to database and API credential categories                                   | No       | Read-Only  |
| `url`                 | String            | The primary URL for the item.                                                                                                    | No       | Read-Only  |
| `username`            | String            | Username for this item.                                                                                                          | No       | Read-Only  |


#### 


<a href="#example" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
# Example using ephemeral resource to retrieve item values
ephemeral "onepassword_item" "example" {
  vault = "your-vault-id"
  title = "your-item-title"
}

# Example using UUID instead of title
ephemeral "onepassword_item" "example_by_uuid" {
  vault = "your-vault-id"
  uuid  = "your-item-uuid"
}
```


## 


<a href="#learn-more" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="https://github.com/1Password/terraform-provider-onepassword/blob/main/CHANGELOG.md" class="link" target="_blank" rel="noreferrer">Changelog</a>
- <a href="/get-started/secure-deployment" class="link">Workflow: Secure your deployments</a>
- <a href="/get-started/build-integrations" class="link">Workflow: Build integrations with 1Password</a>


Was this page helpful?


{"docsConfig":{"theme":"mint","\$schema":"https://mintlify.com/docs.json","name":"1Password Developer","colors":{"primary":"#104ebb","light":"#b8d7ff","dark":"#303136"},"logo":{"light":"https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max\u0026auto=format\u0026n=lHrfVfSCdefFz8U5\u0026q=85\u0026s=29d1c9358888a723dddd8a89a3b6f71d","dark":"https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-light.svg?fit=max\u0026auto=format\u0026n=lHrfVfSCdefFz8U5\u0026q=85\u0026s=119233092720e49043d6f42ff71125f1"},"favicon":"https://mintcdn.com/ab-634991b8/s4Wjy03jBRs6hcHb/favicon.ico?fit=max\u0026auto=format\u0026n=s4Wjy03jBRs6hcHb\u0026q=85\u0026s=dd03b4bc604b342373aa4d3e21be4310","api":{"playground":{"display":"interactive"},"examples":{"languages":\["curl","node","python","go","dotnet","java","php","powershell","ruby"\]}},"background":{"color":{"light":"#fbf8f4","dark":"#1a1b1e"}},"navbar":{"links":\[{"href":"/community","label":"Community"},{"href":"https://www.1password.academy/path/1password-developer-tools","label":"Academy"}\],"primary":{"type":"button","label":"GitHub","href":"https://github.com/1Password"}},"footer":{"socials":{"github":"https://github.com/1Password","x":"https://twitter.com/1Password","reddit":"https://www.reddit.com/r/1Password","linkedin":"https://www.linkedin.com/company/1password","youtube":"https://www.youtube.com/1PasswordVideos","facebook":"https://www.facebook.com/1Password","instagram":"https://www.instagram.com/1password"},"links":\[{"header":"Legal","items":\[{"label":"Terms of Service","href":"https://1password.com/legal/terms-of-service"},{"label":"Privacy Policy","href":"https://1password.com/legal/privacy"},{"label":"Cookie Policy","href":"https://1password.com/legal/cookies"},{"label":"Accessibility","href":"https://1password.com/legal/accessibility"}\]},{"header":"Community","items":\[{"label":"Developer community","href":"/community"},{"label":"Code of Conduct","href":"/code-of-conduct"},{"label":"Community projects disclaimer","href":"/community/disclaimer"}\]},{"header":"Resources","items":\[{"label":"1Password University","href":"https://www.1password.university/?utm_ref=website-footer"},{"label":"Blog RSS","href":"https://blog.1password.com/index.xml"},{"label":"Newsletter","href":"https://1password.com/developer-newsletter"}\]}\]},"seo":{"metatags":{"canonical":"https://www.1password.dev","google-site-verification":"YserOhXnJUjFfIZ4K3qgxkVSlQZQdXtIbBiKzZ35Nvs"}},"fonts":{"heading":{"family":"Public Sans"},"body":{"family":"Public Sans"}},"banner":{"content":"\*\*New!\*\* Use the \[1Password Credential Broker\](https://www.1password.dev/brokered-access) to give CI/CD and other machine workflows short-lived access to secrets, without managing service account tokens.","dismissible":true,"color":{"light":"#145fe4","dark":"#145fe4"}},"errors":{"404":{"redirect":false,"title":"This page can't be found","description":"Our docs have moved to \[www.1password.dev\](https://www.1password.dev). Try searching for what you need or selecting from the list of tools."}},"contextual":{"options":\["copy","view","mcp","cursor","vscode","chatgpt","claude","perplexity"\],"display":"header"},"styling":{"latex":false},"navigation":{"pages":\[\]}},"deployment":{"deploymentMetadataValue":{"subdomain":"ab-634991b8","hasAudioNarration":false,"actualSubdomain":"ab-634991b8","customDomains":\["www.1password.dev"\],"gitSource":{"type":"github","owner":"1password","repo":"1password.dev","deployBranch":"main","contentDirectory":"","isPrivate":true,"mountPath":"","label":""},"chroma":{"liveDeploymentHistoryId":"6ae4c9014c4a3f4f5e4b234c","collectionId":"2b0d16b8-c8c5-48fa-9c4d-f1ffef490467","schemaVersion":"v3","latestBuiltDeploymentHistoryId":"6ae4c9014c4a3f4f5e4b234c"},"feedback":{"thumbs":true,"contextualFeedback":{"allowEmail":false},"agentFeedback":true},"entitlements":{"AI_CHAT":{"status":"ENABLED"},"REMOVE_BRANDING":{"status":"ENABLED"},"CONTEXTUAL_FEEDBACK":{"status":"ENABLED"},"CODE_SNIPPET_FEEDBACK":{"status":"ENABLED"},"WEB_MCP":{"status":"ENABLED"},"NARRATION":{"status":"ENABLED"}},"buildId":"6ae4c9014c4a3f4f5e4b234c","clientVersion":"0.0.4044","searchFilterCounts":\[{"language":"default","tag":"More Tools","count":257},{"language":"default","tag":"Shell Plugins","count":184},{"language":"default","tag":"CLI","count":112},{"language":"default","tag":"Secrets Automation","count":94},{"language":"default","tag":"SaaS Manager API","count":88},{"language":"default","tag":"Plugins","count":85},{"language":"default","tag":"API Reference","count":64},{"language":"default","tag":"Reference","count":58},{"language":"default","tag":"SDKs","count":53},{"language":"default","tag":"Integrations","count":50}\]},"assistantConfig":{"enableStarterQuestions":true,"enableContextualStarterQuestions":true,"deflection":{"enabled":true,"email":"support@1password.com","showHelpButton":true}},"basePath":"","hasChatPermissions":true,"hasWebMcpPermissions":true,"toggles":\[{"name":"kill-isr","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"agent-mintlify-slack","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"agent-integrations-settings","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"automations-pr-grouping","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"custom-prefix","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"analytics-v7","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"user-flows-analytics","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"no-publish-flow","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"workos-onboarding","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"llms-txt-v2","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"snapshot-serving-live","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"stripTemperatureMiddleware","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"support-platform-pylon-zendesk","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"snapshot-serving","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"instant-rollback","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"granular-notifications-server","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"granular-notifications","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"automations-fable","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"fixed-ai-action-pricing","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"automation-resolve-merge-conflict","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"scoped-publishing","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"mintql","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"page-level-analytics","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"editor-version-history-v2","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"billing-page-v2","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"full-page-search","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"workspace-projects","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"assistant-v5","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"byok-sep-25","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"fork-pr-previews","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"revalidation-jwt","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"vite-origin","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"billing-updated-9-15","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"workos-sso-scim","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"hobby-abuse-scan","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"dashboard-inbox","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"workos-signup","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"turbopuffer-dual-write","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"workos-enabled","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"approve-review-flow","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false},{"name":"sso-setup-deadline-banner","enabled":true,"variant":{"name":"disabled","enabled":false,"feature_enabled":true},"impressionData":false}\],"googleFontsInlined":true},"customCss":\[{"filePath":"styles.css","content":":root{--op-secure-blue:#104ebb;--op-secure-blue-hover:#0e46a8;--op-iron-ore:#303136;--op-page-bg-dark:#1a1b1e;--op-white:#ffffff;--op-icy-blue:#dcebff;--op-cornflower:#b8d7ff;--op-biscuit:#fbf8f4;--op-sunbeam:#fad785;--op-tangerine:#ff8f78;--op-enable-mint:#76e0bd;--op-gold:#cbb88e;--op-status-success:#10622f;--op-status-warning:#8a4006;--op-status-error:#a71c1c;--op-status-info:var(--op-secure-blue);--op-border-ui:#949494;--op-border-ui-dark:#6b7280;--op-border-subtle:rgb(3 7 18 / 0.12);--op-border-subtle-dark:rgb(251 248 244 / 0.25);--op-border-footer-dark:rgb(251 248 244 / 0.37);--op-border-navbar-light:rgb(107 114 128 / 0.05);--op-border-navbar-dark:rgb(209 213 219 / 0.06);--op-border-card-light:rgb(3 7 18 / 0.1);--op-border-card-dark:rgb(255 255 255 / 0.1);--op-border-hero-light:rgb(255 255 255 / 0.08);--op-border-hero-dark:rgb(255 255 255 / 0.12);--op-border-badge-light:rgb(16 78 187 / 0.2);--op-border-badge-dark:rgb(184 215 255 / 0.25);--op-border-workflow-dark:rgb(251 248 244 / 0.2);--op-text-body:var(--op-iron-ore);--op-text-body-dark:var(--op-biscuit);--op-surface-card-light:var(--op-white);--op-surface-card-dark:#25262a;--op-surface-callout-light:rgb(220 235 255 / 0.45);--op-surface-callout-dark:rgb(184 215 255 / 0.08)}#content.prose{--tw-prose-body:var(--op-text-body)}.dark \#content.prose{--tw-prose-body:var(--op-text-body-dark)}#content.prose :where(p, span\[data-as=\\p\\\], li, td, th, blockquote, figcaption):not(a.op-cta-primary span){color:var(--op-text-body)}.dark \#content.prose :where(p, span\[data-as=\\p\\\], li, td, th, blockquote, figcaption):not(a.op-cta-primary span){color:var(--op-text-body-dark)}#content :is(p, li, div, span, button, h1, h2, h3, h4, h5, h6).text-gray-600,#content :is(p, li, div, span, button, h1, h2, h3, h4, h5, h6).text-gray-700,#content :is(p, li, span, button, h1, h2, h3, h4, h5, h6).text-gray-500{color:var(--op-text-body)}.dark \#content :is(p, li, div, span, button, h1, h2, h3, h4, h5, h6).dark\\:text-gray-300,.dark \#content :is(p, li, div, span, button, h1, h2, h3, h4, h5, h6).dark\\:text-gray-400,.dark \#content :is(p, li, span, button, h1, h2, h3, h4, h5, h6).dark\\:text-gray-500{color:var(--op-text-body-dark)}#content .text-gray-400:not(:is(p, li, span, button, h1, h2, h3, h4, h5, h6)){color:var(--op-border-ui)}.dark \#content .text-gray-400:not(:is(p, li, span, button, h1, h2, h3, h4, h5, h6)),.dark \#content .text-gray-500:not(:is(p, li, span, button, h1, h2, h3, h4, h5, h6)){color:var(--op-border-ui-dark)}.dark .card-group{--background-dark:37 38 42}.dark .card-group .card{background-color:rgb(var(--background-dark))!important;border-color:var(--op-border-card-dark)!important}.card-group .card{border-color:var(--op-border-card-light)!important}.community-callout,.community-card,.op-card-surface{border:1px solid var(--op-border-card-light)}.dark .community-card,.dark .op-card-surface{border-color:var(--op-border-card-dark)}#content .hover\\:border-gray-300:hover{border-color:var(--op-iron-ore)}.dark \#content .hover\\:border-gray-600:hover{border-color:var(--op-biscuit)}.community-callout,.community-card{border-radius:.5rem;background-color:var(--op-surface-card-light)}.dark .community-card{background-color:var(--op-surface-card-dark)}.community-card .community-card-chevron{color:var(--op-border-ui)}.dark .community-card .community-card-chevron{color:var(--op-cornflower)}a.community-card:hover{border-color:var(--op-secure-blue)}.dark a.community-card:hover{border-color:var(--op-cornflower)}.community-callout{background-color:var(--op-surface-callout-light)}.dark .community-callout{border-color:var(--op-border-card-dark);background-color:var(--op-surface-callout-dark)}.community-link{color:var(--op-secure-blue);text-decoration:none}.community-link:hover{color:var(--op-secure-blue-hover);text-decoration:underline}.dark .community-link{color:var(--op-cornflower)}#footer a,#footer p.font-semibold,.dark \#content\>h5,.dark \#content\>h6,.dark .community-link:hover{color:var(--op-white)}:is(\n \#sidebar-content a:not(\[aria-current=\\page\\\]),\n \#table-of-contents,\n \#table-of-contents a,\n \#navbar .nav-tabs-item:not(\[data-active\]),\n \#navbar nav ul \> li:not(#topbar-cta-button) \> a,\n \#search-bar-entry,\n \#search-bar-entry-mobile,\n \#assistant-entry,\n \#assistant-entry-mobile,\n \[data-component-name=\\theme-toggle\\\]\n){color:var(--op-text-body)}.dark :is(\n \#sidebar-content a:not(\[aria-current=\\page\\\]),\n \#table-of-contents,\n \#table-of-contents a,\n \#navbar .nav-tabs-item:not(\[data-active\]),\n \#navbar nav ul \> li:not(#topbar-cta-button) \> a,\n \#search-bar-entry,\n \#search-bar-entry-mobile,\n \#assistant-entry,\n \#assistant-entry-mobile,\n \[data-component-name=\\theme-toggle\\\]\n){color:var(--op-text-body-dark)}:is(\n \#search-bar-entry,\n \#search-bar-entry-mobile,\n \#assistant-entry,\n \#assistant-entry-mobile,\n \[data-component-name=\\theme-toggle\\\]\n) svg{color:inherit}#footer a.h-fit svg{background-color:var(--op-biscuit)}#footer a.h-fit:hover svg{background-color:var(--op-white)}.hero-background{background-color:var(--op-iron-ore);background-image:radial-gradient(ellipse 75% 100% at 100% 50%,rgb(20 95 228/.55) 0,rgb(20 95 228/.2) 40%,transparent 70%)}.dark .hero-background{background-color:var(--op-page-bg-dark);background-image:radial-gradient(ellipse 80% 100% at 100% 50%,rgb(20 95 228/.7) 0,rgb(20 95 228/.3) 45%,transparent 75%)}.hero-section{border-bottom:1px solid var(--op-border-hero-light)}.dark .hero-section{border-bottom-color:var(--op-border-hero-dark)}.hero-cta{background-color:var(--op-secure-blue);color:var(--op-white);box-shadow:0 1px 3px rgb(0 0 0/.25)}.hero-cta svg,.hero-cta svg path{fill:currentColor!important;color:currentColor!important}.hero-cta:hover{background-color:var(--op-secure-blue-hover)}#content a.op-cta-primary,#content.prose a.op-cta-primary{background-color:var(--op-secure-blue);color:var(--op-white)!important;text-decoration:none}#content a.op-cta-primary span,#content a.op-cta-primary span\[data-as=p\],#content a.op-cta-primary:hover span,#content a.op-cta-primary:hover span\[data-as=p\],#content.prose a.op-cta-primary span,#content.prose a.op-cta-primary span\[data-as=p\],#content.prose a.op-cta-primary:hover span,#content.prose a.op-cta-primary:hover span\[data-as=p\]{color:var(--op-white)!important}#content a.op-cta-primary:hover,#content.prose a.op-cta-primary:hover{background-color:var(--op-secure-blue-hover);color:var(--op-white)!important}#topbar-cta-button a\>span.absolute,.highlight-card-link svg{background-color:var(--op-secure-blue)!important}#topbar-cta-button a:hover\>span.absolute{background-color:var(--op-secure-blue-hover)!important}#topbar-cta-button a span.z-10,#topbar-cta-button a svg,.dark .highlight-card-link:hover{color:var(--op-white)!important}.card-group{gap:1rem}#content .card-group img\[src\*=\\/homepage-icons/brand/\\\]{width:32px;height:32px;flex-shrink:0}.homepage-card-title{display:inline-flex;flex-wrap:wrap;align-items:center;gap:.25rem .5rem}.image-button-link img{margin:10px 0}.dark \#content a\>div\>span{color:var(--op-cornflower)!important}.docs-higlight-cards{display:grid;grid-template-columns:repeat(auto-fill,minmax(250px,1fr));gap:1rem;margin-bottom:1rem}.highlight-card-link{color:var(--op-secure-blue)!important}.highlight-card-link:hover{color:var(--op-secure-blue-hover)!important}.dark .highlight-card-link{color:var(--op-cornflower)!important}.dark .highlight-card-link svg{background-color:var(--op-cornflower)!important}.coloredCodeWrapper .code-block\>div:nth-child(3){--fade-color-light:transparent!important;--fade-color-dark:transparent!important}.badge{border-radius:.4rem;color:var(--op-white);font-weight:700;line-height:1;padding:3px 5px}.badge--primary{background-color:var(--op-secure-blue)}.badge--secondary{background-color:var(--op-biscuit);color:var(--op-iron-ore)}.op-status-badge,.op-workflow-guide-badge{display:inline-flex;flex-shrink:0;align-items:center;white-space:nowrap;border-radius:.25rem;color:var(--op-iron-ore);padding:.125rem .625rem;font-size:.75rem;line-height:1rem;font-weight:600}.op-status-badge{vertical-align:middle;border:1px solid var(--op-border-badge-light);background-color:var(--op-icy-blue)}.dark .op-status-badge{border-color:var(--op-border-badge-dark);background-color:rgb(184 215 255/.12);color:var(--op-icy-blue)}.op-workflow-guide-badge{margin-top:.75rem;border:1px solid transparent;background-color:var(--op-biscuit)}.dark .op-workflow-guide-badge{border-color:var(--op-border-workflow-dark);background-color:rgb(251 248 244/.1);color:var(--op-biscuit)}.op-beta-badge-inline{display:inline-flex;align-items:center;margin-left:.5rem;vertical-align:middle}.mdx-content a\[href^=http\]:not(\[href\*=\\://1password.com/\\\],\[href\$=\\://1password.com\\\],\[href\*=\\.1password.com/\\\],\[href\$=\\.1password.com\\\],\[href\*=\\://1password.dev/\\\],\[href\$=\\://1password.dev\\\],\[href\*=\\.1password.dev/\\\],\[href\$=\\.1password.dev\\\],\[href\*=\\://1password.ca/\\\],\[href\$=\\://1password.ca\\\],\[href\*=\\.1password.ca/\\\],\[href\$=\\.1password.ca\\\],\[href\*=\\://1password.eu/\\\],\[href\$=\\://1password.eu\\\],\[href\*=\\.1password.eu/\\\],\[href\$=\\.1password.eu\\\],\[href\*=\\://1password.io/\\\],\[href\$=\\://1password.io\\\],\[href\*=\\.1password.io/\\\],\[href\$=\\.1password.io\\\],\[href\*=\\://1password.university/\\\],\[href\$=\\://1password.university\\\],\[href\*=\\.1password.university/\\\],\[href\$=\\.1password.university\\\],\[href\*=\\://agilebits.com/\\\],\[href\$=\\://agilebits.com\\\],\[href\*=\\.agilebits.com/\\\],\[href\$=\\.agilebits.com\\\],\[href\*=\\://b5dev.com/\\\],\[href\$=\\://b5dev.com\\\],\[href\*=\\.b5dev.com/\\\],\[href\$=\\.b5dev.com\\\],\[href\*=\\://b5local.com/\\\],\[href\$=\\://b5local.com\\\],\[href\*=\\.b5local.com/\\\],\[href\$=\\.b5local.com\\\],\[href\*=\\://1infra.dev/\\\],\[href\$=\\://1infra.dev\\\],\[href\*=\\.1infra.dev/\\\],\[href\$=\\.1infra.dev\\\],\[href\*=\\://kolide.com/\\\],\[href\$=\\://kolide.com\\\],\[href\*=\\.kolide.com/\\\],\[href\$=\\.kolide.com\\\],\[href\*=\\://trelica.app/\\\],\[href\$=\\://trelica.app\\\],\[href\*=\\.trelica.app/\\\],\[href\$=\\.trelica.app\\\],\[href\*=\\://trelica.eu/\\\],\[href\$=\\://trelica.eu\\\],\[href\*=\\.trelica.eu/\\\],\[href\$=\\.trelica.eu\\\],\[href\*=\\://trelica.com/\\\],\[href\$=\\://trelica.com\\\],\[href\*=\\.trelica.com/\\\],\[href\$=\\.trelica.com\\\],\[href\*=\\://1password.community/\\\],\[href\$=\\://1password.community\\\],\[href\*=\\.1password.community/\\\],\[href\$=\\.1password.community\\\],\[href\*=\\://1pw.ca/\\\],\[href\$=\\://1pw.ca\\\],\[href\*=\\.1pw.ca/\\\],\[href\$=\\.1pw.ca\\\]):not(.card \*,.op-card-surface \*,.image-button-link,.community-card,.community-card \*,pre \*,:has(img))::after{content:\\\\;display:inline-block;width:1em;height:1em;margin-left:.25em;vertical-align:-.125em;background-color:currentColor;-webkit-mask:var(--op-link-icon, url(\\/static/img/icons/external-link.svg\\)) no-repeat center/contain;mask:var(--op-link-icon, url(\\/static/img/icons/external-link.svg\\)) no-repeat center/contain}.mdx-content a:is(\[href\*=\\://github.com/\\\], \[href\$=\\://github.com\\\], \[href\*=\\.github.com/\\\], \[href\$=\\.github.com\\\], \[href\*=\\://github.blog/\\\], \[href\$=\\://github.blog\\\]){--op-link-icon:url(\\/static/img/logos/github.svg\\)}#content\>h5,#content\>h6{font-weight:700}.accordion{background-color:var(--op-icy-blue)}.dark .accordion{background-color:var(--op-surface-card-dark)}.accordion .mint-bg-white{padding:1rem}.accordion .mint-bg-white \[class\*=-mx-\]{margin:0!important;padding:0!important;width:100%!important;--page-padding:0px}#footer img.nav-logo.dark\\:hidden,#footer\>div\>div.flex.flex-col.md\\:flex-row.gap-8.justify-between.min-h-\\\[76px\\\]\>div.flex.flex-col.sm\\:grid.max-md\\:\\!grid-cols-2.gap-8.flex-1\>div\>div\>p{display:none!important}footer#footer.advanced-footer{display:flex!important}footer#footer{align-items:unset;background-color:var(--op-iron-ore);color:var(--op-white)}#footer img.nav-logo.dark\\:block{display:block!important}#footer\>div.flex.w-full.flex-col.gap-12.justify-between.px-8.py-16.md\\:py-20.lg\\:py-28.z-20\>div.h-\\\[1px\\\].w-full.bg-gray-100.dark\\:bg-white\\/5{background-color:var(--op-border-footer-dark)}#footer\>div.flex.w-full.flex-col.gap-12.justify-between.px-8.py-16.md\\:py-20.lg\\:py-28.z-20{margin:0 auto}footer .email_form{max-width:650px;margin:auto}.codeblock_accordion{margin-top:10px}.codeblock_accordion .code-block{margin:0!important}.codeblock_accordion\>div\>.code-block,.codeblock_accordion\>div\>.code-block\>div:nth-child(2){border-bottom-left-radius:0;border-bottom-right-radius:0}.codeblock_accordion .see_results_container{border-bottom-left-radius:1rem;border-bottom-right-radius:1rem}.codeblock_accordion .see_results_container .code-block,.codeblock_accordion .see_results_container .code-block\>div:nth-child(2){border-top-left-radius:0;border-top-right-radius:0}.hide_bullets ul li{padding-left:0!important}.hide_bullets ul li::before{content:none!important}#navigation-items a\[href^=\\/\\\]:not(\[href^=\\//\\\])\>div\>div:nth-child(2){display:none}a\[href^=\\//\\\] .flex-shrink-0 svg,a\[href^=http\] .flex-shrink-0 svg{display:block}h1 code,h2 code,h3 code,h4 code,h5 code,h6 code{white-space:nowrap}h2.flex.whitespace-pre-wrap span.cursor-pointer svg.icon,h4.flex.whitespace-pre-wrap span.cursor-pointer svg.icon{margin:0;vertical-align:baseline}table thead tr th code{padding-left:0!important;padding-right:0!important}.tabs.tab-container{padding:0 .8rem 1rem;border:1px solid var(--op-border-subtle);border-radius:4px}.dark .tabs.tab-container{border-color:var(--op-border-subtle-dark)}.nav-tabs-item:nth-child(3),nav-tabs-item:nth-child(3){--tab-gap-before-divider:8px;--nav-tabs-item-gap:0.5rem;margin-left:var(--tab-gap-before-divider)!important;padding-left:calc(var(--tab-gap-before-divider) + var(--nav-tabs-item-gap))!important;border-left:1px solid var(--op-border-navbar-light)}.dark .nav-tabs-item:nth-child(3),.dark nav-tabs-item:nth-child(3){border-left-color:var(--op-border-navbar-dark)}.peer.is-center~div:has(.tutorial-explorer){max-width:84rem!important}@media (max-width:639px){.tutorial-filter-bar{display:grid!important;grid-template-columns:minmax(0,1fr)}.tutorial-filter-search,.tutorial-filter-tools,.tutorial-filter-topic{grid-column:1/-1;width:100%}.tutorial-filter-search input{width:100%!important}.tutorial-filter-dropdown\>button,.tutorial-filter-menu{width:100%}.tutorial-filter-dropdown\>button{justify-content:space-between}.tutorial-filter-menu{min-width:0!important}.tutorial-filter-sort{grid-column:1/-1;justify-self:end;margin-left:0!important}}#navbar.is-custom .nav-tabs-item\[data-active\]{color:var(--op-text-body);text-shadow:none}.dark \#navbar.is-custom .nav-tabs-item\[data-active\]{color:var(--op-text-body-dark)}#navbar.is-custom .nav-tabs-item\[data-active\]\>div{background-color:transparent!important}#navbar.is-custom .nav-tabs-item\[data-active\]:hover\>div{background-color:rgb(229 231 235)!important}.dark \#navbar.is-custom .nav-tabs-item\[data-active\]:hover\>div{background-color:rgb(55 65 81)!important}#footer .api-sdk-terms-notice{margin:0;padding:0 0 1.25rem;font-size:.875rem;font-style:italic;line-height:1.5;text-align:center;color:rgb(251 248 244/.8);pointer-events:auto}#footer .api-sdk-terms-notice a{position:relative;z-index:2;color:var(--op-cornflower);text-decoration:underline;text-underline-offset:2px;pointer-events:auto;cursor:pointer}"}\],"page":{"pagePath":"connect/terraform","slug":"/connect/terraform","pageMetadata":{"title":"Use the 1Password Terraform provider with Connect","sidebarTitle":"Terraform","og:description":"Use a 1Password Connect server to reference, create, or update items in your vaults with the 1Password Terraform provider.","description":null,"href":"/connect/terraform"},"pageType":"default","mdx":{"mdxSource":{"compiledSource":"\\use strict\\;const{Fragment:\_Fragment,jsx:\_jsx,jsxs:\_jsxs}=arguments\[0\];const{useMDXComponents:\_provideComponents}=arguments\[0\];const Image=({src,darkSrc,alt,width,border,height,round})=\>{const classNames=\[\`mint-mx-4\`\];if(border){classNames.push(\`mint-rounded-sm\`)}if(round){classNames.push(\`mint-rounded-lg\`)}const style={};if(width)style.width=typeof width===\`number\`?\`\${width}px\`:width;if(height)style.height=typeof height===\`number\`?\`\${height}px\`:height;return darkSrc?\_jsxs(\_Fragment,{children:\[\_jsx(\`img\`,{src,alt,className:\[...classNames,\`dark:mint-hidden\`\].join(\` \`),style:Object.keys(style).length\>0?style:undefined}),\_jsx(\`img\`,{src:darkSrc,alt,className:\[...classNames,\`mint-hidden dark:mint-block\`\].join(\` \`),style:Object.keys(style).length\>0?style:undefined,onError:e=\>{e.target.src=src}})\]}):\_jsx(\`img\`,{src,alt,className:classNames.join(\` \`),style:Object.keys(style).length\>0?style:undefined})};const YouTubeVideo=({src,title,alt})=\>{const{Frame}=\_provideComponents()\|\|{};if(!Frame)\_missingMdxReference(\`Frame\`,true);return \_jsx(Frame,{children:\_jsx(\`iframe\`,{className:\`mint-w-full mint-aspect-video mint-rounded-xl\`,src,title:alt??title,allow:\`accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture\`,allowFullScreen:true})})};const Small=({children})=\>{return \_jsx(\`small\`,{children})};function \_createMdxContent(props){const \_components={a:\`a\`,code:\`code\`,h5:\`h5\`,li:\`li\`,ol:\`ol\`,p:\`p\`,pre:\`pre\`,span:\`span\`,strong:\`strong\`,tbody:\`tbody\`,td:\`td\`,th:\`th\`,thead:\`thead\`,tr:\`tr\`,ul:\`ul\`,...\_provideComponents(),...props.components},{CodeBlock,Columns,Frame,Heading,Tab,Table,Tabs,Tip,\_MdxComponentBoundary}=\_components;if(!CodeBlock)\_missingMdxReference(\`CodeBlock\`,true);if(!Columns)\_missingMdxReference(\`Columns\`,true);if(!Frame)\_missingMdxReference(\`Frame\`,true);if(!Heading)\_missingMdxReference(\`Heading\`,true);if(!Tab)\_missingMdxReference(\`Tab\`,true);if(!Table)\_missingMdxReference(\`Table\`,true);if(!Tabs)\_missingMdxReference(\`Tabs\`,true);if(!Tip)\_missingMdxReference(\`Tip\`,true);if(!\_MdxComponentBoundary)\_missingMdxReference(\`\_MdxComponentBoundary\`,true);return \_jsxs(\_Fragment,{children:\[\_jsxs(\_components.p,{children:\[\`With the \`,\_jsx(\_components.a,{href:\`https://github.com/1Password/terraform-provider-onepassword\`,children:\`1Password Terraform provider\`}),\`, you can reference, create, or update items in your vaults using a \`,\_jsx(\_components.a,{href:\`/secrets-automation#1password-connect-servers\`,children:\`1Password Connect Server\`}),\`, a \`,\_jsx(\_components.a,{href:\`/secrets-automation#1password-service-accounts\`,children:\`1Password Service Account\`}),\`, or the 1Password desktop app.\`\]}),\`\n\`,\_jsx(\_MdxComponentBoundary,{name:\`YouTubeVideo\`,children:\_jsx(YouTubeVideo,{src:\`https://www.youtube.com/embed/92yvxV7F4E0\`,title:\`Using 1Password Connect with Terraform\`})}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`requirements\`,children:\`Requirements\`}),\`\n\`,\_jsxs(Tabs,{queryString:\`workflow-type\`,groupId:\`requirements\`,children:\[\_jsx(Tab,{value:\`connect\`,title:\`Connect server\`,id:\`connect-server\`,children:\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/connect/get-started/#step-1\`,children:\`Create a Connect server.\`})}),\`\n\`\]})}),\_jsx(Tab,{value:\`service-account\`,title:\`Service account\`,id:\`service-account\`,children:\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/service-accounts/get-started#create-a-service-account\`,children:\`Create a service account\`})}),\`\n\`\]})}),\_jsxs(Tab,{value:\`1password-app\`,title:\`1Password app\`,id:\`1password-app\`,children:\[\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`Install the latest \`,\_jsx(\_components.a,{href:\`https://support.1password.com/betas#install-a-prerelease-version-of-the-1password-app\`,children:\`beta release\`}),\` of the 1Password desktop app.\`\]}),\`\n\`\]}),\_jsxs(Tip,{children:\[\`If you don’t see the option to update to the latest beta in the app, you can download it directly for \`,\_jsx(\_components.a,{href:\`https://releases.1password.com/mac/beta/\`,children:\`Mac\`}),\`, \`,\_jsx(\_components.a,{href:\`https://releases.1password.com/windows/beta/\`,children:\`Windows\`}),\`, or \`,\_jsx(\_components.a,{href:\`https://releases.1password.com/linux/beta/\`,children:\`Linux\`}),\`.\`\]})\]})\]}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`get-started\`,children:\`Get started\`}),\`\n\`,\_jsxs(Tabs,{queryString:\`workflow-type\`,groupId:\`get-started\`,children:\[\_jsxs(Tab,{value:\`connect\`,title:\`Connect server\`,id:\`connect-server-2\`,children:\[\_jsx(\_components.p,{children:\`To use the 1Password Terraform provider with a Connect server:\`}),\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Specify the Connect server token.\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`You can set this value with the \`,\_jsx(\_components.code,{children:\`OP_CONNECT_TOKEN\`}),\` environment variable or with the \`,\_jsx(\_components.code,{children:\`connect_token\`}),\` field in the provider configuration.\`\]}),\`\n\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`\n\`,\_jsx(\_components.p,{children:\`Specify the Connect server hostname, URL, or IP address.\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`You can set this value with the \`,\_jsx(\_components.code,{children:\`OP_CONNECT_HOST\`}),\` environment variable or with the \`,\_jsx(\_components.code,{children:\`connect_url\`}),\` field in the provider configuration.\`\]}),\`\n\`\]}),\`\n\`\]})\]}),\_jsxs(Tab,{value:\`service-account\`,title:\`Service account\`,id:\`service-account-2\`,children:\[\_jsx(\_components.p,{children:\`To use the 1Password Terraform provider with a service account, you’ll need to provide your service account token.\`}),\_jsxs(\_components.p,{children:\[\`You can set this value with the \`,\_jsx(\_components.code,{children:\`OP_SERVICE_ACCOUNT_TOKEN\`}),\` environment variable or with the \`,\_jsx(\_components.code,{children:\`service_account_token\`}),\` field in the provider configuration.\`\]})\]}),\_jsxs(Tab,{value:\`1password-app\`,title:\`1Password app\`,id:\`1password-app-2\`,\\data-child-tab-ids\\:\`\[\\mac\\,\\windows\\,\\linux\\\]\`,children:\[\_jsxs(\_components.p,{children:\[\`First, turn on the “Integrate with 1Password SDKs” setting in the 1Password desktop app. If you don’t see this setting, make sure you’ve installed the \`,\_jsx(\_components.a,{href:\`https://support.1password.com/betas#install-a-prerelease-version-of-the-1password-app\`,children:\`beta version\`}),\` of the app.\`\]}),\_jsxs(Tabs,{groupId:\`operating-systems\`,children:\[\_jsx(Tab,{value:\`mac\`,title:\`Mac\`,id:\`mac\`,children:\_jsxs(Columns,{cols:2,children:\[\_jsx(\`div\`,{children:\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`Open and unlock the \`,\_jsx(\_components.a,{href:\`https://1password.com/downloads/\`,children:\`1Password app\`}),\`.\`\]}),\`\n\`,\_jsx(\_components.li,{children:\`Select your account or collection at the top of the sidebar.\`}),\`\n\`,\_jsxs(\_components.li,{children:\[\`Navigate to \`,\_jsx(\_components.strong,{children:\`Settings\`}),\` \> \`,\_jsx(\_components.strong,{children:\_jsx(\_components.a,{href:\`onepassword://settings/developers\`,children:\`Developer\`})}),\`.\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`Under Developer Integrations, select \`,\_jsx(\_components.strong,{children:\`Integrate with 1Password SDKs\`}),\`.\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`If you want to authenticate with Touch ID, navigate to \`,\_jsx(\_components.strong,{children:\`Settings\`}),\` \> \`,\_jsx(\_components.strong,{children:\_jsx(\_components.a,{href:\`onepassword://settings/security\`,children:\`Security\`})}),\`, then turn on \`,\_jsx(\_components.strong,{children:\_jsx(\_components.a,{href:\`https://support.1password.com/touch-id-mac/\`,children:\`Unlock using Touch ID\`})}),\`.\`\]}),\`\n\`\]})}),\_jsx(\`div\`,{children:\_jsx(Frame,{children:\_jsx(\_MdxComponentBoundary,{name:\`Image\`,children:\_jsx(Image,{round:true,border:true,alt:\`The Integrate with 1Password SDKs setting\`,src:\`/static/img/developer-integrations-sdks-light.png\`,darkSrc:\`/static/img/developer-integrations-sdks-dark.png\`})})})})\]})}),\_jsx(Tab,{value:\`windows\`,title:\`Windows\`,id:\`windows\`,children:\_jsxs(Columns,{cols:2,children:\[\_jsx(\`div\`,{children:\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`Open and unlock the \`,\_jsx(\_components.a,{href:\`https://1password.com/downloads/\`,children:\`1Password app\`}),\`.\`\]}),\`\n\`,\_jsx(\_components.li,{children:\`Select your account or collection at the top of the sidebar.\`}),\`\n\`,\_jsxs(\_components.li,{children:\[\`Navigate to \`,\_jsx(\_components.strong,{children:\`Settings\`}),\` \> \`,\_jsx(\_components.strong,{children:\_jsx(\_components.a,{href:\`onepassword://settings/developers\`,children:\`Developer\`})}),\`.\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`Under Developer Integrations, select \`,\_jsx(\_components.strong,{children:\`Integrate with 1Password SDKs\`}),\`.\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`If you want to authenticate with Windows Hello, navigate to \`,\_jsx(\_components.strong,{children:\`Settings\`}),\` \> \`,\_jsx(\_components.strong,{children:\_jsx(\_components.a,{href:\`onepassword://settings/security\`,children:\`Security\`})}),\`, then turn on \`,\_jsx(\_components.strong,{children:\_jsx(\_components.a,{href:\`https://support.1password.com/windows-hello/\`,children:\`Unlock using Windows Hello\`})}),\`.\`\]}),\`\n\`\]})}),\_jsx(\`div\`,{children:\_jsx(Frame,{children:\_jsx(\_MdxComponentBoundary,{name:\`Image\`,children:\_jsx(Image,{round:true,border:true,alt:\`The Integrate with 1Password SDKs setting\`,src:\`/static/img/developer-integrations-sdks-light.png\`,darkSrc:\`/static/img/developer-integrations-sdks-dark.png\`})})})})\]})}),\_jsx(Tab,{value:\`linux\`,title:\`Linux\`,id:\`linux\`,children:\_jsxs(Columns,{cols:2,children:\[\_jsx(\`div\`,{children:\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`Open and unlock the \`,\_jsx(\_components.a,{href:\`https://1password.com/downloads/\`,children:\`1Password app\`}),\`.\`\]}),\`\n\`,\_jsx(\_components.li,{children:\`Select your account or collection at the top of the sidebar.\`}),\`\n\`,\_jsxs(\_components.li,{children:\[\`Navigate to \`,\_jsx(\_components.strong,{children:\`Settings\`}),\` \> \`,\_jsx(\_components.strong,{children:\_jsx(\_components.a,{href:\`onepassword://settings/developers\`,children:\`Developer\`})}),\`.\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`Under Developer Integrations, select \`,\_jsx(\_components.strong,{children:\`Integrate with 1Password SDKs\`}),\`.\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`If you want to authenticate the same way you sign in to your Linux account, navigate to \`,\_jsx(\_components.strong,{children:\`Settings\`}),\` \> \`,\_jsx(\_components.strong,{children:\_jsx(\_components.a,{href:\`onepassword://settings/security\`,children:\`Security\`})}),\`, then turn on \`,\_jsx(\_components.strong,{children:\_jsx(\_components.a,{href:\`https://support.1password.com/system-authentication-linux/\`,children:\`Unlock using system authentication\`})}),\`.\`\]}),\`\n\`\]})}),\_jsx(\`div\`,{children:\_jsx(Frame,{children:\_jsx(\_MdxComponentBoundary,{name:\`Image\`,children:\_jsx(Image,{round:true,border:true,alt:\`The Integrate with 1Password SDKs setting\`,src:\`/static/img/developer-integrations-sdks-light.png\`,darkSrc:\`/static/img/developer-integrations-sdks-dark.png\`})})})})\]})})\]}),\_jsx(\_components.p,{children:\`Then provide your account name or ID in the provider configuration:\`}),\_jsxs(\_components.ol,{children:\[\`\n\`,\_jsxs(\_components.li,{children:\[\`Get the name of your 1Password account as it appears at the top of the left sidebar in the 1Password desktop app. Alternatively, you can use \`,\_jsx(\_components.a,{href:\`/cli/get-started\`,children:\`1Password CLI\`}),\` to run \`,\_jsx(\_components.code,{children:\`op account get\`}),\` to find your account ID.\`\]}),\`\n\`,\_jsxs(\_components.li,{children:\[\`Set the \`,\_jsx(\_components.code,{children:\`OP_ACCOUNT\`}),\` environment variable or \`,\_jsx(\_components.code,{children:\`account\`}),\` in the provider configuration to your account name or ID.\`\]}),\`\n\`\]}),\_jsx(\_components.p,{children:\`Run a Terraform command that requires authentication, and you’ll be prompted to authenticate in the same way you unlock your 1Password app, like with biometrics or your 1Password account password.\`})\]})\]}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`reference\`,children:\`Reference\`}),\`\n\`,\_jsx(\_components.p,{children:\`The following sections contain reference information for the 1Password Terraform provider:\`}),\`\n\`,\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`#configuration\`,children:\`Configuration\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`#resources\`,children:\`Resources\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`#data-sources\`,children:\`Data sources\`})}),\`\n\`\]}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`configuration\`,children:\`Configuration\`}),\`\n\`,\_jsx(\_components.p,{children:\`The 1Password Terraform provider has fields you must set before you can use it with a 1Password Connect server, service account, or the 1Password desktop app. The following table describes each field.\`}),\`\n\`,\_jsxs(Table,{children:\[\_jsx(\_components.thead,{children:\_jsxs(\_components.tr,{children:\[\_jsx(\_components.th,{children:\`Field\`}),\_jsx(\_components.th,{children:\`Type\`}),\_jsx(\_components.th,{children:\`Description\`}),\_jsx(\_components.th,{children:\`Required\`})\]})}),\_jsxs(\_components.tbody,{children:\[\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`connect_token\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsxs(\_components.td,{children:\[\`A valid token for the 1Password Connect server. You can also source the value from the \`,\_jsx(\_components.code,{children:\`OP_CONNECT_TOKEN\`}),\` environment variable.\`\]}),\_jsx(\_components.td,{children:\`Required if using a Connect server.\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`connect_url\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsxs(\_components.td,{children:\[\`The HTTP(s) URL of the 1Password Connect server. You can also source the value from the \`,\_jsx(\_components.code,{children:\`OP_CONNECT_HOST\`}),\` environment variable.\`\]}),\_jsx(\_components.td,{children:\`Required if using a Connect server.\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`service_account_token\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsxs(\_components.td,{children:\[\`A valid token for the 1Password Service Account. You can also source the value from the \`,\_jsx(\_components.code,{children:\`OP_SERVICE_ACCOUNT_TOKEN\`}),\` environment variable.\`\]}),\_jsx(\_components.td,{children:\`Required if using a service account.\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`account\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsxs(\_components.td,{children:\[\`The 1Password account name as it appears at the top left of the sidebar in the 1Password desktop app. Alternatively, the 1Password account ID. You can also source the value from the \`,\_jsx(\_components.code,{children:\`ACCOUNT\`}),\` environment variable.\`\]}),\_jsx(\_components.td,{children:\`Required if using the 1Password desktop app integration.\`})\]})\]})\]}),\`\n\`,\_jsx(\_components.p,{children:\`You can use the following environment variables to specify configuration values.\`}),\`\n\`,\_jsxs(Table,{children:\[\_jsx(\_components.thead,{children:\_jsxs(\_components.tr,{children:\[\_jsx(\_components.th,{children:\`Environment variable\`}),\_jsx(\_components.th,{children:\`Description\`}),\_jsx(\_components.th,{children:\`Configuration field\`})\]})}),\_jsxs(\_components.tbody,{children:\[\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`OP_CONNECT_TOKEN\`})}),\_jsx(\_components.td,{children:\`A valid token for the 1Password Connect server.\`}),\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`connect_token\`})})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`OP_CONNECT_HOST\`})}),\_jsx(\_components.td,{children:\`The hostname, IP address, or URL of the 1Password Connect server.\`}),\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`connect_url\`})})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`OP_SERVICE_ACCOUNT_TOKEN\`})}),\_jsx(\_components.td,{children:\`A valid token for the 1Password Service Account.\`}),\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`service_account_token\`})})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`OP_ACCOUNT\`})}),\_jsx(\_components.td,{children:\`The 1Password account name as it appears at the top left of the sidebar in the 1Password desktop app. Alternatively, the 1Password account ID.\`}),\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`account\`})})\]})\]})\]}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`configuration-examples\`,children:\`Configuration examples\`}),\`\n\`,\_jsx(\_components.p,{children:\`The following code blocks show configuration examples.\`}),\`\n\`,\_jsx(Tip,{children:\`The following examples use environment variables. Make sure to set the environment variables beforehand or use plain text.\`}),\`\n\`,\_jsxs(Tabs,{queryString:\`workflow-type\`,groupId:\`get-started\`,children:\[\_jsxs(Tab,{value:\`connect\`,title:\`Connect server\`,id:\`connect-server-3\`,children:\[\_jsx(\_components.p,{children:\`The following example shows a provider configuration using a Connect server:\`}),\_jsx(CodeBlock,{filename:\`connect-example.tf\`,numberOfLines:\`4\`,language:\`terraform\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`terraform\`,children:\_jsxs(\_components.code,{language:\`terraform\`,numberOfLines:\`4\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#4EC9B0\`},children:\`provider\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#4FC1FF\`},children:\` \\onepassword\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` {\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` connect_url\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\OP_CONNECT_HOST\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` connect_token\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\OP_CONNECT_TOKEN\\\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`}\`})}),\`\n\`\]})})})\]}),\_jsxs(Tab,{value:\`service-account\`,title:\`Service account\`,id:\`service-account-3\`,children:\[\_jsx(\_components.p,{children:\`The following example shows a provider configuration using a service account:\`}),\_jsx(CodeBlock,{filename:\`service-account-example.tf\`,numberOfLines:\`3\`,language:\`terraform\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`terraform\`,children:\_jsxs(\_components.code,{language:\`terraform\`,numberOfLines:\`3\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#4EC9B0\`},children:\`provider\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#4FC1FF\`},children:\` \\onepassword\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` {\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` service_account_token\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\OP_SERVICE_ACCOUNT_TOKEN\\\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`}\`})}),\`\n\`\]})})})\]}),\_jsxs(Tab,{value:\`1password-app\`,title:\`1Password app\`,id:\`1password-app-3\`,children:\[\_jsx(\_components.p,{children:\`The following example shows a provider configuration using the 1Password desktop app:\`}),\_jsx(CodeBlock,{filename:\`1password-account-example.tf\`,numberOfLines:\`3\`,language:\`terraform\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`terraform\`,children:\_jsxs(\_components.code,{language:\`terraform\`,numberOfLines:\`3\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#4EC9B0\`},children:\`provider\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#4FC1FF\`},children:\` \\onepassword\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` {\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` account\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\OP_ACCOUNT\\\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`}\`})}),\`\n\`\]})})})\]})\]}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`resources\`,children:\`Resources\`}),\`\n\`,\_jsx(\_components.p,{children:\`The 1Password Terraform provider has the following resources:\`}),\`\n\`,\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsx(\_components.li,{children:\_jsxs(\_components.a,{href:\`#item-resource\`,children:\[\_jsx(\_components.code,{children:\`onepassword_item\`}),\` resource\`\]})}),\`\n\`\]}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`item-resource\`,children:\`Item resource\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`The \`,\_jsx(\_components.code,{children:\`onepassword_item\`}),\` resource represents a 1Password item. You can import a \`,\_jsx(\_components.code,{children:\`onepassword_item\`}),\` with the following syntax:\`\]}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`1\`,language:\`shellscript\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`shellscript\`,children:\_jsxs(\_components.code,{language:\`shellscript\`,numberOfLines:\`1\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#DCDCAA\`},children:\`terraform\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` import\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` onepassword_item.\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\u003c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`item_nam\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`e\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` vaults/\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\u003c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`vault_uui\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`d\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`/items/\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\u003c\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`item_uui\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\`d\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`\>\`})\]}),\`\n\`\]})})}),\`\n\`,\_jsx(\_components.h5,{children:\`Schema\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`The following tables describe the \`,\_jsx(\_components.code,{children:\`onepassword_item\`}),\` resource schema.\`\]}),\`\n\`,\_jsxs(Table,{children:\[\_jsx(\_components.thead,{children:\_jsxs(\_components.tr,{children:\[\_jsx(\_components.th,{children:\`Field\`}),\_jsx(\_components.th,{children:\`Type\`}),\_jsx(\_components.th,{children:\`Description\`}),\_jsx(\_components.th,{children:\`Required\`}),\_jsx(\_components.th,{children:\`Access\`})\]})}),\_jsxs(\_components.tbody,{children:\[\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`vault\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The UUID of the vault the item is in.\`}),\_jsx(\_components.td,{children:\`Yes\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`category\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsxs(\_components.td,{children:\[\`The category of the item. \`,\_jsx(\`br\`,{}),\_jsx(\`br\`,{}),\_jsx(\_components.strong,{children:\`Acceptable values\`}),\`: \`,\_jsx(\_components.code,{children:\`login\`}),\`, \`,\_jsx(\_components.code,{children:\`password\`}),\`, or \`,\_jsx(\_components.code,{children:\`database\`}),\`.\`\]}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`database\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The name of the database. Only applies to the database category.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`hostname\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The address where the database can be found. Only applies to the database category.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`note_value\`})}),\_jsx(\_components.td,{children:\`String, Sensitive\`}),\_jsx(\_components.td,{children:\`Secure note value.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`note_value_wo\`})}),\_jsx(\_components.td,{children:\`String, Sensitive\`}),\_jsx(\_components.td,{children:\`A write-only secure note value. This value is not stored in the state and is intended for use with ephemeral values. Requires Terraform 1.11 or later.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\_jsx(\_components.a,{href:\`https://developer.hashicorp.com/terraform/language/resources/ephemeral#write-only-arguments\`,children:\`Write-only\`})})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`note_value_wo_version\`})}),\_jsx(\_components.td,{children:\`Number\`}),\_jsxs(\_components.td,{children:\[\`An integer that must be incremented to trigger an update to the \`,\_jsx(\_components.code,{children:\`note_value_wo\`}),\` field.\`\]}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\_jsx(\_components.a,{href:\`https://developer.hashicorp.com/terraform/language/resources/ephemeral#write-only-arguments\`,children:\`Write-only\`})})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`password\`})}),\_jsx(\_components.td,{children:\`String, Sensitive\`}),\_jsx(\_components.td,{children:\`The password for the item.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`password_wo\`})}),\_jsx(\_components.td,{children:\`String, Sensitive\`}),\_jsx(\_components.td,{children:\`A write-only password. This value is not stored in the state and is intended for use with ephemeral values. Requires Terraform 1.11 or later.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\_jsx(\_components.a,{href:\`https://developer.hashicorp.com/terraform/language/resources/ephemeral#write-only-arguments\`,children:\`Write-only\`})})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`password_wo_version\`})}),\_jsx(\_components.td,{children:\`Number\`}),\_jsxs(\_components.td,{children:\[\`An integer that must be incremented to trigger an update to the \`,\_jsx(\_components.code,{children:\`password_wo\`}),\` field.\`\]}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\_jsx(\_components.a,{href:\`https://developer.hashicorp.com/terraform/language/resources/ephemeral#write-only-arguments\`,children:\`Write-only\`})})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`password_recipe\`})}),\_jsx(\_components.td,{children:\`Block List, Max: 1\`}),\_jsxs(\_components.td,{children:\[\`The password recipe for the item. Only applies to Login and Password items. See \`,\_jsx(\_components.a,{href:\`#password_recipe\`,children:\_jsx(\_components.code,{children:\`password_recipe\`})}),\`.\`\]}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`password_wo\`})}),\_jsx(\_components.td,{children:\`String, Sensitive\`}),\_jsx(\_components.td,{children:\`A write-only password. This value is not stored in the state and is intended for use with ephemeral values. Requires Terraform 1.11 or later.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\_jsx(\_components.a,{href:\`https://developer.hashicorp.com/terraform/language/resources/ephemeral#write-only-arguments\`,children:\`Write-only\`})})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`password_wo_version\`})}),\_jsx(\_components.td,{children:\`Number\`}),\_jsxs(\_components.td,{children:\[\`An integer that must be incremented to trigger an update to the \`,\_jsx(\_components.code,{children:\`password_wo\`}),\` field.\`\]}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\_jsx(\_components.a,{href:\`https://developer.hashicorp.com/terraform/language/resources/ephemeral#write-only-arguments\`,children:\`Write-only\`})})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`port\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The port the database is listening on. Only applies to the database category.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`section\`})}),\_jsx(\_components.td,{children:\`Block List\`}),\_jsxs(\_components.td,{children:\[\`A list of custom sections in the item. See \`,\_jsx(\_components.a,{href:\`#section\`,children:\_jsx(\_components.code,{children:\`section\`})}),\`.\`\]}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`section_map\`})}),\_jsx(\_components.td,{children:\`Map of Object\`}),\_jsxs(\_components.td,{children:\[\`A map of custom sections for the item, where \`,\_jsx(\_components.code,{children:\`label\`}),\` is the map key. See \`,\_jsx(\_components.a,{href:\`#section_map\`,children:\_jsx(\_components.code,{children:\`section_map\`})}),\`.\`\]}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`tags\`})}),\_jsx(\_components.td,{children:\`List of String\`}),\_jsx(\_components.td,{children:\`An array of strings representing the tags assigned to the item.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`title\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The title of the item.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`type\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsxs(\_components.td,{children:\[\`The type of database. Only applies to the database category. \`,\_jsx(\`br\`,{}),\_jsx(\`br\`,{}),\_jsx(\_components.strong,{children:\`Acceptable values\`}),\`: \`,\_jsx(\_components.code,{children:\`db2\`}),\`, \`,\_jsx(\_components.code,{children:\`filemaker\`}),\`, \`,\_jsx(\_components.code,{children:\`msaccess\`}),\`, \`,\_jsx(\_components.code,{children:\`mssql\`}),\`, \`,\_jsx(\_components.code,{children:\`mysql\`}),\`, \`,\_jsx(\_components.code,{children:\`oracle\`}),\`, \`,\_jsx(\_components.code,{children:\`postgresql\`}),\`, \`,\_jsx(\_components.code,{children:\`sqlite\`}),\` or \`,\_jsx(\_components.code,{children:\`other\`}),\`.\`\]}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`url\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The primary URL for the item.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`username\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The username for the item.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`id\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsxs(\_components.td,{children:\[\`The Terraform resource identifier for the item in the format \`,\_jsx(\_components.code,{children:\`vaults/\u003cvault_id\>/items/\u003citem_id\>\`}),\`.\`\]}),\_jsx(\_components.td,{children:\`N/A\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`uuid\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The UUID of the item. Item identifiers are unique within a specific vault.\`}),\_jsx(\_components.td,{children:\`N/A\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]})\]})\]}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`password_recipe\`,children:\_jsx(\_components.code,{children:\`password_recipe\`})}),\`\n\`,\_jsx(Tip,{children:\`Password recipes can only be added to Login and Password items.\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`The nested schema for the \`,\_jsx(\_components.code,{children:\`password_recipe\`}),\` field:\`\]}),\`\n\`,\_jsxs(Table,{children:\[\_jsx(\_components.thead,{children:\_jsxs(\_components.tr,{children:\[\_jsx(\_components.th,{children:\`Field\`}),\_jsx(\_components.th,{children:\`Type\`}),\_jsx(\_components.th,{children:\`Description\`}),\_jsx(\_components.th,{children:\`Required\`}),\_jsx(\_components.th,{children:\`Access\`})\]})}),\_jsxs(\_components.tbody,{children:\[\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`digits\`})}),\_jsx(\_components.td,{children:\`Boolean\`}),\_jsxs(\_components.td,{children:\[\`Use digits \`,\_jsx(\_components.code,{children:\`\[0-9\]\`}),\` when generating the password.\`\]}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`length\`})}),\_jsx(\_components.td,{children:\`Number\`}),\_jsx(\_components.td,{children:\`The length of the password to be generated.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`symbols\`})}),\_jsx(\_components.td,{children:\`Boolean\`}),\_jsxs(\_components.td,{children:\[\`Use symbols \`,\_jsx(\_components.code,{children:\`\[!@.-\_\*\]\`}),\` when generating the password.\`\]}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]})\]})\]}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`section\`,children:\_jsx(\_components.code,{children:\`section\`})}),\`\n\`,\_jsxs(\_components.p,{children:\[\`The nested schema for the \`,\_jsx(\_components.code,{children:\`section\`}),\` field:\`\]}),\`\n\`,\_jsxs(Table,{children:\[\_jsx(\_components.thead,{children:\_jsxs(\_components.tr,{children:\[\_jsx(\_components.th,{children:\`Field\`}),\_jsx(\_components.th,{children:\`Type\`}),\_jsx(\_components.th,{children:\`Description\`}),\_jsx(\_components.th,{children:\`Required\`}),\_jsx(\_components.th,{children:\`Access\`})\]})}),\_jsxs(\_components.tbody,{children:\[\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`label\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The label for the section.\`}),\_jsx(\_components.td,{children:\`Yes\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`field\`})}),\_jsx(\_components.td,{children:\`Block List\`}),\_jsxs(\_components.td,{children:\[\`A list of custom fields in the section. See \`,\_jsx(\_components.a,{href:\`#item-resource-section-field\`,children:\_jsx(\_components.code,{children:\`section.field\`})}),\`.\`\]}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`id\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`A unique identifier for the section.\`}),\_jsx(\_components.td,{children:\`N/A\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]})\]})\]}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`section_map\`,children:\_jsx(\_components.code,{children:\`section_map\`})}),\`\n\`,\_jsxs(\_components.p,{children:\[\`The nested schema for the \`,\_jsx(\_components.code,{children:\`section_map\`}),\` field:\`\]}),\`\n\`,\_jsxs(Table,{children:\[\_jsx(\_components.thead,{children:\_jsxs(\_components.tr,{children:\[\_jsx(\_components.th,{children:\`Field\`}),\_jsx(\_components.th,{children:\`Type\`}),\_jsx(\_components.th,{children:\`Description\`}),\_jsx(\_components.th,{children:\`Required\`}),\_jsx(\_components.th,{children:\`Access\`})\]})}),\_jsxs(\_components.tbody,{children:\[\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`field_map\`})}),\_jsx(\_components.td,{children:\`Map of Object\`}),\_jsxs(\_components.td,{children:\[\`A map of custom fields in the section, where \`,\_jsx(\_components.code,{children:\`label\`}),\` is the map key. See \`,\_jsx(\_components.a,{href:\`#field_map\`,children:\_jsx(\_components.code,{children:\`field_map\`})}),\`.\`\]}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`id\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`A unique identifier for the section.\`}),\_jsx(\_components.td,{children:\`N/A\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]})\]})\]}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`item-resource-section-field\`,children:\_jsx(\_components.code,{children:\`section.field\`})}),\`\n\`,\_jsxs(\_components.p,{children:\[\`The nested schema for the \`,\_jsx(\_components.code,{children:\`section.field\`}),\` field:\`\]}),\`\n\`,\_jsxs(Table,{children:\[\_jsx(\_components.thead,{children:\_jsxs(\_components.tr,{children:\[\_jsx(\_components.th,{children:\`Field\`}),\_jsx(\_components.th,{children:\`Type\`}),\_jsx(\_components.th,{children:\`Description\`}),\_jsx(\_components.th,{children:\`Required\`}),\_jsx(\_components.th,{children:\`Access\`})\]})}),\_jsxs(\_components.tbody,{children:\[\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`label\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The label for the field.\`}),\_jsx(\_components.td,{children:\`Yes\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`id\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`A unique identifier for the field.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`password_recipe\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsxs(\_components.td,{children:\[\`The password for the item. Only applies to Login and Password items. See \`,\_jsx(\_components.a,{href:\`#item-resource-section-field-password-recipe\`,children:\_jsx(\_components.code,{children:\`section.field.password_recipe\`})}),\`.\`\]}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`type\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsxs(\_components.td,{children:\[\`The type of value stored in the field. \`,\_jsx(\`br\`,{}),\_jsx(\`br\`,{}),\_jsx(\_components.strong,{children:\`Acceptable values\`}),\`: \`,\_jsx(\_components.code,{children:\`STRING\`}),\`, \`,\_jsx(\_components.code,{children:\`EMAIL\`}),\`, \`,\_jsx(\_components.code,{children:\`CONCEALED\`}),\`, \`,\_jsx(\_components.code,{children:\`URL\`}),\`, \`,\_jsx(\_components.code,{children:\`OTP\`}),\`, \`,\_jsx(\_components.code,{children:\`DATE\`}),\`, \`,\_jsx(\_components.code,{children:\`MONTH_YEAR\`}),\`, or \`,\_jsx(\_components.code,{children:\`MENU\`}),\`.\`\]}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`value\`})}),\_jsx(\_components.td,{children:\`String, Sensitive\`}),\_jsx(\_components.td,{children:\`The value of the field.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]})\]})\]}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`field_map\`,children:\_jsx(\_components.code,{children:\`field_map\`})}),\`\n\`,\_jsxs(\_components.p,{children:\[\`The nested schema for the \`,\_jsx(\_components.code,{children:\`field_map\`}),\` field:\`\]}),\`\n\`,\_jsxs(Table,{children:\[\_jsx(\_components.thead,{children:\_jsxs(\_components.tr,{children:\[\_jsx(\_components.th,{children:\`Field\`}),\_jsx(\_components.th,{children:\`Type\`}),\_jsx(\_components.th,{children:\`Description\`}),\_jsx(\_components.th,{children:\`Required\`}),\_jsx(\_components.th,{children:\`Access\`})\]})}),\_jsxs(\_components.tbody,{children:\[\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`id\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`A unique identifier for the field.\`}),\_jsx(\_components.td,{children:\`N/A\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`password_recipe\`})}),\_jsx(\_components.td,{children:\`The password recipe for the field.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`}),\_jsx(\_components.td,{})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`type\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The type of value stored in the field.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`value\`})}),\_jsx(\_components.td,{children:\`String, Sensitive\`}),\_jsx(\_components.td,{children:\`The value of the field.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]})\]})\]}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`item-resource-section-field-password-recipe\`,children:\_jsx(\_components.code,{children:\`section.field.password_recipe\`})}),\`\n\`,\_jsx(Tip,{children:\`Password recipes can only be added to Login and Password items.\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`The nested schema for the \`,\_jsx(\_components.code,{children:\`section.field.password_recipe\`}),\` field:\`\]}),\`\n\`,\_jsxs(Table,{children:\[\_jsx(\_components.thead,{children:\_jsxs(\_components.tr,{children:\[\_jsx(\_components.th,{children:\`Field\`}),\_jsx(\_components.th,{children:\`Type\`}),\_jsx(\_components.th,{children:\`Description\`}),\_jsx(\_components.th,{children:\`Required\`}),\_jsx(\_components.th,{children:\`Access\`})\]})}),\_jsxs(\_components.tbody,{children:\[\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`digits\`})}),\_jsx(\_components.td,{children:\`Boolean\`}),\_jsxs(\_components.td,{children:\[\`Use digits \`,\_jsx(\_components.code,{children:\`\[0-9\]\`}),\` when generating the password.\`\]}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`length\`})}),\_jsx(\_components.td,{children:\`Number\`}),\_jsx(\_components.td,{children:\`The length of the password to be generated.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`symbols\`})}),\_jsx(\_components.td,{children:\`Boolean\`}),\_jsxs(\_components.td,{children:\[\`Use symbols \`,\_jsx(\_components.code,{children:\`\[!@.-\_\*\]\`}),\` when generating the password.\`\]}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]})\]})\]}),\`\n\`,\_jsx(\_components.h5,{children:\`Example\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`The following code block shows an example usage of the \`,\_jsx(\_components.code,{children:\`onepassword_item\`}),\` resource.\`\]}),\`\n\`,\_jsx(CodeBlock,{filename:\`resource.tf\`,numberOfLines:\`32\`,language:\`terraform\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`terraform\`,children:\_jsxs(\_components.code,{language:\`terraform\`,numberOfLines:\`32\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#4EC9B0\`},children:\`resource\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#4FC1FF\`},children:\` \\onepassword_item\\\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#4FC1FF\`},children:\` \\demo_password\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` {\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` vault\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` var\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`.\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`demo_vault\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` title\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\Demo Password Recipe\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` category\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\password\\\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#4EC9B0\`},children:\` password_recipe\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` {\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` length\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#B5CEA8\`},children:\` 40\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` symbols\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` false\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` }\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`}\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#4EC9B0\`},children:\`resource\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#4FC1FF\`},children:\` \\onepassword_item\\\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#4FC1FF\`},children:\` \\demo_login\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` {\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` vault\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` var\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`.\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`demo_vault\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` title\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\Demo Terraform Login\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` category\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\login\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` username\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\test@example.com\\\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`}\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#4EC9B0\`},children:\`resource\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#4FC1FF\`},children:\` \\onepassword_item\\\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#4FC1FF\`},children:\` \\demo_db\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` {\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` vault\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` var\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`.\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`demo_vault\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` category\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\database\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` type\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\mysql\\\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` title\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\Demo TF Database\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` username\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\root\\\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` database\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\Example MySQL Instance\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` hostname\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\localhost\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` port\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#B5CEA8\`},children:\` 3306\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`}\`})}),\`\n\`\]})})}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`data-sources\`,children:\`Data sources\`}),\`\n\`,\_jsx(\_components.p,{children:\`The 1Password Terraform provider has the following data sources:\`}),\`\n\`,\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsx(\_components.li,{children:\_jsxs(\_components.a,{href:\`#item-data-source\`,children:\[\_jsx(\_components.code,{children:\`onepassword_item\`}),\` data source\`\]})}),\`\n\`,\_jsx(\_components.li,{children:\_jsxs(\_components.a,{href:\`#vault-data-source\`,children:\[\_jsx(\_components.code,{children:\`onepassword_vault\`}),\` data source\`\]})}),\`\n\`,\_jsx(\_components.li,{children:\_jsxs(\_components.a,{href:\`#environment-data-source\`,children:\[\_jsx(\_components.code,{children:\`onepassword_environment\`}),\` data source\`\]})}),\`\n\`\]}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`item-data-source\`,children:\`Item data source\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`Use the \`,\_jsx(\_components.code,{children:\`onepassword_item\`}),\` data source to get details of a 1Password item. You can identify an item by its vault UUID and either the item’s title or UUID.\`\]}),\`\n\`,\_jsx(\_components.h5,{children:\`Schema\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`The following tables describe the \`,\_jsx(\_components.code,{children:\`onepassword_item\`}),\` resource schema.\`\]}),\`\n\`,\_jsxs(Table,{children:\[\_jsx(\_components.thead,{children:\_jsxs(\_components.tr,{children:\[\_jsx(\_components.th,{children:\`Field\`}),\_jsx(\_components.th,{children:\`Type\`}),\_jsx(\_components.th,{children:\`Description\`}),\_jsx(\_components.th,{children:\`Required\`}),\_jsx(\_components.th,{children:\`Access\`})\]})}),\_jsxs(\_components.tbody,{children:\[\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`vault\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The UUID of the vault the item is in.\`}),\_jsx(\_components.td,{children:\`Yes\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`note_value\`})}),\_jsx(\_components.td,{children:\`String, Sensitive\`}),\_jsx(\_components.td,{children:\`The Secure Note value.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`title\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The title of the item to retrieve. This field populates with the title of the item if the item is looked up by its UUID.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`uuid\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The UUID of the item to retrieve. This field populates with the UUID of the item if the item is looked up by its title.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`category\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsxs(\_components.td,{children:\[\`The category of the item. \`,\_jsx(\`br\`,{}),\_jsx(\`br\`,{}),\_jsx(\_components.strong,{children:\`Acceptable values\`}),\`: \`,\_jsx(\_components.code,{children:\`login\`}),\`, \`,\_jsx(\_components.code,{children:\`password\`}),\`, or \`,\_jsx(\_components.code,{children:\`database\`}),\`.\`\]}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`database\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The name of the database. Only applies to the database category.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`hostname\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The address where the database can be found. Only applies to the database category.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`id\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsxs(\_components.td,{children:\[\`The Terraform resource identifier for the item in the format \`,\_jsx(\_components.code,{children:\`vaults/\u003cvault_id\>/items/\u003citem_id\>\`}),\`.\`\]}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`password\`})}),\_jsx(\_components.td,{children:\`String, Sensitive\`}),\_jsx(\_components.td,{children:\`The password for the item.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`port\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The port the database is listening on. Only applies to the database category.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`section\`})}),\_jsx(\_components.td,{children:\`List of Object\`}),\_jsx(\_components.td,{children:\`A list of custom sections in an item.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`tags\`})}),\_jsx(\_components.td,{children:\`List of String\`}),\_jsx(\_components.td,{children:\`An array of strings of the tags assigned to the item.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`type\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsxs(\_components.td,{children:\[\`The type of database. Only applies to the database category. \`,\_jsx(\`br\`,{}),\_jsx(\`br\`,{}),\_jsx(\_components.strong,{children:\`Acceptable values\`}),\`: \`,\_jsx(\_components.code,{children:\`db2\`}),\`, \`,\_jsx(\_components.code,{children:\`filemaker\`}),\`, \`,\_jsx(\_components.code,{children:\`msaccess\`}),\`, \`,\_jsx(\_components.code,{children:\`mssql\`}),\`, \`,\_jsx(\_components.code,{children:\`mysql\`}),\`, \`,\_jsx(\_components.code,{children:\`oracle\`}),\`, \`,\_jsx(\_components.code,{children:\`postgresql\`}),\`, \`,\_jsx(\_components.code,{children:\`sqlite\`}),\`, or \`,\_jsx(\_components.code,{children:\`other\`}),\`.\`\]}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`url\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The primary URL for the item.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`username\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The username for the item.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]})\]})\]}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`item-data-source-section\`,children:\_jsx(\_components.code,{children:\`section\`})}),\`\n\`,\_jsxs(\_components.p,{children:\[\`The nested schema for the \`,\_jsx(\_components.code,{children:\`section\`}),\` field:\`\]}),\`\n\`,\_jsxs(Table,{children:\[\_jsx(\_components.thead,{children:\_jsxs(\_components.tr,{children:\[\_jsx(\_components.th,{children:\`Field\`}),\_jsx(\_components.th,{children:\`Type\`}),\_jsx(\_components.th,{children:\`Description\`}),\_jsx(\_components.th,{children:\`Required\`}),\_jsx(\_components.th,{children:\`Access\`})\]})}),\_jsxs(\_components.tbody,{children:\[\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`field\`})}),\_jsx(\_components.td,{children:\`List of Object\`}),\_jsxs(\_components.td,{children:\[\`A list of custom fields in the section. See \`,\_jsx(\_components.a,{href:\`#item-data-source-section-field\`,children:\_jsx(\_components.code,{children:\`section.field\`})}),\`.\`\]}),\_jsx(\_components.td,{children:\`N/A\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`id\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`A unique identifier for the section.\`}),\_jsx(\_components.td,{children:\`N/A\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`label\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The label for the section.\`}),\_jsx(\_components.td,{children:\`N/A\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]})\]})\]}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`item-data-source-section-field\`,children:\_jsx(\_components.code,{children:\`section.field\`})}),\`\n\`,\_jsxs(\_components.p,{children:\[\`The nested schema for the \`,\_jsx(\_components.code,{children:\`section.field\`}),\` field:\`\]}),\`\n\`,\_jsxs(Table,{children:\[\_jsx(\_components.thead,{children:\_jsxs(\_components.tr,{children:\[\_jsx(\_components.th,{children:\`Field\`}),\_jsx(\_components.th,{children:\`Type\`}),\_jsx(\_components.th,{children:\`Description\`}),\_jsx(\_components.th,{children:\`Required\`}),\_jsx(\_components.th,{children:\`Access\`})\]})}),\_jsxs(\_components.tbody,{children:\[\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`id\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`A unique identifier for the field.\`}),\_jsx(\_components.td,{children:\`N/A\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`label\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The label for the field.\`}),\_jsx(\_components.td,{children:\`N/A\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`type\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsxs(\_components.td,{children:\[\`The type of value stored in the field. \`,\_jsx(\`br\`,{}),\_jsx(\`br\`,{}),\_jsx(\_components.strong,{children:\`Acceptable values\`}),\`: \`,\_jsx(\_components.code,{children:\`STRING\`}),\`, \`,\_jsx(\_components.code,{children:\`EMAIL\`}),\`, \`,\_jsx(\_components.code,{children:\`CONCEALED\`}),\`, \`,\_jsx(\_components.code,{children:\`URL\`}),\`, \`,\_jsx(\_components.code,{children:\`OTP\`}),\`, \`,\_jsx(\_components.code,{children:\`DATE\`}),\`, \`,\_jsx(\_components.code,{children:\`MONTH_YEAR\`}),\`, or \`,\_jsx(\_components.code,{children:\`MENU\`}),\`.\`\]}),\_jsx(\_components.td,{children:\`N/A\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`value\`})}),\_jsx(\_components.td,{children:\`String, Sensitive\`}),\_jsx(\_components.td,{children:\`The value of the field.\`}),\_jsx(\_components.td,{children:\`N/A\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]})\]})\]}),\`\n\`,\_jsx(\_components.h5,{children:\`Example\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`The following example shows how to use the \`,\_jsx(\_components.code,{children:\`onepassword_item\`}),\` data source.\`\]}),\`\n\`,\_jsx(CodeBlock,{filename:\`data-source.tf\`,numberOfLines:\`4\`,language:\`terraform\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`terraform\`,children:\_jsxs(\_components.code,{language:\`terraform\`,numberOfLines:\`4\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#4EC9B0\`},children:\`data\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#4FC1FF\`},children:\` \\onepassword_item\\\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#4FC1FF\`},children:\` \\example\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` {\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` vault\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` var\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`.\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`demo_vault\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` uuid\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` onepassword_item\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`.\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`demo_sections\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`.\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`uuid\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`}\`})}),\`\n\`\]})})}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`vault-data-source\`,children:\`Vault data source\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`Use the \`,\_jsx(\_components.code,{children:\`onepassword_vault\`}),\` data source to get details of a vault. You can identify a vault with the vault name or UUID.\`\]}),\`\n\`,\_jsx(\_components.h5,{children:\`Schema\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`The following tables describe the \`,\_jsx(\_components.code,{children:\`onepassword_vault\`}),\` resource schema.\`\]}),\`\n\`,\_jsxs(Table,{children:\[\_jsx(\_components.thead,{children:\_jsxs(\_components.tr,{children:\[\_jsx(\_components.th,{children:\`Field\`}),\_jsx(\_components.th,{children:\`Type\`}),\_jsx(\_components.th,{children:\`Description\`}),\_jsx(\_components.th,{children:\`Required\`}),\_jsx(\_components.th,{children:\`Access\`})\]})}),\_jsxs(\_components.tbody,{children:\[\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`name\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The name of the vault to retrieve. This field populates with the name of the vault if the vault is looked up by its UUID.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`uuid\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The UUID of the vault to retrieve. This field populates with the UUID of the vault if the vault is looked up by its name.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`description\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The description of the vault.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`id\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsxs(\_components.td,{children:\[\`The Terraform resource identifier for this item in the format \`,\_jsx(\_components.code,{children:\`vaults/\u003cvault_id\>\`}),\`.\`\]}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]})\]})\]}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`environment-data-source\`,children:\`Environment data source\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`Use the \`,\_jsx(\_components.code,{children:\`onepassword_environment\`}),\` data source to read variables from a \`,\_jsx(\_components.a,{href:\`/environments\`,children:\`1Password Environment\`}),\`. Identify an environment by its ID.\`\]}),\`\n\`,\_jsx(Tip,{children:\`This data source is only supported with service account or desktop app authentication. It isn’t available with 1Password Connect.\`}),\`\n\`,\_jsx(\_components.h5,{children:\`Schema\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`The following tables describe the \`,\_jsx(\_components.code,{children:\`onepassword_environment\`}),\` resource schema.\`\]}),\`\n\`,\_jsxs(Table,{children:\[\_jsx(\_components.thead,{children:\_jsxs(\_components.tr,{children:\[\_jsx(\_components.th,{children:\`Field\`}),\_jsx(\_components.th,{children:\`Type\`}),\_jsx(\_components.th,{children:\`Description\`}),\_jsx(\_components.th,{children:\`Required\`}),\_jsx(\_components.th,{children:\`Access\`})\]})}),\_jsxs(\_components.tbody,{children:\[\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`environment_id\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsxs(\_components.td,{children:\[\`The unique identifier of the 1Password Environment. Learn how to \`,\_jsx(\_components.a,{href:\`/environments/read-environment-variables#get-an-environments-id\`,children:\`get an Environment’s ID\`}),\`.\`\]}),\_jsx(\_components.td,{children:\`Yes\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`id\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsxs(\_components.td,{children:\[\`The Terraform resource identifier for the environment in the format \`,\_jsx(\_components.code,{children:\`environments/\u003cenvironment_id\>\`}),\`.\`\]}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`variables\`})}),\_jsx(\_components.td,{children:\`Map of String, Sensitive\`}),\_jsxs(\_components.td,{children:\[\`A map of environment variable names to their values. Use this for passing secrets into Terraform resources or for use in \`,\_jsx(\_components.code,{children:\`environment\`}),\` blocks.\`\]}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`metadata\`})}),\_jsx(\_components.td,{children:\`List of Object\`}),\_jsxs(\_components.td,{children:\[\`Metadata for each environment variable. Use this when you need the full structure of each variable. See \`,\_jsx(\_components.a,{href:\`#environment-data-source-metadata\`,children:\_jsx(\_components.code,{children:\`metadata\`})}),\`.\`\]}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]})\]})\]}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`environment-data-source-metadata\`,children:\_jsx(\_components.code,{children:\`metadata\`})}),\`\n\`,\_jsxs(\_components.p,{children:\[\`The nested schema for the \`,\_jsx(\_components.code,{children:\`metadata\`}),\` field:\`\]}),\`\n\`,\_jsxs(Table,{children:\[\_jsx(\_components.thead,{children:\_jsxs(\_components.tr,{children:\[\_jsx(\_components.th,{children:\`Field\`}),\_jsx(\_components.th,{children:\`Type\`}),\_jsx(\_components.th,{children:\`Description\`}),\_jsx(\_components.th,{children:\`Required\`}),\_jsx(\_components.th,{children:\`Access\`})\]})}),\_jsxs(\_components.tbody,{children:\[\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`name\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The environment variable name.\`}),\_jsx(\_components.td,{children:\`N/A\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`value\`})}),\_jsx(\_components.td,{children:\`String, Sensitive\`}),\_jsx(\_components.td,{children:\`The environment variable value.\`}),\_jsx(\_components.td,{children:\`N/A\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`masked\`})}),\_jsx(\_components.td,{children:\`Boolean\`}),\_jsx(\_components.td,{children:\`Whether the value is hidden by default in the 1Password app.\`}),\_jsx(\_components.td,{children:\`N/A\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]})\]})\]}),\`\n\`,\_jsx(\_components.h5,{children:\`Example\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`The following example shows how to use the \`,\_jsx(\_components.code,{children:\`onepassword_environment\`}),\` data source.\`\]}),\`\n\`,\_jsx(CodeBlock,{filename:\`data-source.tf\`,numberOfLines:\`8\`,language:\`terraform\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`terraform\`,children:\_jsxs(\_components.code,{language:\`terraform\`,numberOfLines:\`8\`,children:\[\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#4EC9B0\`},children:\`data\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#4FC1FF\`},children:\` \\onepassword_environment\\\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#4FC1FF\`},children:\` \\example\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` {\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` environment_id\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\your-environment-id\\\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`}\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#4EC9B0\`},children:\`output\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#4FC1FF\`},children:\` \\env_variables\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` {\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` value\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` data\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`.\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`onepassword_environment\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`.\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`example\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`.\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\`variables\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` sensitive\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#569CD6\`},children:\` true\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`}\`})}),\`\n\`\]})})}),\`\n\`,\_jsx(Heading,{level:\`3\`,id:\`ephemeral-resources\`,children:\`Ephemeral resources\`}),\`\n\`,\_jsx(\_components.p,{children:\`The 1Password Terraform provider has the following ephemeral resources:\`}),\`\n\`,\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsx(\_components.li,{children:\_jsxs(\_components.a,{href:\`#item-ephemeral-resource\`,children:\[\_jsx(\_components.code,{children:\`onepassword_item\`}),\` ephemeral resource\`\]})}),\`\n\`\]}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`item-ephemeral-resource\`,children:\`Item ephemeral resource\`}),\`\n\`,\_jsxs(\_components.p,{children:\[\`The \`,\_jsx(\_components.code,{children:\`onepassword_item\`}),\` ephemeral resource represents a 1Password item. Use it to retrieve item values without storing them in Terraform state. This is useful for providing sensitive values to write-only arguments or other ephemeral contexts.\`\]}),\`\n\`,\_jsx(\_components.h5,{children:\`Schema\`}),\`\n\`,\_jsxs(Table,{children:\[\_jsx(\_components.thead,{children:\_jsxs(\_components.tr,{children:\[\_jsx(\_components.th,{children:\`Field\`}),\_jsx(\_components.th,{children:\`Type\`}),\_jsx(\_components.th,{children:\`Description\`}),\_jsx(\_components.th,{children:\`Required\`}),\_jsx(\_components.th,{children:\`Access\`})\]})}),\_jsxs(\_components.tbody,{children:\[\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`vault\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The UUID of the vault the item is in.\`}),\_jsx(\_components.td,{children:\`Yes\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`title\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The title of the item to retrieve. This field will be populated with the title of the item if the item it looked up by its UUID.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`uuid\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The UUID of the item to retrieve. This field will be populated with the UUID of the item if the item it looked up by its title.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Write\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`credential\`})}),\_jsx(\_components.td,{children:\`String, Sensitive\`}),\_jsx(\_components.td,{children:\`API credential for this item. Only applies to the API credential category.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`database\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The name of the database. Only applies to the database category.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`hostname\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The address where the database can be found. Only applies to the database category.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`id\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsxs(\_components.td,{children:\[\`The Terraform resource identifier for the item in the format \`,\_jsx(\_components.code,{children:\`vaults/\u003cvault_id\>/items/\u003citem_id\>\`}),\`.\`\]}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`note_value\`})}),\_jsx(\_components.td,{children:\`String, Sensitive\`}),\_jsx(\_components.td,{children:\`Secure Note value.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`password\`})}),\_jsx(\_components.td,{children:\`String, Sensitive\`}),\_jsx(\_components.td,{children:\`Password for this item.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`port\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The port the database is listening on. Only applies to the database category.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`private_key\`})}),\_jsx(\_components.td,{children:\`String, Sensitive\`}),\_jsx(\_components.td,{children:\`SSH Private Key in PKCS#8 for this item.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`private_key_openssh\`})}),\_jsx(\_components.td,{children:\`String, Sensitive\`}),\_jsx(\_components.td,{children:\`SSH Private key in OpenSSH format.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`public_key\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`SSH Public Key for this item.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`type\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The type of database or API Credential. Only applies to database and API credential categories\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`url\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`The primary URL for the item.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]}),\_jsxs(\_components.tr,{children:\[\_jsx(\_components.td,{children:\_jsx(\_components.code,{children:\`username\`})}),\_jsx(\_components.td,{children:\`String\`}),\_jsx(\_components.td,{children:\`Username for this item.\`}),\_jsx(\_components.td,{children:\`No\`}),\_jsx(\_components.td,{children:\`Read-Only\`})\]})\]})\]}),\`\n\`,\_jsx(Heading,{level:\`4\`,id:\`example\`,children:\`Example\`}),\`\n\`,\_jsx(CodeBlock,{filename:\`\`,numberOfLines:\`11\`,language:\`terraform\`,children:\_jsx(\_components.pre,{className:\`shiki shiki-themes github-light-default dark-plus\`,style:{backgroundColor:\`#ffffff\`,\\--shiki-dark-bg\\:\`#0B0C0E\`,color:\`#1f2328\`,\\--shiki-dark\\:\`#D4D4D4\`},language:\`terraform\`,children:\_jsxs(\_components.code,{language:\`terraform\`,numberOfLines:\`11\`,children:\[\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#6E7781\`,\\--shiki-dark\\:\`#6A9955\`},children:\`# Example using ephemeral resource to retrieve item values\`})}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#4EC9B0\`},children:\`ephemeral\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#4FC1FF\`},children:\` \\onepassword_item\\\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#4FC1FF\`},children:\` \\example\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` {\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` vault\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\your-vault-id\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` title\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\your-item-title\\\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`}\`})}),\`\n\`,\_jsx(\_components.span,{className:\`line\`}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#6E7781\`,\\--shiki-dark\\:\`#6A9955\`},children:\`# Example using UUID instead of title\`})}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#953800\`,\\--shiki-dark\\:\`#4EC9B0\`},children:\`ephemeral\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#4FC1FF\`},children:\` \\onepassword_item\\\`}),\_jsx(\_components.span,{style:{color:\`#0550AE\`,\\--shiki-dark\\:\`#4FC1FF\`},children:\` \\example_by_uuid\\\`}),\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` {\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` vault\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\your-vault-id\\\`})\]}),\`\n\`,\_jsxs(\_components.span,{className:\`line\`,children:\[\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#9CDCFE\`},children:\` uuid\`}),\_jsx(\_components.span,{style:{color:\`#CF222E\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\` =\`}),\_jsx(\_components.span,{style:{color:\`#0A3069\`,\\--shiki-dark\\:\`#CE9178\`},children:\` \\your-item-uuid\\\`})\]}),\`\n\`,\_jsx(\_components.span,{className:\`line\`,children:\_jsx(\_components.span,{style:{color:\`#1F2328\`,\\--shiki-dark\\:\`#D4D4D4\`},children:\`}\`})}),\`\n\`\]})})}),\`\n\`,\_jsx(Heading,{level:\`2\`,id:\`learn-more\`,children:\`Learn more\`}),\`\n\`,\_jsxs(\_components.ul,{children:\[\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`https://github.com/1Password/terraform-provider-onepassword/blob/main/CHANGELOG.md\`,children:\`Changelog\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/get-started/secure-deployment\`,children:\`Workflow: Secure your deployments\`})}),\`\n\`,\_jsx(\_components.li,{children:\_jsx(\_components.a,{href:\`/get-started/build-integrations\`,children:\`Workflow: Build integrations with 1Password\`})}),\`\n\`\]})\]})}function MDXContent(props={}){const{wrapper:MDXLayout}={...\_provideComponents(),...props.components};return MDXLayout?\_jsx(MDXLayout,{...props,children:\_jsx(\_createMdxContent,{...props})}):\_createMdxContent(props)}return{Image,YouTubeVideo,Small,default:MDXContent};function \_missingMdxReference(id,component){throw new Error(\`Expected \`+(component?\`component\`:\`object\`)+\\ \`\\+id+\\\` to be defined: you likely forgot to import, pass, or provide it.\\)}","frontmatter":{},"scope":{"config":{},"pageMetadata":{"title":"Use the 1Password Terraform provider with Connect","sidebarTitle":"Terraform","og:description":"Use a 1Password Connect server to reference, create, or update items in your vaults with the 1Password Terraform provider.","description":null,"href":"/connect/terraform"}}},"mdxSourceWithNoJs":null,"noJsSplices":\[\[141,1281,")=\>null;const YouTubeVideo=()=\>null;cons"\]\]},"mdxExtracts":{"tableOfContents":\[{"title":"Requirements","slug":"requirements","depth":2,"children":\[\]},{"title":"Get started","slug":"get-started","depth":2,"children":\[\]},{"title":"Reference","slug":"reference","depth":2,"children":\[{"title":"Configuration","slug":"configuration","depth":3,"children":\[\]},{"title":"Configuration examples","slug":"configuration-examples","depth":4,"children":\[\]},{"title":"Resources","slug":"resources","depth":3,"children":\[\]},{"title":"Item resource","slug":"item-resource","depth":4,"children":\[\]},{"title":"password_recipe","slug":"password_recipe","depth":4,"children":\[\]},{"title":"section","slug":"section","depth":4,"children":\[\]},{"title":"section_map","slug":"section_map","depth":4,"children":\[\]},{"title":"section.field","slug":"item-resource-section-field","depth":4,"children":\[\]},{"title":"field_map","slug":"field_map","depth":4,"children":\[\]},{"title":"section.field.password_recipe","slug":"item-resource-section-field-password-recipe","depth":4,"children":\[\]},{"title":"Data sources","slug":"data-sources","depth":3,"children":\[\]},{"title":"Item data source","slug":"item-data-source","depth":4,"children":\[\]},{"title":"section","slug":"item-data-source-section","depth":4,"children":\[\]},{"title":"section.field","slug":"item-data-source-section-field","depth":4,"children":\[\]},{"title":"Vault data source","slug":"vault-data-source","depth":4,"children":\[\]},{"title":"Environment data source","slug":"environment-data-source","depth":4,"children":\[\]},{"title":"metadata","slug":"environment-data-source-metadata","depth":4,"children":\[\]},{"title":"Ephemeral resources","slug":"ephemeral-resources","depth":3,"children":\[\]},{"title":"Item ephemeral resource","slug":"item-ephemeral-resource","depth":4,"children":\[\]},{"title":"Example","slug":"example","depth":4,"children":\[\]}\]},{"title":"Learn more","slug":"learn-more","depth":2,"children":\[\]}\],"codeExamples":{}},"jsLinks":\["/\_mintlify/custom/ab-634991b8/5ebc0d10523e8210/static/js/analytics.js","/\_mintlify/custom/ab-634991b8/5bb7437b1c9dcb44/static/js/gtag-prod-sst.js","/\_mintlify/custom/ab-634991b8/ee8ea0eeb20ecd1e/static/js/gtag-sst.js","/\_mintlify/custom/ab-634991b8/f2b239f3d459dc67/api-sdk-terms-notice.js","/\_mintlify/custom/ab-634991b8/3604035e212f8294/homepage-card-icons.js"\],"dynamicCss":".mint-mx-4 {\n margin-left: 1rem;\n margin-right: 1rem\n}\n.mint-hidden {\n display: none\n}\n.mint-aspect-video {\n aspect-ratio: 16 / 9\n}\n.mint-w-full {\n width: 100%\n}\n.mint-rounded-lg {\n border-radius: 0.5rem\n}\n.mint-rounded-sm {\n border-radius: 0.125rem\n}\n.mint-rounded-xl {\n border-radius: 0.75rem\n}\n.dark\\:mint-block:is(.dark \*) {\n display: block\n}\n.dark\\:mint-hidden:is(.dark \*) {\n display: none\n}","subdomain":"ab-634991b8","siteName":"1Password Developer","title":"Use the 1Password Terraform provider with Connect - 1Password Developer","relatedPagesConfig":{"enabled":true,"limit":3,"mode":"automatic"},"contextualStarterQuestions":\[{"\_id":"6ae4c9362086b3fba440c41b","deploymentId":"68a8af9a517ab813d3b84097","questionText":"Can I use a Service Account instead?","status":"active","generatedBy":"contextual","path":"connect/terraform","createdAt":"2026-10-30T16:43:34.645Z","updatedAt":"2026-10-30T16:43:34.645Z","\_\_v":0},{"\_id":"6ae4c9362086b3fba440c41a","deploymentId":"68a8af9a517ab813d3b84097","questionText":"How do I set up Terraform with Connect?","status":"active","generatedBy":"contextual","path":"connect/terraform","createdAt":"2026-10-30T16:43:34.645Z","updatedAt":"2026-10-30T16:43:34.645Z","\_\_v":0},{"\_id":"6ae4c9362086b3fba440c41c","deploymentId":"68a8af9a517ab813d3b84097","questionText":"What do I need before getting started?","status":"active","generatedBy":"contextual","path":"connect/terraform","createdAt":"2026-10-30T16:43:34.645Z","updatedAt":"2026-10-30T16:43:34.645Z","\_\_v":0}\],"navMaps":{"firstHrefInVersion":{},"firstHrefInLanguage":{}},"lastModified":"2026-10-30T16:43:20.902Z","originalFileLocation":"connect/terraform.mdx"},"headHtml":"\u003cscript data-mint-head\>(function(){var d=document.documentElement,p=null;if(!p){try{p=localStorage.getItem(\\isDarkMode\\)}catch(e){}if(p==='true')p='dark';else if(p==='false')p='light';if(p!=='light'\u0026\u0026p!=='dark'\u0026\u0026p!=='system')p=\\system\\}var r=p==='system'?(matchMedia(\\(prefers-color-scheme: dark)\\).matches?'dark':'light'):p;d.classList.remove(r==='dark'?'light':'dark');d.classList.add(r);d.setAttribute(\\data-theme-preference\\,p)})();\u003c/script\>\u003cmeta data-mint-head name=\\application-name\\ content=\\1Password Developer\\\>\u003cmeta data-mint-head name=\\generator\\ content=\\Mintlify\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\192x192\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/android-chrome-192x192.png\\ media=\\(prefers-color-scheme: light)\\\>\u003clink data-mint-head rel=\\apple-touch-icon\\ type=\\image/png\\ sizes=\\180x180\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/apple-touch-icon.png\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\16x16\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/favicon-16x16.png\\ media=\\(prefers-color-scheme: light)\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\32x32\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/favicon-32x32.png\\ media=\\(prefers-color-scheme: light)\\\>\u003clink data-mint-head rel=\\shortcut icon\\ type=\\image/x-icon\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/favicon.ico\\ media=\\(prefers-color-scheme: light)\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\192x192\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon-dark/android-chrome-192x192.png\\ media=\\(prefers-color-scheme: dark)\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\16x16\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon-dark/favicon-16x16.png\\ media=\\(prefers-color-scheme: dark)\\\>\u003clink data-mint-head rel=\\icon\\ type=\\image/png\\ sizes=\\32x32\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon-dark/favicon-32x32.png\\ media=\\(prefers-color-scheme: dark)\\\>\u003clink data-mint-head rel=\\shortcut icon\\ type=\\image/x-icon\\ href=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon-dark/favicon.ico\\ media=\\(prefers-color-scheme: dark)\\\>\u003cmeta data-mint-head property=\\og:title\\ content=\\Use the 1Password Terraform provider with Connect - 1Password Developer\\\>\u003cmeta data-mint-head property=\\og:description\\ content=\\Use a 1Password Connect server to reference, create, or update items in your vaults with the 1Password Terraform provider.\\\>\u003cmeta data-mint-head property=\\og:site_name\\ content=\\1Password Developer\\\>\u003cmeta data-mint-head property=\\og:url\\ content=\\https://www.1password.dev/connect/terraform\\\>\u003cmeta data-mint-head property=\\og:type\\ content=\\website\\\>\u003cmeta data-mint-head property=\\og:image\\ content=\\https://ab-634991b8.mintlify.app/\_mintlify/api/og/v2?division=Integrations\u0026amp;title=Use+the+1Password+Terraform+provider+with+Connect\u0026amp;theme=0e8ac3e29b6f66038c473d59\u0026amp;signature=4c886d0854670e7a1096c13116c84e0d1e9240dd833b2d454d5278ac0bb8a57e\\\>\u003cmeta data-mint-head property=\\og:image:width\\ content=\\1200\\\>\u003cmeta data-mint-head property=\\og:image:height\\ content=\\630\\\>\u003cmeta data-mint-head name=\\twitter:card\\ content=\\summary_large_image\\\>\u003cmeta data-mint-head name=\\twitter:title\\ content=\\Use the 1Password Terraform provider with Connect - 1Password Developer\\\>\u003cmeta data-mint-head name=\\twitter:description\\ content=\\Use a 1Password Connect server to reference, create, or update items in your vaults with the 1Password Terraform provider.\\\>\u003cmeta data-mint-head name=\\twitter:image\\ content=\\https://ab-634991b8.mintlify.app/\_mintlify/api/og/v2?division=Integrations\u0026amp;title=Use+the+1Password+Terraform+provider+with+Connect\u0026amp;theme=0e8ac3e29b6f66038c473d59\u0026amp;signature=4c886d0854670e7a1096c13116c84e0d1e9240dd833b2d454d5278ac0bb8a57e\\\>\u003cmeta data-mint-head name=\\twitter:image:width\\ content=\\1200\\\>\u003cmeta data-mint-head name=\\twitter:image:height\\ content=\\630\\\>\u003cmeta data-mint-head name=\\msapplication-config\\ content=\\/mintlify-assets/\_mintlify/favicons/ab-634991b8/cic7o6CrHhA6877e/\_generated/favicon/browserconfig.xml\\\>\u003cmeta data-mint-head name=\\apple-mobile-web-app-title\\ content=\\1Password Developer\\\>\u003cmeta data-mint-head name=\\msapplication-TileColor\\ content=\\#104ebb\\\>\u003cmeta data-mint-head name=\\google-site-verification\\ content=\\YserOhXnJUjFfIZ4K3qgxkVSlQZQdXtIbBiKzZ35Nvs\\\>\u003clink data-mint-head rel=\\canonical\\ href=\\https://www.1password.dev/connect/terraform\\\>\u003clink data-mint-head rel=\\alternate\\ type=\\application/xml\\ href=\\/sitemap.xml\\\>\u003clink data-mint-head rel=\\alternate\\ type=\\text/markdown\\ href=\\/connect/terraform.md\\\>\u003cscript data-mint-head type=\\application/ld+json\\\>{\\@context\\:\\https://schema.org\\,\\@graph\\:\[{\\@type\\:\\Organization\\,\\@id\\:\\https://www.1password.dev/#organization\\,\\name\\:\\1Password Developer\\,\\url\\:\\https://www.1password.dev\\,\\logo\\:{\\@type\\:\\ImageObject\\,\\url\\:\\https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max\u0026auto=format\u0026n=lHrfVfSCdefFz8U5\u0026q=85\u0026s=29d1c9358888a723dddd8a89a3b6f71d\\}},{\\@type\\:\\WebSite\\,\\@id\\:\\https://www.1password.dev#website\\,\\name\\:\\1Password Developer\\,\\url\\:\\https://www.1password.dev\\,\\publisher\\:{\\@id\\:\\https://www.1password.dev/#organization\\}},{\\@type\\:\\WebPage\\,\\@id\\:\\https://www.1password.dev/connect/terraform#webpage\\,\\url\\:\\https://www.1password.dev/connect/terraform\\,\\name\\:\\Use the 1Password Terraform provider with Connect\\,\\dateModified\\:\\2026-10-30T16:43:20.902Z\\,\\isPartOf\\:{\\@id\\:\\https://www.1password.dev#website\\},\\breadcrumb\\:{\\@id\\:\\https://www.1password.dev/connect/terraform#breadcrumb\\}},{\\@type\\:\\BreadcrumbList\\,\\@id\\:\\https://www.1password.dev/connect/terraform#breadcrumb\\,\\itemListElement\\:\[{\\@type\\:\\ListItem\\,\\position\\:1,\\name\\:\\Secrets Automation\\,\\item\\:\\https://www.1password.dev/secrets-automation\\},{\\@type\\:\\ListItem\\,\\position\\:2,\\name\\:\\Connect server\\,\\item\\:\\https://www.1password.dev/connect\\},{\\@type\\:\\ListItem\\,\\position\\:3,\\name\\:\\Integrations\\,\\item\\:\\https://www.1password.dev/connect/ansible\\},{\\@type\\:\\ListItem\\,\\position\\:4,\\name\\:\\Use the 1Password Terraform provider with Connect\\,\\item\\:\\https://www.1password.dev/connect/terraform\\}\]},{\\@type\\:\[\\Article\\,\\TechArticle\\\],\\@id\\:\\https://www.1password.dev/connect/terraform#article\\,\\headline\\:\\Use the 1Password Terraform provider with Connect\\,\\name\\:\\Use the 1Password Terraform provider with Connect\\,\\url\\:\\https://www.1password.dev/connect/terraform\\,\\mainEntityOfPage\\:{\\@id\\:\\https://www.1password.dev/connect/terraform#webpage\\},\\dateModified\\:\\2026-10-30T16:43:20.902Z\\,\\publisher\\:{\\@id\\:\\https://www.1password.dev/#organization\\},\\isPartOf\\:{\\@id\\:\\https://www.1password.dev#website\\}}\]}\u003c/script\>","siteName":"1Password Developer","nav":{"global":null,"tabs":\[{"tab":"Get Started","pages":\[{"title":"Get Started","href":"/get-started"}\]},{"tab":"Tutorials","pages":\[{"title":"Tutorials","href":"/tutorials"}\]},{"tab":"Security for AI","pages":\[{"title":"Security for AI","href":"/security-for-ai"}\]},{"tab":"Environments","pages":\[{"title":"Environments","href":"/environments"}\]},{"tab":"SSH \u0026 Git","pages":\[{"title":"SSH \u0026 Git","href":"/ssh"}\]},{"tab":"CLI","pages":\[{"title":"CLI","href":"/cli"}\]},{"tab":"SDKs","pages":\[{"title":"SDKs","href":"/sdks"}\]},{"tab":"More Tools","menu":\[{"item":"VS Code","icon":"laptop","pages":\[{"title":"VS Code","href":"/vscode"}\]},{"item":"Shell Plugins","icon":"puzzle-piece","pages":\[{"title":"Shell Plugins","href":"/cli/shell-plugins"}\]},{"item":"Integrations","icon":"puzzle","pages":\[{"title":"Integrations","href":"/integrations"}\]},{"item":"Secrets Automation","icon":"tablet-screen","groups":\[{"group":"Secrets Automation","pages":\[{"title":"1Password Secrets Automation","sidebarTitle":"Overview","href":"/secrets-automation"},{"group":"Service accounts","pages":\[{"title":"1Password Service Accounts","sidebarTitle":"Overview","href":"/service-accounts"},{"title":"Get started with 1Password Service Accounts","sidebarTitle":"Get started","href":"/service-accounts/get-started"},{"title":"Manage service accounts","sidebarTitle":"Manage","href":"/service-accounts/manage-service-accounts"},{"title":"Use service accounts with 1Password CLI","sidebarTitle":"Use with 1Password CLI","href":"/service-accounts/use-with-1password-cli"},{"title":"Use service accounts with 1Password SDKs","sidebarTitle":"Use with 1Password SDKs","href":"/service-accounts/setup-tutorial"},{"group":"Integrations","pages":\[{"title":"Use CI/CD integrations with 1Password service accounts","sidebarTitle":"CI/CD integrations","href":"/secrets-automation/ci-cd"},{"title":"Use Kubernetes integrations with 1Password service accounts","sidebarTitle":"Kubernetes integrations","href":"/secrets-automation/k8s"},{"title":"Postman","url":"https://learning.postman.com/docs/sending-requests/postman-vault/1password/","href":"/service-accounts/postman"},{"title":"Use the 1Password provider for Pulumi with service accounts","sidebarTitle":"Pulumi","href":"/service-accounts/pulumi"},{"title":"Pulumi ESC","url":"https://www.pulumi.com/docs/esc/integrations/dynamic-secrets/1password-secrets/","href":"/service-accounts/pulumi-esc"},{"title":"Use the 1Password Terraform provider with service accounts","sidebarTitle":"Terraform","href":"/service-accounts/terraform"}\]},{"title":"Service account rate limits","sidebarTitle":"Rate limits","href":"/service-accounts/rate-limits"},{"sidebarTitle":"Security","title":"1Password Service Account security","href":"/service-accounts/security"}\]},{"group":"Connect server","pages":\[{"title":"1Password Connect","sidebarTitle":"Overview","href":"/connect"},{"title":"Get started with a 1Password Connect server","sidebarTitle":"Get started","href":"/connect/get-started"},{"title":"Manage Connect servers","sidebarTitle":"Manage","href":"/connect/manage-connect"},{"title":"Configure your Connect server","sidebarTitle":"Configuration","href":"/connect/server-configuration"},{"title":"Use 1Password CLI with a Connect server","sidebarTitle":"Use with 1Password CLI","href":"/connect/cli"},{"group":"SDKs","expanded":true,"pages":\[{"title":"Go","url":"https://github.com/1Password/connect-sdk-go","href":"/connect/sdks/languages/golang"},{"title":"Node.js","url":"https://github.com/1Password/connect-sdk-js","href":"/connect/sdks/languages/javascript"},{"title":"Python","url":"https://github.com/1Password/connect-sdk-python","href":"/connect/sdks/languages/python"}\]},{"group":"Integrations","pages":\[{"title":"Ansible","href":"/connect/ansible"},{"title":"Deploy 1Password Connect Server on AWS ECS Fargate","sidebarTitle":"AWS ECS Fargate","href":"/connect/aws"},{"title":"Use CI/CD integrations with a 1Password Connect server","sidebarTitle":"CI/CD integrations","href":"/connect/ci-cd"},{"title":"Hashicorp Vault backend","url":"https://github.com/1Password/vault-plugin-secrets-onepassword","href":"/connect/hashicorp"},{"title":"Use Kubernetes integrations with a 1Password Connect server","sidebarTitle":"Kubernetes integrations","href":"/connect/k8s"},{"title":"Use the 1Password provider for Pulumi with Connect","sidebarTitle":"Pulumi","description":null,"href":"/connect/pulumi"},{"title":"Use the 1Password Terraform provider with Connect","sidebarTitle":"Terraform","href":"/connect/terraform"}\]},{"group":"Reference","pages":\[{"group":"API Reference","pages":\[{"title":"1Password Connect Server API reference","sidebarTitle":"Overview","description":null,"href":"/connect/api-reference"},{"title":"Get all Vaults","deprecated":null,"version":null,"sidebarTitle":"Get vaults","openapi":"/openapi/connect_server_api.yaml get /vaults","href":"/connect/api-reference/get-vaults"},{"title":"Get Vault details and metadata","deprecated":null,"version":null,"sidebarTitle":"Get vault by id","openapi":"/openapi/connect_server_api.yaml get /vaults/{vaultUuid}","href":"/connect/api-reference/get-vault-by-id"},{"title":"Get all items for inside a Vault","deprecated":null,"version":null,"sidebarTitle":"Get vault items","openapi":"/openapi/connect_server_api.yaml get /vaults/{vaultUuid}/items","href":"/connect/api-reference/get-vault-items"},{"title":"Create a new Item","deprecated":null,"version":null,"sidebarTitle":"Create vault item","openapi":"/openapi/connect_server_api.yaml post /vaults/{vaultUuid}/items","href":"/connect/api-reference/create-vault-item"},{"title":"Get the details of an Item","deprecated":null,"version":null,"sidebarTitle":"Get vault item by id","openapi":"/openapi/connect_server_api.yaml get /vaults/{vaultUuid}/items/{itemUuid}","href":"/connect/api-reference/get-vault-item-by-id"},{"title":"Update an Item","deprecated":null,"version":null,"sidebarTitle":"Update vault item","openapi":"/openapi/connect_server_api.yaml put /vaults/{vaultUuid}/items/{itemUuid}","href":"/connect/api-reference/update-vault-item"},{"title":"Delete an Item","deprecated":null,"version":null,"sidebarTitle":"Delete vault item","openapi":"/openapi/connect_server_api.yaml delete /vaults/{vaultUuid}/items/{itemUuid}","href":"/connect/api-reference/delete-vault-item"},{"title":"Update a subset of Item attributes","deprecated":null,"version":null,"sidebarTitle":"Patch vault item","openapi":"/openapi/connect_server_api.yaml patch /vaults/{vaultUuid}/items/{itemUuid}","href":"/connect/api-reference/patch-vault-item"},{"title":"Get all the files inside an Item","deprecated":null,"version":null,"sidebarTitle":"Get item files","openapi":"/openapi/connect_server_api.yaml get /vaults/{vaultUuid}/items/{itemUuid}/files","href":"/connect/api-reference/get-item-files"},{"title":"Get the details of a File","deprecated":null,"version":null,"sidebarTitle":"Get item file by id","openapi":"/openapi/connect_server_api.yaml get /vaults/{vaultUuid}/items/{itemUuid}/files/{fileUuid}","href":"/connect/api-reference/get-item-file-by-id"},{"title":"Get the content of a File","deprecated":null,"version":null,"sidebarTitle":"Download item file by id","openapi":"/openapi/connect_server_api.yaml get /vaults/{vaultUuid}/items/{itemUuid}/files/{fileUuid}/content","href":"/connect/api-reference/download-item-file-by-id"},{"title":"Retrieve a list of API Requests that have been made.","deprecated":null,"version":null,"sidebarTitle":"Get api activity","openapi":"/openapi/connect_server_api.yaml get /activity","href":"/connect/api-reference/get-api-activity"},{"title":"Ping the server for liveness","deprecated":null,"version":null,"sidebarTitle":"Get heartbeat","openapi":"/openapi/connect_server_api.yaml get /heartbeat","href":"/connect/api-reference/get-heartbeat"},{"title":"Get state of the server and its dependencies.","deprecated":null,"version":null,"sidebarTitle":"Get server health","openapi":"/openapi/connect_server_api.yaml get /health","href":"/connect/api-reference/get-server-health"},{"title":"Query server for exposed Prometheus metrics","deprecated":null,"version":null,"sidebarTitle":"Get prometheus metrics","openapi":"/openapi/connect_server_api.yaml get /metrics","href":"/connect/api-reference/get-prometheus-metrics"}\]},{"title":"Connect concepts","sidebarTitle":"Concepts","href":"/connect/concepts"},{"title":"About 1Password Connect Server security","sidebarTitle":"Security","href":"/connect/security"}\]}\]}\]}\]},{"item":"Events API","icon":"sensor-triangle-exclamation","pages":\[{"title":"Events API","href":"/events-api"}\]},{"item":"Users API","icon":"id-badge","pages":\[{"title":"Users API","href":"/users-api"}\]},{"item":"SaaS Manager API","icon":"chart-line","pages":\[{"title":"SaaS Manager API","href":"/saas-manager-api"}\]},{"item":"Partnership API","icon":"users","pages":\[{"title":"Partnership API","href":"/partnership-api/reference"}\]},{"item":"Accounts API","icon":"user-gear","pages":\[{"title":"Accounts API","href":"/accounts-api"}\]},{"item":"Web Development","icon":"code","pages":\[{"title":"Web Development","href":"/web/add-1password-button-website"}\]},{"item":"Developer Watchtower","icon":"tower-control","pages":\[{"title":"Developer Watchtower","href":"/watchtower"}\]}\]},{"tab":"Agentic Autofill partner guide","hidden":true,"pages":\[{"title":"Agentic Autofill partner guide","href":"/agentic-autofill/partners"}\]}\]},"basePath":"","title":"Use the 1Password Terraform provider with Connect - 1Password Developer","buildId":"dpl_DeHjVRGfFnhYQwHnfC2pjeXXv8h9","deploymentId":"dpl_DeHjVRGfFnhYQwHnfC2pjeXXv8h9","dynamics":\["10e4515597","07c022d89b"\],"chunks":\["BannerMarkdown-CX_qQQOL.js","dist-BTZUMDnx.js","lib-DuNMoZ05.js","lib-B8HbPgcC.js","clsx-xpJZXxdP.js","html-void-elements-mCSPHezU.js","katex-YMM-FMeD.js","marked.esm-CZWythHk.js","Frame-DXXFP6nH.js","DynamicMarkdown-B54_zNBF.js"\]}
