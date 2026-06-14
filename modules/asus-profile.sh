#!/bin/bash

if [[ "$1" == "cycle" ]]; then
    asusctl profile -n > /dev/null
    
    CURRENT_PROFILE=$(asusctl profile -p | grep "Active profile" | awk '{print $4}')
    
    notify-send -h string:x-canonical-private-synchronous:asus-profile \
                "ASUS Control" "Mode changed to <b>$CURRENT_PROFILE</b>"
                
    pkill -RTMIN+8 waybar
else
    CURRENT_PROFILE=$(asusctl profile -p | grep "Active profile" | awk '{print $4}')
fi

if [[ "$CURRENT_PROFILE" == "Quiet" ]]; then
    echo '{"text": "   Low", "tooltip": "Quiet Mode: Fans silenced", "class": "quiet"}'
elif [[ "$CURRENT_PROFILE" == "Balanced" ]]; then
    echo '{"text": "   Bal", "tooltip": "Balanced Mode: Standard cooling", "class": "balanced"}'
elif [[ "$CURRENT_PROFILE" == "Performance" ]]; then
    echo '{"text": "   Perf", "tooltip": "Performance Mode: Max cooling & power", "class": "performance"}'
else
    echo '{"text": "   IDK", "tooltip": "Cannot determine profile"}'
fi