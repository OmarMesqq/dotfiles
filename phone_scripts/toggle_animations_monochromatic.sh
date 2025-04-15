#!/bin/sh

# Run the entire script as root
if [ "$(whoami)" != "root" ]; then
    exec su -c "/system/bin/sh $0"
    exit
fi

# Get all animation scale values
ANIMATOR_SCALE=$(settings get global animator_duration_scale)
TRANSITION_SCALE=$(settings get global transition_animation_scale)
WINDOW_SCALE=$(settings get global window_animation_scale)

# Toggle animations if any of them are off
if [ "$ANIMATOR_SCALE" = "0.0" ] || [ "$TRANSITION_SCALE" = "0.0" ] || [ "$WINDOW_SCALE" = "0.0" ]; then
    settings put global animator_duration_scale 1.0
    settings put global transition_animation_scale 1.0
    settings put global window_animation_scale 1.0
else
    settings put global animator_duration_scale 0.0
    settings put global transition_animation_scale 0.0
    settings put global window_animation_scale 0.0
fi

# Toggle monochromatic mode (simulated via grayscale)
COLOR_MODE=$(settings get secure accessibility_display_daltonizer_enabled)

if [ "$COLOR_MODE" = "0" ]; then
    settings put secure accessibility_display_daltonizer_enabled 1
    settings put secure accessibility_display_daltonizer 0  # Grayscale
else
    settings put secure accessibility_display_daltonizer_enabled 0
fi

