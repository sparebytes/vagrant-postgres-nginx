#!/bin/bash

# Create blank database
# $ /tools/db-create-blank.sh [DB_NAME]

DB_NAME=$1

if [[ -z "$DB_NAME" ]]; then
    DB_NAME="${POSTGRES_NAME}"
fi

echo "Creating blank database: ${DB_NAME}"

cat << EOF | sudo -u postgres psql
-- Create empty database
create database "${DB_NAME}";

-- Assign ${POSTGRES_USER} user to ${DB_NAME} database
alter database "${DB_NAME}" owner to "${POSTGRES_USER}";
EOF

