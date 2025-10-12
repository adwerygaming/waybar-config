#!/bin/bash
state=$(loginctl show-session "$XDG_SESSION_ID" -p IdleHint | cut -d= -f2)

if [[ "$state" == "yes" ]]; then
    echo '{"text": "Idle", "class": "idle"}'
else
    echo '{"text": "Active", "class": "active"}'
fi
