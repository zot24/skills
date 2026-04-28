> Source: https://docs.immich.app/overview/quick-start



<a href="#__docusaurus_skipToContent_fallback" class="skipToContent_m5m7">Skip to main content</a>


On this page


# Quick start


Here is a quick, no-choices path to install Immich and take it for a test drive. Once you've tried it, you might use one of the many other ways to install and use it.

## Requirements<a href="#requirements" class="hash-link" aria-label="Direct link to Requirements" translate="no" title="Direct link to Requirements">​</a>

- A system with at least 6GB of RAM and 2 CPU cores.
- <a href="https://docs.docker.com/engine/install/" target="_blank" rel="noopener noreferrer">Docker</a>

> For a more detailed list of requirements, see the [requirements page](/install/requirements).

------------------------------------------------------------------------

## Set up the server<a href="#set-up-the-server" class="hash-link" aria-label="Direct link to Set up the server" translate="no" title="Direct link to Set up the server">​</a>

### Step 1 - Download the required files<a href="#step-1---download-the-required-files" class="hash-link" aria-label="Direct link to Step 1 - Download the required files" translate="no" title="Direct link to Step 1 - Download the required files">​</a>

Create a directory of your choice (e.g. `./immich-app`) to hold the `docker-compose.yml` and `.env` files.


Move to the directory you created


``` prism-code
mkdir ./immich-app
cd ./immich-app
```


Download <a href="https://github.com/immich-app/immich/releases/latest/download/docker-compose.yml" target="_blank" rel="noopener noreferrer"><code>docker-compose.yml</code></a> and <a href="https://github.com/immich-app/immich/releases/latest/download/example.env" target="_blank" rel="noopener noreferrer"><code>example.env</code></a> by running the following commands:


Get docker-compose.yml file


``` prism-code
wget -O docker-compose.yml https://github.com/immich-app/immich/releases/latest/download/docker-compose.yml
```


Get .env file


``` prism-code
wget -O .env https://github.com/immich-app/immich/releases/latest/download/example.env
```


You can alternatively download these two files from your browser and move them to the directory that you created, in which case ensure that you rename `example.env` to `.env`.

### Step 2 - Populate the .env file with custom values<a href="#step-2---populate-the-env-file-with-custom-values" class="hash-link" aria-label="Direct link to Step 2 - Populate the .env file with custom values" translate="no" title="Direct link to Step 2 - Populate the .env file with custom values">​</a>


Default environmental variable content


``` prism-code
# You can find documentation for all the supported env variables at https://docs.immich.app/install/environment-variables

# The location where your uploaded files are stored
UPLOAD_LOCATION=./library

# The location where your database files are stored. Network shares are not supported for the database
DB_DATA_LOCATION=./postgres

# To set a timezone, uncomment the next line and change Etc/UTC to a TZ identifier from this list: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones#List
# TZ=Etc/UTC

# The Immich version to use. You can pin this to a specific version like "v2.1.0"
IMMICH_VERSION=v2

# Connection secret for postgres. You should change it to a random password
# Please use only the characters `A-Za-z0-9`, without special characters or spaces
DB_PASSWORD=postgres

# The values below this line do not need to be changed
###################################################################################
DB_USERNAME=postgres
DB_DATABASE_NAME=immich
```


- Populate `UPLOAD_LOCATION` with your preferred location for storing backup assets. It should be a new directory on the server with enough free space.
- Consider changing `DB_PASSWORD` to a custom value. Postgres is not publicly exposed, so this password is only used for local authentication. To avoid issues with Docker parsing this value, it is best to use only the characters `A-Za-z0-9`. `pwgen` is a handy utility for this.
- Set your timezone by uncommenting the `TZ=` line.
- Populate custom database information if necessary.

### Step 3 - Start the containers<a href="#step-3---start-the-containers" class="hash-link" aria-label="Direct link to Step 3 - Start the containers" translate="no" title="Direct link to Step 3 - Start the containers">​</a>

From the directory you created in Step 1 (which should now contain your customized `docker-compose.yml` and `.env` files), run the following command to start Immich as a background service:


Start the containers


``` prism-code
docker compose up -d
```


------------------------------------------------------------------------

## Try the web app<a href="#try-the-web-app" class="hash-link" aria-label="Direct link to Try the web app" translate="no" title="Direct link to Try the web app">​</a>

The first user to register will be the admin user. The admin user will be able to add other users to the application.

To register for the admin user, access the web application at `http://<machine-ip-address>:2283` and click on the **Getting Started** button.

<img src="/assets/images/admin-registration-form-eab59e0cd8bd666bc7b1ed017b0e3efc.webp" title="Admin Registration" width="500" />

Follow the prompts to register as the admin user and log in to the application.

Try uploading a picture from your browser.

![](data:image/webp;base64,UklGRqgCAABXRUJQVlA4IJwCAABwEQCdASqBAEUAPtFeqE6oJSOiJ9XbwQAaCWcA1mHzi/9tY7pyyzXb+KsdMabdSBVtMy8k+oT0hzWrmSJR5Hc5dQlIpg+ZrtP4pyRQYIK13Tc9sNvSEzBhqJXnfdZbcu2+rIv1fsNPyJVw0BE1pZhuae+Njpc+7BODiCyONZTUELPMIltsctrzMjg2ilec+/N1so8AAP73ed0dmcorbhTt+gIilp5ntSDHDGp7QuihWZx0vCQy05MsPKEJeQIv3kTzfZSgQLcMudd2lWjMf5VsuYMNLMXoQ+PREnnL/LW5uDPsMSA+TE13kO/IQ7PuFI7iTQ1wVVCfCMTsOsfj2JHKkuXFLAV+pJSewnT8f+j17aXRYD6lTOjwFFrz9GCZtAAqjdALTisQKbeD6k/ib7BBzCIIhi1ERgqi2q7zk0zOIm579m/T7WXFcodysWc5JwsjH2zRpjd7UHYbpaahaPstw3P8dd7e2WsYKDuy08+kd5+JA6J5EnTZxztlHP5a9pU6ZZXqXwOCbkpKyar4zA/qZm5o9/JoKnP8sUYxzMGg+lpYBt3/NGXUJor8STOol9urDjXyqGHvTteP92YHRC7dH34g6W4ZkiDUsYQ719kM1p6gRWsTcbi/FZ9Hz7mvy8DgBl7OtvlJF1SsWb8VOzYbqjcTsXs+IJtUKXCvI0xtoXJmRapPvUOsydGJKzN7qRt1qc1YR0VAkAzjfz+IU9YpmYJfHlqN/p+ZbAuEbsFg0Ji9Q6KgAzMVEL2ofSxpkll77ZpIBnZEC69/ygFB1EGehL5amuzEy1ofWD6UYEQEZMVQzH/oBF/Oq2x1cbIJHLfd5eDRd7+d5f02huX3oaxQp2kCucx7YCkWMcST8zXRC17uVJDlFwAAAAAAAA== "Upload button")

------------------------------------------------------------------------

## Try the mobile app<a href="#try-the-mobile-app" class="hash-link" aria-label="Direct link to Try the mobile app" translate="no" title="Direct link to Try the mobile app">​</a>

### Download the Mobile App<a href="#download-the-mobile-app" class="hash-link" aria-label="Direct link to Download the Mobile App" translate="no" title="Direct link to Download the Mobile App">​</a>

The mobile app can be downloaded from the following places:

- Obtainium: You can get your Obtainium config link from the <a href="https://my.immich.app/utilities" target="_blank" rel="noopener noreferrer">Utilities page of your Immich server</a>.
- <a href="https://play.google.com/store/apps/details?id=app.alextran.immich" target="_blank" rel="noopener noreferrer">Google Play Store</a>
- <a href="https://apps.apple.com/us/app/immich/id1613945652" target="_blank" rel="noopener noreferrer">Apple App Store</a>
- <a href="https://f-droid.org/packages/app.alextran.immich" target="_blank" rel="noopener noreferrer">F-Droid</a>
- <a href="https://github.com/immich-app/immich/releases" target="_blank" rel="noopener noreferrer">GitHub Releases (apk)</a>

### Login to the Mobile App<a href="#login-to-the-mobile-app" class="hash-link" aria-label="Direct link to Login to the Mobile App" translate="no" title="Direct link to Login to the Mobile App">​</a>

Login to the mobile app with the server endpoint URL at `http://<machine-ip-address>:2283`

<img src="/assets/images/sign-in-phone-92be8a8eab0f72d121e8b62e6f69df17.webp" title="Mobile App Sign In" style="width:50.0%" />

In the mobile app, you should see the photo you uploaded from the web UI.

### Transfer Photos from Your Mobile Device<a href="#transfer-photos-from-your-mobile-device" class="hash-link" aria-label="Direct link to Transfer Photos from Your Mobile Device" translate="no" title="Direct link to Transfer Photos from Your Mobile Device">​</a>

1.  Navigate to the backup screen by clicking on the cloud icon in the top right corner of the screen.

<img src="data:image/webp;base64,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" title="Backup button" style="width:50.0%" />

2.  You can select which album(s) you want to back up to the Immich server from the backup screen.

<img src="/assets/images/album-selection-6073c429378c94a70f6929262d09f807.webp" title="Backup button" style="width:50.0%" />

3.  Scroll down to the bottom and press "**Enable Backup**" to start the backup process. This will upload all the assets in the selected albums.


You can read more about backup options [here](/features/mobile-backup).


The backup time differs depending on how many photos are on your mobile device. Large uploads may take quite a while. To quickly get going, you can selectively upload few photos first, by following this [guide](/features/mobile-app#sync-only-selected-photos).

You can select the **Job Queues** tab to see Immich processing your photos.

<img src="/assets/images/jobs-tab-48d8b88c61b7677de8e8c3f8ca1b7b98.webp" title="Job Queues tab" width="300" />

------------------------------------------------------------------------

## Review the database backup and restore process<a href="#review-the-database-backup-and-restore-process" class="hash-link" aria-label="Direct link to Review the database backup and restore process" translate="no" title="Direct link to Review the database backup and restore process">​</a>

Immich has built-in database backups. You can refer to the [database backup](/administration/backup-and-restore) for more information.


The database only contains metadata and user information. You must setup manual backups of the images and videos stored in `UPLOAD_LOCATION`.


------------------------------------------------------------------------

## Where to go from here?<a href="#where-to-go-from-here" class="hash-link" aria-label="Direct link to Where to go from here?" translate="no" title="Direct link to Where to go from here?">​</a>

You may decide you'd like to install the server a different way; the Install category on the left menu provides many options.

You may decide you'd like to add the *rest* of your photos from Google Photos, even those not on your mobile device, via Google Takeout. You can use <a href="https://github.com/simulot/immich-go" target="_blank" rel="noopener noreferrer">immich-go</a> for this.

You may want to [upload photos from your own archive](/features/command-line-interface).

You may want to incorporate a pre-existing archive of photos from an [External Library](/features/libraries); there's a [guide](/guides/external-library) for that.

You may want your mobile device to [back photos up to your server automatically](/features/mobile-backup).


- <a href="#requirements" class="table-of-contents__link toc-highlight">Requirements</a>
- <a href="#set-up-the-server" class="table-of-contents__link toc-highlight">Set up the server</a>
  - <a href="#step-1---download-the-required-files" class="table-of-contents__link toc-highlight">Step 1 - Download the required files</a>
  - <a href="#step-2---populate-the-env-file-with-custom-values" class="table-of-contents__link toc-highlight">Step 2 - Populate the .env file with custom values</a>
  - <a href="#step-3---start-the-containers" class="table-of-contents__link toc-highlight">Step 3 - Start the containers</a>
- <a href="#try-the-web-app" class="table-of-contents__link toc-highlight">Try the web app</a>
- <a href="#try-the-mobile-app" class="table-of-contents__link toc-highlight">Try the mobile app</a>
  - <a href="#download-the-mobile-app" class="table-of-contents__link toc-highlight">Download the Mobile App</a>
  - <a href="#login-to-the-mobile-app" class="table-of-contents__link toc-highlight">Login to the Mobile App</a>
  - <a href="#transfer-photos-from-your-mobile-device" class="table-of-contents__link toc-highlight">Transfer Photos from Your Mobile Device</a>
- <a href="#review-the-database-backup-and-restore-process" class="table-of-contents__link toc-highlight">Review the database backup and restore process</a>
- <a href="#where-to-go-from-here" class="table-of-contents__link toc-highlight">Where to go from here?</a>


