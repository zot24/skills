> Source: https://www.1password.dev/cli/item-fields/



Concepts


# Item fields


Copy page


Copy page


## 


<a href="#built-in-fields" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op item template get <category>
```


View all categories


- API Credential
- Bank Account
- Credit Card
- Crypto Wallet
- Database
- Document
- Driver License
- Email Account
- Identity
- Login
- Medical Record
- Membership
- Outdoor License
- Passport
- Password
- Reward Program
- Secure Note
- Server
- Social Security Number
- Software License
- SSH Key
- Wireless Router


View a Login item JSON template


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
      "password_details": {
        "strength": "TERRIBLE"
      },
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


``` shiki
'notesPlain=This is a note.'
```


## 


<a href="#custom-fields" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


| `fieldType` | `type` | description |
|----|----|----|
| `password` | `CONCEALED` | A concealed password. |
| `text` | `STRING` | A text string. |
| `email` | `EMAIL` | An email address. |
| `url` | `URL` | A web address to copy or open in your default web browser, not used for autofill behavior. Use the `--url` flag to set the website where 1Password suggests and fills a Login, Password, or API Credential item. |
| `date` | `DATE` | A date with the format `YYYY-MM-DD`. |
| `monthYear` | `MONTH_YEAR` | A date with the format `YYYYMM` or `YYYY/MM`. |
| `phone` | `PHONE` | A phone number. |
| `otp` | `OTP` | A one-time password. Accepts an <a href="https://github.com/google/google-authenticator/wiki/Key-Uri-Format" class="link" target="_blank" rel="noreferrer"><code>otpauth://</code> URI</a> as the value. |
| `file` | N/A | A file attachment. Accepts the path to the file as the value. Can only be added with <a href="/cli/item-create#with-assignment-statements" class="link">assignment statements</a>. |


## 


<a href="#learn-more" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/cli/reference/management-commands/item" class="link"><code>op item</code> reference documentation</a>
- <a href="/cli/item-create" class="link">Create an item</a>
- <a href="/cli/item-template-json" class="link">Item JSON template</a>
- <a href="/get-started/build-integrations" class="link">Workflow: Build integrations with 1Password</a>


Was this page helpful?


<a href="/cli/environment-variables" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Environment variables</span></a><a href="/cli/item-template-json" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Item JSON template</span></a>


