> Source: https://hermes-agent.nousresearch.com/docs/getting-started/learning-path/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# Learning Path


Hermes Agent can do a lot — CLI assistant, Telegram/Discord bot, task automation, RL training, and more. This page helps you figure out where to start and what to read based on your experience level and what you're trying to accomplish.


If you haven't installed Hermes Agent yet, begin with the [Installation guide](/docs/getting-started/installation) and then run through the [Quickstart](/docs/getting-started/quickstart). Everything below assumes you have a working installation.


## How to Use This Page<a href="#how-to-use-this-page" class="hash-link" aria-label="Direct link to How to Use This Page" translate="no" title="Direct link to How to Use This Page">​</a>

- **Know your level?** Jump to the [experience-level table](#by-experience-level) and follow the reading order for your tier.
- **Have a specific goal?** Skip to [By Use Case](#by-use-case) and find the scenario that matches.
- **Just browsing?** Check the [Key Features](#key-features-at-a-glance) table for a quick overview of everything Hermes Agent can do.

## By Experience Level<a href="#by-experience-level" class="hash-link" aria-label="Direct link to By Experience Level" translate="no" title="Direct link to By Experience Level">​</a>

| Level            | Goal                                                                               | Recommended Reading                                                                                                                                                                                                                                                            | Time Estimate |
|------------------|------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------|
| **Beginner**     | Get up and running, have basic conversations, use built-in tools                   | [Installation](/docs/getting-started/installation) → [Quickstart](/docs/getting-started/quickstart) → [CLI Usage](/docs/user-guide/cli) → [Configuration](/docs/user-guide/configuration)                                                                                      | ~1 hour       |
| **Intermediate** | Set up messaging bots, use advanced features like memory, cron jobs, and skills    | [Sessions](/docs/user-guide/sessions) → [Messaging](/docs/user-guide/messaging) → [Tools](/docs/user-guide/features/tools) → [Skills](/docs/user-guide/features/skills) → [Memory](/docs/user-guide/features/memory) → [Cron](/docs/user-guide/features/cron)                  | ~2–3 hours    |
| **Advanced**     | Build custom tools, create skills, train models with RL, contribute to the project | [Architecture](/docs/developer-guide/architecture) → [Adding Tools](/docs/developer-guide/adding-tools) → [Creating Skills](/docs/developer-guide/creating-skills) → [RL Training](/docs/user-guide/features/rl-training) → [Contributing](/docs/developer-guide/contributing) | ~4–6 hours    |

## By Use Case<a href="#by-use-case" class="hash-link" aria-label="Direct link to By Use Case" translate="no" title="Direct link to By Use Case">​</a>

Pick the scenario that matches what you want to do. Each one links you to the relevant docs in the order you should read them.

### "I want a CLI coding assistant"<a href="#i-want-a-cli-coding-assistant" class="hash-link" aria-label="Direct link to &quot;I want a CLI coding assistant&quot;" translate="no" title="Direct link to &quot;I want a CLI coding assistant&quot;">​</a>

Use Hermes Agent as an interactive terminal assistant for writing, reviewing, and running code.

1.  [Installation](/docs/getting-started/installation)
2.  [Quickstart](/docs/getting-started/quickstart)
3.  [CLI Usage](/docs/user-guide/cli)
4.  [Code Execution](/docs/user-guide/features/code-execution)
5.  [Context Files](/docs/user-guide/features/context-files)
6.  [Tips & Tricks](/docs/guides/tips)


Pass files directly into your conversation with context files. Hermes Agent can read, edit, and run code in your projects.


### "I want a Telegram/Discord bot"<a href="#i-want-a-telegramdiscord-bot" class="hash-link" aria-label="Direct link to &quot;I want a Telegram/Discord bot&quot;" translate="no" title="Direct link to &quot;I want a Telegram/Discord bot&quot;">​</a>

Deploy Hermes Agent as a bot on your favorite messaging platform.

1.  [Installation](/docs/getting-started/installation)
2.  [Configuration](/docs/user-guide/configuration)
3.  [Messaging Overview](/docs/user-guide/messaging)
4.  [Telegram Setup](/docs/user-guide/messaging/telegram)
5.  [Discord Setup](/docs/user-guide/messaging/discord)
6.  [Voice Mode](/docs/user-guide/features/voice-mode)
7.  [Use Voice Mode with Hermes](/docs/guides/use-voice-mode-with-hermes)
8.  [Security](/docs/user-guide/security)

For full project examples, see:

- [Daily Briefing Bot](/docs/guides/daily-briefing-bot)
- [Team Telegram Assistant](/docs/guides/team-telegram-assistant)

### "I want to automate tasks"<a href="#i-want-to-automate-tasks" class="hash-link" aria-label="Direct link to &quot;I want to automate tasks&quot;" translate="no" title="Direct link to &quot;I want to automate tasks&quot;">​</a>

Schedule recurring tasks, run batch jobs, or chain agent actions together.

1.  [Quickstart](/docs/getting-started/quickstart)
2.  [Cron Scheduling](/docs/user-guide/features/cron)
3.  [Batch Processing](/docs/user-guide/features/batch-processing)
4.  [Delegation](/docs/user-guide/features/delegation)
5.  [Hooks](/docs/user-guide/features/hooks)


Cron jobs let Hermes Agent run tasks on a schedule — daily summaries, periodic checks, automated reports — without you being present.


### "I want to build custom tools/skills"<a href="#i-want-to-build-custom-toolsskills" class="hash-link" aria-label="Direct link to &quot;I want to build custom tools/skills&quot;" translate="no" title="Direct link to &quot;I want to build custom tools/skills&quot;">​</a>

Extend Hermes Agent with your own tools and reusable skill packages.

1.  [Tools Overview](/docs/user-guide/features/tools)
2.  [Skills Overview](/docs/user-guide/features/skills)
3.  [MCP (Model Context Protocol)](/docs/user-guide/features/mcp)
4.  [Architecture](/docs/developer-guide/architecture)
5.  [Adding Tools](/docs/developer-guide/adding-tools)
6.  [Creating Skills](/docs/developer-guide/creating-skills)


Tools are individual functions the agent can call. Skills are bundles of tools, prompts, and configuration packaged together. Start with tools, graduate to skills.


### "I want to train models"<a href="#i-want-to-train-models" class="hash-link" aria-label="Direct link to &quot;I want to train models&quot;" translate="no" title="Direct link to &quot;I want to train models&quot;">​</a>

Use reinforcement learning to fine-tune model behavior with Hermes Agent's built-in RL training pipeline.

1.  [Quickstart](/docs/getting-started/quickstart)
2.  [Configuration](/docs/user-guide/configuration)
3.  [RL Training](/docs/user-guide/features/rl-training)
4.  [Provider Routing](/docs/user-guide/features/provider-routing)
5.  [Architecture](/docs/developer-guide/architecture)


RL training works best when you already understand the basics of how Hermes Agent handles conversations and tool calls. Run through the Beginner path first if you're new.


### "I want to use it as a Python library"<a href="#i-want-to-use-it-as-a-python-library" class="hash-link" aria-label="Direct link to &quot;I want to use it as a Python library&quot;" translate="no" title="Direct link to &quot;I want to use it as a Python library&quot;">​</a>

Integrate Hermes Agent into your own Python applications programmatically.

1.  [Installation](/docs/getting-started/installation)
2.  [Quickstart](/docs/getting-started/quickstart)
3.  [Python Library Guide](/docs/guides/python-library)
4.  [Architecture](/docs/developer-guide/architecture)
5.  [Tools](/docs/user-guide/features/tools)
6.  [Sessions](/docs/user-guide/sessions)

## Key Features at a Glance<a href="#key-features-at-a-glance" class="hash-link" aria-label="Direct link to Key Features at a Glance" translate="no" title="Direct link to Key Features at a Glance">​</a>

Not sure what's available? Here's a quick directory of major features:

| Feature              | What It Does                                                      | Link                                                           |
|----------------------|-------------------------------------------------------------------|----------------------------------------------------------------|
| **Tools**            | Built-in tools the agent can call (file I/O, search, shell, etc.) | [Tools](/docs/user-guide/features/tools)                       |
| **Skills**           | Installable plugin packages that add new capabilities             | [Skills](/docs/user-guide/features/skills)                     |
| **Memory**           | Persistent memory across sessions                                 | [Memory](/docs/user-guide/features/memory)                     |
| **Context Files**    | Feed files and directories into conversations                     | [Context Files](/docs/user-guide/features/context-files)       |
| **MCP**              | Connect to external tool servers via Model Context Protocol       | [MCP](/docs/user-guide/features/mcp)                           |
| **Cron**             | Schedule recurring agent tasks                                    | [Cron](/docs/user-guide/features/cron)                         |
| **Delegation**       | Spawn sub-agents for parallel work                                | [Delegation](/docs/user-guide/features/delegation)             |
| **Code Execution**   | Run code in sandboxed environments                                | [Code Execution](/docs/user-guide/features/code-execution)     |
| **Browser**          | Web browsing and scraping                                         | [Browser](/docs/user-guide/features/browser)                   |
| **Hooks**            | Event-driven callbacks and middleware                             | [Hooks](/docs/user-guide/features/hooks)                       |
| **Batch Processing** | Process multiple inputs in bulk                                   | [Batch Processing](/docs/user-guide/features/batch-processing) |
| **RL Training**      | Fine-tune models with reinforcement learning                      | [RL Training](/docs/user-guide/features/rl-training)           |
| **Provider Routing** | Route requests across multiple LLM providers                      | [Provider Routing](/docs/user-guide/features/provider-routing) |

## What to Read Next<a href="#what-to-read-next" class="hash-link" aria-label="Direct link to What to Read Next" translate="no" title="Direct link to What to Read Next">​</a>

Based on where you are right now:

- **Just finished installing?** → Head to the [Quickstart](/docs/getting-started/quickstart) to run your first conversation.
- **Completed the Quickstart?** → Read [CLI Usage](/docs/user-guide/cli) and [Configuration](/docs/user-guide/configuration) to customize your setup.
- **Comfortable with the basics?** → Explore [Tools](/docs/user-guide/features/tools), [Skills](/docs/user-guide/features/skills), and [Memory](/docs/user-guide/features/memory) to unlock the full power of the agent.
- **Setting up for a team?** → Read [Security](/docs/user-guide/security) and [Sessions](/docs/user-guide/sessions) to understand access control and conversation management.
- **Ready to build?** → Jump into the [Developer Guide](/docs/developer-guide/architecture) to understand the internals and start contributing.
- **Want practical examples?** → Check out the [Guides](/docs/guides/tips) section for real-world projects and tips.


You don't need to read everything. Pick the path that matches your goal, follow the links in order, and you'll be productive quickly. You can always come back to this page to find your next step.


- <a href="#how-to-use-this-page" class="table-of-contents__link toc-highlight">How to Use This Page</a>
- <a href="#by-experience-level" class="table-of-contents__link toc-highlight">By Experience Level</a>
- <a href="#by-use-case" class="table-of-contents__link toc-highlight">By Use Case</a>
  - <a href="#i-want-a-cli-coding-assistant" class="table-of-contents__link toc-highlight">"I want a CLI coding assistant"</a>
  - <a href="#i-want-a-telegramdiscord-bot" class="table-of-contents__link toc-highlight">"I want a Telegram/Discord bot"</a>
  - <a href="#i-want-to-automate-tasks" class="table-of-contents__link toc-highlight">"I want to automate tasks"</a>
  - <a href="#i-want-to-build-custom-toolsskills" class="table-of-contents__link toc-highlight">"I want to build custom tools/skills"</a>
  - <a href="#i-want-to-train-models" class="table-of-contents__link toc-highlight">"I want to train models"</a>
  - <a href="#i-want-to-use-it-as-a-python-library" class="table-of-contents__link toc-highlight">"I want to use it as a Python library"</a>
- <a href="#key-features-at-a-glance" class="table-of-contents__link toc-highlight">Key Features at a Glance</a>
- <a href="#what-to-read-next" class="table-of-contents__link toc-highlight">What to Read Next</a>


