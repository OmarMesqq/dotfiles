#!/bin/bash

# Generate a UUID and remove any hyphens to create a valid filename
uuid=$(uuidgen | tr -d -)

# Capture the screenshot using scrot with the generated UUID as the filename
grim ~/Pictures/"${uuid}.png"

