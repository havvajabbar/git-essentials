#!/bin/bash

FILE_PATH=/etc/modprobe.d/blacklist.conf

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [[ ! -e /etc/modprobe.d/blacklist.conf ]]; then
    touch $FILE_PATH
    echo "blacklist usb_storage" >> $FILE_PATH
    echo "blacklist uas" >> $FILE_PATH
elif ! grep -q "blacklist usb_storage" $FILE_PATH; then
echo "blacklist usb_storage" >> $FILE_PATH
echo "blacklist uas" >> $FILE_PATH
fi

if [[ ! -e /etc/rc.local ]]; then
    touch /etc/rc.local
    echo "modprobe -r uas" >> /etc/rc.local
fi

/usr/sbin/rmmod usb_storage


