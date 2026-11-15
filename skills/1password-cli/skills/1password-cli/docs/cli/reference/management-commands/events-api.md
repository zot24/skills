> Source: https://www.1password.dev/cli/reference/management-commands/events-api/



Management commands


# events-api


### <a href="#subcommands" class="anchor-link" aria-label="Navigate to header: Subcommands"></a><span id="_R_39deehkd74t9_" class="min-w-0 break-words cursor-pointer">Subcommands</span>

- <a href="#events-api-create" class="link">events-api create</a>: Set up an integration with the Events API

## <a href="#events-api-create" class="anchor-link" aria-label="Navigate to header: events-api create"></a><span id="_R_79deehkd74t9_" class="cursor-pointer">events-api create</span>


``` shiki
op events-api create <name> [flags]
```


### <a href="#flags" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_d9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--expires-in duration   Set how the long the events-api token is valid for in
                        (s)econds, (m)inutes, (h)ours, (d)ays, and/or (w)eeks.
--features features     Set the comma-separated list of features the integration
                        token can be used for. Options: `signinattempts`,
                        `itemusages`, `auditevents`.
```


### <a href="#examples" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_l9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
op events-api create SigninEvents --features signinattempts --expires-in 1h
```


``` shiki
op events-api create AllEvents
```


Was this page helpful?


