#!/bin/bash

brightness=$(brightnessctl -m | cut -d',' -f4 | tr -d '%');
icon="";
percentage="";

if [ "$brightness" -ge 50 ]; then
    icon=""
fi

if [ "$brightness" -lt 99 ]; then
    percentage=" $brightness%"
fi

echo "$icon $percentage"