#!/bin/sh

echo  "Label de /dev/sdc é:"
lsblk -o NAME,LABEL /dev/sdc
