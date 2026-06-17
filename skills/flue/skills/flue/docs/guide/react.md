<!-- Source: https://flueframework.com/docs/guide/react -->

`@flue/react` turns Flue’s durable event streams into live React state. Use `useFlueAgent()` for a continuing conversation with an agent instance and `useFlueWorkflow()` to observe a finite workflow run. HTTP requests, authentication, and stream transport remain in `@flue/sdk`.

## Set up React [\#](https://flueframework.com/docs/guide/react/\#set-up-react)

Install both packages, create one SDK client, and provide it to your application:

```
pnpm add @flue/react @flue/sdk
```

```
import { FlueProvider } from '@flue/react';
import { createFlueClient } from '@flue/sdk';
import { createRoot } from 'react-dom/client';
import { App } from './App.tsx';

const client = createFlueClient({ baseUrl: '/api' });

createRoot(document.getElementById('root')!).render(
  <FlueProvider client={client}>
    <App />
  </FlueProvider>,
);
```

Configure authentication, headers, and custom `fetch` behavior on the client. The agent and workflow modules used below must export `route`; mounting `flue()` alone does not expose them. See [Routing](https://flueframework.com/docs/guide/routing/) to expose and protect the Flue API, including cross-origin applications.

## Build an agent conversation [\#](https://flueframework.com/docs/guide/react/\#build-an-agent-conversation)

An agent instance is identified by its agent name and instance ID. The hook reconstructs its transcript from durable events, then follows new events:

```
import { useFlueAgent } from '@flue/react';
import { useState } from 'react';

export function Chat({ conversationId }: { conversationId: string }) {
  const [input, setInput] = useState('');
  const agent = useFlueAgent({
    name: 'support-assistant',
    id: conversationId,
  });

  async function submit(event: React.FormEvent) {
    event.preventDefault();
    const message = input.trim();
    if (!message) return;

    setInput('');
    await agent.sendMessage(message);
  }

  return (
    <section>
      <div aria-live="polite">
        {agent.messages.map((message) => (
          <article key={message.id}>
            <strong>{message.role}</strong>
            {message.parts.map((part) =>
              part.type === 'text' ? <p key={part.text}>{part.text}</p> : null,
            )}
          </article>
        ))}
      </div>

      <form onSubmit={submit}>
        <input value={input} onChange={(event) => setInput(event.target.value)} />
        <button disabled={!input.trim()} type="submit">
          Send
        </button>
      </form>
    </section>
  );
}
```

`sendMessage()` adds the user message immediately and resolves when the server admits the prompt, not when generation finishes. The stream then reconciles that optimistic message with its durable copy. Use `status` to distinguish connection, submission, streaming, and error states.

Messages use a parts-based shape for text, reasoning, tool activity, and images. This shape mirrors AI SDK v5 `UIMessage`, but `@flue/react` neither depends on `ai` at runtime nor implements its transport protocol.

By default, the hook rebuilds a transcript from the latest 100 server events rather than browser storage. Pass `history: 'all'` when the complete transcript is required. Streaming deltas provide best-effort live progress, while `message_end` supplies the authoritative completed assistant message. If the hook attaches after generation starts, earlier partial output may be absent until `message_end` arrives. This delivery behavior does not affect the runtime’s internal interrupted-turn recovery.

## Observe a workflow run [\#](https://flueframework.com/docs/guide/react/\#observe-a-workflow-run)

Workflow invocation and observation are separate. Invoke the workflow with the SDK, retain its `runId`, and pass that ID to `useFlueWorkflow()`:

```
import { useFlueClient, useFlueWorkflow } from '@flue/react';
import { useState } from 'react';

export function Report() {
  const flue = useFlueClient();
  const [runId, setRunId] = useState<string>();
  const run = useFlueWorkflow({ runId });

  async function generate() {
    const invocation = await flue.workflows.invoke('weekly-report', {
      payload: { week: 'current' },
    });
    setRunId(invocation.runId);
  }

  return (
    <section>
      <button onClick={generate} type="button">
        Generate report
      </button>
      <p>{run.status}</p>
      {run.logs.map((event) => (
        <pre key={`${event.timestamp}:${event.eventIndex}`}>{event.message}</pre>
      ))}
    </section>
  );
}
```

The hook replays the complete run before following live events, so it can attach before, during, or after execution. `events` contains the full event history, `logs` selects log events, and `result` or `error` records the terminal outcome.

Transport failures reconnect from the last durable checkpoint. A workflow failure instead produces the terminal `errored` status; observation that ends without a terminal workflow event becomes `disconnected`.

## Rendering and deferred identity [\#](https://flueframework.com/docs/guide/react/\#rendering-and-deferred-identity)

During server rendering, both hooks return empty, idle state and open no connections. The SDK client still needs an absolute `baseUrl` when it is created on the server; relative paths such as `/api` are browser-only. An omitted agent `id` or workflow `runId` also leaves the hook dormant while routing or application data resolves the identity.

## API reference [\#](https://flueframework.com/docs/guide/react/\#api-reference)

See the [`@flue/react` package README](https://github.com/withastro/flue/tree/main/packages/react#readme) for complete options, result types, statuses, and message-part types.

## Docs Navigation

Current page: [React](https://flueframework.com/docs/guide/react/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
