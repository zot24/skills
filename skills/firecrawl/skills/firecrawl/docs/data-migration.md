> Source: https://docs.firecrawl.dev/use-cases/data-migration.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Data Migration

> Transfer web data efficiently between platforms and systems

Extract content, structure, and metadata from any website and transform it for import into a new platform. Firecrawl handles the scraping so you can focus on mapping data to your target system.

## Start with a Template

> [card] [Firecrawl Migrator](https://github.com/firecrawl/firecrawl-migrator)
>
> Efficiently migrate data between platforms and systems

## How It Works

Point Firecrawl at your source website to crawl every page and return clean, structured data. From there, you transform the output to match your target platform's schema and import it using that platform's API or bulk-import tools.

## What You Can Migrate

* **Content**: Pages, posts, articles, media files, metadata
* **Structure**: Hierarchies, categories, tags, taxonomies
* **Users**: Profiles and user-related data where publicly accessible
* **Settings**: Configurations, custom fields, workflows
* **E-commerce**: Products, catalogs, inventory, orders

## Common Migration Use Cases

Users build migration tools with Firecrawl to extract data from various platforms:

> [card] CMS Content Extraction
>
> Extract content from WordPress, Drupal, and Joomla sites or custom CMS platforms. Preserve content structure and metadata, then export for import into new systems like Contentful, Strapi, or Sanity.

> [card] E-commerce Data Extraction
>
> Extract product catalogs from Magento and WooCommerce stores including inventory, pricing, descriptions, and specifications. Format data for import into Shopify, BigCommerce, or other platforms.

## FAQs

> [accordion] How do you handle large-scale migrations?
>
> Our infrastructure scales automatically to handle large migrations. We support incremental processing with batching and parallel extraction, allowing you to migrate millions of pages by breaking them into manageable chunks with progress tracking.

> [accordion] Can I preserve SEO value during migration?
>
> Yes! Extract all SEO metadata including URLs, titles, descriptions, and implement proper redirects. We help maintain your search rankings through the migration.

> [accordion] What about media files and attachments?
>
> Firecrawl can extract and catalog all media files. You can download them for re-upload to your new platform or reference them directly if keeping the same CDN.

> [accordion] How do I validate the migration?
>
> We provide detailed extraction reports and support comparison tools. You can verify content completeness, check broken links, and validate data integrity.

> [accordion] Can I migrate user-generated content and comments?
>
> Yes, you can extract publicly visible user-generated content including comments, reviews, and forum posts. Private user data requires appropriate authentication and permissions.

## Related Use Cases

* [Product & E-commerce](https://docs.firecrawl.dev/use-cases/product-ecommerce.md) - Catalog migrations
* [Content Generation](https://docs.firecrawl.dev/use-cases/content-generation.md) - Content transformation
* [AI Platforms](https://docs.firecrawl.dev/use-cases/ai-platforms.md) - Knowledge base migration


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
