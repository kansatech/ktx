#!/usr/bin/env bash
set -euo pipefail

DATADIR=/var/lib/mysql
SOCKET=/run/mysqld/mysqld.sock
ROOT_FILE=/run/secrets/mysql_root_password

mkdir -p /run/mysqld "$DATADIR"
chown -R mysql:mysql /run/mysqld "$DATADIR"

if [[ ! -d "$DATADIR/mysql" ]]; then
  [[ -r "$ROOT_FILE" ]] || { echo "Missing $ROOT_FILE" >&2; exit 1; }
  echo "Initializing Percona data directory"
  mysqld --initialize-insecure --user=mysql --datadir="$DATADIR"

  mysqld --user=mysql --datadir="$DATADIR" --socket="$SOCKET" --skip-networking &
  pid=$!
  for i in $(seq 1 60); do
    mysqladmin --protocol=socket --socket="$SOCKET" -uroot ping >/dev/null 2>&1 && break
    sleep 1
  done

  password="$(cat "$ROOT_FILE")"
  mysqladmin --protocol=socket --socket="$SOCKET" -uroot password "$password"
  mysqladmin --protocol=socket --socket="$SOCKET" -uroot -p"$password" shutdown
  wait "$pid" || true
fi

exec mysqld --user=mysql --datadir="$DATADIR"
