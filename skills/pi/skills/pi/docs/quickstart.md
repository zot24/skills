> Source: https://pi.dev/docs/latest/quickstart



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# Quickstart


Pi runs in your terminal and works with files on your machine. To use it, you need access to a model through a supported provider. This can be a subscription, an API key, or a local model.

For native Windows setup, read [Windows Setup](/docs/latest/windows). For Android, read [Termux Setup](/docs/latest/termux).


## 1. Install Pi

<a href="#1-install-pi" class="heading-anchor" aria-label="Permalink: 1. Install Pi" data-copy="" data-copy-text="https://pi.dev/docs/latest/quickstart#1-install-pi"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


On macOS or Linux, you can use the installer:

``` bash
curl -fsSL https://pi.dev/install.sh | sh
```

Alternatively, install Pi from npm. This requires Node.js 22.19 or newer:

``` bash
npm install -g --ignore-scripts @earendil-works/pi-coding-agent
```

Pi does not require dependency lifecycle scripts for a normal npm installation.

Verify the installation:

``` bash
pi --version
```


## 2. Start Pi

<a href="#2-start-pi" class="heading-anchor" aria-label="Permalink: 2. Start Pi" data-copy="" data-copy-text="https://pi.dev/docs/latest/quickstart#2-start-pi"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Change to the folder you want Pi to work with, then start it:

``` bash
cd /path/to/folder
pi
```

The working folder helps Pi discover relevant files, instructions, and configuration. Pi also uses it to group saved sessions.

<img src="/docs/latest/images/interactive-mode.png" width="750" alt="Pi running in a terminal with a conversation, input editor, and status footer" />

The interface shows your conversation, an editor for prompts and commands, and a footer with the current folder, model, and session status. See [Use Pi in the terminal](/docs/latest/usage) to learn how to add files, run commands, direct ongoing work, and manage results.


## 3. Choose a model

<a href="#3-choose-a-model" class="heading-anchor" aria-label="Permalink: 3. Choose a model" data-copy="" data-copy-text="https://pi.dev/docs/latest/quickstart#3-choose-a-model"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


A **model** generates Pi's responses. A **provider** is the service or account Pi uses to access that model.

In Pi, run:

``` text
/login
```

Choose a provider, then follow the prompts to use a subscription or store an API key. Run `/model` afterward if you want to select a different available model.

See [Choose a model and provider](/docs/latest/models) for supported providers, environment-variable authentication, local models, and custom endpoints.


## 4. Give Pi a task

<a href="#4-give-pi-a-task" class="heading-anchor" aria-label="Permalink: 4. Give Pi a task" data-copy="" data-copy-text="https://pi.dev/docs/latest/quickstart#4-give-pi-a-task"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Pi shows each file read, search, command, and edit it performs. It does not ask before every tool call.

Enter a task that matches your work, for example:

``` text
Summarize @meeting-notes.md and save the action items to action-items.md.
```

``` text
Explain how this repository is structured and how to run its checks.
```

``` text
Compare @previous.csv with @current.csv and summarize the important changes.
```

Type `@` in the editor to search for a file instead of entering its full path. When Pi finishes, review its response and any changed files. Use version control or backups for important work. For untrusted or unattended work, use a container or another sandbox. See [Security](/docs/latest/security).


## Continue later

<a href="#continue-later" class="heading-anchor" aria-label="Permalink: Continue later" data-copy="" data-copy-text="https://pi.dev/docs/latest/quickstart#continue-later"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Pi saves sessions automatically. Exit Pi, then resume the most recent session for the same working folder with:

``` bash
pi --continue
```

Use `/resume` to choose another saved session. See [Continue or branch a session](/docs/latest/sessions) for session naming, branching, compaction, export, and sharing.


## Next steps

<a href="#next-steps" class="heading-anchor" aria-label="Permalink: Next steps" data-copy="" data-copy-text="https://pi.dev/docs/latest/quickstart#next-steps"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


- [Use Pi interactively](/docs/latest/usage) to learn input, commands, shortcuts, and queued messages.
- [Add instructions](/docs/latest/configuration#context-files) that Pi should follow whenever it works in a folder.
- [Choose a model and provider](/docs/latest/models).


### Choose how to customize Pi

<a href="#choose-how-to-customize-pi" class="heading-anchor" aria-label="Permalink: Choose how to customize Pi" data-copy="" data-copy-text="https://pi.dev/docs/latest/quickstart#choose-how-to-customize-pi"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Start with the least powerful mechanism that meets your need:

| Need                                                | Start with                                              |
|-----------------------------------------------------|---------------------------------------------------------|
| Give Pi persistent instructions for a folder        | [`AGENTS.md`](/docs/latest/configuration#context-files) |
| Reuse a prompt from the `/` menu                    | [Prompt template](/docs/latest/prompt-templates)        |
| Add task-specific instructions and supporting files | [Skill](/docs/latest/skills)                            |
| Add executable tools, commands, or event handlers   | [Extension](/docs/latest/extensions)                    |
| Build a custom terminal component                   | [Terminal UI](/docs/latest/tui)                         |
| Connect an unsupported model service                | [Custom provider](/docs/latest/custom-provider)         |
| Install or distribute several resources             | [Pi package](/docs/latest/packages)                     |


## Uninstall Pi

<a href="#uninstall-pi" class="heading-anchor" aria-label="Permalink: Uninstall Pi" data-copy="" data-copy-text="https://pi.dev/docs/latest/quickstart#uninstall-pi"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


If you installed Pi with npm, run:

``` bash
npm uninstall -g @earendil-works/pi-coding-agent
```

If you used the installer, run it again and choose **Uninstall Pi**:

``` bash
curl -fsSL https://pi.dev/install.sh | sh
```

Neither method removes configuration, credentials, sessions, or installed Pi packages from `~/.pi/agent/`.


