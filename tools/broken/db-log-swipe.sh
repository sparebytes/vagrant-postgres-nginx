LOG_DIR=$PG_LOG_DIR
LAST_LOG_FILE=$(./db-log-last-file.sh)

if [[ -z "$LAST_LOG_FILE" ]]; then
    echo "Error! There is no log file to swipe."
    exit 0
fi


DATE_STAMP=$(date "+%Y%m%d_%H%M%S")
NEW_LOG_FILE_NAME="${LAST_LOG_FILE}_${DATE_STAMP}.log"

sudo cp "${LOG_DIR}/${LAST_LOG_FILE}" "/mylogs/psql/${NEW_LOG_FILE_NAME}"
echo "Swiped ${NEW_LOG_FILE_NAME}"
