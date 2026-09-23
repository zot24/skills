> Source: https://pi.dev/docs/latest/containerization



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# Run Pi in an isolated environment


Use an isolated environment to limit the files, credentials, processes, and network services that generated commands can access or affect.

You can isolate the complete Pi process or keep Pi on the host and route selected tools into an isolated environment.


## Choose an isolation method

<a href="#choose-an-isolation-method" class="heading-anchor" aria-label="Permalink: Choose an isolation method" data-copy="" data-copy-text="https://pi.dev/docs/latest/containerization#choose-an-isolation-method"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Method             | Where Pi runs           | What is isolated                                 | Credential handling                                                                       | Best for                                                               |
|--------------------|-------------------------|--------------------------------------------------|-------------------------------------------------------------------------------------------|------------------------------------------------------------------------|
| Plain Docker       | Container               | Pi, built-in tools, `!` commands, and extensions | Credentials passed into the container                                                     | A straightforward local container boundary                             |
| Docker Sandboxes   | Managed sandbox         | Pi, built-in tools, `!` commands, and extensions | Provider credentials remain on the host and are substituted by the proxy                  | Managed local isolation without exposing the real provider key         |
| OpenShell          | Local or remote sandbox | Pi, built-in tools, `!` commands, and extensions | Policy-controlled credentials and inference routing                                       | Filesystem, process, network, and credential policies                  |
| Gondolin extension | Host                    | Built-in tools and `!` commands                  | Stored Pi credentials remain on the host, but commands inherit host environment variables | A local micro-VM for tool execution while retaining the host interface |

The method changes where extensions run. When the complete Pi process runs inside an isolated environment, its extensions run there too. When host Pi delegates built-in tools through Gondolin, other extension tools still run on the host unless they also delegate their work.


## Decide what Pi can access

<a href="#decide-what-pi-can-access" class="heading-anchor" aria-label="Permalink: Decide what Pi can access" data-copy="" data-copy-text="https://pi.dev/docs/latest/containerization#decide-what-pi-can-access"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


An isolated process can still affect resources you expose to it:

- A read-write host mount lets Pi modify those host files.
- Mounting `~/.pi/agent` exposes your Pi credentials, settings, extensions, and sessions.
- Environment variables passed into a container are available to processes inside it.
- Network access may allow code or tool output to leave the environment.
- Tool-only isolation does not constrain the host Pi process or extension tools that do not use the isolated backend.

Expose only the working folder, credentials, and network destinations needed for the task. Use read-only mounts or copy files into and out of the environment when you do not want writes to affect the host.


## Run Pi in plain Docker

<a href="#run-pi-in-plain-docker" class="heading-anchor" aria-label="Permalink: Run Pi in plain Docker" data-copy="" data-copy-text="https://pi.dev/docs/latest/containerization#run-pi-in-plain-docker"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Plain Docker provides the simplest whole-process container boundary.


### Build the image

<a href="#build-the-image" class="heading-anchor" aria-label="Permalink: Build the image" data-copy="" data-copy-text="https://pi.dev/docs/latest/containerization#build-the-image"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Create `Dockerfile.pi`:

``` dockerfile
FROM node:24-bookworm-slim

RUN apt-get update \
  && apt-get install -y --no-install-recommends bash ca-certificates git ripgrep \
  && rm -rf /var/lib/apt/lists/*
RUN npm install -g --ignore-scripts @earendil-works/pi-coding-agent

WORKDIR /workspace
ENTRYPOINT ["pi"]
```

Build it from the directory containing the file:

``` bash
docker build -t pi-sandbox -f Dockerfile.pi .
```


### Start Pi

<a href="#start-pi" class="heading-anchor" aria-label="Permalink: Start Pi" data-copy="" data-copy-text="https://pi.dev/docs/latest/containerization#start-pi"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


From the working folder you want Pi to access, run:

``` bash
docker run --rm -it \
  -e ANTHROPIC_API_KEY \
  -v "$PWD:/workspace" \
  -v pi-agent-home:/root/.pi/agent \
  pi-sandbox
```

Replace `ANTHROPIC_API_KEY` with the credential required by your provider. The named `pi-agent-home` volume keeps container-local settings, credentials, and sessions between runs.

Do not mount the host's `~/.pi/agent` unless the container should have access to your host Pi configuration and credentials.


### Verify the workspace

<a href="#verify-the-workspace" class="heading-anchor" aria-label="Permalink: Verify the workspace" data-copy="" data-copy-text="https://pi.dev/docs/latest/containerization#verify-the-workspace"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Inside Pi, run:

``` text
!pwd
```

The command should report `/workspace`. Changes under `/workspace` write through to the mounted host folder. Remove the bind mount or use a read-only mount when that is not acceptable.


## Run Pi with Docker Sandboxes

<a href="#run-pi-with-docker-sandboxes" class="heading-anchor" aria-label="Permalink: Run Pi with Docker Sandboxes" data-copy="" data-copy-text="https://pi.dev/docs/latest/containerization#run-pi-with-docker-sandboxes"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


[Docker Sandboxes](https://docs.docker.com/ai/sandboxes/) runs the complete Pi process inside a managed sandbox. Its proxy can keep the real provider credential on the host and substitute it when requests leave the sandbox.

Configure credentials before creating the sandbox. Do not run `/login` inside the sandbox because that writes a real credential into it.


### Use a Claude Pro or Max token

<a href="#use-a-claude-pro-or-max-token" class="heading-anchor" aria-label="Permalink: Use a Claude Pro or Max token" data-copy="" data-copy-text="https://pi.dev/docs/latest/containerization#use-a-claude-pro-or-max-token"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Generate the token with `claude setup-token` on a machine with Claude Code. If an `anthropic` secret is already configured, remove it first so the proxy does not add an API-key header alongside the bearer token:

``` bash
sbx secret rm anthropic

sbx secret set-custom \
  --host api.anthropic.com \
  --env ANTHROPIC_OAUTH_TOKEN \
  --placeholder 'sk-ant-oat01-{rand}'
```

`sbx secret set-custom` reads the real token from standard input. The sandbox receives an OAuth-shaped placeholder, which the proxy replaces only for requests to the configured host.

For an Anthropic API key, use `sbx secret set anthropic` instead.


### Start Pi

<a href="#start-pi-1" class="heading-anchor" aria-label="Permalink: Start Pi" data-copy="" data-copy-text="https://pi.dev/docs/latest/containerization#start-pi-1"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Run this from the working folder you want mounted:

``` bash
sbx run --kit "docker.io/sbx/pi-kit:latest" pi
```

For an existing sandbox, run Pi non-interactively with:

``` bash
sbx exec <sandbox-name> -- pi -p "list the failing tests"
```

See the [Pi kit documentation](https://github.com/docker/sbx-kits-contrib/tree/main/pi) for other providers, troubleshooting, and image pinning.


## Run Pi with OpenShell

<a href="#run-pi-with-openshell" class="heading-anchor" aria-label="Permalink: Run Pi with OpenShell" data-copy="" data-copy-text="https://pi.dev/docs/latest/containerization#run-pi-with-openshell"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


[NVIDIA OpenShell](https://docs.nvidia.com/openshell/about/overview) provides local or remote sandboxes with filesystem, process, network, credential, and inference policies.


### Select a gateway

<a href="#select-a-gateway" class="heading-anchor" aria-label="Permalink: Select a gateway" data-copy="" data-copy-text="https://pi.dev/docs/latest/containerization#select-a-gateway"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Every sandbox requires an active gateway:

``` bash
openshell gateway add <gateway-url> --name <name>
openshell gateway select <name>
```


### Create the sandbox

<a href="#create-the-sandbox" class="heading-anchor" aria-label="Permalink: Create the sandbox" data-copy="" data-copy-text="https://pi.dev/docs/latest/containerization#create-the-sandbox"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` bash
openshell sandbox create --name pi-sandbox --from pi -- pi
```

Pi, its built-in tools, `!` commands, and extension tools run inside the OpenShell boundary.


### Transfer files to a remote sandbox

<a href="#transfer-files-to-a-remote-sandbox" class="heading-anchor" aria-label="Permalink: Transfer files to a remote sandbox" data-copy="" data-copy-text="https://pi.dev/docs/latest/containerization#transfer-files-to-a-remote-sandbox"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


A remote gateway does not bind-mount your host working folder. Clone the repository inside the sandbox or transfer files explicitly:

``` bash
openshell sandbox upload pi-sandbox ./working-folder /workspace
openshell sandbox download pi-sandbox /workspace/working-folder ./working-folder-out
```

OpenShell inference routing can keep raw model credentials outside the sandbox. When configured, point Pi at the corresponding OpenAI-compatible or Anthropic-compatible endpoint exposed by the gateway.


## Route tools through Gondolin

<a href="#route-tools-through-gondolin" class="heading-anchor" aria-label="Permalink: Route tools through Gondolin" data-copy="" data-copy-text="https://pi.dev/docs/latest/containerization#route-tools-through-gondolin"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


[Gondolin](https://github.com/earendil-works/gondolin) is a local Linux micro-VM. Its example extension keeps the Pi process and file-based provider credentials on the host while routing the built-in tools and user `!` commands into the VM.

Commands inside the VM inherit the host process environment. Provider keys supplied through environment variables can therefore be visible inside the VM. Do not use this pattern as a credential boundary unless you remove sensitive variables or change the extension's environment handling.

Gondolin requires Node.js 23.6 or newer and QEMU installed through your operating-system package manager.


### Install the extension

<a href="#install-the-extension" class="heading-anchor" aria-label="Permalink: Install the extension" data-copy="" data-copy-text="https://pi.dev/docs/latest/containerization#install-the-extension"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


From a Pi source checkout:

``` bash
mkdir -p ~/.pi/agent/extensions
cp -R packages/coding-agent/examples/extensions/gondolin ~/.pi/agent/extensions/gondolin
cd ~/.pi/agent/extensions/gondolin
npm install --ignore-scripts
```


### Start Pi

<a href="#start-pi-2" class="heading-anchor" aria-label="Permalink: Start Pi" data-copy="" data-copy-text="https://pi.dev/docs/latest/containerization#start-pi-2"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Run Pi from the working folder you want mounted:

``` bash
cd /path/to/working-folder
pi -e ~/.pi/agent/extensions/gondolin
```

The extension mounts the host working folder at `/workspace` in the VM and overrides `read`, `write`, `edit`, `bash`, `grep`, `find`, and `ls`. File changes under `/workspace` write through to the host.

Other extension tools still run on the host unless they explicitly delegate their operations. Review the [Gondolin example](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/examples/extensions/gondolin) before adding tools that could bypass the VM boundary.


