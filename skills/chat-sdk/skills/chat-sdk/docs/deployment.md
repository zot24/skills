<!-- Source: https://chat-sdk.dev/docs/deploying -->

# Deploying

Deploying to Vercel is the quickest way to get started with the Chat SDK, as it automatically sets up the project by connecting to integrations.

## Requirements

Before deploying, you will need:

- A Vercel account with the Vercel CLI installed
- A GitHub, GitLab, or Bitbucket account

## One-Click Deploy to Vercel

Use the "Deploy with Vercel" button to deploy the Next.js AI Chatbot:

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fvercel%2Fai-chatbot)

During setup, you will configure:

1. A PostgreSQL database (via Neon integration)
2. Blob storage (via Vercel Blob integration)
3. An `AUTH_SECRET` environment variable for authentication seeding

Once complete, Vercel supplies a URL to access your deployed chatbot.

## Setting Up Local Development

After deploying, clone your repository and establish a connection to your Vercel deployment:

```bash
git clone https://github.com/<username>/<repository>
cd <repository>
pnpm install
vercel link
vercel env pull
```

Launch the development environment with `pnpm dev`, and access your chatbot at `http://localhost:3000`.

This approach lets you pull the environment variables from the Vercel project and use them locally, streamlining the development workflow while maintaining consistency with your cloud deployment.

## Environment Variables

| Variable | Description |
|----------|-------------|
| `AUTH_SECRET` | Authentication secret (generate with `npx auth secret`) |
| `AI_GATEWAY_API_KEY` | AI Gateway API key (for non-Vercel deployments) |
| `DATABASE_URL` | Neon Postgres connection string |
| `BLOB_READ_WRITE_TOKEN` | Vercel Blob token |

## Production Checklist

- [ ] Set strong `AUTH_SECRET`
- [ ] Configure production database
- [ ] Enable HTTPS
- [ ] Set up monitoring (Vercel Analytics)
- [ ] Configure rate limiting on `/api/chat`
- [ ] Review security headers
- [ ] Test authentication flow
- [ ] Verify file upload limits
