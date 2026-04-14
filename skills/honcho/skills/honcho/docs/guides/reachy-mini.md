<!-- Source: https://docs.honcho.dev/v3/guides/integrations/reachy-mini -->

# Reachy Mini Voice Agent

## Overview

Building an embodied conversational AI using Reachy Mini, an open-source robot from Hugging Face and Pollen Robotics. Integrates Honcho for persistent memory with OpenAI's Realtime API for voice interactions.

## Key Capabilities

- User identification through facial recognition that loads personal memory
- Conversation storage and reasoning about individual users over time
- Low-latency voice interaction powered by OpenAI
- Eye contact maintenance via gaze tracking

When users return, the robot remembers their name, interests, and previous discussions.

## Installation

Required packages: reachy-mini, honcho-ai, openai, python-dotenv, numpy, scipy, mediapipe, face-recognition.

## Architecture

Reachy Mini sensors -> OpenAI Realtime API -> Honcho memory layer.

## Honcho Implementation

Two peer types:
- Robot peer: stores messages but isn't analyzed
- User peers: reasoned about by the system

Messages queue asynchronously without blocking audio playback.

## Memory Tools

| Tool | Function |
|------|----------|
| `recall` | Query user information from Honcho |
| `create_conclusion` | Save facts to long-term memory |
| `see` | Capture and analyze camera input |

The dialectic API returns results within 200-500 milliseconds.

## Multi-User Workflow

When face recognition detects a returning user: flush previous transcripts, switch Honcho context, retrieve briefing, reconnect with fresh context.
