> Source: https://docs.umami.is/docs/install



<a href="https://umami.is/?ref=docs" class="inline-flex items-center gap-2.5 font-semibold md:hidden" rel="noreferrer noopener" target="_blank"><strong>umami</strong></a>


Search


<a href="/docs" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="true">Documentation</a><a href="/docs/guides" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Guides</a><a href="/docs/api" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">API Reference</a><a href="/docs/cloud" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" data-active="false">Cloud</a><a href="https://v2.umami.is" class="inline-flex items-center gap-2 text-fd-muted-foreground text-sm transition-colors hover:text-fd-accent-foreground data-[active=true]:font-medium data-[active=true]:text-fd-foreground [&amp;_svg]:size-4" target="_blank" rel="noopener noreferrer">v2</a>


<a href="https://github.com/umami-software/umami" class="inline-flex items-center justify-center rounded-md text-sm font-medium transition-colors duration-100 disabled:pointer-events-none disabled:opacity-50 focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-fd-ring hover:bg-fd-accent hover:text-fd-accent-foreground p-1.5 [&amp;_svg]:size-4.5 text-fd-muted-foreground max-lg:hidden" rel="noreferrer noopener" target="_blank" aria-label="GitHub" data-active="false"></a>


# Installation


There are several different ways to install Umami.

- **Installing from source**: Get the code from <a href="https://github.com/umami-software/umami" rel="noreferrer noopener" target="_blank">GitHub</a> and build the application yourself.
- **Using Docker compose**: Build your own Docker container using `docker compose`.
- **Using a Docker image**: Download a pre-built Docker image.

## <a href="#installing-from-source" class="peer" data-card="">Installing from source</a>

### <a href="#requirements" class="peer" data-card="">Requirements</a>

- A server with <a href="https://nodejs.org/" rel="noreferrer noopener" target="_blank">Node.js</a> version 18.18 or newer.
- A database. Umami supports <a href="https://www.postgresql.org/" rel="noreferrer noopener" target="_blank">PostgreSQL</a> (minimum v12.14) databases.

> **Notes**: We recommend configuring the PostgreSQL database to use the **UTC** timezone.
>
> **Why UTC?**
>
> Using UTC avoids issues caused by regional offsets, ensuring consistent, predictable timestamps across environments, services, and deployments.

### <a href="#install-pnpm" class="peer" data-card="">Install pnpm</a>

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>npm install -g pnpm</code></pre>
</figure>

### <a href="#get-the-source-code-and-install-packages" class="peer" data-card="">Get the source code and install packages</a>

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>git clone https://github.com/umami-software/umami.git
cd umami
pnpm install</code></pre>
</figure>

### <a href="#configure-umami" class="peer" data-card="">Configure Umami</a>

Create an `.env` file with the following

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>DATABASE_URL={connection url}</code></pre>
</figure>

The connection url is in the following format:

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>DATABASE_URL=postgresql://username:mypassword@localhost:5432/mydb</code></pre>
</figure>

### <a href="#build-the-application" class="peer" data-card="">Build the application</a>

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>pnpm build</code></pre>
</figure>

The first time the build is run, it will create all the required database tables in your database. It will also create a login account with username **admin** and password **umami**.

### <a href="#start-the-application" class="peer" data-card="">Start the application</a>

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>pnpm start</code></pre>
</figure>

By default this will launch the application on `http://localhost:3000`. You will need to either <a href="https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/" rel="noreferrer noopener" target="_blank">proxy</a> requests from your web server or change the <a href="https://nextjs.org/docs/api-reference/cli#production" rel="noreferrer noopener" target="_blank">port</a> to serve the application directly.

### <a href="#running-umami" class="peer" data-card="">Running Umami</a>

You can simply run `pnpm start` to start Umami, but it's highly recommended you use a process manager like <a href="https://pm2.keymetrics.io/" rel="noreferrer noopener" target="_blank">PM2</a> which will handle restarts for you.

To run with PM2:

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>pnpm --global add pm2
cd umami
pm2 start &quot;pnpm start&quot; --name umami
pm2 startup
pm2 save</code></pre>
</figure>

## <a href="#installing-with-docker" class="peer" data-card="">Installing with Docker</a>

Umami ships with a docker compose file that contains the application and a PostgreSQL database.

To build the Docker container and start up with a Postgres database, run:

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>docker-compose up -d</code></pre>
</figure>

This will create a PostgreSQL database and start the Umami application on `http://localhost:3000`. The default login credentials are username **admin** and password **umami**.

> **Important**: Change the default password immediately after your first login.

Alternatively, if you want to use prebuilt images, you can pull the Umami Docker image with PostgreSQL support:

<figure class="my-4 bg-fd-card rounded-xl shiki relative border shadow-sm outline-none not-prose overflow-hidden text-sm shiki-themes github-light github-dark" dir="ltr" style="--shiki-light:#24292e;--shiki-dark:#e1e4e8;--shiki-light-bg:#fff;--shiki-dark-bg:#24292e" tabindex="0">

<pre class="min-w-full w-max *:flex *:flex-col"><code>docker pull docker.umami.is/umami-software/umami:postgresql-latest</code></pre>
</figure>

When using a prebuilt image, you need to provide your own database and set the `DATABASE_URL` environment variable. See [Environment variables](/docs/environment-variables) for configuration options.


<a href="/docs" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full"></a>


Introduction


Previous Page

<a href="/docs/updates" class="flex flex-col gap-2 rounded-lg border p-4 text-sm transition-colors hover:bg-fd-accent/80 hover:text-fd-accent-foreground @max-lg:col-span-full text-end"></a>


Getting updates


Next Page


### On this page


<a href="#installing-from-source" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">Installing from source</a><a href="#requirements" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">Requirements</a><a href="#install-pnpm" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">Install pnpm</a><a href="#get-the-source-code-and-install-packages" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">Get the source code and install packages</a><a href="#configure-umami" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">Configure Umami</a><a href="#build-the-application" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">Build the application</a><a href="#start-the-application" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">Start the application</a><a href="#running-umami" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-6" data-active="false">Running Umami</a><a href="#installing-with-docker" class="prose py-1.5 text-sm text-fd-muted-foreground transition-colors [overflow-wrap:anywhere] first:pt-0 last:pb-0 data-[active=true]:text-fd-primary ps-3" data-active="false">Installing with Docker</a>


