> Source: https://pi.dev/docs/latest



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# Pi


Pi is an extensible AI agent that works from your terminal. Give it a goal and a working folder, and it can inspect files, run commands, edit content, and work through multi-step tasks.

Use Pi for software development, research notes, writing projects, data files, or hobby work. You can use Pi as is, prompt it to adapt itself to your workflow, or build other applications powered by Pi using the SDK.


## Start using Pi

<a href="#start-using-pi" class="heading-anchor" aria-label="Permalink: Start using Pi" data-copy="" data-copy-text="https://pi.dev/docs/latest#start-using-pi"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


New to Pi? Follow the [Quickstart](/docs/latest/quickstart) to install Pi, connect a model, and complete your first task.

If Pi is already installed, choose what you want to do:

- [Use Pi interactively](/docs/latest/usage) to add files, run commands, direct ongoing work, and export results.
- [Choose a model](/docs/latest/models) or connect a subscription, API key, local model, or compatible endpoint.
- [Continue or branch a session](/docs/latest/sessions) to resume work or explore another approach without losing history.
- [Configure Pi](/docs/latest/configuration) for your preferences, working folders, instructions, and reusable resources.
- [Understand how Pi works](/docs/latest/how-pi-works), including tools, context, sessions, and the agent loop.


## Customize Pi

<a href="#customize-pi" class="heading-anchor" aria-label="Permalink: Customize Pi" data-copy="" data-copy-text="https://pi.dev/docs/latest#customize-pi"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Pi can reuse prompts, load specialized instructions, add executable integrations, change its terminal interface, connect model services, and distribute these resources as packages. Use the [Quickstart customization chooser](/docs/latest/quickstart#choose-how-to-customize-pi) to select the smallest mechanism that meets your need.


## Automate or embed Pi

<a href="#automate-or-embed-pi" class="heading-anchor" aria-label="Permalink: Automate or embed Pi" data-copy="" data-copy-text="https://pi.dev/docs/latest#automate-or-embed-pi"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


- Use [print mode](/docs/latest/cli#invocation-and-output) for one-off and scripted tasks.
- Use [JSON event stream mode](/docs/latest/json) to consume structured events from one run.
- Use [RPC mode](/docs/latest/rpc) to control a separate Pi process.
- Use the [TypeScript SDK](/docs/latest/sdk) to run Pi inside an application.


## Find reference and setup information

<a href="#find-reference-and-setup-information" class="heading-anchor" aria-label="Permalink: Find reference and setup information" data-copy="" data-copy-text="https://pi.dev/docs/latest#find-reference-and-setup-information"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Use the reference pages to look up [CLI options](/docs/latest/cli), [settings](/docs/latest/settings), [provider authentication](/docs/latest/providers), [keybindings](/docs/latest/keybindings), and [environment variables](/docs/latest/environment-variables).

For platform-specific help, see [Terminal Setup](/docs/latest/terminal-setup), [Windows](/docs/latest/windows), [tmux](/docs/latest/tmux), [Termux on Android](/docs/latest/termux), or [Containerization](/docs/latest/containerization).


## Work safely

<a href="#work-safely" class="heading-anchor" aria-label="Permalink: Work safely" data-copy="" data-copy-text="https://pi.dev/docs/latest#work-safely"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Pi's tools and extensions run with the permissions of the Pi process. Project trust controls which project resources Pi loads, but it does not sandbox tool calls. Review [Security](/docs/latest/security) before using untrusted files, repositories, extensions, or unattended automation.


