> Source: https://docs.umami.is/docs/install



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2 text-xl font-bold text-foreground tracking-[-0.03em]" target="_blank" rel="noreferrer"><img src="/logo.svg" class="h-6 w-auto dark:hidden" /><img src="/logo.svg" class="hidden h-6 w-auto dark:block" /><span>umami</span></a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center rounded-md text-sm font-medium text-foreground hover:bg-accent hover:text-foreground size-8 justify-center" target="_blank" rel="noreferrer" aria-label="Umami on GitHub"></a>


Menu


Umami


# Installation


Copy page


There are several different ways to install Umami.

- **Installing from source**: Get the code from [GitHub](https://github.com/umami-software/umami) and build the application yourself.
- **Using Docker compose**: Build your own Docker container using `docker compose`.
- **Using a Docker image**: Download a pre-built Docker image.
- **Using Kubernetes with HelmForge**: Deploy Umami with a third-party Helm chart maintained by the HelmForge project. See the [Running on Kubernetes with HelmForge](/docs/guides/running-on-helmforge) guide.

## Installing from source<a href="#installing-from-source" class="heading-anchor" aria-label="Permalink to “Installing from source”">#</a>

### Requirements<a href="#requirements" class="heading-anchor" aria-label="Permalink to “Requirements”">#</a>

- A server with [Node.js](https://nodejs.org/) version 18.18 or newer.
- A database. Umami supports [PostgreSQL](https://www.postgresql.org/) (minimum v12.14) databases.


Use UTC


We recommend configuring the PostgreSQL database to use the **UTC** timezone. UTC avoids issues caused by regional offsets, ensuring consistent, predictable timestamps across environments, services, and deployments.


### Install pnpm<a href="#install-pnpm" class="heading-anchor" aria-label="Permalink to “Install pnpm”">#</a>


``` code-block
npm install -g pnpm
```


### Get the source code and install packages<a href="#get-the-source-code-and-install-packages" class="heading-anchor" aria-label="Permalink to “Get the source code and install packages”">#</a>


``` code-block
git clone https://github.com/umami-software/umami.git
cd umami
pnpm install
```


### Configure Umami<a href="#configure-umami" class="heading-anchor" aria-label="Permalink to “Configure Umami”">#</a>

Create an `.env` file with the following


``` code-block
DATABASE_URL={connection url}
```


The connection url is in the following format:


``` code-block
DATABASE_URL=postgresql://username:mypassword@localhost:5432/mydb
```


### Build the application<a href="#build-the-application" class="heading-anchor" aria-label="Permalink to “Build the application”">#</a>


``` code-block
pnpm build
```


The first time the build is run, it will create all the required database tables in your database. It will also create a login account with username **admin** and password **umami**.

### Start the application<a href="#start-the-application" class="heading-anchor" aria-label="Permalink to “Start the application”">#</a>


``` code-block
pnpm start
```


By default this will launch the application on `http://localhost:3000`. You will need to either [proxy](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/) requests from your web server or change the [port](https://nextjs.org/docs/api-reference/cli#production) to serve the application directly.

### Running Umami<a href="#running-umami" class="heading-anchor" aria-label="Permalink to “Running Umami”">#</a>

You can simply run `pnpm start` to start Umami, but it's highly recommended you use a process manager like [PM2](https://pm2.keymetrics.io/) which will handle restarts for you.

To run with PM2:


``` code-block
pnpm add -g pm2
cd umami
pm2 start "pnpm start" --name umami
pm2 startup
pm2 save
```


## Installing with Docker<a href="#installing-with-docker" class="heading-anchor" aria-label="Permalink to “Installing with Docker”">#</a>

Umami ships with a docker compose file that contains the application and a PostgreSQL database.

To build the Docker container and start up with a Postgres database, run:


``` code-block
docker compose up -d
```


This will create a PostgreSQL database and start the Umami application on `http://localhost:3000`. The default login credentials are username **admin** and password **umami**.


Change the default password


Change the default password immediately after your first login.


Alternatively, if you want to use prebuilt images, you can pull the Umami Docker image with PostgreSQL support:


``` code-block
docker pull docker.umami.is/umami-software/umami:postgresql-latest
```


When using a prebuilt image, you need to provide your own database and set the `DATABASE_URL` environment variable. See [Environment variables](/docs/environment-variables) for configuration options.


<a href="/docs" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground" rel="prev" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Previous</span><span class="font-medium transition-colors group-hover:text-primary">Introduction</span></span></a><a href="/docs/updates" class="group flex flex-1 items-end gap-3 py-3 text-base text-foreground justify-end text-right" rel="next" data-discover="true"><span class="flex flex-col"><span class="text-xs font-bold text-muted-foreground">Next</span><span class="font-medium transition-colors group-hover:text-primary">Getting updates</span></span></a>


On this page


