#!/bin/bash
set -euo pipefail

cd ~/AUR || exit -1

for dir in */; do
    echo "Updating $dir..."
    cd "$dir" || exit -1 
    sleep 2
    git pull
    cd ..
done

echo "AUR update complete!"
