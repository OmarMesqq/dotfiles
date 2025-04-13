#!/bin/sh

# Run the entire script as root
if [ "$(whoami)" != "root" ]; then
    exec su -c "/system/bin/sh $0"
    exit
fi

# Check current animation scale
ANIM_SCALE=$(settings get global animator_duration_scale)

# Toggle animations (0 = off, 1 = on)
if [ "$ANIM_SCALE" == "0.0" ]; then
    settings put global animator_duration_scale 1
    settings put global transition_animation_scale 1
    settings put global window_animation_scale 1
    echo "Animations ON"
else
    settings put global animator_duration_scale 0
    settings put global transition_animation_scale 0
    settings put global window_animation_scale 0
    echo "Animations OFF"
fi

# Toggle monochromatic mode (simulated via grayscale)
COLOR_MODE=$(settings get secure accessibility_display_daltonizer_enabled)

if [ "$COLOR_MODE" == "0" ]; then
    settings put secure accessibility_display_daltonizer_enabled 1
    settings put secure accessibility_display_daltonizer 0  # Grayscale
    echo "Monochromatic ON"
else
    settings put secure accessibility_display_daltonizer_enabled 0
    echo "Monochromatic OFF"
fi
