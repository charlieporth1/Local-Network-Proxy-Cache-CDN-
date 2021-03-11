#!/bin/bash
function check_root () {
  if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
  fi
}
check_root


apt -y install unbound squid bc

SCRIPT_DIR=`dirname $0`

CONFIG_DIR=$SCRIPT_DIR/config

INSTALL_CONFIG_DIR=/etc/
INSTALL_BIN_DIR=/usr/local/bin

DEFAULT_SQUID_CONF=$INSTALL_CONFIG_DIR/squid/conf.d/debian.conf
UNBOUND_CACHE_CONF=$INSTALL_CONFIG_DIR/unbound/unbound.conf.d/04-cache.conf

IPS=`ifconfig | grep "(e(n[n|s|x|p|o|e|b](.*))|th[0-9])|wlan[0-9])" -A 1 | grep -oE 'inet ([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})' | grep -oE '([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})'`

MEM_COUNT=`grep MemTotal /proc/meminfo | awk '{print $2 / 1024}'`
MEM_AMOUNT=`bc <<< "scale=3; $MEM_COUNT / 2.5"`




cp -rf $CONFIG_DIR/squid/* $INSTALL_CONFIG_DIR/squid/conf.d/
cp -rf $CONFIG_DIR/unbound/* $INSTALL_CONFIG_DIR/unbound/unbound.conf.d/

echo "dns_nameservers $IPS" | sudo tee -a $DEFAULT_SQUID_CONF
echo "cache_mem $MEM_AMOUNT MB" | sudo tee -a $DEFAULT_SQUID_CONF

bash $SCRIPT_DIR/createSwap.sh
bash $SCRIPT_DIR/kernelImprovements.sh
bash $SCRIPT_DIR/increaseCpu.sh
source $SCRIPT_DIR/apply.sh

echo "*  *   *   *   *    root    SHELL=/bin/bash; bash $SCRIPT_DIR/pm.proxy_health_check.sh >> /var/log/health-check.log" > /etc/cron.d/health_check

ENABLE_CDN
RESTART_CDN

printf """
	Point your devices and routers to the http(s), ftp, socks, and rstp proxy of $IPS as well as pointing your DNS servers of your router and/or devices to $IPS.
	Have a great speedy day. Please remeber to reboot to apply settings in kernel improvements.
"""
