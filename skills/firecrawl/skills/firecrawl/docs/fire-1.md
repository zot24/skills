> Source: https://docs.firecrawl.dev/agents/fire-1.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Agent

> Gather data wherever it lives on the web.

**Picking the right tool.** Agent is right when you **don't know the URLs** or need autonomous navigation across the web.

* For **a single known URL**, [JSON mode on `/scrape`](/features/llm-extract) is cheaper and synchronous.
* Full comparison: [Choosing the Data Extractor](/developer-guides/usage-guides/choosing-the-data-extractor).

Firecrawl `/agent` is a magic API that searches, navigates, and gathers data from the widest range of websites, finding data in hard-to-reach places and uncovering data in ways no other API can. It accomplishes in a few minutes what would take a human many hours — end-to-end data collection, without scripts or manual work.
Whether you need one data point or entire datasets at scale, Firecrawl `/agent` works to get your data.

**Think of `/agent` as deep research for data, wherever it is!**


  **Research Preview**: Agent is in early access. Expect rough edges. It will get significantly better over time.


Agent builds on everything great about `/extract` and takes it further:

* **No URLs Required**: Just describe what you need via `prompt` parameter. URLs are optional
* **Deep Web Search**: Autonomously searches and navigates deep into sites to find your data
* **Reliable and Accurate**: Works with a wide variety of queries and use cases
* **Faster**: Processes multiple sources in parallel for quicker results


  Test the agent in the interactive playground — no code required.


## Using `/agent`

The only required parameter is `prompt`. Simply describe what data you want to extract. For structured output, provide a JSON schema. The SDKs support Pydantic (Python) and Zod (Node) for type-safe schema definitions:

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl
  from pydantic import BaseModel, Field
  from typing import List, Optional

  app = Firecrawl(api_key="fc-YOUR_API_KEY")

  class Founder(BaseModel):
      name: str = Field(description="Full name of the founder")
      role: Optional[str] = Field(None, description="Role or position")
      background: Optional[str] = Field(None, description="Professional background")

  class FoundersSchema(BaseModel):
      founders: List[Founder] = Field(description="List of founders")

  result = app.agent(
      prompt="Find the founders of Firecrawl",
      schema=FoundersSchema,
      model="spark-2",
      max_credits=100
  )

  print(result.data)
  ```

  ```js Node
  import { Firecrawl } from 'firecrawl';
  import { z } from 'zod';

  const firecrawl = new Firecrawl({ apiKey: "fc-YOUR_API_KEY" });

  const result = await firecrawl.agent({
    prompt: "Find the founders of Firecrawl",
    schema: z.object({
      founders: z.array(z.object({
        name: z.string().describe("Full name of the founder"),
        role: z.string().describe("Role or position").optional(),
        background: z.string().describe("Professional background").optional()
      })).describe("List of founders")
    }),
    model: "spark-2",
    maxCredits: 100
  });

  console.log(result.data);
  ```

  ```bash cURL
  curl -X POST "https://api.firecrawl.dev/v2/agent" \
    -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
    -H "Content-Type: application/json" \
    -d '{
      "prompt": "Find the founders of Firecrawl",
      "model": "spark-2",
      "maxCredits": 100,
      "schema": {
        "type": "object",
        "properties": {
          "founders": {
            "type": "array",
            "description": "List of founders",
            "items": {
              "type": "object",
              "properties": {
                "name": { "type": "string", "description": "Full name" },
                "role": { "type": "string", "description": "Role or position" },
                "background": { "type": "string", "description": "Professional background" }
              },
              "required": ["name"]
            }
          }
        },
        "required": ["founders"]
      }
    }'
  ```
</CodeGroup>

### Response

```json JSON theme={null}
{
  "success": true,
  "status": "completed",
  "data": {
    "founders": [
      {
        "name": "Eric Ciarla",
        "role": "Co-founder",
        "background": "Previously at Mendable"
      },
      {
        "name": "Nicolas Camara",
        "role": "Co-founder",
        "background": "Previously at Mendable"
      },
      {
        "name": "Caleb Peffer",
        "role": "Co-founder",
        "background": "Previously at Mendable"
      }
    ]
  },
  "expiresAt": "2024-12-15T00:00:00.000Z",
  "creditsUsed": 15
}
```

## Providing URLs (Optional)

You can optionally provide URLs to focus the agent on specific pages:

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl

  app = Firecrawl(api_key="fc-YOUR_API_KEY")

  result = app.agent(
      urls=["https://docs.firecrawl.dev", "https://firecrawl.dev/pricing"],
      prompt="Compare the features and pricing information from these pages"
  )

  print(result.data)
  ```

  ```js Node
  import { Firecrawl } from 'firecrawl';

  const firecrawl = new Firecrawl({ apiKey: "fc-YOUR_API_KEY" });

  const result = await firecrawl.agent({
    urls: ["https://docs.firecrawl.dev", "https://firecrawl.dev/pricing"],
    prompt: "Compare the features and pricing information from these pages"
  });

  console.log(result.data);
  ```

  ```bash cURL
  curl -X POST "https://api.firecrawl.dev/v2/agent" \
    -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
    -H "Content-Type: application/json" \
    -d '{
      "urls": [
        "https://docs.firecrawl.dev",
        "https://firecrawl.dev/pricing"
      ],
      "prompt": "Compare the features and pricing information from these pages"
    }'
  ```
</CodeGroup>

## Job Status and Completion

Agent jobs run asynchronously. When you submit a job, you'll receive a Job ID that you can use to check status:

* **Default method**: `agent()` waits and returns final results
* **Start then poll**: Use `start_agent` (Python) or `startAgent` (Node) to get a Job ID immediately, then poll with `get_agent_status` / `getAgentStatus`
* **Push instead of poll**: Pass a `webhook` when you start the job to receive [agent events](/webhooks/events#agent-events) as the run progresses and finishes

Job results are available via the API for 24 hours after completion. After this period, you can still view your agent history and results in the [activity logs](https://www.firecrawl.dev/app/logs).

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl

  app = Firecrawl(api_key="fc-YOUR_API_KEY")

  # Start an agent job
  agent_job = app.start_agent(
      prompt="Find the founders of Firecrawl"
  )

  # Check the status
  status = app.get_agent_status(agent_job.id)

  print(status)
  # Example output:
  # status='completed'
  # success=True
  # data={ ... }
  # expires_at=datetime.datetime(...)
  # credits_used=15
  ```

  ```js Node
  import { Firecrawl } from 'firecrawl';

  const firecrawl = new Firecrawl({ apiKey: "fc-YOUR_API_KEY" });

  // Start an agent job
  const started = await firecrawl.startAgent({
    prompt: "Find the founders of Firecrawl"
  });

  // Check the status
  if (started.id) {
    const status = await firecrawl.getAgentStatus(started.id);
    console.log(status.status, status.data);
  }
  ```

  ```bash cURL
  curl -X GET "https://api.firecrawl.dev/v2/agent/<jobId>" \
    -H "Authorization: Bearer $FIRECRAWL_API_KEY"
  ```
</CodeGroup>

### Possible States

| Status | Description |
| - | - |
| `processing` | The agent is still working on your request |
| `completed` | Extraction finished successfully |
| `failed` | An error occurred during extraction, or the job was cancelled (cancelled jobs report `failed` with a cancellation error message) |


  **Cancellation is cooperative.** When you call the cancel endpoint, the request is registered immediately, but any step already in flight (an LLM reasoning step, a tool call, or a browser action) runs to a clean stopping point before the job stops. Credits can continue to accrue during that short window, so the final `creditsUsed` may be higher than the value reported at the moment you clicked cancel. A cancelled job reports status `failed` when polled and emits an `agent.cancelled` webhook event.


#### Pending Example

```json JSON theme={null}
{
  "success": true,
  "status": "processing",
  "expiresAt": "2024-12-15T00:00:00.000Z"
}
```

#### Completed Example

```json JSON theme={null}
{
  "success": true,
  "status": "completed",
  "data": {
    "founders": [
      {
        "name": "Eric Ciarla",
        "role": "Co-founder"
      },
      {
        "name": "Nicolas Camara",
        "role": "Co-founder"
      },
      {
        "name": "Caleb Peffer",
        "role": "Co-founder"
      }
    ]
  },
  "expiresAt": "2024-12-15T00:00:00.000Z",
  "creditsUsed": 15
}
```

## Listing agent runs

`GET /agent` lists every agent run your team has made, most recent first — including runs started from the playground or the API. Each entry carries the run's ID, creation time, status, a short target hint, and the options it was started with.

Results are paginated in fixed pages of 20 runs. When more pages exist, the response includes a `next` URL; pass its `before` timestamp to fetch the next page. The SDK methods do not auto-paginate, so you stay in control of how far back to go.

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl

  app = Firecrawl(api_key="fc-YOUR_API_KEY")

  # List your most recent agent runs
  page = app.list_agents()

  for run in page.agents:
      print(run.id, run.status, run.target_hint)

  # Fetch the next page using the cursor from `next`
  if page.next:
      before = int(page.next.split("before=")[-1])
      older = app.list_agents(before=before)
  ```

  ```js Node
  import { Firecrawl } from 'firecrawl';

  const firecrawl = new Firecrawl({ apiKey: "fc-YOUR_API_KEY" });

  // List your most recent agent runs
  const page = await firecrawl.listAgents();

  for (const run of page.agents ?? []) {
    console.log(run.id, run.status, run.targetHint);
  }

  // Fetch the next page using the cursor from `next`
  if (page.next) {
    const before = Number(new URL(page.next).searchParams.get("before"));
    const older = await firecrawl.listAgents({ before });
  }
  ```

  ```bash cURL
  curl -X GET "https://api.firecrawl.dev/v2/agent" \
    -H "Authorization: Bearer $FIRECRAWL_API_KEY"

  # Fetch the next page (unix ms timestamp from the previous page's `next` URL)
  curl -X GET "https://api.firecrawl.dev/v2/agent?before=1756600000000" \
    -H "Authorization: Bearer $FIRECRAWL_API_KEY"
  ```
</CodeGroup>

## Following a run in progress

Agent doesn't hold a streamed connection open. There's no server-sent event stream and no websocket, so you follow a run either by polling its trace or by receiving webhooks.

| Surface | What you get | Best for |
| - | - | - |
| Trace polling | Full detail: every event the run has emitted so far, including tool calls, reasoning summaries, progress phases, and artifact changes | Building your own progress UI, or debugging what a run actually did |
| Webhooks | Push delivery, coarse-grained: the five agent lifecycle events (`agent.started`, `agent.action`, `agent.completed`, `agent.failed`, `agent.cancelled`). See [webhook events](/webhooks/events) | Reacting to a run finishing without holding a poll loop open |
| Live view | A human-watchable view of the agent's browser. Request the trace with `?liveView=true` and each entry in `activeBrowserSessions` carries a `liveViewUrl` | Watching a run navigate in real time |

When you order trace events yourself, group them by `agent.id` first: `producerSequence` is monotonic per emitting agent, so a single global sort interleaves an orchestrator's events with its subagents' incorrectly. Events can also land for a moment after the terminal `run.finished` event, so keep polling through a short tail window before you render the final state.

<CodeGroup>
  ```python Python
  import time
  from collections import defaultdict

  from firecrawl import Firecrawl

  app = Firecrawl(api_key="fc-YOUR_API_KEY")

  agent_job = app.start_agent(prompt="Find the founders of Firecrawl")
  seen = set()
  finished = False
  quiet_polls = 0

  while True:
      trace = app.get_agent_trace(agent_job.id)

      # producer_sequence is monotonic per emitting agent, so group first.
      by_agent = defaultdict(list)
      for event in trace.events or []:
          by_agent[event.agent.id].append(event)

      new_events = 0
      for agent_id, events in by_agent.items():
          for event in sorted(events, key=lambda e: e.producer_sequence):
              if event.event_id not in seen:
                  seen.add(event.event_id)
                  new_events += 1
                  print(agent_id, event.producer_sequence, event.type)

      if not finished:
          finished = app.get_agent_status(agent_job.id).status != "processing"
      elif new_events:
          quiet_polls = 0
      else:
          # Tail window: events can land for a moment after the run finishes.
          quiet_polls += 1
          if quiet_polls == 3:
              break

      time.sleep(5)
  ```

  ```js Node
  import { Firecrawl } from 'firecrawl';

  const firecrawl = new Firecrawl({ apiKey: "fc-YOUR_API_KEY" });

  const started = await firecrawl.startAgent({ prompt: "Find the founders of Firecrawl" });
  const seen = new Set();
  let finished = false;
  let quietPolls = 0;

  for (;;) {
    const trace = await firecrawl.getAgentTrace(started.id);

    // producerSequence is monotonic per emitting agent, so group first.
    const byAgent = new Map();
    for (const event of trace.events ?? []) {
      const bucket = byAgent.get(event.agent.id) ?? [];
      bucket.push(event);
      byAgent.set(event.agent.id, bucket);
    }

    let newEvents = 0;
    for (const [agentId, events] of byAgent) {
      for (const event of events.sort((a, b) => a.producerSequence - b.producerSequence)) {
        if (seen.has(event.eventId)) continue;
        seen.add(event.eventId);
        newEvents++;
        console.log(agentId, event.producerSequence, event.type);
      }
    }

    if (!finished) {
      finished = (await firecrawl.getAgentStatus(started.id)).status !== "processing";
    } else if (newEvents) {
      quietPolls = 0;
    } else {
      // Tail window: events can land for a moment after the run finishes.
      if (++quietPolls === 3) break;
    }

    await new Promise((resolve) => setTimeout(resolve, 5000));
  }
  ```

  ```bash cURL
  # Print only the events you haven't seen yet, and keep polling through a short
  # tail window after the run finishes.
  tmp=$(mktemp -d)
  trap 'rm -rf "$tmp"' EXIT
  : > "$tmp/seen.txt"
  finished=0
  quiet=0

  while [ "$quiet" -lt 3 ]; do
    curl -s "https://api.firecrawl.dev/v2/agent/JOB_ID/trace" \
      -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
    | jq -r '.events | group_by(.agent.id)[] | sort_by(.producerSequence)[]
             | "\(.eventId) \(.agent.id) \(.producerSequence) \(.type)"' > "$tmp/poll.txt"

    new=$(grep -vxF -f "$tmp/seen.txt" "$tmp/poll.txt")
    [ -n "$new" ] && echo "$new"
    cp "$tmp/poll.txt" "$tmp/seen.txt"

    if [ "$finished" = 0 ]; then
      status=$(curl -s "https://api.firecrawl.dev/v2/agent/JOB_ID" \
        -H "Authorization: Bearer $FIRECRAWL_API_KEY" | jq -r '.status')
      [ "$status" = "processing" ] || finished=1
    elif [ -n "$new" ]; then
      quiet=0
    else
      quiet=$((quiet + 1))
    fi

    sleep 5
  done
  ```
</CodeGroup>

## Execution Traces and Snapshots

Every run records a canonical execution trace — ordered events covering tool calls, reasoning summaries, progress updates, browser sessions, and output artifact changes. Fetch it to debug a run or power a live progress UI:

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl

  app = Firecrawl(api_key="fc-YOUR_API_KEY")

  # Execution trace of a run: ordered events (tool calls, reasoning, artifacts)
  trace = app.get_agent_trace("JOB_ID")

  for event in trace.events or []:
      print(event.type)

  # Include currently active browser sessions while the run is in flight
  live = app.get_agent_trace("JOB_ID", live_view=True)
  for session in live.active_browser_sessions or []:
      print(session.live_view_url)
  ```

  ```js Node
  import { Firecrawl } from 'firecrawl';

  const firecrawl = new Firecrawl({ apiKey: "fc-YOUR_API_KEY" });

  // Execution trace of a run: ordered events (tool calls, reasoning, artifacts)
  const trace = await firecrawl.getAgentTrace("JOB_ID");

  for (const event of trace.events ?? []) {
    console.log(event.type);
  }

  // Include currently active browser sessions while the run is in flight
  const live = await firecrawl.getAgentTrace("JOB_ID", { liveView: true });
  console.log(live.activeBrowserSessions);
  ```

  ```bash cURL
  curl "https://api.firecrawl.dev/v2/agent/JOB_ID/trace" \
    -H "Authorization: Bearer $FIRECRAWL_API_KEY"

  # Include currently active browser sessions while the run is in flight
  curl "https://api.firecrawl.dev/v2/agent/JOB_ID/trace?liveView=true" \
    -H "Authorization: Bearer $FIRECRAWL_API_KEY"
  ```
</CodeGroup>

`artifact.updated` trace events reference the agent's working output by `snapshotId`. Fetch the full content of a snapshot with the snapshots endpoint:

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl

  app = Firecrawl(api_key="fc-YOUR_API_KEY")

  # artifact.updated trace events reference snapshot content by snapshotId
  snapshot = app.get_agent_snapshot("JOB_ID", "SNAPSHOT_ID")

  print(snapshot.snapshot)
  ```

  ```js Node
  import { Firecrawl } from 'firecrawl';

  const firecrawl = new Firecrawl({ apiKey: "fc-YOUR_API_KEY" });

  // artifact.updated trace events reference snapshot content by snapshotId
  const snapshot = await firecrawl.getAgentSnapshot("JOB_ID", "SNAPSHOT_ID");

  console.log(snapshot.snapshot);
  ```

  ```bash cURL
  curl "https://api.firecrawl.dev/v2/agent/JOB_ID/snapshots/SNAPSHOT_ID" \
    -H "Authorization: Bearer $FIRECRAWL_API_KEY"
  ```
</CodeGroup>

Traces and snapshots are recorded on Spark 2 runs, which is every new run; jobs started on Spark 1 models before their retirement do not have them. See the [trace](/api-reference/endpoint/agent-trace) and [snapshot](/api-reference/endpoint/agent-snapshot) API references for the full event schema, and the [Agent errors](/api-reference/errors#agent) catalog for the failures these endpoints return.

## Getting the agent's source data

A run writes its working output to artifacts as it goes, and you can retrieve them once you have the run's trace. Every `artifact.updated` event describes one change to one artifact: `artifact.kind` is `json`, `markdown`, `html`, `screenshot`, or `text`, `artifact.path` is where the run put it, and `artifact.snapshotId` is the handle you exchange for its content at `GET /agent/{jobId}/snapshots/{snapshotId}`. The snapshot endpoint returns that content in a `snapshot` field as a string: for `json` artifacts that string is JSON-encoded and needs decoding, while `markdown`, `html`, and `text` artifacts are the content itself.

To pull the page content a run produced, fetch the trace, keep the `artifact.updated` events whose `kind` you want, then fetch each snapshot:

<CodeGroup>
  ```python Python
  import json

  from firecrawl import Firecrawl

  app = Firecrawl(api_key="fc-YOUR_API_KEY")

  trace = app.get_agent_trace("JOB_ID")

  for event in trace.events or []:
      if event.type != "artifact.updated":
          continue

      kind = event.artifact.kind
      if kind not in ("markdown", "html", "json"):
          continue

      snapshot = app.get_agent_snapshot("JOB_ID", event.artifact.snapshot_id)

      # markdown, html, and text snapshots are the content itself.
      # json snapshots are JSON-encoded, so decode those.
      content = json.loads(snapshot.snapshot) if kind == "json" else snapshot.snapshot

      print(kind, event.artifact.path, content)
  ```

  ```js Node
  import { Firecrawl } from 'firecrawl';

  const firecrawl = new Firecrawl({ apiKey: "fc-YOUR_API_KEY" });

  const trace = await firecrawl.getAgentTrace("JOB_ID");

  for (const event of trace.events ?? []) {
    if (event.type !== "artifact.updated") continue;

    const kind = event.artifact.kind;
    if (!["markdown", "html", "json"].includes(kind)) continue;

    const snapshot = await firecrawl.getAgentSnapshot("JOB_ID", event.artifact.snapshotId);

    // markdown, html, and text snapshots are the content itself.
    // json snapshots are JSON-encoded, so decode those.
    const content = kind === "json" ? JSON.parse(snapshot.snapshot) : snapshot.snapshot;

    console.log(kind, event.artifact.path, content);
  }
  ```

  ```bash cURL
  # Fetch every markdown, html, or json artifact the run wrote.
  curl -s "https://api.firecrawl.dev/v2/agent/JOB_ID/trace" \
    -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  | jq -r '.events[]
           | select(.type == "artifact.updated")
           | select(.artifact.kind == "markdown" or .artifact.kind == "html" or .artifact.kind == "json")
           | "\(.artifact.kind) \(.artifact.snapshotId)"' \
  | while read -r kind snapshot_id; do
      body=$(curl -s "https://api.firecrawl.dev/v2/agent/JOB_ID/snapshots/$snapshot_id" \
        -H "Authorization: Bearer $FIRECRAWL_API_KEY")

      # markdown and html snapshots are the content itself; json is JSON-encoded.
      if [ "$kind" = "json" ]; then
        printf '%s' "$body" | jq -r '.snapshot | fromjson'
      else
        printf '%s' "$body" | jq -r '.snapshot'
      fi
    done
  ```
</CodeGroup>

Two things worth knowing before you build on this:

* **Artifacts are the run's output, not a page-by-page archive.** What a run writes to an artifact depends on how it works through your prompt, so treat the artifact set as what that particular run produced rather than a guaranteed record of every page it opened.
* **Tool results carry the rest.** Each `tool_call.finished` event includes a `result` field holding what that tool returned, which is where content that never became an artifact shows up.

## Share agent runs

You can share agent runs directly from the Agent playground. Shared links are public — anyone with the link can view the run output and activity — and you can revoke access at any time to disable the link. Shared pages are not indexed by search engines.

## Model Selection

Firecrawl Agent runs on **Spark 2** — cheaper and faster than the earlier Spark 1 models, at comparable accuracy. It is the default: every run executes on `spark-2`, whether or not you set the `model` parameter.


  **Spark 1 models are deprecated.** The Spark 1 model names remain accepted for backwards compatibility, but requests that use them route to `spark-2`.


### Spark 2

`spark-2` handles the full range of tasks that previously called for a Mini-versus-Pro decision, so there is no accuracy-versus-cost trade-off to make.

**Highlights:**

* Lowest cost per run
* Fastest run time
* Accuracy comparable to the former Spark 1 flagship
* The only model with a reasoning budget: pass `effort` (`low`, `medium`, or `high`) to control how hard it thinks

### Specifying a Model

The `model` parameter is optional — every request runs `spark-2`:

<CodeGroup>
  ```python Python
  from firecrawl import Firecrawl

  app = Firecrawl(api_key="fc-YOUR_API_KEY")

  # Spark 2 is the default — every run executes on it
  result = app.agent(
      prompt="Find the pricing of Firecrawl",
      model="spark-2"
  )

  # Deprecated: Spark 1 model names are still accepted, but route to "spark-2".

  print(result.data)
  ```

  ```js Node
  import { Firecrawl } from 'firecrawl';

  const firecrawl = new Firecrawl({ apiKey: "fc-YOUR_API_KEY" });

  // Spark 2 is the default — every run executes on it
  const result = await firecrawl.agent({
    prompt: "Find the pricing of Firecrawl",
    model: "spark-2"
  });

  // Deprecated: Spark 1 model names are still accepted, but route to "spark-2".

  console.log(result.data);
  ```

  ```bash cURL
  # Spark 2 is the default — every run executes on it
  curl -X POST "https://api.firecrawl.dev/v2/agent" \
    -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
    -H "Content-Type: application/json" \
    -d '{
      "prompt": "Find the pricing of Firecrawl",
      "model": "spark-2"
    }'

  # Deprecated: Spark 1 model names are still accepted, but route to "spark-2".
  ```
</CodeGroup>

## Data providers that need terms

Agent can call [Alexandria](/features/alexandria) data providers during a run, but only the ones whose data terms your team has accepted. A provider whose terms you haven't accepted is never called, whatever `exchange.onTermsRequired` is set to. The run carries on with the providers it can use, and the status response reports what it skipped.

There is no auto-accept mode. Accepting a provider's terms always needs a person to agree to them, either in the [dashboard](https://www.firecrawl.dev/app/settings?tab=data-sources) or through a `terms/accept` call your application makes after its user has explicitly agreed. If you build an agent on top of Firecrawl, it must ask its user before calling `terms/accept`. A request for data isn't consent to a provider's terms.

| `onTermsRequired` | What happens |
| - | - |
| `skip` (default) | The run answers with accepted providers only and never blocks. `exchange.skippedProviders` lists the gated providers that would have helped. |
| `ask` | The same as `skip`. The run also ends with `exchange.requiresAction` and a `pendingApproval` of `kind: "terms"`, so you can ask your user, accept, and continue the thread. |

If you leave `onTermsRequired` out on a follow-up turn of a thread, the turn uses the previous turn's value. If a turn ends on a paid-call approval (`requireApproval`), it has no terms offer.

### Response fields

These fields are on the `exchange` object of `GET /v2/agent/{id}`:

* `skippedProviders` (any mode): one entry per gated provider that would have helped, with `provider`, `name`, `capability`, `adds` (what it would have added), `reason: "terms_required"`, `version` (the terms version) and `termsUrl` (where to accept in the dashboard).
* `requiresAction` (`ask` only): `type: "accept_terms"`, an `approvalId` and a `providers` list. `approvalId` is always present. It's the id of the `terms` pending approval you answer when you continue the thread. Each provider carries the exact `show` (`terms/show`) and `accept` (`terms/accept`) calls to make. Each provider's `digest` (and `accept.options.digest`) is always present and can be `null`, meaning the catalog didn't publish one. In that case, run `terms/show` first and send the digest it returns.

```json theme={null}
{
  "status": "completed",
  "exchange": {
    "enabled": true,
    "onTermsRequired": "ask",
    "paidCalls": 0,
    "creditsUsed": null,
    "skippedProviders": [
      {
        "provider": "apollo",
        "name": "Apollo",
        "capability": "people/search",
        "adds": "verified work emails and direct phone numbers",
        "reason": "terms_required",
        "version": "F-1.0.0",
        "termsUrl": "https://www.firecrawl.dev/app/alexandria/apollo"
      }
    ],
    "requiresAction": {
      "type": "accept_terms",
      "approvalId": "0199aaaa-0000-7000-8000-000000000000",
      "providers": [
        {
          "provider": "apollo",
          "name": "Apollo",
          "capability": "people/search",
          "version": "F-1.0.0",
          "digest": "<sha256>",
          "url": "https://www.firecrawl.dev/app/alexandria/apollo",
          "show": { "provider": "firecrawl", "capability": "terms/show", "options": { "provider": "apollo" } },
          "accept": {
            "provider": "firecrawl",
            "capability": "terms/accept",
            "options": { "provider": "apollo", "version": "F-1.0.0", "digest": "<sha256>", "confirmed": true }
          }
        }
      ]
    }
  },
  "pendingApproval": {
    "id": "0199aaaa-0000-7000-8000-000000000000",
    "kind": "terms",
    "reason": "Apollo could add verified work emails and direct phone numbers.",
    "calls": [],
    "terms": [{ "provider": "apollo", "name": "Apollo", "version": "F-1.0.0", "digest": "<sha256>", "url": "https://www.firecrawl.dev/app/alexandria/apollo" }],
    "resolution": null
  }
}
```

### Accept, then continue

In `ask` mode:

1. Show your user the terms. Run the provider's `show` call through [`/v2/scrape`](/features/alexandria) with `alexandria`.
2. Only if the user explicitly agrees, run its `accept` call the same way. If `accept.options.digest` is `null`, use the digest `terms/show` returned:

```bash theme={null}
curl -X POST https://api.firecrawl.dev/v2/scrape \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "alexandria": {
      "provider": "firecrawl",
      "capability": "terms/accept",
      "options": { "provider": "apollo", "version": "F-1.0.0", "digest": "<sha256>", "confirmed": true }
    }
  }'
```

3. Continue the same thread with `exchange.approve`. The offer is accepted as a whole, and `callIds` and `always` are ignored on it. The next turn uses those providers to fill the gap the previous answer named, rather than re-running everything.

```bash theme={null}
curl -X POST https://api.firecrawl.dev/v2/agent \
  -H "Authorization: Bearer $FIRECRAWL_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "threadId": "<threadId from the previous run>",
    "prompt": "Continue with Apollo.",
    "exchange": {
      "approve": { "approvalId": "0199aaaa-0000-7000-8000-000000000000" }
    }
  }'
```

To go on without the provider, continue with `exchange.decline: { "approvalId": "..." }` instead. This declines the whole offer, and its providers aren't offered again for the rest of the thread.

In `skip` mode there's no pending approval to answer. After the terms are accepted, start a new run (or a new turn of the thread) and the provider is available.

## Parameters

| Parameter | Type | Required | Description |
| - | - | - | - |
| `prompt` | string | **Yes** | Natural language description of the data you want to extract (max 10,000 characters) |
| `model` | string | No | Defaults to `spark-2`, the model every run executes on. Spark 1 models are deprecated and route to `spark-2` |
| `effort` | string | No | Reasoning budget: `low`, `medium`, or `high`. Every run executes on `spark-2`, so `effort` can be sent with or without `model` |
| `urls` | array | No | Optional list of URLs to focus the extraction |
| `schema` | object | No | Optional JSON schema for structured output |
| `strictConstrainToURLs` | boolean | No | If `true`, the agent only visits the URLs provided in the `urls` array |
| `webhook` | object | No | Webhook to receive agent lifecycle events (`agent.started`, `agent.action`, `agent.completed`, `agent.failed`, `agent.cancelled`). See the [webhook payloads](/api-reference/endpoint/webhook-agent-started) |
| `maxCredits` | number | No | Maximum number of credits to spend on this agent task. Defaults to **2,500** if not set. The dashboard supports values up to **2,500**; for higher limits, set `maxCredits` via the API (values above 2,500 are always treated as paid requests). If the limit is reached, the job fails and **no data is returned**. Failed runs are not billed: credits used for AI reasoning are never charged on failure, any credits used for tool calls during the run (scraping, search, mapping, etc.) are refunded, and the response reports `creditsUsed: 0`. |
| `exchange.onTermsRequired` | string | No | What to do when an Alexandria data provider the agent would use needs terms your team has not accepted: `skip` (default) or `ask`. See [Data providers that need terms](#data-providers-that-need-terms) |

## Agent vs Extract: What's Improved

| Feature | Agent (New) | Extract |
| - | - | - |
| URLs Required | No | Yes |
| Speed | Faster | Standard |
| Cost | Lower | Standard |
| Reliability | Higher | Standard |
| Query Flexibility | High | Moderate |

## Example Use Cases

* **Research**: "Find the top 5 AI startups and their funding amounts"
* **Competitive Analysis**: "Compare pricing plans between Slack and Microsoft Teams"
* **Data Gathering**: "Extract contact information from company websites"
* **Content Summarization**: "Summarize the latest blog posts about web scraping"

## CSV Upload in Agent Playground

The [Agent Playground](https://www.firecrawl.dev/app/agent) supports CSV upload for batch processing. Your CSV can contain one or more columns of input data. For example, a single column of company names, or multiple columns such as company name, product, and website URL. Each row represents one item for the agent to process.

Upload your CSV, then add output columns using the "+" button in the grid header. Each column has its own prompt — click a column header to describe what the agent should find for that field (e.g., "CEO or founder name", "Total funding raised"). Hit Run, and the agent processes each row in parallel, filling in the results.

## Troubleshooting with Ask

If your agent jobs fail or return unexpected results, use the [Ask API](/features/ask) for agentic debugging. Describe the issue and get back a verified answer with fix parameters you can apply directly:

```bash theme={null}
curl -X POST https://api.firecrawl.dev/v2/support/ask \
  -H "Authorization: Bearer fc-YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "question": "my agent returned incomplete results"
  }'
```

See the [Ask documentation](/features/ask) for full details and integration examples.

## API Reference

Check out the [Agent API Reference](/api-reference/endpoint/agent) for more details.

Have feedback or need help? Email [help@firecrawl.com](mailto:help@firecrawl.com).

## Pricing

Firecrawl Agent uses **dynamic billing** that scales with the complexity of your data extraction request. You pay based on the actual work Agent performs, ensuring fair pricing whether you're extracting simple data points or complex structured information from multiple sources.

### How Agent pricing works

Agent pricing is **dynamic and credit-based** during Research Preview:

* **Simple extractions** (like contact info from a single page) typically use fewer credits and cost less
* **Complex research tasks** (like competitive analysis across multiple domains) use more credits but reflect the total effort involved
* **Transparent usage** shows you exactly how many credits each request consumed
* **Credit conversion** automatically converts agent credit usage to credits for easy billing


  Credit usage varies based on the complexity of your prompt, the amount of data processed, and the structure of the output requested. As a rough guide, most agent runs consume **a few hundred credits**, though simpler single-page tasks may use less and complex multi-domain research may use more.


### Parallel Agents Pricing

If you are running multiple agents in parallel with Spark-1 Fast, pricing is a lot more predictable at 10 credits per cell.

### Getting started

**All users** receive **5 free daily runs**, which can be used from either the playground or the API, to explore Agent's capabilities without any cost.

Additional usage is billed based on credit consumption and converted to credits.

### Managing costs

Agent can be expensive, but there are some ways to decrease the cost:

* **Start with free runs**: Use your 5 daily free requests to understand pricing
* **Set a `maxCredits` parameter**: Limit your spending by setting a maximum number of credits you're willing to spend. The dashboard caps this at 2,500 credits; to set a higher limit, use the `maxCredits` parameter directly via the API (note: values above 2,500 are always billed as paid requests)
* **Optimize prompts**: More specific prompts often use fewer credits
* **Break large tasks into smaller runs**: A single agent run returns roughly 150-200 rows of structured data. For large extraction jobs, split by category, region, or URL batch (3-5 URLs per run) and merge the results. This also keeps each run well under the `maxCredits` limit.
* **Monitor usage**: Track your consumption through the dashboard
* **Set expectations**: Complex multi-domain research will use more credits than simple single-page extractions

Try Agent now at [firecrawl.dev/app/agent](https://www.firecrawl.dev/app/agent) to see how credit usage scales with your specific use cases.


  Pricing is subject to change as we move from Research Preview to general availability. Current users will receive advance notice of any pricing updates.


> Are you an AI agent that needs a Firecrawl API key? See [firecrawl.dev/agent-onboarding/SKILL.md](https://www.firecrawl.dev/agent-onboarding/SKILL.md) for automated onboarding instructions.
