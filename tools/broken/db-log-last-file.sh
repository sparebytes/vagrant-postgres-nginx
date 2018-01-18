LOG_DIR=$PG_LOG_DIR
LAST_LOG_FILE=$(sudo ls -t1 $PG_LOG_DIR | grep '\.log$' |  head -n 1)
echo $LAST_LOG_FILE