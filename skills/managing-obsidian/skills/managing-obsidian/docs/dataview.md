<!-- Source: Scraped from blacksmithgu.github.io/obsidian-dataview via Firecrawl -->

[Skip to content](https://blacksmithgu.github.io/obsidian-dataview/#overview)

# Overview

Dataview is a live index and query engine over your personal knowledge base. You can [**add metadata**](https://blacksmithgu.github.io/obsidian-dataview/annotation/add-metadata/) to your notes and **query** them with the [**Dataview Query Language**](https://blacksmithgu.github.io/obsidian-dataview/queries/structure/) to list, filter, sort or group your data. Dataview keeps your queries always up to date and makes data aggregation a breeze.

You could

- Track your sleep by recording it in daily notes, and automatically create weekly tables of your sleep schedule.
- Automatically collect links to books in your notes, and render them all sorted by rating.
- Automatically collect pages associated with today's date and show them in your daily note.
- Find pages with no tags for follow-up, or show pretty views of specifically-tagged pages.
- Create dynamic views which show upcoming birthdays or events recorded in your notes

and many more things.

Dataview gives you a fast way to search, display and operate on indexed data in your vault!

Dataview is highly generic and high performance, scaling up to hundreds of thousands of annotated notes without issue.

If the built in [query language](https://blacksmithgu.github.io/obsidian-dataview/queries/structure/) is insufficient for your purpose, you can run arbitrary
JavaScript against the [dataview API](https://blacksmithgu.github.io/obsidian-dataview/api/intro/) and build whatever utility you might need yourself, right in your notes.

Dataview is about displaying, not editing

Dataview is meant for displaying and calculating data. It is not meant to edit your notes/metadata and will always leave them untouched (... except if you're checking a [Task](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#task) through Dataview.)

## How to Use Dataview

Dataview consists of two big building blocks: **Data Indexing** and **Data Querying**.

More details on the linked documentation pages

The following sections should give you a general overview about what you can do with dataview and how. Be sure to visit the linked pages to find out more about the individual parts.

### Data Indexing

Dataview operates on metadata in your Markdown files. It cannot read everything in your vault, but only specific data. Some of your content, like tags and bullet points (including tasks), are [available automatically](https://blacksmithgu.github.io/obsidian-dataview/annotation/add-metadata/#implicit-fields) in Dataview. You can add other data through **fields**, either on top of your file [per YAML Frontmatter](https://blacksmithgu.github.io/obsidian-dataview/annotation/add-metadata/#frontmatter) or in the middle of your content with [Inline Fields](https://blacksmithgu.github.io/obsidian-dataview/annotation/add-metadata/#inline-fields) via the `[key:: value]` syntax. Dataview _indexes_ these data to make it available for you to query.

Dataview indexes [certain information](https://blacksmithgu.github.io/obsidian-dataview/annotation/add-metadata/#implicit-fields) like tags and list items and the data you add via fields. Only indexed data is available in a Dataview query!

For example, a file might look like this:

```
---
author: "Edgar Allan Poe"
published: 1845
tags: poems
---

# The Raven

Once upon a midnight dreary, while I pondered, weak and weary,
Over many a quaint and curious volume of forgotten lore—
```

Or like this:

```
#poems

# The Raven

From [author:: Edgar Allan Poe], written in (published:: 1845)

Once upon a midnight dreary, while I pondered, weak and weary,
Over many a quaint and curious volume of forgotten lore—
```

In terms of indexed metadata (or what you can query), they are identical, and only differ in their annotation style. How you want to [annotate your metadata](https://blacksmithgu.github.io/obsidian-dataview/annotation/add-metadata/) is up to you and your personal preference. With this file, you'd have the **metadata field**`author` available and everything Dataview provides you [automatically as implicit fields](https://blacksmithgu.github.io/obsidian-dataview/annotation/metadata-pages/), like the tag or note title.

Data needs to be indexed

In the above example, you _do not_ have the poem itself available in Dataview: It is a paragraph, not a metadata field and not something Dataview indexes automatically. It is not part of Dataviews index, so you won't be able to query it.

### Data Querying

You can access **indexed data** with the help of **Queries**.

There are **three different ways** you can write a Query: With help of the [Dataview Query Language](https://blacksmithgu.github.io/obsidian-dataview/queries/dql-js-inline/#dataview-query-language-dql), as an [inline statement](https://blacksmithgu.github.io/obsidian-dataview/queries/dql-js-inline/#inline-dql) or in the most flexible but most complex way: as a [Javascript Query](https://blacksmithgu.github.io/obsidian-dataview/queries/dql-js-inline/#dataview-js).

The **Dataview Query Language** ( **DQL**) gives you a broad and powerful toolbelt to query, display and operate on your data. An [**inline query**](https://blacksmithgu.github.io/obsidian-dataview/queries/dql-js-inline/#inline-dql) gives you the possibility to display exactly one indexed value anywhere in your note. You can also do calculations this way. With **DQL** at your hands, you'll be probably fine without any Javascript through your data journey.

A DQL Query consists of several parts:

- Exactly one [**Query Type**](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/) that determines what your Query Output looks like
- None or one [**FROM statement**](https://blacksmithgu.github.io/obsidian-dataview/queries/data-commands/#from) to pick a specific tag or folder (or another [source](https://blacksmithgu.github.io/obsidian-dataview/reference/sources/)) to look at
- None to multiple [**other Data Commands**](https://blacksmithgu.github.io/obsidian-dataview/queries/data-commands/) that help you filter, group and sort your wanted output

For example, a Query can look like this:

````
```dataview
LIST
```
````

which list all files in your vault.

Everything but the Query Type is optional

The only thing you need for a valid DQL Query is the Query Type (and on [CALENDAR](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#calendar) s, a date field.)

A more restricted Query might look like this:

````
```dataview
LIST
FROM #poems
WHERE author = "Edgar Allan Poe"
```
````

which lists all files in your vault that have the tag `#poems` and a [field](https://blacksmithgu.github.io/obsidian-dataview/annotation/add-metadata/) named `author` with the value `Edgar Allan Poe`. This query would find our example page from above.

`LIST` is only one out of four [Query Types](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/) you can use. For example, with a `TABLE`, we could add some more information to our output:

````
```dataview
TABLE author, published, file.inlinks AS "Mentions"
FROM #poems
```
````

This'll give you back a result like:

| File (3) | author | published | Mentions |
| --- | --- | --- | --- |
| The Bells | Edgar Allan Poe | 1849 |  |
| The New Colossus | Emma Lazarus | 1883 | \- \[\[Favorite Poems\]\] |
| The Raven | Edgar Allan Poe | 1845 | \- \[\[Favorite Poems\]\] |

That's not where the capabilities of dataview end, though. You can also **operate on your data** with help of [**functions**](https://blacksmithgu.github.io/obsidian-dataview/reference/functions/). Mind that these operations are only made inside your query - your **data in your files stays untouched**.

````
```dataview
TABLE author, date(now).year - published AS "Age in Yrs", length(file.inlinks) AS "Counts of Mentions"
FROM #poems
```
````

gives you back

| File (3) | author | Age in Yrs | Count of Mentions |
| --- | --- | --- | --- |
| The Bells | Edgar Allan Poe | 173 | 0 |
| The New Colossus | Emma Lazarus | 139 | 1 |
| The Raven | Edgar Allan Poe | 177 | 1 |

Find more examples [here](https://blacksmithgu.github.io/obsidian-dataview/resources/examples/).

As you can see, dataview doesn't only allow you to aggregate your data swiftly and always up to date, it also can help you with operations to give you new insights on your dataset. Browse through the documentation to find out more on how to interact with your data.

Have fun exploring your vault in new ways!

## Resources and Help

This documentation is not the only place that can help you out on your data journey. Take a look at [Resources and Support](https://blacksmithgu.github.io/obsidian-dataview/resources/resources-and-support/) for a list of helpful pages and videos.
---

[Skip to content](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#query-types)

# Query Types

The **Query Type** determines how the output of your dataview query looks like. It is the **first and only mandatory** specification you give to a dataview query. There are four available: `LIST`, `TABLE`, `TASK` and `CALENDAR`.

The Query Type also determines which **information level** a query is executed on. `LIST`, `TABLE` and `CALENDAR` operate at **page level** whereas `TASK` queries operate at the `file.tasks` level. More on that in the `TASK` Query Type.

You can combine **every Query Type with all available [Data Commands](https://blacksmithgu.github.io/obsidian-dataview/queries/data-commands/)** to refine your result set. Read more about the interconnection between Query Types and Data Commands on [How to Use Dataview](https://blacksmithgu.github.io/obsidian-dataview/#how-to-use-dataview) and the [structure page](https://blacksmithgu.github.io/obsidian-dataview/queries/structure/).

Query Type

The Query Type determines the output format of a query. It's the only mandatory information for a query.

## LIST

`LIST` queries output a bullet point list consisting of your file links or the group name, if you decided to [group](https://blacksmithgu.github.io/obsidian-dataview/queries/data-commands/#group-by). You can specify up to **one additional information** to output alongside your file or group information.

Query Type `LIST`

`LIST` outputs a bullet point list of page links or Group keys. You can specify one additional information to show for each result.

The simplest LIST query outputs a bullet point list of all files in your vault:

````
```dataview
LIST
```
````

**Output**

- [Classic Cheesecake](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#)
- [Git Basics](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#)
- [How to fix Git Cheatsheet](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#)
- [League of Legends](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#)
- [Pillars of Eternity 2](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#)
- [Stardew Valley](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#)
- [Dashboard](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#)

but you can, of course, use [data commands](https://blacksmithgu.github.io/obsidian-dataview/queries/data-commands/) to restrict which pages you want to have listed:

````
```dataview
LIST
FROM #games/mobas OR #games/crpg
```
````

**Output**

- [League of Legends](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#)
- [Pillars of Eternity 2](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#)

### Output an additional information

To add a **additional information** to your query, specify it right after the `LIST` command and before possibly available data commands:

````
```dataview
LIST file.folder
```
````

**Output**

- [Classic Cheesecake](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#): Baking/Recipes
- [Git Basics](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#): Coding
- [How to fix Git Cheatsheet](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#): Coding/Cheatsheets
- [League of Legends](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#): Games
- [Pillars of Eternity 2](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#): Games
- [Stardew Valley](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#): Games/finished
- [Dashboard](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#):

You can only add **one** additional information, not multiple. But you can **specify a computed value** instead of a plain meta data field, which can contain information of multiple fields:

````
```dataview
LIST "File Path: " + file.folder + " _(created: " + file.cday + ")_"
FROM "Games"
```
````

**Output**

- [League of Legends](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#): File Path: Games _(created: May 13, 2021)_
- [Pillars of Eternity 2](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#): File Path: Games _(created: February 02, 2022)_
- [Stardew Valley](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#): File Path: Games/finished _(created: April 04, 2021)_

### Grouping

A **grouped list** shows their group keys, and only the group keys, by default:

````
```dataview
LIST
GROUP BY type
```
````

**Output**

- game
- knowledge
- moc
- recipe
- summary

A common use-case on grouped `LIST` queries is to add the file links to the output by specifying them as the additional information:

````
```dataview
LIST rows.file.link
GROUP BY type
```
````

- game:
  - [Stardew Valley](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#)
  - [League of Legends](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#)
  - [Pillars of Eternity 2](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#)
- knowledge:
  - [Git Basics](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#)
- moc:
  - [Dashboard](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#)
- recipe:
  - [Classic Cheesecake](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#)
- summary:
  - [How to fix Git Cheatsheet](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#)

### LIST WITHOUT ID

If you don't want the file name or group key included in the list view, you can use `LIST WITHOUT ID`. `LIST WITHOUT ID` works the same as `LIST`, but it does not output the file link or group name if you add an additional information.

````
```dataview
LIST WITHOUT ID
```
````

**Output**

- [Classic Cheesecake](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#)
- [Git Basics](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#)
- [How to fix Git Cheatsheet](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#)
- [League of Legends](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#)
- [Pillars of Eternity 2](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#)
- [Stardew Valley](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#)
- [Dashboard](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#)

It's the same as `LIST`, because it does not contain an additional information!

````
```dataview
LIST WITHOUT ID type
```
````

**Output**

- moc
- recipe
- summary
- knowledge
- game
- game
- game

`LIST WITHOUT ID` can be handy if you want to output computed values, for example.

````
```dataview
LIST WITHOUT ID length(rows) + " pages of type " + key
GROUP BY type
```
````

**Output**

- 3 pages of type game
- 1 pages of type knowledge
- 1 pages of type moc
- 1 pages of type recipe
- 1 pages of type summary

## TABLE

The `TABLE` query types outputs page data as a tabular view. You can add zero to multiple meta data fields to your `TABLE` query by adding them as a **comma separated list**. You can not only use plain meta data fields as columns, but specify **calculations** as well. Optionally, you can specify a **table header** via the `AS <header>` syntax. Like all other query types, you can refine your result set for your query with [data commands](https://blacksmithgu.github.io/obsidian-dataview/queries/data-commands/).

`TABLE` Query Type

`TABLE` queries render a tabular view of any number of meta data values or calculations. It is possible to specify column headers via `AS <header>`.

````
```dataview
TABLE
```
````

**Output**

| File (7) |
| --- |
| [Classic Cheesecake](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#) |
| [Git Basics](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#) |
| [How to fix Git Cheatsheet](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#) |
| [League of Legends](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#) |
| [Pillars of Eternity 2](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#) |
| [Stardew Valley](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#) |
| [Dashboard](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#) |

Changing the first column header name

You can change the name of the first column header (by default "File" or "Group") via the Dataview Settings under Table Settings -> Primary Column Name / Group Column Name.
If you want to change the name only for one specific `TABLE` query, have a look at `TABLE WITHOUT ID`.

Disabling Result count

The first column always shows the result count. If you do not want to get it displayed, you can disable it in Dataview's settings ("Display result count", available since 0.5.52).

Of course, a `TABLE` is made for specifying one to multiple additional information:

````
```dataview
TABLE started, file.folder, file.etags
FROM #games
```
````

**Output**

| File (3) | started | file.folder | file.etags |
| --- | --- | --- | --- |
| [League of Legends](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#) | May 16, 2021 | Games | \- #games/moba |
| [Pillars of Eternity 2](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#) | April 21, 2022 | Games | \- #games/crpg |
| [Stardew Valley](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#) | April 04, 2021 | Games/finished | \- #games/simulation |

Implicit fields

Curious about `file.folder` and `file.etags`? Learn more about [implicit fields on pages](https://blacksmithgu.github.io/obsidian-dataview/annotation/metadata-pages/).

### Custom Column Headers

You can specify **custom headings** for your columns by using the `AS` syntax:

````
```dataview
TABLE started, file.folder AS Path, file.etags AS "File Tags"
FROM #games
```
````

**Output**

| File (3) | started | Path | File Tags |
| --- | --- | --- | --- |
| [League of Legends](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#) | May 16, 2021 | Games | \- #games/moba |
| [Pillars of Eternity 2](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#) | April 21, 2022 | Games | \- #games/crpg |
| [Stardew Valley](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#) | April 04, 2021 | Games/finished | \- #games/simulation |

Custom headers with spaces

If you want to use a custom header with spaces, like `File Tags`, you need to wrap it into double quotes: `"File Tags"`.

This is especially useful when you want to use **calculations or expressions as column values**:

````
```dataview
TABLE
default(finished, date(today)) - started AS "Played for",
file.folder AS Path,
file.etags AS "File Tags"
FROM #games
```
````

**Output**

| File (3) | Played for | Path | File Tags |
| --- | --- | --- | --- |
| [League of Legends](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#) | 1 years, 6 months, 1 weeks | Games | \- #games/moba |
| [Pillars of Eternity 2](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#) | 7 months, 2 days | Games | \- #games/crpg |
| [Stardew Valley](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#) | 4 months, 3 weeks, 3 days | Games/finished | \- #games/simulation |

Calculations and expressions

Learn more about the capability of computing expressions and calculations under [expressions](https://blacksmithgu.github.io/obsidian-dataview/reference/expressions/) and [functions](https://blacksmithgu.github.io/obsidian-dataview/reference/functions/).

### TABLE WITHOUT ID

If you don't want the first column ("File" or "Group" by default), you can use `TABLE WITHOUT ID`. `TABLE WITHOUT ID` works the same as `TABLE`, but it does not output the file link or group name as a first column if you add additional information.

You can use this if you, for example, output another identifying value:

````
```dataview
TABLE WITHOUT ID
steamid,
file.etags AS "File Tags"
FROM #games
```
````

**Output**

| steamid (3) | File Tags |
| --- | --- |
| 560130 | \- #games/crog |
| - | \- #games/moba |
| 413150 | \- #games/simulation |

Also, you can use `TABLE WITHOUT ID` if you want to **rename the first column for one specific query**.

````
```dataview
TABLE WITHOUT ID
file.link AS "Game",
file.etags AS "File Tags"
FROM #games
```
````

**Output**

| Game (3) | File Tags |
| --- | --- |
| [League of Legends](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#) | \- #games/moba |
| [Pillars of Eternity 2](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#) | \- #games/crpg |
| [Stardew Valley](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#) | \- #games/simulation |

Renaming the first column in general

If you want to rename the first column in all cases, change the name in Dataviews settings under Table Settings.

## TASK

The `TASK` Query outputs **an interactive list of all tasks in your vault** that match the given [data commands](https://blacksmithgu.github.io/obsidian-dataview/queries/data-commands/) (if any). `TASK` queries are special compared to the other Query Types because they do give back **Tasks as results and not pages**. This implies that all [data commands](https://blacksmithgu.github.io/obsidian-dataview/queries/data-commands/) operate on **Task level** and makes it possible to granularly filter your tasks i.e. for their status or meta data specified on the task itself.

Also, `TASK` Queries are the only possibility to **manipulate your files through DQL**. Normally, Dataview does not touch the content of your files; however, if you check a task through a dataview query, it'll get **checked in its original file, too**. In the Dataview Settings under "Task Settings", you can opt-in to automatically set a `completion` meta data field when checking a task in dataview. Mind though that this only works if you check the task inside a dataview block.

`TASK` Query Type

`TASK` queries render an interactive list of all tasks in your vault. `TASK` Queries are executed on **task level**, not page level, allowing for task-specific filtering. This is the only command in dataview that modifies your original files if interacted with.

````
```dataview
TASK
```
````

**Output**

- [ ]  Buy new shoes #shopping
- [ ]  Mail Paul about training schedule
- [ ] Finish the math assignment
  - [x]  Finish Paper 1 \[due:: 2022-08-13\]
  - [ ]  Read again through chapter 3 \[due:: 2022-09-01\]
  - [x]  Write a cheatsheet \[due:: 2022-08-02\]
  - [ ]  Write a summary of chapter 1-4 \[due:: 2022-09-12\]
- [x]  Hand in physics
- [ ]  Get new pillows for mom #shopping
- [x]  Buy some working pencils #shopping

You can use [data commands](https://blacksmithgu.github.io/obsidian-dataview/queries/data-commands/) like for all other Query Types. Data Commands are executed on task level, making [implicit fields on tasks](https://blacksmithgu.github.io/obsidian-dataview/annotation/metadata-tasks/) directly available.

````
```dataview
TASK
WHERE !completed AND contains(tags, "#shopping")
```
````

**Output**

- [ ]  Buy new shoes #shopping
- [ ]  Get new pillows for mom #shopping

A common use case for tasks is to **group tasks by their originating file**:

````
```dataview
TASK
WHERE !completed
GROUP BY file.link
```
````

**Output**

[2022-07-30](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#) (1)

- [ ] Finish the math assignment
  - [ ]  Read again through chapter 3 \[due:: 2022-09-01\]
  - [ ]  Write a summary of chapter 1-4 \[due:: 2022-09-12\]

[2022-09-21](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#) (2)

- [ ]  Buy new shoes #shopping
- [ ]  Mail Paul about training schedule

[2022-09-27](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/#) (1)

- [ ]  Get new pillows for mom #shopping

Counting tasks with subtask

Noticing the (1) on the header of `2022-07-30`? Child tasks belong to their parent task and are not counted separately. Also, they **behave differently** on filtering.

### Child Tasks

A task is considered a **child task** if it is **indented by a tab** and is below an unindented task.

- [ ] clean up the house
  - [ ]  kitchen
  - [x]  living room
  - [ ]  Bedroom \[urgent:: true\]

Children of a bullet point item

While indented tasks under a bulleted list item are, strictly speaking, also child tasks, Dataview will handle them like normal tasks in most cases.

Child Tasks **belong to their parent**. This means if you're querying for tasks, you'll get child tasks as part of their parent back.

````
```dataview
TASK
```
````

**Output**

- [ ] clean up the house
  - [ ]  kitchen
  - [x]  living room
  - [ ]  Bedroom \[urgent:: true\]
- [ ]  Call the insurance about the car
- [x]  Find out the transaction number

This specifically means that child task will be part of your result set **as long as the parent matches the query** \- even if the child task itself doesn't.

````
```dataview
TASK
WHERE !completed
```
````

**Output**

- [ ] clean up the house
  - [ ]  kitchen
  - [x]  living room
  - [ ]  Bedroom \[urgent:: true\]
- [ ]  Call the insurance about the car

Here, `living room` does **not match** the query, but is included anyway, because its parent `clean up the house` does match.

Mind that you'll get individual children tasks back, if the child matches your predicate but the parent doesn't:

````
```dataview
TASK
WHERE urgent
```
````

**Output**

- [ ]  Bedroom \[urgent:: true\]

## CALENDAR

The `CALENDAR` Query outputs a monthly based calendar where every result is depicted as a dot on it referring date. The `CALENDAR` is the only Query Type that requires an additional information. This additional information needs to be a [date](https://blacksmithgu.github.io/obsidian-dataview/annotation/types-of-metadata/#date) (or unset) on all queried pages.

`CALENDAR` Query Type

The `CALENDAR` Query Types renders a calendar view where every result is represented by a dot on the given meta data field date.

````
```dataview
CALENDAR file.ctime
```
````

**Output**

![](https://blacksmithgu.github.io/obsidian-dataview/assets/calendar_query_type.png)

While it is possible to use `SORT` and `GROUP BY` in combination with `CALENDAR`, it has **no effect**. Additionally, the calendar query does not render if the given meta data field contains something else than a valid [date](https://blacksmithgu.github.io/obsidian-dataview/annotation/types-of-metadata/#date) (but the field can be empty). To make sure you're only taking valid pages into account, you can filter for valid meta data values:

````
```dataview
CALENDAR due
WHERE typeof(due) = "date"
```
````
---

[Skip to content](https://blacksmithgu.github.io/obsidian-dataview/queries/dql-js-inline/#dql-js-and-inlines)

# DQL, JS and Inlines

Once you've added [useful data to relevant pages](https://blacksmithgu.github.io/obsidian-dataview/annotation/add-metadata/), you'll want to actually display it somewhere or operate on it. Dataview
allows this in four different ways, all of which are written in codeblocks directly in your Markdown and live-reloaded
when your vault changes.

## Dataview Query Language (DQL)

The [**Dataview Query Language**](https://blacksmithgu.github.io/obsidian-dataview/queries/structure/) (for short **DQL**) is a SQL-like language and Dataviews core functionality. It supports [four Query Types](https://blacksmithgu.github.io/obsidian-dataview/queries/query-types/) to produce different outputs, [data commands](https://blacksmithgu.github.io/obsidian-dataview/queries/data-commands/) to refine, resort or group your result and [plentiful functions](https://blacksmithgu.github.io/obsidian-dataview/reference/functions/) which allow numerous operations and adjustments to achieve your wanted output.

Warning

If you are familiar with SQL, please read [Differences to SQL](https://blacksmithgu.github.io/obsidian-dataview/queries/differences-to-sql/) to avoid confusing DQL with SQL.

You create a **DQL** query with a codeblock that uses `dataview` as type:

````
```dataview
TABLE rating AS "Rating", summary AS "Summary" FROM #games
SORT rating DESC
```
````

Use backticks

A valid codeblock needs to use backticks (\`) on start and end (three each). Do not confuse the backtick with the similar looking apostrophe ' !

Find a explanation how to write a DQL Query under the [query language\\
reference](https://blacksmithgu.github.io/obsidian-dataview/queries/structure/). If you learn better by example, take a look at the [query examples](https://blacksmithgu.github.io/obsidian-dataview/resources/examples/).

## Inline DQL

A Inline DQL uses a inline block format instead of a code block and a configurable prefix to mark this inline code block as a DQL block.

```
`= this.file.name`
```

Change of DQL prefix

You can change the `=` to another token (like `dv:` or `~`) in Dataviews' settings under "Codeblock Settings" > "Inline Query Prefix"

Inline DQL Queries display **exactly one value** somewhere in the middle of your note. They seamlessly blend into the content of your note:

```
Today is `= date(today)` - `= [[exams]].deadline - date(today)` until exams!
```

would, for example, render to

```
Today is November 07, 2022 - 2 months, 5 days until exams!
```

**Inline DQL** queries always display exactly one value, not a list (or table) of values. You can access the properties of the **current page** via prefix `this.` or a different page via `[[linkToPage]].`.

```
`= this.file.name`
`= this.file.mtime`
`= this.someMetadataField`
`= [[secondPage]].file.name`
`= [[secondPage]].file.mtime`
`= [[secondPage]].someMetadataField`
```

You can use everything available as [expressions](https://blacksmithgu.github.io/obsidian-dataview/reference/expressions/) and [literals](https://blacksmithgu.github.io/obsidian-dataview/reference/literals/) in an Inline DQL Query, including [functions](https://blacksmithgu.github.io/obsidian-dataview/reference/functions/). Query Types and Data Commands, on the other hand, are **not available in Inlines.**

```
Assignment due in `= this.due - date(today)`
Final paper due in `= [[Computer Science Theory]].due - date(today)`

🏃‍♂️ Goal reached? `= choice(this.steps > 10000, "YES!", "**No**, get moving!")`

You have `= length(filter(link(dateformat(date(today), "yyyy-MM-dd")).file.tasks, (t) => !t.completed))` tasks to do. `= choice(date(today).weekday > 5, "Take it easy!", "Time to get work done!")`
```

## Dataview JS

The dataview [JavaScript API](https://blacksmithgu.github.io/obsidian-dataview/api/intro/) gives you the full power of JavaScript and provides a DSL for pulling
Dataview data and executing queries, allowing you to create arbitrarily complex queries and views. Similar to the query
language, you create Dataview JS blocks via a `dataviewjs`-annotated codeblock:

````
```dataviewjs
let pages = dv.pages("#books and -#books/finished").where(b => b.rating >= 7);
for (let group of pages.groupBy(b => b.genre)) {
dv.header(3, group.key);
dv.list(group.rows.file.name);
}
```
````

Inside of a JS dataview block, you have access to the full dataview API via the `dv` variable. For an explanation of
what you can do with it, see the [API documentation](https://blacksmithgu.github.io/obsidian-dataview/api/code-reference/), or the [API\\
examples](https://blacksmithgu.github.io/obsidian-dataview/api/code-examples/).

Advanced usage

Writing Javascript queries is a advanced technique that requires understanding in programming and JS. Please be aware that JS Queries have access to your file system and be cautious when using other peoples' JS Queries, especially when they are not publicly shared through the Obsidian Community.

## Inline Dataview JS

Similar to the query language, you can write JS inline queries, which let you embed a computed JS value directly. You
create JS inline queries via inline code blocks:

```
`$= dv.current().file.mtime`
```

In inline DataviewJS, you have access to the `dv` variable, as in `dataviewjs` codeblocks, and can make all of the same calls. The result
should be something which evaluates to a JavaScript value, which Dataview will automatically render appropriately.

Unlike Inline DQL queries, Inline JS queries do have access to everything a Dataview JS Query has available and can hence query and output multiple pages.

Change of Inline JS prefix

You can change the `$=` to another token (like `dvjs:` or `$~`) in Dataviews' settings under "Codeblock Settings" > "Javascript Inline Query Prefix"
---

## Dataview JavaScript API

[Skip to content](https://blacksmithgu.github.io/obsidian-dataview/api/intro/#overview)

# Overview

The Dataview JavaScript API allows for executing arbitrary JavaScript with access to the dataview indices and query
engine, which is good for complex views or interop with other plugins. The API comes in two flavors: plugin facing, and
user facing (or 'inline API usage').

## Inline Access

You can create a "DataviewJS" block via:

````
```dataviewjs
dv.pages("#thing")...
```
````

Code executed in such codeblocks have access to the `dv` variable, which provides the entirety of the codeblock-relevant
dataview API (like `dv.table()`, `dv.pages()`, and so on). For more information, check out the [codeblock API\\
reference](https://blacksmithgu.github.io/obsidian-dataview/api/code-reference/).

## Plugin Access

You can access the Dataview Plugin API (from other plugins or the console) through `app.plugins.plugins.dataview.api`;
this API is similar to the codeblock reference, with slightly different arguments due to the lack of an implicit file
to execute the queries in. For more information, check out the [Plugin API reference](https://blacksmithgu.github.io/obsidian-dataview/api/code-reference/).