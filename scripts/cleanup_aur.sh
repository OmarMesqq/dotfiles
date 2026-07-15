#!/bin/bash
set -euo pipefail

cd ~/AUR || exit -1

for dir in */; do
    echo "Cleaning $dir..."
    cd "$dir" || cd "$HOME"
    
    # Delete downloaded source/binary archives
    rm -f *.pkg.tar.zst 2>/dev/null
    rm -f *.tar.{gz,xz,bz2,zst} 2>/dev/null
    rm -f *.deb 2>/dev/null

    # Delete signature filess
    rm -f *.sig *.asc 2>/dev/null
    
    # Cleanup build dirs
    rm -rf src/ pkg/ source/ 2>/dev/null
    
    cd ..
done

echo "AUR cleanup complete!"
