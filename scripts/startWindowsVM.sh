#!/bin/sh

qemu-system-x86_64 \
       	-daemonize \
       	-m 6G \
       	-smp 2 \
       	-enable-kvm \
       	-drive file=/home/omar/vm/windows10.qcow2
