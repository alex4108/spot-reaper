#!/usr/bin/env bash

echo $$ > /tmp/spot-reaper.pid

# Monitors for spot instance termination notifications
while true; do

    TERM_STATUS=$(curl -LI http://169.254.169.254/latest/meta-data/spot/instance-action -o /dev/null -w '%{http_code}\n' -s)
    if [[ "${TERM_STATUS}" -eq "200" ]]; then
        echo "Term signal received, launching handler."
        /etc/spot-reaper/handler
        break
    fi

    sleep 5 # AWS Says to poll the endpoint every 5 seconds

done