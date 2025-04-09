#!/bin/bash
unset _JAVA_AWT_WM_NONREPARENTING

qemu-system-x86_64 \
    -daemonize \
    -nodefaults \
    -machine type=q35,accel=kvm \
    -cpu host \
    -m 8G \
    -smp 4 \
    -display sdl \
    -audiodev pipewire,id=snd0 \
    -device ich9-intel-hda \
    -device hda-output,audiodev=snd0 \
    -device qemu-xhci \
    -device usb-tablet \
    -device virtio-vga \
    -drive id=hd0,file=/home/omar/vm/windows_hdd.img,format=qcow2,if=none \
    -device ide-hd,drive=hd0,bus=ide.0 \
    -boot c \
    -netdev user,id=net0 \
    -device e1000,netdev=net0
