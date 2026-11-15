> Source: https://www.1password.dev/cli/reference/management-commands/environment/



Management commands


# environment


### <a href="#subcommands" class="anchor-link" aria-label="Navigate to header: Subcommands"></a><span id="_R_59deehkd74t9_" class="min-w-0 break-words cursor-pointer">Subcommands</span>

- <a href="#environment-secret" class="link">environment secret</a>: Manage the secrets in a 1Password Environment

## <a href="#environment-secret" class="anchor-link" aria-label="Navigate to header: environment secret"></a><span id="_R_99deehkd74t9_" class="cursor-pointer">environment secret</span>


### <a href="#environment-secret-subcommands" class="anchor-link" aria-label="Navigate to header: Subcommands"></a><span id="_R_d9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Subcommands</span>

- <a href="#environment-secret-list" class="link">environment secret list</a>: List the secrets in a 1Password Environment

## <a href="#environment-secret-list" class="anchor-link" aria-label="Navigate to header: environment secret list"></a><span id="_R_h9deehkd74t9_" class="cursor-pointer">environment secret list</span>


``` shiki
op environment secret list { <environmentName> | <environmentID> | - } [flags]
```


### <a href="#environment-secret-list-flags" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_n9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--format string   Use this output format. Can be `human-readable`, `json`, `csv`, or
                  `dotenv`. Can be set as the OP_FORMAT environment variable.
                  (default "human-readable")
--reveal          Don't conceal the secrets' values.
```


### <a href="#environment-secret-list-examples" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_v9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
op environment secret list 6ijsqfxvdxlwjcpsx7yrzs3tka
```


``` shiki
op environment secret list Staging
```


``` shiki
op environment secret list Staging --reveal
```


``` shiki
op environment secret list Staging --reveal --format=dotenv
```


Was this page helpful?


