#!/bin/bash -e

# Rename database
# $ /tools/db-rename.sh [OLD_DB_NAME] [NEW_DB_NAME]

cdir="${0%/*}"
DATE_STAMP=$(date "+%Y%m%d_%H%M%S")
OLD_DB_NAME=$1
NEW_DB_NAME=$2

if [[ -z "$OLD_DB_NAME" ]]; then
    OLD_DB_NAME="${POSTGRES_NAME}"
fi

if [[ -z "$NEW_DB_NAME" ]]; then
    NEW_DB_NAME="${OLD_DB_NAME}_${DATE_STAMP}"
fi


echo "Renaming ${OLD_DB_NAME} database to ${NEW_DB_NAME}"

$cdir/db-kill-connections.sh ${OLD_DB_NAME}

cat << EOF | sudo -u postgres psql
-- Rename
alter database "${OLD_DB_NAME}" rename to "${NEW_DB_NAME}";
EOF

