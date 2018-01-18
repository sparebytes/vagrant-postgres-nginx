#!/bin/bash -e

DB_NAME=$1

if [[ -z "$DB_NAME" ]]; then
    DB_NAME="$POSTGRES_NAME"
fi

DATE_STAMP=$(date "+%Y%m%d_%H%M%S")
DUMP_FILE="/dbdump/${DB_NAME}_$DATE_STAMP.sql"

sudo -u postgres pg_dump $DB_NAME > $DUMP_FILE;
