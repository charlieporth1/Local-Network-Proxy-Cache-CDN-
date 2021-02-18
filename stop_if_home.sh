#!/bin/bash
# Stop if home
# This script is used in `/etc/rc.local` for a mobile multi purpose raspberry pi
# It detects what wifi SSID is the home network and if its currently connected and shuts down the cdn processes because they take cpu and memory 
SCRIPT_DIR=`dirname $0`
echo $SCRIPT_DIR

source $SCRIPT_DIR/apply.sh

HOME_SSID="TLHome"

GET_SSID_CMD=$(iwgetid -r)

if [[ "$GET_SSID_CMD" == "$HOME_SSID" ]]; then
	echo "At $GET_SSID_CMD which is home stopping cdn"
	STOP_CDN
fi
