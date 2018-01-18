LOG_DIR=$PG_LOG_DIR
LAST_LOG_FILE=$(./db-log-last-file.sh)

if [[ -z "$LAST_LOG_FILE" ]]; then
    echo "Log file does not exist yet."
    echo -ne "Waiting..."

    while [[ -z "$LAST_LOG_FILE" ]]; do
        echo -ne "."
        sleep 1
        LAST_LOG_FILE=$(./db-log-last-file.sh)
    done

    echo "...Found"

    exit 0
fi


echo ""
echo ""
echo "Watching File: ${LOG_DIR}/${LAST_LOG_FILE}"
echo ""
echo ""
sudo tail -f "${LOG_DIR}/${LAST_LOG_FILE}"