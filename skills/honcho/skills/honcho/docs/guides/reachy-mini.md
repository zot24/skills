> Source: https://docs.honcho.dev/v3/guides/integrations/reachy-mini.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.honcho.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Voice Agent - Reachy Mini

> Build an embodied voice AI agent with long-term memory using Honcho

[Reachy Mini](https://huggingface.co/blog/reachy-mini) is Hugging Face and Pollen Robotics' open-source robot for human-robot interaction. This guide integrates Honcho for persistent, multi-user memory with OpenAI's Realtime API for voice.


  **Real-time memory**: Honcho's async API is designed for live voice interactions. Messages persist in the background without blocking audio, and the dialectic API returns user context fast enough for mid-conversation tool calls.


    Full source code


    Watch us build it live


## What It Does

* **Face recognition** identifies users and loads their personal memory
* **Honcho** stores conversations and reasons about each user over time
* **OpenAI Realtime** handles low-latency voice interaction
* **Gaze tracking** maintains eye contact during conversation

When a user returns days later, the robot remembers their name, interests, and previous discussions.

## Setup

```bash
pip install reachy-mini honcho-ai openai python-dotenv numpy scipy mediapipe face-recognition
```

```bash
export OPENAI_API_KEY=your_openai_key
export HONCHO_API_KEY=your_honcho_key  # get at app.honcho.dev
```

## Architecture

```
Reachy Mini (camera, mic, speaker)
        ↓
OpenAI Realtime API (voice + tools)
        ↓
Honcho (memory + reasoning per user)
```

## Honcho Integration

Initialize Honcho with a robot peer (not observed) and dynamic user peers (observed):

```python
from honcho import Honcho
from honcho.api_types import PeerConfig

honcho = Honcho(api_key=api_key, workspace_id="reachy-mini")

# Robot peer - stores messages but isn't reasoned about
robot_peer = await honcho.aio.peer(
    "reachy",
    configuration=PeerConfig(observe_me=False),
)

# User peers - Honcho reasons about their preferences and history
user_peer = await honcho.aio.peer(user_id)
session = await honcho.aio.session(f"chat-{user_id}")
```

Store messages in the background without blocking the voice loop:

```python
# Queue messages async - doesn't block audio playback
await session.aio.add_messages(user_peer.message(transcript))
await session.aio.add_messages(robot_peer.message(response))
```

## Memory Tools

The robot calls Honcho mid-conversation via OpenAI function calling — fast enough for real-time voice:

| Tool                | Purpose                                            |
| ------------------- | -------------------------------------------------- |
| `recall`            | Query Honcho about the user ("What's their name?") |
| `create_conclusion` | Save important facts to long-term memory           |
| `see`               | Capture and analyze camera feed                    |

```python
# Recall - ask Honcho's dialectic API (returns in ~200-500ms)
result = await user_peer.aio.chat(
    "What do I know about this user?",
    session=session,
    reasoning_level="medium"
)

# Create conclusion - save a fact
await user_peer.conclusions_of(user_id).aio.create([
    {"content": "Their name is Alice"}
])
```

## Multi-User Support

Face recognition identifies returning users. When a new face is detected, the agent:

1. Flushes pending transcripts to the previous user's session
2. Switches Honcho context to the new user
3. Fetches a briefing from Honcho's dialectic API
4. Reconnects OpenAI with fresh context and triggers a greeting

```python
# Get briefing when user is recognized
briefing = await user_peer.aio.chat(
    "What should I know about this user? Name, interests, recent topics.",
    session=session,
    reasoning_level="low"
)
```

## System Prompt

```python
SYSTEM_PROMPT = """You are Reachy, a friendly robot. Keep responses concise.

You have a recall tool for memory. ALWAYS use it before claiming you don't
know something about the user. Never say "Nice to meet you" if you've met before."""
```

## Run

```bash
uv run python main.py
```

## Next Steps


    Understand peers, sessions, and reasoning


    Learn about Honcho's dialectic API


    Retrieve formatted conversation history


    Dig into the code


