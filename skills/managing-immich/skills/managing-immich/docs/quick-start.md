<!-- Source: https://docs.immich.app/overview/quick-start -->

# Immich Quick Start Guide

## System Requirements

Immich requires a minimum configuration of **6GB RAM** and **2 CPU cores**, along with Docker installed on your system.

## Server Setup Process

### Step 1: Prepare Your Directory

Create a dedicated folder for Immich configuration files:

```bash
mkdir ./immich-app
cd ./immich-app
```

Download the required files using wget:

```bash
wget -O docker-compose.yml https://github.com/immich-app/immich/releases/latest/download/docker-compose.yml
wget -O .env https://github.com/immich-app/immich/releases/latest/download/example.env
```

Alternatively, download these files through your browser and rename `example.env` to `.env`.

### Step 2: Configure Environment Variables

Edit your `.env` file with these key settings:

```env
UPLOAD_LOCATION=./library
DB_DATA_LOCATION=./postgres
DB_PASSWORD=postgres
IMMICH_VERSION=v2
```

**Important customizations:**
- Set `UPLOAD_LOCATION` to your preferred storage directory with adequate free space
- Change `DB_PASSWORD` to a secure value (alphanumeric characters only, no special characters)
- Uncomment and set `TZ=` for your timezone using IANA timezone identifiers

### Step 3: Launch Containers

From your configuration directory, start the service:

```bash
docker compose up -d
```

## Web Application Access

Access the web interface at `http://<machine-ip-address>:2283`

The first registered user automatically becomes the admin account. Click "Getting Started" to create this account and begin uploading photos from your browser.

## Mobile Application Setup

### Installation Options

Download the Immich mobile app from:
- **Google Play Store**
- **Apple App Store**
- **F-Droid**
- **GitHub Releases** (APK)

### Login Configuration

Connect your mobile device using the server endpoint: `http://<machine-ip-address>:2283`

### Photo Backup Process

1. Navigate to the backup screen by tapping the cloud icon
2. Select desired albums for backup
3. Scroll down and tap "Enable Backup" to begin syncing photos
4. Monitor progress via the **Job Queues** tab in the web interface

**Note:** Initial uploads vary in duration based on photo library size. Consider uploading a small batch first for quicker verification.

## Database Backup Considerations

Immich includes automated database backups. However, you must **manually backup images and videos** stored in your configured `UPLOAD_LOCATION` directory, as the database contains only metadata and user information.

## Next Steps

- Explore alternative installation methods via the Install documentation
- Import photos from Google Takeout using immich-go
- Configure external libraries for existing photo archives
- Enable automatic mobile device backup functionality
- Upload photos via command-line interface
