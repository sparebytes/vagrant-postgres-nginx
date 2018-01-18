#!/bin/bash -e
LOG_DIR=$PG_LOG_DIR
LAST_LOG_FILE=$(./db-log-last-file.sh)

DATE_STAMP=$(date "+%Y%m%d_%H%M%S")
for FILE in $(sudo ls -t1 $LOG_DIR)
do
    echo ${NEW_LOG_FILE_NAME}
    NEW_LOG_FILE_NAME="${FILE}_${DATE_STAMP}.log"
    if [ $LAST_LOG_FILE = $FILE ]; then
        sudo cp "$LOG_DIR/$FILE" "/mylogs/psql/${NEW_LOG_FILE_NAME}"
        sudo truncate -s0 "$LOG_DIR/$FILE"
    else
        sudo mv "$LOG_DIR/$FILE" "/mylogs/psql/${NEW_LOG_FILE_NAME}"
    fi
done

# sudo mv "$LOG_DIR/*" "/mylogs/psql"