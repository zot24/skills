> Source: https://www.1password.dev/cli/reference/management-commands/events-api/



Management commands


# events-api


Copy page


Copy page


### 


<a href="#subcommands" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="#events-api-create" class="link">events-api create</a>: Set up an integration with the Events API

## 


<a href="#events-api-create" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op events-api create <name> [flags]
```


### 


<a href="#flags" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--expires-in duration   Set how the long the events-api token is valid for in
                        (s)econds, (m)inutes, (h)ours, (d)ays, and/or (w)eeks.
--features features     Set the comma-separated list of features the integration
                        token can be used for. Options: `signinattempts`,
                        `itemusages`, `auditevents`.
```


### 


<a href="#examples" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op events-api create SigninEvents --features signinattempts --expires-in 1h
```


``` shiki
op events-api create AllEvents
```


Was this page helpful?


<a href="/cli/reference/management-commands/environment" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">environment</span></a><a href="/cli/reference/management-commands/group" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">group</span></a>


