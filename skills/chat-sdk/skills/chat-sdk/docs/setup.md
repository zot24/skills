<!-- Source: https://chat-sdk.dev/docs/setup -->

# Setup

This guide covers setting up Chat SDK for local development and production deployment. There are two pathways available.

## Option 1: One-Click Deploy with Vercel (Recommended)

The quickest approach uses Vercel's one-click deployment:

1. Click the "Deploy with Vercel" button in the repository
2. Create a new project and associated repository
3. Vercel integrates services like Neon Postgres and AI Gateway automatically
4. Clone the repository locally and connect via `vc link`
5. Pull environment variables through `vc env pull`
6. Proceed with local development
7. Pushing code changes automatically triggers redeployment

## Option 2: Local Development with Deferred Deployment

For developers preferring to establish local infrastructure first:

1. Fork the Chat SDK repository on GitHub
2. Clone your forked copy locally
3. Create a PostgreSQL database and configure the `DATABASE_URL` environment variable in `.env.local`
4. Create a Vercel Blob store and set `BLOB_READ_WRITE_TOKEN` in `.env.local`
5. Configure AI Gateway and establish the `AI_GATEWAY_API_KEY` environment variable
6. Execute `pnpm install` for dependency installation
7. Launch the development environment using `pnpm dev`

## Environment Variables

Required variables in `.env.local`:

```bash
# Authentication
AUTH_SECRET=your-auth-secret  # Generate with: npx auth secret

# AI Gateway (for non-Vercel deployments)
AI_GATEWAY_API_KEY=your-gateway-key

# Database
DATABASE_URL=your-neon-postgres-url

# Storage
BLOB_READ_WRITE_TOKEN=your-vercel-blob-token
```

## Database Setup

Run migrations to create the required tables:

```bash
pnpm db:migrate
```

## Running the Development Server

```bash
pnpm dev
```

The app will be available at [http://localhost:3000](http://localhost:3000).

## Vercel CLI Workflow

For the best experience with environment variables:

```bash
# Install Vercel CLI
npm i -g vercel

# Link to your Vercel project
vercel link

# Pull environment variables
vercel env pull
```

This automatically syncs your production environment variables locally.

## Infrastructure

Both pathways enable developers to work with:
- **PostgreSQL** (via Neon) - Chat history and user data
- **Vercel Blob** - File storage for attachments and avatars
- **AI Gateway** - Unified access to multiple AI model providers
