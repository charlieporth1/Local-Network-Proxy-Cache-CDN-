#!/bin/bash
CURRENT_DIR=$PWD
CONFIG_DIR=$CURRENT_DIR/config

INSTALL_CONFIG_DIR=/etc/
INSTALL_BIN_DIR=/usr/local/bin

IPS=`ifconfig | grep "en\|wlan0" -A 1 | grep -oE 'inet ([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})' | grep -oE '([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})'`
apt -y install unbound squid

echo "dns_nameservers $IPS" | sudo tee -a $CONFIG_DIR/squid/debian.conf

cp -rf $CONFIG_DIR/squid/* $INSTALL_CONFIG_DIR/squid/conf.d/
cp -rf $CONFIG_DIR/unbound/* $INSTALL_CONFIG_DIR/unbound/unbound.conf.d/


bash $CURRENT_DIR/apply.sh
echo """
Point your devices to the http(s), ftp, socks, rstp proxy of $IPS and your DNS servers of your router and devices to $IPS
Have a great speedy day
"""
