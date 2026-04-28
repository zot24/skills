> Source: https://docs.firecrawl.dev/use-cases/data-migration.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# Data Migration

> Transfer web data efficiently between platforms and systems

Extract content, structure, and metadata from any website and transform it for import into a new platform. Firecrawl handles the scraping so you can focus on mapping data to your target system.

## Start with a Template


  Efficiently migrate data between platforms and systems


  **Get started with the Firecrawl Migrator template.** Extract and transform data for platform migrations.


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


    Extract content from WordPress, Drupal, and Joomla sites or custom CMS platforms. Preserve content structure and metadata, then export for import into new systems like Contentful, Strapi, or Sanity.


    Extract product catalogs from Magento and WooCommerce stores including inventory, pricing, descriptions, and specifications. Format data for import into Shopify, BigCommerce, or other platforms.


## FAQs


    Our infrastructure scales automatically to handle large migrations. We support incremental processing with batching and parallel extraction, allowing you to migrate millions of pages by breaking them into manageable chunks with progress tracking.


    Yes! Extract all SEO metadata including URLs, titles, descriptions, and implement proper redirects. We help maintain your search rankings through the migration.


    Firecrawl can extract and catalog all media files. You can download them for re-upload to your new platform or reference them directly if keeping the same CDN.


    We provide detailed extraction reports and support comparison tools. You can verify content completeness, check broken links, and validate data integrity.


    Yes, you can extract publicly visible user-generated content including comments, reviews, and forum posts. Private user data requires appropriate authentication and permissions.


## Related Use Cases

* [Product & E-commerce](/use-cases/product-ecommerce) - Catalog migrations
* [Content Generation](/use-cases/content-generation) - Content transformation
* [AI Platforms](/use-cases/ai-platforms) - Knowledge base migration
