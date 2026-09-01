> Source: https://docs.firecrawl.dev/_llms/fr.md

# Firecrawl Docs: French

## French

- [French / v2 (202 pages)](https://docs.firecrawl.dev/_llms/fr/v2.md): Documentation for French / v2.

### v1

#### Documentation

##### Démarrage rapide

- [Introduction](https://docs.firecrawl.dev/fr/introduction.md): Recherchez sur le web, extrayez n’importe quelle page et interagissez avec elle, le tout via une seule API.
- [Premiers pas](https://docs.firecrawl.dev/fr/mcp-server.md): Configurez Firecrawl MCP avec un accès sans clé, une connexion à un compte ou une clé API.
- [Migration v1 → v2](https://docs.firecrawl.dev/fr/migrate-to-v2.md): Principales modifications, correspondances et exemples avant/après pour mettre à niveau votre intégration vers la v2.
- [Guide avancé de scraping](https://docs.firecrawl.dev/fr/advanced-scraping-guide.md): Configurez les options de scraping, les actions du navigateur, le crawl, la cartographie et le point de terminaison de l'agent grâce à l’ensemble de la surface de l’API Firecrawl.

###### Offres et facturation

- [Facturation](https://docs.firecrawl.dev/fr/billing.md): Fonctionnement de la facturation, des crédits et des offres Firecrawl
- [Limites de débit](https://docs.firecrawl.dev/fr/rate-limits.md): Limites de débit selon les forfaits et les requêtes API
- [Crédits partenaires](https://docs.firecrawl.dev/fr/partner-credits.md): Comment fonctionnent les crédits partenaires Firecrawl, notamment les conditions d’éligibilité, leur expiration et les limites de l’offre

###### Entreprise

- [Enterprise](https://docs.firecrawl.dev/fr/enterprise.md): Offres Enterprise, sécurité et fonctionnalités de Firecrawl à grande échelle
- [Restrictions d’adresses IP](https://docs.firecrawl.dev/fr/features/ip-restrictions.md): Restreignez les clés API de votre équipe à une liste d’autorisation d’adresses IP ou de plages CIDR, afin qu’elles ne fonctionnent que depuis des réseaux approuvés. Contrôle appliqué côté serveur.
- [Restrictions de clé](https://docs.firecrawl.dev/fr/features/key-restrictions.md): Verrouillez une clé API individuelle sur des formats de sortie et des points de terminaison spécifiques. Appliqué côté serveur, sans possibilité pour une requête de passer outre.
- [Protection contre les menaces](https://docs.firecrawl.dev/fr/features/threat-protection.md): Bloquez les requêtes vers des URL à risque sur tous les points de terminaison, à l’aide d’une politique contrôlée par votre organisation. Appliquée côté serveur.
- [Journalisation d’audit SIEM](https://docs.firecrawl.dev/fr/features/siem.md): Envoyez un événement d’audit structuré à votre SIEM pour chaque extraction effectuée par votre équipe, en commençant par Microsoft Sentinel. Livraison côté serveur.

##### Fonctionnalités de base

- [Crawl](https://docs.firecrawl.dev/fr/features/crawl.md): Crawler récursivement un site web et obtenir le contenu de chaque page
- [Cartographier](https://docs.firecrawl.dev/fr/features/map.md): Indiquez un site web et récupérez toutes ses URL — ultra rapide
- [Recherche](https://docs.firecrawl.dev/fr/features/search.md): Recherchez sur le web et obtenez le contenu complet des résultats

###### Extraction

- [Scrape](https://docs.firecrawl.dev/fr/features/scrape.md): Transformez n'importe quelle URL en données propres
- [Scraping plus rapide](https://docs.firecrawl.dev/fr/features/fast-scraping.md): Accélérez vos scrapes de 500 % grâce au paramètre maxAge
- [Scrape par lots](https://docs.firecrawl.dev/fr/features/batch-scrape.md): Scraper plusieurs URL en une seule tâche par lots
- [Mode JSON - Résultat structuré](https://docs.firecrawl.dev/fr/features/llm-extract.md): Extraire des données structurées à partir de pages via des LLM
- [Suivi des modifications](https://docs.firecrawl.dev/fr/features/change-tracking.md): Détecter et surveiller les changements dans le contenu web entre les extractions
- [Mode avancé](https://docs.firecrawl.dev/fr/features/enhanced-mode.md): Utilisez des proxies avancés pour un scraping fiable sur des sites complexes
- [Proxys](https://docs.firecrawl.dev/fr/features/proxies.md): Découvrez les types de proxy, les emplacements et la façon dont Firecrawl sélectionne des proxy pour vos requêtes.

##### Fonctionnalités d’agent

- [Agent FIRE-1 (bêta)](https://docs.firecrawl.dev/fr/agents/fire-1.md): Agent IA permettant une navigation et des interactions intelligentes avec les pages web

##### Webhooks

- [Vue d’ensemble](https://docs.firecrawl.dev/fr/webhooks/overview.md): Notifications en temps réel pour vos opérations Firecrawl
- [Types d’événements](https://docs.firecrawl.dev/fr/webhooks/events.md): Référence des événements webhook
- [Sécurité](https://docs.firecrawl.dev/fr/webhooks/security.md): Vérifiez l’authenticité des webhooks
- [Tests](https://docs.firecrawl.dev/fr/webhooks/testing.md): Tester et déboguer des webhooks

##### Dashboard

- [Vue d’ensemble](https://docs.firecrawl.dev/fr/dashboard.md): Vue d’ensemble du dashboard Firecrawl et de ses principales fonctionnalités

#### SDKs

##### Global

- [Aperçu](https://docs.firecrawl.dev/fr/sdks/overview.md): Les SDK Firecrawl sont des bibliothèques qui encapsulent l’API Firecrawl pour vous aider à effectuer facilement des recherches, à scraper et à interagir avec le web.

##### Officiel

- [Python](https://docs.firecrawl.dev/fr/sdks/python.md): Le SDK Python Firecrawl est une surcouche à l’API Firecrawl qui vous aide à convertir facilement des sites web en Markdown.
- [Node](https://docs.firecrawl.dev/fr/sdks/node.md): Scrapez, crawlez et extrayez des données structurées depuis des sites web avec le SDK Node de Firecrawl.
- [Go](https://docs.firecrawl.dev/fr/sdks/go.md): Le SDK Go de Firecrawl est un wrapper de l’API Firecrawl qui vous aide à convertir facilement des sites web en Markdown.
- [Java](https://docs.firecrawl.dev/fr/sdks/java.md): Le SDK Java de Firecrawl est un wrapper autour de l’API Firecrawl pour vous aider à convertir facilement des sites web en markdown.
- [Ruby](https://docs.firecrawl.dev/fr/sdks/ruby.md): Le SDK Ruby de Firecrawl est une surcouche de l'API Firecrawl qui vous permet de convertir facilement des sites web en Markdown.
- [Rust](https://docs.firecrawl.dev/fr/sdks/rust.md): Le SDK Rust de Firecrawl est un wrapper de l’API Firecrawl qui vous permet de convertir facilement des sites web en markdown.
- [.NET](https://docs.firecrawl.dev/fr/sdks/dotnet.md): Le SDK .NET de Firecrawl est un wrapper de l’API Firecrawl qui vous permet de convertir facilement des sites web en markdown.
- [PHP](https://docs.firecrawl.dev/fr/sdks/php.md): Le SDK PHP de Firecrawl est un wrapper de l’API Firecrawl qui vous permet de convertir facilement des sites web en markdown.
- [Elixir](https://docs.firecrawl.dev/fr/sdks/elixir.md): Le SDK Elixir de Firecrawl est un client auto-généré pour l’API v2 de Firecrawl, conçu avec Req et NimbleOptions.

## OpenAPI Specs

- [v2-openapi](/fr/api-reference/v2-openapi.json)
- [webhooks-openapi](/fr/api-reference/webhooks-openapi.json)

## Optional

- [Sandbox](https://firecrawl.dev/playground)
- [Blog](https://firecrawl.dev/blog)
- [Communauté](https://community.firecrawl.dev/)
- [Journal des modifications](https://firecrawl.dev/changelog)
- [Intégrations](https://www.firecrawl.dev/app)
