<!-- Source: https://docs.umami.is/docs/install -->

# Installation

## From Source

### Requirements
- Node.js 18.18 or newer
- PostgreSQL (minimum v12.14) — configure to use UTC timezone

### Steps

```bash
# Install pnpm
npm install -g pnpm

# Clone and install
git clone https://github.com/umami-software/umami.git
cd umami
pnpm install

# Configure database
echo 'DATABASE_URL=postgresql://username:mypassword@localhost:5432/mydb' > .env

# Build (creates tables, default credentials: admin/umami)
pnpm build

# Start on http://localhost:3000
pnpm start
```

Use PM2 for production: `pm2 start pnpm --name umami -- start`

## Docker Compose

```bash
git clone https://github.com/umami-software/umami.git
cd umami
docker-compose up -d
# Access at http://localhost:3000 (admin/umami)
```

Automatically creates PostgreSQL database.

## Pre-built Docker Image

```bash
docker pull docker.umami.is/umami-software/umami:postgresql-latest
```

Requires providing your own database and setting `DATABASE_URL`.

## Umami Cloud

Managed hosting at https://cloud.umami.is — no self-hosting required.

## Post-Install

**Change the default password immediately** after first login (admin/umami).
