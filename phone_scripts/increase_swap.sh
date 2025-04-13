#!/system/bin/sh

if [ -f /data/swapfile ]; then
    chmod 600 /data/swapfile
    mkswap /data/swapfile
    swapon /data/swapfile
fi

sysctl vm.swappiness=200

