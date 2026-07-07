> Source: https://www.1password.dev/cli/reference/management-commands/document/



Management commands


# document


Copy page


Copy page


### 


<a href="#subcommands" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


- <a href="#document-create" class="link">document create</a>: Create a document item
- <a href="#document-delete" class="link">document delete</a>: Delete or archive a document item
- <a href="#document-edit" class="link">document edit</a>: Edit a document item
- <a href="#document-get" class="link">document get</a>: Download a document
- <a href="#document-list" class="link">document list</a>: Get a list of documents

## 


<a href="#document-create" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op document create [{ <file> | - }] [flags]
```


### 


<a href="#flags" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--file-name name   Set the file's name.
--tags tags        Set the tags to the specified (comma-separated) values.
--title title      Set the document item's title.
--vault vault      Save the document in this vault. Default: Private.
```


#### 


<a href="#create-a-file-from-standard-input" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#examples" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op document create "../demos/videos/demo.mkv" --title "2020-06-21 Demo Video"
```


``` shiki
cat auth.log.* | op document create - --title "Authlogs 2020-06" --file-name "auth.log.2020.06"
```


## 


<a href="#document-delete" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op document delete [{ <itemName> | <itemID> | - }] [flags]
```


### 


<a href="#flags-2" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--archive       Move the document to the Archive.
--vault vault   Delete the document in this vault.
```


#### 


<a href="#specify-items-on-standard-input" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#examples-2" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op document delete "2019 Contracts"
```


``` shiki
op document delete "2019 Contracts" --archive
```


## 


<a href="#document-edit" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op document edit { <itemName> | <itemID> } [{ <file> | - }] [flags]
```


### 


<a href="#flags-3" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--file-name name   Set the file's name.
--tags tags        Set the tags to the specified (comma-separated) values. An empty
                   value removes all tags.
--title title      Set the document item's title.
--vault vault      Look up document in this vault.
```


#### 


<a href="#update-a-file-from-standard-input" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


## 


<a href="#document-get" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op document get { <itemName> | <itemID> } [flags]
```


### 


<a href="#flags-4" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
    --file-mode filemode Set filemode for the output file. It is ignored without the --out-file flag. (default 0600)
    --force              Forcibly print an unintelligible document to an interactive terminal. If --out-file is specified, save the document to a file without prompting for confirmation.
    --include-archive    Include document items in the Archive. Can also be set using OP_INCLUDE_ARCHIVE environment variable.
-o, --out-file path      Save the document to the file path instead of stdout.
    --vault vault        Look for the document in this vault.
```


#### 


<a href="#save-to-a-file" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


### 


<a href="#examples-3" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op document get "Top Secret Plan B" --out-file=../documents/secret-plans.text
```


## 


<a href="#document-list" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op document list [flags]
```


### 


<a href="#flags-5" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
--include-archive   Include document items in the Archive. Can also be set using
                    OP_INCLUDE_ARCHIVE environment variable.
--vault vault       Only list documents in this vault.
```


Was this page helpful?


<a href="/cli/reference/management-commands/connect" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">connect</span></a><a href="/cli/reference/management-commands/environment" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">environment</span></a>


