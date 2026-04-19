<!-- Source: Scraped from coddingtonbear.github.io/obsidian-local-rest-api via Firecrawl -->

Explore

# Local REST API for Obsidian  ```  1.0  ```    ``` OAS 3.0 ```

[./openapi.yaml](https://coddingtonbear.github.io/obsidian-local-rest-api/openapi.yaml)

You can use this interface for trying out your Local REST API in Obsidian.

Before trying the below tools, you will want to make sure you press the "Authorize" button below and provide the API Key you are shown when you open the "Local REST API" section of your Obsidian settings. All requests to the API require a valid API Key; so you won't get very far without doing that.

When using this tool you may see browser security warnings due to your browser not trusting the self-signed certificate the plugin will generate on its first run. If you do, you can make those errors disappear by adding the certificate as a "Trusted Certificate" in your browser or operating system's settings.

Servers

https://{host}:{port} - HTTPS (Secure Mode)http://{host}:{port} - HTTP (Insecure Mode)

Computed URL:`https://127.0.0.1:27124`

#### Server variables

|     |     |
| --- | --- |
| host |  |
| port |  |

Authorize

### [Vault Files](https://coddingtonbear.github.io/obsidian-local-rest-api/\#/Vault%20Files)

GET
[/vault/{filename}](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Vault%20Files/get_vault__filename_)

Return the content of a single file in your vault.

POST
[/vault/{filename}](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Vault%20Files/post_vault__filename_)

Append content to a new or existing file.

PUT
[/vault/{filename}](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Vault%20Files/put_vault__filename_)

Create a new file in your vault or update the content of an existing one.

PATCH
[/vault/{filename}](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Vault%20Files/patch_vault__filename_)

Partially update content in an existing note.

DELETE
[/vault/{filename}](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Vault%20Files/delete_vault__filename_)

Delete a particular file in your vault.

### [Active File](https://coddingtonbear.github.io/obsidian-local-rest-api/\#/Active%20File)

GET
[/active/](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Active%20File/get_active_)

Return the content of the active file open in Obsidian.

POST
[/active/](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Active%20File/post_active_)

Append content to the active file open in Obsidian.

PUT
[/active/](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Active%20File/put_active_)

Update the content of the active file open in Obsidian.

PATCH
[/active/](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Active%20File/patch_active_)

Partially update content in the currently open note.

DELETE
[/active/](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Active%20File/delete_active_)

Deletes the currently-active file in Obsidian.

### [Periodic Notes](https://coddingtonbear.github.io/obsidian-local-rest-api/\#/Periodic%20Notes)

GET
[/periodic/{period}/](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Periodic%20Notes/get_periodic__period__)

Get current periodic note for the specified period.

GET
[/periodic/{period}/{year}/{month}/{day}/](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Periodic%20Notes/get_periodic__period___year___month___day__)

Get the periodic note for the specified period and date.

POST
[/periodic/{period}/](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Periodic%20Notes/post_periodic__period__)

Append content to the current periodic note for the specified period.

POST
[/periodic/{period}/{year}/{month}/{day}/](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Periodic%20Notes/post_periodic__period___year___month___day__)

Append content to the periodic note for the specified period and date.

PUT
[/periodic/{period}/](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Periodic%20Notes/put_periodic__period__)

Update the content of the current periodic note for the specified period.

PUT
[/periodic/{period}/{year}/{month}/{day}/](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Periodic%20Notes/put_periodic__period___year___month___day__)

Update the content of the periodic note for the specified period and date.

PATCH
[/periodic/{period}/](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Periodic%20Notes/patch_periodic__period__)

Partially update content in the current periodic note for the specified period.

PATCH
[/periodic/{period}/{year}/{month}/{day}/](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Periodic%20Notes/patch_periodic__period___year___month___day__)

Partially update content in the periodic note for the specified period and date.

DELETE
[/periodic/{period}/](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Periodic%20Notes/delete_periodic__period__)

Delete the current periodic note for the specified period.

DELETE
[/periodic/{period}/{year}/{month}/{day}/](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Periodic%20Notes/delete_periodic__period___year___month___day__)

Delete the periodic note for the specified period and date.

### [Vault Directories](https://coddingtonbear.github.io/obsidian-local-rest-api/\#/Vault%20Directories)

GET
[/vault/](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Vault%20Directories/get_vault_)

List files that exist in the root of your vault.

GET
[/vault/{pathToDirectory}/](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Vault%20Directories/get_vault__pathToDirectory__)

List files that exist in the specified directory.

### [Search](https://coddingtonbear.github.io/obsidian-local-rest-api/\#/Search)

POST
[/search/](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Search/post_search_)

Search for documents matching a specified search query

POST
[/search/simple/](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Search/post_search_simple_)

Search for documents matching a specified text query

### [Commands](https://coddingtonbear.github.io/obsidian-local-rest-api/\#/Commands)

GET
[/commands/](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Commands/get_commands_)

Get a list of available commands.

POST
[/commands/{commandId}/](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Commands/post_commands__commandId__)

Execute a command.

### [Open](https://coddingtonbear.github.io/obsidian-local-rest-api/\#/Open)

POST
[/open/{filename}](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Open/post_open__filename_)

Open the specified document in the Obsidian user interface.

### [System](https://coddingtonbear.github.io/obsidian-local-rest-api/\#/System)

GET
[/](https://coddingtonbear.github.io/obsidian-local-rest-api/#/System/get_)

Returns basic details about the server.

GET
[/obsidian-local-rest-api.crt](https://coddingtonbear.github.io/obsidian-local-rest-api/#/System/get_obsidian_local_rest_api_crt)

Returns the certificate in use by this API.

GET
[/openapi.yaml](https://coddingtonbear.github.io/obsidian-local-rest-api/#/System/get_openapi_yaml)

Returns OpenAPI YAML document describing the capabilities of this API.

### [Tags](https://coddingtonbear.github.io/obsidian-local-rest-api/\#/Tags)

GET
[/tags/](https://coddingtonbear.github.io/obsidian-local-rest-api/#/Tags/get_tags_)

Get a list of all tags with metadata.

#### Schemas

Error

NoteJson