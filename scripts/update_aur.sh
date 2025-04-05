#!/bin/bash

cd ~/AUR || exit

for dir in */; do
    echo "Updating $dir..."
    cd "$dir" || continue
    git pull
    cd ..
done

echo "AUR update complete!"
