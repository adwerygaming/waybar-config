#!/bin/sh

# Use a PID file to track the inhibitor process
PID_FILE="/tmp/swayidle_inhibitor.pid"

if [ -f "$PID_FILE" ]; then
    # If PID file exists, kill the process and remove the file
    kill "$(cat $PID_FILE)"
    rm "$PID_FILE"
    echo '{"text":"","tooltip":"Normal Idle Enabled","class":"inactive"}'
else
    # If PID file doesn't exist, start swayidle to inhibit idle
    # The -w flag waits for a signal, effectively inhibiting idle forever
    swayidle -w &
    # Store the PID of the new swayidle process in the file
    echo $! > "$PID_FILE"
    echo '{"text":"","tooltip":"Screen Stays On","class":"active"}'
fi