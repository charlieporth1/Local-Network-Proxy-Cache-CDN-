#!/bin/bash
SCRIPT_DIR=`dirname $0`
HEALTH_CHECK_BIN=$SCRIPT_DIR/proxy_test.sh

source $SCRIPT_DIR/apply.sh
HEALTH_CHECK_STATUS=`bash $HEALTH_CHECK_BIN | grep -o 200 | sed -n '1p'`
if [[ 200 != $HEALTH_CHECK_STATUS ]]; then
	RESTART_CDN
fi
