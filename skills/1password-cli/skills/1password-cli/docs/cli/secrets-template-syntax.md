> Source: https://www.1password.dev/cli/secrets-template-syntax/



Concepts


# Template syntax


``` shiki
database:
  host: localhost
  port: 5432
  username: {{ op://prod/database/username }}
  password: {{ op://prod/database/password }}
```


## <a href="#secret-references" class="anchor-link" aria-label="Navigate to header: Secret references"></a><span id="_R_79deehkd74t9_" class="cursor-pointer">Secret references</span>


### <a href="#unenclosed-secret-references" class="anchor-link" aria-label="Navigate to header: Unenclosed secret references"></a><span id="_R_b9deehkd74t9_" class="cursor-pointer">Unenclosed secret references</span>


``` shiki
op://test-app/database/password
```


- Begins with `op://` and is not preceded by any of the characters from: `alphanumeric`, `-`, `+` , `\`, `.`.
- Ends with either the end of the template, or the first encountered character outside the following set: `alphanumeric`, `-`, `?`, `_`, `.`.


### <a href="#enclosed-secret-references" class="anchor-link" aria-label="Navigate to header: Enclosed secret references"></a><span id="_R_119deehkd74t9_" class="cursor-pointer">Enclosed secret references</span>


``` shiki
{{ op://test-app/database/password }}
```


- Begins with two closed braces `{{`
- Ends with the two closed braces `}}`
- Contains a valid unenclosed secret reference between the two pairs of braces, possibly padded with spaces


### <a href="#special-characters" class="anchor-link" aria-label="Navigate to header: Special characters"></a><span id="_R_1j9deehkd74t9_" class="cursor-pointer">Special characters</span>


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


## <a href="#variables" class="anchor-link" aria-label="Navigate to header: Variables"></a><span id="_R_1t9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Variables</span>


- `$var` (unenclosed variables)
- `${var}` (enclosed variables)


### <a href="#default-values" class="anchor-link" aria-label="Navigate to header: Default values"></a><span id="_R_319deehkd74t9_" class="cursor-pointer">Default values</span>


## <a href="#learn-more" class="anchor-link" aria-label="Navigate to header: Learn more"></a><span id="_R_3b9deehkd74t9_" class="cursor-pointer">Learn more</span>

- <a href="/cli/secrets-config-files/" class="link">Load secrets into config files</a>
- <a href="/cli/secrets-environment-variables/" class="link">Load secrets into the environment</a>
- <a href="/cli/secret-reference-syntax/" class="link">Secret reference syntax</a>
- <a href="/get-started/secure-developer-secrets" class="link">Workflow: Secure local development</a>


Was this page helpful?


