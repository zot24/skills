> Source: https://wiki.servarr.com/prowlarr/indexers



This page will describe how to add and configure indexers in Prowlarr.

# <a href="#adding-an-indexer" class="toc-anchor">¶</a> Adding an Indexer

To add an indexer, first click on `Indexers` on the left, then + `Add Indexer` at the top of the page.

![ind_1_addindexer.png](/assets/prowlarr/ind_1_addindexer.png)

Choose your indexer from the list, or type a partial name in the box to find your indexer. If your indexer is not listed, you may be able to use "Generic Newznab" (for Usenet) or "Generic Torznab" (for torrents). Otherwise visit our <a href="https://requests.prowlarr.com/" class="is-external-link">Indexer Request site</a>.

> Using `Generic Newznab` or `Generic Torznab` assumes your indexer supports standardized \*znab formats. If it doesn't, then this will not work

> Note: almost every Usenet site is compatible with Generic Newznab.

> If your tracker or indexer is not listed and not on our <a href="/prowlarr/supported-indexers" class="is-internal-link is-valid-page">supported indexers</a> page, you can request it be added via our <a href="https://requests.prowlarr.com" class="is-external-link">Indexer Requests Site</a>

# <a href="#editing-an-indexer" class="toc-anchor">¶</a> Editing an Indexer

To edit an indexer, first click on `Indexers` on the left, then click the wrench icon to the far right of the Indexer you wish to edit.

# <a href="#viewing-an-indexer-id-or-url" class="toc-anchor">¶</a> Viewing an Indexer Id or URL

To view details about an indexer, first click on `Indexers` on the left, then click the Indexer Link in the Indexer Name Column. (Formerly the (i) icon to the right)

Details available may include:

- Id in Prowlarr
- Description
- Encoding
- Language
- Site
- Newznab/Torznab Prowlarr URL
- Site Capabilities

# <a href="#indexer-settings" class="toc-anchor">¶</a> Indexer Settings

Once you've selected your indexer, there will be a pop-up containing further information you will need to configure it. Note that the specific settings will change slightly for each indexer based on their required fields and the type of indexer you're configuring.

![ind_3_indexer2.png](/assets/prowlarr/ind_3_indexer2.png)

- Name - Select a name for this indexer. When it syncs to your apps, it will add `(Prowlarr)` behind it.
- Enable - Check the box to enable this indexer.
- Redirect - If enabled, this will pass the grab link directly to the application rather than proxying it via Prowlarr. Redirect is **required** for all Usenet (Newznab) indexers and cannot be disabled for them. For torrent indexers it is optional and only needed for a small number of specific trackers to avoid being banned.

> Redirect is mandatory for all Usenet indexers. Attempting to save a Usenet indexer with Redirect disabled will result in a validation error.

- Sync Profile - Select your Sync Profile here. These can be created in <a href="/prowlarr/settings#applications" class="is-internal-link is-valid-page"><code>Settings</code> =&gt; <code>Apps</code></a>. The Standard default, profile already exists, and looks like this:

> You can have different settings per app by creating multiple instances of the indexer

![ind_3_settingsapps.png](/assets/prowlarr/ind_3_settingsapps.png)

- URL - Select the URL for Prowlarr to use. If blank, the default/first url is used.

- Download Link - If you're adding a torrent indexer, you may need to choose what kind of download link to use.

- (Advanced Option) API Path - Path to the Indexer's API. Typically `/api`

- Credentials - Many indexers and trackers require you to authenticate / login in some way. You may have to enter an API key, RSS key, a session id, a cookie, or other credentials from your indexer (usually found in your Profile Page or under Security), select search orders, or other options for your specific indexer.

  - API Key
  - RSS Key
  - Session ID
  - Cookie
  - Username/Password
  - etc.

- (Advanced Option) Additional Parameters - Additional parameters to add to the requests for this indexer.

- VIP Expiration - Enter the date in ISO format (yyyy-MM-DD) to be notified 1 week prior to expiration; otherwise leave blank

- Tags - Use tags to specify default download clients, specify Indexer Proxies, specify indexers to applications or just to organize your indexers.

- (Advanced Option) Query Limit - If your indexer limits your API hits per the configured unit, you can enter that number here to avoid exceeding the limit.

- (Advanced Option) Grab Limit - If your indexer limits your Grabs per the configured unit, you can enter that number here to avoid exceeding the limit. Once the grab limit is reached further queries will trigger an unhandled exception in \*Arr Apps. Other apps may vary.

- (Advanced Option) Limits Unit - The unit of time for counting Query and Grab Limits per indexer. Options are `Day` (default) or `Hour`.

- (Advanced Option) Seed Ratio - For Torrent Indexers Only: The ratio a torrent should reach before stopping, empty is app's default

- (Advanced Option) Seed Time - For Torrent Indexers Only: The time a torrent should be seeded before stopping, empty is app's default. Values are in minutes.

- (Advanced Option) Pack Seed Time - For Torrent Indexers Only: The time a pack (season or discography) torrent should be seeded before stopping, empty is app's default. Values are in minutes.

- (Advanced Option) Apps Minimum Seeders - For Torrent Indexers Only: The minimum number of seeders required by the connected apps for this indexer to grab a release. Empty uses the Sync Profile's default.

- (Advanced Option) Prefer Magnet URL - For Torrent Indexers Only: When enabled, this indexer will prefer magnet URLs over torrent file links for grabs.

- (Advanced Option) Indexer Priority - Priority of this indexer to prefer one indexer over another in release tiebreaker scenarios. 1 is highest priority and 50 is lowest priority, with 25 as the default. These priorities will sync to the \*Arr apps.

- Download Client - Specify which download client is used for grabs made within Prowlarr from this indexer. Leave blank to use any available download client.

- Test your indexer, and if a green checkmark appears, you're okay to save it. When you save it, depending on your sync settings, it will be added to your apps automatically.

## <a href="#adding-a-custom-yml-definition" class="toc-anchor">¶</a> Adding a custom YML definition

- Note that the yml definition is cached for a short period and if you make changes for development purposes you will need to wait out the cache or restart Prowlarr.
- If you wish to add a custom Cardigann compatible YML definition file for an indexer that is not supported or to test changes to an existing definition file:
  - Create (or if already created, navigate to) the Custom Indexer Definition folder named `Custom` within the `Definitions` folder of <a href="/prowlarr/appdata-directory" class="is-internal-link is-valid-page">Prowlarr's App Data folder</a>
    - Example paths:
      - Windows: `C:\ProgramData\Prowlarr\Definitions\Custom`
      - Linux: `/home/$USER/.config/Prowlarr/Definitions/Custom`
      - OSX: `/Users/$USER/.config/Prowlarr/Definitions/Custom`
      - Docker: `/config/Definitions/Custom`
  - Create your custom definition '.yml'
  - Save your <a href="/prowlarr/cardigann-yml-definition" class="is-internal-link is-valid-page">Cardigann compatible YML file</a> within the custom definition folder and ensure Prowlarr has permissions to access it.

> The file name and id in the definition must be unique and cannot conflict with any other existing definitions. It's strongly advised to have the name in the definition to be unique as well.

# <a href="#supported-indexers" class="toc-anchor">¶</a> Supported Indexers

- <a href="/prowlarr/supported-indexers/" class="is-internal-link is-valid-page">See this wiki page for a list of supported indexers as of the latest nightly.</a>


