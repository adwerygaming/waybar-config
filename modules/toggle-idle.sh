#!/bin/sh

PID_FILE="/tmp/swayidle_inhibitor.pid"

if [ -f "$PID_FILE" ]; then
    kill "$(cat $PID_FILE)"
    rm "$PID_FILE"
    echo '{"text":"","tooltip":"Normal Idle Enabled","class":"inactive"}'
else
    swayidle -w &
    echo $! > "$PID_FILE"
    echo '{"text":"","tooltip":"Screen Stays On","class":"active"}'
fi