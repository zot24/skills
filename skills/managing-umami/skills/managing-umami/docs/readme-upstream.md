<!-- Source: https://raw.githubusercontent.com/umami-software/umami/master/README.md -->

# Umami

A simple, fast, privacy-focused alternative to Google Analytics.

## Getting Started

A detailed getting started guide can be found at https://umami.is/docs.

## Installing from Source

### Requirements

- A server with Node.js version 18.18 or newer
- A database. Umami supports PostgreSQL (minimum v12.14).

### Install pnpm

```bash
npm install -g pnpm
```

### Get the source code and install packages

```bash
git clone https://github.com/umami-software/umami.git
cd umami
pnpm install
```

### Configure Umami

Create an `.env` file with the following:

```
DATABASE_URL=postgresql://username:mypassword@localhost:5432/mydb
```

### Build the application

```bash
pnpm build
```

The build step will create tables in your database. It will also create a login user with username **admin** and password **umami**.

### Start the application

```bash
pnpm start
```

By default this will launch the application on `http://localhost:3000`.

## Installing with Docker

To build the Umami container and start up a Postgres database, run:

```bash
docker-compose up -d
```

Alternatively, pull a pre-built image:

```bash
docker pull docker.umami.is/umami-software/umami:postgresql-latest
```

## Getting Updates

To get the latest features, pull the latest code from the repository and rebuild:

```bash
cd umami
git pull
pnpm install
pnpm build
```

For Docker, pull the latest image and recreate the container.

## License

MIT
