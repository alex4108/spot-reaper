#!/bin/bash
# chkconfig: 2345 20 80
# description: Spot Reaper handles spot instance termination.
### BEGIN INIT INFO
# Provides: spot-reaper
# Required-Start: $local_fs $network
# Required-Stop: $local_fs $network
# Default-Start: 2 3 4 5
# Default-Stop: 0 1 6
# Short-Description: start and stop spot-reaper
# Description: Spot Reaper handles spot instance termination.
### END INIT INFO

logfile="/var/log/spot-reaper"
redir=">$logfile 2>&1 &"

# Source function library.
. /etc/init.d/functions

start() {
    /usr/bin/spot-reaper.sh &
    daemon "/usr/bin/spot-reaper.sh" "$redir"
    # example: daemon program_name &
}

stop() {
    kill -9 $(cat /tmp/spot-reaper.pid) && rm -rf /tmp/spot-reaper.pid
    echo "$(date) Spot Reaper exited on request" >> /var/log/spot-reaper.log
}

status() { 
    if [ -f /tmp/spot-reaper.pid ]; then 
        # PID Exists, check if it's running
        pid=$(cat /tmp/spot-reaper.pid)
        running=$(kill -0 ${pid})
        if [[ $? == "0" ]]; then
            echo "Running"
        else 
            echo "PID Exists but not running.  Process died?"
        fi
    else 
        echo "Not running"
    fi
}

case "$1" in 
    start)
       start
       ;;
    stop)
       stop
       ;;
    restart)
       stop
       start
       ;;
    status)
        status
       ;;
    *)
       echo "Usage: $0 {start|stop|status|restart}"
esac

exit 0 