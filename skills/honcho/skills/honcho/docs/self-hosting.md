<!-- Source: https://docs.honcho.dev/v3/contributing/self-hosting -->

# Self-Hosting / Local Environment Setup

## Overview

Establish a local Honcho instance with PostgreSQL and pgvector for development, testing, or self-hosted deployments.

## Prerequisites

- **uv** (Python package manager)
- **Git**
- **Docker** (optional, for containerized setup)
- PostgreSQL with pgvector extension

## LLM Configuration

At least one LLM provider with tool-calling support is required. The server will fail to start without a provider configured.

1. Set endpoint and API key (OpenAI-compatible services like OpenRouter, Together, or Ollama work)
2. Specify model names across DERIVER_MODEL, SUMMARY_MODEL, DREAM_MODEL, and DIALECTIC_LEVELS settings

## Docker Setup (Recommended)

```bash
git clone https://github.com/plastic-labs/honcho.git
cd honcho
cp .env.template .env
cp docker-compose.yml.example docker-compose.yml
```

Edit `.env` with your LLM provider details, then start services:

```bash
docker compose up -d --build
```

This launches the API (port 8000), deriver worker, PostgreSQL database, and Redis cache.

## Manual Setup

Install dependencies via uv, set up PostgreSQL locally or via Docker. Create a `.env` file with database connection string and LLM credentials. Run migrations and start both the FastAPI server and deriver worker in separate terminals.

## Verification

- Health check: `curl http://localhost:8000/health`
- Database test: Create a workspace via POST request
- API docs: Visit `http://localhost:8000/docs`

## Production Deployment

Enable authentication, implement HTTPS via reverse proxy (Caddy or nginx), secure database credentials, and configure monitoring through Prometheus and Sentry if needed. Scale the deriver by increasing worker count or running multiple instances.
