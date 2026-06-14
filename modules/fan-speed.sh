#!/bin/bash

ASUS_HWMON=$(grep -l "asus" /sys/class/hwmon/hwmon*/name | head -n 1 | xargs dirname)

if [[ -z "$ASUS_HWMON" ]]; then
    echo '{"text": "󰈐 N/A", "tooltip": "ASUS sensor offline"}'
    exit 0
fi

CPU_FAN=$(cat "$ASUS_HWMON"/fan1_input 2>/dev/null || echo "0")
GPU_FAN=$(cat "$ASUS_HWMON"/fan2_input 2>/dev/null || echo "0")

echo '{"text": " 󰈐  '$CPU_FAN' 󰈐  '$GPU_FAN' ", "tooltip": "CPU Fan: '$CPU_FAN' RPM\nGPU Fan: '$GPU_FAN' RPM", "class": "fans"}'