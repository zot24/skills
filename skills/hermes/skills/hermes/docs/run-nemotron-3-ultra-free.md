> Source: https://hermes-agent.nousresearch.com/docs/guides/run-nemotron-3-ultra-free/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# Run Nemotron 3 Ultra free in Hermes Agent


Nous Research has been inducted into the **Nemotron Coalition** of leading AI labs working with **NVIDIA** to advance open frontier foundation models. In honor of this, we've partnered with **Nebius** to provide **Nemotron 3 Ultra** free on <a href="https://portal.nousresearch.com" target="_blank" rel="noopener noreferrer">Nous Portal</a> for two weeks (**June 4th – June 18th**). Follow the instructions below to try the model in your Hermes Agent today.


The `nvidia/nemotron-3-ultra:free` tier is available from **June 4th to June 18th**. The `:free` tag is what keeps it on the no-cost plan — pick that exact variant.


Pick whichever install fits you. The **desktop app** is the easiest — no terminal required. If you live in a terminal, the **command-line** install is right below it.

## Option A — Desktop app (recommended)<a href="#option-a--desktop-app-recommended" class="hash-link" aria-label="Direct link to Option A — Desktop app (recommended)" translate="no" title="Direct link to Option A — Desktop app (recommended)">​</a>

The simplest path: a one-click installer with a guided, point-and-click setup. No terminal needed.

### 1. Download and install<a href="#1-download-and-install" class="hash-link" aria-label="Direct link to 1. Download and install" translate="no" title="Direct link to 1. Download and install">​</a>

<a href="https://hermes-agent.nousresearch.com/desktop" target="_blank" rel="noopener noreferrer">Download the Hermes Desktop installer</a> for macOS or Windows, then open it. On first launch it finishes setting itself up (usually under a minute).

### 2. Connect Nous Portal<a href="#2-connect-nous-portal" class="hash-link" aria-label="Direct link to 2. Connect Nous Portal" translate="no" title="Direct link to 2. Connect Nous Portal">​</a>

When the app opens, you'll see a "Let's get you set up" screen. Click **Nous Portal** (marked **Recommended**). Your browser opens — create a <a href="https://portal.nousresearch.com" target="_blank" rel="noopener noreferrer">Nous Portal</a> account (or sign in), choose the **Free** plan, and authorize Hermes. The app connects automatically.

### 3. Pick the free Nemotron 3 Ultra model<a href="#3-pick-the-free-nemotron-3-ultra-model" class="hash-link" aria-label="Direct link to 3. Pick the free Nemotron 3 Ultra model" translate="no" title="Direct link to 3. Pick the free Nemotron 3 Ultra model">​</a>

After connecting, the app shows a **Default model** card. Click **Change**, search for **nemotron 3 ultra**, and select the variant tagged **Free tier**:


``` prism-code
nvidia/nemotron-3-ultra:free
```


The `:free` tag is what keeps it on the no-cost tier — pick that variant.

### 4. Start chatting<a href="#4-start-chatting" class="hash-link" aria-label="Direct link to 4. Start chatting" translate="no" title="Direct link to 4. Start chatting">​</a>

Click **Start chatting**. That's it — you're talking to Nemotron 3 Ultra, free.

## Option B — Command line<a href="#option-b--command-line" class="hash-link" aria-label="Direct link to Option B — Command line" translate="no" title="Direct link to Option B — Command line">​</a>

Prefer the terminal?

### 1. Install Hermes Agent<a href="#1-install-hermes-agent" class="hash-link" aria-label="Direct link to 1. Install Hermes Agent" translate="no" title="Direct link to 1. Install Hermes Agent">​</a>

On macOS/Linux/WSL2/Android, run


``` prism-code
curl -fsSL https://hermes-agent.nousresearch.com/install.sh | bash
```


On Windows, run


``` prism-code
iex (irm https://hermes-agent.nousresearch.com/install.ps1)
```


Prefer to review first? Download <a href="https://hermes-agent.nousresearch.com/install.sh" target="_blank" rel="noopener noreferrer"><code>install.sh</code></a>, inspect it, then run it.

After it finishes, reload your shell:


``` prism-code
source ~/.bashrc   # or source ~/.zshrc
```


### 2. Run Quick Setup<a href="#2-run-quick-setup" class="hash-link" aria-label="Direct link to 2. Run Quick Setup" translate="no" title="Direct link to 2. Run Quick Setup">​</a>


``` prism-code
hermes setup
```


Select **Quick Setup**. Hermes opens a browser tab and waits for you to finish the next steps.

### 3. Create a Nous Portal account<a href="#3-create-a-nous-portal-account" class="hash-link" aria-label="Direct link to 3. Create a Nous Portal account" translate="no" title="Direct link to 3. Create a Nous Portal account">​</a>

In the browser, create a <a href="https://portal.nousresearch.com" target="_blank" rel="noopener noreferrer">Nous Portal</a> account (or sign in) and choose the **Free** plan.

### 4. Connect your account<a href="#4-connect-your-account" class="hash-link" aria-label="Direct link to 4. Connect your account" translate="no" title="Direct link to 4. Connect your account">​</a>

When prompted to connect your account to Hermes Agent, click **Connect**. You'll see a confirmation once it's linked.

### 5. Select the free Nemotron 3 Ultra model<a href="#5-select-the-free-nemotron-3-ultra-model" class="hash-link" aria-label="Direct link to 5. Select the free Nemotron 3 Ultra model" translate="no" title="Direct link to 5. Select the free Nemotron 3 Ultra model">​</a>

Return to your terminal. From the model list, select:


``` prism-code
nvidia/nemotron-3-ultra:free
```


The `:free` tag is what keeps it on the no-cost tier, so make sure you pick that variant.

### 6. Start chatting<a href="#6-start-chatting" class="hash-link" aria-label="Direct link to 6. Start chatting" translate="no" title="Direct link to 6. Start chatting">​</a>

Complete the remaining Quick Setup prompts, then run:


``` prism-code
hermes
```


That's it — you're talking to Nemotron 3 Ultra, free.

## Switching to it later<a href="#switching-to-it-later" class="hash-link" aria-label="Direct link to Switching to it later" translate="no" title="Direct link to Switching to it later">​</a>

Already set up with another model?

- **Desktop app:** open the model picker, search for **nemotron 3 ultra**, and select the **Free tier** variant.
- **CLI / TUI:** switch any time from inside a session with `/model nvidia/nemotron-3-ultra:free`, or run `/model` to open the picker and choose it from the list.

## Troubleshooting<a href="#troubleshooting" class="hash-link" aria-label="Direct link to Troubleshooting" translate="no" title="Direct link to Troubleshooting">​</a>

- **Don't see the model in the list?** Make sure you finished the Nous Portal connection and that you're on the **Free** plan. In the CLI, `hermes portal info` confirms you're logged in and routing through Nous.
- **Picked the wrong variant?** Re-select `nvidia/nemotron-3-ultra:free` — the `:free` suffix is required to stay on the no-cost tier.
- **Browser didn't open / you're on a remote host (CLI)?** See [OAuth over SSH / Remote Hosts](/docs/guides/oauth-over-ssh) for port-forwarding and manual-paste workarounds.

## See also<a href="#see-also" class="hash-link" aria-label="Direct link to See also" translate="no" title="Direct link to See also">​</a>

- **[Desktop App](/docs/user-guide/desktop)** — The native one-click app (macOS, Windows, Linux)
- **[Run Hermes Agent with Nous Portal](/docs/guides/run-hermes-with-nous-portal)** — Full Portal walkthrough: models, Tool Gateway, and verification
- **[Nous Portal integration](/docs/integrations/nous-portal)** — What's in the subscription
- **[Quickstart](/docs/getting-started/quickstart)** — Install-to-chat in under 5 minutes


- <a href="#option-a--desktop-app-recommended" class="table-of-contents__link toc-highlight">Option A — Desktop app (recommended)</a>
  - <a href="#1-download-and-install" class="table-of-contents__link toc-highlight">1. Download and install</a>
  - <a href="#2-connect-nous-portal" class="table-of-contents__link toc-highlight">2. Connect Nous Portal</a>
  - <a href="#3-pick-the-free-nemotron-3-ultra-model" class="table-of-contents__link toc-highlight">3. Pick the free Nemotron 3 Ultra model</a>
  - <a href="#4-start-chatting" class="table-of-contents__link toc-highlight">4. Start chatting</a>
- <a href="#option-b--command-line" class="table-of-contents__link toc-highlight">Option B — Command line</a>
  - <a href="#1-install-hermes-agent" class="table-of-contents__link toc-highlight">1. Install Hermes Agent</a>
  - <a href="#2-run-quick-setup" class="table-of-contents__link toc-highlight">2. Run Quick Setup</a>
  - <a href="#3-create-a-nous-portal-account" class="table-of-contents__link toc-highlight">3. Create a Nous Portal account</a>
  - <a href="#4-connect-your-account" class="table-of-contents__link toc-highlight">4. Connect your account</a>
  - <a href="#5-select-the-free-nemotron-3-ultra-model" class="table-of-contents__link toc-highlight">5. Select the free Nemotron 3 Ultra model</a>
  - <a href="#6-start-chatting" class="table-of-contents__link toc-highlight">6. Start chatting</a>
- <a href="#switching-to-it-later" class="table-of-contents__link toc-highlight">Switching to it later</a>
- <a href="#troubleshooting" class="table-of-contents__link toc-highlight">Troubleshooting</a>
- <a href="#see-also" class="table-of-contents__link toc-highlight">See also</a>


