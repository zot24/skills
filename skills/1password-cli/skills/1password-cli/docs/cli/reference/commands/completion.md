> Source: https://www.1password.dev/cli/reference/commands/completion/



General commands


# completion


``` shiki
op completion <shell> [flags]
```


#### <a href="#load-shell-completion-information-for-bash" class="anchor-link" aria-label="Navigate to header: Load shell completion information for Bash"></a><span id="_R_79deehkd74t9_" class="cursor-pointer">Load shell completion information for Bash</span>


``` shiki
source <(op completion bash)
```


#### <a href="#load-shell-completion-information-for-zsh" class="anchor-link" aria-label="Navigate to header: Load shell completion information for Zsh"></a><span id="_R_f9deehkd74t9_" class="cursor-pointer">Load shell completion information for Zsh</span>


``` shiki
eval "$(op completion zsh)"; compdef _op op
```


#### <a href="#load-shell-completion-information-for-fish" class="anchor-link" aria-label="Navigate to header: Load shell completion information for fish"></a><span id="_R_l9deehkd74t9_" class="cursor-pointer">Load shell completion information for fish</span>


``` shiki
op completion fish | source
```


#### <a href="#load-shell-completion-information-for-powershell" class="anchor-link" aria-label="Navigate to header: Load shell completion information for PowerShell"></a><span id="_R_r9deehkd74t9_" class="cursor-pointer">Load shell completion information for PowerShell</span>


``` shiki
op completion powershell | Out-String | Invoke-Expression
```


``` shiki
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
```


Was this page helpful?


