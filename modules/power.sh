#!/bin/bash

BAT="/sys/class/power_supply/BAT1"

CURRENT="$BAT/current_now"
VOLTAGE="$BAT/voltage_now"
STATUS="$BAT/status"

if [[ -f "$CURRENT" && -f "$VOLTAGE" ]]; then
    I=$(cat "$CURRENT")
    V=$(cat "$VOLTAGE")

    if [[ "$I" -eq 0 ]]; then
        echo ""
        exit 0
    fi

    WATT=$(awk "BEGIN { printf \"%.1f\", ($I * $V) / 1000000000000 }")

    if [[ "$(cat "$STATUS")" == "Charging" ]]; then
        echo " +${WATT}W"
    else
        echo " ${WATT}W"
    fi
    else
    echo ""
fi
