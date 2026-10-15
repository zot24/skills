> Source: https://docs.firecrawl.dev/features/sso.md

> ## Documentation Index
> Fetch the complete documentation index at: https://docs.firecrawl.dev/llms.txt
> Use this file to discover all available pages before exploring further.

# SSO and SCIM

> Set up single sign-on (SSO) and SCIM directory sync so your team signs in through your identity provider and user access stays in sync with your directory.

Single sign-on (SSO) lets your team sign in to Firecrawl through the identity provider your organization already manages, using SAML or OIDC. SCIM directory sync builds on SSO: users and groups in your directory are provisioned into, updated in, and removed from your Firecrawl teams automatically.


  SSO and SCIM are enterprise features and are enabled per organization. See [Enterprise features](/enterprise) for the rest of the enterprise plan.


## SSO

### Prerequisites

* An Enterprise plan.
* An IT or identity admin on your team.
* A supported identity provider, for example Microsoft Entra ID, Okta, Google Workspace, or another SAML or OIDC provider your admin already manages.

### Setup


    Your IT admin contacts Firecrawl support at [help@firecrawl.dev](mailto:help@firecrawl.dev) and asks to enable SSO for your organization. Firecrawl turns it on and sends setup instructions to the IT contact you name.


    Firecrawl uses WorkOS for SSO. Your IT admin completes setup in the WorkOS invitation, where they configure your identity provider.


    When setup is done, team members sign in from the [Firecrawl sign-in page](https://www.firecrawl.dev/app) using your organization's SSO.


## SCIM directory sync

SCIM directory sync (user provisioning) connects a directory in your identity provider to a Firecrawl team. Firecrawl uses WorkOS Directory Sync, so when people join, change, or leave in your directory, the same change is applied in Firecrawl without manual invites or removals.

### Prerequisites

* SSO set up for your organization. The **User Provisioning (SCIM)** tab only appears once your organization has an SSO configuration.
* An identity provider that supports SCIM provisioning, such as Okta, Microsoft Entra ID, or Google Workspace.
* A team **admin** in Firecrawl to manage provisioning in the dashboard.

### Setup


    Contact Firecrawl support at [help@firecrawl.dev](mailto:help@firecrawl.dev) and ask to enable directory sync. Your IT admin connects your identity provider's SCIM app through WorkOS, and you receive the WorkOS directory ID for the connection (it looks like `directory_01...`).


    In the dashboard, open [Enterprise Controls → User Provisioning (SCIM)](https://www.firecrawl.dev/app/enterprise-controls?tab=scim). Under **Directory → team bindings**, select the team users should be provisioned into and click **Add binding**. One organization can bind several directories, each to a different team.


    On the binding, paste the **WorkOS directory ID** and save it, then turn on **Enable user provisioning**. Directory events are only processed while provisioning is enabled.


    Groups pushed from your identity provider appear under **Push groups**. For each group, choose a **Role** (`member` or `admin`) and, optionally, a **Team** other than the binding team. Groups left as `unmapped` grant no role. If a user is in several mapped groups, they get the highest role.


If users or groups that already existed in your directory are missing, open the binding's actions menu and click **Sync from WorkOS** to pull in users, groups, and memberships.

### What gets synced

* **New users** in the directory are added to the binding team as members, then given the role from their mapped groups.
* **Profile updates** such as name and avatar are applied to the user. Sign-in email is not changed by directory sync.
* **Group membership changes** add or remove users from teams that groups are routed to, and update their role.
* **Deactivated or deleted users** are removed from every team the directory governs. API keys they created are not revoked, because keys belong to the team. Rotate them from the dashboard if needed.

On a team managed by directory sync, members can't be removed manually from team settings, since your identity provider owns membership.

The **User Provisioning (SCIM)** tab also has two optional access controls: **Restrict team creation**, so only organization admins can create teams, and **Restrict domain signup**, which blocks self-serve signup for your organization's verified or SSO-required domains. SSO login and SCIM provisioning are not affected by either setting.


This documentation is built and hosted on [Mintlify](https://mintlify.com), a developer documentation platform.
