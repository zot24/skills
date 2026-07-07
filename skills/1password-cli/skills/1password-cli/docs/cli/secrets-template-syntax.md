> Source: https://www.1password.dev/cli/secrets-template-syntax/



Concepts


# Template syntax


Copy page


Copy page


``` shiki
database:
  host: localhost
  port: 5432
  username: {{ op://prod/database/username }}
  password: {{ op://prod/database/password }}
```


## 


<a href="#secret-references" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#unenclosed-secret-references" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op://test-app/database/password
```


- Begins with `op://` and is not preceded by any of the characters from: `alphanumeric`, `-`, `+` , `\`, `.`.
- Ends with either the end of the template, or the first encountered character outside the following set: `alphanumeric`, `-`, `?`, `_`, `.`.


### 


<a href="#enclosed-secret-references" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
{{ op://test-app/database/password }}
```


- Begins with two closed braces `{{`
- Ends with the two closed braces `}}`
- Contains a valid unenclosed secret reference between the two pairs of braces, possibly padded with spaces


### 


<a href="#special-characters" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
{{ "{{ test op://prod/docker-credentials/username }}" }}
will be resolved to
{{ test op://prod/docker-credentials/username }}
```


``` shiki
{{ "{{ test \"test\" test }}" }}
will be resolved to
{{ test "test" test }}
```


## 


<a href="#variables" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- `$var` (unenclosed variables)
- `${var}` (enclosed variables)


### 


<a href="#default-values" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#learn-more" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="/cli/secrets-config-files" class="link">Load secrets into config files</a>
- <a href="/cli/secrets-environment-variables" class="link">Load secrets into the environment</a>
- <a href="/cli/secret-reference-syntax" class="link">Secret reference syntax</a>
- <a href="/get-started/secure-developer-secrets" class="link">Workflow: Secure your developer secrets</a>
- <a href="/get-started/developer-quickstart" class="link">Developer quickstart</a>


Was this page helpful?


<a href="/cli/secret-reference-syntax" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Secret reference syntax</span></a><a href="/cli/vault-permissions" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">Vault permissions</span></a>


