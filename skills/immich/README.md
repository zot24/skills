# Immich Skill

Expert assistant for deploying and managing [Immich](https://immich.app), a self-hosted photo and video management solution.

## Service Overview

| Service | Purpose | Port |
|---------|---------|------|
| Immich Server | Web UI + REST API | 2283 |
| Machine Learning | CLIP search, facial recognition, OCR | 3003 |
| PostgreSQL | Metadata database (pgvecto.rs) | 5432 |
| Redis | Job queue and caching | 6379 |

## Usage

### Slash Commands

```
/immich setup                  # Docker Compose deployment
/immich configure              # Environment variables guide
/immich backup                 # Database + filesystem backup
/immich library /mnt/photos    # External library setup
/immich upload /path/to/photos # CLI bulk upload
/immich api assets             # API usage examples
/immich ml                     # Machine learning config
/immich mobile                 # Mobile app setup
/immich troubleshoot           # Diagnose issues
/immich sync                   # Update documentation
```

### Natural Language Triggers

The skill activates on mentions of: Immich, photo management, photo backup, Google Photos alternative, facial recognition, self-hosted photos, photo server, media library.

## Documentation Sources

- **Website**: https://immich.app
- **Documentation**: https://docs.immich.app
- **GitHub**: https://github.com/immich-app/immich
- **API Docs**: https://api.immich.app

## Skill Structure

```
skills/immich/
├── .claude-plugin/plugin.json           # Plugin metadata
├── commands/immich.md          # Slash command entry point
├── skills/immich/
│   ├── SKILL.md                         # Overview + references (~100 lines)
│   └── docs/                            # Cached documentation
│       ├── quick-start.md               # Installation guide
│       ├── requirements.md              # Hardware & software prerequisites
│       ├── environment-variables.md     # Full config reference
│       ├── backup-and-restore.md        # Backup procedures
│       ├── external-libraries.md        # External library setup
│       ├── cli.md                       # CLI reference
│       ├── api.md                       # API overview
│       └── readme-upstream.md           # Raw upstream README
├── sync.json                            # Sync configuration
└── README.md                            # This file
```
