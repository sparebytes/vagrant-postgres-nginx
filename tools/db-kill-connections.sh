#!/bin/bash -e

# Kill all database connections to [DB_NAME]
# $ /tools/db-kill-connections.sh [DB_NAME]

DB_NAME=$1

if [[ -z "$DB_NAME" ]]; then
    DB_NAME="${POSTGRES_NAME}"
fi

echo "Killing all database connections"

cat << EOF | sudo -u postgres psql
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE 1=1 -- pg_stat_activity.datname = '${DB_NAME}'
  AND pid <> pg_backend_pid();
EOF
