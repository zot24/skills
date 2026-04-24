> Source: https://hermes-agent.nousresearch.com/docs/user-guide/features/cron/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# Scheduled Tasks (Cron)


Schedule tasks to run automatically with natural language or cron expressions. Hermes exposes cron management through a single `cronjob` tool with action-style operations instead of separate schedule/list/remove tools.

## What cron can do now<a href="#what-cron-can-do-now" class="hash-link" aria-label="Direct link to What cron can do now" translate="no" title="Direct link to What cron can do now">​</a>

Cron jobs can:

- schedule one-shot or recurring tasks
- pause, resume, edit, trigger, and remove jobs
- attach zero, one, or multiple skills to a job
- deliver results back to the origin chat, local files, or configured platform targets
- run in fresh agent sessions with the normal static tool list


Cron-run sessions cannot recursively create more cron jobs. Hermes disables cron management tools inside cron executions to prevent runaway scheduling loops.


## Creating scheduled tasks<a href="#creating-scheduled-tasks" class="hash-link" aria-label="Direct link to Creating scheduled tasks" translate="no" title="Direct link to Creating scheduled tasks">​</a>

### In chat with `/cron`<a href="#in-chat-with-cron" class="hash-link" aria-label="Direct link to in-chat-with-cron" translate="no" title="Direct link to in-chat-with-cron">​</a>


``` prism-code
/cron add 30m "Remind me to check the build"
/cron add "every 2h" "Check server status"
/cron add "every 1h" "Summarize new feed items" --skill blogwatcher
/cron add "every 1h" "Use both skills and combine the result" --skill blogwatcher --skill maps
```


### From the standalone CLI<a href="#from-the-standalone-cli" class="hash-link" aria-label="Direct link to From the standalone CLI" translate="no" title="Direct link to From the standalone CLI">​</a>


``` prism-code
hermes cron create "every 2h" "Check server status"
hermes cron create "every 1h" "Summarize new feed items" --skill blogwatcher
hermes cron create "every 1h" "Use both skills and combine the result" \
  --skill blogwatcher \
  --skill maps \
  --name "Skill combo"
```


### Through natural conversation<a href="#through-natural-conversation" class="hash-link" aria-label="Direct link to Through natural conversation" translate="no" title="Direct link to Through natural conversation">​</a>

Ask Hermes normally:


``` prism-code
Every morning at 9am, check Hacker News for AI news and send me a summary on Telegram.
```


Hermes will use the unified `cronjob` tool internally.

## Skill-backed cron jobs<a href="#skill-backed-cron-jobs" class="hash-link" aria-label="Direct link to Skill-backed cron jobs" translate="no" title="Direct link to Skill-backed cron jobs">​</a>

A cron job can load one or more skills before it runs the prompt.

### Single skill<a href="#single-skill" class="hash-link" aria-label="Direct link to Single skill" translate="no" title="Direct link to Single skill">​</a>


``` prism-code
cronjob(
    action="create",
    skill="blogwatcher",
    prompt="Check the configured feeds and summarize anything new.",
    schedule="0 9 * * *",
    name="Morning feeds",
)
```


### Multiple skills<a href="#multiple-skills" class="hash-link" aria-label="Direct link to Multiple skills" translate="no" title="Direct link to Multiple skills">​</a>

Skills are loaded in order. The prompt becomes the task instruction layered on top of those skills.


``` prism-code
cronjob(
    action="create",
    skills=["blogwatcher", "maps"],
    prompt="Look for new local events and interesting nearby places, then combine them into one short brief.",
    schedule="every 6h",
    name="Local brief",
)
```


This is useful when you want a scheduled agent to inherit reusable workflows without stuffing the full skill text into the cron prompt itself.

## Editing jobs<a href="#editing-jobs" class="hash-link" aria-label="Direct link to Editing jobs" translate="no" title="Direct link to Editing jobs">​</a>

You do not need to delete and recreate jobs just to change them.

### Chat<a href="#chat" class="hash-link" aria-label="Direct link to Chat" translate="no" title="Direct link to Chat">​</a>


``` prism-code
/cron edit <job_id> --schedule "every 4h"
/cron edit <job_id> --prompt "Use the revised task"
/cron edit <job_id> --skill blogwatcher --skill maps
/cron edit <job_id> --remove-skill blogwatcher
/cron edit <job_id> --clear-skills
```


### Standalone CLI<a href="#standalone-cli" class="hash-link" aria-label="Direct link to Standalone CLI" translate="no" title="Direct link to Standalone CLI">​</a>


``` prism-code
hermes cron edit <job_id> --schedule "every 4h"
hermes cron edit <job_id> --prompt "Use the revised task"
hermes cron edit <job_id> --skill blogwatcher --skill maps
hermes cron edit <job_id> --add-skill maps
hermes cron edit <job_id> --remove-skill blogwatcher
hermes cron edit <job_id> --clear-skills
```


Notes:

- repeated `--skill` replaces the job's attached skill list
- `--add-skill` appends to the existing list without replacing it
- `--remove-skill` removes specific attached skills
- `--clear-skills` removes all attached skills

## Lifecycle actions<a href="#lifecycle-actions" class="hash-link" aria-label="Direct link to Lifecycle actions" translate="no" title="Direct link to Lifecycle actions">​</a>

Cron jobs now have a fuller lifecycle than just create/remove.

### Chat<a href="#chat-1" class="hash-link" aria-label="Direct link to Chat" translate="no" title="Direct link to Chat">​</a>


``` prism-code
/cron list
/cron pause <job_id>
/cron resume <job_id>
/cron run <job_id>
/cron remove <job_id>
```


### Standalone CLI<a href="#standalone-cli-1" class="hash-link" aria-label="Direct link to Standalone CLI" translate="no" title="Direct link to Standalone CLI">​</a>


``` prism-code
hermes cron list
hermes cron pause <job_id>
hermes cron resume <job_id>
hermes cron run <job_id>
hermes cron remove <job_id>
hermes cron status
hermes cron tick
```


What they do:

- `pause` — keep the job but stop scheduling it
- `resume` — re-enable the job and compute the next future run
- `run` — trigger the job on the next scheduler tick
- `remove` — delete it entirely

## How it works<a href="#how-it-works" class="hash-link" aria-label="Direct link to How it works" translate="no" title="Direct link to How it works">​</a>

**Cron execution is handled by the gateway daemon.** The gateway ticks the scheduler every 60 seconds, running any due jobs in isolated agent sessions.


``` prism-code
hermes gateway install     # Install as a user service
sudo hermes gateway install --system   # Linux: boot-time system service for servers
hermes gateway             # Or run in foreground

hermes cron list
hermes cron status
```


### Gateway scheduler behavior<a href="#gateway-scheduler-behavior" class="hash-link" aria-label="Direct link to Gateway scheduler behavior" translate="no" title="Direct link to Gateway scheduler behavior">​</a>

On each tick Hermes:

1.  loads jobs from `~/.hermes/cron/jobs.json`
2.  checks `next_run_at` against the current time
3.  starts a fresh `AIAgent` session for each due job
4.  optionally injects one or more attached skills into that fresh session
5.  runs the prompt to completion
6.  delivers the final response
7.  updates run metadata and the next scheduled time

A file lock at `~/.hermes/cron/.tick.lock` prevents overlapping scheduler ticks from double-running the same job batch.

## Delivery options<a href="#delivery-options" class="hash-link" aria-label="Direct link to Delivery options" translate="no" title="Direct link to Delivery options">​</a>

When scheduling jobs, you specify where the output goes:

| Option                     | Description                                         | Example                        |
|----------------------------|-----------------------------------------------------|--------------------------------|
| `"origin"`                 | Back to where the job was created                   | Default on messaging platforms |
| `"local"`                  | Save to local files only (`~/.hermes/cron/output/`) | Default on CLI                 |
| `"telegram"`               | Telegram home channel                               | Uses `TELEGRAM_HOME_CHANNEL`   |
| `"telegram:123456"`        | Specific Telegram chat by ID                        | Direct delivery                |
| `"telegram:-100123:17585"` | Specific Telegram topic                             | `chat_id:thread_id` format     |
| `"discord"`                | Discord home channel                                | Uses `DISCORD_HOME_CHANNEL`    |
| `"discord:#engineering"`   | Specific Discord channel                            | By channel name                |
| `"slack"`                  | Slack home channel                                  |                                |
| `"whatsapp"`               | WhatsApp home                                       |                                |
| `"signal"`                 | Signal                                              |                                |
| `"matrix"`                 | Matrix home room                                    |                                |
| `"mattermost"`             | Mattermost home channel                             |                                |
| `"email"`                  | Email                                               |                                |
| `"sms"`                    | SMS via Twilio                                      |                                |
| `"homeassistant"`          | Home Assistant                                      |                                |
| `"dingtalk"`               | DingTalk                                            |                                |
| `"feishu"`                 | Feishu/Lark                                         |                                |
| `"wecom"`                  | WeCom                                               |                                |
| `"weixin"`                 | Weixin (WeChat)                                     |                                |
| `"bluebubbles"`            | BlueBubbles (iMessage)                              |                                |
| `"qqbot"`                  | QQ Bot (Tencent QQ)                                 |                                |

The agent's final response is automatically delivered. You do not need to call `send_message` in the cron prompt.

### Response wrapping<a href="#response-wrapping" class="hash-link" aria-label="Direct link to Response wrapping" translate="no" title="Direct link to Response wrapping">​</a>

By default, delivered cron output is wrapped with a header and footer so the recipient knows it came from a scheduled task:


``` prism-code
Cronjob Response: Morning feeds
-------------

<agent output here>

Note: The agent cannot see this message, and therefore cannot respond to it.
```


To deliver the raw agent output without the wrapper, set `cron.wrap_response` to `false`:


``` prism-code
# ~/.hermes/config.yaml
cron:
  wrap_response: false
```


### Silent suppression<a href="#silent-suppression" class="hash-link" aria-label="Direct link to Silent suppression" translate="no" title="Direct link to Silent suppression">​</a>

If the agent's final response starts with `[SILENT]`, delivery is suppressed entirely. The output is still saved locally for audit (in `~/.hermes/cron/output/`), but no message is sent to the delivery target.

This is useful for monitoring jobs that should only report when something is wrong:


``` prism-code
Check if nginx is running. If everything is healthy, respond with only [SILENT].
Otherwise, report the issue.
```


Failed jobs always deliver regardless of the `[SILENT]` marker — only successful runs can be silenced.

## Script timeout<a href="#script-timeout" class="hash-link" aria-label="Direct link to Script timeout" translate="no" title="Direct link to Script timeout">​</a>

Pre-run scripts (attached via the `script` parameter) have a default timeout of 120 seconds. If your scripts need longer — for example, to include randomized delays that avoid bot-like timing patterns — you can increase this:


``` prism-code
# ~/.hermes/config.yaml
cron:
  script_timeout_seconds: 300   # 5 minutes
```


Or set the `HERMES_CRON_SCRIPT_TIMEOUT` environment variable. The resolution order is: env var → config.yaml → 120s default.

## Provider recovery<a href="#provider-recovery" class="hash-link" aria-label="Direct link to Provider recovery" translate="no" title="Direct link to Provider recovery">​</a>

Cron jobs inherit your configured fallback providers and credential pool rotation. If the primary API key is rate-limited or the provider returns an error, the cron agent can:

- **Fall back to an alternate provider** if you have `fallback_providers` (or the legacy `fallback_model`) configured in `config.yaml`
- **Rotate to the next credential** in your [credential pool](/docs/user-guide/configuration#credential-pool-strategies) for the same provider

This means cron jobs that run at high frequency or during peak hours are more resilient — a single rate-limited key won't fail the entire run.

## Schedule formats<a href="#schedule-formats" class="hash-link" aria-label="Direct link to Schedule formats" translate="no" title="Direct link to Schedule formats">​</a>

The agent's final response is automatically delivered — you do **not** need to include `send_message` in the cron prompt for that same destination. If a cron run calls `send_message` to the exact target the scheduler will already deliver to, Hermes skips that duplicate send and tells the model to put the user-facing content in the final response instead. Use `send_message` only for additional or different targets.

### Relative delays (one-shot)<a href="#relative-delays-one-shot" class="hash-link" aria-label="Direct link to Relative delays (one-shot)" translate="no" title="Direct link to Relative delays (one-shot)">​</a>


``` prism-code
30m     → Run once in 30 minutes
2h      → Run once in 2 hours
1d      → Run once in 1 day
```


### Intervals (recurring)<a href="#intervals-recurring" class="hash-link" aria-label="Direct link to Intervals (recurring)" translate="no" title="Direct link to Intervals (recurring)">​</a>


``` prism-code
every 30m    → Every 30 minutes
every 2h     → Every 2 hours
every 1d     → Every day
```


### Cron expressions<a href="#cron-expressions" class="hash-link" aria-label="Direct link to Cron expressions" translate="no" title="Direct link to Cron expressions">​</a>


``` prism-code
0 9 * * *       → Daily at 9:00 AM
0 9 * * 1-5     → Weekdays at 9:00 AM
0 */6 * * *     → Every 6 hours
30 8 1 * *      → First of every month at 8:30 AM
0 0 * * 0       → Every Sunday at midnight
```


### ISO timestamps<a href="#iso-timestamps" class="hash-link" aria-label="Direct link to ISO timestamps" translate="no" title="Direct link to ISO timestamps">​</a>


``` prism-code
2026-03-15T09:00:00    → One-time at March 15, 2026 9:00 AM
```


## Repeat behavior<a href="#repeat-behavior" class="hash-link" aria-label="Direct link to Repeat behavior" translate="no" title="Direct link to Repeat behavior">​</a>

| Schedule type               | Default repeat | Behavior           |
|-----------------------------|----------------|--------------------|
| One-shot (`30m`, timestamp) | 1              | Runs once          |
| Interval (`every 2h`)       | forever        | Runs until removed |
| Cron expression             | forever        | Runs until removed |

You can override it:


``` prism-code
cronjob(
    action="create",
    prompt="...",
    schedule="every 2h",
    repeat=5,
)
```


## Managing jobs programmatically<a href="#managing-jobs-programmatically" class="hash-link" aria-label="Direct link to Managing jobs programmatically" translate="no" title="Direct link to Managing jobs programmatically">​</a>

The agent-facing API is one tool:


``` prism-code
cronjob(action="create", ...)
cronjob(action="list")
cronjob(action="update", job_id="...")
cronjob(action="pause", job_id="...")
cronjob(action="resume", job_id="...")
cronjob(action="run", job_id="...")
cronjob(action="remove", job_id="...")
```


For `update`, pass `skills=[]` to remove all attached skills.

## Job storage<a href="#job-storage" class="hash-link" aria-label="Direct link to Job storage" translate="no" title="Direct link to Job storage">​</a>

Jobs are stored in `~/.hermes/cron/jobs.json`. Output from job runs is saved to `~/.hermes/cron/output/{job_id}/{timestamp}.md`.

Jobs may store `model` and `provider` as `null`. When those fields are omitted, Hermes resolves them at execution time from the global configuration. They only appear in the job record when a per-job override is set.

The storage uses atomic file writes so interrupted writes do not leave a partially written job file behind.

## Self-contained prompts still matter<a href="#self-contained-prompts-still-matter" class="hash-link" aria-label="Direct link to Self-contained prompts still matter" translate="no" title="Direct link to Self-contained prompts still matter">​</a>


Cron jobs run in a completely fresh agent session. The prompt must contain everything the agent needs that is not already provided by attached skills.


**BAD:** `"Check on that server issue"`

**GOOD:** `"SSH into server 192.168.1.100 as user 'deploy', check if nginx is running with 'systemctl status nginx', and verify https://example.com returns HTTP 200."`

## Security<a href="#security" class="hash-link" aria-label="Direct link to Security" translate="no" title="Direct link to Security">​</a>

Scheduled task prompts are scanned for prompt-injection and credential-exfiltration patterns at creation and update time. Prompts containing invisible Unicode tricks, SSH backdoor attempts, or obvious secret-exfiltration payloads are blocked.


- <a href="#what-cron-can-do-now" class="table-of-contents__link toc-highlight">What cron can do now</a>
- <a href="#creating-scheduled-tasks" class="table-of-contents__link toc-highlight">Creating scheduled tasks</a>
  - <a href="#in-chat-with-cron" class="table-of-contents__link toc-highlight">In chat with <code>/cron</code></a>
  - <a href="#from-the-standalone-cli" class="table-of-contents__link toc-highlight">From the standalone CLI</a>
  - <a href="#through-natural-conversation" class="table-of-contents__link toc-highlight">Through natural conversation</a>
- <a href="#skill-backed-cron-jobs" class="table-of-contents__link toc-highlight">Skill-backed cron jobs</a>
  - <a href="#single-skill" class="table-of-contents__link toc-highlight">Single skill</a>
  - <a href="#multiple-skills" class="table-of-contents__link toc-highlight">Multiple skills</a>
- <a href="#editing-jobs" class="table-of-contents__link toc-highlight">Editing jobs</a>
  - <a href="#chat" class="table-of-contents__link toc-highlight">Chat</a>
  - <a href="#standalone-cli" class="table-of-contents__link toc-highlight">Standalone CLI</a>
- <a href="#lifecycle-actions" class="table-of-contents__link toc-highlight">Lifecycle actions</a>
  - <a href="#chat-1" class="table-of-contents__link toc-highlight">Chat</a>
  - <a href="#standalone-cli-1" class="table-of-contents__link toc-highlight">Standalone CLI</a>
- <a href="#how-it-works" class="table-of-contents__link toc-highlight">How it works</a>
  - <a href="#gateway-scheduler-behavior" class="table-of-contents__link toc-highlight">Gateway scheduler behavior</a>
- <a href="#delivery-options" class="table-of-contents__link toc-highlight">Delivery options</a>
  - <a href="#response-wrapping" class="table-of-contents__link toc-highlight">Response wrapping</a>
  - <a href="#silent-suppression" class="table-of-contents__link toc-highlight">Silent suppression</a>
- <a href="#script-timeout" class="table-of-contents__link toc-highlight">Script timeout</a>
- <a href="#provider-recovery" class="table-of-contents__link toc-highlight">Provider recovery</a>
- <a href="#schedule-formats" class="table-of-contents__link toc-highlight">Schedule formats</a>
  - <a href="#relative-delays-one-shot" class="table-of-contents__link toc-highlight">Relative delays (one-shot)</a>
  - <a href="#intervals-recurring" class="table-of-contents__link toc-highlight">Intervals (recurring)</a>
  - <a href="#cron-expressions" class="table-of-contents__link toc-highlight">Cron expressions</a>
  - <a href="#iso-timestamps" class="table-of-contents__link toc-highlight">ISO timestamps</a>
- <a href="#repeat-behavior" class="table-of-contents__link toc-highlight">Repeat behavior</a>
- <a href="#managing-jobs-programmatically" class="table-of-contents__link toc-highlight">Managing jobs programmatically</a>
- <a href="#job-storage" class="table-of-contents__link toc-highlight">Job storage</a>
- <a href="#self-contained-prompts-still-matter" class="table-of-contents__link toc-highlight">Self-contained prompts still matter</a>
- <a href="#security" class="table-of-contents__link toc-highlight">Security</a>


