#!/bin/bash
# Stop if home
# This script is used in `/etc/rc.local` for a mobile multi purpose raspberry pi
# It detects what wifi SSID is the home network and if its currently connected and shuts down the cdn processes because they take cpu and memory 
SCRIPT_DIR=`dirname $0`
PROG=/home/pi/Programs
source $SCRIPT_DIR/apply.sh

HOME_SSID="TLHome"

GET_SSID_CMD=$(iwgetid -r)

if [[ "$GET_SSID_CMD" == "$HOME_SSID" ]]; then
	echo "At $GET_SSID_CMD which is home stopping cdn"
	STOP_CDN
	sudo systemctl start tvmosaic.service
	#other programs here
#	bash $PROG/ledmanager.sh
else
	sudo sysctl -w net.ipv4.ip_forward=1
	sudo systemctl stop tvmosaic.service
	killall tvmosaic_server
#	sudo ip link set wlan0 down && sudo ip link set wlan0 up
#	sudo ip link set wlan0 down
	sudo ifconfig enxb827ebd8ea6c down
	sudo ifconfig enxb827ebd8ea6c 192.168.1.4 netmask 255.255.255.0 up
#	sudo ifconfig wlan0 192.168.1.5 netmask 255.255.255.0 up
#	sudo ip link set wlan0 down

	START_CDN
fi
