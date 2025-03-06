#!/bin/bash
set -ex

RAM_PATH="/tmp"
WALLPAPER_IN_RAM="$RAM_PATH/nasa_wallpaper.jpg"
METADATA_IN_RAM="$RAM_PATH/nasa_metadata.json"

DISK_PATH="$HOME/.nasa_apod"
WALLPAPER_IN_DISK="$DISK_PATH/nasa_wallpaper.jpg"
METADATA_IN_DISK="$DISK_PATH/nasa_metadata.json"

today=$(date +%Y-%m-%d)

existsInRam=false
matchesInRam=false
existsInDisk=false
matchesInDisk=false


if [[ -f "$METADATA_IN_RAM" ]]; then
    existsInRam=true
    cached_date=$(jq -r '.date' "$METADATA_IN_RAM")

    if [[ "$cached_date" == "$today" && -f "$WALLPAPER_IN_RAM" ]]; then
        matchesInRam=true
    fi
fi

if [[ -f "$METADATA_IN_DISK" ]]; then
    existsInDisk=true
    cached_date=$(jq -r '.date' "$METADATA_IN_DISK")

    if [[ "$cached_date" == "$today" && -f "$WALLPAPER_IN_DISK" ]]; then
        matchesInDisk=true
    fi
fi


# Case 0 (happy path): both are set and up to date
if [[ "$existsInRam" == true && "$matchesInRam" == true && "$existsInDisk" == true && "$matchesInDisk" == true ]]; then
    swaybg -i "$WALLPAPER_IN_RAM" -m fill &
    exit 0
fi

# Case 1: we need to update the disk by copying the correct data from RAM
if [[ ("$existsInRam" == true && "$matchesInRam" == true && "$existsInDisk" == true && "$matchesInDisk" == false) || 
      ("$existsInRam" == true && "$matchesInRam" == true && "$existsInDisk" == false) ]]; then
    cp "$METADATA_IN_RAM" "$METADATA_IN_DISK"
    cp "$WALLPAPER_IN_RAM" "$WALLPAPER_IN_DISK"
    
    swaybg -i "$WALLPAPER_IN_RAM" -m fill &
    exit 0
fi

# Case 2: we need to update the RAM by copying the correct data from disk
if [[ ("$existsInRam" == true && "$matchesInRam" == false && "$existsInDisk" == true && "$matchesInDisk" == true) || 
      ("$existsInRam" == false && "$existsInDisk" == true && "$matchesInDisk" == true) ]]; then
    cp "$WALLPAPER_IN_DISK" "$WALLPAPER_IN_RAM"
    cp "$METADATA_IN_DISK" "$METADATA_IN_RAM"
    swaybg -i "$WALLPAPER_IN_RAM" -m fill &
    exit 0
fi


# Case 3 (worst case): need to hit the API as to update both and set the new wallpaper
DOT_ENV=$(cat .env)

#TODO: be more defensive
# Set the field delimiter to '=' for the awk command. This is common in .env files
# Only match lines starting with the NASA api key and print the second field (after the '=', i.e. the key itself)
API_KEY=$(echo "$DOT_ENV" | awk -F= '/NASA_API_KEY=/ {print $2}')
# Match a double quote ("), any character(s) other than double quote n times (*) and the final double quote
# Then, strip the double quotes using echo
#API_KEY=$(echo "$NASA_API_KEY_LINE" | grep -E '"[^"]*"' | xargs echo)

NASA_API_URL="https://api.nasa.gov/planetary/apod"
NASA_API_ENDPOINT="${NASA_API_URL}?api_key="${API_KEY}""


# Fetch the JSONified metadata
metadata=$(curl -s "$NASA_API_ENDPOINT")

# Save metadata for caching
echo "$metadata" > "$METADATA_IN_RAM"
cp "$METADATA_IN_RAM" "$METADATA_IN_DISK"

# Extract the image URL from the JSON prioritizing the HD URL
image_url=$(echo "$metadata" | jq -r '.hdurl // .url')

# Download the wallpaper, cache it in disk and set it
curl -s -o "$WALLPAPER_IN_RAM" "$image_url"
cp "$WALLPAPER_IN_RAM" "$WALLPAPER_IN_DISK"
swaybg -i "$WALLPAPER_IN_RAM" -m fill &

