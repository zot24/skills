> Source: https://www.1password.dev/connect/terraform/



> ## Documentation Index
>
> Fetch the complete documentation index at: <a href="/llms.txt" tabindex="-1">/llms.txt</a>
>
> Use this file to discover all available pages before exploring further.


<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


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


- <a href="/connect/get-started#step-1" class="link">Create a Connect server.</a>


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
4.  Under Integrate with the 1Password SDKs, select **Integrate with other apps**.
5.  If you want to authenticate with Touch ID, navigate to **Settings** \> **<a href="onepassword://settings/security" class="link" target="_blank" rel="noreferrer">Security</a>**, then turn on **<a href="https://support.1password.com/touch-id-mac/" class="link" target="_blank" rel="noreferrer">Unlock using Touch ID</a>**.


1.  Open and unlock the <a href="https://1password.com/downloads/" class="link" target="_blank" rel="noreferrer">1Password app</a>.
2.  Select your account or collection at the top of the sidebar.
3.  Navigate to **Settings** \> **<a href="onepassword://settings/developers" class="link" target="_blank" rel="noreferrer">Developer</a>**.
4.  Under Integrate with the 1Password SDKs, select **Integrate with other apps**.
5.  If you want to authenticate with Windows Hello, navigate to **Settings** \> **<a href="onepassword://settings/security" class="link" target="_blank" rel="noreferrer">Security</a>**, then turn on **<a href="https://support.1password.com/windows-hello/" class="link" target="_blank" rel="noreferrer">Unlock using Windows Hello</a>**.


1.  Open and unlock the <a href="https://1password.com/downloads/" class="link" target="_blank" rel="noreferrer">1Password app</a>.
2.  Select your account or collection at the top of the sidebar.
3.  Navigate to **Settings** \> **<a href="onepassword://settings/developers" class="link" target="_blank" rel="noreferrer">Developer</a>**.
4.  Under Integrate with the 1Password SDKs, select **Integrate with other apps**.
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


<table class="m-0 min-w-full w-full max-w-none table [&amp;_td]:min-w-[150px] [&amp;_th]:text-left [&amp;_td[data-numeric]]:tabular-nums">
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


<table class="m-0 min-w-full w-full max-w-none table [&amp;_td]:min-w-[150px] [&amp;_th]:text-left [&amp;_td[data-numeric]]:tabular-nums">
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


<table class="m-0 min-w-full w-full max-w-none table [&amp;_td]:min-w-[150px] [&amp;_th]:text-left [&amp;_td[data-numeric]]:tabular-nums">
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


<table class="m-0 min-w-full w-full max-w-none table [&amp;_td]:min-w-[150px] [&amp;_th]:text-left [&amp;_td[data-numeric]]:tabular-nums">
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


Related topics

<a href="/terraform" class="flex items-center gap-2 rounded-lg py-1.5 text-gray-950 dark:text-gray-50 hover:text-primary dark:hover:text-primary-light"><span class="text-sm tracking-[-0.1px] line-clamp-1">Use the 1Password Terraform provider</span></a><a href="/service-accounts/terraform" class="flex items-center gap-2 rounded-lg py-1.5 text-gray-950 dark:text-gray-50 hover:text-primary dark:hover:text-primary-light"><span class="text-sm tracking-[-0.1px] line-clamp-1">Use the 1Password Terraform provider with service accounts</span></a><a href="/cli/shell-plugins/terraform" class="flex items-center gap-2 rounded-lg py-1.5 text-gray-950 dark:text-gray-50 hover:text-primary dark:hover:text-primary-light"><span class="text-sm tracking-[-0.1px] line-clamp-1">Use 1Password to securely authenticate Terraform</span></a>


Was this page helpful?


<a href="/connect/pulumi" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Pulumi</span></a><a href="/connect/api-reference" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Overview</span></a>


Responses are generated using AI and may contain mistakes.


<a href="mailto:support@1password.com" class="group flex justify-between items-center gap-1 mt-2 py-1 transition-colors duration-200" data-component-part="contact-support-button"><span data-component-part="contact-support-icon"></span></a>

Contact support


