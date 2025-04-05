#!/bin/bash

qemu-system-x86_64 \
    -daemonize \
    -audiodev pipewire,id=snd0 \
    -device ich9-intel-hda \
    -device hda-output,audiodev=snd0 \
    -display sdl \
    -m 8G \
    -smp 2 \
    -enable-kvm \
    -drive file=/home/omar/vm/windows_hdd.img,format=qcow2
