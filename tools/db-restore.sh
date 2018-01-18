#!/bin/bash -e

# Renames [CUR_DB_NAME] to something else and then copies [BACKUP_DB_NAME] as [CUR_DB_NAME]
# $ /tools/db-restore.sh [BACKUP_DB_NAME] [CUR_DB_NAME]

cdir="${0%/*}"
BACKUP_DB_NAME=$1
CUR_DB_NAME=$2

if [[ -z "$BACKUP_DB_NAME" ]]; then
    echo "Error! A parameter must be given of the database name to restore from."
    exit 1
fi

if [[ -z "$CUR_DB_NAME" ]]; then
    CUR_DB_NAME="$POSTGRES_NAME"
fi

DATE_STAMP=$(date "+%Y%m%d_%H%M%S")
CUR_BACKUP_NAME="${CUR_DB_NAME}_${DATE_STAMP}"

echo "Renaming up ${CUR_DB_NAME} database to ${CUR_BACKUP_NAME} and copying ${BACKUP_DB_NAME} to ${CUR_DB_NAME}"

$cdir/db-kill-connections.sh
$cdir/db-rename.sh $CUR_DB_NAME $CUR_BACKUP_NAME
$cdir/db-backup.sh $BACKUP_DB_NAME $CUR_DB_NAME
