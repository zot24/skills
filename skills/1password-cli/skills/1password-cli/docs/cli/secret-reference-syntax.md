> Source: https://www.1password.dev/cli/secret-reference-syntax/



> ## Documentation Index
>
> Fetch the complete documentation index at: [/llms.txt](/llms.txt)
>
> Use this file to discover all available pages before exploring further.


<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


<a href="/" class="select-none" data-state="closed" data-slot="context-menu-trigger" style="-webkit-touch-callout:none"><span class="sr-only">1Password Developer home page</span><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=29d1c9358888a723dddd8a89a3b6f71d" class="nav-logo w-auto h-7 relative object-contain shrink-0 block dark:hidden" alt="light logo" /><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-light.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=119233092720e49043d6f42ff71125f1" class="nav-logo w-auto h-7 relative object-contain shrink-0 hidden dark:block" alt="dark logo" /></a>


Search...


Concepts


Secret reference syntax


<a href="/get-started" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Get Started</a>


<a href="/security-for-ai" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Security for AI</a>


<a href="/environments" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Environments</a>


<a href="/ssh" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SSH &amp; Git</a>


<a href="/cli" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200 [text-shadow:-0.2px_0_0_currentColor,0.2px_0_0_currentColor]" data-active="true" aria-current="location">CLI</a>


<a href="/sdks" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SDKs</a>


More Tools


Concepts


# Secret reference syntax


Copy page


Copy page


``` shiki
op://<vault-name>/<item-name>/[section-name/]<field-name>
```


## 


<a href="#get-secret-references" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#with-the-1password-desktop-app" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  Open the item where the secret you want to reference is stored.
2.  Select next to the field that contains the secret you want to reference, then select **Copy Secret Reference**.


### 


<a href="#with-1password-for-vs-code" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


1.  Open the **<a href="https://code.visualstudio.com/api/ux-guidelines/command-palette" class="link" target="_blank" rel="noreferrer">Command Palette</a>** .
2.  Enter `1Password: Get from 1Password`.
3.  Enter the item name or ID.
4.  Select the field to use.

### 


<a href="#with-1password-cli" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


Example JSON output


``` shiki
op item get GitHub --format json
```


``` shiki
  "fields": [
    {
      "id": "username",
      "type": "STRING",
      "purpose": "USERNAME",
      "label": "username",
      "value": "wendy_appleseed@agilebits.com",
      "reference": "op://development/GitHub/username"
    },
    {
      "id": "password",
      "type": "CONCEALED",
      "purpose": "PASSWORD",
      "label": "password",
      "value": "GADbhK6MjNZrRftGMqto",
      "entropy": 115.5291519165039,
      "reference": "op://development/GitHub/password",
      "password_details": {
        "entropy": 115,
        "generated": true,
        "strength": "FANTASTIC"
      }
    },
    {
      "id": "notesPlain",
      "type": "STRING",
      "purpose": "NOTES",
      "label": "notesPlain",
      "reference": "op://development/GitHub/notesPlain"
    },
    {
      "id": "5ni6bw735myujqe4elwbzuf2ee",
      "section": {
        "id": "hv46kvrohfj75q6g45km2uultq",
        "label": "credentials"
      },
      "type": "CONCEALED",
      "label": "personal_token",
      "value": "ghp_WzgPAEutsFRZH9uxWYtw",
      "reference": "op://development/GitHub/credentials/personal_token"
    }
  ]
}
```


## 


<a href="#syntax-rules" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#supported-characters" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- alphanumeric characters (`a-z`, `A-Z`, `0-9`)
- `-`, `_`, `.` and the whitespace character


``` shiki
op read "op://development/aws/Access Keys/access_key_id"
```


### 


<a href="#file-attachments" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op://vault-name/item-name/[section-name/]file-name
```


### 


<a href="#externally-set-variables" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
MYSQL_DATABASE = "op://$APP_ENV/mysql/database"
MYSQL_USERNAME = "op://$APP_ENV/mysql/username"
MYSQL_PASSWORD = "op://$APP_ENV/mysql/password"
```


### 


<a href="#field-and-file-metadata-attributes" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


#### 


<a href="#attribute-parameter" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op://<vault>/<item>[/<section>]/<field-name>?attribute=<attribute-value>
```


``` shiki
op://<vault>/<item>[/<section>]/<file-name>?attribute=<attribute-value>
```


| Attribute | Definition                                                                      |
|-----------|---------------------------------------------------------------------------------|
| `type`    | The field’s type                                                                |
| `value`   | The field’s content                                                             |
| `id`      | The field’s unique identifier                                                   |
| `purpose` | The designation of a built-in field (can be “username”, “password”, or “notes”) |
| `otp`     | Use with one-time password fields to generate a one-time password code          |


| Attribute | Definition                              |
|-----------|-----------------------------------------|
| `type`    | The field’s type                        |
| `content` | The file attachment’s content           |
| `size`    | The size of the file attachment         |
| `id`      | The file attachment’s unique identifier |
| `name`    | The name of the file attachment         |


#### 


<a href="#ssh-format-parameter" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#secret-reference-examples" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#a-field-inside-a-section" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op://Management/PagerDuty/Admin/email
```


- `Management` refers to the vault where the item is saved
- `PagerDuty` refers to the item
- `Admin` refers to the section where the field is a part of
- `email` refers to the field where the secret you want to reference is located


### 


<a href="#a-field-without-a-section" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op://dev/Stripe/publishable-key
```


- `dev` refers to the vault where the item is saved
- `Stripe` refers to the item
- `publishable-key` refers to the field where the secret you want to reference is located


## 


<a href="#learn-more" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/cli/secret-references" class="link">Use secret references with 1Password CLI</a>
- <a href="/sdks" class="link">Get started with 1Password SDKs</a>
- <a href="/cli/secrets-config-files" class="link">Load secrets into config files</a>
- <a href="/cli/secrets-environment-variables" class="link">Load secrets into the environment</a>
- <a href="/cli/secrets-template-syntax" class="link">Template syntax</a>
- <a href="/get-started/secure-developer-secrets" class="link">Workflow: Secure your developer secrets</a>


Was this page helpful?


<a href="/cli/item-template-json" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Item JSON template</span></a><a href="/cli/secrets-template-syntax" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Template syntax</span></a>


Responses are generated using AI and may contain mistakes.


<a href="mailto:support@1password.com" class="group flex justify-between items-center gap-1 mt-2 py-1 transition-colors duration-200" data-component-part="contact-support-button"><span data-component-part="contact-support-icon"></span></a>

Contact support


