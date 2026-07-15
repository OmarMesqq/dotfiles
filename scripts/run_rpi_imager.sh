#!/bin/bash
set -euo pipefail

echo "Make sure Sway has XWayland support"
xhost +
sudo rpi-imager
