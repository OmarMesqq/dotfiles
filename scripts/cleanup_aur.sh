#!/bin/bash

cd ~/AUR || exit

for dir in */; do
    echo "Cleaning $dir..."
    cd "$dir" || continue
    
    # Delete old .pkg.tar.zst files (keep latest 2 versions)
    ls -t *.pkg.tar.zst 2>/dev/null | tail -n +3 | xargs rm -f
    
    # Delete debug packages (optional)
    rm -f *-debug-*.pkg.tar.zst 2>/dev/null
    
    # Delete downloaded source archives (.tar.gz, .tar.xz, etc.)
    rm -f *.tar.{gz,xz,bz2,zst} 2>/dev/null
    
    # Delete signature files (.sig, .asc)
    rm -f *.sig *.asc 2>/dev/null
    
    # Clean src/ and pkg/ directories if they exist
    rm -rf src/ pkg/ 2>/dev/null
    
    cd ..
done

echo "AUR cleanup complete!"
