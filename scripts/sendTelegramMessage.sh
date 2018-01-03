#!/bin/bash
# SendTelegramMessage: send Telegram messages through a simple bash script

APIKEY="424848481:AAE0E8-1QX8Wf8LBhoChYLbLWiJjNvh_OqA"
CHATID="157875449"

curl -X GET "https://api.telegram.org/bot$APIKEY/sendMessage?chat_id=$CHATID&text=$1"
