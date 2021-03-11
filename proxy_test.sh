#!/bin/bash
FULL_STATUS=`curl -s -i --tcp-fastopen --proxy http://192.168.1.4:3128 https://www.google.com`
HTTP_STATUS=`echo "$FULL_STATUS\n" | head -1`
echo $FULL_STATUS
echo $HTTP_STATUS
