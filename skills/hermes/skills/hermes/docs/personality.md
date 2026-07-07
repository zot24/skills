> Source: https://hermes-agent.nousresearch.com/docs/user-guide/features/personality/



On this page


# Personality & SOUL.md


Hermes Agent's personality is fully customizable. `SOUL.md` is the **primary identity** — it's the first thing in the system prompt and defines who the agent is.

- `SOUL.md` — a durable persona file that lives in `HERMES_HOME` and serves as the agent's identity (slot \#1 in the system prompt)
- built-in or custom `/personality` presets — session-level system-prompt overlays

If you want to change who Hermes is — or replace it with an entirely different agent persona — edit `SOUL.md`.

## How SOUL.md works now<a href="#how-soulmd-works-now" class="hash-link" aria-label="Direct link to How SOUL.md works now" translate="no" title="Direct link to How SOUL.md works now">​</a>

Hermes now seeds a default `SOUL.md` automatically in:


``` text
~/.hermes/SOUL.md
```


More precisely, it uses the current instance's `HERMES_HOME`, so if you run Hermes with a custom home directory, it will use:


``` text
$HERMES_HOME/SOUL.md
```


### Important behavior<a href="#important-behavior" class="hash-link" aria-label="Direct link to Important behavior" translate="no" title="Direct link to Important behavior">​</a>

- **SOUL.md is the agent's primary identity.** It occupies slot \#1 in the system prompt, replacing the hardcoded default identity.
- Hermes creates a starter `SOUL.md` automatically if one does not exist yet
- Existing user `SOUL.md` files are never overwritten
- Hermes loads `SOUL.md` only from `HERMES_HOME`
- Hermes does not look in the current working directory for `SOUL.md`
- If `SOUL.md` exists but is empty, or cannot be loaded, Hermes falls back to a built-in default identity
- If `SOUL.md` has content, that content is injected verbatim after security scanning and truncation
- SOUL.md is **not** duplicated in the context files section — it appears only once, as the identity

That makes `SOUL.md` a true per-user or per-instance identity, not just an additive layer.

## Why this design<a href="#why-this-design" class="hash-link" aria-label="Direct link to Why this design" translate="no" title="Direct link to Why this design">​</a>

This keeps personality predictable.

If Hermes loaded `SOUL.md` from whatever directory you happened to launch it in, your personality could change unexpectedly between projects. By loading only from `HERMES_HOME`, the personality belongs to the Hermes instance itself.

That also makes it easier to teach users:

- "Edit `~/.hermes/SOUL.md` to change Hermes' default personality."

## Where to edit it<a href="#where-to-edit-it" class="hash-link" aria-label="Direct link to Where to edit it" translate="no" title="Direct link to Where to edit it">​</a>

For most users:


``` bash
~/.hermes/SOUL.md
```


If you use a custom home:


``` bash
$HERMES_HOME/SOUL.md
```


## What should go in SOUL.md?<a href="#what-should-go-in-soulmd" class="hash-link" aria-label="Direct link to What should go in SOUL.md?" translate="no" title="Direct link to What should go in SOUL.md?">​</a>

Use it for durable voice and personality guidance, such as:

- tone
- communication style
- level of directness
- default interaction style
- what to avoid stylistically
- how Hermes should handle uncertainty, disagreement, or ambiguity

Use it less for:

- one-off project instructions
- file paths
- repo conventions
- temporary workflow details

Those belong in `AGENTS.md`, not `SOUL.md`.

## Good SOUL.md content<a href="#good-soulmd-content" class="hash-link" aria-label="Direct link to Good SOUL.md content" translate="no" title="Direct link to Good SOUL.md content">​</a>

A good SOUL file is:

- stable across contexts
- broad enough to apply in many conversations
- specific enough to materially shape the voice
- focused on communication and identity, not task-specific instructions

### Example<a href="#example" class="hash-link" aria-label="Direct link to Example" translate="no" title="Direct link to Example">​</a>


``` markdown
# Personality

You are a pragmatic senior engineer with strong taste.
You optimize for truth, clarity, and usefulness over politeness theater.

## Style
- Be direct without being cold
- Prefer substance over filler
- Push back when something is a bad idea
- Admit uncertainty plainly
- Keep explanations compact unless depth is useful

## What to avoid
- Sycophancy
- Hype language
- Repeating the user's framing if it's wrong
- Overexplaining obvious things

## Technical posture
- Prefer simple systems over clever systems
- Care about operational reality, not idealized architecture
- Treat edge cases as part of the design, not cleanup
```


## What Hermes injects into the prompt<a href="#what-hermes-injects-into-the-prompt" class="hash-link" aria-label="Direct link to What Hermes injects into the prompt" translate="no" title="Direct link to What Hermes injects into the prompt">​</a>

`SOUL.md` content goes directly into slot \#1 of the system prompt — the agent identity position. No wrapper language is added around it.

The content goes through:

- prompt-injection scanning
- truncation if it is too large

If the file is empty, whitespace-only, or cannot be read, Hermes falls back to a built-in default identity ("You are Hermes Agent, an intelligent AI assistant created by Nous Research..."). This fallback also applies when `skip_context_files` is set (e.g., in subagent/delegation contexts).

## Security scanning<a href="#security-scanning" class="hash-link" aria-label="Direct link to Security scanning" translate="no" title="Direct link to Security scanning">​</a>

`SOUL.md` is scanned like other context-bearing files for prompt injection patterns before inclusion.

That means you should still keep it focused on persona/voice rather than trying to sneak in strange meta-instructions.

## SOUL.md vs AGENTS.md<a href="#soulmd-vs-agentsmd" class="hash-link" aria-label="Direct link to SOUL.md vs AGENTS.md" translate="no" title="Direct link to SOUL.md vs AGENTS.md">​</a>

This is the most important distinction.

### SOUL.md<a href="#soulmd" class="hash-link" aria-label="Direct link to SOUL.md" translate="no" title="Direct link to SOUL.md">​</a>

Use for:

- identity
- tone
- style
- communication defaults
- personality-level behavior

### AGENTS.md<a href="#agentsmd" class="hash-link" aria-label="Direct link to AGENTS.md" translate="no" title="Direct link to AGENTS.md">​</a>

Use for:

- project architecture
- coding conventions
- tool preferences
- repo-specific workflows
- commands, ports, paths, deployment notes

A useful rule:

- if it should follow you everywhere, it belongs in `SOUL.md`
- if it belongs to a project, it belongs in `AGENTS.md`

## SOUL.md vs `/personality`<a href="#soulmd-vs-personality" class="hash-link" aria-label="Direct link to soulmd-vs-personality" translate="no" title="Direct link to soulmd-vs-personality">​</a>

`SOUL.md` is your durable default personality.

`/personality` is a session-level overlay that changes or supplements the current system prompt.

So:

- `SOUL.md` = baseline voice
- `/personality` = temporary mode switch

Examples:

- keep a pragmatic default SOUL, then use `/personality teacher` for a tutoring conversation
- keep a concise SOUL, then use `/personality creative` for brainstorming

## Built-in personalities<a href="#built-in-personalities" class="hash-link" aria-label="Direct link to Built-in personalities" translate="no" title="Direct link to Built-in personalities">​</a>

Hermes ships with built-in personalities you can switch to with `/personality`.

| Name            | Description                                  |
|-----------------|----------------------------------------------|
| **helpful**     | Friendly, general-purpose assistant          |
| **concise**     | Brief, to-the-point responses                |
| **technical**   | Detailed, accurate technical expert          |
| **creative**    | Innovative, outside-the-box thinking         |
| **teacher**     | Patient educator with clear examples         |
| **kawaii**      | Cute expressions, sparkles, and enthusiasm ★ |
| **catgirl**     | Neko-chan with cat-like expressions, nya~    |
| **pirate**      | Captain Hermes, tech-savvy buccaneer         |
| **shakespeare** | Bardic prose with dramatic flair             |
| **surfer**      | Totally chill bro vibes                      |
| **noir**        | Hard-boiled detective narration              |
| **uwu**         | Maximum cute with uwu-speak                  |
| **philosopher** | Deep contemplation on every query            |
| **hype**        | MAXIMUM ENERGY AND ENTHUSIASM!!!             |

## Switching personalities with commands<a href="#switching-personalities-with-commands" class="hash-link" aria-label="Direct link to Switching personalities with commands" translate="no" title="Direct link to Switching personalities with commands">​</a>

### CLI<a href="#cli" class="hash-link" aria-label="Direct link to CLI" translate="no" title="Direct link to CLI">​</a>


``` text
/personality
/personality concise
/personality technical
```


### Messaging platforms<a href="#messaging-platforms" class="hash-link" aria-label="Direct link to Messaging platforms" translate="no" title="Direct link to Messaging platforms">​</a>


``` text
/personality teacher
```


These are convenient overlays, but your global `SOUL.md` still gives Hermes its persistent default personality unless the overlay meaningfully changes it.

## Custom personalities in config<a href="#custom-personalities-in-config" class="hash-link" aria-label="Direct link to Custom personalities in config" translate="no" title="Direct link to Custom personalities in config">​</a>

You can also define named custom personalities in `~/.hermes/config.yaml` under `agent.personalities`.


``` yaml
agent:
  personalities:
    codereviewer: >
      You are a meticulous code reviewer. Identify bugs, security issues,
      performance concerns, and unclear design choices. Be precise and constructive.
```


Then switch to it with:


``` text
/personality codereviewer
```


## Recommended workflow<a href="#recommended-workflow" class="hash-link" aria-label="Direct link to Recommended workflow" translate="no" title="Direct link to Recommended workflow">​</a>

A strong default setup is:

1.  Keep a thoughtful global `SOUL.md` in `~/.hermes/SOUL.md`
2.  Put project instructions in `AGENTS.md`
3.  Use `/personality` only when you want a temporary mode shift

That gives you:

- a stable voice
- project-specific behavior where it belongs
- temporary control when needed

## How personality interacts with the full prompt<a href="#how-personality-interacts-with-the-full-prompt" class="hash-link" aria-label="Direct link to How personality interacts with the full prompt" translate="no" title="Direct link to How personality interacts with the full prompt">​</a>

At a high level, the prompt stack includes:

1.  **SOUL.md** (agent identity — or built-in fallback if SOUL.md is unavailable)
2.  tool-aware behavior guidance
3.  memory/user context
4.  skills guidance
5.  context files (`AGENTS.md`, `.cursorrules`)
6.  timestamp
7.  platform-specific formatting hints
8.  optional system-prompt overlays such as `/personality`

`SOUL.md` is the foundation — everything else builds on top of it.

## Related docs<a href="#related-docs" class="hash-link" aria-label="Direct link to Related docs" translate="no" title="Direct link to Related docs">​</a>

- [Context Files](/docs/user-guide/features/context-files)
- [Configuration](/docs/user-guide/configuration)
- [Tips & Best Practices](/docs/guides/tips)
- [SOUL.md Guide](/docs/guides/use-soul-with-hermes)

## CLI appearance vs conversational personality<a href="#cli-appearance-vs-conversational-personality" class="hash-link" aria-label="Direct link to CLI appearance vs conversational personality" translate="no" title="Direct link to CLI appearance vs conversational personality">​</a>

Conversational personality and CLI appearance are separate:

- `SOUL.md`, `agent.system_prompt`, and `/personality` affect how Hermes speaks
- `display.skin` and `/skin` affect how Hermes looks in the terminal

For terminal appearance, see [Skins & Themes](/docs/user-guide/features/skins).


- <a href="#how-soulmd-works-now" class="table-of-contents__link toc-highlight">How SOUL.md works now</a>
  - <a href="#important-behavior" class="table-of-contents__link toc-highlight">Important behavior</a>
- <a href="#why-this-design" class="table-of-contents__link toc-highlight">Why this design</a>
- <a href="#where-to-edit-it" class="table-of-contents__link toc-highlight">Where to edit it</a>
- <a href="#what-should-go-in-soulmd" class="table-of-contents__link toc-highlight">What should go in SOUL.md?</a>
- <a href="#good-soulmd-content" class="table-of-contents__link toc-highlight">Good SOUL.md content</a>
  - <a href="#example" class="table-of-contents__link toc-highlight">Example</a>
- <a href="#what-hermes-injects-into-the-prompt" class="table-of-contents__link toc-highlight">What Hermes injects into the prompt</a>
- <a href="#security-scanning" class="table-of-contents__link toc-highlight">Security scanning</a>
- <a href="#soulmd-vs-agentsmd" class="table-of-contents__link toc-highlight">SOUL.md vs AGENTS.md</a>
  - <a href="#soulmd" class="table-of-contents__link toc-highlight">SOUL.md</a>
  - <a href="#agentsmd" class="table-of-contents__link toc-highlight">AGENTS.md</a>
- <a href="#soulmd-vs-personality" class="table-of-contents__link toc-highlight">SOUL.md vs <code>/personality</code></a>
- <a href="#built-in-personalities" class="table-of-contents__link toc-highlight">Built-in personalities</a>
- <a href="#switching-personalities-with-commands" class="table-of-contents__link toc-highlight">Switching personalities with commands</a>
  - <a href="#cli" class="table-of-contents__link toc-highlight">CLI</a>
  - <a href="#messaging-platforms" class="table-of-contents__link toc-highlight">Messaging platforms</a>
- <a href="#custom-personalities-in-config" class="table-of-contents__link toc-highlight">Custom personalities in config</a>
- <a href="#recommended-workflow" class="table-of-contents__link toc-highlight">Recommended workflow</a>
- <a href="#how-personality-interacts-with-the-full-prompt" class="table-of-contents__link toc-highlight">How personality interacts with the full prompt</a>
- <a href="#related-docs" class="table-of-contents__link toc-highlight">Related docs</a>
- <a href="#cli-appearance-vs-conversational-personality" class="table-of-contents__link toc-highlight">CLI appearance vs conversational personality</a>


