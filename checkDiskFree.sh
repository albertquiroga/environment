#!/bin/bash
# CheckDiskFree: sends a Telegram alert if disk free is less than configured value

MAXDISK=100
THRESHOLD=5
DISKUSAGE=`df -Ph /files | tail -1 | awk '{print $5}' | tr -d %`
DISKFREE=$(($MAXDISK-$DISKUSAGE))

if [ "$DISKFREE" -lt "$THRESHOLD" ] ;
then
  /bin/sh /home/pyro/sendTelegramMessage.sh "Warning: disk usage is at $DISKUSAGE%"
fi

