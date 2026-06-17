<!-- Source: https://flueframework.com/docs/ecosystem/deploy/docker -->

Package the Flue Node.js build as a container image that runs on any platform that takes one. For the underlying build and runtime behavior, see [Deploy Agents on Node.js](https://flueframework.com/docs/ecosystem/deploy/node/).

Flue’s Node target is a long-running HTTP server, not a function. The container must stay up to hold agent sessions and serve streamed responses; deploy it as a service, not a scale-to-zero invocation.

## Dockerfile [\#](https://flueframework.com/docs/ecosystem/deploy/docker/\#dockerfile)

A multi-stage build keeps the runtime image lean: compile the Node target in the first stage, ship only production dependencies and `dist/` in the second.

```
# syntax=docker/dockerfile:1

FROM node:22-slim AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npx flue build --target node

FROM node:22-slim AS runtime
WORKDIR /app
ENV NODE_ENV=production
COPY package.json package-lock.json ./
RUN npm ci --omit=dev
COPY --from=build /app/dist ./dist
USER node
ENV PORT=8080
EXPOSE 8080
CMD ["node", "dist/server.mjs"]
```

The build externalizes your application dependencies rather than bundling them, so the runtime stage installs production dependencies (`@flue/cli` stays a build-only dependency and is dropped by `--omit=dev`). Add a `.dockerignore` for `node_modules`, `dist`, `.git`, and `.env` so local artifacts and secrets never enter the image.

The official `node` images ship a non-root `node` user (uid 1000); `USER node` drops superuser privileges in the running container. Node was not designed to run as PID 1 and won’t reap children or forward signals cleanly, so run the container with an init — `docker run --init` (shown below) or a baked-in `tini`/`dumb-init` — so `SIGTERM` reaches the server for a graceful shutdown of in-flight streams.

The server binds `PORT` (default `3000`; this image sets `8080`). Match it to whatever your platform expects.

## Build and run [\#](https://flueframework.com/docs/ecosystem/deploy/docker/\#build-and-run)

```
docker build -t flue-agents .
docker run --init -p 8080:8080 -e ANTHROPIC_API_KEY=sk-... flue-agents
```

## Environment and secrets [\#](https://flueframework.com/docs/ecosystem/deploy/docker/\#environment-and-secrets)

The built server reads only the environment supplied when the container starts — it does not load `.env`. Pass your model provider key (`ANTHROPIC_API_KEY`, `OPENAI_API_KEY`, …) and an optional `MODEL_SPECIFIER` at run time, and inject them through your platform’s secret store rather than baking them into the image:

```
docker run --init -p 8080:8080 \
  -e MODEL_SPECIFIER=anthropic/claude-sonnet-4-6 \
  -e ANTHROPIC_API_KEY=sk-... \
  flue-agents
```

## Persistence [\#](https://flueframework.com/docs/ecosystem/deploy/docker/\#persistence)

Without a `db.ts` adapter the server keeps agent sessions, accepted submissions, and workflow-run records in process-local memory — they are lost when the container restarts or redeploys, and they are not shared across replicas. For durable state, or to run more than one instance, add a [`PersistenceAdapter`](https://flueframework.com/docs/guide/database/) backed by a Postgres reachable from the container:

```
import { postgres } from '@flue/postgres';

export default postgres(process.env.DATABASE_URL!);
```

Flue discovers `db.ts` at build time and wires it into the generated server. Provide `DATABASE_URL` as an environment variable like any other secret.

## Health and streaming [\#](https://flueframework.com/docs/ecosystem/deploy/docker/\#health-and-streaming)

Flue does not generate a health endpoint. If your platform health-checks the container, define the route it expects (commonly `/health`) in your `app.ts`.

Streamed agent and workflow responses use long-lived `GET /runs/:runId` connections (long-poll / SSE). Make sure the platform’s request and idle-connection timeouts allow them, or have clients read stream coordinates from the `202` admission response and reconnect.

## References [\#](https://flueframework.com/docs/ecosystem/deploy/docker/\#references)

- [Docker — Containerize a Node.js application](https://docs.docker.com/guides/nodejs/containerize/) (official): multi-stage builds, `.dockerignore`, `EXPOSE`/`PORT`.
- [Node.js Docker — Best Practices](https://github.com/nodejs/docker-node/blob/main/docs/BestPractices.md) (official): `NODE_ENV=production`, non-root `node` user, `--init`/tini for PID-1 signal handling.
- [Docker run reference — init process](https://docs.docker.com/engine/reference/run/#specify-an-init-process) (official): the `--init` flag.
- [Snyk — 10 best practices to containerize Node.js with Docker](https://snyk.io/blog/10-best-practices-to-containerize-nodejs-web-applications-with-docker/): non-root `USER`, exec-form `CMD`, graceful shutdown.

## Docs Navigation

Current page: [Deploy Agents with Docker](https://flueframework.com/docs/ecosystem/deploy/docker/)

### Sections

- [Guide](https://flueframework.com/docs/getting-started/quickstart/)
- [Reference](https://flueframework.com/docs/api/agent-api/)
- [CLI](https://flueframework.com/docs/cli/overview/)
- [SDK](https://flueframework.com/docs/sdk/overview/)
- [Ecosystem](https://flueframework.com/docs/ecosystem/)
