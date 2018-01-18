#!/bin/bash -e

# latest.sql
DB_IMPORT_FILE=/dbdump/latest.sql
echo "Importing $DB_IMPORT_FILE into $POSTGRES_NAME"
sudo -u postgres psql -d $POSTGRES_NAME -f $DB_IMPORT_FILE
