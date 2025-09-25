#!/bin/bash

# Path and cron variables
SCRIPT_FILE="/home/projects/test-monitoring/release/test-monitoring.sh"
SERVICE_FILE="/etc/systemd/system/test-monitoring.service"
CRON_JOB="* * * * * $SCRIPT_FILE"
LOG_FILE="/var/log/monitoring.log"

# Check systemd unit
if [ -f $SERVICE_FILE ]; then
echo "Service file already exists."
else

# Create systemd unit
echo "Creating service file....."
cat << EOF > $SERVICE_FILE
[Unit]
Description=Test Monitoring Service
After=network.target

[Service]
ExecStart=$SCRIPT_FILE
Restart=always

[Install]
WantedBy=multi-user.target
EOF
echo "Systemd unit created."

# Exec and enable service
systemctl daemon-reload
systemctl enable test-monitoring.service
systemctl start test-monitoring.service
echo "Service created, added to startup and started."
fi

# Check crontab
if (crontab -l | grep "$CRON_JOB") > /dev/null; then
echo "Cron job already exists."
else
# Create cron job
(crontab -l ; echo "$CRON_JOB") | crontab -
echo "Cron job added."
fi

# Check log file 
if [ -f $LOG_FILE ]; then
echo "Log file already exists."
else

#Create log file
touch $LOG_FILE
echo "Log file created."
fi
