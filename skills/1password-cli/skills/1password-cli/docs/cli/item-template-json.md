> Source: https://www.1password.dev/cli/item-template-json/



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


| Name | Description |
|----|----|
| `id` | The identifier for the section. If the item has multiple sections, each ID must be unique. |
| `label` | The name of the section displayed in 1Password. |


View a section JSON object


``` shiki
    {
      "id": " ",
      "label": " "
    }
```


| Name | Description |
|----|----|
| `id` | The field’s ID. Each ID should be unique. If left empty, 1Password will generate a random ID. |
| `section id` | The ID of the section where the field is located. Only required if located in a custom section. |
| `type` | The field’s type. <a href="/cli/item-fields#custom-fields" class="link">Learn more about custom field types.</a> |
| `label` | The name of the field displayed in 1Password. |
| `value` | The information saved in the field. Depending on its type, it can be a string, a secret, a number, or a date. |


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

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-primary dark:text-primary-light border-current" data-component-part="tab-button" data-active="true" data-testid="tab-In the app">

  In the app

  </div>

  </div>

- <div id="in-the-json-template">

  <div class="flex text-sm items-center gap-1.5 leading-6 font-semibold whitespace-nowrap pt-3 pb-2.5 -mb-px max-w-max border-b text-gray-900 border-transparent hover:border-gray-300 dark:text-gray-200 dark:hover:border-gray-700" data-component-part="tab-button" data-active="false" data-testid="tab-In the JSON template">

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


