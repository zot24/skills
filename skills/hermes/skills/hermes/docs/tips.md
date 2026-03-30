> Source: https://hermes-agent.nousresearch.com/docs/guides/tips/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# Tips & Best Practices


A quick-wins collection of practical tips that make you immediately more effective with Hermes Agent. Each section targets a different aspect — scan the headers and jump to what's relevant.

------------------------------------------------------------------------

## Getting the Best Results<a href="#getting-the-best-results" class="hash-link" aria-label="Direct link to Getting the Best Results" translate="no" title="Direct link to Getting the Best Results">​</a>

### Be Specific About What You Want<a href="#be-specific-about-what-you-want" class="hash-link" aria-label="Direct link to Be Specific About What You Want" translate="no" title="Direct link to Be Specific About What You Want">​</a>

Vague prompts produce vague results. Instead of "fix the code," say "fix the TypeError in `api/handlers.py` on line 47 — the `process_request()` function receives `None` from `parse_body()`." The more context you give, the fewer iterations you need.

### Provide Context Up Front<a href="#provide-context-up-front" class="hash-link" aria-label="Direct link to Provide Context Up Front" translate="no" title="Direct link to Provide Context Up Front">​</a>

Front-load your request with the relevant details: file paths, error messages, expected behavior. One well-crafted message beats three rounds of clarification. Paste error tracebacks directly — the agent can parse them.

### Use Context Files for Recurring Instructions<a href="#use-context-files-for-recurring-instructions" class="hash-link" aria-label="Direct link to Use Context Files for Recurring Instructions" translate="no" title="Direct link to Use Context Files for Recurring Instructions">​</a>

If you find yourself repeating the same instructions ("use tabs not spaces," "we use pytest," "the API is at `/api/v2`"), put them in an `AGENTS.md` file. The agent reads it automatically every session — zero effort after setup.

### Let the Agent Use Its Tools<a href="#let-the-agent-use-its-tools" class="hash-link" aria-label="Direct link to Let the Agent Use Its Tools" translate="no" title="Direct link to Let the Agent Use Its Tools">​</a>

Don't try to hand-hold every step. Say "find and fix the failing test" rather than "open `tests/test_foo.py`, look at line 42, then..." The agent has file search, terminal access, and code execution — let it explore and iterate.

### Use Skills for Complex Workflows<a href="#use-skills-for-complex-workflows" class="hash-link" aria-label="Direct link to Use Skills for Complex Workflows" translate="no" title="Direct link to Use Skills for Complex Workflows">​</a>

Before writing a long prompt explaining how to do something, check if there's already a skill for it. Type `/skills` to browse available skills, or just invoke one directly like `/axolotl` or `/github-pr-workflow`.

## CLI Power User Tips<a href="#cli-power-user-tips" class="hash-link" aria-label="Direct link to CLI Power User Tips" translate="no" title="Direct link to CLI Power User Tips">​</a>

### Multi-Line Input<a href="#multi-line-input" class="hash-link" aria-label="Direct link to Multi-Line Input" translate="no" title="Direct link to Multi-Line Input">​</a>

Press **Alt+Enter** (or **Ctrl+J**) to insert a newline without sending. This lets you compose multi-line prompts, paste code blocks, or structure complex requests before hitting Enter to send.

### Paste Detection<a href="#paste-detection" class="hash-link" aria-label="Direct link to Paste Detection" translate="no" title="Direct link to Paste Detection">​</a>

The CLI auto-detects multi-line pastes. Just paste a code block or error traceback directly — it won't send each line as a separate message. The paste is buffered and sent as one message.

### Interrupt and Redirect<a href="#interrupt-and-redirect" class="hash-link" aria-label="Direct link to Interrupt and Redirect" translate="no" title="Direct link to Interrupt and Redirect">​</a>

Press **Ctrl+C** once to interrupt the agent mid-response. You can then type a new message to redirect it. Double-press Ctrl+C within 2 seconds to force exit. This is invaluable when the agent starts going down the wrong path.

### Resume Sessions with `-c`<a href="#resume-sessions-with--c" class="hash-link" aria-label="Direct link to resume-sessions-with--c" translate="no" title="Direct link to resume-sessions-with--c">​</a>

Forgot something from your last session? Run `hermes -c` to resume exactly where you left off, with full conversation history restored. You can also resume by title: `hermes -r "my research project"`.

### Clipboard Image Paste<a href="#clipboard-image-paste" class="hash-link" aria-label="Direct link to Clipboard Image Paste" translate="no" title="Direct link to Clipboard Image Paste">​</a>

Press **Ctrl+V** to paste an image from your clipboard directly into the chat. The agent uses vision to analyze screenshots, diagrams, error popups, or UI mockups — no need to save to a file first.

### Slash Command Autocomplete<a href="#slash-command-autocomplete" class="hash-link" aria-label="Direct link to Slash Command Autocomplete" translate="no" title="Direct link to Slash Command Autocomplete">​</a>

Type `/` and press **Tab** to see all available commands. This includes built-in commands (`/compress`, `/model`, `/title`) and every installed skill. You don't need to memorize anything — Tab completion has you covered.


Use `/verbose` to cycle through tool output display modes: **off → new → all → verbose**. The "all" mode is great for watching what the agent does; "off" is cleanest for simple Q&A.


## Context Files<a href="#context-files" class="hash-link" aria-label="Direct link to Context Files" translate="no" title="Direct link to Context Files">​</a>

### AGENTS.md: Your Project's Brain<a href="#agentsmd-your-projects-brain" class="hash-link" aria-label="Direct link to AGENTS.md: Your Project&#39;s Brain" translate="no" title="Direct link to AGENTS.md: Your Project&#39;s Brain">​</a>

Create an `AGENTS.md` in your project root with architecture decisions, coding conventions, and project-specific instructions. This is automatically injected into every session, so the agent always knows your project's rules.


``` prism-code
# Project Context
- This is a FastAPI backend with SQLAlchemy ORM
- Always use async/await for database operations
- Tests go in tests/ and use pytest-asyncio
- Never commit .env files
```


### SOUL.md: Customize Personality<a href="#soulmd-customize-personality" class="hash-link" aria-label="Direct link to SOUL.md: Customize Personality" translate="no" title="Direct link to SOUL.md: Customize Personality">​</a>

Want Hermes to have a stable default voice? Edit `~/.hermes/SOUL.md` (or `$HERMES_HOME/SOUL.md` if you use a custom Hermes home). Hermes now seeds a starter SOUL automatically and uses that global file as the instance-wide personality source.

For a full walkthrough, see [Use SOUL.md with Hermes](/docs/guides/use-soul-with-hermes).


``` prism-code
# Soul
You are a senior backend engineer. Be terse and direct.
Skip explanations unless asked. Prefer one-liners over verbose solutions.
Always consider error handling and edge cases.
```


Use `SOUL.md` for durable personality. Use `AGENTS.md` for project-specific instructions.

### .cursorrules Compatibility<a href="#cursorrules-compatibility" class="hash-link" aria-label="Direct link to .cursorrules Compatibility" translate="no" title="Direct link to .cursorrules Compatibility">​</a>

Already have a `.cursorrules` or `.cursor/rules/*.mdc` file? Hermes reads those too. No need to duplicate your coding conventions — they're loaded automatically from the working directory.

### Hierarchical Discovery<a href="#hierarchical-discovery" class="hash-link" aria-label="Direct link to Hierarchical Discovery" translate="no" title="Direct link to Hierarchical Discovery">​</a>

Hermes walks the directory tree and discovers **all** `AGENTS.md` files at every level. In a monorepo, put project-wide conventions at the root and team-specific ones in subdirectories — they're all concatenated together with path headers.


Keep context files focused and concise. Every character counts against your token budget since they're injected into every single message.


## Memory & Skills<a href="#memory--skills" class="hash-link" aria-label="Direct link to Memory &amp; Skills" translate="no" title="Direct link to Memory &amp; Skills">​</a>

### Memory vs. Skills: What Goes Where<a href="#memory-vs-skills-what-goes-where" class="hash-link" aria-label="Direct link to Memory vs. Skills: What Goes Where" translate="no" title="Direct link to Memory vs. Skills: What Goes Where">​</a>

**Memory** is for facts: your environment, preferences, project locations, and things the agent has learned about you. **Skills** are for procedures: multi-step workflows, tool-specific instructions, and reusable recipes. Use memory for "what," skills for "how."

### When to Create Skills<a href="#when-to-create-skills" class="hash-link" aria-label="Direct link to When to Create Skills" translate="no" title="Direct link to When to Create Skills">​</a>

If you find a task that takes 5+ steps and you'll do it again, ask the agent to create a skill for it. Say "save what you just did as a skill called `deploy-staging`." Next time, just type `/deploy-staging` and the agent loads the full procedure.

### Managing Memory Capacity<a href="#managing-memory-capacity" class="hash-link" aria-label="Direct link to Managing Memory Capacity" translate="no" title="Direct link to Managing Memory Capacity">​</a>

Memory is intentionally bounded (~2,200 chars for MEMORY.md, ~1,375 chars for USER.md). When it fills up, the agent consolidates entries. You can help by saying "clean up your memory" or "replace the old Python 3.9 note — we're on 3.12 now."

### Let the Agent Remember<a href="#let-the-agent-remember" class="hash-link" aria-label="Direct link to Let the Agent Remember" translate="no" title="Direct link to Let the Agent Remember">​</a>

After a productive session, say "remember this for next time" and the agent will save the key takeaways. You can also be specific: "save to memory that our CI uses GitHub Actions with the `deploy.yml` workflow."


Memory is a frozen snapshot — changes made during a session don't appear in the system prompt until the next session starts. The agent writes to disk immediately, but the prompt cache isn't invalidated mid-session.


## Performance & Cost<a href="#performance--cost" class="hash-link" aria-label="Direct link to Performance &amp; Cost" translate="no" title="Direct link to Performance &amp; Cost">​</a>

### Don't Break the Prompt Cache<a href="#dont-break-the-prompt-cache" class="hash-link" aria-label="Direct link to Don&#39;t Break the Prompt Cache" translate="no" title="Direct link to Don&#39;t Break the Prompt Cache">​</a>

Most LLM providers cache the system prompt prefix. If you keep your system prompt stable (same context files, same memory), subsequent messages in a session get **cache hits** that are significantly cheaper. Avoid changing the model or system prompt mid-session.

### Use /compress Before Hitting Limits<a href="#use-compress-before-hitting-limits" class="hash-link" aria-label="Direct link to Use /compress Before Hitting Limits" translate="no" title="Direct link to Use /compress Before Hitting Limits">​</a>

Long sessions accumulate tokens. When you notice responses slowing down or getting truncated, run `/compress`. This summarizes the conversation history, preserving key context while dramatically reducing token count. Use `/usage` to check where you stand.

### Delegate for Parallel Work<a href="#delegate-for-parallel-work" class="hash-link" aria-label="Direct link to Delegate for Parallel Work" translate="no" title="Direct link to Delegate for Parallel Work">​</a>

Need to research three topics at once? Ask the agent to use `delegate_task` with parallel subtasks. Each subagent runs independently with its own context, and only the final summaries come back — massively reducing your main conversation's token usage.

### Use execute_code for Batch Operations<a href="#use-execute_code-for-batch-operations" class="hash-link" aria-label="Direct link to Use execute_code for Batch Operations" translate="no" title="Direct link to Use execute_code for Batch Operations">​</a>

Instead of running terminal commands one at a time, ask the agent to write a script that does everything at once. "Write a Python script to rename all `.jpeg` files to `.jpg` and run it" is cheaper and faster than renaming files individually.

### Choose the Right Model<a href="#choose-the-right-model" class="hash-link" aria-label="Direct link to Choose the Right Model" translate="no" title="Direct link to Choose the Right Model">​</a>

Use `/model` to switch models mid-session. Use a frontier model (Claude Sonnet/Opus, GPT-4o) for complex reasoning and architecture decisions. Switch to a faster model for simple tasks like formatting, renaming, or boilerplate generation.


Run `/usage` periodically to see your token consumption. Run `/insights` for a broader view of usage patterns over the last 30 days.


## Messaging Tips<a href="#messaging-tips" class="hash-link" aria-label="Direct link to Messaging Tips" translate="no" title="Direct link to Messaging Tips">​</a>

### Set a Home Channel<a href="#set-a-home-channel" class="hash-link" aria-label="Direct link to Set a Home Channel" translate="no" title="Direct link to Set a Home Channel">​</a>

Use `/sethome` in your preferred Telegram or Discord chat to designate it as the home channel. Cron job results and scheduled task outputs are delivered here. Without it, the agent has nowhere to send proactive messages.

### Use /title to Organize Sessions<a href="#use-title-to-organize-sessions" class="hash-link" aria-label="Direct link to Use /title to Organize Sessions" translate="no" title="Direct link to Use /title to Organize Sessions">​</a>

Name your sessions with `/title auth-refactor` or `/title research-llm-quantization`. Named sessions are easy to find with `hermes sessions list` and resume with `hermes -r "auth-refactor"`. Unnamed sessions pile up and become impossible to distinguish.

### DM Pairing for Team Access<a href="#dm-pairing-for-team-access" class="hash-link" aria-label="Direct link to DM Pairing for Team Access" translate="no" title="Direct link to DM Pairing for Team Access">​</a>

Instead of manually collecting user IDs for allowlists, enable DM pairing. When a teammate DMs the bot, they get a one-time pairing code. You approve it with `hermes pairing approve telegram XKGH5N7P` — simple and secure.

### Tool Progress Display Modes<a href="#tool-progress-display-modes" class="hash-link" aria-label="Direct link to Tool Progress Display Modes" translate="no" title="Direct link to Tool Progress Display Modes">​</a>

Use `/verbose` to control how much tool activity you see. In messaging platforms, less is usually more — keep it on "new" to see just new tool calls. In the CLI, "all" gives you a satisfying live view of everything the agent does.


On messaging platforms, sessions auto-reset after idle time (default: 24 hours) or daily at 4 AM. Adjust per-platform in `~/.hermes/config.yaml` if you need longer sessions.


## Security<a href="#security" class="hash-link" aria-label="Direct link to Security" translate="no" title="Direct link to Security">​</a>

### Use Docker for Untrusted Code<a href="#use-docker-for-untrusted-code" class="hash-link" aria-label="Direct link to Use Docker for Untrusted Code" translate="no" title="Direct link to Use Docker for Untrusted Code">​</a>

When working with untrusted repositories or running unfamiliar code, use Docker or Daytona as your terminal backend. Set `TERMINAL_BACKEND=docker` in your `.env`. Destructive commands inside a container can't harm your host system.


``` prism-code
# In your .env:
TERMINAL_BACKEND=docker
TERMINAL_DOCKER_IMAGE=hermes-sandbox:latest
```


### Avoid Windows Encoding Pitfalls<a href="#avoid-windows-encoding-pitfalls" class="hash-link" aria-label="Direct link to Avoid Windows Encoding Pitfalls" translate="no" title="Direct link to Avoid Windows Encoding Pitfalls">​</a>

On Windows, some default encodings (such as `cp125x`) cannot represent all Unicode characters, which can cause `UnicodeEncodeError` when writing files in tests or scripts.

- Prefer opening files with an explicit UTF-8 encoding:


``` prism-code
with open("results.txt", "w", encoding="utf-8") as f:
    f.write("✓ All good\n")
```


- In PowerShell, you can also switch the current session to UTF-8 for console and native command output:


``` prism-code
$OutputEncoding = [Console]::OutputEncoding = [Text.UTF8Encoding]::new($false)
```


This keeps PowerShell and child processes on UTF-8 and helps avoid Windows-only failures.

### Review Before Choosing "Always"<a href="#review-before-choosing-always" class="hash-link" aria-label="Direct link to Review Before Choosing &quot;Always&quot;" translate="no" title="Direct link to Review Before Choosing &quot;Always&quot;">​</a>

When the agent triggers a dangerous command approval (`rm -rf`, `DROP TABLE`, etc.), you get four options: **once**, **session**, **always**, **deny**. Think carefully before choosing "always" — it permanently allowlists that pattern. Start with "session" until you're comfortable.

### Command Approval Is Your Safety Net<a href="#command-approval-is-your-safety-net" class="hash-link" aria-label="Direct link to Command Approval Is Your Safety Net" translate="no" title="Direct link to Command Approval Is Your Safety Net">​</a>

Hermes checks every command against a curated list of dangerous patterns before execution. This includes recursive deletes, SQL drops, piping curl to shell, and more. Don't disable this in production — it exists for good reasons.


When running in a container backend (Docker, Singularity, Modal, Daytona), dangerous command checks are **skipped** because the container is the security boundary. Make sure your container images are properly locked down.


### Use Allowlists for Messaging Bots<a href="#use-allowlists-for-messaging-bots" class="hash-link" aria-label="Direct link to Use Allowlists for Messaging Bots" translate="no" title="Direct link to Use Allowlists for Messaging Bots">​</a>

Never set `GATEWAY_ALLOW_ALL_USERS=true` on a bot with terminal access. Always use platform-specific allowlists (`TELEGRAM_ALLOWED_USERS`, `DISCORD_ALLOWED_USERS`) or DM pairing to control who can interact with your agent.


``` prism-code
# Recommended: explicit allowlists per platform
TELEGRAM_ALLOWED_USERS=123456789,987654321
DISCORD_ALLOWED_USERS=123456789012345678

# Or use cross-platform allowlist
GATEWAY_ALLOWED_USERS=123456789,987654321
```


------------------------------------------------------------------------

*Have a tip that should be on this page? Open an issue or PR — community contributions are welcome.*


- <a href="#getting-the-best-results" class="table-of-contents__link toc-highlight">Getting the Best Results</a>
  - <a href="#be-specific-about-what-you-want" class="table-of-contents__link toc-highlight">Be Specific About What You Want</a>
  - <a href="#provide-context-up-front" class="table-of-contents__link toc-highlight">Provide Context Up Front</a>
  - <a href="#use-context-files-for-recurring-instructions" class="table-of-contents__link toc-highlight">Use Context Files for Recurring Instructions</a>
  - <a href="#let-the-agent-use-its-tools" class="table-of-contents__link toc-highlight">Let the Agent Use Its Tools</a>
  - <a href="#use-skills-for-complex-workflows" class="table-of-contents__link toc-highlight">Use Skills for Complex Workflows</a>
- <a href="#cli-power-user-tips" class="table-of-contents__link toc-highlight">CLI Power User Tips</a>
  - <a href="#multi-line-input" class="table-of-contents__link toc-highlight">Multi-Line Input</a>
  - <a href="#paste-detection" class="table-of-contents__link toc-highlight">Paste Detection</a>
  - <a href="#interrupt-and-redirect" class="table-of-contents__link toc-highlight">Interrupt and Redirect</a>
  - <a href="#resume-sessions-with--c" class="table-of-contents__link toc-highlight">Resume Sessions with <code>-c</code></a>
  - <a href="#clipboard-image-paste" class="table-of-contents__link toc-highlight">Clipboard Image Paste</a>
  - <a href="#slash-command-autocomplete" class="table-of-contents__link toc-highlight">Slash Command Autocomplete</a>
- <a href="#context-files" class="table-of-contents__link toc-highlight">Context Files</a>
  - <a href="#agentsmd-your-projects-brain" class="table-of-contents__link toc-highlight">AGENTS.md: Your Project's Brain</a>
  - <a href="#soulmd-customize-personality" class="table-of-contents__link toc-highlight">SOUL.md: Customize Personality</a>
  - <a href="#cursorrules-compatibility" class="table-of-contents__link toc-highlight">.cursorrules Compatibility</a>
  - <a href="#hierarchical-discovery" class="table-of-contents__link toc-highlight">Hierarchical Discovery</a>
- <a href="#memory--skills" class="table-of-contents__link toc-highlight">Memory &amp; Skills</a>
  - <a href="#memory-vs-skills-what-goes-where" class="table-of-contents__link toc-highlight">Memory vs. Skills: What Goes Where</a>
  - <a href="#when-to-create-skills" class="table-of-contents__link toc-highlight">When to Create Skills</a>
  - <a href="#managing-memory-capacity" class="table-of-contents__link toc-highlight">Managing Memory Capacity</a>
  - <a href="#let-the-agent-remember" class="table-of-contents__link toc-highlight">Let the Agent Remember</a>
- <a href="#performance--cost" class="table-of-contents__link toc-highlight">Performance &amp; Cost</a>
  - <a href="#dont-break-the-prompt-cache" class="table-of-contents__link toc-highlight">Don't Break the Prompt Cache</a>
  - <a href="#use-compress-before-hitting-limits" class="table-of-contents__link toc-highlight">Use /compress Before Hitting Limits</a>
  - <a href="#delegate-for-parallel-work" class="table-of-contents__link toc-highlight">Delegate for Parallel Work</a>
  - <a href="#use-execute_code-for-batch-operations" class="table-of-contents__link toc-highlight">Use execute_code for Batch Operations</a>
  - <a href="#choose-the-right-model" class="table-of-contents__link toc-highlight">Choose the Right Model</a>
- <a href="#messaging-tips" class="table-of-contents__link toc-highlight">Messaging Tips</a>
  - <a href="#set-a-home-channel" class="table-of-contents__link toc-highlight">Set a Home Channel</a>
  - <a href="#use-title-to-organize-sessions" class="table-of-contents__link toc-highlight">Use /title to Organize Sessions</a>
  - <a href="#dm-pairing-for-team-access" class="table-of-contents__link toc-highlight">DM Pairing for Team Access</a>
  - <a href="#tool-progress-display-modes" class="table-of-contents__link toc-highlight">Tool Progress Display Modes</a>
- <a href="#security" class="table-of-contents__link toc-highlight">Security</a>
  - <a href="#use-docker-for-untrusted-code" class="table-of-contents__link toc-highlight">Use Docker for Untrusted Code</a>
  - <a href="#avoid-windows-encoding-pitfalls" class="table-of-contents__link toc-highlight">Avoid Windows Encoding Pitfalls</a>
  - <a href="#review-before-choosing-always" class="table-of-contents__link toc-highlight">Review Before Choosing "Always"</a>
  - <a href="#command-approval-is-your-safety-net" class="table-of-contents__link toc-highlight">Command Approval Is Your Safety Net</a>
  - <a href="#use-allowlists-for-messaging-bots" class="table-of-contents__link toc-highlight">Use Allowlists for Messaging Bots</a>


