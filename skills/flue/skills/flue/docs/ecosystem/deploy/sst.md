> Source: https://flueframework.com/docs/ecosystem/deploy/sst

<a href="#main-content" class="fixed left-4 -top-16 z-[100] rounded-lg bg-blue-500 px-3 py-2 text-white focus:top-4">Skip to content</a>


<a href="https://flueframework.com" class="flex items-center gap-2" aria-label="Flue homepage"><span class="text-2xl font-extrabold tracking-tight text-gray-950 leading-8">Flue</span></a>


Esc


Start typing to search the documentation.


<a href="https://github.com/withastro/flue" class="hidden text-gray-500 transition-colors hover:text-gray-950 focus-visible:text-gray-950 docs-desktop:inline-flex" target="_blank" rel="noopener noreferrer" aria-label="GitHub"></a>


# Deploy Agents on SST


Last updated Jul 21, 2026<a href="/docs/ecosystem/deploy/sst/index.md" class="inline-flex items-center gap-2 text-gray-500 transition-colors hover:text-gray-800">View as Markdown</a>


[SST](https://sst.dev) is a TypeScript infrastructure-as-code framework for AWS. You describe your infrastructure as components in a single `sst.config.ts` file and deploy it with `sst deploy`. This guide deploys a Flue agent as a persistent container service, not as a Lambda function: Flue’s streaming responses use long-lived conversation `GET` connections, and its default coordinator keeps state in memory, so it must run as an always-on process. SST’s `sst.aws.Service` component runs exactly that — a container on AWS Fargate behind a load balancer.

This guide builds on the [Docker](/docs/ecosystem/deploy/docker/) guide. SST builds and pushes the image from that same `Dockerfile`; the steps below cover the SST-specific wiring — the service, secrets, and database. The `vite build` output (`dist/server.mjs`, started with `node dist/server.mjs`) and its runtime contract are unchanged from the [Node.js](/docs/ecosystem/deploy/node/) guide.

This guide was written against SST v3 (the Ion engine, the current major line). SST’s component API moves quickly; confirm field names against the current [SST docs](https://sst.dev/docs/) for your installed version.

## The service

An `sst.aws.Service` runs on an `sst.aws.Cluster`, which needs an `sst.aws.Vpc`. The service builds the container from your `Dockerfile` and exposes it through a load balancer. Point the load balancer’s `forward` port at the port your Dockerfile’s server listens on — the [Docker](/docs/ecosystem/deploy/docker/) guide binds `PORT=8080`, so the examples below forward to `8080`.

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="typescript"><code>/// &lt;reference path=&quot;./.sst/platform/config.d.ts&quot; /&gt;

export default $config({
  app(input) {
    return {
      name: &#39;flue-agents&#39;,
      home: &#39;aws&#39;,
      removal: input.stage === &#39;production&#39; ? &#39;retain&#39; : &#39;remove&#39;,
    };
  },
  async run() {
    const vpc = new sst.aws.Vpc(&#39;FlueVpc&#39;);
    const cluster = new sst.aws.Cluster(&#39;FlueCluster&#39;, { vpc });

    new sst.aws.Service(&#39;Flue&#39;, {
      cluster,
      image: { context: &#39;.&#39;, dockerfile: &#39;Dockerfile&#39; },
      loadBalancer: {
        rules: [{ listen: &#39;80/http&#39;, forward: &#39;8080/http&#39; }],
      },
    });
  },
});</code></pre>
<figcaption><span>sst.config.ts</span></figcaption>
</figure>

`sst deploy` builds the image from the `Dockerfile`, pushes it to ECR, and provisions the cluster, service, and load balancer. The service URL is printed at the end of the deploy.

## Environment and secrets

Flue’s built server reads its provider key and model from the environment at start time. SST’s `link` exposes resources through the `sst` SDK’s `Resource` object at runtime, but the Flue server does not import that SDK — it reads plain `process.env`. So pass values the server needs through the service’s `environment` field, not through `link` alone.

Define the provider key as an `sst.Secret` so its value stays out of source, then interpolate it into `environment`:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="typescript"><code>const apiKey = new sst.Secret(&#39;AnthropicApiKey&#39;);

new sst.aws.Service(&#39;Flue&#39;, {
  cluster,
  image: { context: &#39;.&#39;, dockerfile: &#39;Dockerfile&#39; },
  loadBalancer: { rules: [{ listen: &#39;80/http&#39;, forward: &#39;8080/http&#39; }] },
  link: [apiKey],
  environment: {
    ANTHROPIC_API_KEY: apiKey.value,
    MODEL_SPECIFIER: &#39;anthropic/claude-sonnet-4-6&#39;,
  },
});</code></pre>
<figcaption><span>sst.config.ts</span></figcaption>
</figure>

Use `OPENAI_API_KEY` (and an `openai/...` `MODEL_SPECIFIER`) instead for OpenAI, matching the env var your provider expects. Set the secret’s value once per stage with the CLI:

``` astro-code
sst secret set AnthropicApiKey sk-...
```

Linking the secret grants the service permission to read it; the `environment` entry is what surfaces it to the Flue process as `process.env.ANTHROPIC_API_KEY`.

## Persistence

On a single Fargate task, Flue’s canonical conversations, attachments, and accepted submissions live in memory, so they are lost when the task restarts or redeploys. Back them with Postgres when state must survive replacement or be available to replacement tasks. Shared storage does not enable active-active agent execution: route each agent instance to one live task.

The `sst.aws.Postgres` component provisions an RDS Postgres instance in the VPC and exposes its connection parts as outputs (`host`, `port`, `username`, `password`, `database`). Construct a `DATABASE_URL` from those with `$interpolate` and pass it through `environment`:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="typescript"><code>const db = new sst.aws.Postgres(&#39;FlueDb&#39;, { vpc });

new sst.aws.Service(&#39;Flue&#39;, {
  cluster,
  image: { context: &#39;.&#39;, dockerfile: &#39;Dockerfile&#39; },
  loadBalancer: { rules: [{ listen: &#39;80/http&#39;, forward: &#39;8080/http&#39; }] },
  link: [apiKey, db],
  environment: {
    ANTHROPIC_API_KEY: apiKey.value,
    MODEL_SPECIFIER: &#39;anthropic/claude-sonnet-4-6&#39;,
    DATABASE_URL: $interpolate`postgresql://${db.username}:${db.password}@${db.host}:${db.port}/${db.database}`,
  },
});</code></pre>
<figcaption><span>sst.config.ts</span></figcaption>
</figure>

Install `@flue/postgres` and add a `db.ts` that wraps your configured `pg` pool and reads `DATABASE_URL` — see [Postgres](/docs/ecosystem/databases/postgres/) for the full bring-your-own-driver runner:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="typescript"><code>import { postgres } from &#39;@flue/postgres&#39;;
import { Pool } from &#39;pg&#39;;

const pool = new Pool({ connectionString: process.env.DATABASE_URL });

export default postgres({
  query: async (text, params) =&gt; (await pool.query(text, params)).rows,
  transaction: async (fn) =&gt; {
    /* one checked-out client per transaction; see the Postgres guide */
  },
  close: () =&gt; pool.end(),
});</code></pre>
<figcaption><span>src/db.ts (abridged)</span></figcaption>
</figure>

Flue discovers `db.ts` at build time and wires it into the generated server. The adapter handles schema creation, canonical conversation streams, immutable attachments, and durable submission state. Because the Postgres instance and the service share the VPC, the service reaches the database over the private network. See [Database](/docs/guide/database/) for the adapter contract and other backends.

## Health and streaming

The load balancer health-checks the service before it routes traffic, and the check defaults to path `/`. Flue does not generate a `/health` route — define one in `app.ts`, or the load balancer will treat the default health-check path as unhealthy if `/` doesn’t return a `200`. Once that route exists, point the check at it through the service’s `loadBalancer.health` field, which is keyed by the forwarded `'port/protocol'`:

<figure class="astro-code-figure">
<pre class="astro-code github-light" style="background-color:#fff;color:#24292e; overflow-x: auto;" tabindex="0" data-language="typescript"><code>loadBalancer: {
  rules: [{ listen: &#39;80/http&#39;, forward: &#39;8080/http&#39; }],
  health: {
    &#39;8080/http&#39;: { path: &#39;/health&#39; },
  },
},</code></pre>
<figcaption><span>sst.config.ts</span></figcaption>
</figure>

`sst.aws.Service` also accepts a container-level `health` command (run by ECS, e.g. `{ command: ['CMD-SHELL', 'curl -f http://localhost:8080/health || exit 1'] }`) if you prefer an ECS health check.

Agent conversations hold long-lived `GET` reads open on the conversation URL (long-poll or SSE). Load balancer idle timeouts can cut these off; for slow work, retain the admission’s `streamUrl` and `offset`, raise the idle timeout, and resume the conversation stream rather than holding one blocking request. See the [Streaming Protocol](/docs/reference/streaming-protocol/).

## Going further

SST stages give you independent environments from one config — `sst deploy --stage production` and `sst deploy --stage dev` provision separate copies, and `sst secret set` scopes values per stage. Run `sst deploy` from CI or locally; `sst remove --stage <name>` tears a stage down. See the [SST docs](https://sst.dev/docs/) for autodeploy, custom domains on the load balancer, and scaling the service. Multiple tasks require shared durable storage plus instance-affine routing so one live task owns each agent instance.

## References

- [SST Service component](https://sst.dev/docs/component/aws/service/) — Fargate container service, load balancer, and health-check fields.
- [SST Postgres component](https://sst.dev/docs/component/aws/postgres/) — RDS Postgres and its `host`/`port`/`username`/`password`/`database` outputs.
- [SST Secret component](https://sst.dev/docs/component/secret/) — `new sst.Secret()`, `sst secret set`, and `.value`.
- [SST containers on AWS](https://sst.dev/docs/start/aws/container/) — official walkthrough for deploying a container service.


## Docs Navigation

Current page: [Deploy Agents on SST](/docs/ecosystem/deploy/sst/)

### Sections

- [Guide](/docs/guide/getting-started/)
- [Reference](/docs/reference/agent-api/)
- [CLI](/docs/cli/overview/)
- [Agent SDK](/docs/sdk/overview/)
- [Ecosystem](/docs/ecosystem/)


