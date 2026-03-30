> Source: https://hermes-agent.nousresearch.com/docs/user-guide/features/memory/



On this page


# Persistent Memory


Hermes Agent has bounded, curated memory that persists across sessions. This lets it remember your preferences, your projects, your environment, and things it has learned.

## How It Works<a href="#how-it-works" class="hash-link" aria-label="Direct link to How It Works" translate="no" title="Direct link to How It Works">​</a>

Two files make up the agent's memory:

| File | Purpose | Char Limit |
|----|----|----|
| **MEMORY.md** | Agent's personal notes — environment facts, conventions, things learned | 2,200 chars (~800 tokens) |
| **USER.md** | User profile — your preferences, communication style, expectations | 1,375 chars (~500 tokens) |

Both are stored in `~/.hermes/memories/` and are injected into the system prompt as a frozen snapshot at session start. The agent manages its own memory via the `memory` tool — it can add, replace, or remove entries.


Character limits keep memory focused. When memory is full, the agent consolidates or replaces entries to make room for new information.


## How Memory Appears in the System Prompt<a href="#how-memory-appears-in-the-system-prompt" class="hash-link" aria-label="Direct link to How Memory Appears in the System Prompt" translate="no" title="Direct link to How Memory Appears in the System Prompt">​</a>

At the start of every session, memory entries are loaded from disk and rendered into the system prompt as a frozen block:


``` text
══════════════════════════════════════════════
MEMORY (your personal notes) [67% — 1,474/2,200 chars]
══════════════════════════════════════════════
User's project is a Rust web service at ~/code/myapi using Axum + SQLx
§
This machine runs Ubuntu 22.04, has Docker and Podman installed
§
User prefers concise responses, dislikes verbose explanations
```


The format includes:

- A header showing which store (MEMORY or USER PROFILE)
- Usage percentage and character counts so the agent knows capacity
- Individual entries separated by `§` (section sign) delimiters
- Entries can be multiline

**Frozen snapshot pattern:** The system prompt injection is captured once at session start and never changes mid-session. This is intentional — it preserves the LLM's prefix cache for performance. When the agent adds/removes memory entries during a session, the changes are persisted to disk immediately but won't appear in the system prompt until the next session starts. Tool responses always show the live state.

## Memory Tool Actions<a href="#memory-tool-actions" class="hash-link" aria-label="Direct link to Memory Tool Actions" translate="no" title="Direct link to Memory Tool Actions">​</a>

The agent uses the `memory` tool with these actions:

- **add** — Add a new memory entry
- **replace** — Replace an existing entry with updated content (uses substring matching via `old_text`)
- **remove** — Remove an entry that's no longer relevant (uses substring matching via `old_text`)

There is no `read` action — memory content is automatically injected into the system prompt at session start. The agent sees its memories as part of its conversation context.

### Substring Matching<a href="#substring-matching" class="hash-link" aria-label="Direct link to Substring Matching" translate="no" title="Direct link to Substring Matching">​</a>

The `replace` and `remove` actions use short unique substring matching — you don't need the full entry text. The `old_text` parameter just needs to be a unique substring that identifies exactly one entry:


``` python
# If memory contains "User prefers dark mode in all editors"
memory(action="replace", target="memory",
       old_text="dark mode",
       content="User prefers light mode in VS Code, dark mode in terminal")
```


If the substring matches multiple entries, an error is returned asking for a more specific match.

## Two Targets Explained<a href="#two-targets-explained" class="hash-link" aria-label="Direct link to Two Targets Explained" translate="no" title="Direct link to Two Targets Explained">​</a>

### `memory` — Agent's Personal Notes<a href="#memory--agents-personal-notes" class="hash-link" aria-label="Direct link to memory--agents-personal-notes" translate="no" title="Direct link to memory--agents-personal-notes">​</a>

For information the agent needs to remember about the environment, workflows, and lessons learned:

- Environment facts (OS, tools, project structure)
- Project conventions and configuration
- Tool quirks and workarounds discovered
- Completed task diary entries
- Skills and techniques that worked

### `user` — User Profile<a href="#user--user-profile" class="hash-link" aria-label="Direct link to user--user-profile" translate="no" title="Direct link to user--user-profile">​</a>

For information about the user's identity, preferences, and communication style:

- Name, role, timezone
- Communication preferences (concise vs detailed, format preferences)
- Pet peeves and things to avoid
- Workflow habits
- Technical skill level

## What to Save vs Skip<a href="#what-to-save-vs-skip" class="hash-link" aria-label="Direct link to What to Save vs Skip" translate="no" title="Direct link to What to Save vs Skip">​</a>

### Save These (Proactively)<a href="#save-these-proactively" class="hash-link" aria-label="Direct link to Save These (Proactively)" translate="no" title="Direct link to Save These (Proactively)">​</a>

The agent saves automatically — you don't need to ask. It saves when it learns:

- **User preferences:** "I prefer TypeScript over JavaScript" → save to `user`
- **Environment facts:** "This server runs Debian 12 with PostgreSQL 16" → save to `memory`
- **Corrections:** "Don't use `sudo` for Docker commands, user is in docker group" → save to `memory`
- **Conventions:** "Project uses tabs, 120-char line width, Google-style docstrings" → save to `memory`
- **Completed work:** "Migrated database from MySQL to PostgreSQL on 2026-01-15" → save to `memory`
- **Explicit requests:** "Remember that my API key rotation happens monthly" → save to `memory`

### Skip These<a href="#skip-these" class="hash-link" aria-label="Direct link to Skip These" translate="no" title="Direct link to Skip These">​</a>

- **Trivial/obvious info:** "User asked about Python" — too vague to be useful
- **Easily re-discovered facts:** "Python 3.12 supports f-string nesting" — can web search this
- **Raw data dumps:** Large code blocks, log files, data tables — too big for memory
- **Session-specific ephemera:** Temporary file paths, one-off debugging context
- **Information already in context files:** SOUL.md and AGENTS.md content

## Capacity Management<a href="#capacity-management" class="hash-link" aria-label="Direct link to Capacity Management" translate="no" title="Direct link to Capacity Management">​</a>

Memory has strict character limits to keep system prompts bounded:

| Store  | Limit       | Typical entries |
|--------|-------------|-----------------|
| memory | 2,200 chars | 8-15 entries    |
| user   | 1,375 chars | 5-10 entries    |

### What Happens When Memory is Full<a href="#what-happens-when-memory-is-full" class="hash-link" aria-label="Direct link to What Happens When Memory is Full" translate="no" title="Direct link to What Happens When Memory is Full">​</a>

When you try to add an entry that would exceed the limit, the tool returns an error:


``` json
{
  "success": false,
  "error": "Memory at 2,100/2,200 chars. Adding this entry (250 chars) would exceed the limit. Replace or remove existing entries first.",
  "current_entries": ["..."],
  "usage": "2,100/2,200"
}
```


The agent should then:

1.  Read the current entries (shown in the error response)
2.  Identify entries that can be removed or consolidated
3.  Use `replace` to merge related entries into shorter versions
4.  Then `add` the new entry

**Best practice:** When memory is above 80% capacity (visible in the system prompt header), consolidate entries before adding new ones. For example, merge three separate "project uses X" entries into one comprehensive project description entry.

### Practical Examples of Good Memory Entries<a href="#practical-examples-of-good-memory-entries" class="hash-link" aria-label="Direct link to Practical Examples of Good Memory Entries" translate="no" title="Direct link to Practical Examples of Good Memory Entries">​</a>

**Compact, information-dense entries work best:**


``` text
# Good: Packs multiple related facts
User runs macOS 14 Sonoma, uses Homebrew, has Docker Desktop and Podman. Shell: zsh with oh-my-zsh. Editor: VS Code with Vim keybindings.

# Good: Specific, actionable convention
Project ~/code/api uses Go 1.22, sqlc for DB queries, chi router. Run tests with 'make test'. CI via GitHub Actions.

# Good: Lesson learned with context
The staging server (10.0.1.50) needs SSH port 2222, not 22. Key is at ~/.ssh/staging_ed25519.

# Bad: Too vague
User has a project.

# Bad: Too verbose
On January 5th, 2026, the user asked me to look at their project which is
located at ~/code/api. I discovered it uses Go version 1.22 and...
```


## Duplicate Prevention<a href="#duplicate-prevention" class="hash-link" aria-label="Direct link to Duplicate Prevention" translate="no" title="Direct link to Duplicate Prevention">​</a>

The memory system automatically rejects exact duplicate entries. If you try to add content that already exists, it returns success with a "no duplicate added" message.

## Security Scanning<a href="#security-scanning" class="hash-link" aria-label="Direct link to Security Scanning" translate="no" title="Direct link to Security Scanning">​</a>

Memory entries are scanned for injection and exfiltration patterns before being accepted, since they're injected into the system prompt. Content matching threat patterns (prompt injection, credential exfiltration, SSH backdoors) or containing invisible Unicode characters is blocked.

## Session Search<a href="#session-search" class="hash-link" aria-label="Direct link to Session Search" translate="no" title="Direct link to Session Search">​</a>

Beyond MEMORY.md and USER.md, the agent can search its past conversations using the `session_search` tool:

- All CLI and messaging sessions are stored in SQLite (`~/.hermes/state.db`) with FTS5 full-text search
- Search queries return relevant past conversations with Gemini Flash summarization
- The agent can find things it discussed weeks ago, even if they're not in its active memory


``` bash
hermes sessions list    # Browse past sessions
```


### session_search vs memory<a href="#session_search-vs-memory" class="hash-link" aria-label="Direct link to session_search vs memory" translate="no" title="Direct link to session_search vs memory">​</a>

| Feature | Persistent Memory | Session Search |
|----|----|----|
| **Capacity** | ~1,300 tokens total | Unlimited (all sessions) |
| **Speed** | Instant (in system prompt) | Requires search + LLM summarization |
| **Use case** | Key facts always available | Finding specific past conversations |
| **Management** | Manually curated by agent | Automatic — all sessions stored |
| **Token cost** | Fixed per session (~1,300 tokens) | On-demand (searched when needed) |

**Memory** is for critical facts that should always be in context. **Session search** is for "did we discuss X last week?" queries where the agent needs to recall specifics from past conversations.

## Configuration<a href="#configuration" class="hash-link" aria-label="Direct link to Configuration" translate="no" title="Direct link to Configuration">​</a>


``` yaml
# In ~/.hermes/config.yaml
memory:
  memory_enabled: true
  user_profile_enabled: true
  memory_char_limit: 2200   # ~800 tokens
  user_char_limit: 1375     # ~500 tokens
```


## Honcho Integration (Cross-Session User Modeling)<a href="#honcho-integration-cross-session-user-modeling" class="hash-link" aria-label="Direct link to Honcho Integration (Cross-Session User Modeling)" translate="no" title="Direct link to Honcho Integration (Cross-Session User Modeling)">​</a>

For deeper, AI-generated user understanding that works across sessions and platforms, you can enable [Honcho Memory](/docs/user-guide/features/honcho). Honcho runs alongside built-in memory in `hybrid` mode (the default) — `MEMORY.md` and `USER.md` stay as-is, and Honcho adds a persistent user modeling layer on top.


``` bash
hermes honcho setup
```


See the [Honcho Memory](/docs/user-guide/features/honcho) docs for full configuration, tools, and CLI reference.


- <a href="#how-it-works" class="table-of-contents__link toc-highlight">How It Works</a>
- <a href="#how-memory-appears-in-the-system-prompt" class="table-of-contents__link toc-highlight">How Memory Appears in the System Prompt</a>
- <a href="#memory-tool-actions" class="table-of-contents__link toc-highlight">Memory Tool Actions</a>
  - <a href="#substring-matching" class="table-of-contents__link toc-highlight">Substring Matching</a>
- <a href="#two-targets-explained" class="table-of-contents__link toc-highlight">Two Targets Explained</a>
  - <a href="#memory--agents-personal-notes" class="table-of-contents__link toc-highlight"><code>memory</code> — Agent's Personal Notes</a>
  - <a href="#user--user-profile" class="table-of-contents__link toc-highlight"><code>user</code> — User Profile</a>
- <a href="#what-to-save-vs-skip" class="table-of-contents__link toc-highlight">What to Save vs Skip</a>
  - <a href="#save-these-proactively" class="table-of-contents__link toc-highlight">Save These (Proactively)</a>
  - <a href="#skip-these" class="table-of-contents__link toc-highlight">Skip These</a>
- <a href="#capacity-management" class="table-of-contents__link toc-highlight">Capacity Management</a>
  - <a href="#what-happens-when-memory-is-full" class="table-of-contents__link toc-highlight">What Happens When Memory is Full</a>
  - <a href="#practical-examples-of-good-memory-entries" class="table-of-contents__link toc-highlight">Practical Examples of Good Memory Entries</a>
- <a href="#duplicate-prevention" class="table-of-contents__link toc-highlight">Duplicate Prevention</a>
- <a href="#security-scanning" class="table-of-contents__link toc-highlight">Security Scanning</a>
- <a href="#session-search" class="table-of-contents__link toc-highlight">Session Search</a>
  - <a href="#session_search-vs-memory" class="table-of-contents__link toc-highlight">session_search vs memory</a>
- <a href="#configuration" class="table-of-contents__link toc-highlight">Configuration</a>
- <a href="#honcho-integration-cross-session-user-modeling" class="table-of-contents__link toc-highlight">Honcho Integration (Cross-Session User Modeling)</a>


