<!-- Source: https://docs.honcho.dev/v3/guides/discord -->

# Discord Bots with Honcho

## Overview

Honcho enables building Discord bots with conversational memory and context management using the py-cord library.

## Core Event Handling

```python
@bot.event
async def on_message(message):
    if not validate_message(message):
        return

    input = sanitize_message(message)
    if not input:
        return

    peer = honcho_client.peer(id=get_peer_id_from_discord(message))
    session = honcho_client.session(id=str(message.channel.id))

    async with message.channel.typing():
        response = llm(session, input)

    await send_discord_message(message, response)

    session.add_messages(
        [
            peer.message(input),
            assistant.message(response),
        ]
    )
```

## Helper Functions

### Message Validation

```python
def validate_message(message) -> bool:
    if message.author == bot.user:
        return False
    if isinstance(message.channel, discord.DMChannel):
        return False
    if not bot.user.mentioned_in(message):
        return False
    return True
```

### Message Sanitization

```python
def sanitize_message(message) -> str | None:
    content = message.content.replace(f"<@{bot.user.id}>", "").strip()
    if not content:
        return None
    return content
```

### Peer Identification

```python
def get_peer_id_from_discord(message):
    return f"discord_{str(message.author.id)}"
```

### LLM Integration

```python
def llm(session, prompt) -> str:
    messages: list[dict[str, object]] = session.context().to_openai(
        assistant=assistant
    )
    messages.append({"role": "user", "content": prompt})

    try:
        completion = openai.chat.completions.create(
            model=MODEL_NAME,
            messages=messages,
        )
        return completion.choices[0].message.content
    except Exception as e:
        print(e)
        return f"Error: {e}"
```

### Message Sending (handles Discord character limits)

```python
async def send_discord_message(message, response_content: str):
    if len(response_content) > 1500:
        chunks = []
        current_chunk = ""
        for line in response_content.splitlines(keepends=True):
            if len(current_chunk) + len(line) > 1500:
                chunks.append(current_chunk)
                current_chunk = line
            else:
                current_chunk += line
        if current_chunk:
            chunks.append(current_chunk)
        for chunk in chunks:
            await message.channel.send(chunk)
    else:
        await message.channel.send(response_content)
```

## Slash Commands

```python
@bot.slash_command(name="chat", description="Chat with Honcho about a peer.")
async def chat(ctx, query: str):
    await ctx.defer()
    try:
        peer = honcho_client.peer(id=get_peer_id_from_discord(ctx))
        session = honcho_client.session(id=str(ctx.channel.id))
        response = peer.chat(query=query, session_id=session.id)
        if response:
            await ctx.followup.send(response)
        else:
            await ctx.followup.send(
                f"I don't know anything about {ctx.author.name} because we haven't talked yet!"
            )
    except Exception as e:
        await ctx.followup.send(f"Sorry, there was an error: {str(e)}")
```

## Configuration

```python
honcho_client = Honcho()
assistant = honcho_client.peer(id="assistant", config={"observe_me": False})
openai = OpenAI(base_url="https://openrouter.ai/api/v1", api_key=MODEL_API_KEY)
```

## Key Patterns

- **Peer/Session Model**: Users as peers, conversations as sessions
- **Automatic Context Management**: Session context converts to OpenAI format
- **Message Storage**: Both user input and assistant responses stored
- **Query Capabilities**: Peer chat for history-based responses
