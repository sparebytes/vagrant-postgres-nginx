#!/bin/bash -e

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
