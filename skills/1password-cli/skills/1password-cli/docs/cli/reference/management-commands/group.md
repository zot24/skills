> Source: https://www.1password.dev/cli/reference/management-commands/group/



Management commands


# group


Copy page


Copy page


### 


<a href="#subcommands" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="#group-create" class="link">group create</a>: Create a group
- <a href="#group-delete" class="link">group delete</a>: Remove a group
- <a href="#group-edit" class="link">group edit</a>: Edit a group’s name or description
- <a href="#group-get" class="link">group get</a>: Get details about a group
- <a href="#group-list" class="link">group list</a>: List groups
- <a href="#group-user" class="link">group user</a>: Manage group membership

## 


<a href="#group-create" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op group create <name> [flags]
```


### 


<a href="#flags" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--description string   Set the group's description.
```


## 


<a href="#group-delete" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op group delete [{ <groupName> | <groupID> | - }] [flags]
```


## 


<a href="#group-edit" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op group edit [{ <groupName> | <groupID> | - }] [flags]
```


### 


<a href="#flags-2" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--description description   Change the group's description.
--name name                 Change the group's name.
```


## 


<a href="#group-get" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op group get [{ <groupName> | <groupID> | - }] [flags]
```


#### 


<a href="#use-standard-input-to-specify-objects" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#examples" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op group list --format=json | op group get -
```


``` shiki
op group list --vault "Production keys" --format=json | op group get -
```


## 


<a href="#group-list" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op group list [flags]
```


### 


<a href="#flags-3" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--user user     List groups that a user belongs to.
--vault vault   List groups that have direct access to a vault.
```


### 


<a href="#examples-2" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op group list | op group get -
```


``` shiki
op group list --vault Staging --format=json | op group get -
```


``` shiki
op group list --user wendy_appleseed@1password.com --format=json | op group get -
```


## 


<a href="#group-user" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#subcommands-2" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="#group-user-grant" class="link">group user grant</a>: Add a user to a group
- <a href="#group-user-list" class="link">group user list</a>: Retrieve users that belong to a group
- <a href="#group-user-revoke" class="link">group user revoke</a>: Remove a user from a group

## 


<a href="#group-user-grant" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op group user grant [flags]
```


### 


<a href="#flags-4" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--group string   Specify the group to grant the user access to.
--role string    Specify the user's role as a member or manager. Default: member.
--user string    Specify the user to grant group access to.
```


## 


<a href="#group-user-list" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op group user list <group> [flags]
```


## 


<a href="#group-user-revoke" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op group user revoke [flags]
```


### 


<a href="#flags-5" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--group string   Specify the group to remove the user from.
--help           Get help with group user revoke.
--user string    Specify the user to remove from the group.
```


Was this page helpful?


<a href="/cli/reference/management-commands/events-api" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">events-api</span></a><a href="/cli/reference/management-commands/item" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">item</span></a>


