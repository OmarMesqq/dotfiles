#!/bin/bash
set -euo pipefail

echo "Make sure sway has XWayland support"
xhost +
sudo rpi-imager

