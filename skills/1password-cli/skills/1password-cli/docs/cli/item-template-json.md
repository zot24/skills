> Source: https://www.1password.dev/cli/item-template-json/



> ## Documentation Index
>
> Fetch the complete documentation index at: [/llms.txt](/llms.txt)
>
> Use this file to discover all available pages before exploring further.


<a href="#content-area" class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:p-2 focus:text-sm focus:bg-background-light dark:focus:bg-background-dark focus:rounded-md focus:outline-primary dark:focus:outline-primary-light">Skip to main content</a>


<a href="/" class="select-none" data-state="closed" data-slot="context-menu-trigger" style="-webkit-touch-callout:none"><span class="sr-only">1Password Developer home page</span><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-dark.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=29d1c9358888a723dddd8a89a3b6f71d" class="nav-logo w-auto h-7 relative object-contain shrink-0 block dark:hidden" alt="light logo" /><img src="https://mintcdn.com/ab-634991b8/lHrfVfSCdefFz8U5/static/img/logo-light.svg?fit=max&amp;auto=format&amp;n=lHrfVfSCdefFz8U5&amp;q=85&amp;s=119233092720e49043d6f42ff71125f1" class="nav-logo w-auto h-7 relative object-contain shrink-0 hidden dark:block" alt="dark logo" /></a>


Search...


Concepts


Item JSON template


<a href="/get-started" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Get Started</a>


<a href="/security-for-ai" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Security for AI</a>


<a href="/environments" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">Environments</a>


<a href="/ssh" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SSH &amp; Git</a>


<a href="/cli" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium hover:text-gray-800 dark:hover:text-gray-300 text-gray-800 dark:text-gray-200 [text-shadow:-0.2px_0_0_currentColor,0.2px_0_0_currentColor]" data-active="true" aria-current="location">CLI</a>


<a href="/sdks" class="link nav-tabs-item group relative h-full gap-2 flex items-center font-medium text-gray-600 dark:text-gray-400 hover:text-gray-800 dark:hover:text-gray-300">SDKs</a>


More Tools


Concepts


# Item JSON template


Copy page


Copy page


## 


<a href="#item-template-keys" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
{
  "title": " ",
  "category": " ",
  "sections": [
    {
      "id": " ",
      "label": " "
    },
  ],
  "fields": [
    {
      "id": " ",
      "section": {
        "id": " "
      },
      "type": " ",
      "label": " ",
      "value": " "
    }
  ]
}
```


| Name       | Description                                  |
|------------|----------------------------------------------|
| `title`    | The name of the item displayed in 1Password. |
| `category` | The item’s category.                         |


| Name    | Description                                                                                |
|---------|--------------------------------------------------------------------------------------------|
| `id`    | The identifier for the section. If the item has multiple sections, each ID must be unique. |
| `label` | The name of the section displayed in 1Password.                                            |


View a section JSON object


``` shiki
    {
      "id": " ",
      "label": " "
    }
```


| Name         | Description                                                                                                      |
|--------------|------------------------------------------------------------------------------------------------------------------|
| `id`         | The field’s ID. Each ID should be unique. If left empty, 1Password will generate a random ID.                    |
| `section id` | The ID of the section where the field is located. Only required if located in a custom section.                  |
| `type`       | The field’s type. <a href="/cli/item-fields#custom-fields" class="link">Learn more about custom field types.</a> |
| `label`      | The name of the field displayed in 1Password.                                                                    |
| `value`      | The information saved in the field. Depending on its type, it can be a string, a secret, a number, or a date.    |


View a field JSON object


``` shiki
    {
      "id": " ",
      "section": {
        "id": " "
      },
      "type": " ",
      "label": " ",
      "value": " "
    }
```


## 


<a href="#example-json-representation" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <div id="in-the-app">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" component-part="tab-button" active="true" testid="tab-In the app">

  In the app

  </div>

  </div>

- <div id="in-the-json-template">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" component-part="tab-button" active="false" testid="tab-In the JSON template">

  In the JSON template

  </div>

  </div>


``` shiki
{
  "id": "4l3udxihvvuhszh2kxyjbblxl4",
  "title": "mysql",
  "version": 3,
  "vault": {
    "id": "uteieiwkhgv6hau7xkorejyvru"
  },
  "category": "DATABASE",
  "last_edited_by": "IU2OKUBKAFGQPFPFZEG7X3NQ4U",
  "created_at": "2021-11-25T14:50:14Z",
  "updated_at": "2022-02-25T18:12:12Z",
  "sections": [
    {
      "id": "g52gfotnw7nhnkgq477si2hmmi",
      "label": "Database Owner"
    }
  ],
  "fields": [
    {
      "id": "notesPlain",
      "type": "STRING",
      "purpose": "NOTES",
      "label": "notesPlain"
    },
    {
      "id": "database_type",
      "type": "MENU",
      "label": "type",
      "value": "mysql"
    },
    {
      "id": "hostname",
      "type": "STRING",
      "label": "server",
      "value": "http://localhost"
    },
    {
      "id": "port",
      "type": "STRING",
      "label": "port",
      "value": "5432"
    },
    {
      "id": "database",
      "type": "STRING",
      "label": "database",
      "value": "app-database"
    },
    {
      "id": "username",
      "type": "STRING",
      "label": "username",
      "value": "mysql-user"
    },
    {
      "id": "password",
      "type": "CONCEALED",
      "label": "password",
      "value": "T4Kn7np2bLJXAFoYPoVC"
    },
    {
      "id": "sid",
      "type": "STRING",
      "label": "SID"
    },
    {
      "id": "alias",
      "type": "STRING",
      "label": "alias"
    },
    {
      "id": "options",
      "type": "STRING",
      "label": "connection options"
    },
    {
      "id": "tpcs7jrjikehw5o4tzbe5pklca",
      "section": {
        "id": "g52gfotnw7nhnkgq477si2hmmi",
        "label": "Database Owner"
      },
      "type": "STRING",
      "label": "admin",
      "value": "Wendy Appleseed"
    },
    {
      "id": "sdqueijyulxryvu5ceuwktjkiq",
      "section": {
        "id": "g52gfotnw7nhnkgq477si2hmmi",
        "label": "Database Owner"
      },
      "type": "EMAIL",
      "label": "email",
      "value": "appleseed.wendy@gmail.com"
    }
  ]
}
```


## 


<a href="#learn-more" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/cli/item-create" class="link">Create an item</a>
- <a href="/cli/reference/management-commands/item" class="link">Work with items</a>
- <a href="/cli/reference/management-commands/vault" class="link">Work with vaults</a>
- <a href="/get-started/build-integrations" class="link">Workflow: Build integrations with 1Password</a>


Was this page helpful?


<a href="/cli/item-fields" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Item fields</span></a><a href="/cli/secret-reference-syntax" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Secret reference syntax</span></a>


Responses are generated using AI and may contain mistakes.


<a href="mailto:support@1password.com" class="group flex justify-between items-center gap-1 mt-2 py-1 transition-colors duration-200" data-component-part="contact-support-button"><span data-component-part="contact-support-icon"></span></a>

Contact support


