> Source: https://docs.immich.app/features/command-line-interface



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_m5m7">Skip to main content</a>


On this page


# The Immich CLI


Immich has a command line interface (CLI) that allows you to perform certain actions from the command line.

## Features<a href="#features" class="hash-link" aria-label="Direct link to Features" translate="no" title="Direct link to Features">​</a>

- Upload photos and videos to Immich
- Check server version

More features are planned for the future.


If you are looking to import your Google Photos takeout, we recommend this community maintained tool <a href="https://github.com/simulot/immich-go" target="_blank" rel="noopener noreferrer">immich-go</a>


## Requirements<a href="#requirements" class="hash-link" aria-label="Direct link to Requirements" translate="no" title="Direct link to Requirements">​</a>

- Node.js 20 or above
- Npm

If you can't install node/npm, there is also a Docker version available below.

## Installation (NPM)<a href="#installation-npm" class="hash-link" aria-label="Direct link to Installation (NPM)" translate="no" title="Direct link to Installation (NPM)">​</a>


``` prism-code
npm i -g @immich/cli
```


NOTE: if you previously installed the legacy CLI, you will need to uninstall it first:


``` prism-code
npm uninstall -g immich
```


## Installation (Docker)<a href="#installation-docker" class="hash-link" aria-label="Direct link to Installation (Docker)" translate="no" title="Direct link to Installation (Docker)">​</a>

If npm is not available on your system you can try the Docker version


``` prism-code
docker run -it -v "$(pwd)":/import:ro -e IMMICH_INSTANCE_URL=https://your-immich-instance/api -e IMMICH_API_KEY=your-api-key ghcr.io/immich-app/immich-cli:latest
```


Please modify the `IMMICH_INSTANCE_URL` and `IMMICH_API_KEY` environment variables as suitable. You can also use a Docker env file to store your sensitive API key.

This `docker run` command will directly run the command `immich` inside the container. You can directly append the desired parameters (see under "usage") to the commandline like this:


``` prism-code
docker run -it -v "$(pwd)":/import:ro -e IMMICH_INSTANCE_URL=https://your-immich-instance/api -e IMMICH_API_KEY=your-api-key ghcr.io/immich-app/immich-cli:latest upload -a -c 5 --recursive directory/
```


## Usage<a href="#usage" class="hash-link" aria-label="Direct link to Usage" translate="no" title="Direct link to Usage">​</a>

Usage


``` prism-code
$ immich
Usage: immich [options] [command]

Command line interface for Immich

Options:
  -V, --version                       output the version number
  -d, --config-directory <directory>  Configuration directory where auth.yml will be stored (default: "~/.config/immich/", env:
                                      IMMICH_CONFIG_DIR)
  -u, --url [url]                     Immich server URL (env: IMMICH_INSTANCE_URL)
  -k, --key [key]                     Immich API key (env: IMMICH_API_KEY)
  -h, --help                          display help for command

Commands:
  login|login-key <url> <key>         Login using an API key
  logout                              Remove stored credentials
  server-info                         Display server information
  upload [options] [paths...]         Upload assets
  help [command]                      display help for command
```


## Commands<a href="#commands" class="hash-link" aria-label="Direct link to Commands" translate="no" title="Direct link to Commands">​</a>

The upload command supports the following options:

Options


``` prism-code
Usage: immich upload [paths...] [options]

Upload assets

Arguments:
  paths                       One or more paths to assets to be uploaded

Options:
  -r, --recursive             Recursive (default: false, env: IMMICH_RECURSIVE)
  -i, --ignore <pattern>      Pattern to ignore (env: IMMICH_IGNORE_PATHS)
  -h, --skip-hash             Don't hash files before upload (default: false, env: IMMICH_SKIP_HASH)
  -H, --include-hidden        Include hidden folders (default: false, env: IMMICH_INCLUDE_HIDDEN)
  -a, --album                 Automatically create albums based on folder name (default: false, env: IMMICH_AUTO_CREATE_ALBUM)
  -A, --album-name <name>     Add all assets to specified album (env: IMMICH_ALBUM_NAME)
  -n, --dry-run               Don't perform any actions, just show what will be done (default: false, env: IMMICH_DRY_RUN)
  -c, --concurrency <number>  Number of assets to upload at the same time (default: 4, env: IMMICH_UPLOAD_CONCURRENCY)
  -j, --json-output           Output detailed information in json format (default: false, env: IMMICH_JSON_OUTPUT)
  --delete                    Delete local assets after upload (env: IMMICH_DELETE_ASSETS)
  --delete-duplicates         Delete local assets that are duplicates (already exist on server) (env: IMMICH_DELETE_DUPLICATES)
  --no-progress               Hide progress bars (env: IMMICH_PROGRESS_BAR)
  --watch                     Watch for changes and upload automatically (default: false, env: IMMICH_WATCH_CHANGES)
  --help                      display help for command
```


Note that the above options can read from environment variables as well.

## Quick Start<a href="#quick-start" class="hash-link" aria-label="Direct link to Quick Start" translate="no" title="Direct link to Quick Start">​</a>

You begin by authenticating to your Immich server. For instance:


``` prism-code
# immich login [url] [key]
immich login http://192.168.1.216:2283/api HFEJ38DNSDUEG
```


This will store your credentials in a `auth.yml` file in the configuration directory which defaults to `~/.config/immich/`. The directory can be set with the `-d` option or the environment variable `IMMICH_CONFIG_DIR`. Please keep the file secure, either by performing the logout command after you are done, or deleting it manually.

Once you are authenticated, you can upload assets to your Immich server.


``` prism-code
immich upload file1.jpg file2.jpg
```


By default, subfolders are not included. To upload a directory including subfolder, use the --recursive option:


``` prism-code
immich upload --recursive directory/
```


If you are unsure what will happen, you can use the `--dry-run` option to see what would happen without actually performing any actions.


``` prism-code
immich upload --dry-run --recursive directory/
```


By default, the upload command will hash the files before uploading them. This is to avoid uploading the same file multiple times. If you are sure that the files are unique, you can skip this step by passing the `--skip-hash` option. Note that Immich always performs its own deduplication through hashing, so this is merely a performance consideration. If you have good bandwidth it might be faster to skip hashing.


``` prism-code
immich upload --skip-hash --recursive directory/
```


You can automatically create albums based on the folder name by passing the `--album` option. This will automatically create albums for each uploaded asset based on the name of the folder they are in.


``` prism-code
immich upload --album --recursive directory/
```


You can also choose to upload all assets to a specific album with the `--album-name` option.


``` prism-code
immich upload --album-name "My summer holiday" --recursive directory/
```


It is possible to skip assets matching a glob pattern by passing the `--ignore` option. See [the library documentation](/features/libraries) on how to use glob patterns. You can add several exclusion patterns if needed.


``` prism-code
immich upload --ignore **/Raw/** --recursive directory/
```


``` prism-code
immich upload --ignore **/Raw/** **/*.tif --recursive directory/
```


By default, hidden files are skipped. If you want to include hidden files, use the `--include-hidden` option:


``` prism-code
immich upload --include-hidden --recursive directory/
```


You can use the `--json-output` option to get a json printed which includes three keys: `newFiles`, `duplicates` and `newAssets`. Due to some logging output you will need to strip the first three lines of output to get the json. For example to get a list of files that would be uploaded for further processing:


``` prism-code
immich upload --dry-run --json-output . | tail -n +6 | jq .newFiles[]
```


### Obtain the API Key<a href="#obtain-the-api-key" class="hash-link" aria-label="Direct link to Obtain the API Key" translate="no" title="Direct link to Obtain the API Key">​</a>

The API key can be obtained in the user setting panel on the web interface. You can also specify permissions for the key to limit its access.

<img src="data:image/webp;base64,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" class="img_mXw_" decoding="async" loading="lazy" width="1402" height="310" alt="Obtain Api Key" />

<img src="/assets/images/obtain-api-key-2-5498f00ac6bd1523b1d33826d26a3416.webp" class="img_mXw_" decoding="async" loading="lazy" width="2060" height="1908" alt="Specify permissions for the key" />


- <a href="#features" class="table-of-contents__link toc-highlight">Features</a>
- <a href="#requirements" class="table-of-contents__link toc-highlight">Requirements</a>
- <a href="#installation-npm" class="table-of-contents__link toc-highlight">Installation (NPM)</a>
- <a href="#installation-docker" class="table-of-contents__link toc-highlight">Installation (Docker)</a>
- <a href="#usage" class="table-of-contents__link toc-highlight">Usage</a>
- <a href="#commands" class="table-of-contents__link toc-highlight">Commands</a>
- <a href="#quick-start" class="table-of-contents__link toc-highlight">Quick Start</a>
  - <a href="#obtain-the-api-key" class="table-of-contents__link toc-highlight">Obtain the API Key</a>


