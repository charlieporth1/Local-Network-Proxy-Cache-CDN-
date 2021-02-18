#!/bin/bash
KERNEL_CONF=/etc/sysctl.conf
echo 'net.ipv4.tcp_timestamps=0' | sudo tee -a $KERNEL_CONF
echo 'net.ipv4.tcp_sack=1' | sudo tee -a $KERNEL_CONF
echo 'net.core.netdev_max_backlog=250000' | sudo tee -a $KERNEL_CONF
echo 'net.core.rmem_max=4194304' | sudo tee -a $KERNEL_CONF
echo 'net.core.wmem_max=4194304' | sudo tee -a $KERNEL_CONF
echo 'net.core.rmem_default=4194304' | sudo tee -a $KERNEL_CONF
echo 'net.core.wmem_default=4194304' | sudo tee -a $KERNEL_CONF
echo 'net.core.optmem_max=4194304' | sudo tee -a $KERNEL_CONF
echo 'net.ipv4.tcp_rmem="4096 87380 4194304"' | sudo tee -a $KERNEL_CONF
echo 'net.ipv4.tcp_wmem="4096 65536 4194304"' | sudo tee -a $KERNEL_CONF
echo 'net.ipv4.tcp_low_latency=1' | sudo tee -a $KERNEL_CONF
echo 'net.ipv4.tcp_adv_win_scale=1' | sudo tee -a $KERNEL_CONF
echo 'net.core.default_qdisc=fq"' | sudo tee -a $KERNEL_CONF
echo 'net.ipv4.tcp_congestion_control=bbr' | sudo tee -a $KERNEL_CONF
#echo '' | sudo tee -a $KERNEL_CONF
sudo sysctl -p
