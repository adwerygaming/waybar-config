#!/bin/bash

action=$1  # get, up, down
step=5;

case "$action" in
    up)
        brightnessctl set +"${value:-$step}"%  
        ;;
    down)
        brightnessctl set "${value:-$step}"%-
        ;;
    set)
        brightnessctl set "${value}"%
        ;;
    flip)
        brightness=$(brightnessctl -m | cut -d',' -f4 | tr -d '%');
        
        if [ "$brightness" -ge 1 ]; then
            brightnessctl set 0;
        else    
            brightnessctl set 255;
        fi
        ;;
    *)
        exit 1
        ;;
esac