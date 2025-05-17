#!/bin/bash
set -ex

adb push /home/omar/hdd/phone_backup/com.whatsapp/ /sdcard/Android/media/com.whatsapp/ 
adb push /home/omar/hdd/phone_backup/DCIM /sdcard/DCIM 
adb push /home/omar/hdd/phone_backup/Download /sdcard/Download 
adb push /home/omar/hdd/phone_backup/Music /sdcard/Music 
adb push /home/omar/hdd/phone_backup/Pictures /sdcard/Pictures 

