#!/bin/bash -e
cdir="${0%/*}"
$cdir/db-kill-connections.sh

OLD_DB_NAME=$1
NEW_DB_NAME=$2

if [[ -z "$OLD_DB_NAME" ]]; then
    OLD_DB_NAME="$POSTGRES_NAME"
fi

if [[ -z "$NEW_DB_NAME" ]]; then
    DATE_STAMP=$(date "+%Y%m%d_%H%M%S")
    NEW_DB_NAME="${OLD_DB_NAME}_${DATE_STAMP}"
fi

echo "Backing-Up ${OLD_DB_NAME} database to ${NEW_DB_NAME}"

cat << EOF | sudo -u postgres psql
-- Copy Database
create database "${NEW_DB_NAME}" with template "${OLD_DB_NAME}"
EOF

