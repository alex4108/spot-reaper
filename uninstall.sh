#!/usr/bin/env bash

pidof systemd && systemd="true" || systemd="false"

rm -rf /usr/bin/spot-reaper.sh
rm -rf /tmp/spot-reaper/pid
if [[ "${systemd}" == "true" ]]; 
    rm -rf /etc/systemd/system/multi-user.target.wants/spot-reaper.service
else
    rm -rf /etc/init.d/spot-reaper
fi