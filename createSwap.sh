#!/bin/bash
ROOT_STORAGE_STATS=`df -h | grep root`
FREE_SPACE=`printf "$ROOT_STORAGE_STATS" | awk '{print $4}'`
MEM_COUNT=`grep MemTotal /proc/meminfo | awk '{print $2 / 1024}'`
#If more than 12 GB of free space and less than 2GB of ram create swap if swapfile does not exist
if [[ `echo $FREE_SPACE | rev | cut -c 2- | rev` -ge 12 ]] && \
   [[ $MEM_COUNT -le 4096 ]] && \
   [[ ! -f /swapfile ]]
then
	sudo fallocate -l $(( $MEM_COUNT * 2 )) M /swapfile
	sudo chmod 600 /swapfile
	sudo mkswap /swapfile
	sudo swapon /swapfile
	sudo cp /etc/fstab /etc/fstab.bak
	echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
	sudo sysctl vm.swappiness=25
 	[[ -z `grep -o "vm.swappiness"  /etc/sysctl.conf` ]] && echo 'vm.swappiness=25' | sudo tee -a /etc/sysctl.conf
	sudo sysctl -p
elif [[ -f /swapfile ]]
	sudo swapon /swapfile
fi
