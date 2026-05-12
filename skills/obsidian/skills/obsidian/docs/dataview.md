> Source: https://blacksmithgu.github.io/obsidian-dataview/


<a href="#overview" class="md-skip">Skip to content</a>


Initializing search


<a href="https://github.com/blacksmithgu/obsidian-dataview" class="md-source" data-md-component="source" title="Go to repository"></a>


GitHub


<a href="#resources-and-help" class="md-nav__link"><span class="md-ellipsis"> Resources and Help </span></a>


<a href="queries/dql-js-inline/" class="md-nav__link"><span class="md-ellipsis"> DQL, JS and Inlines </span></a>


<a href="friends/" class="md-nav__link"><span class="md-ellipsis"> Friends of Dataview </span></a>

<a href="changelog/" class="md-nav__link"><span class="md-ellipsis"> Changelog </span></a>


<a href="#resources-and-help" class="md-nav__link"><span class="md-ellipsis"> Resources and Help </span></a>


# Overview

Dataview is a live index and query engine over your personal knowledge base. You can [**add metadata**](annotation/add-metadata/) to your notes and **query** them with the [**Dataview Query Language**](queries/structure/) to list, filter, sort or group your data. Dataview keeps your queries always up to date and makes data aggregation a breeze.

You could

- Track your sleep by recording it in daily notes, and automatically create weekly tables of your sleep schedule.
- Automatically collect links to books in your notes, and render them all sorted by rating.
- Automatically collect pages associated with today's date and show them in your daily note.
- Find pages with no tags for follow-up, or show pretty views of specifically-tagged pages.
- Create dynamic views which show upcoming birthdays or events recorded in your notes

and many more things.


Dataview gives you a fast way to search, display and operate on indexed data in your vault!


Dataview is highly generic and high performance, scaling up to hundreds of thousands of annotated notes without issue.

If the built in [query language](queries/structure/) is insufficient for your purpose, you can run arbitrary JavaScript against the [dataview API](api/intro/) and build whatever utility you might need yourself, right in your notes.


Dataview is about displaying, not editing

Dataview is meant for displaying and calculating data. It is not meant to edit your notes/metadata and will always leave them untouched (... except if you're checking a [Task](queries/query-types/#task) through Dataview.)


## How to Use Dataview

Dataview consists of two big building blocks: **Data Indexing** and **Data Querying**.


More details on the linked documentation pages

The following sections should give you a general overview about what you can do with dataview and how. Be sure to visit the linked pages to find out more about the individual parts.


### Data Indexing

Dataview operates on metadata in your Markdown files. It cannot read everything in your vault, but only specific data. Some of your content, like tags and bullet points (including tasks), are [available automatically](annotation/add-metadata/#implicit-fields) in Dataview. You can add other data through **fields**, either on top of your file [per YAML Frontmatter](annotation/add-metadata/#frontmatter) or in the middle of your content with [Inline Fields](annotation/add-metadata/#inline-fields) via the `[key:: value]` syntax. Dataview *indexes* these data to make it available for you to query.


Dataview indexes [certain information](annotation/add-metadata/#implicit-fields) like tags and list items and the data you add via fields. Only indexed data is available in a Dataview query!


For example, a file might look like this:


    ---
    author: "Edgar Allan Poe"
    published: 1845
    tags: poems
    ---

    # The Raven

    Once upon a midnight dreary, while I pondered, weak and weary,
    Over many a quaint and curious volume of forgotten lore—


Or like this:


    #poems

    # The Raven

    From [author:: Edgar Allan Poe], written in (published:: 1845)

    Once upon a midnight dreary, while I pondered, weak and weary,
    Over many a quaint and curious volume of forgotten lore—


In terms of indexed metadata (or what you can query), they are identical, and only differ in their annotation style. How you want to [annotate your metadata](annotation/add-metadata/) is up to you and your personal preference. With this file, you'd have the **metadata field** `author` available and everything Dataview provides you [automatically as implicit fields](annotation/metadata-pages/), like the tag or note title.


Data needs to be indexed

In the above example, you *do not* have the poem itself available in Dataview: It is a paragraph, not a metadata field and not something Dataview indexes automatically. It is not part of Dataviews index, so you won't be able to query it.


### Data Querying

You can access **indexed data** with the help of **Queries**.

There are **three different ways** you can write a Query: With help of the [Dataview Query Language](queries/dql-js-inline/#dataview-query-language-dql), as an [inline statement](queries/dql-js-inline/#inline-dql) or in the most flexible but most complex way: as a [Javascript Query](queries/dql-js-inline/#dataview-js).

The **Dataview Query Language** (**DQL**) gives you a broad and powerful toolbelt to query, display and operate on your data. An [**inline query**](queries/dql-js-inline/#inline-dql) gives you the possibility to display exactly one indexed value anywhere in your note. You can also do calculations this way. With **DQL** at your hands, you'll be probably fine without any Javascript through your data journey.

A DQL Query consists of several parts:

- Exactly one [**Query Type**](queries/query-types/) that determines what your Query Output looks like
- None or one [**FROM statement**](queries/data-commands/#from) to pick a specific tag or folder (or another [source](reference/sources/)) to look at
- None to multiple [**other Data Commands**](queries/data-commands/) that help you filter, group and sort your wanted output

For example, a Query can look like this:


    ```dataview
    LIST
    ```


which list all files in your vault.


Everything but the Query Type is optional

The only thing you need for a valid DQL Query is the Query Type (and on [CALENDAR](queries/query-types/#calendar)s, a date field.)


A more restricted Query might look like this:


    ```dataview
    LIST
    FROM #poems
    WHERE author = "Edgar Allan Poe"
    ```


which lists all files in your vault that have the tag `#poems` and a [field](annotation/add-metadata/) named `author` with the value `Edgar Allan Poe`. This query would find our example page from above.

`LIST` is only one out of four [Query Types](queries/query-types/) you can use. For example, with a `TABLE`, we could add some more information to our output:


    ```dataview
    TABLE author, published, file.inlinks AS "Mentions"
    FROM #poems
    ```


This'll give you back a result like:

| File (3)         | author          | published | Mentions                  |
|------------------|-----------------|-----------|---------------------------|
| The Bells        | Edgar Allan Poe | 1849      |                           |
| The New Colossus | Emma Lazarus    | 1883      | \- \[\[Favorite Poems\]\] |
| The Raven        | Edgar Allan Poe | 1845      | \- \[\[Favorite Poems\]\] |

That's not where the capabilities of dataview end, though. You can also **operate on your data** with help of [**functions**](reference/functions/). Mind that these operations are only made inside your query - your **data in your files stays untouched**.


    ```dataview
    TABLE author, date(now).year - published AS "Age in Yrs", length(file.inlinks) AS "Counts of Mentions"
    FROM #poems
    ```


gives you back

| File (3)         | author          | Age in Yrs | Count of Mentions |
|------------------|-----------------|------------|-------------------|
| The Bells        | Edgar Allan Poe | 173        | 0                 |
| The New Colossus | Emma Lazarus    | 139        | 1                 |
| The Raven        | Edgar Allan Poe | 177        | 1                 |


Find more examples [here](resources/examples/).


As you can see, dataview doesn't only allow you to aggregate your data swiftly and always up to date, it also can help you with operations to give you new insights on your dataset. Browse through the documentation to find out more on how to interact with your data.

Have fun exploring your vault in new ways!

## Resources and Help

This documentation is not the only place that can help you out on your data journey. Take a look at [Resources and Support](resources/resources-and-support/) for a list of helpful pages and videos.


