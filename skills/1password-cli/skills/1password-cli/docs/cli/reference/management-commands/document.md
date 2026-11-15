> Source: https://www.1password.dev/cli/reference/management-commands/document/



Management commands


# document


### <a href="#subcommands" class="anchor-link" aria-label="Navigate to header: Subcommands"></a><span id="_R_39deehkd74t9_" class="min-w-0 break-words cursor-pointer">Subcommands</span>

- <a href="#document-create" class="link">document create</a>: Create a document item
- <a href="#document-delete" class="link">document delete</a>: Delete or archive a document item
- <a href="#document-edit" class="link">document edit</a>: Edit a document item
- <a href="#document-get" class="link">document get</a>: Download a document
- <a href="#document-list" class="link">document list</a>: Get a list of documents

## <a href="#document-create" class="anchor-link" aria-label="Navigate to header: document create"></a><span id="_R_79deehkd74t9_" class="cursor-pointer">document create</span>


``` shiki
op document create [{ <file> | - }] [flags]
```


### <a href="#flags" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_d9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--file-name name   Set the file's name.
--tags tags        Set the tags to the specified (comma-separated) values.
--title title      Set the document item's title.
--vault vault      Save the document in this vault. Default: Private.
```


#### <a href="#create-a-file-from-standard-input" class="anchor-link" aria-label="Navigate to header: Create a file from standard input"></a><span id="_R_j9deehkd74t9_" class="cursor-pointer">Create a file from standard input</span>


### <a href="#examples" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_n9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
op document create "../demos/videos/demo.mkv" --title "2020-06-21 Demo Video"
```


``` shiki
cat auth.log.* | op document create - --title "Authlogs 2020-06" --file-name "auth.log.2020.06"
```


## <a href="#document-delete" class="anchor-link" aria-label="Navigate to header: document delete"></a><span id="_R_119deehkd74t9_" class="cursor-pointer">document delete</span>


``` shiki
op document delete [{ <itemName> | <itemID> | - }] [flags]
```


### <a href="#flags-2" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_179deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--archive       Move the document to the Archive.
--vault vault   Delete the document in this vault.
```


#### <a href="#specify-items-on-standard-input" class="anchor-link" aria-label="Navigate to header: Specify items on standard input"></a><span id="_R_1b9deehkd74t9_" class="cursor-pointer">Specify items on standard input</span>


### <a href="#examples-2" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_1h9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
op document delete "2019 Contracts"
```


``` shiki
op document delete "2019 Contracts" --archive
```


## <a href="#document-edit" class="anchor-link" aria-label="Navigate to header: document edit"></a><span id="_R_1r9deehkd74t9_" class="cursor-pointer">document edit</span>


``` shiki
op document edit { <itemName> | <itemID> } [{ <file> | - }] [flags]
```


### <a href="#flags-3" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_219deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--file-name name   Set the file's name.
--tags tags        Set the tags to the specified (comma-separated) values. An empty
                   value removes all tags.
--title title      Set the document item's title.
--vault vault      Look up document in this vault.
```


#### <a href="#update-a-file-from-standard-input" class="anchor-link" aria-label="Navigate to header: Update a file from standard input"></a><span id="_R_279deehkd74t9_" class="cursor-pointer">Update a file from standard input</span>


## <a href="#document-get" class="anchor-link" aria-label="Navigate to header: document get"></a><span id="_R_2b9deehkd74t9_" class="cursor-pointer">document get</span>


``` shiki
op document get { <itemName> | <itemID> } [flags]
```


### <a href="#flags-4" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_2h9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
    --file-mode filemode Set filemode for the output file. It is ignored without the --out-file flag. (default 0600)
    --force              Forcibly print an unintelligible document to an interactive terminal. If --out-file is specified, save the document to a file without prompting for confirmation.
    --include-archive    Include document items in the Archive. Can also be set using OP_INCLUDE_ARCHIVE environment variable.
-o, --out-file path      Save the document to the file path instead of stdout.
    --vault vault        Look for the document in this vault.
```


#### <a href="#save-to-a-file" class="anchor-link" aria-label="Navigate to header: Save to a file"></a><span id="_R_2n9deehkd74t9_" class="cursor-pointer">Save to a file</span>


### <a href="#examples-3" class="anchor-link" aria-label="Navigate to header: Examples"></a><span id="_R_2t9deehkd74t9_" class="min-w-0 break-words cursor-pointer">Examples</span>


``` shiki
op document get "Top Secret Plan B" --out-file=../documents/secret-plans.text
```


## <a href="#document-list" class="anchor-link" aria-label="Navigate to header: document list"></a><span id="_R_339deehkd74t9_" class="cursor-pointer">document list</span>


``` shiki
op document list [flags]
```


### <a href="#flags-5" class="anchor-link" aria-label="Navigate to header: Flags"></a><span id="_R_399deehkd74t9_" class="min-w-0 break-words cursor-pointer">Flags</span>


``` shiki
--include-archive   Include document items in the Archive. Can also be set using
                    OP_INCLUDE_ARCHIVE environment variable.
--vault vault       Only list documents in this vault.
```


Was this page helpful?


