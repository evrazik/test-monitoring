#!/bin/bash

# Variables
PID_FILE="/var/run/test.pid"
LOG_FILE="/var/log/monitoring.log"
API="https://test.com/monitoring/test/api"
LAST_RESTART_CHECK="/tmp/last_restart_check"

# Check if last restart check file exists
if [ ! -f "$LAST_RESTART_CHECK" ]; then
echo "0" > "$LAST_RESTART_CHECK"
fi

# Check test process
if [ -f $PID_FILE ]; then
PID=$(cat $PID_FILE)
if kill -0 $PID > /dev/null 2>&1; then
# Process works. Sending API request
if curl --output /dev/null --silent --head --fail --max-time 5 "$API"; then
echo "[$(date)] Request was successfully sent to $API" >> $LOG_FILE
else
echo "[$(date)] Error. Can't reach $API" >> $LOG_FILE
fi
else
echo "[$(date)] Error: Process with PID $(cat $PID_FILE) does not exist." >> $LOG_FILE
fi
fi

# Check restart process
if [ "$LAST_RESTART_CHECK" -gt "$(stat --format=%Y /proc/$(cat $PID_FILE)/cmdline)" ]; then
echo "[$(date)] Test process was restarted" >> $LOG_FILE
fi

# Update last restart check time
echo $(date +%s) > "$LAST_RESTART_CHECK"
