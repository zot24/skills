> Source: https://www.1password.dev/cli/reference/commands/completion/



General commands


# completion


Copy page


Copy page


``` shiki
op completion <shell> [flags]
```


#### 


<a href="#load-shell-completion-information-for-bash" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
source <(op completion bash)
```


#### 


<a href="#load-shell-completion-information-for-zsh" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
eval "$(op completion zsh)"; compdef _op op
```


#### 


<a href="#load-shell-completion-information-for-fish" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op completion fish | source
```


#### 


<a href="#load-shell-completion-information-for-powershell" class="-ml-10 flex items-center opacity-0 border-0 group-hover:opacity-100 focus:opacity-100 focus:outline-0 group/link" aria-label="Navigate to header">​</a>


``` shiki
op completion powershell | Out-String | Invoke-Expression
```


``` shiki
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
```


Was this page helpful?


<a href="/cli/reference/management-commands/vault" class="flex items-center space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">vault</span></a><a href="/cli/reference/commands/inject" class="flex items-center ml-auto space-x-3 group"><span class="group-hover:text-gray-900 dark:group-hover:text-white">inject</span></a>


