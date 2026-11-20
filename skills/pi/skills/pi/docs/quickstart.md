> Source: https://pi.dev/docs/latest/quickstart



# Quickstart


Pi runs in your terminal and works with files on your machine. To use it, you need access to a model through a supported provider. This can be a subscription, an API key, or a local model.

For native Windows setup, read <a href="/latest/windows" class="link-module_root__svb26">Windows Setup</a>. For Android, read <a href="/latest/termux" class="link-module_root__svb26">Termux Setup</a>.


## 1. Install Pi


Install Pi with the installer on macOS, Linux, or Windows:

``` code-snippet-module_root__tK5do
curl -fsSL https://pi.dev/install.sh | sh
```

``` code-snippet-module_root__tK5do
powershell -c "irm https://pi.dev/install.ps1 | iex"
```

Both installers pin all dependencies and update Pi with `pi update`. Alternatively, install Pi from npm, which does not pin transitive dependencies. This requires Node.js 22.19 or newer:

``` code-snippet-module_root__tK5do
npm install -g --ignore-scripts @earendil-works/pi-coding-agent
```

Pi does not require dependency lifecycle scripts for a normal npm installation.

With Nix on macOS or Linux, install the latest release from Pi's flake. Nix builds Pi from source:

``` code-snippet-module_root__tK5do
nix profile add github:earendil-works/pi/stable
```

Older Nix versions use `nix profile install` instead. Update with `nix profile upgrade pi`; `pi update` cannot update a Nix installation. To pin a release, use a tag such as `github:earendil-works/pi/v1.0.0`.

Verify the installation:

``` code-snippet-module_root__tK5do
pi --version
```


## 2. Start Pi


Change to the folder you want Pi to work with, then start it:

``` code-snippet-module_root__tK5do
cd /path/to/folder
pi
```

The working folder helps Pi discover relevant files, instructions, and configuration. Pi also uses it to group saved sessions.

<img src="/latest/images/interactive-mode.png" class="image-module_root__h-f8n" decoding="async" width="750" alt="Pi running in a terminal with a conversation, input editor, and status footer" />

The interface shows your conversation, an editor for prompts and commands, and a footer with the current folder, model, and session status. See <a href="/latest/usage" class="link-module_root__svb26">Use Pi in the terminal</a> to learn how to add files, run commands, direct ongoing work, and manage results.


## 3. Choose a model


A **model** generates Pi's responses. A **provider** is the service or account Pi uses to access that model.

In Pi, run:

``` code-snippet-module_root__tK5do
/login
```

Choose a provider, then follow the prompts to use a subscription or store an API key. Run `/model` afterward if you want to select a different available model.

See <a href="/latest/models" class="link-module_root__svb26">Choose a model and provider</a> for supported providers, environment-variable authentication, local models, and custom endpoints.


## 4. Give Pi a task


Pi shows each file read, search, command, and edit it performs. It does not ask before every tool call.

Enter a task that matches your work, for example:

``` code-snippet-module_root__tK5do
Summarize @meeting-notes.md and save the action items to action-items.md.
```

``` code-snippet-module_root__tK5do
Explain how this repository is structured and how to run its checks.
```

``` code-snippet-module_root__tK5do
Compare @previous.csv with @current.csv and summarize the important changes.
```

Type `@` in the editor to search for a file instead of entering its full path. When Pi finishes, review its response and any changed files. Use version control or backups for important work. For untrusted or unattended work, use a container or another sandbox. See <a href="/latest/security" class="link-module_root__svb26">Security</a>.


## Continue later


Pi saves sessions automatically. Exit Pi, then resume the most recent session for the same working folder with:

``` code-snippet-module_root__tK5do
pi --continue
```

Use `/resume` to choose another saved session. See <a href="/latest/sessions" class="link-module_root__svb26">Continue or branch a session</a> for session naming, branching, compaction, export, and sharing.


## Next steps


- <a href="/latest/usage" class="link-module_root__svb26">Use Pi interactively</a> to learn input, commands, shortcuts, and queued messages.
- <a href="/latest/configuration#context-files" class="link-module_root__svb26">Add instructions</a> that Pi should follow whenever it works in a folder.
- <a href="/latest/models" class="link-module_root__svb26">Choose a model and provider</a>.


### Choose how to customize Pi


Start with the least powerful mechanism that meets your need:


| Need | Start with |
|----|----|
| Give Pi persistent instructions for a folder | <a href="/latest/configuration#context-files" class="link-module_root__svb26"><code class="inline-code-module_root__fGvLx" data-variant="soft">AGENTS.md</code></a> |
| Reuse a prompt from the `/` menu | <a href="/latest/prompt-templates" class="link-module_root__svb26">Prompt template</a> |
| Add task-specific instructions and supporting files | <a href="/latest/skills" class="link-module_root__svb26">Skill</a> |
| Add executable tools, commands, or event handlers | <a href="/latest/extensions" class="link-module_root__svb26">Extension</a> |
| Build a custom terminal component | <a href="/latest/tui" class="link-module_root__svb26">Terminal UI</a> |
| Connect an unsupported model service | <a href="/latest/custom-provider" class="link-module_root__svb26">Custom provider</a> |
| Install or distribute several resources | <a href="/latest/packages" class="link-module_root__svb26">Pi package</a> |


## Uninstall Pi


If you installed Pi with npm, run:

``` code-snippet-module_root__tK5do
npm uninstall -g @earendil-works/pi-coding-agent
```

If you used the installer, run it again and choose **Uninstall Pi**:

``` code-snippet-module_root__tK5do
curl -fsSL https://pi.dev/install.sh | sh
```

If you installed Pi with Nix, run:

``` code-snippet-module_root__tK5do
nix profile remove pi
```

None of these methods removes configuration, credentials, sessions, or installed Pi packages from `~/.pi/agent/`.


