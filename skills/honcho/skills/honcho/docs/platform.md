> Source: https://docs.honcho.dev/v3/documentation/reference/platform.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.honcho.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# The Honcho Dashboard

> Build stateful agents without worrying about infrastructure


  Start using the platform to manage Honcho instances for your workspace or app.


The quickest way to begin using Honcho in production is with the
[Honcho Cloud Service](https://app.honcho.dev). Sign up, generate an API key,
and start building with Honcho.

## 1. Go to [app.honcho.dev](https://app.honcho.dev)

Create an account to start using Honcho. If a teammate already uses Honcho, ask
them to invite you to their organization. Otherwise, you'll see a banner
prompting you to create a new one.

<div style={{ maxWidth: "400px", margin: "0 auto" }}>
  <Frame>
    <img src="https://mintcdn.com/plasticlabs/lVyHfvNDd8wveJyM/images/app-screenshots/welcome-to-honcho.png?fit=max&auto=format&n=lVyHfvNDd8wveJyM&q=85&s=5d650ef0df0b7d327adf5a0cfcf81e45" alt="Honcho Platform Dashboard" loading="lazy" decoding="async" fetchpriority="low" style={{ width: "100%", height: "auto" }} width="970" height="1228" data-path="images/app-screenshots/welcome-to-honcho.png" />
  </Frame>
</div>

Once you've created an organization, you'll be taken to the dashboard and see
the Welcome page with integration guidance and links to documentation.

<Frame>
  <img src="https://mintcdn.com/plasticlabs/lVyHfvNDd8wveJyM/images/app-screenshots/get-started-copy.png?fit=max&auto=format&n=lVyHfvNDd8wveJyM&q=85&s=0957b2e6b1cc2de1a210ad76dc92f9d3" alt="Honcho Dashboard Getting Started" width="1200" height="800" loading="lazy" decoding="async" fetchpriority="low" data-path="images/app-screenshots/get-started-copy.png" />
</Frame>

Each organization has dedicated infrastructure running to isolate your
workloads. Once you add a valid payment method under the
[Billing](https://app.honcho.dev/billing) page, your instance will turn on.

## 2. Activate your Honcho instance

Navigate to the [Billing](https://app.honcho.dev/billing) page to add a payment method. Your Honcho instance provisions automatically, and you can monitor the deployment on the [Instance Status](https://app.honcho.dev/status) page until all systems show a green check mark.

<Frame>
  <img src="https://mintcdn.com/plasticlabs/lVyHfvNDd8wveJyM/images/app-screenshots/status-page.png?fit=max&auto=format&n=lVyHfvNDd8wveJyM&q=85&s=98159448f6d8cb42849114f0034c4dab" alt="Instance Status Page" width="1200" height="800" loading="lazy" decoding="async" fetchpriority="low" data-path="images/app-screenshots/status-page.png" />
</Frame>

You can also upgrade Honcho when new versions are made available directly from the status page.

<div style={{ maxWidth: "700px", margin: "0 auto" }}>
  <Frame>
    <img src="https://mintcdn.com/plasticlabs/lVyHfvNDd8wveJyM/images/app-screenshots/upgrade-honcho.png?fit=max&auto=format&n=lVyHfvNDd8wveJyM&q=85&s=888096650b6391d8afb257335593e773" alt="Upgrade Honcho" loading="lazy" decoding="async" fetchpriority="low" style={{ width: "100%", height: "auto" }} width="1330" height="545" data-path="images/app-screenshots/upgrade-honcho.png" />
  </Frame>
</div>

The **Performance** page provides comprehensive monitoring with usage metrics, health analytics, API response times, and endpoint usage across Honcho.

<Frame>
  <img src="https://mintcdn.com/plasticlabs/lVyHfvNDd8wveJyM/images/app-screenshots/performance-analytics.png?fit=max&auto=format&n=lVyHfvNDd8wveJyM&q=85&s=99fdfa2174ad9f4ee8238bf75dbcfa3b" alt="Performance Analytics Dashboard" width="1200" height="800" loading="lazy" decoding="async" fetchpriority="low" data-path="images/app-screenshots/performance-analytics.png" />
</Frame>

## 3. Manage API Keys

The [API Keys](https://app.honcho.dev/api-keys) page allows you to create and manage authentication tokens for different environments. You can create admin-level keys with full instance access or scope keys to specific `Workspaces`, `Peers`, or `Sessions`.

<Frame>
  <img src="https://mintcdn.com/plasticlabs/lVyHfvNDd8wveJyM/images/app-screenshots/api-keys.png?fit=max&auto=format&n=lVyHfvNDd8wveJyM&q=85&s=0ecd65b84a9a5150a943ea14bdfd8c30" alt="API Key Management Dashboard" width="1200" height="800" loading="lazy" decoding="async" fetchpriority="low" data-path="images/app-screenshots/api-keys.png" />
</Frame>

## 4. Test with API Playground

The [API Playground](https://app.honcho.dev/playground) provides a Postman-like interface to test queries, explore endpoints, and validate your integration. Authenticate with an API key and send requests directly to your Honcho instance with real-time responses and full request/response logging.

<Frame>
  <img src="https://mintcdn.com/plasticlabs/6O7xRufE052olsvb/images/app-screenshots/api-playground.png?fit=max&auto=format&n=6O7xRufE052olsvb&q=85&s=bd3d604fc0b7bada3785cf4a956893f9" alt="API Playground Interface" width="1200" height="800" loading="lazy" decoding="async" fetchpriority="low" data-path="images/app-screenshots/api-playground.png" />
</Frame>

## 5. Workspaces

The [Explore](https://app.honcho.dev/explore) page provides comprehensive `Workspace` management where you can create workspaces and begin exploring the platform. Each `Workspace` serves as a container for organizing your Honcho data.

<Frame>
  <img src="https://mintcdn.com/plasticlabs/lVyHfvNDd8wveJyM/images/app-screenshots/explore-honcho.png?fit=max&auto=format&n=lVyHfvNDd8wveJyM&q=85&s=95a8180f4c1841a86d2e0309111ce99b" alt="Workspace Table" width="1200" height="800" loading="lazy" decoding="async" fetchpriority="low" data-path="images/app-screenshots/explore-honcho.png" />
</Frame>

Click into any workspace to access a general overview of `Peers` and `Sessions`. Here you can quickly create `Peers`, `Sessions`, and add multiple `Peers` to any `Session`. Edit the metadata and configuration for a `Workspace` with the Edit Config button. Click into any entity to navigate to their respective utilities pages or click the expand icon to view Workspace-wide `Peers` and `Sessions` data tables with more details.

<Frame>
  <img src="https://mintcdn.com/plasticlabs/lVyHfvNDd8wveJyM/images/app-screenshots/workspace-dash.png?fit=max&auto=format&n=lVyHfvNDd8wveJyM&q=85&s=7f570e6aebf25a67c1142b211f919178" alt="Workspace Dashboard Overview" width="1200" height="800" loading="lazy" decoding="async" fetchpriority="low" data-path="images/app-screenshots/workspace-dash.png" />
</Frame>

## 6. Peer Dashboard & Utilities

Expand the `Peers` list from the `Workspace` dashboard to see a detailed view of `Peers`.

<Frame>
  <img src="https://mintcdn.com/plasticlabs/lVyHfvNDd8wveJyM/images/app-screenshots/peer-dash.png?fit=max&auto=format&n=lVyHfvNDd8wveJyM&q=85&s=bb3eaf7fc86fa7bdb32d5def13eb83f0" alt="Peer Dashboard" width="1200" height="800" loading="lazy" decoding="async" fetchpriority="low" data-path="images/app-screenshots/peer-dash.png" />
</Frame>

Click into any peer to navigate to their respective utilities page. Next to the `Peer` name you can edit the [Peer Configuration](/v3/documentation/features/advanced/reasoning-configuration), and in the tabs below, explore all utilities for the `Peer`.

<Frame>
  <img src="https://mintcdn.com/plasticlabs/lVyHfvNDd8wveJyM/images/app-screenshots/peer-utilities.png?fit=max&auto=format&n=lVyHfvNDd8wveJyM&q=85&s=9fb53f36a54490d4ba29c584fba9e421" alt="Peer Management Dashboard" width="1200" height="800" loading="lazy" decoding="async" fetchpriority="low" data-path="images/app-screenshots/peer-utilities.png" />
</Frame>

Utilities include:

* **Message search** across all sessions for a `Peer`
* **Chat** to query `Peer` representations with an optional session scope (results vary based on the `Peer`'s configuration)

<Frame>
  <img src="https://mintcdn.com/plasticlabs/lVyHfvNDd8wveJyM/images/app-screenshots/chat-endpoint.png?fit=max&auto=format&n=lVyHfvNDd8wveJyM&q=85&s=7b45b0dcf3da581478cfc8e3c0e499c5" alt="Chat Endpoint" width="1200" height="800" loading="lazy" decoding="async" fetchpriority="low" data-path="images/app-screenshots/chat-endpoint.png" />
</Frame>

* **Session logs** view which `Sessions` the `Peer` is active
* **Peer configuration and metadata management** including [Session-Peer Configuration](/v3/documentation/features/advanced/reasoning-configuration#session-configuration)

<Frame>
  <img src="https://mintcdn.com/plasticlabs/lVyHfvNDd8wveJyM/images/app-screenshots/peer-utilities.png?fit=max&auto=format&n=lVyHfvNDd8wveJyM&q=85&s=9fb53f36a54490d4ba29c584fba9e421" alt="Peer Management Dashboard" width="1200" height="800" loading="lazy" decoding="async" fetchpriority="low" data-path="images/app-screenshots/peer-utilities.png" />
</Frame>

## 7. Session Dashboard & Utilities

Click into the sessions view within a workspace to see a table of all of your `Sessions` data.

<Frame>
  <img src="https://mintcdn.com/plasticlabs/lVyHfvNDd8wveJyM/images/app-screenshots/session-dash.png?fit=max&auto=format&n=lVyHfvNDd8wveJyM&q=85&s=defe9758490b1df1df73ef3136b857bb" alt="Sessions Table" width="1200" height="800" loading="lazy" decoding="async" fetchpriority="low" data-path="images/app-screenshots/session-dash.png" />
</Frame>

Click into a `Session` to open its utilities page.

<Frame>
  <img src="https://mintcdn.com/plasticlabs/lVyHfvNDd8wveJyM/images/app-screenshots/session-utilities.png?fit=max&auto=format&n=lVyHfvNDd8wveJyM&q=85&s=8d56e70f80ab22ab0f35533e4721a9a9" alt="Session Utilities" width="1200" height="800" loading="lazy" decoding="async" fetchpriority="low" data-path="images/app-screenshots/session-utilities.png" />
</Frame>

Here you can:

* **View and add Messages** within the `Session`; filter messages by `Peer`
* **Advanced search** across `Session` messages
* **Peer management** for adding/removing `Peers` and editing a `Peer`'s Session-level configuration
* **Get Context** to generate LLM-ready context with customizable token limits

<Frame>
  <img src="https://mintcdn.com/plasticlabs/lVyHfvNDd8wveJyM/images/app-screenshots/get-context.png?fit=max&auto=format&n=lVyHfvNDd8wveJyM&q=85&s=f1d3cad3007f4d1ef56af8079d7212bb" alt="Get Context" width="1200" height="800" loading="lazy" decoding="async" fetchpriority="low" data-path="images/app-screenshots/get-context.png" />
</Frame>

## 8. Webhooks Integration

The [Webhooks](https://app.honcho.dev/webhooks) page enables Webhook creation and management.

<Frame>
  <img src="https://mintcdn.com/plasticlabs/lVyHfvNDd8wveJyM/images/app-screenshots/webhooks-page.png?fit=max&auto=format&n=lVyHfvNDd8wveJyM&q=85&s=ef4dd7093046916d8cc723080c6ff753" alt="Webhooks Dashboard" width="1200" height="800" loading="lazy" decoding="async" fetchpriority="low" data-path="images/app-screenshots/webhooks-page.png" />
</Frame>

## 9. Organization Member Access

The [Members](https://app.honcho.dev/members) page provides organization administration to manage your team's access to Honcho with the ability to grant admin permissions.

<Frame>
  <img src="https://mintcdn.com/plasticlabs/lVyHfvNDd8wveJyM/images/app-screenshots/members-dashboard.png?fit=max&auto=format&n=lVyHfvNDd8wveJyM&q=85&s=95565b05f0aebaa6c6cd75cb2851d725" alt="Members Dashboard" width="1200" height="800" loading="lazy" decoding="async" fetchpriority="low" data-path="images/app-screenshots/members-dashboard.png" />
</Frame>

## Go Further

View the [Architecture](/v3/documentation/core-concepts/architecture) to see how Honcho works under the hood.

Dive into our [API Reference](/v3/api-reference) to explore all available endpoints.

## Next Steps


    Get started with managed Honcho instances


    Connect with 1000+ developers building with Honcho


    View our guidelines and explore the codebase


    See Honcho in action with real examples


