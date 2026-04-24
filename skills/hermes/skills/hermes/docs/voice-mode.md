> Source: https://hermes-agent.nousresearch.com/docs/user-guide/features/voice-mode/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# Voice Mode


Hermes Agent supports full voice interaction across CLI and messaging platforms. Talk to the agent using your microphone, hear spoken replies, and have live voice conversations in Discord voice channels.

If you want a practical setup walkthrough with recommended configurations and real usage patterns, see [Use Voice Mode with Hermes](/docs/guides/use-voice-mode-with-hermes).

## Prerequisites<a href="#prerequisites" class="hash-link" aria-label="Direct link to Prerequisites" translate="no" title="Direct link to Prerequisites">​</a>

Before using voice features, make sure you have:

1.  **Hermes Agent installed** — `pip install hermes-agent` (see [Installation](/docs/getting-started/installation))
2.  **An LLM provider configured** — run `hermes model` or set your preferred provider credentials in `~/.hermes/.env`
3.  **A working base setup** — run `hermes` to verify the agent responds to text before enabling voice


The `~/.hermes/` directory and default `config.yaml` are created automatically the first time you run `hermes`. You only need to create `~/.hermes/.env` manually for API keys.


## Overview<a href="#overview" class="hash-link" aria-label="Direct link to Overview" translate="no" title="Direct link to Overview">​</a>

| Feature               | Platform          | Description                                                     |
|-----------------------|-------------------|-----------------------------------------------------------------|
| **Interactive Voice** | CLI               | Press Ctrl+B to record, agent auto-detects silence and responds |
| **Auto Voice Reply**  | Telegram, Discord | Agent sends spoken audio alongside text responses               |
| **Voice Channel**     | Discord           | Bot joins VC, listens to users speaking, speaks replies back    |

## Requirements<a href="#requirements" class="hash-link" aria-label="Direct link to Requirements" translate="no" title="Direct link to Requirements">​</a>

### Python Packages<a href="#python-packages" class="hash-link" aria-label="Direct link to Python Packages" translate="no" title="Direct link to Python Packages">​</a>


``` prism-code
# CLI voice mode (microphone + audio playback)
pip install "hermes-agent[voice]"

# Discord + Telegram messaging (includes discord.py[voice] for VC support)
pip install "hermes-agent[messaging]"

# Premium TTS (ElevenLabs)
pip install "hermes-agent[tts-premium]"

# Local TTS (NeuTTS, optional)
python -m pip install -U neutts[all]

# Everything at once
pip install "hermes-agent[all]"
```


| Extra         | Packages                                              | Required For            |
|---------------|-------------------------------------------------------|-------------------------|
| `voice`       | `sounddevice`, `numpy`                                | CLI voice mode          |
| `messaging`   | `discord.py[voice]`, `python-telegram-bot`, `aiohttp` | Discord & Telegram bots |
| `tts-premium` | `elevenlabs`                                          | ElevenLabs TTS provider |

Optional local TTS provider: install `neutts` separately with `python -m pip install -U neutts[all]`. On first use it downloads the model automatically.


`discord.py[voice]` installs **PyNaCl** (for voice encryption) and **opus bindings** automatically. This is required for Discord voice channel support.


### System Dependencies<a href="#system-dependencies" class="hash-link" aria-label="Direct link to System Dependencies" translate="no" title="Direct link to System Dependencies">​</a>


``` prism-code
# macOS
brew install portaudio ffmpeg opus
brew install espeak-ng   # for NeuTTS

# Ubuntu/Debian
sudo apt install portaudio19-dev ffmpeg libopus0
sudo apt install espeak-ng   # for NeuTTS
```


| Dependency    | Purpose                                         | Required For           |
|---------------|-------------------------------------------------|------------------------|
| **PortAudio** | Microphone input and audio playback             | CLI voice mode         |
| **ffmpeg**    | Audio format conversion (MP3 → Opus, PCM → WAV) | All platforms          |
| **Opus**      | Discord voice codec                             | Discord voice channels |
| **espeak-ng** | Phonemizer backend                              | Local NeuTTS provider  |

### API Keys<a href="#api-keys" class="hash-link" aria-label="Direct link to API Keys" translate="no" title="Direct link to API Keys">​</a>

Add to `~/.hermes/.env`:


``` prism-code
# Speech-to-Text — local provider needs NO key at all
# pip install faster-whisper          # Free, runs locally, recommended
GROQ_API_KEY=your-key                 # Groq Whisper — fast, free tier (cloud)
VOICE_TOOLS_OPENAI_KEY=your-key       # OpenAI Whisper — paid (cloud)

# Text-to-Speech (optional — Edge TTS and NeuTTS work without any key)
ELEVENLABS_API_KEY=***           # ElevenLabs — premium quality
# VOICE_TOOLS_OPENAI_KEY above also enables OpenAI TTS
```


If `faster-whisper` is installed, voice mode works with **zero API keys** for STT. The model (~150 MB for `base`) downloads automatically on first use.


------------------------------------------------------------------------

## CLI Voice Mode<a href="#cli-voice-mode" class="hash-link" aria-label="Direct link to CLI Voice Mode" translate="no" title="Direct link to CLI Voice Mode">​</a>

### Quick Start<a href="#quick-start" class="hash-link" aria-label="Direct link to Quick Start" translate="no" title="Direct link to Quick Start">​</a>

Start the CLI and enable voice mode:


``` prism-code
hermes                # Start the interactive CLI
```


Then use these commands inside the CLI:


``` prism-code
/voice          Toggle voice mode on/off
/voice on       Enable voice mode
/voice off      Disable voice mode
/voice tts      Toggle TTS output
/voice status   Show current state
```


### How It Works<a href="#how-it-works" class="hash-link" aria-label="Direct link to How It Works" translate="no" title="Direct link to How It Works">​</a>

1.  Start the CLI with `hermes` and enable voice mode with `/voice on`
2.  **Press Ctrl+B** — a beep plays (880Hz), recording starts
3.  **Speak** — a live audio level bar shows your input: `● [▁▂▃▅▇▇▅▂] ❯`
4.  **Stop speaking** — after 3 seconds of silence, recording auto-stops
5.  **Two beeps** play (660Hz) confirming the recording ended
6.  Audio is transcribed via Whisper and sent to the agent
7.  If TTS is enabled, the agent's reply is spoken aloud
8.  Recording **automatically restarts** — speak again without pressing any key

This loop continues until you press **Ctrl+B** during recording (exits continuous mode) or 3 consecutive recordings detect no speech.


The record key is configurable via `voice.record_key` in `~/.hermes/config.yaml` (default: `ctrl+b`).


### Silence Detection<a href="#silence-detection" class="hash-link" aria-label="Direct link to Silence Detection" translate="no" title="Direct link to Silence Detection">​</a>

Two-stage algorithm detects when you've finished speaking:

1.  **Speech confirmation** — waits for audio above the RMS threshold (200) for at least 0.3s, tolerating brief dips between syllables
2.  **End detection** — once speech is confirmed, triggers after 3.0 seconds of continuous silence

If no speech is detected at all for 15 seconds, recording stops automatically.

Both `silence_threshold` and `silence_duration` are configurable in `config.yaml`. You can also disable the record start/stop beeps with `voice.beep_enabled: false`.

### Streaming TTS<a href="#streaming-tts" class="hash-link" aria-label="Direct link to Streaming TTS" translate="no" title="Direct link to Streaming TTS">​</a>

When TTS is enabled, the agent speaks its reply **sentence-by-sentence** as it generates text — you don't wait for the full response:

1.  Buffers text deltas into complete sentences (min 20 chars)
2.  Strips markdown formatting and `<think>` blocks
3.  Generates and plays audio per sentence in real-time

### Hallucination Filter<a href="#hallucination-filter" class="hash-link" aria-label="Direct link to Hallucination Filter" translate="no" title="Direct link to Hallucination Filter">​</a>

Whisper sometimes generates phantom text from silence or background noise ("Thank you for watching", "Subscribe", etc.). The agent filters these out using a set of 26 known hallucination phrases across multiple languages, plus a regex pattern that catches repetitive variations.

------------------------------------------------------------------------

## Gateway Voice Reply (Telegram & Discord)<a href="#gateway-voice-reply-telegram--discord" class="hash-link" aria-label="Direct link to Gateway Voice Reply (Telegram &amp; Discord)" translate="no" title="Direct link to Gateway Voice Reply (Telegram &amp; Discord)">​</a>

If you haven't set up your messaging bots yet, see the platform-specific guides:

- [Telegram Setup Guide](/docs/user-guide/messaging/telegram)
- [Discord Setup Guide](/docs/user-guide/messaging/discord)

Start the gateway to connect to your messaging platforms:


``` prism-code
hermes gateway        # Start the gateway (connects to configured platforms)
hermes gateway setup  # Interactive setup wizard for first-time configuration
```


### Discord: Channels vs DMs<a href="#discord-channels-vs-dms" class="hash-link" aria-label="Direct link to Discord: Channels vs DMs" translate="no" title="Direct link to Discord: Channels vs DMs">​</a>

The bot supports two interaction modes on Discord:

| Mode                    | How to Talk                                     | Mention Required | Setup                             |
|-------------------------|-------------------------------------------------|------------------|-----------------------------------|
| **Direct Message (DM)** | Open the bot's profile → "Message"              | No               | Works immediately                 |
| **Server Channel**      | Type in a text channel where the bot is present | Yes (`@botname`) | Bot must be invited to the server |

**DM (recommended for personal use):** Just open a DM with the bot and type — no @mention needed. Voice replies and all commands work the same as in channels.

**Server channels:** The bot only responds when you @mention it (e.g. `@hermesbyt4 hello`). Make sure you select the **bot user** from the mention popup, not the role with the same name.


To disable the mention requirement in server channels, add to `~/.hermes/.env`:


``` prism-code
DISCORD_REQUIRE_MENTION=false
```


Or set specific channels as free-response (no mention needed):


``` prism-code
DISCORD_FREE_RESPONSE_CHANNELS=123456789,987654321
```


### Commands<a href="#commands" class="hash-link" aria-label="Direct link to Commands" translate="no" title="Direct link to Commands">​</a>

These work in both Telegram and Discord (DMs and text channels):


``` prism-code
/voice          Toggle voice mode on/off
/voice on       Voice replies only when you send a voice message
/voice tts      Voice replies for ALL messages
/voice off      Disable voice replies
/voice status   Show current setting
```


### Modes<a href="#modes" class="hash-link" aria-label="Direct link to Modes" translate="no" title="Direct link to Modes">​</a>

| Mode         | Command      | Behavior                                        |
|--------------|--------------|-------------------------------------------------|
| `off`        | `/voice off` | Text only (default)                             |
| `voice_only` | `/voice on`  | Speaks reply only when you send a voice message |
| `all`        | `/voice tts` | Speaks reply to every message                   |

Voice mode setting is persisted across gateway restarts.

### Platform Delivery<a href="#platform-delivery" class="hash-link" aria-label="Direct link to Platform Delivery" translate="no" title="Direct link to Platform Delivery">​</a>

| Platform     | Format                         | Notes                                                                                           |
|--------------|--------------------------------|-------------------------------------------------------------------------------------------------|
| **Telegram** | Voice bubble (Opus/OGG)        | Plays inline in chat. ffmpeg converts MP3 → Opus if needed                                      |
| **Discord**  | Native voice bubble (Opus/OGG) | Plays inline like a user voice message. Falls back to file attachment if voice bubble API fails |

------------------------------------------------------------------------

## Discord Voice Channels<a href="#discord-voice-channels" class="hash-link" aria-label="Direct link to Discord Voice Channels" translate="no" title="Direct link to Discord Voice Channels">​</a>

The most immersive voice feature: the bot joins a Discord voice channel, listens to users speaking, transcribes their speech, processes through the agent, and speaks the reply back in the voice channel.

### Setup<a href="#setup" class="hash-link" aria-label="Direct link to Setup" translate="no" title="Direct link to Setup">​</a>

#### 1. Discord Bot Permissions<a href="#1-discord-bot-permissions" class="hash-link" aria-label="Direct link to 1. Discord Bot Permissions" translate="no" title="Direct link to 1. Discord Bot Permissions">​</a>

If you already have a Discord bot set up for text (see [Discord Setup Guide](/docs/user-guide/messaging/discord)), you need to add voice permissions.

Go to the <a href="https://discord.com/developers/applications" target="_blank" rel="noopener noreferrer">Discord Developer Portal</a> → your application → **Installation** → **Default Install Settings** → **Guild Install**:

**Add these permissions to the existing text permissions:**

| Permission             | Purpose                          | Required    |
|------------------------|----------------------------------|-------------|
| **Connect**            | Join voice channels              | Yes         |
| **Speak**              | Play TTS audio in voice channels | Yes         |
| **Use Voice Activity** | Detect when users are speaking   | Recommended |

**Updated Permissions Integer:**

| Level        | Integer        | What's Included                                                                     |
|--------------|----------------|-------------------------------------------------------------------------------------|
| Text only    | `274878286912` | View Channels, Send Messages, Read History, Embeds, Attachments, Threads, Reactions |
| Text + Voice | `274881432640` | All above + Connect, Speak                                                          |

**Re-invite the bot** with the updated permissions URL:


``` prism-code
https://discord.com/oauth2/authorize?client_id=YOUR_APP_ID&scope=bot+applications.commands&permissions=274881432640
```


Replace `YOUR_APP_ID` with your Application ID from the Developer Portal.


Re-inviting the bot to a server it's already in will update its permissions without removing it. You won't lose any data or configuration.


#### 2. Privileged Gateway Intents<a href="#2-privileged-gateway-intents" class="hash-link" aria-label="Direct link to 2. Privileged Gateway Intents" translate="no" title="Direct link to 2. Privileged Gateway Intents">​</a>

In the <a href="https://discord.com/developers/applications" target="_blank" rel="noopener noreferrer">Developer Portal</a> → your application → **Bot** → **Privileged Gateway Intents**, enable all three:

| Intent                     | Purpose                                        |
|----------------------------|------------------------------------------------|
| **Presence Intent**        | Detect user online/offline status              |
| **Server Members Intent**  | Map voice SSRC identifiers to Discord user IDs |
| **Message Content Intent** | Read text message content in channels          |

All three are required for full voice channel functionality. **Server Members Intent** is especially critical — without it, the bot cannot identify who is speaking in the voice channel.

#### 3. Opus Codec<a href="#3-opus-codec" class="hash-link" aria-label="Direct link to 3. Opus Codec" translate="no" title="Direct link to 3. Opus Codec">​</a>

The Opus codec library must be installed on the machine running the gateway:


``` prism-code
# macOS (Homebrew)
brew install opus

# Ubuntu/Debian
sudo apt install libopus0
```


The bot auto-loads the codec from:

- **macOS:** `/opt/homebrew/lib/libopus.dylib`
- **Linux:** `libopus.so.0`

#### 4. Environment Variables<a href="#4-environment-variables" class="hash-link" aria-label="Direct link to 4. Environment Variables" translate="no" title="Direct link to 4. Environment Variables">​</a>


``` prism-code
# ~/.hermes/.env

# Discord bot (already configured for text)
DISCORD_BOT_TOKEN=your-bot-token
DISCORD_ALLOWED_USERS=your-user-id

# STT — local provider needs no key (pip install faster-whisper)
# GROQ_API_KEY=your-key            # Alternative: cloud-based, fast, free tier

# TTS — optional. Edge TTS and NeuTTS need no key.
# ELEVENLABS_API_KEY=***      # Premium quality
# VOICE_TOOLS_OPENAI_KEY=***  # OpenAI TTS / Whisper
```


### Start the Gateway<a href="#start-the-gateway" class="hash-link" aria-label="Direct link to Start the Gateway" translate="no" title="Direct link to Start the Gateway">​</a>


``` prism-code
hermes gateway        # Start with existing configuration
```


The bot should come online in Discord within a few seconds.

### Commands<a href="#commands-1" class="hash-link" aria-label="Direct link to Commands" translate="no" title="Direct link to Commands">​</a>

Use these in the Discord text channel where the bot is present:


``` prism-code
/voice join      Bot joins your current voice channel
/voice channel   Alias for /voice join
/voice leave     Bot disconnects from voice channel
/voice status    Show voice mode and connected channel
```


You must be in a voice channel before running `/voice join`. The bot joins the same VC you're in.


### How It Works<a href="#how-it-works-1" class="hash-link" aria-label="Direct link to How It Works" translate="no" title="Direct link to How It Works">​</a>

When the bot joins a voice channel, it:

1.  **Listens** to each user's audio stream independently
2.  **Detects silence** — 1.5s of silence after at least 0.5s of speech triggers processing
3.  **Transcribes** the audio via Whisper STT (local, Groq, or OpenAI)
4.  **Processes** through the full agent pipeline (session, tools, memory)
5.  **Speaks** the reply back in the voice channel via TTS

### Text Channel Integration<a href="#text-channel-integration" class="hash-link" aria-label="Direct link to Text Channel Integration" translate="no" title="Direct link to Text Channel Integration">​</a>

When the bot is in a voice channel:

- Transcripts appear in the text channel: `[Voice] @user: what you said`
- Agent responses are sent as text in the channel AND spoken in the VC
- The text channel is the one where `/voice join` was issued

### Echo Prevention<a href="#echo-prevention" class="hash-link" aria-label="Direct link to Echo Prevention" translate="no" title="Direct link to Echo Prevention">​</a>

The bot automatically pauses its audio listener while playing TTS replies, preventing it from hearing and re-processing its own output.

### Access Control<a href="#access-control" class="hash-link" aria-label="Direct link to Access Control" translate="no" title="Direct link to Access Control">​</a>

Only users listed in `DISCORD_ALLOWED_USERS` can interact via voice. Other users' audio is silently ignored.


``` prism-code
# ~/.hermes/.env
DISCORD_ALLOWED_USERS=284102345871466496
```


------------------------------------------------------------------------

## Configuration Reference<a href="#configuration-reference" class="hash-link" aria-label="Direct link to Configuration Reference" translate="no" title="Direct link to Configuration Reference">​</a>

### config.yaml<a href="#configyaml" class="hash-link" aria-label="Direct link to config.yaml" translate="no" title="Direct link to config.yaml">​</a>


``` prism-code
# Voice recording (CLI)
voice:
  record_key: "ctrl+b"            # Key to start/stop recording
  max_recording_seconds: 120       # Maximum recording length
  auto_tts: false                  # Auto-enable TTS when voice mode starts
  beep_enabled: true               # Play record start/stop beeps
  silence_threshold: 200           # RMS level (0-32767) below which counts as silence
  silence_duration: 3.0            # Seconds of silence before auto-stop

# Speech-to-Text
stt:
  provider: "local"                  # "local" (free) | "groq" | "openai"
  local:
    model: "base"                    # tiny, base, small, medium, large-v3
  # model: "whisper-1"              # Legacy: used when provider is not set

# Text-to-Speech
tts:
  provider: "edge"                 # "edge" (free) | "elevenlabs" | "openai" | "neutts" | "minimax"
  edge:
    voice: "en-US-AriaNeural"      # 322 voices, 74 languages
  elevenlabs:
    voice_id: "pNInz6obpgDQGcFmaJgB"    # Adam
    model_id: "eleven_multilingual_v2"
  openai:
    model: "gpt-4o-mini-tts"
    voice: "alloy"                 # alloy, echo, fable, onyx, nova, shimmer
    base_url: "https://api.openai.com/v1"  # optional: override for self-hosted or OpenAI-compatible endpoints
  neutts:
    ref_audio: ''
    ref_text: ''
    model: neuphonic/neutts-air-q4-gguf
    device: cpu
```


### Environment Variables<a href="#environment-variables" class="hash-link" aria-label="Direct link to Environment Variables" translate="no" title="Direct link to Environment Variables">​</a>


``` prism-code
# Speech-to-Text providers (local needs no key)
# pip install faster-whisper        # Free local STT — no API key needed
GROQ_API_KEY=...                    # Groq Whisper (fast, free tier)
VOICE_TOOLS_OPENAI_KEY=...         # OpenAI Whisper (paid)

# STT advanced overrides (optional)
STT_GROQ_MODEL=whisper-large-v3-turbo    # Override default Groq STT model
STT_OPENAI_MODEL=whisper-1               # Override default OpenAI STT model
GROQ_BASE_URL=https://api.groq.com/openai/v1     # Custom Groq endpoint
STT_OPENAI_BASE_URL=https://api.openai.com/v1    # Custom OpenAI STT endpoint

# Text-to-Speech providers (Edge TTS and NeuTTS need no key)
ELEVENLABS_API_KEY=***             # ElevenLabs (premium quality)
# VOICE_TOOLS_OPENAI_KEY above also enables OpenAI TTS

# Discord voice channel
DISCORD_BOT_TOKEN=...
DISCORD_ALLOWED_USERS=...
```


### STT Provider Comparison<a href="#stt-provider-comparison" class="hash-link" aria-label="Direct link to STT Provider Comparison" translate="no" title="Direct link to STT Provider Comparison">​</a>

| Provider   | Model                    | Speed                     | Quality | Cost      | API Key |
|------------|--------------------------|---------------------------|---------|-----------|---------|
| **Local**  | `base`                   | Fast (depends on CPU/GPU) | Good    | Free      | No      |
| **Local**  | `small`                  | Medium                    | Better  | Free      | No      |
| **Local**  | `large-v3`               | Slow                      | Best    | Free      | No      |
| **Groq**   | `whisper-large-v3-turbo` | Very fast (~0.5s)         | Good    | Free tier | Yes     |
| **Groq**   | `whisper-large-v3`       | Fast (~1s)                | Better  | Free tier | Yes     |
| **OpenAI** | `whisper-1`              | Fast (~1s)                | Good    | Paid      | Yes     |
| **OpenAI** | `gpt-4o-transcribe`      | Medium (~2s)              | Best    | Paid      | Yes     |

Provider priority (automatic fallback): **local** \> **groq** \> **openai**

### TTS Provider Comparison<a href="#tts-provider-comparison" class="hash-link" aria-label="Direct link to TTS Provider Comparison" translate="no" title="Direct link to TTS Provider Comparison">​</a>

| Provider       | Quality   | Cost | Latency            | Key Required |
|----------------|-----------|------|--------------------|--------------|
| **Edge TTS**   | Good      | Free | ~1s                | No           |
| **ElevenLabs** | Excellent | Paid | ~2s                | Yes          |
| **OpenAI TTS** | Good      | Paid | ~1.5s              | Yes          |
| **NeuTTS**     | Good      | Free | Depends on CPU/GPU | No           |

NeuTTS uses the `tts.neutts` config block above.

------------------------------------------------------------------------

## Troubleshooting<a href="#troubleshooting" class="hash-link" aria-label="Direct link to Troubleshooting" translate="no" title="Direct link to Troubleshooting">​</a>

### "No audio device found" (CLI)<a href="#no-audio-device-found-cli" class="hash-link" aria-label="Direct link to &quot;No audio device found&quot; (CLI)" translate="no" title="Direct link to &quot;No audio device found&quot; (CLI)">​</a>

PortAudio is not installed:


``` prism-code
brew install portaudio    # macOS
sudo apt install portaudio19-dev  # Ubuntu
```


### Bot doesn't respond in Discord server channels<a href="#bot-doesnt-respond-in-discord-server-channels" class="hash-link" aria-label="Direct link to Bot doesn&#39;t respond in Discord server channels" translate="no" title="Direct link to Bot doesn&#39;t respond in Discord server channels">​</a>

The bot requires an @mention by default in server channels. Make sure you:

1.  Type `@` and select the **bot user** (with the \#discriminator), not the **role** with the same name
2.  Or use DMs instead — no mention needed
3.  Or set `DISCORD_REQUIRE_MENTION=false` in `~/.hermes/.env`

### Bot joins VC but doesn't hear me<a href="#bot-joins-vc-but-doesnt-hear-me" class="hash-link" aria-label="Direct link to Bot joins VC but doesn&#39;t hear me" translate="no" title="Direct link to Bot joins VC but doesn&#39;t hear me">​</a>

- Check your Discord user ID is in `DISCORD_ALLOWED_USERS`
- Make sure you're not muted in Discord
- The bot needs a SPEAKING event from Discord before it can map your audio — start speaking within a few seconds of joining

### Bot hears me but doesn't respond<a href="#bot-hears-me-but-doesnt-respond" class="hash-link" aria-label="Direct link to Bot hears me but doesn&#39;t respond" translate="no" title="Direct link to Bot hears me but doesn&#39;t respond">​</a>

- Verify STT is available: install `faster-whisper` (no key needed) or set `GROQ_API_KEY` / `VOICE_TOOLS_OPENAI_KEY`
- Check the LLM model is configured and accessible
- Review gateway logs: `tail -f ~/.hermes/logs/gateway.log`

### Bot responds in text but not in voice channel<a href="#bot-responds-in-text-but-not-in-voice-channel" class="hash-link" aria-label="Direct link to Bot responds in text but not in voice channel" translate="no" title="Direct link to Bot responds in text but not in voice channel">​</a>

- TTS provider may be failing — check API key and quota
- Edge TTS (free, no key) is the default fallback
- Check logs for TTS errors

### Whisper returns garbage text<a href="#whisper-returns-garbage-text" class="hash-link" aria-label="Direct link to Whisper returns garbage text" translate="no" title="Direct link to Whisper returns garbage text">​</a>

The hallucination filter catches most cases automatically. If you're still getting phantom transcripts:

- Use a quieter environment
- Adjust `silence_threshold` in config (higher = less sensitive)
- Try a different STT model


- <a href="#prerequisites" class="table-of-contents__link toc-highlight">Prerequisites</a>
- <a href="#overview" class="table-of-contents__link toc-highlight">Overview</a>
- <a href="#requirements" class="table-of-contents__link toc-highlight">Requirements</a>
  - <a href="#python-packages" class="table-of-contents__link toc-highlight">Python Packages</a>
  - <a href="#system-dependencies" class="table-of-contents__link toc-highlight">System Dependencies</a>
  - <a href="#api-keys" class="table-of-contents__link toc-highlight">API Keys</a>
- <a href="#cli-voice-mode" class="table-of-contents__link toc-highlight">CLI Voice Mode</a>
  - <a href="#quick-start" class="table-of-contents__link toc-highlight">Quick Start</a>
  - <a href="#how-it-works" class="table-of-contents__link toc-highlight">How It Works</a>
  - <a href="#silence-detection" class="table-of-contents__link toc-highlight">Silence Detection</a>
  - <a href="#streaming-tts" class="table-of-contents__link toc-highlight">Streaming TTS</a>
  - <a href="#hallucination-filter" class="table-of-contents__link toc-highlight">Hallucination Filter</a>
- <a href="#gateway-voice-reply-telegram--discord" class="table-of-contents__link toc-highlight">Gateway Voice Reply (Telegram &amp; Discord)</a>
  - <a href="#discord-channels-vs-dms" class="table-of-contents__link toc-highlight">Discord: Channels vs DMs</a>
  - <a href="#commands" class="table-of-contents__link toc-highlight">Commands</a>
  - <a href="#modes" class="table-of-contents__link toc-highlight">Modes</a>
  - <a href="#platform-delivery" class="table-of-contents__link toc-highlight">Platform Delivery</a>
- <a href="#discord-voice-channels" class="table-of-contents__link toc-highlight">Discord Voice Channels</a>
  - <a href="#setup" class="table-of-contents__link toc-highlight">Setup</a>
  - <a href="#start-the-gateway" class="table-of-contents__link toc-highlight">Start the Gateway</a>
  - <a href="#commands-1" class="table-of-contents__link toc-highlight">Commands</a>
  - <a href="#how-it-works-1" class="table-of-contents__link toc-highlight">How It Works</a>
  - <a href="#text-channel-integration" class="table-of-contents__link toc-highlight">Text Channel Integration</a>
  - <a href="#echo-prevention" class="table-of-contents__link toc-highlight">Echo Prevention</a>
  - <a href="#access-control" class="table-of-contents__link toc-highlight">Access Control</a>
- <a href="#configuration-reference" class="table-of-contents__link toc-highlight">Configuration Reference</a>
  - <a href="#configyaml" class="table-of-contents__link toc-highlight">config.yaml</a>
  - <a href="#environment-variables" class="table-of-contents__link toc-highlight">Environment Variables</a>
  - <a href="#stt-provider-comparison" class="table-of-contents__link toc-highlight">STT Provider Comparison</a>
  - <a href="#tts-provider-comparison" class="table-of-contents__link toc-highlight">TTS Provider Comparison</a>
- <a href="#troubleshooting" class="table-of-contents__link toc-highlight">Troubleshooting</a>
  - <a href="#no-audio-device-found-cli" class="table-of-contents__link toc-highlight">"No audio device found" (CLI)</a>
  - <a href="#bot-doesnt-respond-in-discord-server-channels" class="table-of-contents__link toc-highlight">Bot doesn't respond in Discord server channels</a>
  - <a href="#bot-joins-vc-but-doesnt-hear-me" class="table-of-contents__link toc-highlight">Bot joins VC but doesn't hear me</a>
  - <a href="#bot-hears-me-but-doesnt-respond" class="table-of-contents__link toc-highlight">Bot hears me but doesn't respond</a>
  - <a href="#bot-responds-in-text-but-not-in-voice-channel" class="table-of-contents__link toc-highlight">Bot responds in text but not in voice channel</a>
  - <a href="#whisper-returns-garbage-text" class="table-of-contents__link toc-highlight">Whisper returns garbage text</a>


