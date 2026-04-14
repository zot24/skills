> Source: https://hermes-agent.nousresearch.com/docs/guides/use-voice-mode-with-hermes/



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_fXgn">Skip to main content</a>


On this page


# Use Voice Mode with Hermes


This guide is the practical companion to the [Voice Mode feature reference](/docs/user-guide/features/voice-mode).

If the feature page explains what voice mode can do, this guide shows how to actually use it well.

## What voice mode is good for<a href="#what-voice-mode-is-good-for" class="hash-link" aria-label="Direct link to What voice mode is good for" translate="no" title="Direct link to What voice mode is good for">​</a>

Voice mode is especially useful when:

- you want a hands-free CLI workflow
- you want spoken responses in Telegram or Discord
- you want Hermes sitting in a Discord voice channel for live conversation
- you want quick idea capture, debugging, or back-and-forth while walking around instead of typing

## Choose your voice mode setup<a href="#choose-your-voice-mode-setup" class="hash-link" aria-label="Direct link to Choose your voice mode setup" translate="no" title="Direct link to Choose your voice mode setup">​</a>

There are really three different voice experiences in Hermes.

| Mode                        | Best for                                            | Platform               |
|-----------------------------|-----------------------------------------------------|------------------------|
| Interactive microphone loop | Personal hands-free use while coding or researching | CLI                    |
| Voice replies in chat       | Spoken responses alongside normal messaging         | Telegram, Discord      |
| Live voice channel bot      | Group or personal live conversation in a VC         | Discord voice channels |

A good path is:

1.  get text working first
2.  enable voice replies second
3.  move to Discord voice channels last if you want the full experience

## Step 1: make sure normal Hermes works first<a href="#step-1-make-sure-normal-hermes-works-first" class="hash-link" aria-label="Direct link to Step 1: make sure normal Hermes works first" translate="no" title="Direct link to Step 1: make sure normal Hermes works first">​</a>

Before touching voice mode, verify that:

- Hermes starts
- your provider is configured
- the agent can answer text prompts normally


``` prism-code
hermes
```


Ask something simple:


``` prism-code
What tools do you have available?
```


If that is not solid yet, fix text mode first.

## Step 2: install the right extras<a href="#step-2-install-the-right-extras" class="hash-link" aria-label="Direct link to Step 2: install the right extras" translate="no" title="Direct link to Step 2: install the right extras">​</a>

### CLI microphone + playback<a href="#cli-microphone--playback" class="hash-link" aria-label="Direct link to CLI microphone + playback" translate="no" title="Direct link to CLI microphone + playback">​</a>


``` prism-code
pip install "hermes-agent[voice]"
```


### Messaging platforms<a href="#messaging-platforms" class="hash-link" aria-label="Direct link to Messaging platforms" translate="no" title="Direct link to Messaging platforms">​</a>


``` prism-code
pip install "hermes-agent[messaging]"
```


### Premium ElevenLabs TTS<a href="#premium-elevenlabs-tts" class="hash-link" aria-label="Direct link to Premium ElevenLabs TTS" translate="no" title="Direct link to Premium ElevenLabs TTS">​</a>


``` prism-code
pip install "hermes-agent[tts-premium]"
```


### Local NeuTTS (optional)<a href="#local-neutts-optional" class="hash-link" aria-label="Direct link to Local NeuTTS (optional)" translate="no" title="Direct link to Local NeuTTS (optional)">​</a>


``` prism-code
python -m pip install -U neutts[all]
```


### Everything<a href="#everything" class="hash-link" aria-label="Direct link to Everything" translate="no" title="Direct link to Everything">​</a>


``` prism-code
pip install "hermes-agent[all]"
```


## Step 3: install system dependencies<a href="#step-3-install-system-dependencies" class="hash-link" aria-label="Direct link to Step 3: install system dependencies" translate="no" title="Direct link to Step 3: install system dependencies">​</a>

### macOS<a href="#macos" class="hash-link" aria-label="Direct link to macOS" translate="no" title="Direct link to macOS">​</a>


``` prism-code
brew install portaudio ffmpeg opus
brew install espeak-ng
```


### Ubuntu / Debian<a href="#ubuntu--debian" class="hash-link" aria-label="Direct link to Ubuntu / Debian" translate="no" title="Direct link to Ubuntu / Debian">​</a>


``` prism-code
sudo apt install portaudio19-dev ffmpeg libopus0
sudo apt install espeak-ng
```


Why these matter:

- `portaudio` → microphone input / playback for CLI voice mode
- `ffmpeg` → audio conversion for TTS and messaging delivery
- `opus` → Discord voice codec support
- `espeak-ng` → phonemizer backend for NeuTTS

## Step 4: choose STT and TTS providers<a href="#step-4-choose-stt-and-tts-providers" class="hash-link" aria-label="Direct link to Step 4: choose STT and TTS providers" translate="no" title="Direct link to Step 4: choose STT and TTS providers">​</a>

Hermes supports both local and cloud speech stacks.

### Easiest / cheapest setup<a href="#easiest--cheapest-setup" class="hash-link" aria-label="Direct link to Easiest / cheapest setup" translate="no" title="Direct link to Easiest / cheapest setup">​</a>

Use local STT and free Edge TTS:

- STT provider: `local`
- TTS provider: `edge`

This is usually the best place to start.

### Environment file example<a href="#environment-file-example" class="hash-link" aria-label="Direct link to Environment file example" translate="no" title="Direct link to Environment file example">​</a>

Add to `~/.hermes/.env`:


``` prism-code
# Cloud STT options (local needs no key)
GROQ_API_KEY=***
VOICE_TOOLS_OPENAI_KEY=***

# Premium TTS (optional)
ELEVENLABS_API_KEY=***
```


### Provider recommendations<a href="#provider-recommendations" class="hash-link" aria-label="Direct link to Provider recommendations" translate="no" title="Direct link to Provider recommendations">​</a>

#### Speech-to-text<a href="#speech-to-text" class="hash-link" aria-label="Direct link to Speech-to-text" translate="no" title="Direct link to Speech-to-text">​</a>

- `local` → best default for privacy and zero-cost use
- `groq` → very fast cloud transcription
- `openai` → good paid fallback

#### Text-to-speech<a href="#text-to-speech" class="hash-link" aria-label="Direct link to Text-to-speech" translate="no" title="Direct link to Text-to-speech">​</a>

- `edge` → free and good enough for most users
- `neutts` → free local/on-device TTS
- `elevenlabs` → best quality
- `openai` → good middle ground
- `mistral` → multilingual, native Opus

### If you use `hermes setup`<a href="#if-you-use-hermes-setup" class="hash-link" aria-label="Direct link to if-you-use-hermes-setup" translate="no" title="Direct link to if-you-use-hermes-setup">​</a>

If you choose NeuTTS in the setup wizard, Hermes checks whether `neutts` is already installed. If it is missing, the wizard tells you NeuTTS needs the Python package `neutts` and the system package `espeak-ng`, offers to install them for you, installs `espeak-ng` with your platform package manager, and then runs:


``` prism-code
python -m pip install -U neutts[all]
```


If you skip that install or it fails, the wizard falls back to Edge TTS.

## Step 5: recommended config<a href="#step-5-recommended-config" class="hash-link" aria-label="Direct link to Step 5: recommended config" translate="no" title="Direct link to Step 5: recommended config">​</a>


``` prism-code
voice:
  record_key: "ctrl+b"
  max_recording_seconds: 120
  auto_tts: false
  silence_threshold: 200
  silence_duration: 3.0

stt:
  provider: "local"
  local:
    model: "base"

tts:
  provider: "edge"
  edge:
    voice: "en-US-AriaNeural"
```


This is a good conservative default for most people.

If you want local TTS instead, switch the `tts` block to:


``` prism-code
tts:
  provider: "neutts"
  neutts:
    ref_audio: ''
    ref_text: ''
    model: neuphonic/neutts-air-q4-gguf
    device: cpu
```


## Use case 1: CLI voice mode<a href="#use-case-1-cli-voice-mode" class="hash-link" aria-label="Direct link to Use case 1: CLI voice mode" translate="no" title="Direct link to Use case 1: CLI voice mode">​</a>

## Turn it on<a href="#turn-it-on" class="hash-link" aria-label="Direct link to Turn it on" translate="no" title="Direct link to Turn it on">​</a>

Start Hermes:


``` prism-code
hermes
```


Inside the CLI:


``` prism-code
/voice on
```


### Recording flow<a href="#recording-flow" class="hash-link" aria-label="Direct link to Recording flow" translate="no" title="Direct link to Recording flow">​</a>

Default key:

- `Ctrl+B`

Workflow:

1.  press `Ctrl+B`
2.  speak
3.  wait for silence detection to stop recording automatically
4.  Hermes transcribes and responds
5.  if TTS is on, it speaks the answer
6.  the loop can automatically restart for continuous use

### Useful commands<a href="#useful-commands" class="hash-link" aria-label="Direct link to Useful commands" translate="no" title="Direct link to Useful commands">​</a>


``` prism-code
/voice
/voice on
/voice off
/voice tts
/voice status
```


### Good CLI workflows<a href="#good-cli-workflows" class="hash-link" aria-label="Direct link to Good CLI workflows" translate="no" title="Direct link to Good CLI workflows">​</a>

#### Walk-up debugging<a href="#walk-up-debugging" class="hash-link" aria-label="Direct link to Walk-up debugging" translate="no" title="Direct link to Walk-up debugging">​</a>

Say:


``` prism-code
I keep getting a docker permission error. Help me debug it.
```


Then continue hands-free:

- "Read the last error again"
- "Explain the root cause in simpler terms"
- "Now give me the exact fix"

#### Research / brainstorming<a href="#research--brainstorming" class="hash-link" aria-label="Direct link to Research / brainstorming" translate="no" title="Direct link to Research / brainstorming">​</a>

Great for:

- walking around while thinking
- dictating half-formed ideas
- asking Hermes to structure your thoughts in real time

#### Accessibility / low-typing sessions<a href="#accessibility--low-typing-sessions" class="hash-link" aria-label="Direct link to Accessibility / low-typing sessions" translate="no" title="Direct link to Accessibility / low-typing sessions">​</a>

If typing is inconvenient, voice mode is one of the fastest ways to stay in the full Hermes loop.

## Tuning CLI behavior<a href="#tuning-cli-behavior" class="hash-link" aria-label="Direct link to Tuning CLI behavior" translate="no" title="Direct link to Tuning CLI behavior">​</a>

### Silence threshold<a href="#silence-threshold" class="hash-link" aria-label="Direct link to Silence threshold" translate="no" title="Direct link to Silence threshold">​</a>

If Hermes starts/stops too aggressively, tune:


``` prism-code
voice:
  silence_threshold: 250
```


Higher threshold = less sensitive.

### Silence duration<a href="#silence-duration" class="hash-link" aria-label="Direct link to Silence duration" translate="no" title="Direct link to Silence duration">​</a>

If you pause a lot between sentences, increase:


``` prism-code
voice:
  silence_duration: 4.0
```


### Record key<a href="#record-key" class="hash-link" aria-label="Direct link to Record key" translate="no" title="Direct link to Record key">​</a>

If `Ctrl+B` conflicts with your terminal or tmux habits:


``` prism-code
voice:
  record_key: "ctrl+space"
```


## Use case 2: voice replies in Telegram or Discord<a href="#use-case-2-voice-replies-in-telegram-or-discord" class="hash-link" aria-label="Direct link to Use case 2: voice replies in Telegram or Discord" translate="no" title="Direct link to Use case 2: voice replies in Telegram or Discord">​</a>

This mode is simpler than full voice channels.

Hermes stays a normal chat bot, but can speak replies.

### Start the gateway<a href="#start-the-gateway" class="hash-link" aria-label="Direct link to Start the gateway" translate="no" title="Direct link to Start the gateway">​</a>


``` prism-code
hermes gateway
```


### Turn on voice replies<a href="#turn-on-voice-replies" class="hash-link" aria-label="Direct link to Turn on voice replies" translate="no" title="Direct link to Turn on voice replies">​</a>

Inside Telegram or Discord:


``` prism-code
/voice on
```


or


``` prism-code
/voice tts
```


### Modes<a href="#modes" class="hash-link" aria-label="Direct link to Modes" translate="no" title="Direct link to Modes">​</a>

| Mode         | Meaning                             |
|--------------|-------------------------------------|
| `off`        | text only                           |
| `voice_only` | speak only when the user sent voice |
| `all`        | speak every reply                   |

### When to use which mode<a href="#when-to-use-which-mode" class="hash-link" aria-label="Direct link to When to use which mode" translate="no" title="Direct link to When to use which mode">​</a>

- `/voice on` if you want spoken replies only for voice-originating messages
- `/voice tts` if you want a full spoken assistant all the time

### Good messaging workflows<a href="#good-messaging-workflows" class="hash-link" aria-label="Direct link to Good messaging workflows" translate="no" title="Direct link to Good messaging workflows">​</a>

#### Telegram assistant on your phone<a href="#telegram-assistant-on-your-phone" class="hash-link" aria-label="Direct link to Telegram assistant on your phone" translate="no" title="Direct link to Telegram assistant on your phone">​</a>

Use when:

- you are away from your machine
- you want to send voice notes and get quick spoken replies
- you want Hermes to function like a portable research or ops assistant

#### Discord DMs with spoken output<a href="#discord-dms-with-spoken-output" class="hash-link" aria-label="Direct link to Discord DMs with spoken output" translate="no" title="Direct link to Discord DMs with spoken output">​</a>

Useful when you want private interaction without server-channel mention behavior.

## Use case 3: Discord voice channels<a href="#use-case-3-discord-voice-channels" class="hash-link" aria-label="Direct link to Use case 3: Discord voice channels" translate="no" title="Direct link to Use case 3: Discord voice channels">​</a>

This is the most advanced mode.

Hermes joins a Discord VC, listens to user speech, transcribes it, runs the normal agent pipeline, and speaks replies back into the channel.

## Required Discord permissions<a href="#required-discord-permissions" class="hash-link" aria-label="Direct link to Required Discord permissions" translate="no" title="Direct link to Required Discord permissions">​</a>

In addition to the normal text-bot setup, make sure the bot has:

- Connect
- Speak
- preferably Use Voice Activity

Also enable privileged intents in the Developer Portal:

- Presence Intent
- Server Members Intent
- Message Content Intent

## Join and leave<a href="#join-and-leave" class="hash-link" aria-label="Direct link to Join and leave" translate="no" title="Direct link to Join and leave">​</a>

In a Discord text channel where the bot is present:


``` prism-code
/voice join
/voice leave
/voice status
```


### What happens when joined<a href="#what-happens-when-joined" class="hash-link" aria-label="Direct link to What happens when joined" translate="no" title="Direct link to What happens when joined">​</a>

- users speak in the VC
- Hermes detects speech boundaries
- transcripts are posted in the associated text channel
- Hermes responds in text and audio
- the text channel is the one where `/voice join` was issued

### Best practices for Discord VC use<a href="#best-practices-for-discord-vc-use" class="hash-link" aria-label="Direct link to Best practices for Discord VC use" translate="no" title="Direct link to Best practices for Discord VC use">​</a>

- keep `DISCORD_ALLOWED_USERS` tight
- use a dedicated bot/testing channel at first
- verify STT and TTS work in ordinary text-chat voice mode before trying VC mode

## Voice quality recommendations<a href="#voice-quality-recommendations" class="hash-link" aria-label="Direct link to Voice quality recommendations" translate="no" title="Direct link to Voice quality recommendations">​</a>

### Best quality setup<a href="#best-quality-setup" class="hash-link" aria-label="Direct link to Best quality setup" translate="no" title="Direct link to Best quality setup">​</a>

- STT: local `large-v3` or Groq `whisper-large-v3`
- TTS: ElevenLabs

### Best speed / convenience setup<a href="#best-speed--convenience-setup" class="hash-link" aria-label="Direct link to Best speed / convenience setup" translate="no" title="Direct link to Best speed / convenience setup">​</a>

- STT: local `base` or Groq
- TTS: Edge

### Best zero-cost setup<a href="#best-zero-cost-setup" class="hash-link" aria-label="Direct link to Best zero-cost setup" translate="no" title="Direct link to Best zero-cost setup">​</a>

- STT: local
- TTS: Edge

## Common failure modes<a href="#common-failure-modes" class="hash-link" aria-label="Direct link to Common failure modes" translate="no" title="Direct link to Common failure modes">​</a>

### "No audio device found"<a href="#no-audio-device-found" class="hash-link" aria-label="Direct link to &quot;No audio device found&quot;" translate="no" title="Direct link to &quot;No audio device found&quot;">​</a>

Install `portaudio`.

### "Bot joins but hears nothing"<a href="#bot-joins-but-hears-nothing" class="hash-link" aria-label="Direct link to &quot;Bot joins but hears nothing&quot;" translate="no" title="Direct link to &quot;Bot joins but hears nothing&quot;">​</a>

Check:

- your Discord user ID is in `DISCORD_ALLOWED_USERS`
- you are not muted
- privileged intents are enabled
- the bot has Connect/Speak permissions

### "It transcribes but does not speak"<a href="#it-transcribes-but-does-not-speak" class="hash-link" aria-label="Direct link to &quot;It transcribes but does not speak&quot;" translate="no" title="Direct link to &quot;It transcribes but does not speak&quot;">​</a>

Check:

- TTS provider config
- API key / quota for ElevenLabs or OpenAI
- `ffmpeg` install for Edge conversion paths

### "Whisper outputs garbage"<a href="#whisper-outputs-garbage" class="hash-link" aria-label="Direct link to &quot;Whisper outputs garbage&quot;" translate="no" title="Direct link to &quot;Whisper outputs garbage&quot;">​</a>

Try:

- quieter environment
- higher `silence_threshold`
- different STT provider/model
- shorter, clearer utterances

### "It works in DMs but not in server channels"<a href="#it-works-in-dms-but-not-in-server-channels" class="hash-link" aria-label="Direct link to &quot;It works in DMs but not in server channels&quot;" translate="no" title="Direct link to &quot;It works in DMs but not in server channels&quot;">​</a>

That is often mention policy.

By default, the bot needs an `@mention` in Discord server text channels unless configured otherwise.

## Suggested first-week setup<a href="#suggested-first-week-setup" class="hash-link" aria-label="Direct link to Suggested first-week setup" translate="no" title="Direct link to Suggested first-week setup">​</a>

If you want the shortest path to success:

1.  get text Hermes working
2.  install `hermes-agent[voice]`
3.  use CLI voice mode with local STT + Edge TTS
4.  then enable `/voice on` in Telegram or Discord
5.  only after that, try Discord VC mode

That progression keeps the debugging surface small.

## Where to read next<a href="#where-to-read-next" class="hash-link" aria-label="Direct link to Where to read next" translate="no" title="Direct link to Where to read next">​</a>

- [Voice Mode feature reference](/docs/user-guide/features/voice-mode)
- [Messaging Gateway](/docs/user-guide/messaging)
- [Discord setup](/docs/user-guide/messaging/discord)
- [Telegram setup](/docs/user-guide/messaging/telegram)
- [Configuration](/docs/user-guide/configuration)


- <a href="#what-voice-mode-is-good-for" class="table-of-contents__link toc-highlight">What voice mode is good for</a>
- <a href="#choose-your-voice-mode-setup" class="table-of-contents__link toc-highlight">Choose your voice mode setup</a>
- <a href="#step-1-make-sure-normal-hermes-works-first" class="table-of-contents__link toc-highlight">Step 1: make sure normal Hermes works first</a>
- <a href="#step-2-install-the-right-extras" class="table-of-contents__link toc-highlight">Step 2: install the right extras</a>
  - <a href="#cli-microphone--playback" class="table-of-contents__link toc-highlight">CLI microphone + playback</a>
  - <a href="#messaging-platforms" class="table-of-contents__link toc-highlight">Messaging platforms</a>
  - <a href="#premium-elevenlabs-tts" class="table-of-contents__link toc-highlight">Premium ElevenLabs TTS</a>
  - <a href="#local-neutts-optional" class="table-of-contents__link toc-highlight">Local NeuTTS (optional)</a>
  - <a href="#everything" class="table-of-contents__link toc-highlight">Everything</a>
- <a href="#step-3-install-system-dependencies" class="table-of-contents__link toc-highlight">Step 3: install system dependencies</a>
  - <a href="#macos" class="table-of-contents__link toc-highlight">macOS</a>
  - <a href="#ubuntu--debian" class="table-of-contents__link toc-highlight">Ubuntu / Debian</a>
- <a href="#step-4-choose-stt-and-tts-providers" class="table-of-contents__link toc-highlight">Step 4: choose STT and TTS providers</a>
  - <a href="#easiest--cheapest-setup" class="table-of-contents__link toc-highlight">Easiest / cheapest setup</a>
  - <a href="#environment-file-example" class="table-of-contents__link toc-highlight">Environment file example</a>
  - <a href="#provider-recommendations" class="table-of-contents__link toc-highlight">Provider recommendations</a>
  - <a href="#if-you-use-hermes-setup" class="table-of-contents__link toc-highlight">If you use <code>hermes setup</code></a>
- <a href="#step-5-recommended-config" class="table-of-contents__link toc-highlight">Step 5: recommended config</a>
- <a href="#use-case-1-cli-voice-mode" class="table-of-contents__link toc-highlight">Use case 1: CLI voice mode</a>
- <a href="#turn-it-on" class="table-of-contents__link toc-highlight">Turn it on</a>
  - <a href="#recording-flow" class="table-of-contents__link toc-highlight">Recording flow</a>
  - <a href="#useful-commands" class="table-of-contents__link toc-highlight">Useful commands</a>
  - <a href="#good-cli-workflows" class="table-of-contents__link toc-highlight">Good CLI workflows</a>
- <a href="#tuning-cli-behavior" class="table-of-contents__link toc-highlight">Tuning CLI behavior</a>
  - <a href="#silence-threshold" class="table-of-contents__link toc-highlight">Silence threshold</a>
  - <a href="#silence-duration" class="table-of-contents__link toc-highlight">Silence duration</a>
  - <a href="#record-key" class="table-of-contents__link toc-highlight">Record key</a>
- <a href="#use-case-2-voice-replies-in-telegram-or-discord" class="table-of-contents__link toc-highlight">Use case 2: voice replies in Telegram or Discord</a>
  - <a href="#start-the-gateway" class="table-of-contents__link toc-highlight">Start the gateway</a>
  - <a href="#turn-on-voice-replies" class="table-of-contents__link toc-highlight">Turn on voice replies</a>
  - <a href="#modes" class="table-of-contents__link toc-highlight">Modes</a>
  - <a href="#when-to-use-which-mode" class="table-of-contents__link toc-highlight">When to use which mode</a>
  - <a href="#good-messaging-workflows" class="table-of-contents__link toc-highlight">Good messaging workflows</a>
- <a href="#use-case-3-discord-voice-channels" class="table-of-contents__link toc-highlight">Use case 3: Discord voice channels</a>
- <a href="#required-discord-permissions" class="table-of-contents__link toc-highlight">Required Discord permissions</a>
- <a href="#join-and-leave" class="table-of-contents__link toc-highlight">Join and leave</a>
  - <a href="#what-happens-when-joined" class="table-of-contents__link toc-highlight">What happens when joined</a>
  - <a href="#best-practices-for-discord-vc-use" class="table-of-contents__link toc-highlight">Best practices for Discord VC use</a>
- <a href="#voice-quality-recommendations" class="table-of-contents__link toc-highlight">Voice quality recommendations</a>
  - <a href="#best-quality-setup" class="table-of-contents__link toc-highlight">Best quality setup</a>
  - <a href="#best-speed--convenience-setup" class="table-of-contents__link toc-highlight">Best speed / convenience setup</a>
  - <a href="#best-zero-cost-setup" class="table-of-contents__link toc-highlight">Best zero-cost setup</a>
- <a href="#common-failure-modes" class="table-of-contents__link toc-highlight">Common failure modes</a>
  - <a href="#no-audio-device-found" class="table-of-contents__link toc-highlight">"No audio device found"</a>
  - <a href="#bot-joins-but-hears-nothing" class="table-of-contents__link toc-highlight">"Bot joins but hears nothing"</a>
  - <a href="#it-transcribes-but-does-not-speak" class="table-of-contents__link toc-highlight">"It transcribes but does not speak"</a>
  - <a href="#whisper-outputs-garbage" class="table-of-contents__link toc-highlight">"Whisper outputs garbage"</a>
  - <a href="#it-works-in-dms-but-not-in-server-channels" class="table-of-contents__link toc-highlight">"It works in DMs but not in server channels"</a>
- <a href="#suggested-first-week-setup" class="table-of-contents__link toc-highlight">Suggested first-week setup</a>
- <a href="#where-to-read-next" class="table-of-contents__link toc-highlight">Where to read next</a>


