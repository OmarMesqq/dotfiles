#!/bin/bash

qemu-system-x86_64 \
	-daemonize \
	-audiodev pipewire,id=snd0 \
	-device ich9-intel-hda \
	-device hda-output,audiodev=snd0 \
	-display sdl \
	-m 6G \
	-smp 2 \
       	-enable-kvm \
       	-drive file=/home/omar/j/vm/windows_10.img,format=raw,cache=none
