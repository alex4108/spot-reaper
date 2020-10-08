#!/usr/bin/env bash

# Installs spot reaper as a systemd service

if [ "$EUID" -ne 0 ]; then
    echo "Spot Reaper installer must run with root permissions.  Try again"
    exit
fi

echo "Starting Spot Reaper installation."

## Always
mkdir -p /etc/spot-reaper
cp src/spot-reaper.sh /usr/bin/spot-reaper.sh
chmod +x /usr/bin/spot-reaper.sh
cp src/handler /etc/spot-reaper/
chmod +x /etc/spot-reaper/handler


echo "Spot reaper is now installed!"
echo "Ensure your handler script at /etc/spot-reaper/handler is set up appropriately."
echo "Run these commands to enable & start spot reaper"
pidof systemd && systemd="true" || systemd="false"

if [[ "${systemd}" -eq "true" ]]; then
    cp service/spot-reaper.service /etc/systemd/system/multi-user.target.wants/
    systemctl daemon-reload
    echo "systemctl enable spot-reaper && systemctl start spot-reaper"    
else
    mkdir -p /etc/init.d/spot-reaper/
    cp service/service.sh /etc/init.d/spot-reaper/service.sh
    echo "chkconfig spot-reaper on && service spot-reaper start"
fi