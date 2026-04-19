<!-- Source: Scraped from silentvoid13.github.io/Templater via Firecrawl -->

- Light (default)
- Rust
- Coal
- Navy
- Ayu

# Templater

[Print this book](https://silentvoid13.github.io/Templater/print.html "Print this book")

[Templater](https://github.com/SilentVoid13/Templater) is a template language that lets you insert **variables** and **functions** results into your notes. It will also let you execute JavaScript code manipulating those variables and functions.

With [Templater](https://github.com/SilentVoid13/Templater), you will be able to create powerful templates to automate manual tasks.

The following template file, that is using [Templater](https://github.com/SilentVoid13/Templater) syntax:

```javascript

---
creation date: <% tp.file.creation_date() %>
modification date: <% tp.file.last_modified_date("dddd Do MMMM YYYY HH:mm:ss") %>
---

<< [[<% tp.date.now("YYYY-MM-DD", -1) %>]] | [[<% tp.date.now("YYYY-MM-DD", 1) %>]] >>

# <% tp.file.title %>

<% tp.web.daily_quote() %>
```

Will produce the following result when inserted:

```

---
creation date: 2021-01-07 17:20
modification date: Thursday 7th January 2021 17:20:43
---

<< [[2021-04-08]] | [[2021-04-10]] >>

# Test Test

> Do the best you can until you know better. Then when you know better, do better.
> &mdash; <cite>Maya Angelou</cite>
```
---

- Light (default)
- Rust
- Coal
- Navy
- Ayu

# Templater

[Print this book](https://silentvoid13.github.io/Templater/print.html "Print this book")

[Templater](https://github.com/SilentVoid13/Templater) is a template language that lets you insert **variables** and **functions** results into your notes. It will also let you execute JavaScript code manipulating those variables and functions.

With [Templater](https://github.com/SilentVoid13/Templater), you will be able to create powerful templates to automate manual tasks.

The following template file, that is using [Templater](https://github.com/SilentVoid13/Templater) syntax:

```javascript

---
creation date: <% tp.file.creation_date() %>
modification date: <% tp.file.last_modified_date("dddd Do MMMM YYYY HH:mm:ss") %>
---

<< [[<% tp.date.now("YYYY-MM-DD", -1) %>]] | [[<% tp.date.now("YYYY-MM-DD", 1) %>]] >>

# <% tp.file.title %>

<% tp.web.daily_quote() %>
```

Will produce the following result when inserted:

```

---
creation date: 2021-01-07 17:20
modification date: Thursday 7th January 2021 17:20:43
---

<< [[2021-04-08]] | [[2021-04-10]] >>

# Test Test

> Do the best you can until you know better. Then when you know better, do better.
> &mdash; <cite>Maya Angelou</cite>
```
---

- Light (default)
- Rust
- Coal
- Navy
- Ayu

# Templater

[Print this book](https://silentvoid13.github.io/Templater/print.html "Print this book")

The different internal variables and functions offered by [Templater](https://github.com/SilentVoid13/Templater) are available under different **modules**, to sort them. The existing **internal modules** are:

- [App module](https://silentvoid13.github.io/Templater/internal-functions/internal-modules/app-module.html): `tp.app`
- [Config module](https://silentvoid13.github.io/Templater/internal-functions/internal-modules/config-module.html): `tp.config`
- [Date module](https://silentvoid13.github.io/Templater/internal-functions/internal-modules/date-module.html): `tp.date`
- [File module](https://silentvoid13.github.io/Templater/internal-functions/internal-modules/file-module.html): `tp.file`
- [Frontmatter module](https://silentvoid13.github.io/Templater/internal-functions/internal-modules/frontmatter-module.html): `tp.frontmatter`
- [Hooks module](https://silentvoid13.github.io/Templater/internal-functions/internal-modules/hooks-module.html): `tp.hooks`
- [Obsidian module](https://silentvoid13.github.io/Templater/internal-functions/internal-modules/obsidian-module.html): `tp.obsidian`
- [System module](https://silentvoid13.github.io/Templater/internal-functions/internal-modules/system-module.html): `tp.system`
- [Web module](https://silentvoid13.github.io/Templater/internal-functions/internal-modules/web-module.html): `tp.web`

If you understood the [object hierarchy](https://silentvoid13.github.io/Templater/syntax.html#objects-hierarchy) correctly, this means that a typical internal function call looks like this: ` <% tp.<module_name>.<internal_function_name> %>`

I invite everyone to contribute to this plugin development by adding new internal functions. More information [here](https://silentvoid13.github.io/Templater/internal-functions/contribute.html).