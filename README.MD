# Test Process Monitoring Solution

This repository contains scripts to install test monitoring program on a Unix-based system. This is test task for Effective Mobile company.

## Installation

1. Clone this repository to your local machine.
2. Make the installation script executable by running "chmod +x install.sh".
3. Configure variables in 'install.sh' and "test-monitoring.sh".
4. Run the installation script with "sudo ./install.sh" to create, enable systemd unit, cron schedule and empty log. The script contains all neccessary checks.

## Usage

### Test Process

The "test" is a simple program that writes its PID to a file "/var/run/test.pid". It can be started manually.

### Monitoring Script

The "test-monitoring.sh" script monitors the "test" process and sends API requests at regular 1s intervals if the process is running. If the process has been restarted, it logs an event to "/var/log/monitoring.log". The script should be run as a cron job or systemd timer on a schedule that suits your needs.

## Configuration

The following variables can be modified in the scripts to customize their behavior:

- "PID_FILE": Path to the file containing the PID of the "test" process (default: "/var/run/test.pid").
- "LOG_FILE": Path to the monitoring log file (default: "/var/log/monitoring.log").
- "SCRIPT_FILE": Path to the monitoring script (default: "/home/projects/test-monitoring/release/test-monitoring.sh").
- "SERVICE_FILE": Path to the systemd unit file (default: "/etc/systemd/system/test-monitoring.service").
- "CRON_JOB": the crontab schedule entry for monitoring script (default: "* * * * * $SCRIPT_FILE").
- "LAST_RESTART_CHECK": path to the temporary check file (default: "/tmp/last_restart_check").
- "API": URL for sending API requests when the "test" process is running (default: "https://test.com/monitoring/test/api").

## Troubleshooting

If you encounter any issues while using these scripts, please check the following:

- Verify that the monitoring script has the necessary permissions to access files and directories it requires.
- Make sure that API requests are being sent to the correct URL and that the server is reachable. 

## License

This project is licensed under the MIT License - see the LICENSE.MD file for details.
