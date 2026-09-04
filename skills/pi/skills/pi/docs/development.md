> Source: https://pi.dev/docs/latest/development



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# Development


See [AGENTS.md](https://github.com/earendil-works/pi-mono/blob/main/AGENTS.md) for additional guidelines.


## Setup

<a href="#setup" class="heading-anchor" aria-label="Permalink: Setup" data-copy="" data-copy-text="https://pi.dev/docs/latest/development#setup"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` bash
git clone https://github.com/earendil-works/pi-mono
cd pi-mono
npm install
npm run build
```

Run from source:

``` bash
/path/to/pi-mono/pi-test.sh
```

The script can be run from any directory. Pi keeps the caller's current working directory.


## Forking / Rebranding

<a href="#forking--rebranding" class="heading-anchor" aria-label="Permalink: Forking / Rebranding" data-copy="" data-copy-text="https://pi.dev/docs/latest/development#forking--rebranding"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Configure via `package.json`:

``` json
{
  "piConfig": {
    "name": "pi",
    "configDir": ".pi"
  }
}
```

Change `name`, `configDir`, and `bin` field for your fork. Affects CLI banner, config paths, and environment variable names.


## Path Resolution

<a href="#path-resolution" class="heading-anchor" aria-label="Permalink: Path Resolution" data-copy="" data-copy-text="https://pi.dev/docs/latest/development#path-resolution"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Three execution modes: npm install, standalone binary, tsx from source.

**Always use `src/config.ts`** for package assets:

``` typescript
import { getPackageDir, getThemeDir } from "./config.js";
```

Never use `__dirname` directly for package assets.


## Debug Command

<a href="#debug-command" class="heading-anchor" aria-label="Permalink: Debug Command" data-copy="" data-copy-text="https://pi.dev/docs/latest/development#debug-command"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


`/debug` (hidden) writes to `~/.pi/agent/pi-debug.log`:

- Rendered TUI lines with ANSI codes
- Last messages sent to the LLM


## Testing

<a href="#testing" class="heading-anchor" aria-label="Permalink: Testing" data-copy="" data-copy-text="https://pi.dev/docs/latest/development#testing"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


``` bash
./test.sh                         # Run non-LLM tests (no API keys needed)
npm test                          # Run all tests
npm test -- test/specific.test.ts # Run specific test
```


## Project Structure

<a href="#project-structure" class="heading-anchor" aria-label="Permalink: Project Structure" data-copy="" data-copy-text="https://pi.dev/docs/latest/development#project-structure"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


    packages/
      ai/           # LLM provider abstraction
      agent/        # Agent loop and message types  
      tui/          # Terminal UI components
      coding-agent/ # CLI and interactive mode


