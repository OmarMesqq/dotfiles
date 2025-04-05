
#!/bin/bash

# Get battery percentage for keyboard
KB_PERCENT=$(upower -d | awk '/Keyboard K380/,/icon-name/ {if ($1 == "percentage:") print $2}')

# Get battery percentage for mouse
MOUSE_PERCENT=$(upower -d | awk '/LIFT/,/icon-name/ {if ($1 == "percentage:") print $2}')


HEADPHONE_PERCENT=$(upower -d | awk '/Philips/,/icon-name/ {if ($1 == "percentage:") print $2}')

# Output JSON for Waybar
echo "{ \"keyboard\": \"$KB_PERCENT\", \"mouse\": \"$MOUSE_PERCENT\", \"headphone\": \"$HEADPHONE_PERCENT\" }"
