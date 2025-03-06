#!/bin/bash
set -ex

adb pull /sdcard/Android/media/com.whatsapp/ /home/omar/phone_backup/
adb pull /sdcard/AnkiDroid /home/omar/phone_backup/
adb pull /sdcard/AntennaPod /home/omar/phone_backup/
adb pull /sdcard/AppManager /home/omar/phone_backup/
adb pull /sdcard/DCIM /home/omar/phone_backup/
adb pull /sdcard/Documents /home/omar/phone_backup/
adb pull /sdcard/Download /home/omar/phone_backup/
adb pull /sdcard/Movies /home/omar/phone_backup/
adb pull /sdcard/Music /home/omar/phone_backup/
adb pull /sdcard/Pictures /home/omar/phone_backup/

