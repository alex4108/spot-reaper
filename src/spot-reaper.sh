#!/usr/bin/env bash

echo $$ > /tmp/spot-reaper.pid

echo "$(date) Spot Reaper starting up"
# Monitors for spot instance termination notifications
while true; do

    TERM_STATUS=$(curl -LI http://169.254.169.254/latest/meta-data/spot/instance-action -o /dev/null -w '%{http_code}\n' -s)
    if [[ "${TERM_STATUS}" == "200" ]]; then
        echo "$(date) Term signal received, launching handler."
        /etc/spot-reaper/handler
        sleep 300 # Stay asleep for a bit until we get terminated
    fi

    sleep 5 # AWS Says to poll the endpoint every 5 seconds

done
echo "$(date) Spot Reaper exiting on it's own"
