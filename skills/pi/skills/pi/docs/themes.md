> Source: https://pi.dev/docs/latest/themes



Documentation

Guides and references for configuring and extending Pi.


Navigation


On this page


Documentation


Search documentation


<a href="#" class="docs-search-result-link"><span class="docs-search-result-meta"></span><strong></strong><span class="docs-search-result-excerpt"></span></a>


On this page


# Customize Pi with themes


Themes control the colors Pi uses in interactive mode and HTML exports. Pi includes `dark` and `light` themes. You can select one theme, follow your terminal's light or dark appearance, or create your own palette.


## Choose a theme

<a href="#choose-a-theme" class="heading-anchor" aria-label="Permalink: Choose a theme" data-copy="" data-copy-text="https://pi.dev/docs/latest/themes#choose-a-theme"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Open `/settings` and select **Theme**. You can use one theme for every terminal appearance or choose separate themes for light and dark terminals.

The selection is saved as the `theme` [setting](/docs/latest/settings#terminal-and-display):

``` json
{
  "theme": "dark"
}
```

Automatic mode stores the light theme first and the dark theme second:

``` json
{
  "theme": "light/dark"
}
```

When automatic mode is active, Pi changes themes when the terminal reports an appearance change. Theme names cannot contain `/` because Pi reserves it for this setting format.

Use `--use-theme` to choose the initial theme for one invocation without changing the saved setting:

``` bash
pi --use-theme light
pi --use-theme light/dark
```

See [CLI resources](/docs/latest/cli#resources) for the command-line option.


## Create a custom theme

<a href="#create-a-custom-theme" class="heading-anchor" aria-label="Permalink: Create a custom theme" data-copy="" data-copy-text="https://pi.dev/docs/latest/themes#create-a-custom-theme"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Copy one of the [built-in themes](https://github.com/earendil-works/pi/tree/main/packages/coding-agent/src/modes/interactive/theme) or create a new JSON file conforming to the [schema](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/src/modes/interactive/theme/theme-schema.json).

1.  Save the file as `<agent-dir>/themes/my-theme.json`. The agent directory defaults to `~/.pi/agent`.
2.  Set its `name` to `my-theme`.
3.  Change values in `vars` and `colors`.
4.  Select `my-theme` through `/settings`.

Use the theme name as the filename. Pi hot-reloads the active user theme only from `<agent-dir>/themes/<name>.json`. Run `/reload` after adding or changing a theme from any other source.


## Understand the theme file

<a href="#understand-the-theme-file" class="heading-anchor" aria-label="Permalink: Understand the theme file" data-copy="" data-copy-text="https://pi.dev/docs/latest/themes#understand-the-theme-file"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


| Property  | Required | Responsibility                                                                            |
|-----------|----------|-------------------------------------------------------------------------------------------|
| `$schema` | No       | Enables editor validation and completion against Pi's published schema.                   |
| `name`    | Yes      | Identifies the theme in selectors and settings. It must be unique and cannot contain `/`. |
| `vars`    | No       | Defines reusable color values. Variables can reference other variables.                   |
| `colors`  | Yes      | Assigns colors to terminal UI roles. The schema identifies required and optional roles.   |
| `export`  | No       | Overrides page and panel backgrounds in HTML exports.                                     |

A color can be written in four forms:

| Form               | Example     | Meaning                                                |
|--------------------|-------------|--------------------------------------------------------|
| RGB hexadecimal    | `"#00aaff"` | A six-digit RGB color.                                 |
| 256-color index    | `39`        | An ANSI palette index from `0` through `255`.          |
| Variable reference | `"primary"` | The value of an entry in `vars`.                       |
| Terminal default   | `""`        | The terminal's default foreground or background color. |

Pi resolves chained variable references. A missing variable or circular reference makes the theme invalid. Hexadecimal colors use truecolor when supported and are approximated in terminals limited to 256 colors. If colors differ from their hexadecimal values, check your terminal's truecolor detection and contrast settings. See [Configure Your Terminal](/docs/latest/terminal-setup#override-detected-capabilities).

Use the [theme JSON schema](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/src/modes/interactive/theme/theme-schema.json) for the exact properties, required colors, and accepted value types.

Pi reports invalid theme files during startup and `/reload`.


## Find the color to change

<a href="#find-the-color-to-change" class="heading-anchor" aria-label="Permalink: Find the color to change" data-copy="" data-copy-text="https://pi.dev/docs/latest/themes#find-the-color-to-change"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Theme colors describe interface roles rather than individual components. Use these groups to find the relevant part of the schema:

| Area                     | Color names                                                                |
|--------------------------|----------------------------------------------------------------------------|
| General interface        | `accent`, `border*`, `text`, `muted`, `dim`, `success`, `error`, `warning` |
| Selection and fullscreen | `selectedBg`, `searchMatch*`, `scrollbar*`                                 |
| Messages                 | `userMessage*`, `customMessage*`, `thinkingText`                           |
| Tool execution           | `toolPendingBg`, `toolSuccessBg`, `toolErrorBg`, `toolTitle`, `toolOutput` |
| Markdown                 | `md*`                                                                      |
| Tool diffs               | `toolDiff*`                                                                |
| Syntax highlighting      | `syntax*`                                                                  |
| Editor modes             | `thinking*`, `bashMode`                                                    |
| HTML export              | `export.pageBg`, `export.cardBg`, `export.infoBg`                          |

The schema is the format reference. The built-in themes provide complete values that you can copy and adjust.

Five colors are optional and inherit another color when omitted:

| Optional color    | Fallback        |
|-------------------|-----------------|
| `scrollbarTrack`  | `muted`         |
| `scrollbarThumb`  | `text`          |
| `searchMatchBg`   | `selectedBg`    |
| `searchMatchText` | `text`          |
| `thinkingMax`     | `thinkingXhigh` |

If `export` colors are omitted, Pi derives HTML page and panel backgrounds from `userMessageBg`.


## Load a theme from a project or package

<a href="#load-a-theme-from-a-project-or-package" class="heading-anchor" aria-label="Permalink: Load a theme from a project or package" data-copy="" data-copy-text="https://pi.dev/docs/latest/themes#load-a-theme-from-a-project-or-package"><span class="anchor-link"></span> <span class="anchor-check"></span> <span class="anchor-copied-label">Copied</span></a>


Place a project theme in `.pi/themes/`. Project themes load only after [project trust](/docs/latest/security#understand-project-trust) is granted.

You can also load theme files and directories through the `themes` setting or distribute them in a Pi package. See [Configuration](/docs/latest/configuration), [Settings](/docs/latest/settings#resources), and [Pi Packages](/docs/latest/packages).

Each loaded theme must have a unique name. Pi reports duplicate names as resource collisions.


