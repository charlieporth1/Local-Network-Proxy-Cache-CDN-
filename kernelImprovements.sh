#!/bin/bash
KERNEL_CONF=/etc/sysctl.conf
MOD_CONF=/etc/modules-load.d/ctp-cdn-cache.conf
echo 'tcp_bbr' | sudo tee -a $MOD_CONF
echo 'sctp' | sudo tee -a $MOD_CONF
echo 'ip_tunnel' | sudo tee -a $MOD_CONF
echo 'tcp_htcp' | sudo tee -a $MOD_CONF
echo 'ipcomp' | sudo tee -a $MOD_CONF
echo 'udp_tunnel' | sudo tee -a $MOD_CONF
echo 'sha256_generic' | sudo tee -a $MOD_CONF
echo 'ecdh_generic' | sudo tee -a $MOD_CONF
echo 'gcm' | sudo tee -a $MOD_CONF
echo 'xor' | sudo tee -a $MOD_CONF
echo 'aes-neon-bs' | sudo tee -a $MOD_CONF
echo 'aes-neon-blk' | sudo tee -a $MOD_CONF
echo 'aes-arm64' | sudo tee -a $MOD_CONF
echo 'xor-neon' | sudo tee -a $MOD_CONF
echo 'poly1305-neon' | sudo tee -a $MOD_CONF
echo 'chacha-neon' | sudo tee -a $MOD_CONF

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
sudo sysctl -p
