#!/usr/bin/env bash
set -euo pipefail

STAMP="$(date -u +%Y%m%dT%H%M%SZ)"
DUMP_DIR=/backup-staging/databases
APP_DIR=/backup-staging/appliances
mkdir -p "$DUMP_DIR" "$APP_DIR"

# Logical Percona backups: one compressed file per application database.
mysql --defaults-extra-file=/run/ktx-secrets/mysql-backup.cnf -NBe "SHOW DATABASES" \
 | grep -Ev '^(information_schema|performance_schema|mysql|sys)$' \
 | while read -r db; do
     echo "Dumping ${db}"
     mysqldump --defaults-extra-file=/run/ktx-secrets/mysql-backup.cnf \
       --single-transaction --routines --triggers --events --hex-blob --no-tablespaces \
       "$db" | zstd -T0 -q -o "$DUMP_DIR/${db}-${STAMP}.sql.zst"
   done

# Create consistent SQLite copies for appliance state when present.
if [[ -r /source/uptime/kuma.db ]]; then
  sqlite3 /source/uptime/kuma.db ".backup '$APP_DIR/uptime-kuma-${STAMP}.db'"
fi
if [[ -r /source/vaultwarden/db.sqlite3 ]]; then
  sqlite3 /source/vaultwarden/db.sqlite3 ".backup '$APP_DIR/vaultwarden-${STAMP}.db'"
fi

# Back up sites/platform plus selected shared-service state.  Live SQLite DB/WAL
# files are excluded because consistent .backup copies were created above.
/usr/local/bin/ktx-restic backup --tag ktx-prod \
  --exclude '/source/uptime/kuma.db*' \
  --exclude '/source/vaultwarden/db.sqlite3*' \
  /source/sites \
  /source/platform \
  /source/uptime \
  /source/vaultwarden \
  /source/rustdesk \
  /source/sshpiper \
  /source/proxy-acme \
  /backup-staging/databases \
  /backup-staging/appliances

# Staging files are recoverable from restic after a successful snapshot.
find "$DUMP_DIR" "$APP_DIR" -type f -mtime +2 -delete

# Retain a simple initial policy.  Change this deliberately to match business needs.
/usr/local/bin/ktx-restic forget --keep-daily 7 --keep-weekly 5 --keep-monthly 12 --prune
