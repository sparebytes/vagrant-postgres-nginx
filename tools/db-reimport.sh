#!/bin/bash -e

# Rename existing database and import /dbdump/latest.sql
# $ /tools/db-reimport.sh [DB_NAME] [DB_IMPORT_FILE]

DB_NAME=$1
DB_IMPORT_FILE=$2

if [[ -z "$DB_NAME" ]]; then
    DB_NAME="${POSTGRES_NAME}"
fi

if [[ -z "$DB_IMPORT_FILE" ]]; then
    DB_IMPORT_FILE="/dbdump/latest.sql"
fi


cdir="${0%/*}"
$cdir/db-kill-connections.sh "${DB_NAME}"
$cdir/db-rename.sh "${DB_NAME}"
$cdir/db-create-blank.sh "${DB_NAME}"
$cdir/db-import-latest.sh "${DB_NAME}" "${DB_IMPORT_FILE}"