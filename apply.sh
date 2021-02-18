#!/bin/bash
function RESTART_CDN() {
	systemctl restart squid.service
	systemctl restart unbound.service
}
function ENABLE_CDN() {
	systemctl enable squid.service
	systemctl enable unbound.service
}
function STOP_CDN() {
	systemctl stop squid.service
	systemctl stop unbound.service
}
function START_CDN() {
	systemctl start squid.service
	systemctl start unbound.service
}

export -f RESTART_CDN
export -f ENABLE_CDN
export -f STOP_CDN
export -f START_CDN
