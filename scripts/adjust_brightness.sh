#!/bin/bash

# Get current brightness
current_brightness=$(cat /sys/class/backlight/intel_backlight/brightness)
echo "Current brightness: $current_brightness"

# Get maximum brightness
max_brightness=$(cat /sys/class/backlight/intel_backlight/max_brightness)
echo "Maximum brightness: $max_brightness"

# Ask for new brightness value
read -p "Enter new brightness value (between 0 and $max_brightness): " new_brightness

# Check if the new brightness is within the permissible range
if [[ $new_brightness -ge 0 && $new_brightness -le $max_brightness ]]; then
    echo $new_brightness | sudo tee /sys/class/backlight/intel_backlight/brightness
else
    echo "Invalid brightness value. It must be between 0 and $max_brightness."
fi