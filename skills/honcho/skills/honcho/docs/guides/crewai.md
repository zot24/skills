> Source: https://honcho.dev/docs/v3/guides/integrations/crewai.md

> ## Documentation Index
> Fetch the complete documentation index at: https://honcho.dev/docs/llms.txt
> Use this file to discover all available pages before exploring further.

# CrewAI

> Build AI agents with persistent memory using CrewAI and Honcho

Integrate Honcho with CrewAI to build agents that maintain memory across sessions. This guide uses CrewAI's unified `Memory` API with Honcho as a custom storage backend.


  The full code is available on [GitHub](https://github.com/plastic-labs/honcho/tree/main/examples/crewai) with examples in [Python](https://github.com/plastic-labs/honcho/tree/main/examples/crewai/python/examples).


## What We're Building

* **CrewAI** orchestrates agents, tasks, and memory recall.
* **Honcho** persists CrewAI memory records and exposes additional context, search, and reasoning tools.


  CrewAI currently supports Python `>=3.10,<3.14`; use one of those interpreters when installing this integration.


## Setup

Install the packages:

<CodeGroup>
  ```bash Python (uv)
  uv add honcho-crewai crewai python-dotenv
  ```

  ```bash Python (pip)
  pip install honcho-crewai crewai python-dotenv
  ```
</CodeGroup>

Set your model provider keys and Honcho configuration:

```bash
OPENAI_API_KEY=your_openai_key
HONCHO_API_KEY=your_honcho_key
HONCHO_WORKSPACE_ID=crewai-demo
```

For local development, initialize the Honcho client with `environment="local"`.

## CrewAI Memory Storage

`HonchoMemoryStorage` implements CrewAI's current `StorageBackend` protocol and can be passed directly to `Memory(storage=...)`.

```python
from crewai import Memory
from honcho import Honcho
from honcho_crewai import HonchoMemoryStorage

honcho = Honcho(workspace_id="crewai-demo")
storage = HonchoMemoryStorage(
    peer_id="user-123",
    session_id="session-123",
    honcho_client=honcho,
)
memory = Memory(storage=storage)
```

CrewAI embeds memory records before storing them. The Honcho backend stores those records as Honcho messages, keeps CrewAI metadata in message metadata, and performs vector search over the stored embeddings.

```python
memory.remember(
    "The user is learning Python and wants to build web applications.",
    scope="/users/user-123",
    categories=["preferences"],
    metadata={"source": "onboarding"},
)
```

Use the memory instance with a crew:

```python Python
from crewai import Agent, Crew, Process, Task

agent = Agent(
    role="Programming Mentor",
    goal="Help users learn programming by remembering their interests and progress",
    backstory="You are a patient programming mentor.",
)

task = Task(
    description="Suggest a Python web project that matches the user's interests.",
    expected_output="A specific project suggestion with a brief explanation",
    agent=agent,
)

crew = Crew(
    agents=[agent],
    tasks=[task],
    process=Process.sequential,
    memory=memory,
    verbose=True,
)

result = crew.kickoff()
print(result.raw)
```


  `HonchoStorage` is still available as a compatibility adapter for older CrewAI `ExternalMemory` integrations, but new projects should use `HonchoMemoryStorage`.


## CrewAI Tool Integration

Honcho also provides tools that let agents explicitly retrieve memory:

* **`HonchoGetContextTool`** retrieves session context with token limits.
* **`HonchoDialecticTool`** queries Honcho's representation of a peer.
* **`HonchoSearchTool`** performs semantic search over session messages.

```python Python
from crewai import Agent, Crew, Process, Task
from honcho import Honcho
from honcho_crewai import (
    HonchoDialecticTool,
    HonchoGetContextTool,
    HonchoSearchTool,
)

honcho = Honcho(workspace_id="crewai-demo")
user_id = "demo-user"
session_id = "tools-demo-session"

user = honcho.peer(user_id)
session = honcho.session(session_id)

for message in [
    "I'm planning a trip to Japan in March",
    "I love authentic local cuisine, especially ramen and sushi",
    "My budget is around $3000 for a 10-day trip",
]:
    session.add_messages([user.message(message)])

context_tool = HonchoGetContextTool(
    honcho=honcho,
    session_id=session_id,
    peer_id=user_id,
)
dialectic_tool = HonchoDialecticTool(
    honcho=honcho,
    session_id=session_id,
    peer_id=user_id,
)
search_tool = HonchoSearchTool(honcho=honcho, session_id=session_id)

travel_agent = Agent(
    role="Travel Planning Specialist",
    goal="Create personalized travel recommendations using memory tools",
    backstory="You are an expert travel planner with access to memory tools.",
    tools=[context_tool, dialectic_tool, search_tool],
    verbose=True,
    allow_delegation=False,
)

task = Task(
    description="Create a personalized 3-day Tokyo itinerary using the memory tools.",
    expected_output="A 3-day Tokyo itinerary with activities, restaurants, and budget notes",
    agent=travel_agent,
)

crew = Crew(
    agents=[travel_agent],
    tasks=[task],
    process=Process.sequential,
    verbose=True,
)

crew.kickoff()
```

## When To Use Each

Use `HonchoMemoryStorage` when you want CrewAI to handle recall automatically through the unified memory system.

Use the Honcho tools when the agent should decide when and how to query memory, search messages, or ask Honcho for a peer-level representation.

You can combine both: unified memory for baseline context, tools for targeted retrieval. See the [hybrid memory example](https://github.com/plastic-labs/honcho/blob/main/examples/crewai/python/examples/hybrid_memory_example.py) for a complete implementation.

## Related Resources


    Understand Honcho's peer-based model and core primitives


    Learn about retrieving and formatting conversation context


    Query peer representations for deeper understanding


    Build stateful agents with LangGraph and Honcho


