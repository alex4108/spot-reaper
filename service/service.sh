#!/bin/bash
# chkconfig: 2345 20 80
# description: Spot Reaper handles spot instance termination.

# Source function library.
. /etc/init.d/functions

start() {
    /usr/bin/spot-reaper.sh &
    # example: daemon program_name &
}

stop() {
    kill -9 $(cat /tmp/spot-reaper.pid) && rm -rf /tmp/spot-reaper.pid
}

status { 
    if [ -f /tmp/spot-reaper.pid ]; then 
        # PID Exists, check if it's running
        pid=$(cat /tmp/spot-reaper.pid)
        running=$(kill -0 ${pid})
        if [[ "${running}" -eq "0" ]]; then
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