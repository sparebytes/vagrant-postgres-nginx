#!/bin/bash -e

# Import database from /dbdump/latest.sql
# $ /tools/db-import-latest.sh [DB_NAME] [DB_IMPORT_FILE]

DB_NAME=$1
DB_IMPORT_FILE=$2

if [[ -z "$DB_NAME" ]]; then
    DB_NAME="${POSTGRES_NAME}"
fi

if [[ -z "$DB_IMPORT_FILE" ]]; then
    DB_IMPORT_FILE="/dbdump/latest.sql"
fi

echo "Importing $DB_IMPORT_FILE into $DB_NAME"
sudo -u postgres psql -d $DB_NAME -f $DB_IMPORT_FILE
