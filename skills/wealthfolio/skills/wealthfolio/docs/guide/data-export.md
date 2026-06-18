> Source: https://wealthfolio.app/docs/guide/data-export

Your Wealthfolio data is yours. You can export it in three formats depending on what you
need to do.

---

## 1 · Run an export

1. **Settings → Exports**.
2. Pick your **format** (CSV, JSON, or Full database).
3. Pick **what** to export (Accounts, Activities, Goals, Assets, Quotes, etc.).
4. Pick the destination folder.
5. **Export.**

<MdxImage
  src="https://assets.wealthfolio.app/images/docs/export.webp"
  width="718"
  height="404"
  alt="Wealthfolio Exports"
/>

---

## 2 · Pick the right format

| Format            | When to use                                                                                                            |
| ----------------- | ---------------------------------------------------------------------------------------------------------------------- |
| **CSV**           | Loading into a spreadsheet, sharing one table with someone, importing into another tool.                               |
| **JSON**          | Programmatic processing, scripts, custom dashboards. Preserves nested structures CSV flattens out.                     |
| **Full database** | Complete backup or migration to a new machine. One SQLite file (or `.sql` dump) containing every table and every row.  |

For a **backup before a big change** (a major version upgrade, a bulk delete, a tax-time
checkpoint) → use **Full database**. It's the only format that round-trips losslessly.

---

## 3 · Round-trip restore

To restore from a full-database export:

1. Close Wealthfolio.
2. Locate your data directory:
   - **macOS:** `~/Library/Application Support/com.teymz.wealthfolio/`
   - **Windows:** `%APPDATA%\Wealthfolio\`
   - **Linux:** `~/.local/share/com.teymz.wealthfolio/`
3. Move the existing `wealthfolio.db` aside (rename it; don't delete it until you've
   verified the restore).
4. Copy your exported database into the same location, renaming it to `wealthfolio.db`.
5. Reopen Wealthfolio.

Self-hosted: stop the container, replace the file at the path in `WF_DB_PATH`
(default `/data/wealthfolio.db`), start the container.

CSV / JSON exports don't round-trip to a full database. They're for partial reuse, not
full restoration.

---

## 4 · Where the database file lives if you'd rather copy it

You don't have to use the export feature to back up. You can copy the SQLite file
directly. Same paths as above. Stop the app first (or use SQLite's online backup
mechanism via the CLI if you need a hot copy).

---

## 5 · Scheduled exports?

There's no built-in scheduler today; exports are manual. If you need automated
backups:

- **Self-hosted:** snapshot the data volume with your container/host's backup tool (e.g.
  `restic`, `borg`, Proxmox snapshots, Unraid backup plugins).
- **Desktop:** include the Wealthfolio data directory in your normal backup tool (Time
  Machine, Windows File History, Restic).

Both approaches give you point-in-time recovery without trusting any cloud, and they
keep working even if Wealthfolio's export UI changes.

---
