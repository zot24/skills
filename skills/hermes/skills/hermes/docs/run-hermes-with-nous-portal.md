> Source: https://hermes-agent.nousresearch.com/docs/guides/run-hermes-with-nous-portal/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# Run Hermes Agent with Nous Portal


This guide walks you through running Hermes Agent on a <a href="https://portal.nousresearch.com" target="_blank" rel="noopener noreferrer">Nous Portal</a> subscription end to end — from signing up to verifying that every tool routes correctly. If you just want the overview of what the Portal is and what's in the subscription, see the [Nous Portal integration page](/docs/integrations/nous-portal). This page is the task script.

## Prerequisites<a href="#prerequisites" class="hash-link" aria-label="Direct link to Prerequisites" translate="no" title="Direct link to Prerequisites">​</a>

- Hermes Agent installed ([Quickstart](/docs/getting-started/quickstart))
- A web browser on the machine you're setting up (or SSH port forwarding — see [OAuth over SSH](/docs/guides/oauth-over-ssh))
- About 5 minutes

You do **not** need: an OpenAI key, an Anthropic key, a Firecrawl account, a FAL account, a Browser Use account, or any other per-vendor credential. That's the whole point.

## 1. Get a subscription<a href="#1-get-a-subscription" class="hash-link" aria-label="Direct link to 1. Get a subscription" translate="no" title="Direct link to 1. Get a subscription">​</a>

Open <a href="https://portal.nousresearch.com/manage-subscription" target="_blank" rel="noopener noreferrer">portal.nousresearch.com/manage-subscription</a>, sign up, and pick a plan.

Already subscribed? Skip to step 2.

## 2. Run the one-shot setup<a href="#2-run-the-one-shot-setup" class="hash-link" aria-label="Direct link to 2. Run the one-shot setup" translate="no" title="Direct link to 2. Run the one-shot setup">​</a>


``` prism-code
hermes setup --portal
```


This single command does five things:

1.  Opens your browser to portal.nousresearch.com for OAuth login
2.  Stores the refresh token at `~/.hermes/auth.json`
3.  Sets `model.provider: nous` in `~/.hermes/config.yaml`
4.  Picks a default agentic model (`anthropic/claude-sonnet-4.6` or similar)
5.  Turns on the Tool Gateway for web search, image generation, TTS, and browser automation

When it finishes, you're back at your terminal ready to chat.

### What if I'm SSH'd into a server?<a href="#what-if-im-sshd-into-a-server" class="hash-link" aria-label="Direct link to What if I&#39;m SSH&#39;d into a server?" translate="no" title="Direct link to What if I&#39;m SSH&#39;d into a server?">​</a>

OAuth needs a browser, but the loopback callback runs on the machine where Hermes is running. Two options:


``` prism-code
# Option A: SSH port forwarding (preferred)
ssh -N -L 8642:127.0.0.1:8642 user@remote-host    # in a local terminal
hermes setup --portal                              # on the remote, open the printed URL in your local browser

# Option B: manual paste (for Cloud Shell, Codespaces, EC2 Instance Connect)
hermes auth add nous --type oauth --manual-paste
# Then re-run `hermes setup --portal` to wire the provider + gateway
```


See [OAuth over SSH / Remote Hosts](/docs/guides/oauth-over-ssh) for the full walkthrough including ProxyJump chains, mosh/tmux, and ControlMaster gotchas.

## 3. Verify it worked<a href="#3-verify-it-worked" class="hash-link" aria-label="Direct link to 3. Verify it worked" translate="no" title="Direct link to 3. Verify it worked">​</a>


``` prism-code
hermes portal info
```


You should see:


``` prism-code
  Nous Portal
  ───────────
  Auth:    ✓ logged in
  Portal:  https://portal.nousresearch.com
  Model:   ✓ using Nous as inference provider

  Tool Gateway
  ────────────
  Web search & extract  via Nous Portal
  Image generation      via Nous Portal
  Text-to-speech        via Nous Portal
  Browser automation    via Nous Portal
```


If any line shows something other than "via Nous Portal" or the auth line says "not logged in", jump to [Troubleshooting](#troubleshooting) below.

## 4. Run your first conversation<a href="#4-run-your-first-conversation" class="hash-link" aria-label="Direct link to 4. Run your first conversation" translate="no" title="Direct link to 4. Run your first conversation">​</a>


``` prism-code
hermes chat
```


Try something that exercises both the model and the Tool Gateway:


``` prism-code
Hey, search the web for "Hermes Agent release notes" and summarize the top 3 hits.
```


You should see Hermes call `web_search` (Firecrawl-backed, through the gateway) and respond with a summary. If the search runs and the response makes sense, you're done — the Portal is wired up end to end.

## 5. Pick the model you actually want<a href="#5-pick-the-model-you-actually-want" class="hash-link" aria-label="Direct link to 5. Pick the model you actually want" translate="no" title="Direct link to 5. Pick the model you actually want">​</a>

`hermes setup --portal` lets you pick a model during setup, but the whole point of the subscription is access to the full catalog — switch any time with `/model` mid-session:


``` prism-code
/model anthropic/claude-sonnet-4.6     # best general-purpose agentic
/model openai/gpt-5.4                  # strong reasoning + tool calling
/model google/gemini-2.5-pro           # huge context window
/model deepseek/deepseek-v3.2          # cost-effective coder
/model anthropic/claude-opus-4.6       # heavyweight for hard problems
```


Or pop the picker to browse:


``` prism-code
/model
```


Pick a different default permanently:


``` prism-code
# in your terminal, outside any session
hermes config set model.default anthropic/claude-sonnet-4.6
```


### Don't pick Hermes-4 for agent work<a href="#dont-pick-hermes-4-for-agent-work" class="hash-link" aria-label="Direct link to Don&#39;t pick Hermes-4 for agent work" translate="no" title="Direct link to Don&#39;t pick Hermes-4 for agent work">​</a>

Hermes-4-70B and Hermes-4-405B are available on the Portal at deep discounts, but they're **chat/reasoning models**, not tool-call-tuned. They will struggle with multi-step agent loops. Use them via <a href="https://chat.nousresearch.com" target="_blank" rel="noopener noreferrer">Nous Chat</a> for conversation/research work, or through the [subscription proxy](/docs/user-guide/features/subscription-proxy) from non-agent tools. For Hermes Agent itself, stick to the frontier agentic models above.

The Portal's own <a href="https://portal.nousresearch.com/info" target="_blank" rel="noopener noreferrer">info page</a> carries this warning too — it's the official Nous guidance, not just a Hermes-side opinion.

## 6. (Optional) Customize Tool Gateway routing<a href="#6-optional-customize-tool-gateway-routing" class="hash-link" aria-label="Direct link to 6. (Optional) Customize Tool Gateway routing" translate="no" title="Direct link to 6. (Optional) Customize Tool Gateway routing">​</a>

The gateway is opt-in per tool, not all-or-nothing. If you already have a Browserbase account and want to keep using it while routing web search and image generation through Nous, that's supported:


``` prism-code
hermes tools
# → Web search       → "Nous Subscription"     (recommended)
# → Image generation → "Nous Subscription"     (recommended)
# → Browser          → "Browserbase"           (your existing key)
# → TTS              → "Nous Subscription"     (recommended)
```


These rows appear in `hermes tools` even before you've logged into Nous Portal — if you pick "Nous Subscription" without an active session, Hermes runs the Portal login inline (without changing your inference provider or your other tools).

Verify your mix with:


``` prism-code
hermes portal tools
```


You'll see per-tool routing — `via Nous Portal` for the ones routed through the subscription, and the partner name (`browserbase`, `firecrawl`, etc.) for the ones using your own keys.

## 7. (Optional) Enable voice mode<a href="#7-optional-enable-voice-mode" class="hash-link" aria-label="Direct link to 7. (Optional) Enable voice mode" translate="no" title="Direct link to 7. (Optional) Enable voice mode">​</a>

Because the Tool Gateway includes OpenAI TTS, [voice mode](/docs/user-guide/features/voice-mode) works without a separate OpenAI key:


``` prism-code
hermes setup voice
# → pick "Nous Subscription" for TTS
# → pick a speech-to-text backend (local faster-whisper is free, no setup)
```


Then in any messaging-platform session (Telegram, Discord, Signal, etc.), send a voice message and Hermes will transcribe it, respond, and reply with synthesized voice — all on your Portal subscription.

## 8. (Optional) Cron + always-on workflows<a href="#8-optional-cron--always-on-workflows" class="hash-link" aria-label="Direct link to 8. (Optional) Cron + always-on workflows" translate="no" title="Direct link to 8. (Optional) Cron + always-on workflows">​</a>

The Portal subscription works for [cron jobs](/docs/user-guide/features/cron) and [batch processing](/docs/user-guide/features/batch-processing) the same way it works for interactive chat — the OAuth refresh token is reused automatically. No additional setup; just schedule cron jobs and they'll bill against your subscription.


``` prism-code
hermes cron create "every day at 9am" \
  "Search the web for top AI news and summarize the 5 most important stories" \
  --name "Daily AI news"
```


The cron job runs unattended, calls the model + web search + summarization all through your Portal subscription.

## Profiles and multi-user setups<a href="#profiles-and-multi-user-setups" class="hash-link" aria-label="Direct link to Profiles and multi-user setups" translate="no" title="Direct link to Profiles and multi-user setups">​</a>

If you use [Hermes profiles](/docs/user-guide/profiles) (e.g. a separate config per project), the Portal refresh token is automatically shared across all profiles via a shared token store. Sign in once on any profile, and the rest pick it up automatically.

For team setups where multiple humans share a machine, each human has their own Portal account → each home directory holds its own `~/.hermes/auth.json` → no token sharing across users. This is the right boundary.

## Troubleshooting<a href="#troubleshooting" class="hash-link" aria-label="Direct link to Troubleshooting" translate="no" title="Direct link to Troubleshooting">​</a>

### `hermes portal info` shows "not logged in" after `hermes setup --portal`<a href="#hermes-portal-info-shows-not-logged-in-after-hermes-setup---portal" class="hash-link" aria-label="Direct link to hermes-portal-info-shows-not-logged-in-after-hermes-setup---portal" translate="no" title="Direct link to hermes-portal-info-shows-not-logged-in-after-hermes-setup---portal">​</a>

The OAuth flow didn't complete. Re-run it:


``` prism-code
hermes portal
```


If your browser doesn't open or the callback fails, you're likely on a remote/headless host — see [OAuth over SSH](/docs/guides/oauth-over-ssh) for the port-forwarding and manual-paste workarounds.

### "Model: currently openrouter" (or some other provider) instead of "using Nous as inference provider"<a href="#model-currently-openrouter-or-some-other-provider-instead-of-using-nous-as-inference-provider" class="hash-link" aria-label="Direct link to &quot;Model: currently openrouter&quot; (or some other provider) instead of &quot;using Nous as inference provider&quot;" translate="no" title="Direct link to &quot;Model: currently openrouter&quot; (or some other provider) instead of &quot;using Nous as inference provider&quot;">​</a>

Your local config drifted. The OAuth worked but `model.provider` is still pointing at a different provider. Fix:


``` prism-code
hermes config set model.provider nous
```


Or interactively:


``` prism-code
hermes model
# pick Nous Portal
```


Re-verify with `hermes portal info`.

### Tool Gateway tools showing partner names instead of "via Nous Portal"<a href="#tool-gateway-tools-showing-partner-names-instead-of-via-nous-portal" class="hash-link" aria-label="Direct link to Tool Gateway tools showing partner names instead of &quot;via Nous Portal&quot;" translate="no" title="Direct link to Tool Gateway tools showing partner names instead of &quot;via Nous Portal&quot;">​</a>

Per-tool config is overriding the gateway. Run:


``` prism-code
hermes tools
# pick "Nous Subscription" for any tool you want gateway-routed
```


Some users intentionally mix — e.g. routing web through Nous but using their own Browserbase key for browser. If that's intentional, leave it alone. If not, this command fixes it.

### "Re-authentication required" mid-session<a href="#re-authentication-required-mid-session" class="hash-link" aria-label="Direct link to &quot;Re-authentication required&quot; mid-session" translate="no" title="Direct link to &quot;Re-authentication required&quot; mid-session">​</a>

Your Portal refresh token was invalidated (password change, manual revoke, session expiry). The token is now quarantined locally so Hermes doesn't replay it endlessly. Just log in again:


``` prism-code
hermes auth add nous
```


The quarantine clears automatically on successful re-login.

### Model I want isn't in the `/model` picker<a href="#model-i-want-isnt-in-the-model-picker" class="hash-link" aria-label="Direct link to model-i-want-isnt-in-the-model-picker" translate="no" title="Direct link to model-i-want-isnt-in-the-model-picker">​</a>

The Portal catalog mirrors OpenRouter's model list (300+). If a model is missing, try typing the OpenRouter-style slug directly:


``` prism-code
/model anthropic/claude-opus-4.6
/model openai/o1-2025-12-17
```


If a model is genuinely unavailable, <a href="https://github.com/NousResearch/hermes-agent/issues" target="_blank" rel="noopener noreferrer">open an issue</a> — most gaps are routing config we can update.

### Billing not appearing on my Portal account<a href="#billing-not-appearing-on-my-portal-account" class="hash-link" aria-label="Direct link to Billing not appearing on my Portal account" translate="no" title="Direct link to Billing not appearing on my Portal account">​</a>

`hermes portal info` will tell you whether you're actually routing through the Portal or some other provider. Common causes:

- `model.provider` set to `openrouter`/`anthropic`/etc. instead of `nous`
- An OAuth refresh failure that fell back to a different configured provider
- Multiple Hermes profiles where you're using the wrong one (check `hermes profile list`)

### Want to revoke and start clean<a href="#want-to-revoke-and-start-clean" class="hash-link" aria-label="Direct link to Want to revoke and start clean" translate="no" title="Direct link to Want to revoke and start clean">​</a>


``` prism-code
hermes auth logout nous       # wipes the local refresh token
# Then re-run setup or remove the subscription from the Portal web UI
```


## What this gets you, in plain numbers<a href="#what-this-gets-you-in-plain-numbers" class="hash-link" aria-label="Direct link to What this gets you, in plain numbers" translate="no" title="Direct link to What this gets you, in plain numbers">​</a>

| Without Portal                                   | With Portal                            |
|--------------------------------------------------|----------------------------------------|
| 1× OpenRouter / Anthropic / OpenAI key in `.env` | 1× OAuth refresh token, no `.env` keys |
| 1× Firecrawl key for web                         | Web routed through gateway             |
| 1× FAL key for image gen                         | Image gen routed through gateway       |
| 1× Browser Use / Browserbase key for browser     | Browser routed through gateway         |
| 1× OpenAI key for TTS / voice mode               | TTS routed through gateway             |
| 5 separate dashboards, top-ups, invoices         | 1 subscription, 1 invoice              |
| Cross-machine: replicate all 5 keys              | Cross-machine: re-OAuth once           |

That's the deal. If you're using more than two of those backends anyway, the subscription pays for itself.

## See also<a href="#see-also" class="hash-link" aria-label="Direct link to See also" translate="no" title="Direct link to See also">​</a>

- **[Nous Portal integration page](/docs/integrations/nous-portal)** — Overview of what's in the subscription
- **[Tool Gateway](/docs/user-guide/features/tool-gateway)** — Full details on every gateway-routed tool
- **[Subscription proxy](/docs/user-guide/features/subscription-proxy)** — Use your Portal subscription from non-Hermes tools
- **[Voice mode](/docs/user-guide/features/voice-mode)** — Set up voice conversations on the Portal subscription
- **[OAuth over SSH](/docs/guides/oauth-over-ssh)** — Remote / headless login patterns
- **[Profiles](/docs/user-guide/profiles)** — Share one Portal login across multiple Hermes configurations


- <a href="#prerequisites" class="table-of-contents__link toc-highlight">Prerequisites</a>
- <a href="#1-get-a-subscription" class="table-of-contents__link toc-highlight">1. Get a subscription</a>
- <a href="#2-run-the-one-shot-setup" class="table-of-contents__link toc-highlight">2. Run the one-shot setup</a>
  - <a href="#what-if-im-sshd-into-a-server" class="table-of-contents__link toc-highlight">What if I'm SSH'd into a server?</a>
- <a href="#3-verify-it-worked" class="table-of-contents__link toc-highlight">3. Verify it worked</a>
- <a href="#4-run-your-first-conversation" class="table-of-contents__link toc-highlight">4. Run your first conversation</a>
- <a href="#5-pick-the-model-you-actually-want" class="table-of-contents__link toc-highlight">5. Pick the model you actually want</a>
  - <a href="#dont-pick-hermes-4-for-agent-work" class="table-of-contents__link toc-highlight">Don't pick Hermes-4 for agent work</a>
- <a href="#6-optional-customize-tool-gateway-routing" class="table-of-contents__link toc-highlight">6. (Optional) Customize Tool Gateway routing</a>
- <a href="#7-optional-enable-voice-mode" class="table-of-contents__link toc-highlight">7. (Optional) Enable voice mode</a>
- <a href="#8-optional-cron--always-on-workflows" class="table-of-contents__link toc-highlight">8. (Optional) Cron + always-on workflows</a>
- <a href="#profiles-and-multi-user-setups" class="table-of-contents__link toc-highlight">Profiles and multi-user setups</a>
- <a href="#troubleshooting" class="table-of-contents__link toc-highlight">Troubleshooting</a>
  - <a href="#hermes-portal-info-shows-not-logged-in-after-hermes-setup---portal" class="table-of-contents__link toc-highlight"><code>hermes portal info</code> shows "not logged in" after <code>hermes setup --portal</code></a>
  - <a href="#model-currently-openrouter-or-some-other-provider-instead-of-using-nous-as-inference-provider" class="table-of-contents__link toc-highlight">"Model: currently openrouter" (or some other provider) instead of "using Nous as inference provider"</a>
  - <a href="#tool-gateway-tools-showing-partner-names-instead-of-via-nous-portal" class="table-of-contents__link toc-highlight">Tool Gateway tools showing partner names instead of "via Nous Portal"</a>
  - <a href="#re-authentication-required-mid-session" class="table-of-contents__link toc-highlight">"Re-authentication required" mid-session</a>
  - <a href="#model-i-want-isnt-in-the-model-picker" class="table-of-contents__link toc-highlight">Model I want isn't in the <code>/model</code> picker</a>
  - <a href="#billing-not-appearing-on-my-portal-account" class="table-of-contents__link toc-highlight">Billing not appearing on my Portal account</a>
  - <a href="#want-to-revoke-and-start-clean" class="table-of-contents__link toc-highlight">Want to revoke and start clean</a>
- <a href="#what-this-gets-you-in-plain-numbers" class="table-of-contents__link toc-highlight">What this gets you, in plain numbers</a>
- <a href="#see-also" class="table-of-contents__link toc-highlight">See also</a>


